From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 12/17] paravirt_ops - interrupt/exception
	changes
Date: Thu, 08 Mar 2007 01:02:28 -0500
Message-ID: <1173333748.25848.13.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-irqs.patch)
Interrupt updates for paravirt ops.


Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>



Index: clean-start/arch/x86_64/ia32/ia32entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/ia32/ia32entry.S
+++ clean-start/arch/x86_64/ia32/ia32entry.S
@@ -16,6 +16,13 @@
 #include <asm/irqflags.h>
 #include <linux/linkage.h>
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define ENABLE_INTERRUPTS(CLBR)		sti
+#define DISABLE_INTERRUPTS(CLBR)	cli
+#endif
+
 #define IA32_NR_syscalls ((ia32_syscall_end - ia32_sys_call_table)/8)
 =

 	.macro IA32_ARG_FIXUP noebp=3D0
@@ -81,7 +88,7 @@ ENTRY(ia32_sysenter_target)
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs, here we enable it straight after entry:
 	 */
-	sti	=

+	ENABLE_INTERRUPTS(CLBR_NONE)
  	movl	%ebp,%ebp		/* zero extension */
 	pushq	$__USER32_DS
 	CFI_ADJUST_CFA_OFFSET 8
@@ -123,7 +130,7 @@ sysenter_do_call:	=

 	call	*ia32_sys_call_table(,%rax,8)
 	movq	%rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	testl	$_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
 	jnz	int_ret_from_sys_call
@@ -141,7 +148,7 @@ sysenter_do_call:	=

 	CFI_REGISTER rip,rdx
 	TRACE_IRQS_ON
 	swapgs
-	sti		/* sti only takes effect after the next instruction */
+	ENABLE_INTERRUPTS(CLBR_NONE)		/* sti only takes effect after the next ins=
truction */
 	/* sysexit */
 	.byte	0xf, 0x35
 =

@@ -199,7 +206,7 @@ ENTRY(ia32_cstar_target)
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs and here we enable it straight after entry:
 	 */
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_ARGS 8,1,1
 	movl 	%eax,%eax	/* zero extension */
 	movq	%rax,ORIG_RAX-ARGOFFSET(%rsp)
@@ -232,7 +239,7 @@ cstar_do_call:	=

 	call *ia32_sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	testl $_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
 	jnz  int_ret_from_sys_call
@@ -307,7 +314,7 @@ ENTRY(ia32_syscall)
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs and here we enable it straight after entry:
 	 */
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	movl %eax,%eax
 	pushq %rax
 	CFI_ADJUST_CFA_OFFSET 8
Index: clean-start/arch/x86_64/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/entry.S
+++ clean-start/arch/x86_64/kernel/entry.S
@@ -51,6 +51,15 @@
 #include <asm/page.h>
 #include <asm/irqflags.h>
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define ENABLE_INTERRUPTS(x)	sti
+#define DISABLE_INTERRUPTS(x)	cli
+#define INTERRUPT_RETURN	iretq
+#define SYSRETQ			sysretq
+#define SWAPGS			swapgs
+#endif
 	.code64
 =

 #ifndef CONFIG_PREEMPT
@@ -179,6 +188,7 @@ rff_trace:
 	CFI_ENDPROC
 END(ret_from_fork)
 =

+
 /*
  * System call entry. Upto 6 arguments in registers are supported.
  *
@@ -223,7 +233,7 @@ ENTRY(system_call)
 	 * No need to follow this irqs off/on section - it's straight
 	 * and short:
 	 */
-	sti					=

+	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_ARGS 8,1
 	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp) =

 	movq  %rcx,RIP-ARGOFFSET(%rsp)
@@ -270,7 +280,7 @@ sysret_careful:
 	bt $TIF_NEED_RESCHED,%edx
 	jnc sysret_signal
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
 	call schedule
@@ -281,7 +291,7 @@ sysret_careful:
 	/* Handle a signal */ =

 sysret_signal:
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
 	jz    1f
 =

