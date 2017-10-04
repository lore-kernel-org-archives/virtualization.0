From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 11/13] x86/paravirt: Add paravirt alternatives infrastructure
Date: Wed,  4 Oct 2017 10:58:32 -0500
Message-ID: <39743c79546ede3073586403d0836a4f93519b0a.1507128293.git.jpoimboe__36991.8920485818$1509079682$gmane$org@redhat.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

With CONFIG_PARAVIRT, the kernel .text is littered with a bunch of calls
to pv_irq_ops function pointers, like:

  callq  *0xffffffff81e3a400 (pv_irq_ops.save_fl)

In non-Xen paravirt environments -- including native, KVM, Hyper-V, and
VMware -- the above code gets patched by native_patch() to look like
this instead:

   pushfq
   pop    %rax
   nopl   0x0(%rax,%rax,1)

So in most scenarios, there's a mismatch between what vmlinux shows and
the actual runtime code.  This mismatch hurts debuggability and makes
the assembly code harder to understand.

It also causes the ORC unwinder to produce KASAN warnings like:

  BUG: KASAN: stack-out-of-bounds in deref_stack_reg+0x123/0x140

This warning is due to the fact that objtool doesn't know about
parainstructions, so it doesn't know about the "pushfq; pop %rax"
sequence above.

Prepare to fix both of these issues (debuggability and ORC KASAN
warnings) by adding a paravirt alternatives infrastructure to put the
native instructions in .text by default.  Then, when booting on a
hypervisor, replace the native instructions with pv ops calls.

The pv ops calls need to be available much earlier than when
alternatives are normally applied.  So put these alternatives in a
dedicated ".pv_alternatives" section.

So now these instructions may be patched twice:

- in apply_pv_alternatives(), to allow the kernel to boot in the
  virtualized environment;

- and again in apply_paravirt(), to enable performance improvements
  (e.g., replacing an indirect call with a direct call).

That's a bit more complex, but overall this approach should cause less
confusion than before because the vmlinux code is now much more likely
to represent the actual runtime state of the code in the most common
paravirt cases (everything except Xen and vSMP).

It could be simplified by redesigning the paravirt patching code such
that it uses alternatives for all of its patching.  Instead of using pv
ops to specify which functions they need, they would instead set CPU
feature bits, which would then be used by the alternatives to decide
what to replace the native code with.  Then each site would only be
patched once.

But that's going to be a bit more work.  At least this patch creates a
good foundation for eventually getting rid of .parainstructions and pv
ops completely.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/alternative-asm.h |  9 +++-
 arch/x86/include/asm/alternative.h     | 12 +++--
 arch/x86/include/asm/cpufeatures.h     |  1 +
 arch/x86/include/asm/paravirt-asm.h    | 10 ++++
 arch/x86/include/asm/paravirt_types.h  | 84 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/alternative.c          | 13 ++++++
 arch/x86/kernel/cpu/hypervisor.c       |  2 +
 arch/x86/kernel/module.c               | 11 ++++-
 arch/x86/kernel/vmlinux.lds.S          |  6 +++
 arch/x86/xen/enlighten_pv.c            |  1 +
 10 files changed, 141 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 60073947350d..0ced2e3d0a30 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -39,14 +39,14 @@
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+#define __ALTERNATIVE(section, oldinstr, newinstr, feature)		\
 140:;									\
 	oldinstr;							\
 141:;									\
 	.skip -(((144f-143f)-(141b-140b)) > 0) *			\
 		((144f-143f)-(141b-140b)),0x90;				\
 142:;									\
-	.pushsection .altinstructions, "a";				\
+	.pushsection section, "a";					\
 	altinstruction_entry 140b,143f,feature,142b-140b,144f-143f,142b-141b;\
 	.popsection;							\
 	.pushsection .altinstr_replacement, "ax";			\
@@ -55,6 +55,11 @@
 144:;									\
 	.popsection
 
