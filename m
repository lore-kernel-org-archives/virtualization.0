From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH] paravirt_ops x86_64 , take 2
Date: Fri, 12 Jan 2007 01:04:07 -0200
Message-ID: <20070112030407.GA19490@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org, rusty@rustcorp.com.au
List-Id: virtualization@lists.linuxfoundation.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

Here's a new version of the paravirt_ops x86_64 patch. With this
message, I'm sending an incremental patch. The complete patches can be
found , from now on, at  http://et.redhat.com/~gcosta/paravirt_ops/

The main aim of this new update, is to fix a critical bug, namely,
Rusty's name. However, I took the opportunity to write some new less
important pieces of code, highlighting:

* proper casts in places in which macros were replaced by functions, and
the arguments happened to mismatch types.
* calling paravirt_ops functions from .S files (I lacked this last time)
* addition of the startup_paravirt function, to kick off guests (not
tested) 
* fixed problems with patching
* added a new field, vsyscall_page in the paravirt_ops struct, which
allows the kernel to map a vsyscall_page on its own
* fixed vsyscall functions to avoid calling paravirt_ops functions.
__vsyscall_0 is the page to be mapped for the host. (set and get cpu not
yet tested.)
* fixed cpuid calls. 
* added substitute for the swapgs instruction. (Notice that I'm not
saying it works ;-) )

In my TODO list, you can find: 
* putting swapgs to work
* making sure legacy mode binaries work 
* merging in valuable commentaries from all you ;-)

-- 
Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="incremental-12Jan.patch"

diff -urp linux-2.6.19-paravirt0/arch/i386/kernel/alternative.c linux-2.6.19-paravirt1/arch/i386/kernel/alternative.c
--- linux-2.6.19-paravirt0/arch/i386/kernel/alternative.c	2007-01-11 21:57:07.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/i386/kernel/alternative.c	2007-01-11 21:42:22.000000000 -0200
@@ -431,9 +431,7 @@ void __init alternative_instructions(voi
 	}
 #endif
 #ifdef CONFIG_PARAVIRT
-  #ifndef CONFIG_X86_64 /* Not working properly yet */
  	apply_paravirt(__start_parainstructions, __stop_parainstructions);
-  #endif
 #endif
 	local_irq_restore(flags);
 }
diff -urp linux-2.6.19-paravirt0/arch/x86_64/ia32/syscall32.c linux-2.6.19-paravirt1/arch/x86_64/ia32/syscall32.c
--- linux-2.6.19-paravirt0/arch/x86_64/ia32/syscall32.c	2007-01-11 21:51:35.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/ia32/syscall32.c	2007-01-09 11:01:19.000000000 -0200
@@ -104,5 +104,5 @@ void syscall32_cpu_init(void)
 	checking_wrmsrl(MSR_IA32_SYSENTER_ESP, 0ULL);
 	checking_wrmsrl(MSR_IA32_SYSENTER_EIP, (u64)ia32_sysenter_target);
 
-	wrmsrl(MSR_CSTAR, ia32_cstar_target);
+	wrmsrl(MSR_CSTAR, (u64)ia32_cstar_target);
 }
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/asm-offsets.c linux-2.6.19-paravirt1/arch/x86_64/kernel/asm-offsets.c
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/asm-offsets.c	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/asm-offsets.c	2007-01-11 09:46:44.000000000 -0200
@@ -79,9 +79,10 @@ int main(void)
 	ENTRY(paravirt_enabled);
 	ENTRY(irq_disable);
 	ENTRY(irq_enable);
-	ENTRY(irq_enable_sysexit);
+	ENTRY(sysret);
 	ENTRY(iret);
-	ENTRY(read_cr0);
+	ENTRY(read_cr2);
+	ENTRY(swapgs);
 #endif
 
 	return 0;
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/entry.S linux-2.6.19-paravirt1/arch/x86_64/kernel/entry.S
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/entry.S	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/entry.S	2007-01-11 22:22:26.000000000 -0200
@@ -51,6 +51,13 @@
 #include <asm/page.h>
 #include <asm/irqflags.h>
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define ENABLE_INTERRUPTS(x)	sti
+#define DISABLE_INTERRUPTS(x)	cli
+#define SYSRETQ			sysretq
+#endif
 	.code64
 
 #ifndef CONFIG_PREEMPT
@@ -179,6 +186,7 @@ rff_trace:
 	CFI_ENDPROC
 END(ret_from_fork)
 
+
 /*
  * System call entry. Upto 6 arguments in registers are supported.
  *
@@ -223,7 +231,7 @@ ENTRY(system_call)
 	 * No need to follow this irqs off/on section - it's straight
 	 * and short:
 	 */
-	sti					
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_ARGS 8,1
 	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp) 
 	movq  %rcx,RIP-ARGOFFSET(%rsp)
@@ -245,7 +253,7 @@ ret_from_sys_call:
 	/* edi:	flagmask */
 sysret_check:		
 	GET_THREAD_INFO(%rcx)
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	movl threadinfo_flags(%rcx),%edx
 	andl %edi,%edx
