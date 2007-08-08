From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Fix Malicious Guest GDT Host Crash
Date: Wed, 08 Aug 2007 14:10:20 +1000
Message-ID: <1186546220.17470.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
Cc: ron minnich <rminnich@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	Testing would be appreciated (esp. Ron?): I'd like to push this as soon
as possible into 2.6.23.  I thought of it while pondering kvm-lite, and
then proved it was a problem...

==
If a Guest makes hypercall which sets a GDT entry to not present, we
currently set any segment registers using that GDT entry to 0.
Unfortunately, this is not sufficient: there are other ways of
altering GDT entries which will cause a fault.

The correct solution to do what Linux does: let them set any GDT value
they want and handle the #GP when popping causes a fault.  This has
the added benefit of making our switcher slightly more robust in the
case of any other bugs which cause it to fault.

We kill the Guest if it causes a fault in the Switcher, so it has to
make sure it's not using segments when it changes them.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 55fdd7fa62b7 drivers/lguest/core.c
--- a/drivers/lguest/core.c	Mon Aug 06 16:38:47 2007 +1000
+++ b/drivers/lguest/core.c	Wed Aug 08 13:24:59 2007 +1000
@@ -452,6 +452,11 @@ static void run_guest_once(struct lguest
 	/* Copy the guest-specific information into this CPU's "struct
 	 * lguest_pages". */
 	copy_in_guest_info(lg, pages);
+
+	/* Set the trap number to 256 (impossible value).  If we fault while
+	 * switching to the Guest (bad segment registers or bug), this will
+	 * cause us to abort the Guest. */
+	lg->regs->trapnum = 256;
 
 	/* Now: we push the "eflags" register on the stack, then do an "lcall".
 	 * This is how we change from using the kernel code segment to using
diff -r 55fdd7fa62b7 drivers/lguest/interrupts_and_traps.c
--- a/drivers/lguest/interrupts_and_traps.c	Mon Aug 06 16:38:47 2007 +1000
+++ b/drivers/lguest/interrupts_and_traps.c	Wed Aug 08 13:22:53 2007 +1000
@@ -195,13 +195,16 @@ static int has_err(unsigned int trap)
 /* deliver_trap() returns true if it could deliver the trap. */
 int deliver_trap(struct lguest *lg, unsigned int num)
 {
-	u32 lo = lg->idt[num].a, hi = lg->idt[num].b;
+	/* Trap numbers are always 8 bit, but we set an impossible trap number
+	 * for traps inside the Switcher, so check that here. */
+	if (num >= ARRAY_SIZE(lg->idt))
+		return 0;
 
 	/* Early on the Guest hasn't set the IDT entries (or maybe it put a
 	 * bogus one in): if we fail here, the Guest will be killed. */
-	if (!idt_present(lo, hi))
+	if (!idt_present(lg->idt[num].a, lg->idt[num].b))
 		return 0;
-	set_guest_interrupt(lg, lo, hi, has_err(num));
+	set_guest_interrupt(lg, lg->idt[num].a, lg->idt[num].b, has_err(num));
 	return 1;
 }
 
diff -r 55fdd7fa62b7 drivers/lguest/lguest.c
--- a/drivers/lguest/lguest.c	Mon Aug 06 16:38:47 2007 +1000
+++ b/drivers/lguest/lguest.c	Wed Aug 08 13:27:58 2007 +1000
@@ -323,9 +323,12 @@ static void lguest_write_gdt_entry(struc
  * __thread variables).  So we have a hypercall specifically for this case. */
 static void lguest_load_tls(struct thread_struct *t, unsigned int cpu)
 {
+	/* There's one problem which normal hardware doesn't have: the Host
+	 * can't handle us removing entries we're currently using.  So we clear
+	 * the GS register here: if it's needed it'll be reloaded anyway. */
+	loadsegment(gs, 0);
 	lazy_hcall(LHCALL_LOAD_TLS, __pa(&t->tls_array), cpu, 0);
 }
-/*:*/
 
 /*G:038 That's enough excitement for now, back to ploughing through each of
  * the paravirt_ops (we're about 1/3 of the way through).
diff -r 55fdd7fa62b7 drivers/lguest/segments.c
--- a/drivers/lguest/segments.c	Mon Aug 06 16:38:47 2007 +1000
+++ b/drivers/lguest/segments.c	Wed Aug 08 13:57:08 2007 +1000
@@ -43,22 +43,6 @@
  * begin.
  */
 
-/* Is the descriptor the Guest wants us to put in OK?
- *
- * The flag which Intel says must be zero: must be zero.  The descriptor must
- * be present, (this is actually checked earlier but is here for thorougness),
- * and the descriptor type must be 1 (a memory segment).  */
-static int desc_ok(const struct desc_struct *gdt)
-{
-	return ((gdt->b & 0x00209000) == 0x00009000);
-}
-
-/* Is the segment present?  (Otherwise it can't be used by the Guest). */
-static int segment_present(const struct desc_struct *gdt)
-{
-	return gdt->b & 0x8000;
-}
-
 /* There are several entries we don't let the Guest set.  The TSS entry is the
  * "Task State Segment" which controls all kinds of delicate things.  The
  * LGUEST_CS and LGUEST_DS entries are reserved for the Switcher, and the
@@ -71,37 +55,11 @@ static int ignored_gdt(unsigned int num)
 		|| num == GDT_ENTRY_DOUBLEFAULT_TSS);
 }
 
-/* If the Guest asks us to remove an entry from the GDT, we have to be careful.
- * If one of the segment registers is pointing at that entry the Switcher will
- * crash when it tries to reload the segment registers for the Guest.
- *
- * It doesn't make much sense for the Guest to try to remove its own code, data
- * or stack segments while they're in use: assume that's a Guest bug.  If it's
- * one of the lesser segment registers using the removed entry, we simply set
- * that register to 0 (unusable). */
-static void check_segment_use(struct lguest *lg, unsigned int desc)
-{
-	/* GDT entries are 8 bytes long, so we divide to get the index and
-	 * ignore the bottom bits. */
-	if (lg->regs->gs / 8 == desc)
-		lg->regs->gs = 0;
-	if (lg->regs->fs / 8 == desc)
-		lg->regs->fs = 0;
-	if (lg->regs->es / 8 == desc)
-		lg->regs->es = 0;
-	if (lg->regs->ds / 8 == desc
-	    || lg->regs->cs / 8 == desc
-	    || lg->regs->ss / 8 == desc)
-		kill_guest(lg, "Removed live GDT entry %u", desc);
-}
-/*:*/
-/*M:009 We wouldn't need to check for removal of in-use segments if we handled
- * faults in the Switcher.  However, it's probably not a worthwhile
- * optimization. :*/
-
-/*H:610 Once the GDT has been changed, we look through the changed entries and
- * see if they're OK.  If not, we'll call kill_guest() and the Guest will never
- * get to use the invalid entries. */
+/*H:610 Once the GDT has been changed, we fix the new entries up a little.  We
+ * don't care if they're invalid: the worst that can happen is a General
+ * Protection Fault in the Switcher when it restores a Guest segment register
+ * which tries to use that entry.  Then we kill the Guest for causing such a
+ * mess: the message will be "unhandled trap 256". */
 static void fixup_gdt_table(struct lguest *lg, unsigned start, unsigned end)
 {
 	unsigned int i;
@@ -111,16 +69,6 @@ static void fixup_gdt_table(struct lgues
 		 * they say */
 		if (ignored_gdt(i))
 			continue;
-
-		/* We could fault in switch_to_guest if they are using
-		 * a removed segment. */
-		if (!segment_present(&lg->gdt[i])) {
-			check_segment_use(lg, i);
-			continue;
-		}
-
-		if (!desc_ok(&lg->gdt[i]))
-			kill_guest(lg, "Bad GDT descriptor %i", i);
 
 		/* Segment descriptors contain a privilege level: the Guest is
 		 * sometimes careless and leaves this as 0, even though it's
diff -r 55fdd7fa62b7 drivers/lguest/switcher.S
--- a/drivers/lguest/switcher.S	Mon Aug 06 16:38:47 2007 +1000
+++ b/drivers/lguest/switcher.S	Wed Aug 08 12:29:13 2007 +1000
@@ -47,6 +47,7 @@
 // Down here in the depths of assembler code.
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/page.h>
 #include "lg.h"
 
 // We mark the start of the code to copy
@@ -182,13 +183,15 @@ ENTRY(switch_to_guest)
 	movl	$(LGUEST_DS), %eax;					\
 	movl	%eax, %ds;						\
 	/* So where are we?  Which CPU, which struct?			\
-	 * The stack is our clue: our TSS sets				\
-	 * It at the end of "struct lguest_pages"			\
-	 * And we then pushed and pushed and pushed Guest regs:		\
-	 * Now stack points atop the "struct lguest_regs".   		\
-	 * Subtract that offset, and we find our struct. */		\
+	 * The stack is our clue: our TSS starts			\
+	 * It at the end of "struct lguest_pages".			\
+	 * Or we may have stumbled while restoring			\
+	 * Our Guest segment regs while in switch_to_guest,		\
+	 * The fault pushed atop that part-unwound stack.		\
+	 * If we round the stack down to the page start			\
+	 * We're at the start of "struct lguest_pages". */		\
 	movl	%esp, %eax;						\
-	subl	$LGUEST_PAGES_regs, %eax;				\
+	andl	$(~(1 << PAGE_SHIFT - 1)), %eax;			\
 	/* Save our trap number: the switch will obscure it		\
 	 * (The Guest regs are not mapped here in the Host)		\
 	 * %ebx holds it safe for deliver_to_host */			\