+#define ARGS(args...) args
+
+#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+	__ALTERNATIVE(.altinstructions, ARGS(oldinstr), ARGS(newinstr), feature)
+
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index c096624137ae..8482f90d5078 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -61,6 +61,7 @@ extern int alternatives_patched;
 
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
+extern void apply_pv_alternatives(void);
 
 struct module;
 
@@ -132,14 +133,17 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n\t"
 
 /* alternative assembly primitive: */
-#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+#define __ALTERNATIVE(section, oldinstr, newinstr, feature)		\
 	OLDINSTR(oldinstr, 1)						\
-	".pushsection .altinstructions,\"a\"\n"				\
+	".pushsection " section ",\"a\"\n"				\
 	ALTINSTR_ENTRY(feature, 1)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
-	".popsection"
+	".popsection\n"
+
+#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+	__ALTERNATIVE(".altinstructions", oldinstr, newinstr, feature)
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
 	OLDINSTR_2(oldinstr, 1, 2)					\
@@ -150,7 +154,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
-	".popsection"
+	".popsection\n"
 
 /*
  * Alternative instructions for different CPU types or capabilities.
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2519c6c801c9..1be45a2fc00d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -214,6 +214,7 @@
 
 #define X86_FEATURE_VMMCALL     ( 8*32+15) /* Prefer vmmcall to vmcall */
 #define X86_FEATURE_XENPV       ( 8*32+16) /* "" Xen paravirtual guest */
+#define X86_FEATURE_PV_OPS      ( 8*32+17) /* Use pv ops alternatives */
 
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ebx), word 9 */
diff --git a/arch/x86/include/asm/paravirt-asm.h b/arch/x86/include/asm/paravirt-asm.h
index 8bdd50ee4bf3..a8139ea27cc1 100644
--- a/arch/x86/include/asm/paravirt-asm.h
+++ b/arch/x86/include/asm/paravirt-asm.h
@@ -21,6 +21,16 @@
 	 .short clobbers;						\
 	.popsection
 
+#define PV_ALT_SITE(oldinstr, newinstr, ops, off, clobbers)		\
+	__ALTERNATIVE(.pv_altinstructions, oldinstr, newinstr,		\
+		      X86_FEATURE_PV_OPS);				\
+	.pushsection .parainstructions, "a";				\
+	_ASM_ALIGN;							\
+	_ASM_PTR 140b;							\
+	.byte PV_TYPE(ops, off);					\
+	.byte 142b-140b;						\
+	.short clobbers;						\
+	.popsection
 
 #define COND_PUSH(set, mask, reg)			\
 	.if ((~(set)) & mask); push %reg; .endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 5656aea79412..b3a73d6d8908 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -375,6 +375,33 @@ int paravirt_disable_iospace(void);
 	"  .short " clobber "\n"					\
 	".popsection\n"
 
+/*
+ * Generate some native code, which, if running on a hypervisor, is replaced
+ * *twice*:
+ *
+ * - The first patch is done in early boot by apply_pv_alternatives(), to
+ *   enable the patch to boot in the virtualized environment.  It replaces the
+ *   native code with a call to the pv ops struct function pointer.
+ *
+ * - The second patch is done later by apply_paravirt(), for performance
+ *   reasons.  In most cases it converts the indirect call to a direct call in
+ *   order to improve CPU branch prediction.
+ *
+ * This is done for debugging improvement purposes, so that instructions listed
+ * in the kernel disassembly will match up with the most common runtime case
+ * (native instructions).
+ */
+#define _PV_ALT_SITE(oldinstr, newinstr, type, clobber)			\
+	__ALTERNATIVE(".pv_altinstructions", oldinstr, newinstr,	\
+		      X86_FEATURE_PV_OPS)				\
+	".pushsection .parainstructions,\"a\"\n"			\
+	_ASM_ALIGN "\n"							\
+	_ASM_PTR " 661b\n"						\
+	".byte " type "\n"						\
+	".byte " alt_total_slen "\n"					\
+	".short " clobber "\n"						\
+	".popsection\n"							\
+
 #define PARAVIRT_PATCH(x)						\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