@@ -261,7 +269,7 @@ sysret_check:		
 	/*CFI_REGISTER	rflags,r11*/
 	movq	%gs:pda_oldrsp,%rsp
 	swapgs
-	sysretq
+	SYSRETQ
 
 	CFI_RESTORE_STATE
 	/* Handle reschedules */
@@ -270,7 +278,7 @@ sysret_careful:
 	bt $TIF_NEED_RESCHED,%edx
 	jnc sysret_signal
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
 	call schedule
@@ -281,7 +289,7 @@ sysret_careful:
 	/* Handle a signal */ 
 sysret_signal:
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
 	jz    1f
 
@@ -294,7 +302,7 @@ sysret_signal:
 1:	movl $_TIF_NEED_RESCHED,%edi
 	/* Use IRET because user could have changed frame. This
 	   works because ptregscall_common has called FIXUP_TOP_OF_STACK. */
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	jmp int_with_check
 	
@@ -326,7 +334,7 @@ tracesys:			 
  */
 	.globl int_ret_from_sys_call
 int_ret_from_sys_call:
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_restore_args
@@ -347,20 +355,20 @@ int_careful:
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
 
 	/* handle signals and tracing -- both require a full stack frame */
 int_very_careful:
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_REST
 	/* Check for syscall exit trace */	
 	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edx
@@ -383,7 +391,7 @@ int_signal:
 1:	movl $_TIF_NEED_RESCHED,%edi	
 int_restore_rest:
 	RESTORE_REST
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	jmp int_with_check
 	CFI_ENDPROC
@@ -525,7 +533,7 @@ ENTRY(common_interrupt)
 	interrupt do_IRQ
 	/* 0(%rsp): oldrsp-ARGOFFSET */
 ret_from_intr:
-	cli	
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	decl %gs:pda_irqcount
 	leaveq
@@ -552,13 +560,13 @@ retint_swapgs:	 	
 	/*
 	 * The iretq could re-enable interrupts:
 	 */
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_IRETQ
 	swapgs 
 	jmp restore_args
 
 retint_restore_args:				
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	/*
 	 * The iretq could re-enable interrupts:
 	 */
@@ -566,35 +574,22 @@ retint_restore_args:				
 restore_args:
 	RESTORE_ARGS 0,8,0						
 iret_label:	
-	iretq
+	INTERRUPT_RETURN
 
-	.section __ex_table,"a"
-	.quad iret_label,bad_iret	
-	.previous
-	.section .fixup,"ax"
-	/* force a signal here? this matches i386 behaviour */
-	/* running with kernel gs */
-bad_iret:
-	movq $11,%rdi	/* SIGSEGV */
-	TRACE_IRQS_ON
-	sti
-	jmp do_exit			
-	.previous	
-	
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
 	popq %rdi		
 	CFI_ADJUST_CFA_OFFSET	-8
 	GET_THREAD_INFO(%rcx)
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	jmp retint_check
 	
@@ -602,14 +597,14 @@ retint_signal:
 	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
 	jz    retint_swapgs
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_REST
 	movq $-1,ORIG_RAX(%rsp) 			
 	xorl %esi,%esi		# oldset
 	movq %rsp,%rdi		# &pt_regs
 	call do_notify_resume
 	RESTORE_REST
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	movl $_TIF_NEED_RESCHED,%edi
 	GET_THREAD_INFO(%rcx)
@@ -738,7 +733,7 @@ END(spurious_interrupt)
 	.if \ist
 	addq	$EXCEPTION_STKSZ, per_cpu__init_tss + TSS_ist + (\ist - 1) * 8(%rbp)
 	.endif
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	.if \irqtrace
 	TRACE_IRQS_OFF
 	.endif
@@ -770,7 +765,7 @@ paranoid_swapgs\trace:
 	swapgs
 paranoid_restore\trace:
 	RESTORE_ALL 8
-	iretq
+	INTERRUPT_RETURN
 paranoid_userspace\trace:
 	GET_THREAD_INFO(%rcx)
 	movl threadinfo_flags(%rcx),%ebx
@@ -785,11 +780,11 @@ paranoid_userspace\trace:
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
@@ -798,9 +793,9 @@ paranoid_schedule\trace:
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
@@ -862,7 +857,7 @@ error_sti:	
 error_exit:		
 	movl %ebx,%eax		
 	RESTORE_REST
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	GET_THREAD_INFO(%rcx)	
 	testl %eax,%eax
@@ -904,7 +899,7 @@ ENTRY(load_gs_index)
 	CFI_STARTPROC
 	pushf
 	CFI_ADJUST_CFA_OFFSET 8
-	cli
+	DISABLE_INTERRUPTS(CLBR_NONE)
         swapgs
 gs_change:     
         movl %edi,%gs   
@@ -1065,18 +1060,32 @@ KPROBE_ENTRY(int3)
 KPROBE_END(int3)
 
 #ifdef CONFIG_PARAVIRT
