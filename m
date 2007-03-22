From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] lguest: clean up some l"references .init.text" warnings
Date: Thu, 22 Mar 2007 13:57:23 +1100
Message-ID: <1174532243.2713.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965580AbXCVC5j@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Thanks to Andrew for pointing these out.

This patch moves the parvirtprobe section into .init.data: it's only
used in very very early boot, and for similar reasons, puts
lguest_maybe_init and lguest_memory_setup in init.text.

As well as fixing some warnings, this frees up a tiny bit more memory.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r ecec388180b2 arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S	Mon Mar 19 14:58:08 2007 +1100
+++ b/arch/i386/kernel/vmlinux.lds.S	Tue Mar 20 12:10:39 2007 +1100
@@ -81,12 +81,6 @@ SECTIONS
 	CONSTRUCTORS
 	} :data
 
-  .paravirtprobe : AT(ADDR(.paravirtprobe) - LOAD_OFFSET) {
-  	__start_paravirtprobe = .;
-	*(.paravirtprobe)
-  	__stop_paravirtprobe = .;
-  }
-
   . = ALIGN(4096);
   .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
   	__nosave_begin = .;
@@ -151,7 +145,12 @@ SECTIONS
 	*(.init.text)
 	_einittext = .;
   }
-  .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) { *(.init.data) }
+  .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
+	*(.init.data)
+  	__start_paravirtprobe = .;
+	*(.paravirtprobe)
+  	__stop_paravirtprobe = .;
+  }
   . = ALIGN(16);
   .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
   	__setup_start = .;
diff -r ecec388180b2 arch/i386/lguest/lguest.c
--- a/arch/i386/lguest/lguest.c	Mon Mar 19 14:58:08 2007 +1100
+++ b/arch/i386/lguest/lguest.c	Tue Mar 20 11:34:07 2007 +1100
@@ -136,7 +136,7 @@ static struct notifier_block paniced = {
 	.notifier_call = lguest_panic
 };
 
-static char *lguest_memory_setup(void)
+static __init char *lguest_memory_setup(void)
 {
 	/* We do this here because lockcheck barfs if before start_kernel */
 	atomic_notifier_chain_register(&panic_notifier_list, &paniced);
@@ -549,7 +549,8 @@ static __attribute_used__ __init void lg
 	start_kernel();
 }
 
-asm("lguest_maybe_init:\n"
+asm(".section .init.text\n"
+    "lguest_maybe_init:\n"
     "	cmpl $"__stringify(LGUEST_MAGIC_EBP)", %ebp\n"
     "	jne 1f\n"
     "	cmpl $"__stringify(LGUEST_MAGIC_EDI)", %edi\n"
