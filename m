From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 05/13] x86/paravirt: Move paravirt asm macros to paravirt-asm.h
Date: Wed,  4 Oct 2017 10:58:26 -0500
Message-ID: <4ce3349e19c5ea443cb33f76468adddcee685f89.1507128293.git.jpoimboe__293.14086209542$1509079617$gmane$org@redhat.com>
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

The paravirt.h file is quite big and the asm interfaces for paravirt
don't need to be in the same file as the C interfaces.  Move the asm
interfaces to a dedicated header file.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/entry_32.S           |   1 +
 arch/x86/entry/entry_64.S           |   2 +-
 arch/x86/entry/entry_64_compat.S    |   1 +
 arch/x86/include/asm/paravirt-asm.h | 126 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt.h     | 132 +++---------------------------------
 arch/x86/kernel/head_64.S           |   2 +-
 6 files changed, 138 insertions(+), 126 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-asm.h

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 8a13d468635a..21d1197779a4 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -40,6 +40,7 @@
 #include <asm/irq_vectors.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative-asm.h>
+#include <asm/paravirt-asm.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/frame.h>
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 49167258d587..c7c85724d7e0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -30,7 +30,7 @@
 #include <asm/hw_irq.h>
 #include <asm/page_types.h>
 #include <asm/irqflags.h>
-#include <asm/paravirt.h>
+#include <asm/paravirt-asm.h>
 #include <asm/percpu.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index e26c25ca7756..4d9385529c39 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -13,6 +13,7 @@
 #include <asm/irqflags.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/paravirt-asm.h>
 #include <linux/linkage.h>
 #include <linux/err.h>
 
diff --git a/arch/x86/include/asm/paravirt-asm.h b/arch/x86/include/asm/paravirt-asm.h
new file mode 100644
index 000000000000..add8a190fdac
--- /dev/null
+++ b/arch/x86/include/asm/paravirt-asm.h
@@ -0,0 +1,126 @@
+#ifndef _ASM_X86_PARAVIRT_ASM_H
+#define _ASM_X86_PARAVIRT_ASM_H
+
+#ifdef CONFIG_PARAVIRT
+#ifdef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/paravirt_types.h>
+
+#define _PVSITE(ptype, clobbers, ops, word, algn)	\
+771:;						\
+	ops;					\
+772:;						\
+	.pushsection .parainstructions,"a";	\
+	 .align	algn;				\
+	 word 771b;				\
+	 .byte ptype;				\
+	 .byte 772b-771b;			\
+	 .short clobbers;			\
+	.popsection
+
+
+#define COND_PUSH(set, mask, reg)			\
+	.if ((~(set)) & mask); push %reg; .endif
+#define COND_POP(set, mask, reg)			\
+	.if ((~(set)) & mask); pop %reg; .endif
+
+#ifdef CONFIG_X86_64
+
+#define PV_SAVE_REGS(set)			\
+	COND_PUSH(set, CLBR_RAX, rax);		\
+	COND_PUSH(set, CLBR_RCX, rcx);		\
+	COND_PUSH(set, CLBR_RDX, rdx);		\
+	COND_PUSH(set, CLBR_RSI, rsi);		\
+	COND_PUSH(set, CLBR_RDI, rdi);		\
+	COND_PUSH(set, CLBR_R8, r8);		\
+	COND_PUSH(set, CLBR_R9, r9);		\
+	COND_PUSH(set, CLBR_R10, r10);		\
+	COND_PUSH(set, CLBR_R11, r11)
+#define PV_RESTORE_REGS(set)			\
+	COND_POP(set, CLBR_R11, r11);		\
+	COND_POP(set, CLBR_R10, r10);		\
+	COND_POP(set, CLBR_R9, r9);		\
+	COND_POP(set, CLBR_R8, r8);		\
+	COND_POP(set, CLBR_RDI, rdi);		\
+	COND_POP(set, CLBR_RSI, rsi);		\
+	COND_POP(set, CLBR_RDX, rdx);		\
+	COND_POP(set, CLBR_RCX, rcx);		\
+	COND_POP(set, CLBR_RAX, rax)
+
+#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
+#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
+#define PARA_INDIRECT(addr)	*addr(%rip)
+#else
+#define PV_SAVE_REGS(set)			\
+	COND_PUSH(set, CLBR_EAX, eax);		\
+	COND_PUSH(set, CLBR_EDI, edi);		\
+	COND_PUSH(set, CLBR_ECX, ecx);		\
+	COND_PUSH(set, CLBR_EDX, edx)
+#define PV_RESTORE_REGS(set)			\
+	COND_POP(set, CLBR_EDX, edx);		\
+	COND_POP(set, CLBR_ECX, ecx);		\
+	COND_POP(set, CLBR_EDI, edi);		\
+	COND_POP(set, CLBR_EAX, eax)
+
+#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 4)
+#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .long, 4)
+#define PARA_INDIRECT(addr)	*%cs:addr
+#endif
+
+#define INTERRUPT_RETURN						\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
+
+#define DISABLE_INTERRUPTS(clobbers)					\
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
+		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
+		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
+
+#define ENABLE_INTERRUPTS(clobbers)					\
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
+		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
+		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
+
+#ifdef CONFIG_X86_32
+#define GET_CR0_INTO_EAX				\
+	push %ecx; push %edx;				\
+	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
+	pop %edx; pop %ecx
+#else	/* !CONFIG_X86_32 */
+
+/*
+ * If swapgs is used while the userspace stack is still current,
+ * there's no way to call a pvop.  The PV replacement *must* be
+ * inlined, or the swapgs instruction must be trapped and emulated.
+ */
+#define SWAPGS_UNSAFE_STACK						\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
+		  swapgs)
+
+/*
+ * Note: swapgs is very special, and in practise is either going to be
+ * implemented with a single "swapgs" instruction or something very
+ * special.  Either way, we don't need to save any registers for
+ * it.
+ */
+#define SWAPGS								\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
+		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs)		\
+		 )
+
+#define GET_CR2_INTO_RAX				\
+	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
+
+#define USERGS_SYSRET64							\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
+		  CLBR_NONE,						\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
+#endif	/* CONFIG_X86_32 */
+
+#endif  /*  __ASSEMBLY__  */
+#endif /* CONFIG_PARAVIRT */
+
+#endif /* _ASM_X86_PARAVIRT_ASM_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2f51fbf175da..bfd02c3335cb 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -3,17 +3,16 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
 
