From: Zachary Amsden <zach@vmware.com>
Subject: Patch: use .pushsection/.popsection
Date: Tue, 08 Aug 2006 23:02:10 -0700
Message-ID: <44D97A62.9020106@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020701060400010207030401"
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
To: Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------020701060400010207030401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I think this might fix the X bug...

--------------020701060400010207030401
Content-Type: text/plain;
 name="use-push-popsection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use-push-popsection.patch"

diff -r e698e6ee2fa1 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Tue Aug 08 10:18:34 2006 -0700
+++ b/arch/i386/kernel/entry.S	Tue Aug 08 10:36:17 2006 -0700
@@ -162,17 +162,17 @@ 2:	popl %es;	\
 2:	popl %es;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
 	/*CFI_RESTORE es;*/\
-.section .fixup,"ax";	\
+.pushsection .fixup,"ax";	\
 3:	movl $0,(%esp);	\
 	jmp 1b;		\
 4:	movl $0,(%esp);	\
 	jmp 2b;		\
-.previous;		\
-.section __ex_table,"a";\
+.popsection		\
+.pushsection __ex_table,"a";\
 	.align 4;	\
 	.long 1b,3b;	\
 	.long 2b,4b;	\
-.previous
+.popsection
 
 #define RING0_INT_FRAME \
 	CFI_STARTPROC simple;\
@@ -300,10 +300,10 @@ sysenter_past_esp:
 	cmpl $__PAGE_OFFSET-3,%ebp
 	jae syscall_fault
 1:	movl (%ebp),%ebp
-.section __ex_table,"a"
+.pushsection __ex_table,"a"
 	.align 4
 	.long 1b,syscall_fault
-.previous
+.popsection
 
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
@@ -378,18 +378,18 @@ restore_nocheck_notrace:
 	addl $4, %esp
 	CFI_ADJUST_CFA_OFFSET -4
 1:	INTERRUPT_RETURN
-.section .fixup,"ax"
+.pushsection .fixup,"ax"
 iret_exc:
 	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
-.previous
-.section __ex_table,"a"
+.popsection
+.pushsection __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
-.previous
+.popsection
 
 	CFI_RESTORE_STATE
 ldt_ss:
@@ -415,11 +415,11 @@ ldt_ss:
 	TRACE_IRQS_IRET
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
-1:	INTERRUPT_RETURN
-.section __ex_table,"a"
+1:	iret
+.pushsection __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
-.previous
+.popsection
 	CFI_ENDPROC
 
 	# perform work that needs to be done immediately before resumption
@@ -525,14 +525,14 @@ syscall_badsys:
 	je 28f; \
 27:	popl %eax; \
 	CFI_ADJUST_CFA_OFFSET -4; \
-.section .fixup,"ax"; \
+.pushsection .fixup,"ax"; \
 28:	movl $__KERNEL_DS, %eax; \
 	movl %eax, %ds; \
 	movl %eax, %es; \
 	/* switch to 32bit stack */ \
 	FIXUP_ESPFIX_STACK; \
 	jmp 27b; \
-.previous
+.popsection
 
 /*
  * Build the entry stubs and pointer table with
@@ -639,7 +639,7 @@ error_code:
 	call *%edi
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+KPROBE_EXIT
 
 ENTRY(coprocessor_error)
 	RING0_INT_FRAME
@@ -715,7 +715,7 @@ debug_stack_correct:
 	call do_debug
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+KPROBE_EXIT
 
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -795,12 +795,12 @@ nmi_16bit_stack:
 	call do_nmi
 	RESTORE_REGS
 	lss 12+4(%esp), %esp		# back to 16bit stack
-1:	INTERRUPT_RETURN
-	CFI_ENDPROC
-.section __ex_table,"a"
+1:	iret
+	CFI_ENDPROC
+.pushsection __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
-.previous
+.popsection
 
 #ifdef CONFIG_PARAVIRT
 ENTRY(nopara_iret)
@@ -821,7 +821,7 @@ KPROBE_ENTRY(int3)
 	call do_int3
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+KPROBE_EXIT
 
 ENTRY(overflow)
 	RING0_INT_FRAME
@@ -886,7 +886,7 @@ KPROBE_ENTRY(general_protection)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
-.previous
+KPROBE_EXIT
 
 ENTRY(alignment_check)
 	RING0_EC_FRAME
diff -r e698e6ee2fa1 include/asm-i386/alternative-asm.i
--- a/include/asm-i386/alternative-asm.i	Tue Aug 08 10:18:34 2006 -0700
+++ b/include/asm-i386/alternative-asm.i	Tue Aug 08 10:33:13 2006 -0700
@@ -3,10 +3,10 @@
 #ifdef CONFIG_SMP
 	.macro LOCK_PREFIX
 1:	lock
-	.section .smp_locks,"a"
+	.pushsection .smp_locks,"a"
 	.align 4
 	.long 1b
-	.previous
+	.popsection
 	.endm
 #else
 	.macro LOCK_PREFIX
diff -r e698e6ee2fa1 include/linux/linkage.h
--- a/include/linux/linkage.h	Tue Aug 08 10:18:34 2006 -0700
+++ b/include/linux/linkage.h	Tue Aug 08 10:35:55 2006 -0700
@@ -35,8 +35,11 @@
 #endif
 
 #define KPROBE_ENTRY(name) \
-  .section .kprobes.text, "ax"; \
+  .pushsection .kprobes.text, "ax"; \
   ENTRY(name)
+
+#define KPROBE_EXIT \
+  .popsection
 
 #ifndef END
 #define END(name) \

--------------020701060400010207030401
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------020701060400010207030401--