@@ -559,6 +586,33 @@ int paravirt_disable_iospace(void);
 		      PVOP_CALLEE_OUTPUTS, ,				\
 		      pre, post, ##__VA_ARGS__)
 
+#define ____PVOP_ALT_CALL(rettype, native, op, clbr, call_clbr,	\
+			     extra_clbr, ...)				\
+({									\
+	rettype __ret;							\
+	PVOP_CALL_ARGS;							\
+	PVOP_TEST_NULL(op);						\
+	asm volatile(PV_ALT_SITE(native, PV_CALL_STR)			\
+		     : call_clbr, ASM_CALL_CONSTRAINT			\
+		     : PV_INPUT_CONSTRAINTS(op, clbr),			\
+		       ##__VA_ARGS__					\
+		     : "memory", "cc" extra_clbr);			\
+	if (IS_ENABLED(CONFIG_X86_32) &&				\
+	    sizeof(rettype) > sizeof(unsigned long))			\
+		__ret = (rettype)((((u64)__edx) << 32) | __eax);	\
+	else								\
+		__ret = (rettype)(__eax & PVOP_RETMASK(rettype));	\
+	__ret;								\
+})
+
+#define __PVOP_ALT_CALL(rettype, native, op, ...)			\
+	____PVOP_ALT_CALL(rettype, native, op, CLBR_ANY,		\
+			     PVOP_CALL_OUTPUTS, EXTRA_CLOBBERS,		\
+			     ##__VA_ARGS__)
+
+#define __PVOP_ALT_CALLEESAVE(rettype, native, op, ...)			\
+	____PVOP_ALT_CALL(rettype, native, op.func, CLBR_RET_REG,	\
+			     PVOP_CALLEE_OUTPUTS, , ##__VA_ARGS__)
 
 #define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, pre, post, ...)	\
 	({								\
@@ -583,28 +637,58 @@ int paravirt_disable_iospace(void);
 		      PVOP_VCALLEE_OUTPUTS, ,				\
 		      pre, post, ##__VA_ARGS__)
 
+#define ____PVOP_ALT_VCALL(native, op, clbr, call_clbr, extra_clbr,	\
+			      ...)					\
+({									\
+	PVOP_VCALL_ARGS;						\
+	PVOP_TEST_NULL(op);						\
+	asm volatile(PV_ALT_SITE(native, PV_CALL_STR)			\
+		     : call_clbr, ASM_CALL_CONSTRAINT			\
+		     : PV_INPUT_CONSTRAINTS(op, clbr),			\
+		       ##__VA_ARGS__					\
+		     : "memory", "cc" extra_clbr);			\
+})
+
+#define __PVOP_ALT_VCALL(native, op, ...)				\
+	____PVOP_ALT_VCALL(native, op, CLBR_ANY,			\
+			      PVOP_VCALL_OUTPUTS, VEXTRA_CLOBBERS,	\
+			      ##__VA_ARGS__)
+
+#define __PVOP_ALT_VCALLEESAVE(native, op, ...)				\
+	____PVOP_ALT_VCALL(native, op.func, CLBR_RET_REG,		\
+			      PVOP_VCALLEE_OUTPUTS, , ##__VA_ARGS__)
 
 
 #define PVOP_CALL0(rettype, op)						\
 	__PVOP_CALL(rettype, op, "", "")
+#define PVOP_ALT_CALL0(rettype, native, op)				\
+	__PVOP_ALT_CALL(rettype, native, op)
 #define PVOP_VCALL0(op)							\
 	__PVOP_VCALL(op, "", "")
 
 #define PVOP_CALLEE0(rettype, op)					\
 	__PVOP_CALLEESAVE(rettype, op, "", "")
+#define PVOP_ALT_CALLEE0(rettype, native, op)				\
+	__PVOP_ALT_CALLEESAVE(rettype, native, op)
 #define PVOP_VCALLEE0(op)						\
 	__PVOP_VCALLEESAVE(op, "", "")
+#define PVOP_ALT_VCALLEE0(native, op)					\
+	__PVOP_ALT_VCALLEESAVE(native, op)
 
 
 #define PVOP_CALL1(rettype, op, arg1)					\
 	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
 #define PVOP_VCALL1(op, arg1)						\
 	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_VCALL1(native, op, arg1)				\
+	__PVOP_ALT_VCALL(native, op, PVOP_CALL_ARG1(arg1))
 
 #define PVOP_CALLEE1(rettype, op, arg1)					\
 	__PVOP_CALLEESAVE(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
 #define PVOP_VCALLEE1(op, arg1)						\
 	__PVOP_VCALLEESAVE(op, "", "", PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_VCALLEE1(native, op, arg1)				\
+	__PVOP_ALT_VCALLEESAVE(native, op, PVOP_CALL_ARG1(arg1))
 
 
 #define PVOP_CALL2(rettype, op, arg1, arg2)				\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 81c577c7deba..2d13c1af76ac 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -21,6 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
+#include <asm/cpufeature.h>
 
 int __read_mostly alternatives_patched;
 
@@ -269,6 +270,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 }
 
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+extern struct alt_instr __pv_alt_instructions[], __pv_alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void *text_poke_early(void *addr, const void *opcode, size_t len);
 
@@ -598,6 +600,17 @@ int alternatives_text_reserved(void *start, void *end)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PARAVIRT
+/*
+ * Paravirt alternatives are applied much earlier than normal alternatives.
+ * They are only applied when running on a hypervisor.  They replace some
+ * native instructions with calls to pv ops.
+ */
+void __init apply_pv_alternatives(void)
+{
+	setup_force_cpu_cap(X86_FEATURE_PV_OPS);
+	apply_alternatives(__pv_alt_instructions, __pv_alt_instructions_end);
+}
+
 void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 				     struct paravirt_patch_site *end)
 {
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 4fa90006ac68..17243fe0f5ce 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -71,6 +71,8 @@ void __init init_hypervisor_platform(void)
 	if (!x86_hyper)
 		return;
 
+	apply_pv_alternatives();
+
 	if (x86_hyper->init_platform)
 		x86_hyper->init_platform();
 }
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 62e7d70aadd5..34ec137e302a 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -213,8 +213,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL;
+	const Elf_Shdr *s, *text = NULL, *alt = NULL, *pv_alt = NULL,
+		*locks = NULL, *para = NULL, *orc = NULL, *orc_ip = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -222,6 +222,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			text = s;
 		if (!strcmp(".altinstructions", secstrings + s->sh_name))
 			alt = s;
+		if (!strcmp(".pv_altinstructions", secstrings + s->sh_name))
+			pv_alt = s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
 			locks = s;
 		if (!strcmp(".parainstructions", secstrings + s->sh_name))
@@ -237,6 +239,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
+	if (pv_alt) {
+		/* patch .altinstructions */
+		void *seg = (void *)pv_alt->sh_addr;
+		apply_alternatives(seg, seg + pv_alt->sh_size);
+	}
 	if (locks && text) {
 		void *lseg = (void *)locks->sh_addr;
 		void *tseg = (void *)text->sh_addr;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f05f00acac89..94537de39109 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -250,6 +250,12 @@ SECTIONS
 		*(.altinstructions)
 		__alt_instructions_end = .;
 	}
+	. = ALIGN(8);
+	.pv_altinstructions : AT(ADDR(.pv_altinstructions) - LOAD_OFFSET) {
+		__pv_alt_instructions = .;
+		*(.pv_altinstructions)
+		__pv_alt_instructions_end = .;
+	}
 
 	/*
 	 * And here are the replacement instructions. The linker sticks
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c0cb5c2bfd92..874953d8c360 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1224,6 +1224,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	pv_info = xen_info;
 	pv_init_ops.patch = paravirt_patch_default;
 	pv_cpu_ops = xen_cpu_ops;
+	apply_pv_alternatives();
 
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
 
-- 
2.13.6