-#ifdef CONFIG_PARAVIRT
-#include <asm/pgtable_types.h>
-#include <asm/asm.h>
+#ifndef __ASSEMBLY__
 
-#include <asm/paravirt_types.h>
+#ifdef CONFIG_PARAVIRT
 
-#ifndef __ASSEMBLY__
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <asm/frame.h>
+#include <asm/pgtable_types.h>
+#include <asm/paravirt_types.h>
 
 static inline void load_sp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
@@ -809,125 +808,8 @@ static inline notrace unsigned long arch_local_irq_save(void)
 
 extern void default_banner(void);
 
-#else  /* __ASSEMBLY__ */
-
-#define _PVSITE(ptype, clobbers, ops, word, algn)	\
-771:;						\
-	ops;					\
-772:;						\
-	.pushsection .parainstructions,"a";	\
-	 .align	algn;				\
-	 word 771b;				\
-	 .byte ptype;				\
-	 .byte 772b-771b;			\
-	 .short clobbers;			\
-	.popsection
-
-
-#define COND_PUSH(set, mask, reg)			\
-	.if ((~(set)) & mask); push %reg; .endif
-#define COND_POP(set, mask, reg)			\
-	.if ((~(set)) & mask); pop %reg; .endif
-
-#ifdef CONFIG_X86_64
-
-#define PV_SAVE_REGS(set)			\
-	COND_PUSH(set, CLBR_RAX, rax);		\
-	COND_PUSH(set, CLBR_RCX, rcx);		\
-	COND_PUSH(set, CLBR_RDX, rdx);		\
-	COND_PUSH(set, CLBR_RSI, rsi);		\
-	COND_PUSH(set, CLBR_RDI, rdi);		\
-	COND_PUSH(set, CLBR_R8, r8);		\
-	COND_PUSH(set, CLBR_R9, r9);		\
-	COND_PUSH(set, CLBR_R10, r10);		\
-	COND_PUSH(set, CLBR_R11, r11)
-#define PV_RESTORE_REGS(set)			\
-	COND_POP(set, CLBR_R11, r11);		\
-	COND_POP(set, CLBR_R10, r10);		\
-	COND_POP(set, CLBR_R9, r9);		\
-	COND_POP(set, CLBR_R8, r8);		\
-	COND_POP(set, CLBR_RDI, rdi);		\
-	COND_POP(set, CLBR_RSI, rsi);		\
-	COND_POP(set, CLBR_RDX, rdx);		\
-	COND_POP(set, CLBR_RCX, rcx);		\
-	COND_POP(set, CLBR_RAX, rax)
-
-#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
-#define PARA_INDIRECT(addr)	*addr(%rip)
-#else
-#define PV_SAVE_REGS(set)			\
-	COND_PUSH(set, CLBR_EAX, eax);		\
-	COND_PUSH(set, CLBR_EDI, edi);		\
-	COND_PUSH(set, CLBR_ECX, ecx);		\
-	COND_PUSH(set, CLBR_EDX, edx)
-#define PV_RESTORE_REGS(set)			\
-	COND_POP(set, CLBR_EDX, edx);		\
-	COND_POP(set, CLBR_ECX, ecx);		\
-	COND_POP(set, CLBR_EDI, edi);		\
-	COND_POP(set, CLBR_EAX, eax)
-
-#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 4)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .long, 4)
-#define PARA_INDIRECT(addr)	*%cs:addr
-#endif
-
-#define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
-
-#define DISABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
-		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
-		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
-
-#define ENABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
-		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
-		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
-
-#ifdef CONFIG_X86_32
-#define GET_CR0_INTO_EAX				\
-	push %ecx; push %edx;				\
-	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
-	pop %edx; pop %ecx
-#else	/* !CONFIG_X86_32 */
-
-/*
- * If swapgs is used while the userspace stack is still current,
- * there's no way to call a pvop.  The PV replacement *must* be
- * inlined, or the swapgs instruction must be trapped and emulated.
- */
-#define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  swapgs)
-
-/*
- * Note: swapgs is very special, and in practise is either going to be
- * implemented with a single "swapgs" instruction or something very
- * special.  Either way, we don't need to save any registers for
- * it.
- */
-#define SWAPGS								\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs)		\
-		 )
-
-#define GET_CR2_INTO_RAX				\
-	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
-
-#define USERGS_SYSRET64							\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
-		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
-#endif	/* CONFIG_X86_32 */
-
-#endif /* __ASSEMBLY__ */
-#else  /* CONFIG_PARAVIRT */
+#else  /* !CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
-#ifndef __ASSEMBLY__
 static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 					  struct mm_struct *mm)
 {
@@ -936,6 +818,8 @@ static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 }
-#endif /* __ASSEMBLY__ */
 #endif /* !CONFIG_PARAVIRT */
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 42e32c2e51bb..5bf2faec41b9 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -25,7 +25,7 @@
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
-#include <asm/paravirt.h>
+#include <asm/paravirt-asm.h>
 #define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
 #else
 #define GET_CR2_INTO(reg) movq %cr2, reg
-- 
2.13.6
