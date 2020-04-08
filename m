From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 16/26] x86/alternatives: Add paravirt patching at runtime
Date: Tue,  7 Apr 2020 22:03:13 -0700
Message-ID: <20200408050323.4237-17-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Add paravirt_patch_runtime() which uses text_poke_late() to patch
paravirt sites.

Also add paravirt_worker() which does the actual insn generation
generate_paravirt() (which uses runtime_patch() to generate the
appropriate native or paravirt insn sequences) and then calls
text_poke_site() to do the actual poking.

 CPU0                                CPUx
 ----                                ----

 patch_worker()                      patch_worker()

   /* Traversal, insn-gen */           text_poke_sync_finish()
   tps.patch_worker()
     /* = paravirt_worker() */         /*
                                        * wait until:
     /* for each patch-site */          *  tps->state == PATCH_DONE
     generate_paravirt()                */
       runtime_patch()
     text_poke_site()
       poke_sync()

           ...                                 ...

   smp_store_release(&tps->state, PATCH_DONE)

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/text-patching.h |  2 +
 arch/x86/kernel/alternative.c        | 98 +++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index c4b2814f2f9d..e86709a8287e 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -21,6 +21,8 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #ifndef CONFIG_PARAVIRT_RUNTIME
 #define __parainstructions_runtime	NULL
 #define __parainstructions_runtime_end	NULL
+#else
+int paravirt_runtime_patch(void);
 #endif
 
 /*
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 452d4081eded..1c5acdc4f349 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1463,7 +1463,9 @@ static void poke_sync(struct text_poke_state *tps, int state, int offset,
 /**
  * text_poke_site() - called on the primary to patch a single call site.
  *
- * Returns after switching tps->state to PATCH_SYNC_DONE.
+ * Called in thread context with tps->state == PATCH_SYNC_DONE where it
+ * takes tps->state through different PATCH_SYNC_* states, returning
+ * after having switched the tps->state back to PATCH_SYNC_DONE.
  */
 static void __maybe_unused text_poke_site(struct text_poke_state *tps,
 					  struct text_poke_loc *tp)
@@ -1598,6 +1600,16 @@ static int __maybe_unused text_poke_late(patch_worker_t worker, void *stage)
 	return ret;
 }
 
+/*
+ * Check if this address is still in scope of this module's .text section.
+ */
+static bool __maybe_unused stale_address(struct alt_module *am, u8 *p)
+{
+	if (p < am->text || p >= am->text_end)
+		return true;
+	return false;
+}
+
 #ifdef CONFIG_PARAVIRT_RUNTIME
 struct paravirt_stage_entry {
 	void *dest;	/* pv_op destination */
@@ -1654,4 +1666,88 @@ void text_poke_pv_stage_zero(void)
 	lockdep_assert_held(&text_mutex);
 	pv_stage.count = 0;
 }
+
+/**
+ * generate_paravirt - fill up the insn sequence for a pv-op.
+ *
+ * @tp - address of struct text_poke_loc
+ * @op - the pv-op entry for this location
+ * @site - patch site (kernel or module text)
+ */
+static void generate_paravirt(struct text_poke_loc *tp,
+			      struct paravirt_stage_entry *op,
+			      struct paravirt_patch_site *site)
+{
+	unsigned int used;
+
+	BUG_ON(site->len > POKE_MAX_OPCODE_SIZE);
+
+	text_poke_loc_init(tp, site->instr, site->instr, site->len, NULL, true);
+
+	/*
+	 * Paravirt patches can patch calls (ex. mmu.tlb_flush),
+	 * callee_saves(ex. queued_spin_unlock).
+	 *
+	 * runtime_patch() calls native_patch(), or paravirt_patch()
+	 * based on the destination.
+	 */
+	used = runtime_patch(site->type, (void *)tp->text, op->dest,
+			     (unsigned long)site->instr, site->len);
+
+	/* No good way to recover. */
+	BUG_ON(used < 0);
+
+	/* Pad the rest with nops */
+	add_nops((void *)tp->text + used, site->len - used);
+}
+
+/**
+ * paravirt_worker - generate the paravirt patching
+ * insns and calls text_poke_site() to do the actual patching.
+ */
+static void paravirt_worker(struct text_poke_state *tps)
+{
+	struct paravirt_patch_site *site;
+	struct paravirt_stage *stage = tps->stage;
+	struct paravirt_stage_entry *op = &stage->ops[0];
+	struct alt_module *am;
+	struct text_poke_loc tp;
+	int i;
+
+	list_for_each_entry(am, tps->head, next) {
+		for (site = am->para; site < am->para_end; site++) {
+			if (stale_address(am, site->instr))
+				continue;
+
+			for (i = 0;  i < stage->count; i++) {
+				if (op[i].type != site->type)
+					continue;
+
+				generate_paravirt(&tp, &op[i], site);
+
+				text_poke_site(tps, &tp);
+			}
+		}
+	}
+}
+
+/**
+ * paravirt_runtime_patch() -- patch pv-ops, including paired ops.
+ *
+ * Called holding the text_mutex.
+ *
+ * Modify possibly multiple mutually-dependent pv-op callsites
+ * (ex. pv_lock_ops) using stop_machine().
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int paravirt_runtime_patch(void)
+{
+	lockdep_assert_held(&text_mutex);
+
+	if (!pv_stage.count)
+		return -EINVAL;
+
+	return text_poke_late(paravirt_worker, &pv_stage);
+}
 #endif /* CONFIG_PARAVIRT_RUNTIME */
-- 
2.20.1