@@ -294,7 +304,7 @@ sysret_signal:
 1:	movl $_TIF_NEED_RESCHED,%edi
 	/* Use IRET because user could have changed frame. This
 	   works because ptregscall_common has called FIXUP_TOP_OF_STACK. */
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	jmp int_with_check
 	=

@@ -326,7 +336,7 @@ tracesys:			 =

  */
 	.globl int_ret_from_sys_call
 int_ret_from_sys_call:
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_restore_args
@@ -347,20 +357,20 @@ int_careful:
 	bt $TIF_NEED_RESCHED,%edx
 	jnc  int_very_careful
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
 	call schedule
 	popq %rdi
 	CFI_ADJUST_CFA_OFFSET -8
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	jmp int_with_check
 =

 	/* handle signals and tracing -- both require a full stack frame */
 int_very_careful:
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_REST
 	/* Check for syscall exit trace */	=

 	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edx
@@ -383,7 +393,7 @@ int_signal:
 1:	movl $_TIF_NEED_RESCHED,%edi	=

 int_restore_rest:
 	RESTORE_REST
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	jmp int_with_check
 	CFI_ENDPROC
@@ -504,7 +514,7 @@ END(stub_rt_sigreturn)
 	CFI_DEF_CFA_REGISTER	rbp
 	testl $3,CS(%rdi)
 	je 1f
-	swapgs	=

+	SWAPGS
 	/* irqcount is used to check if a CPU is already on an interrupt
 	   stack or not. While this is essentially redundant with preempt_count
 	   it is a little cheaper to use a separate counter in the PDA
@@ -525,7 +535,7 @@ ENTRY(common_interrupt)
 	interrupt do_IRQ
 	/* 0(%rsp): oldrsp-ARGOFFSET */
 ret_from_intr:
-	cli	=

+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	decl %gs:pda_irqcount
 	leaveq
@@ -552,13 +562,13 @@ retint_swapgs:	 	=

 	/*
 	 * The iretq could re-enable interrupts:
 	 */
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_IRETQ
-	swapgs =

+	SWAPGS
 	jmp restore_args
 =

 retint_restore_args:				=

-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	/*
 	 * The iretq could re-enable interrupts:
 	 */
@@ -566,10 +576,14 @@ retint_restore_args:				=

 restore_args:
 	RESTORE_ARGS 0,8,0						=

 iret_label:	=

-	iretq
+#ifdef CONFIG_PARAVIRT
+	INTERRUPT_RETURN
+ENTRY(native_iret)
+#endif
+1:	iretq
 =

 	.section __ex_table,"a"
-	.quad iret_label,bad_iret	=

+	.quad 1b, bad_iret
 	.previous
 	.section .fixup,"ax"
 	/* force a signal here? this matches i386 behaviour */
@@ -577,24 +591,27 @@ iret_label:	=

 bad_iret:
 	movq $11,%rdi	/* SIGSEGV */
 	TRACE_IRQS_ON
-	sti
-	jmp do_exit			=

-	.previous	=

-	=

+	ENABLE_INTERRUPTS(CLBR_NONE)
+	jmp do_exit
+	.previous
+#ifdef CONFIG_PARAVIRT
+ENDPROC(native_iret)
+#endif
+
 	/* edi: workmask, edx: work */
 retint_careful:
 	CFI_RESTORE_STATE
 	bt    $TIF_NEED_RESCHED,%edx
 	jnc   retint_signal
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET	8
 	call  schedule
 	popq %rdi		=

 	CFI_ADJUST_CFA_OFFSET	-8
 	GET_THREAD_INFO(%rcx)
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	jmp retint_check
 	=