+/* Not yet working. Do not use */
+ENTRY(native_swapgs)
+	swapgs
+	jmp 	%cs:(paravirt_ops+PARAVIRT_swapgs)
+ENDPROC(native_swapgs)
+
 ENTRY(native_iret)
 1:	iretq
 .section __ex_table,"a"
 	.align 8
 	.quad 1b, bad_iret
 .previous
+.section .fixup,"ax"
+/* force a signal here? this matches i386 behaviour */
+/* running with kernel gs */
+bad_iret:
+	movq $11,%rdi	/* SIGSEGV */
+	TRACE_IRQS_ON
+	ENABLE_INTERRUPTS(CLBR_NONE)
+	jmp do_exit
+	.previous
 ENDPROC(native_iret)
 
-ENTRY(native_irq_enable_sysexit)
-	sti
+ENTRY(native_sysret)
 	sysretq
-ENDPROC(native_irq_enable_sysexit)
+ENDPROC(native_sysret)
 
 #endif /* CONFIG_PARAVIRT */
 
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/head64.c linux-2.6.19-paravirt1/arch/x86_64/kernel/head64.c
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/head64.c	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/head64.c	2007-01-09 18:13:19.000000000 -0200
@@ -62,7 +62,7 @@ void __init x86_64_start_kernel(char * r
 
 	for (i = 0; i < IDT_ENTRIES; i++)
 		set_intr_gate(i, early_idt_handler);
-	asm volatile("lidt %0" :: "m" (idt_descr));
+	load_idt((const struct desc_struct *)&idt_descr);
 
 	early_printk("Kernel alive\n");
 
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/head.S linux-2.6.19-paravirt1/arch/x86_64/kernel/head.S
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/head.S	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/head.S	2007-01-11 22:42:33.000000000 -0200
@@ -16,6 +16,13 @@
 #include <asm/page.h>
 #include <asm/msr.h>
 #include <asm/cache.h>
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/asm-offsets.h>
+#include <asm/paravirt.h>
+#else
+#define GET_CR2_INTO_RAX mov %cr2, %rax
+#endif
 	
 /* we are not able to switch in one step to the final KERNEL ADRESS SPACE
  * because we need identity-mapped pages on setup so define __START_KERNEL to
@@ -106,6 +113,14 @@ startup_64:
 	 * reload the page tables here.
 	 */
 
+#ifdef CONFIG_PARAVIRT
+	/* a CS ended in 0x3 indicates we're in userspace. That's where
+	 * our paravirt guests run. */
+	movq	%cs, %rax
+	testq	$0x3, %rax
+	jnz	startup_paravirt
+#endif
+
 	/* Enable PAE mode and PGE */
 	xorq	%rax, %rax
 	btsq	$5, %rax
@@ -208,10 +223,11 @@ ENTRY(early_idt_handler)
 	cmpl $2,early_recursion_flag(%rip)
 	jz  1f
 	incl early_recursion_flag(%rip)
-	xorl %eax,%eax
 	movq 8(%rsp),%rsi	# get rip
 	movq (%rsp),%rdx
-	movq %cr2,%rcx
+	GET_CR2_INTO_RAX
+	movq %rax,%rcx
+	xorq %rax, %rax
 	leaq early_idt_msg(%rip),%rdi
 	call early_printk
 	cmpl $2,early_recursion_flag(%rip)
@@ -232,6 +248,47 @@ early_idt_msg:
 early_idt_ripmsg:
 	.asciz "RIP %s\n"
 
+#ifdef CONFIG_PARAVIRT
+ENTRY(startup_paravirt)
+	cld
+
+	/* initial stack location */
+ 	movq $(init_thread_union+THREAD_SIZE),%rsp
+
+	/* We take pains to preserve all the regs. */
+	pushq	%r11
+	pushq	%r10
+	pushq	%r9
+	pushq	%r8
+	pushq	%rsi
+	pushq	%rdi
+	pushq	%rdx
+	pushq	%rcx
+	pushq	%rax
+
+	/* paravirt.o is last in link, and that probe fn never returns */
+	pushq	$__start_paravirtprobe
+1:
+	movq	0(%rsp), %rax
+	pushq	(%rax)
+	movq	8(%rsp), %rdi
+	call	*(%rsp)
+	popq	%rax
+
+	movq	0x10(%rsp), %rax
+	movq	0x18(%rsp), %rcx
+	movq	0x20(%rsp), %rdx
+	movq	0x28(%rsp), %rdi
+	movq	0x30(%rsp), %rsi
+	movq	0x38(%rsp), %r8
+	movq	0x40(%rsp), %r9
+	movq	0x48(%rsp), %r10
+	movq	0x50(%rsp), %r11
+
+	addl	$8, (%rsp)
+	jmp	1b
+#endif
+
 .code32
 ENTRY(no_long_mode)
 	/* This isn't an x86-64 CPU so hang */
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/paravirt.c linux-2.6.19-paravirt1/arch/x86_64/kernel/paravirt.c
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/paravirt.c	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/paravirt.c	2007-01-11 20:10:06.000000000 -0200
@@ -1,6 +1,6 @@
 /*  Paravirtualization interfaces
     Copyright (C) 2007 Glauber de Oliveira Costa, Red Hat Inc.
-    Based on i386 work by Rusty Russel.
+    Based on i386 work by Rusty Russell.
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -59,11 +59,14 @@ void memory_setup(void)
 	asm("start_" #name ": " code "; end_" #name ":")
 DEF_NATIVE(cli, "cli");
 DEF_NATIVE(sti, "sti");
-DEF_NATIVE(popfq, "pushq %rax; popfq");
+/* We push rdi , and pop in rda. This is due to x86_64 calling conventions
+ * Recall that we are patching a function call */
+DEF_NATIVE(popfq, "pushq %rdi; popfq");
 DEF_NATIVE(pushfq, "pushfq; popq %rax");
 DEF_NATIVE(pushfq_cli, "pushfq; popq %rax; cli");
-DEF_NATIVE(iret, "iret");
-DEF_NATIVE(sti_sysretq, "sti; sysretq");
+DEF_NATIVE(iret, "iretq");
+DEF_NATIVE(sysretq, "sysretq");
+DEF_NATIVE(swapgs, "swapgs");
 
 static const struct native_insns
 {
@@ -75,7 +78,8 @@ static const struct native_insns
 	[PARAVIRT_SAVE_FLAGS] = { start_pushfq, end_pushfq },
 	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] = { start_pushfq_cli, end_pushfq_cli },
 	[PARAVIRT_INTERRUPT_RETURN] = { start_iret, end_iret },
-	[PARAVIRT_STI_SYSRETQ] = { start_sti_sysretq, end_sti_sysretq },
+	[PARAVIRT_SYSRETQ] = { start_sysretq, end_sysretq },
+	[PARAVIRT_SWAPGS] = { start_swapgs, end_swapgs },
 };
 
 static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned len)
