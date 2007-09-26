From: rusty@rustcorp.com.au
Subject: [patch 19/43] lguest: Make shadow IDT a complete IDT with 256
	entries.
Date: Wed, 26 Sep 2007 16:36:37 +1000
Message-ID: <20070926063648.539814423@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=idt-flat.patch
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This simplifies the code a little, in preparation for allowing
alternate system call vectors in guests (Plan 9 uses 0x40).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 drivers/lguest/interrupts_and_traps.c |   49 ++++++++++++---------------------
 drivers/lguest/lg.h                   |    3 --
 2 files changed, 20 insertions(+), 32 deletions(-)

===================================================================
--- a/drivers/lguest/interrupts_and_traps.c
+++ b/drivers/lguest/interrupts_and_traps.c
@@ -215,10 +215,9 @@ int deliver_trap(struct lguest *lg, unsi
  * system calls down from 1750ns to 270ns.  Plus, if lguest didn't do it, all
  * the other hypervisors would tease it.
  *
- * This routine determines if a trap can be delivered directly. */
-static int direct_trap(const struct lguest *lg,
-		       const struct desc_struct *trap,
-		       unsigned int num)
+ * This routine indicates if a particular trap number could be delivered
+ * directly. */
+static int direct_trap(unsigned int num)
 {
 	/* Hardware interrupts don't go to the Guest at all (except system
 	 * call). */
@@ -229,14 +228,7 @@ static int direct_trap(const struct lgue
 	 * fault address), general protection faults (in/out emulation) and
 	 * device not available (TS handling), and of course, the hypercall
 	 * trap. */
-	if (num == 14 || num == 13 || num == 7 || num == LGUEST_TRAP_ENTRY)
-		return 0;
-
-	/* Only trap gates (type 15) can go direct to the Guest.  Interrupt
-	 * gates (type 14) disable interrupts as they are entered, which we
-	 * never let the Guest do.  Not present entries (type 0x0) also can't
-	 * go direct, of course 8) */
-	return idt_type(trap->a, trap->b) == 0xF;
+	return num != 14 && num != 13 && num != 7 && num != LGUEST_TRAP_ENTRY;
 }
 /*:*/
 
@@ -342,15 +334,11 @@ void load_guest_idt_entry(struct lguest 
 	 * to copy this again. */
 	lg->changed |= CHANGED_IDT;
 
-	/* The IDT which we keep in "struct lguest" only contains 32 entries
-	 * for the traps and LGUEST_IRQS (32) entries for interrupts.  We
-	 * ignore attempts to set handlers for higher interrupt numbers, except
-	 * for the system call "interrupt" at 128: we have a special IDT entry
-	 * for that. */
-	if (num < ARRAY_SIZE(lg->idt))
+	/* Check that the Guest doesn't try to step outside the bounds. */
+	if (num >= ARRAY_SIZE(lg->idt))
+		kill_guest(lg, "Setting idt entry %u", num);
+	else
 		set_trap(lg, &lg->idt[num], num, lo, hi);
-	else if (num == SYSCALL_VECTOR)
-		set_trap(lg, &lg->syscall_idt, num, lo, hi);
 }
 
 /* The default entry for each interrupt points into the Switcher routines which
@@ -393,20 +381,21 @@ void copy_traps(const struct lguest *lg,
 
 	/* We can simply copy the direct traps, otherwise we use the default
 	 * ones in the Switcher: they will return to the Host. */
-	for (i = 0; i < FIRST_EXTERNAL_VECTOR; i++) {
-		if (direct_trap(lg, &lg->idt[i], i))
+	for (i = 0; i < ARRAY_SIZE(lg->idt); i++) {
+		/* If no Guest can ever override this trap, leave it alone. */
+		if (!direct_trap(i))
+			continue;
+
+		/* Only trap gates (type 15) can go direct to the Guest.
+		 * Interrupt gates (type 14) disable interrupts as they are
+		 * entered, which we never let the Guest do.  Not present
+		 * entries (type 0x0) also can't go direct, of course. */
+		if (idt_type(lg->idt[i].a, lg->idt[i].b) == 0xF)
 			idt[i] = lg->idt[i];
 		else
+			/* Reset it to the default. */
 			default_idt_entry(&idt[i], i, def[i]);
 	}
-
-	/* Don't forget the system call trap!  The IDT entries for other
-	 * interupts never change, so no need to copy them. */
-	i = SYSCALL_VECTOR;
-	if (direct_trap(lg, &lg->syscall_idt, i))
-		idt[i] = lg->syscall_idt;
-	else
-		default_idt_entry(&idt[i], i, def[i]);
 }
 
 void guest_set_clockevent(struct lguest *lg, unsigned long delta)
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -183,8 +183,7 @@ struct lguest
 	struct desc_struct gdt[GDT_ENTRIES];
 
 	/* The IDT entries: some copied into lguest_ro_state when running. */
-	struct desc_struct idt[FIRST_EXTERNAL_VECTOR+LGUEST_IRQS];
-	struct desc_struct syscall_idt;
+	struct desc_struct idt[IDT_ENTRIES];
 
 	/* Virtual clock device */
 	struct hrtimer hrt;

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
