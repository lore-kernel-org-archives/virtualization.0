From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 07/26] x86/paravirt: Persist .parainstructions.runtime
Date: Tue,  7 Apr 2020 22:03:04 -0700
Message-ID: <20200408050323.4237-8-ankur.a.arora@oracle.com>
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

Persist .parainstructions.runtime in memory. We will use it to
patch paravirt-ops at runtime.

The extra memory footprint depends on chosen config options but the
inlined queued_spin_unlock() presents an edge case:

 $ objdump -h vmlinux|grep .parainstructions
 Idx Name              		Size      VMA
 	LMA                File-off  Algn
  27 .parainstructions 		0001013c  ffffffff82895000
  	0000000002895000   01c95000  2**3
  28 .parainstructions.runtime  0000cd2c  ffffffff828a5140
  	00000000028a5140   01ca5140  2**3

(The added footprint is the size of the .parainstructions.runtime
section.)

  $ size vmlinux
  text       data       bss        dec      hex       filename
  13726196   12302814   14094336   40123346 2643bd2   vmlinux

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/alternative.h |  1 +
 arch/x86/kernel/alternative.c      | 16 +++++++++++++++-
 arch/x86/kernel/module.c           | 28 +++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index db91a7731d87..d19546c14ff6 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -76,6 +76,7 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 struct module;
 
 void alternatives_module_add(struct module *mod, char *name,
+			     void *para, void *para_end,
 			     void *locks, void *locks_end,
 			     void *text, void *text_end);
 void alternatives_module_del(struct module *mod);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 09e4ee0e09a2..8189ac21624c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -482,6 +482,12 @@ struct alt_module {
 	struct module	*mod;
 	char		*name;
 
+#ifdef CONFIG_PARAVIRT_RUNTIME
+	/* ptrs to paravirt sites */
+	struct paravirt_patch_site *para;
+	struct paravirt_patch_site *para_end;
+#endif
+
 	/* ptrs to lock prefixes */
 	const s32	*locks;
 	const s32	*locks_end;
@@ -496,6 +502,7 @@ struct alt_module {
 static LIST_HEAD(alt_modules);
 
 void __init_or_module alternatives_module_add(struct module *mod, char *name,
+					      void *para, void *para_end,
 					      void *locks, void *locks_end,
 					      void *text,  void *text_end)
 {
@@ -506,7 +513,7 @@ void __init_or_module alternatives_module_add(struct module *mod, char *name,
 	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1))
 		uniproc_patched = true;
 #endif
-	if (!uniproc_patched)
+	if (!IS_ENABLED(CONFIG_PARAVIRT_RUNTIME) && !uniproc_patched)
 		return;
 
 	mutex_lock(&text_mutex);
@@ -516,6 +523,11 @@ void __init_or_module alternatives_module_add(struct module *mod, char *name,
 	alt->mod	= mod;
 	alt->name	= name;
 
+#ifdef CONFIG_PARAVIRT_RUNTIME
+	alt->para	= para;
+	alt->para_end	= para_end;
+#endif
+
 	if (num_possible_cpus() != 1 || uniproc_patched) {
 		/* Remember only if we'll need to undo it. */
 		alt->locks	= locks;
@@ -733,6 +745,8 @@ void __init alternative_instructions(void)
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 	alternatives_module_add(NULL, "core kernel",
+				__parainstructions_runtime,
+				__parainstructions_runtime_end,
 				__smp_locks, __smp_locks_end,
 				_text, _etext);
 
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index fc3d35198b09..7b2632184c11 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -248,12 +248,30 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
-	if (locks && text) {
-		void *lseg = (void *)locks->sh_addr;
-		void *tseg = (void *)text->sh_addr;
+	if (para_run || (locks && text)) {
+		void *pseg, *pseg_end;
+		void *lseg, *lseg_end;
+		void *tseg, *tseg_end;
+
+		pseg = pseg_end = NULL;
+		lseg = lseg_end = NULL;
+		tseg = tseg_end = NULL;
+		if (para_run) {
+			pseg = (void *)para_run->sh_addr;
+			pseg_end = pseg + para_run->sh_size;
+		}
+
+		if (locks && text) {
+			tseg = (void *)text->sh_addr;
+			tseg_end = tseg + text->sh_size;
+
+			lseg = (void *)locks->sh_addr;
+			lseg_end = lseg + locks->sh_size;
+		}
 		alternatives_module_add(me, me->name,
-					lseg, lseg + locks->sh_size,
-					tseg, tseg + text->sh_size);
+					pseg, pseg_end,
+					lseg, lseg_end,
+					tseg, tseg_end);
 	}
 
 	if (para) {
-- 
2.20.1