@@ -88,7 +92,6 @@ static unsigned native_patch(u8 type, u1
 
 	insn_len = native_insns[type].end - native_insns[type].start;
 
-
 	/* Similarly if we can't fit replacement. */
 	if (len < insn_len)
 		return len;
@@ -243,7 +246,7 @@ static void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-static unsigned long native_read_msr(unsigned int msr, int *err)
+static u64 native_read_msr(unsigned int msr, int *err)
 {
 	unsigned long val;
 
@@ -287,6 +290,13 @@ static u64 native_read_tsc(void)
 	return val;
 }
 
+static u64 native_read_tscp(int *aux)
+{
+	u64 val;
+	asm volatile ("rdtscp" : "=A" (val), "=c" (aux));
+	return val;
+}
+
 static u64 native_read_pmc(void)
 {
 	unsigned long val;
@@ -463,7 +473,8 @@ void native_pmd_clear(pmd_t *pmd)
 
 /* These are in entry.S */
 extern void native_iret(void);
-extern void native_irq_enable_sysexit(void);
+extern void native_sysret(void);
+extern void native_swapgs(void);
 
 static int __init print_banner(void)
 {
@@ -475,12 +486,18 @@ core_initcall(print_banner);
 /* We simply declare start_kernel to be the paravirt probe of last resort. */
 paravirt_probe(start_kernel);
 
+extern unsigned long __vsyscall_0;
 struct paravirt_ops paravirt_ops = {
 	.name = "bare hardware",
 	.paravirt_enabled = 0,
 	.kernel_rpl = 0,
 	.pgd_alignment = sizeof(pgd_t) * PTRS_PER_PGD,
 
+	.swapgs = {
+		.ret = 0,
+		.fn = native_swapgs,
+	 },
+	.vsyscall_page = &__vsyscall_0,
  	.patch = native_patch,
 	.banner = default_banner,
 	.arch_setup = native_nop,
@@ -512,6 +529,7 @@ struct paravirt_ops paravirt_ops = {
 	.read_msr = native_read_msr,
 	.write_msr = native_write_msr,
 	.read_tsc = native_read_tsc,
+	.read_tscp = native_read_tscp,
 	.read_pmc = native_read_pmc,
 	.load_tr_desc = native_load_tr_desc,
 	.set_ldt = native_set_ldt,
@@ -571,7 +589,7 @@ struct paravirt_ops paravirt_ops = {
 	.make_pud = native_make_pud,
 	.make_pgd = native_make_pgd,
 
-	.irq_enable_sysexit = native_irq_enable_sysexit,
+	.sysret = native_sysret,
 	.iret = native_iret,
 
 	.dup_mmap = (void *)native_nop,
@@ -580,4 +598,5 @@ struct paravirt_ops paravirt_ops = {
 
 	.startup_ipi_hook = (void *)native_nop,
 };
+
 EXPORT_SYMBOL(paravirt_ops);
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/setup64.c linux-2.6.19-paravirt1/arch/x86_64/kernel/setup64.c
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/setup64.c	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/setup64.c	2007-01-09 10:24:25.000000000 -0200
@@ -123,7 +123,7 @@ void pda_init(int cpu)
 	asm volatile("movl %0,%%fs ; movl %0,%%gs" :: "r" (0)); 
 	/* Memory clobbers used to order PDA accessed */
 	mb();
-	wrmsrl(MSR_GS_BASE, pda);
+	wrmsrl(MSR_GS_BASE, (u64)pda);
 	mb();
 
 	pda->cpunumber = cpu; 
@@ -160,7 +160,7 @@ void syscall_init(void)
 	 * but only a 32bit target. LSTAR sets the 64bit rip. 	 
 	 */ 
 	wrmsrl(MSR_STAR,  ((u64)__USER32_CS)<<48  | ((u64)__KERNEL_CS)<<32); 
-	wrmsrl(MSR_LSTAR, system_call); 
+	wrmsrl(MSR_LSTAR, (u64)system_call); 
 
 #ifdef CONFIG_IA32_EMULATION   		
 	syscall32_cpu_init ();
@@ -223,8 +223,8 @@ void __cpuinit cpu_init (void)
  		memcpy(cpu_gdt(cpu), cpu_gdt_table, GDT_SIZE);
 
 	cpu_gdt_descr[cpu].size = GDT_SIZE;
-	asm volatile("lgdt %0" :: "m" (cpu_gdt_descr[cpu]));
-	asm volatile("lidt %0" :: "m" (idt_descr));
+	load_gdt((const struct desc_struct *)&cpu_gdt_descr[cpu]);
+	load_idt((const struct desc_struct *)&idt_descr);
 
 	memset(me->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
 	syscall_init();
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/setup.c linux-2.6.19-paravirt1/arch/x86_64/kernel/setup.c
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/setup.c	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/setup.c	2007-01-09 10:22:24.000000000 -0200
@@ -341,6 +341,12 @@ static void discover_ebda(void)
 		ebda_size = 64*1024;
 }
 
+/* Overridden in paravirt.c if CONFIG_PARAVIRT */
+void __attribute__((weak)) memory_setup(void)
+{
+       return setup_memory_region();
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	printk(KERN_INFO "Command line: %s\n", saved_command_line);
@@ -561,12 +567,6 @@ static int __cpuinit get_model_name(stru
 	return 1;
 }
 
-/* Overridden in paravirt.c if CONFIG_PARAVIRT */
-void __attribute__((weak)) memory_setup(void)
-{
-       return setup_memory_region();
-}
-
 static void __cpuinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, eax, ebx, ecx, edx;
diff -urp linux-2.6.19-paravirt0/arch/x86_64/kernel/vsyscall.c linux-2.6.19-paravirt1/arch/x86_64/kernel/vsyscall.c
--- linux-2.6.19-paravirt0/arch/x86_64/kernel/vsyscall.c	2007-01-11 21:51:35.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/kernel/vsyscall.c	2007-01-10 06:57:22.000000000 -0200
@@ -73,7 +73,7 @@ static __always_inline void do_vgettimeo
 		usec = __xtime.tv_nsec / 1000;
 
 		if (__vxtime.mode != VXTIME_HPET) {
-			t = get_cycles_sync();
+			t = vget_cycles_sync();
 			if (t < __vxtime.last_tsc)
 				t = __vxtime.last_tsc;
 			usec += ((t - __vxtime.last_tsc) *
@@ -147,8 +147,8 @@ time_t __vsyscall(1) vtime(time_t *t)
 long __vsyscall(2)
 vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
 {
-	unsigned int dummy, p;
-	unsigned long j = 0;
+	unsigned int p;
+	unsigned long dummy, j = 0;
 
 	/* Fast cache - only recompute value once per jiffies and avoid
 	   relatively costly rdtscp/cpuid otherwise.
@@ -162,7 +162,8 @@ vgetcpu(unsigned *cpu, unsigned *node, s
 		p = tcache->blob[1];
 	} else if (__vgetcpu_mode == VGETCPU_RDTSCP) {
 		/* Load per CPU data from RDTSCP */
-		rdtscp(dummy, dummy, p);
+		/* rdtscp() cannot be called due to the paravirt indirection */
+		asm("rdtscp" : "=A" (dummy), "=c" (p));
 	} else {
 		/* Load per CPU data from GDT */
 		asm("lsl %1,%0" : "=r" (p) : "r" (__PER_CPU_SEG));
@@ -257,7 +258,11 @@ static void __cpuinit vsyscall_set_cpu(i
 	node = cpu_to_node[cpu];
 #endif
 	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP))
-		write_rdtscp_aux((node << 12) | cpu);
+		/* This is write_rdtscp_aux. It cannot be called directly
+		 * due to the paravirt indirection */
+		asm("wrmsr"  :  /* no output */
+			     :  "d"(0),
+				"a" ((node << 12) | cpu), "c" (0xc0000103));
 
 	/* Store cpu number in limit so that it can be loaded quickly
 	   in user space in vgetcpu.
@@ -286,8 +291,12 @@ cpu_vsyscall_notifier(struct notifier_bl
 
 static void __init map_vsyscall(void)
 {
+#ifndef CONFIG_PARAVIRT
 	extern char __vsyscall_0;
 	unsigned long physaddr_page0 = __pa_symbol(&__vsyscall_0);
+#else
+	unsigned long physaddr_page0 = __pa_symbol(paravirt_ops.vsyscall_page);
+#endif
 
 	/* Note that VSYSCALL_MAPPED_PAGES must agree with the code below. */
 	__set_fixmap(VSYSCALL_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
@@ -300,7 +309,14 @@ static int __init vsyscall_init(void)
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	BUG_ON((unsigned long) &vgetcpu != VSYSCALL_ADDR(__NR_vgetcpu));
-	map_vsyscall();
+#ifdef CONFIG_PARAVIRT
+	if (paravirt_ops.vsyscall_page)
+#endif
+		map_vsyscall();
+#ifdef CONFIG_PARAVIRT
+	else
+		__sysctl_vsyscall = 0;
+#endif
 #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
diff -urp linux-2.6.19-paravirt0/arch/x86_64/mm/pageattr.c linux-2.6.19-paravirt1/arch/x86_64/mm/pageattr.c
--- linux-2.6.19-paravirt0/arch/x86_64/mm/pageattr.c	2007-01-11 21:51:35.000000000 -0200
+++ linux-2.6.19-paravirt1/arch/x86_64/mm/pageattr.c	2007-01-09 18:02:50.000000000 -0200
@@ -81,7 +81,7 @@ static void flush_kernel_map(void *arg)
 		void *adr = page_address(pg);
 		if (cpu_has_clflush)
 			cache_flush_page(adr);
-		__flush_tlb_one(adr);
+		__flush_tlb_one((u64)adr);
 	}
 }
 
diff -urp linux-2.6.19-paravirt0/include/asm-x86_64/alternative.h linux-2.6.19-paravirt1/include/asm-x86_64/alternative.h
--- linux-2.6.19-paravirt0/include/asm-x86_64/alternative.h	2007-01-11 21:51:36.000000000 -0200
+++ linux-2.6.19-paravirt1/include/asm-x86_64/alternative.h	2007-01-08 06:53:56.000000000 -0200
@@ -134,8 +134,10 @@ static inline void alternatives_smp_swit
 #define LOCK_PREFIX ""
 #endif
 
-struct paravirt_patch;
+
+
 #ifdef CONFIG_PARAVIRT
+struct paravirt_patch;
 void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end);
 #else
 static inline void
@@ -145,4 +147,5 @@ apply_paravirt(struct paravirt_patch *st
 #define __stop_parainstructions NULL
 #endif
 
+
 #endif /* _X86_64_ALTERNATIVE_H */
diff -urp linux-2.6.19-paravirt0/include/asm-x86_64/irqflags.h linux-2.6.19-paravirt1/include/asm-x86_64/irqflags.h
--- linux-2.6.19-paravirt0/include/asm-x86_64/irqflags.h	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/include/asm-x86_64/irqflags.h	2007-01-09 17:55:54.000000000 -0200
@@ -18,7 +18,6 @@ static inline int raw_irqs_disabled_flag
 {
 	return !(flags & (1 << 9));
 }
-
 #else
 
 /*
diff -urp linux-2.6.19-paravirt0/include/asm-x86_64/msr.h linux-2.6.19-paravirt1/include/asm-x86_64/msr.h
--- linux-2.6.19-paravirt0/include/asm-x86_64/msr.h	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/include/asm-x86_64/msr.h	2007-01-09 18:12:03.000000000 -0200
@@ -105,15 +105,6 @@ static inline void native_cpuid(unsigned
 
 #endif /* CONFIG_PARAVIRT */
 
-#define rdtscp(low,high,aux) \
-     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (low), "=d" (high), "=c" (aux))
-
-#define rdtscpll(val, aux) do { \
-     unsigned long __a, __d; \
-     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (__a), "=d" (__d), "=c" (aux)); \
-     (val) = (__d << 32) | __a; \
-} while (0)
-
 #define checking_wrmsrl(msr,val) wrmsr_safe(msr,(u32)(val),(u32)((val)>>32))
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
@@ -125,6 +116,7 @@ static inline void cpuid(unsigned int op
 	*eax = op;
 	__cpuid(eax, ebx, ecx, edx);
 }
+
 /* Some CPUID calls want 'count' to be placed in ecx */
 static inline void cpuid_count(int op, int count,
 			 int *eax, int *ebx, int *ecx, int *edx)
@@ -140,24 +132,28 @@ static inline void cpuid_count(int op, i
 static inline unsigned int cpuid_eax(unsigned int op)
 {
 	unsigned int eax, ebx, ecx, edx;
+	eax = op;
 	__cpuid(&eax, &ebx, &ecx, &edx);
 	return eax;
 }
 static inline unsigned int cpuid_ebx(unsigned int op)
 {
 	unsigned int eax, ebx, ecx, edx;
+	eax = op;
 	__cpuid(&eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 static inline unsigned int cpuid_ecx(unsigned int op)
 {
 	unsigned int eax, ebx, ecx, edx;
+	eax = op;
 	__cpuid(&eax, &ebx, &ecx, &edx);
 	return ecx;
 }
 static inline unsigned int cpuid_edx(unsigned int op)
 {
 	unsigned int eax, ebx, ecx, edx;
+	eax = op;
 	__cpuid(&eax, &ebx, &ecx, &edx);
 	return edx;
 }
diff -urp linux-2.6.19-paravirt0/include/asm-x86_64/paravirt.h linux-2.6.19-paravirt1/include/asm-x86_64/paravirt.h
--- linux-2.6.19-paravirt0/include/asm-x86_64/paravirt.h	2007-01-11 21:56:03.000000000 -0200
+++ linux-2.6.19-paravirt1/include/asm-x86_64/paravirt.h	2007-01-11 22:50:41.000000000 -0200
@@ -17,7 +17,8 @@
 #define PARAVIRT_SAVE_FLAGS 3
 #define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
 #define PARAVIRT_INTERRUPT_RETURN 5
-#define PARAVIRT_STI_SYSRETQ 6
+#define PARAVIRT_SYSRETQ 6
+#define PARAVIRT_SWAPGS	7
 
 /* Bitmask of what can be clobbered: usually at least rax. */
 #define CLBR_NONE 0x0
@@ -34,6 +35,11 @@ struct desc_struct;
 struct tss_struct;
 struct mm_struct;
 
+struct swapgs {
+	u64 ret;
+	void (*fn)(void);
+};
+
 struct paravirt_ops
 {
 	int paravirt_enabled;
@@ -43,6 +49,9 @@ struct paravirt_ops
 
 	const char *name;
 
+	unsigned long *vsyscall_page;
+
+	struct swapgs swapgs;
 	/*
 	 * Patch may replace one of the defined code sequences with arbitrary
 	 * code, subject to the same register constraints.  This generally
@@ -89,6 +98,7 @@ struct paravirt_ops
 	void (*restore_fl)(unsigned long);
 	void (*irq_disable)(void);
 	void (*irq_enable)(void);
+
 	void (*safe_halt)(void);
 	void (*halt)(void);
 	void (*wbinvd)(void);
@@ -98,6 +108,7 @@ struct paravirt_ops
 	int (*write_msr)(unsigned int msr, u64 val);
 
 	u64 (*read_tsc)(void);
+	u64 (*read_tscp)(int *aux);
 	u64 (*read_pmc)(void);
 
 	void (*load_tr_desc)(void);
@@ -167,7 +178,7 @@ struct paravirt_ops
 	void (*set_lazy_mode)(int mode);
 
 	/* These two are jmp to, not actually called. */
-	void (*irq_enable_sysexit)(void);
+	void (*sysret)(void);
 	void (*iret)(void);
 
 	void (*startup_ipi_hook)(int phys_apicid, unsigned long start_eip, unsigned long start_esp);
@@ -262,6 +273,14 @@ static inline void halt(void)
 	val2 = _l >> 32;					\
 } while(0)
 
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr,a,b) ({					\
+	int _err;						\
+	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	(*a) = (u32)_l;						\
+	(*b) = _l >> 32;					\
+	_err; })
+
 #define wrmsr(msr,val1,val2) do {				\
 	u64 _l = ((u64)(val2) << 32) | (val1);			\
 	paravirt_ops.write_msr((msr), _l);			\
@@ -273,19 +292,12 @@ static inline void halt(void)
 } while(0)
 
 #define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+
 #define wrmsr_safe(msr,a,b) ({					\
 	u64 _l = ((u64)(b) << 32) | (a);			\
 	paravirt_ops.write_msr((msr),_l);			\
 })
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr,a,b) ({					\
-	int _err;						\
-	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
-	(*a) = (u32)_l;						\
-	(*b) = _l >> 32;					\
-	_err; })
-
 #define rdtsc(low,high) do {					\
 	u64 _l = paravirt_ops.read_tsc();			\
 	low = (u32)_l;						\
@@ -299,6 +311,14 @@ static inline void halt(void)
 
 #define rdtscll(val) (val = paravirt_ops.read_tsc())
 
+#define rdtscp(low,high,aux) do {				\
+	u64 _val = paravirt_ops.read_tscp(&aux);		\
+	low = (int)_val;					\
+	high = _val >> 32;					\
+} while (0)
+
+#define rdtscpll(val, aux) (val) = paravirt_ops.read_tscp(&aux)
+
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define rdpmc(counter,low,high) do {				\
@@ -375,7 +395,6 @@ void native_pte_clear(struct mm_struct *
 void native_pmd_clear(pmd_t *pmd);
 void native_nop(void);
 
-
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
@@ -483,6 +502,9 @@ struct paravirt_patch {
 	"  .short " __stringify(clobber) "\n"		\
 	".popsection"
 
+/* These functions tends to be very simple. So, if they touch any register,
+ * the calle-saved ones may already fulfill their needs, and hopefully we
+ * have no need to save any. */
 static inline unsigned long __raw_local_save_flags(void)
 {
 	unsigned long f;
@@ -533,18 +555,12 @@ static inline unsigned long __raw_local_
 	return f;
 }
 
+#define CLI_STRING paravirt_alt("call *paravirt_ops+%c[irq_disable];",	\
+		     PARAVIRT_IRQ_DISABLE, CLBR_NONE)
 
+#define STI_STRING paravirt_alt("call *paravirt_ops+%c[irq_enable];",	\
+		     PARAVIRT_IRQ_ENABLE, CLBR_NONE)
 
-/* Still x86-ish */
-#define CLI_STRING paravirt_alt("pushq %%rcx; pushq %%rdx;"		\
-		     "call *paravirt_ops+%c[irq_disable];"		\
-		     "popq %%rdx; popq %%rcx",				\
-		     PARAVIRT_IRQ_DISABLE, CLBR_RAX)
-
-#define STI_STRING paravirt_alt("pushq %%rcx; pushq %%rdx;"		\
-		     "call *paravirt_ops+%c[irq_enable];"		\
-		     "popq %%rdx; popq %%rcx",				\
-		     PARAVIRT_IRQ_ENABLE, CLBR_RAX)
 #define CLI_STI_CLOBBERS , "%rax"
 #define CLI_STI_INPUT_ARGS \
 	,								\
@@ -571,22 +587,23 @@ static inline unsigned long __raw_local_
 
 #define DISABLE_INTERRUPTS(clobbers)			\
 	PARA_PATCH(PARAVIRT_IRQ_DISABLE, clobbers,	\
-	pushq %rcx; pushq %rdx;				\
-	call *paravirt_ops+PARAVIRT_irq_disable;	\
-	popq %rdx; popq %rcx)				\
+	call *paravirt_ops+PARAVIRT_irq_disable)
 
 #define ENABLE_INTERRUPTS(clobbers)			\
 	PARA_PATCH(PARAVIRT_IRQ_ENABLE, clobbers,	\
-	pushq %rcx; pushq %rdx;				\
-	call *%cs:paravirt_ops+PARAVIRT_irq_enable;	\
-	popq %rdx; popq %rcx)
-
-#define ENABLE_INTERRUPTS_SYSRETQ			\
-	PARA_PATCH(PARAVIRT_STI_SYSRETQ, CLBR_ANY,	\
-	jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit)
+	call *%cs:paravirt_ops+PARAVIRT_irq_enable)
 