@@ -602,14 +619,14 @@ retint_signal:
 	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
 	jz    retint_swapgs
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_REST
 	movq $-1,ORIG_RAX(%rsp) 			=

 	xorl %esi,%esi		# oldset
 	movq %rsp,%rdi		# &pt_regs
 	call do_notify_resume
 	RESTORE_REST
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	movl $_TIF_NEED_RESCHED,%edi
 	GET_THREAD_INFO(%rcx)
@@ -722,7 +739,7 @@ END(spurious_interrupt)
 	rdmsr
 	testl %edx,%edx
 	js    1f
-	swapgs
+	SWAPGS
 	xorl  %ebx,%ebx
 1:
 	.if \ist
@@ -738,7 +755,7 @@ END(spurious_interrupt)
 	.if \ist
 	addq	$EXCEPTION_STKSZ, per_cpu__init_tss + TSS_ist + (\ist - 1) * 8(%rbp)
 	.endif
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	.if \irqtrace
 	TRACE_IRQS_OFF
 	.endif
@@ -767,10 +784,10 @@ paranoid_swapgs\trace:
 	.if \trace
 	TRACE_IRQS_IRETQ 0
 	.endif
-	swapgs
+	SWAPGS
 paranoid_restore\trace:
 	RESTORE_ALL 8
-	iretq
+	INTERRUPT_RETURN
 paranoid_userspace\trace:
 	GET_THREAD_INFO(%rcx)
 	movl threadinfo_flags(%rcx),%ebx
@@ -785,11 +802,11 @@ paranoid_userspace\trace:
 	.if \trace
 	TRACE_IRQS_ON
 	.endif
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	xorl %esi,%esi 			/* arg2: oldset */
 	movq %rsp,%rdi 			/* arg1: &pt_regs */
 	call do_notify_resume
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	.if \trace
 	TRACE_IRQS_OFF
 	.endif
@@ -798,9 +815,9 @@ paranoid_schedule\trace:
 	.if \trace
 	TRACE_IRQS_ON
 	.endif
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	call schedule
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	.if \trace
 	TRACE_IRQS_OFF
 	.endif
@@ -851,7 +868,7 @@ KPROBE_ENTRY(error_entry)
 	testl $3,CS(%rsp)
 	je  error_kernelspace
 error_swapgs:	=

-	swapgs
+	SWAPGS
 error_sti:	=

 	movq %rdi,RDI(%rsp) 	=

 	movq %rsp,%rdi
@@ -862,7 +879,7 @@ error_sti:	=

 error_exit:		=

 	movl %ebx,%eax		=

 	RESTORE_REST
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	GET_THREAD_INFO(%rcx)	=

 	testl %eax,%eax
@@ -875,7 +892,7 @@ error_exit:		=

 	 * The iret might restore flags:
 	 */
 	TRACE_IRQS_IRETQ
-	swapgs =

+	SWAPGS
 	RESTORE_ARGS 0,8,0						=

 	jmp iret_label
 	CFI_ENDPROC
@@ -904,12 +921,12 @@ ENTRY(load_gs_index)
 	CFI_STARTPROC
 	pushf
 	CFI_ADJUST_CFA_OFFSET 8
-	cli
-        swapgs
+	DISABLE_INTERRUPTS(CLBR_NONE)
+        SWAPGS
 gs_change:     =

         movl %edi,%gs   =

 2:	mfence		/* workaround */
-	swapgs
+	SWAPGS
         popf
 	CFI_ADJUST_CFA_OFFSET -8
         ret
@@ -923,7 +940,7 @@ ENDPROC(load_gs_index)
         .section .fixup,"ax"
 	/* running with kernelgs */
 bad_gs: =

-	swapgs			/* switch back to user gs */
+	SWAPGS			/* switch back to user gs */
 	xorl %eax,%eax
         movl %eax,%gs
         jmp  2b
@@ -1064,6 +1081,13 @@ KPROBE_ENTRY(int3)
  	CFI_ENDPROC
 KPROBE_END(int3)
 =

