From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 11/12] i386: Move setup_idt from head.S to head32.c
Date: Mon, 30 Apr 2007 10:33:52 -0600
Message-ID: <m11wi14ya7.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>
	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r6q14zow.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mz0p4zfc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1irbd4zcm.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ejm14z5f.fsf_-_@ebiederm.dsl.xmission.com>
	<m1abwp4yd9.fsf_-_@ebiederm.dsl.xmission.com>
	<m1647d4ybr.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1647d4ybr.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 30 Apr 2007 10:32:56 -0600")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


This slightly delays when we setup the idt.  But by doing it in C
things are noticeably simpler. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/head.S   |   68 +++-----------------------------------------
 arch/i386/kernel/head32.c |   26 +++++++++++++++++
 2 files changed, 31 insertions(+), 63 deletions(-)

diff --git a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
index 22ddb3f..0ee615b 100644
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -197,19 +197,6 @@ ENTRY(startup_32_smp)
 	pushl $0
 	popfl
 
-#ifdef CONFIG_SMP
-	cmpb $0, ready
-	jz  1f				/* Initial CPU cleans BSS */
-	jmp checkCPUtype
-1:
-#endif /* CONFIG_SMP */
-
-/*
- * start system 32-bit setup. We need to re-do some of the things done
- * in 16-bit mode for the "real" operations.
- */
-	call setup_idt
-
 checkCPUtype:
 
 	movl $-1,X86_CPUID		#  -1 for no CPUID initially
@@ -274,7 +261,6 @@ is386:	movl $2,%ecx		# set MP
 
 	call check_x87
 	lgdt early_gdt_descr
-	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
 	movl %eax,%ss			# after changing gdt.
@@ -321,65 +307,21 @@ check_x87:
 	.byte 0xDB,0xE4		/* fsetpm for 287, ignored by 387 */
 	ret
 
-/*
- *  setup_idt
- *
- *  sets up a idt with 256 entries pointing to
- *  ignore_int, interrupt gates. It doesn't actually load
- *  idt - that can be done only after paging has been enabled
- *  and the kernel moved to PAGE_OFFSET. Interrupts
- *  are enabled elsewhere, when we can be relatively
- *  sure everything is ok.
- *
- *  Warning: %esi is live across this function.
- */
-setup_idt:
-	lea ignore_int,%edx
-	movl $(__KERNEL_CS << 16),%eax
-	movw %dx,%ax		/* selector = 0x0010 = cs */
-	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
-
-	lea idt_table,%edi
-	mov $256,%ecx
-rp_sidt:
-	movl %eax,(%edi)
-	movl %edx,4(%edi)
-	addl $8,%edi
-	dec %ecx
-	jne rp_sidt
-
-.macro	set_early_handler handler,trapno
-	lea \handler,%edx
-	movl $(__KERNEL_CS << 16),%eax
-	movw %dx,%ax
-	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
-	lea idt_table,%edi
-	movl %eax,8*\trapno(%edi)
-	movl %edx,8*\trapno+4(%edi)
-.endm
-
-	set_early_handler handler=early_divide_err,trapno=0
-	set_early_handler handler=early_illegal_opcode,trapno=6
-	set_early_handler handler=early_protection_fault,trapno=13
-	set_early_handler handler=early_page_fault,trapno=14
-
-	ret
-
-early_divide_err:
+ENTRY(early_divide_err)
 	xor %edx,%edx
 	pushl $0	/* fake errcode */
 	jmp early_fault
 
-early_illegal_opcode:
+ENTRY(early_illegal_opcode)
 	movl $6,%edx
 	pushl $0	/* fake errcode */
 	jmp early_fault
 
-early_protection_fault:
+ENTRY(early_protection_fault)
 	movl $13,%edx
 	jmp early_fault
 
-early_page_fault:
+ENTRY(early_page_fault)
 	movl $14,%edx
 	jmp early_fault
 
@@ -408,7 +350,7 @@ hlt_loop:
 
 /* This is the default interrupt "handler" :-) */
 	ALIGN
-ignore_int:
+ENTRY(ignore_int)
 	cld
 #ifdef CONFIG_PRINTK
 	pushl %eax
diff --git a/arch/i386/kernel/head32.c b/arch/i386/kernel/head32.c
index 3db0590..d2f85d5 100644
--- a/arch/i386/kernel/head32.c
+++ b/arch/i386/kernel/head32.c
@@ -7,8 +7,34 @@
 
 #include <linux/init.h>
 #include <linux/start_kernel.h>
+#include <asm/desc.h>
+
+extern void ignore_int(void);
+extern void early_divide_err(void);
+extern void early_illegal_opcode(void);
+extern void early_protection_fault(void);
+extern void early_page_fault(void);
+
+/*
+ *  setup_idt
+ *
+ *  sets up a idt with 256 entries pointing to ignore_int.  Interrupts
+ *  are enabled elsewhere, when we can be relatively sure everything is ok.
+ */
+static void __init setup_idt(void)
+{
+	int i;
+	for (i = 0; i < IDT_ENTRIES; i++)
+		set_intr_gate(i, ignore_int);
+	set_intr_gate(0, early_divide_err);
+	set_intr_gate(6, early_illegal_opcode);
+	set_intr_gate(13, early_protection_fault);
+	set_intr_gate(14, early_page_fault);
+	load_idt(&idt_descr);
+}
 
 void __init i386_start_kernel(void)
 {
+	setup_idt();
 	start_kernel();
 }
-- 
1.5.1.1.181.g2de0
