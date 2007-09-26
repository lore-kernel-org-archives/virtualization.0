From: rusty@rustcorp.com.au
Subject: [patch 30/43] lguest: Allow guest to specify syscall vector to use.
Date: Wed, 26 Sep 2007 16:36:48 +1000
Message-ID: <20070926063650.531824582@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=plan9-syscall.patch
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

(Based on Ron Minnich's LGUEST_PLAN9_SYSCALL patch).

This patch allows Guests to specify what system call vector they want,
and we try to reserve it.  We only allow one non-Linux system call
vector, to try to avoid DoS on the Host.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 arch/i386/lguest/boot.c               |    1 
 drivers/lguest/core.c                 |   30 +++++++++++++-------
 drivers/lguest/i386_core.c            |    4 ++
 drivers/lguest/interrupts_and_traps.c |   49 ++++++++++++++++++++++++++++++++-
 drivers/lguest/lg.h                   |    3 ++
 include/linux/lguest.h                |    3 ++
 6 files changed, 79 insertions(+), 11 deletions(-)

===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -281,37 +281,47 @@ static int __init init(void)
 	/* First we put the Switcher up in very high virtual memory. */
 	err = map_switcher();
 	if (err)
-		return err;
+		goto out;
 
 	/* Now we set up the pagetable implementation for the Guests. */
 	err = init_pagetables(switcher_page, SHARED_SWITCHER_PAGES);
-	if (err) {
-		unmap_switcher();
-		return err;
-	}
+	if (err)
+		goto unmap;
 
 	/* The I/O subsystem needs some things initialized. */
 	lguest_io_init();
 
+	/* We might need to reserve an interrupt vector. */
+	err = init_interrupts();
+	if (err)
+		goto free_pgtables;
+
 	/* /dev/lguest needs to be registered. */
 	err = lguest_device_init();
-	if (err) {
-		free_pagetables();
-		unmap_switcher();
-		return err;
-	}
+	if (err)
+		goto free_interrupts;
 
 	/* Finally we do some architecture-specific setup. */
 	lguest_arch_host_init();
 
 	/* All good! */
 	return 0;
+
+free_interrupts:
+	free_interrupts();
+free_pgtables:
+	free_pagetables();
+unmap:
+	unmap_switcher();
+out:
+	return err;
 }
 
 /* Cleaning up is just the same code, backwards.  With a little French. */
 static void __exit fini(void)
 {
 	lguest_device_remove();
+	free_interrupts();
 	free_pagetables();
 	unmap_switcher();
 
===================================================================
--- a/drivers/lguest/i386_core.c
+++ b/drivers/lguest/i386_core.c
@@ -530,6 +530,10 @@ int lguest_arch_init_hypercalls(struct l
 	if (put_user(tsc_speed, &lg->lguest_data->tsc_khz))
 		return -EFAULT;
 
+	/* The interrupt code might not like the system call vector. */
+	if (!check_syscall_vector(lg))
+		kill_guest(lg, "bad syscall vector");
+
 	return 0;
 }
 /* Now we've examined the hypercall code; our Guest can make requests.  There
===================================================================
--- a/arch/i386/lguest/boot.c
+++ b/arch/i386/lguest/boot.c
@@ -87,6 +87,7 @@ struct lguest_data lguest_data = {
 	.noirq_start = (u32)lguest_noirq_start,
 	.noirq_end = (u32)lguest_noirq_end,
 	.blocked_interrupts = { 1 }, /* Block timer interrupts */
+	.syscall_vec = SYSCALL_VECTOR,
 };
 static cycle_t clock_base;
 
===================================================================
--- a/drivers/lguest/interrupts_and_traps.c
+++ b/drivers/lguest/interrupts_and_traps.c
@@ -12,7 +12,13 @@
  * them first, so we also have a way of "reflecting" them into the Guest as if
  * they had been delivered to it directly. :*/
 #include <linux/uaccess.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include "lg.h"
+
+/* Allow Guests to use a non-128 (ie. non-Linux) syscall trap. */
+static unsigned int syscall_vector = SYSCALL_VECTOR;
+module_param(syscall_vector, uint, 0444);
 
 /* The address of the interrupt handler is split into two bits: */
 static unsigned long idt_address(u32 lo, u32 hi)
@@ -183,6 +189,47 @@ void maybe_do_interrupt(struct lguest *l
 	 * timer interrupt. */
 	write_timestamp(lg);
 }
+/*:*/
+
+/* Linux uses trap 128 for system calls.  Plan9 uses 64, and Ron Minnich sent
+ * me a patch, so we support that too.  It'd be a big step for lguest if half
+ * the Plan 9 user base were to start using it.
+ *
+ * Actually now I think of it, it's possible that Ron *is* half the Plan 9
+ * userbase.  Oh well. */
+static bool could_be_syscall(unsigned int num)
+{
+	/* Normal Linux SYSCALL_VECTOR or reserved vector? */
+	return num == SYSCALL_VECTOR || num == syscall_vector;
+}
+
+/* The syscall vector it wants must be unused by Host. */
+bool check_syscall_vector(struct lguest *lg)
+{
+	u32 vector;
+
+	if (get_user(vector, &lg->lguest_data->syscall_vec))
+		return false;
+
+	return could_be_syscall(vector);
+}
+
+int init_interrupts(void)
+{
+	/* If they want some strange system call vector, reserve it now */
+	if (syscall_vector != SYSCALL_VECTOR
+	    && test_and_set_bit(syscall_vector, used_vectors)) {
+		printk("lg: couldn't reserve syscall %u\n", syscall_vector);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+void free_interrupts(void)
+{
+	if (syscall_vector != SYSCALL_VECTOR)
+		clear_bit(syscall_vector, used_vectors);
+}
 
 /*H:220 Now we've got the routines to deliver interrupts, delivering traps
  * like page fault is easy.  The only trick is that Intel decided that some
@@ -224,7 +271,7 @@ static int direct_trap(unsigned int num)
 {
 	/* Hardware interrupts don't go to the Guest at all (except system
 	 * call). */
-	if (num >= FIRST_EXTERNAL_VECTOR && num != SYSCALL_VECTOR)
+	if (num >= FIRST_EXTERNAL_VECTOR && !could_be_syscall(num))
 		return 0;
 
 	/* The Host needs to see page faults (for shadow paging and to save the
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -142,6 +142,9 @@ void copy_traps(const struct lguest *lg,
 		const unsigned long *def);
 void guest_set_clockevent(struct lguest *lg, unsigned long delta);
 void init_clockdev(struct lguest *lg);
+bool check_syscall_vector(struct lguest *lg);
+int init_interrupts(void);
+void free_interrupts(void);
 
 /* segments.c: */
 void setup_default_gdt_entries(struct lguest_ro_state *state);
===================================================================
--- a/include/linux/lguest.h
+++ b/include/linux/lguest.h
@@ -48,6 +48,9 @@ struct lguest_data
 /* Fields initialized by the Guest at boot: */
 	/* Instruction range to suppress interrupts even if enabled */
 	unsigned long noirq_start, noirq_end;
+
+	/* The vector to try to use for system calls (0x40 or 0x80). */
+	unsigned int syscall_vec;
 };
 extern struct lguest_data lguest_data;
 #endif /* __ASSEMBLY__ */

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
