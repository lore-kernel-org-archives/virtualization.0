From: rusty@rustcorp.com.au
Subject: [patch 25/43] lguest: Move register setup into i386_core.c
Date: Wed, 26 Sep 2007 16:36:43 +1000
Message-ID: <20070926063649.629020708@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-user-disentangle.diff
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

Move setup_regs() to lguest_arch_setup_regs() in i386_core.c given
that this is very architecture specific.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 drivers/lguest/i386_core.c   |   36 ++++++++++++++++++++++++++++++++++++
 drivers/lguest/lg.h          |    1 +
 drivers/lguest/lguest_user.c |   37 +------------------------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

===================================================================
--- a/drivers/lguest/i386_core.c
+++ b/drivers/lguest/i386_core.c
@@ -535,3 +535,39 @@ int lguest_arch_init_hypercalls(struct l
 /* Now we've examined the hypercall code; our Guest can make requests.  There
  * is one other way we can do things for the Guest, as we see in
  * emulate_insn(). :*/
+
+/*L:030 lguest_arch_setup_regs()
+ *
+ * Most of the Guest's registers are left alone: we used get_zeroed_page() to
+ * allocate the structure, so they will be 0. */
+void lguest_arch_setup_regs(struct lguest *lg, unsigned long start)
+{
+	struct lguest_regs *regs = lg->regs;
+
+	/* There are four "segment" registers which the Guest needs to boot:
+	 * The "code segment" register (cs) refers to the kernel code segment
+	 * __KERNEL_CS, and the "data", "extra" and "stack" segment registers
+	 * refer to the kernel data segment __KERNEL_DS.
+	 *
+	 * The privilege level is packed into the lower bits.  The Guest runs
+	 * at privilege level 1 (GUEST_PL).*/
+	regs->ds = regs->es = regs->ss = __KERNEL_DS|GUEST_PL;
+	regs->cs = __KERNEL_CS|GUEST_PL;
+
+	/* The "eflags" register contains miscellaneous flags.  Bit 1 (0x002)
+	 * is supposed to always be "1".  Bit 9 (0x200) controls whether
+	 * interrupts are enabled.  We always leave interrupts enabled while
+	 * running the Guest. */
+	regs->eflags = 0x202;
+
+	/* The "Extended Instruction Pointer" register says where the Guest is
+	 * running. */
+	regs->eip = start;
+
+	/* %esi points to our boot information, at physical address 0, so don't
+	 * touch it. */
+	/* There are a couple of GDT entries the Guest expects when first
+	 * booting. */
+
+	setup_guest_gdt(lg);
+}
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -204,6 +204,7 @@ void lguest_arch_handle_trap(struct lgue
 void lguest_arch_handle_trap(struct lguest *lg);
 int lguest_arch_init_hypercalls(struct lguest *lg);
 int lguest_arch_do_hcall(struct lguest *lg, struct hcall_args *args);
+void lguest_arch_setup_regs(struct lguest *lg, unsigned long start);
 
 /* <arch>_switcher.S: */
 extern char start_switcher_text[], end_switcher_text[], switch_to_guest[];
===================================================================
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -9,37 +9,6 @@
 #include <linux/fs.h>
 #include "lg.h"
 
-/*L:030 setup_regs() doesn't really belong in this file, but it gives us an
- * early glimpse deeper into the Host so it's worth having here.
- *
- * Most of the Guest's registers are left alone: we used get_zeroed_page() to
- * allocate the structure, so they will be 0. */
-static void setup_regs(struct lguest_regs *regs, unsigned long start)
-{
-	/* There are four "segment" registers which the Guest needs to boot:
-	 * The "code segment" register (cs) refers to the kernel code segment
-	 * __KERNEL_CS, and the "data", "extra" and "stack" segment registers
-	 * refer to the kernel data segment __KERNEL_DS.
-	 *
-	 * The privilege level is packed into the lower bits.  The Guest runs
-	 * at privilege level 1 (GUEST_PL).*/
-	regs->ds = regs->es = regs->ss = __KERNEL_DS|GUEST_PL;
-	regs->cs = __KERNEL_CS|GUEST_PL;
-
-	/* The "eflags" register contains miscellaneous flags.  Bit 1 (0x002)
-	 * is supposed to always be "1".  Bit 9 (0x200) controls whether
-	 * interrupts are enabled.  We always leave interrupts enabled while
-	 * running the Guest. */
-	regs->eflags = 0x202;
-
-	/* The "Extended Instruction Pointer" register says where the Guest is
-	 * running. */
-	regs->eip = start;
-
-	/* %esi points to our boot information, at physical address 0, so don't
-	 * touch it. */
-}
-
 /*L:310 To send DMA into the Guest, the Launcher needs to be able to ask for a
  * DMA buffer.  This is done by writing LHREQ_GETDMA and the key to
  * /dev/lguest. */
@@ -214,11 +183,7 @@ static int initialize(struct file *file,
 
 	/* Now we initialize the Guest's registers, handing it the start
 	 * address. */
-	setup_regs(lg->regs, args[3]);
-
-	/* There are a couple of GDT entries the Guest expects when first
-	 * booting. */
-	setup_guest_gdt(lg);
+	lguest_arch_setup_regs(lg, args[3]);
 
 	/* The timer for lguest's clock needs initialization. */
 	init_clockdev(lg);

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
