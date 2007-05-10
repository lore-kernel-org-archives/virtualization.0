From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest re-review
Date: Thu, 10 May 2007 10:24:08 +1000
Message-ID: <1178756648.7286.182.camel@localhost.localdomain>
References: <20070509025122.f3cb7247.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759769AbXEJAYV@vger.kernel.org>
In-Reply-To: <20070509025122.f3cb7247.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-09 at 02:51 -0700, Andrew Morton wrote:
> Some concern was expressed over the lguest review status, so I shall send
> the patches out again for people to review, to test, to make observations
> about the author's personal appearance, etc.

Thanks Andrew,

	This means I can finally ack this patch (thanks Eric):

From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Revert "[PATCH] paravirt: Add startup infrastructure for paravirtualization"

This reverts commit c9ccf30d77f04064fe5436027ab9d2230c7cdd94.

Entering the kernel at startup_32 without passing our real mode data
in %esi, and without guaranteeing that physical and virtual addresses
are identity mapped makes head.S impossible to maintain.

The only user of this infrastructure is lguest which is not merged so
nothing we currently support will break by removing this over designed
nightmare, and only the pending lguest patches will be affected. The
pending Xen patches have a different entry point that they use.

We are currently discussing what Xen and lguest need to do to boot the
kernel in a more normal fashion so using startup_32 in this weird
manner is clearly not their long term direction.

So let's remove this code in head.S before it causes brain damage to
people trying to maintain head.S

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>
CC: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/i386/kernel/head.S        |   38 --------------------------------------
 arch/i386/kernel/paravirt.c    |    1 -
 arch/i386/kernel/vmlinux.lds.S |    6 ------
 include/asm-i386/paravirt.h    |    5 -----
 4 files changed, 50 deletions(-)

===================================================================
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -70,12 +70,6 @@ INIT_MAP_BEYOND_END = BOOTBITMAP_SIZE + 
  */
 .section .text.head,"ax",@progbits
 ENTRY(startup_32)
-
-#ifdef CONFIG_PARAVIRT
-        movl %cs, %eax
-        testl $0x3, %eax
-        jnz startup_paravirt
-#endif
 
 /*
  * Set segments to known values.
@@ -501,38 +495,6 @@ ignore_int:
 	iret
 
 .section .text
-#ifdef CONFIG_PARAVIRT
-startup_paravirt:
-	cld
- 	movl $(init_thread_union+THREAD_SIZE),%esp
-
-	/* We take pains to preserve all the regs. */
-	pushl	%edx
-	pushl	%ecx
-	pushl	%eax
-
-	pushl	$__start_paravirtprobe
-1:
-	movl	0(%esp), %eax
-	cmpl	$__stop_paravirtprobe, %eax
-	je	unhandled_paravirt
-	pushl	(%eax)
-	movl	8(%esp), %eax
-	call	*(%esp)
-	popl	%eax
-
-	movl	4(%esp), %eax
-	movl	8(%esp), %ecx
-	movl	12(%esp), %edx
-
-	addl	$4, (%esp)
-	jmp	1b
-
-unhandled_paravirt:
-	/* Nothing wanted us: we're screwed. */
-	ud2
-#endif
-
 /*
  * Real beginning of normal "text" segment
  */
===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/efi.h>
 #include <linux/bcd.h>
-#include <linux/start_kernel.h>
 #include <linux/highmem.h>
 
 #include <asm/bug.h>
===================================================================
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -80,12 +80,6 @@ SECTIONS
 	EXTRA_RWDATA
 	CONSTRUCTORS
 	} :data
-
-  .paravirtprobe : AT(ADDR(.paravirtprobe) - LOAD_OFFSET) {
-  	__start_paravirtprobe = .;
-	*(.paravirtprobe)
-  	__stop_paravirtprobe = .;
-  }
 
   . = ALIGN(4096);
   .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -221,11 +221,6 @@ struct paravirt_ops
 	void (*irq_enable_sysexit)(void);
 	void (*iret)(void);
 };
-
-/* Mark a paravirt probe function. */
-#define paravirt_probe(fn)						\
- static asmlinkage void (*__paravirtprobe_##fn)(void) __attribute_used__ \
-		__attribute__((__section__(".paravirtprobe"))) = fn
 
 extern struct paravirt_ops paravirt_ops;
 
