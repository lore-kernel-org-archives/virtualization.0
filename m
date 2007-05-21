From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: changing definition of paravirt_ops.iret
Date: Mon, 21 May 2007 17:27:17 +0100
Message-ID: <4651C865.9090605@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I'm implementing a more efficient version of the Xen iret paravirt_op,
so that it can use the real iret instruction where possible.  I really
need to get access to per-cpu variables, so I can set the event mask
state in the vcpu_info structure, but unfortunately at the point where
INTERRUPT_RETURN is used in entry.S, the usermode %fs has already been
restored.

How would you feel if we changed paravirt_ops.iret to make it also
responsible for restoring %fs? 

In other words, change RESTORE_REGS to skip %fs, and then native_iret
would look like:

1:	popl %fs
	iret

with the normal exception stuff.  Fortunately, %fs is already the first
thing to be saved and last to be restored, so there's no major
rearrangements.

Ideally I'd also like a register to play with, but that would require
rearranging pt_regs, which is a bit tricky.

Also, INTERRUPT_RETURN already has a bug, in which it needs to deal with
its own iret exceptions.

    J

diff -r e13ec2ed67aa arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon May 21 16:56:20 2007 +0100
+++ b/arch/i386/kernel/entry.S	Mon May 21 17:21:37 2007 +0100
@@ -59,6 +59,9 @@
  *   INTERRUPT_RETURN (aka. "iret")
  *   GET_CR0_INTO_EAX (aka. "movl %cr0, %eax")
  *   ENABLE_INTERRUPTS_SYSEXIT (aka "sti; sysexit").
+ *
+ * INTERRUPT_RETURN is responsible for restoring the usermode %fs
+ * from the stack.
  *
  * For DISABLE_INTERRUPTS/ENABLE_INTERRUPTS (aka "cli"/"sti"), you must
  * specify what registers can be overwritten (CLBR_NONE, CLBR_EAX/EDX/ECX/ANY).
@@ -166,21 +169,15 @@ 2:	popl %es;	\
 2:	popl %es;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
 	/*CFI_RESTORE es;*/\
-3:	popl %fs;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	/*CFI_RESTORE fs;*/\
 .pushsection .fixup,"ax";	\
 4:	movl $0,(%esp);	\
 	jmp 1b;		\
 5:	movl $0,(%esp);	\
 	jmp 2b;		\
-6:	movl $0,(%esp);	\
-	jmp 3b;		\
 .section __ex_table,"a";\
 	.align 4;	\
 	.long 1b,4b;	\
 	.long 2b,5b;	\
-	.long 3b,6b;	\
 .popsection
 
 #define RING0_INT_FRAME \
@@ -406,19 +403,14 @@ restore_nocheck_notrace:
 	RESTORE_REGS
 	addl $4, %esp			# skip orig_eax/error_code
 	CFI_ADJUST_CFA_OFFSET -4
-1:	INTERRUPT_RETURN
-.section .fixup,"ax"
+	INTERRUPT_RETURN
+
 iret_exc:
 	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
-.previous
-.section __ex_table,"a"
-	.align 4
-	.long 1b,iret_exc
-.previous
 
 	CFI_RESTORE_STATE
 ldt_ss:
@@ -863,21 +855,22 @@ nmi_espfix_stack:
 	RESTORE_REGS
 	lss 12+4(%esp), %esp		# back to espfix stack
 	CFI_ADJUST_CFA_OFFSET -24
-1:	INTERRUPT_RETURN
-	CFI_ENDPROC
+	INTERRUPT_RETURN
+	CFI_ENDPROC
+KPROBE_END(nmi)
+
+#ifdef CONFIG_PARAVIRT
+ENTRY(native_iret)
+1:	popl %fs
+2:	iret
+.pushsection .fixup,"ax"
+3:	movl $0,(%esp)
+	jmp 1b
 .section __ex_table,"a"
 	.align 4
-	.long 1b,iret_exc
-.previous
-KPROBE_END(nmi)
-
-#ifdef CONFIG_PARAVIRT
-ENTRY(native_iret)
-1:	iret
-.section __ex_table,"a"
-	.align 4
-	.long 1b,iret_exc
-.previous
+	.long 1b,3b
+	.long 2b,iret_exc
+.popsection
 END(native_iret)
 
 ENTRY(native_irq_enable_sysexit)
diff -r e13ec2ed67aa arch/i386/xen/enlighten.c
--- a/arch/i386/xen/enlighten.c	Mon May 21 16:56:20 2007 +0100
+++ b/arch/i386/xen/enlighten.c	Mon May 21 17:21:37 2007 +0100
@@ -851,7 +851,6 @@ static unsigned xen_patch(u8 type, u16 c
 		SITE(irq_disable);
 		SITE(save_fl);
 		SITE(restore_fl);
-		SITE(iret);
 #undef SITE
 
 	patch_site:
@@ -935,7 +934,7 @@ static const struct paravirt_ops xen_par
 	.read_tsc = native_read_tsc,
 	.read_pmc = native_read_pmc,
 
-	.iret = (void *)&hypercall_page[__HYPERVISOR_iret],
+	.iret = xen_iret,
 	.irq_enable_sysexit = NULL,  /* never called */
 
 	.load_tr_desc = paravirt_nop,
diff -r e13ec2ed67aa include/asm-i386/irqflags.h
--- a/include/asm-i386/irqflags.h	Mon May 21 16:56:20 2007 +0100
+++ b/include/asm-i386/irqflags.h	Mon May 21 17:21:37 2007 +0100
@@ -106,7 +106,18 @@ static inline unsigned long __raw_local_
 #define DISABLE_INTERRUPTS(clobbers)	cli
 #define ENABLE_INTERRUPTS(clobbers)	sti
 #define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
-#define INTERRUPT_RETURN		iret
+#define INTERRUPT_RETURN				\
+1:	popl %fs;					\
+2:	iret;						\
+.pushsection .fixup,"ax";				\
+3:	movl $0,(%esp);					\
+	jmp 1b;						\
+.section __ex_table,"a";				\
+	.align 4;					\
+	.long 1b,3b;					\
+	.long 2b,iret_exc;				\
+.popsection
+
 #define GET_CR0_INTO_EAX		movl %cr0, %eax
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT */
