From: James Morris <jmorris@namei.org>
Subject: [PATCH 1/2] lguest: Add TSC clocksource
Date: Wed, 9 May 2007 09:35:50 -0400 (EDT)
Message-ID: <Line.LNX.4.64.0705090934570.4526@d.namei>
References: <Line.LNX.4.64.0705090927001.4526@d.namei>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Line.LNX.4.64.0705090927001.4526@d.namei>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

Add rudimentary TSC-based clocksource support (based on Rusty's original 
patch).  Needs to be enhanced for frequency scaling.

Signed-off-by: James Morris <jmorris@namei.org>
---
 arch/i386/kernel/tsc.c      |    1 +
 drivers/lguest/hypercalls.c |    6 +++++-
 drivers/lguest/lguest.c     |   25 +++++++++++++++++++++++++
 include/linux/lguest.h      |    2 ++
 4 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index 7a5091d..3c82af5 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -26,6 +26,7 @@ static int tsc_enabled;
  * an extra value to store the TSC freq
  */
 unsigned int tsc_khz;
+EXPORT_SYMBOL_GPL(tsc_khz);
 
 int tsc_disable;
 
diff --git a/drivers/lguest/hypercalls.c b/drivers/lguest/hypercalls.c
index 0eec0fe..a8c0b86 100644
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
 #include <linux/mm.h>
+#include <linux/clocksource.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <irq_vectors.h>
@@ -222,7 +223,10 @@ static void initialize(struct lguest *lg)
 	if (get_user(lg->noirq_start, &lg->lguest_data->noirq_start)
 	    || get_user(lg->noirq_end, &lg->lguest_data->noirq_end)
 	    /* We also give the Guest a unique id, as used in lguest_net.c. */
-	    || put_user(lg->guestid, &lg->lguest_data->guestid))
+	    || put_user(lg->guestid, &lg->lguest_data->guestid)
+	    /* TSC clock multiplier is determined at runtime */
+	    || put_user(clocksource_khz2mult(tsc_khz, 22),
+	    		&lg->lguest_data->clock_mult))
 		kill_guest(lg, "bad guest page %p", lg->lguest_data);
 
 	/* page_tables.c will also do some setup. */
diff --git a/drivers/lguest/lguest.c b/drivers/lguest/lguest.c
index f4f300f..e102c35 100644
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -52,6 +52,7 @@
 #include <linux/screen_info.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/clocksource.h>
 #include <linux/lguest.h>
 #include <linux/lguest_launcher.h>
 #include <asm/paravirt.h>
@@ -618,6 +619,29 @@ static void lguest_time_irq(unsigned int irq, struct irq_desc *desc)
 	update_process_times(user_mode_vm(get_irq_regs()));
 }
 
+static cycle_t lguest_clock_read(void)
+{
+	/* FIXME: This is just the native one.  Account stolen time! */
+	return paravirt_ops.read_tsc();
+}
+
+/* FIXME: Update iff tsc rate changes. */
+static struct clocksource lguest_clock = {
+	.name		= "lguest",
+	.rating		= 400,
+	.read		= lguest_clock_read,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.mult		= 0, /* to be set */
+	.shift		= 22,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void lguest_setup_clocksource(void)
+{
+	lguest_clock.mult = lguest_data.clock_mult;
+	clocksource_register(&lguest_clock);
+}
+
 /* At some point in the boot process, we get asked to set up our timing
  * infrastructure.  The kernel doesn't expect timer interrupts before this, but
  * we cleverly initialized the "blocked_interrupts" field of "struct
@@ -627,6 +651,7 @@ static void lguest_time_init(void)
 	/* We set up the timer interrupt (0) to go to our simple timer
 	 * routine */
 	set_irq_handler(0, lguest_time_irq);
+	lguest_setup_clocksource();
 	/* Ask the Host for the time once.  Since the TIMER_READ hypercall
 	 * returns the number of ticks since it was last called, this means it
 	 * will return the right thing when we call it next time, from
diff --git a/include/linux/lguest.h b/include/linux/lguest.h
index f41392c..6ce0865 100644
--- a/include/linux/lguest.h
+++ b/include/linux/lguest.h
@@ -99,6 +99,8 @@ struct lguest_data
 	unsigned long reserve_mem;
 	/* ID of this Guest (used by network driver to set ethernet address) */
 	u16 guestid;
+	/* Multiplier for TSC clock. */
+	u32 clock_mult;
 	/* Page where the top-level pagetable is */
 	unsigned long pgdir;
 
-- 
1.5.0.6