-#define GET_CR0_INTO_RAX			\
-	call *paravirt_ops+PARAVIRT_read_cr0
+#define SYSRETQ						\
+	PARA_PATCH(PARAVIRT_SYSRETQ, CLBR_ANY,		\
+	jmp *%cs:paravirt_ops+PARAVIRT_sysret)
+
+#define SWAPGS						\
+	movq $. + 0x11, (paravirt_ops+PARAVIRT_swapgs);	\
+	jmp  (paravirt_ops+PARAVIRT_swapgs+8);		\
+
+/* this is needed in early_idt_handler */
+#define GET_CR2_INTO_RAX 				\
+	call *paravirt_ops+PARAVIRT_read_cr2
 
 #endif /* __ASSEMBLY__ */
 #else  /* !CONFIG_PARAVIRT */
diff -urp linux-2.6.19-paravirt0/include/asm-x86_64/timex.h linux-2.6.19-paravirt1/include/asm-x86_64/timex.h
--- linux-2.6.19-paravirt0/include/asm-x86_64/timex.h	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19-paravirt1/include/asm-x86_64/timex.h	2007-01-10 15:10:00.000000000 -0200
@@ -31,14 +31,29 @@ static __always_inline cycles_t get_cycl
 {
 	unsigned long long ret;
 	unsigned eax;
+	unsigned int (*fn)(unsigned int) = &cpuid_eax;
 	/* Don't do an additional sync on CPUs where we know
 	   RDTSC is already synchronous. */
-	alternative_io("cpuid", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
-			  "=a" (eax), "0" (1) : "ebx","ecx","edx","memory");
+	alternative_io("call *%3", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
+			"=a" (eax) , "D" (1) , "m" (fn));
 	rdtscll(ret);
 	return ret;
 }
 
+/* Inside a vsyscall, we cannot call paravirt functions. (like rdtsc
+ * and cpuid). For the host, use this function instead */
+static __always_inline cycles_t vget_cycles_sync(void)
+{
+	unsigned long ret;
+	unsigned eax;
+	/* Don't do an additional sync on CPUs where we know
+	   RDTSC is already synchronous. */
+	alternative_io("cpuid", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
+			  "=a" (eax), "0" (1) : "ebx","ecx","edx","memory");
+
+	asm volatile("rdtsc" : "=A" (ret));
+	return ret;
+}
 extern unsigned int cpu_khz;
 
 extern int read_current_timer(unsigned long *timer_value);

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--YZ5djTAD1cGYuMQK--
