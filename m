From: rusty@rustcorp.com.au
Subject: [patch 21/43] lguest: Reorder guest saved regs to match hyperall
	order
Date: Wed, 26 Sep 2007 16:36:39 +1000
Message-ID: <20070926063648.920114327@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-i386-regs-reorder.diff
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Move eax next to ebx/ecx/edx in struct lguest_regs on i386, so they
will be located together and allow it to map directly to a struct
hcall_ring entry (which will be renamed struct hcall_args as in a
subsequent patch).

This is in preparation for making the code hcall code architecture
independent.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/i386_switcher.S |    4 ++--
 include/asm-i386/lguest.h      |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

===================================================================
--- linux-2.6.23-rc3.orig/drivers/lguest/i386_switcher.S
+++ linux-2.6.23-rc3/drivers/lguest/i386_switcher.S
@@ -134,6 +134,7 @@ ENTRY(switch_to_guest)
 	// The Guest's register page has been mapped
 	// Writable onto our %esp (stack) --
 	// We can simply pop off all Guest regs.
+	popl	%eax
 	popl	%ebx
 	popl	%ecx
 	popl	%edx
@@ -141,7 +142,6 @@ ENTRY(switch_to_guest)
 	popl	%edi
 	popl	%ebp
 	popl	%gs
-	popl	%eax
 	popl	%fs
 	popl	%ds
 	popl	%es
@@ -169,7 +169,6 @@ ENTRY(switch_to_guest)
 	pushl	%es;							\
 	pushl	%ds;							\
 	pushl	%fs;							\
-	pushl	%eax;							\
 	pushl	%gs;							\
 	pushl	%ebp;							\
 	pushl	%edi;							\
@@ -177,6 +176,7 @@ ENTRY(switch_to_guest)
 	pushl	%edx;							\
 	pushl	%ecx;							\
 	pushl	%ebx;							\
+	pushl	%eax;							\
 	/* Our stack and our code are using segments			\
 	 * Set in the TSS and IDT					\
 	 * Yet if we were to touch data we'd use			\
===================================================================
--- linux-2.6.23-rc3.orig/include/asm-i386/lguest.h
+++ linux-2.6.23-rc3/include/asm-i386/lguest.h
@@ -26,10 +26,9 @@ extern unsigned long default_idt_entries
 struct lguest_regs
 {
 	/* Manually saved part. */
-	unsigned long ebx, ecx, edx;
+	unsigned long eax, ebx, ecx, edx;
 	unsigned long esi, edi, ebp;
 	unsigned long gs;
-	unsigned long eax;
 	unsigned long fs, ds, es;
 	unsigned long trapnum, errcode;
 	/* Trap pushed part */

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