+#ifdef CONFIG_PARAVIRT
+ENTRY(native_sysret)
+	sysretq
+ENDPROC(native_sysret)
+
+#endif /* CONFIG_PARAVIRT */
+
 ENTRY(overflow)
 	zeroentry do_overflow
 END(overflow)
Index: clean-start/arch/x86_64/kernel/i8259.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/i8259.c
+++ clean-start/arch/x86_64/kernel/i8259.c
@@ -77,7 +77,7 @@ BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd) BU
 	IRQ(x,c), IRQ(x,d), IRQ(x,e), IRQ(x,f)
 =

 /* for the irq vectors */
-static void (*interrupt[NR_VECTORS - FIRST_EXTERNAL_VECTOR])(void) =3D {
+void (*interrupt[NR_VECTORS - FIRST_EXTERNAL_VECTOR])(void) =3D {
 					  IRQLIST_16(0x2), IRQLIST_16(0x3),
 	IRQLIST_16(0x4), IRQLIST_16(0x5), IRQLIST_16(0x6), IRQLIST_16(0x7),
 	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
@@ -501,7 +501,10 @@ static int __init init_timer_sysfs(void)
 =

 device_initcall(init_timer_sysfs);
 =

-void __init init_IRQ(void)
+/* Overridden in paravirt.c */
+void init_IRQ(void) __attribute__((weak, alias("native_init_IRQ")));
+
+void __init native_init_IRQ(void)
 {
 	int i;
 =

Index: clean-start/arch/x86_64/kernel/traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/traps.c
+++ clean-start/arch/x86_64/kernel/traps.c
@@ -1067,6 +1067,7 @@ asmlinkage void math_state_restore(void)
 	task_thread_info(me)->status |=3D TS_USEDFPU;
 	me->fpu_counter++;
 }
+EXPORT_SYMBOL_GPL(math_state_restore);
 =

 void __init trap_init(void)
 {
Index: clean-start/include/asm-x86_64/irq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/irq.h
+++ clean-start/include/asm-x86_64/irq.h
@@ -46,6 +46,9 @@ static __inline__ int irq_canonicalize(i
 extern void fixup_irqs(cpumask_t map);
 #endif
 =

+void init_IRQ(void);
+void native_init_IRQ(void);
+
 #define __ARCH_HAS_DO_SOFTIRQ 1
 =

 #endif /* _ASM_IRQ_H */
Index: clean-start/include/asm-x86_64/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/irqflags.h
+++ clean-start/include/asm-x86_64/irqflags.h
@@ -11,6 +11,15 @@
 #define _ASM_IRQFLAGS_H
 =

 #ifndef __ASSEMBLY__
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1 << 9));
+}
+#else
+
 /*
  * Interrupt control:
  */
@@ -30,8 +39,6 @@ static inline unsigned long __raw_local_
 	return flags;
 }
 =

-#define raw_local_save_flags(flags) \
-		do { (flags) =3D __raw_local_save_flags(); } while (0)
 =

 static inline void raw_local_irq_restore(unsigned long flags)
 {
@@ -100,8 +107,6 @@ static inline unsigned long __raw_local_
 	return flags;
 }
 =

-#define raw_local_irq_save(flags) \
-		do { (flags) =3D __raw_local_irq_save(); } while (0)
 =

 static inline int raw_irqs_disabled(void)
 {
@@ -128,6 +133,7 @@ static inline void halt(void)
 	__asm__ __volatile__("hlt": : :"memory");
 }
 =

+#endif /* CONFIG_PARAVIRT */
 #else /* __ASSEMBLY__: */
 # ifdef CONFIG_TRACE_IRQFLAGS
 #  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk
@@ -138,4 +144,9 @@ static inline void halt(void)
 # endif
 #endif
 =

+#define raw_local_save_flags(flags) \
+		do { (flags) =3D __raw_local_save_flags(); } while (0)
+
+#define raw_local_irq_save(flags) \
+		do { (flags) =3D __raw_local_irq_save(); } while (0)
 #endif

--
