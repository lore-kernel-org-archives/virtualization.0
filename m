From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 10/26] x86/paravirt: Add primitives to stage pv-ops
Date: Tue,  7 Apr 2020 22:03:07 -0700
Message-ID: <20200408050323.4237-11-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, vkuznets@redhat.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Add paravirt_stage_alt() which conditionally selects between a paravirt
or native pv-op and then stages it for later patching.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/paravirt_types.h |  6 +++
 arch/x86/include/asm/text-patching.h  |  3 ++
 arch/x86/kernel/alternative.c         | 58 +++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 3b9f6c105397..0c4ca7ad719c 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -350,6 +350,12 @@ extern struct paravirt_patch_template native_pv_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+#define paravirt_stage_alt(do_stage, op, opfn)				\
+	(text_poke_pv_stage(PARAVIRT_PATCH(op),				\
+			    (do_stage) ? (opfn) : (native_pv_ops.op)))
+
+#define paravirt_stage_zero() text_poke_pv_stage_zero()
+
 /*
  * Neat trick to map patch type back to the call within the
  * corresponding structure.
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e2ef241c261e..706e61e6967d 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -55,6 +55,9 @@ extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_finish(void);
 
+bool text_poke_pv_stage(u8 type, void *opfn);
+void text_poke_pv_stage_zero(void);
+
 #define INT3_INSN_SIZE		1
 #define INT3_INSN_OPCODE	0xCC
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8189ac21624c..0c335af9ee28 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1307,3 +1307,61 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
+
+#ifdef CONFIG_PARAVIRT_RUNTIME
+struct paravirt_stage_entry {
+	void *dest;	/* pv_op destination */
+	u8 type;	/* pv_op type */
+};
+
+/*
+ * We don't anticipate many pv-ops being written at runtime.
+ */
+#define PARAVIRT_STAGE_MAX 8
+struct paravirt_stage {
+	struct paravirt_stage_entry ops[PARAVIRT_STAGE_MAX];
+	u32 count;
+};
+
+/* Protected by text_mutex */
+static struct paravirt_stage pv_stage;
+
+/**
+ * text_poke_pv_stage - Stage paravirt-op for poking.
+ * @addr: address in struct paravirt_patch_template
+ * @type: pv-op type
+ * @opfn: destination of the pv-op
+ *
+ * Return: staging status.
+ */
+bool text_poke_pv_stage(u8 type, void *opfn)
+{
+	if (system_state == SYSTEM_BOOTING) { /* Passthrough */
+		PARAVIRT_PATCH_OP(pv_ops, type) = (long)opfn;
+		goto out;
+	}
+
+	lockdep_assert_held(&text_mutex);
+
+	if (PARAVIRT_PATCH_OP(pv_ops, type) == (long)opfn)
+		goto out;
+
+	if (pv_stage.count >= PARAVIRT_STAGE_MAX)
+		goto out;
+
+	pv_stage.ops[pv_stage.count].type = type;
+	pv_stage.ops[pv_stage.count].dest = opfn;
+
+	pv_stage.count++;
+
+	return true;
+out:
+	return false;
+}
+
+void text_poke_pv_stage_zero(void)
+{
+	lockdep_assert_held(&text_mutex);
+	pv_stage.count = 0;
+}
+#endif /* CONFIG_PARAVIRT_RUNTIME */
-- 
2.20.1
