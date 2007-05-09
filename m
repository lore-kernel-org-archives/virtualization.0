From: James Morris <jmorris@namei.org>
Subject: [PATCH 2/2] lguest: Convert to hrtimer framework
Date: Wed, 9 May 2007 09:37:33 -0400 (EDT)
Message-ID: <Line.LNX.4.64.0705090935580.4526@d.namei>
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

Convert lguest to the hrtimer framework, enabling dynamic ticks and high 
resolution timers.

Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/lguest/hypercalls.c           |   13 +----
 drivers/lguest/interrupts_and_traps.c |   32 +++++++++++--
 drivers/lguest/lg.h                   |    6 ++-
 drivers/lguest/lguest.c               |   82 +++++++++++++++++++++++++-------
 drivers/lguest/lguest_user.c          |    7 +++
 include/linux/lguest.h                |    5 ++-
 6 files changed, 111 insertions(+), 34 deletions(-)

diff --git a/drivers/lguest/hypercalls.c b/drivers/lguest/hypercalls.c
index a8c0b86..e2e8047 100644
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -65,16 +65,6 @@ static void do_hcall(struct lguest *lg, struct lguest_regs *regs)
 		else
 			guest_pagetable_flush_user(lg);
 		break;
-	case LHCALL_TIMER_READ: {
-		/* The "timer" returns the number of clock ticks since the
-		 * Guest last asked. */
-		u32 now = jiffies;
-		mb();
-		regs->eax = now - lg->last_timer;
-		/* Remember the clock ticks for next time */
-		lg->last_timer = now;
-		break;
-	}
 	case LHCALL_GET_WALLCLOCK: {
 		/* The Guest wants to know the real time in seconds since 1970,
 		 * in good Unix tradition. */
@@ -120,6 +110,9 @@ static void do_hcall(struct lguest *lg, struct lguest_regs *regs)
 	case LHCALL_LOAD_TLS:
 		guest_load_tls(lg, (struct desc_struct __user*)regs->edx);
 		break;
+	case LHCALL_SET_CLOCKEVENT:
+		guest_set_clockevent(lg, regs->edx);
+		break;
 
 	case LHCALL_TS:
 		/* This sets the TS flag, as we saw used in run_guest(). */
diff --git a/drivers/lguest/interrupts_and_traps.c b/drivers/lguest/interrupts_and_traps.c
index ece6e2a..409d174 100644
--- a/drivers/lguest/interrupts_and_traps.c
+++ b/drivers/lguest/interrupts_and_traps.c
@@ -131,10 +131,6 @@ void maybe_do_interrupt(struct lguest *lg)
 	if (!lg->lguest_data)
 		return;
 
-	/* If the timer has changed, we set the timer interrupt (0). */
-	if (jiffies != lg->last_timer)
-		set_bit(0, lg->irqs_pending);
-
 	/* Take our "irqs_pending" array and remove any interrupts the Guest
 	 * wants blocked: the result ends up in "blk". */
 	if (copy_from_user(&blk, lg->lguest_data->blocked_interrupts,
@@ -408,3 +404,31 @@ void copy_traps(const struct lguest *lg, struct desc_struct *idt,
 	else
 		default_idt_entry(&idt[i], i, def[i]);
 }
+
+void guest_set_clockevent(struct lguest *lg, unsigned long delta)
+{
+	ktime_t expires;
+
+	if (unlikely(delta == 0)) {
+		/* Clock event device is shutting down. */
+		hrtimer_cancel(&lg->hrt);
+		return;
+	}
+	
+	expires = ktime_add_ns(ktime_get_real(), delta);
+	hrtimer_start(&lg->hrt, expires, HRTIMER_MODE_ABS);
+}
+
+static enum hrtimer_restart clockdev_fn(struct hrtimer *timer)
+{
+	struct lguest *lg = container_of(timer, struct lguest, hrt);
+	
+	set_bit(0, lg->irqs_pending);
+	return HRTIMER_NORESTART;
+}
+
+void init_clockdev(struct lguest *lg)
+{
+	hrtimer_init(&lg->hrt, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	lg->hrt.function = clockdev_fn;
+}
diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index be506c8..d4c3fb9 100644
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -147,7 +147,6 @@ struct lguest
 	u32 cr2;
 	int halted;
 	int ts;
-	u32 last_timer;
 	u32 next_hcall;
 	u32 esp1;
 	u8 ss1;
@@ -186,6 +185,9 @@ struct lguest
 	struct desc_struct idt[FIRST_EXTERNAL_VECTOR+LGUEST_IRQS];
 	struct desc_struct syscall_idt;
 
+	/* Virtual clock device */
+	struct hrtimer hrt;
+
 	/* Pending virtual interrupts */
 	DECLARE_BITMAP(irqs_pending, LGUEST_IRQS);
 };
@@ -214,6 +216,8 @@ void setup_default_idt_entries(struct lguest_ro_state *state,
 			       const unsigned long *def);
 void copy_traps(const struct lguest *lg, struct desc_struct *idt,
 		const unsigned long *def);
+void guest_set_clockevent(struct lguest *lg, unsigned long delta);
+void init_clockdev(struct lguest *lg);
 
 /* segments.c: */
 void setup_default_gdt_entries(struct lguest_ro_state *state);
diff --git a/drivers/lguest/lguest.c b/drivers/lguest/lguest.c
index e102c35..0f4edf1 100644
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -53,6 +53,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/lguest.h>
 #include <linux/lguest_launcher.h>
 #include <asm/paravirt.h>
@@ -605,19 +606,6 @@ static unsigned long lguest_get_wallclock(void)
 	return hcall(LHCALL_GET_WALLCLOCK, 0, 0, 0);
 }
 
-/* This is the Guest timer interrupt handler (hardware interrupt 0).  I copied
- * this from some old code which has since been bulldozed, but it still
- * works. */
-static void lguest_time_irq(unsigned int irq, struct irq_desc *desc)
-{
-	/* We call do_timer() with the number of ticks which have passed since
-	 * we last called do_timer().  Fortunately, that's exactly what the
-	 * TIMER_READ hypercall returns (if the Guest and Host have different
-	 * CONFIG_HZ values, this will give strange results).  */
-	do_timer(hcall(LHCALL_TIMER_READ, 0, 0, 0));
-	/* We are expected to update process times from here as well. */
-	update_process_times(user_mode_vm(get_irq_regs()));
-}
 
 static cycle_t lguest_clock_read(void)
 {
@@ -642,6 +630,68 @@ static void lguest_setup_clocksource(void)
 	clocksource_register(&lguest_clock);
 }
 
+static void lguest_clockevent_shutdown(void)
+{
+	hcall(LHCALL_SET_CLOCKEVENT, 0, 0, 0);
+}
+
+static int lguest_clockevent_set_next_event(unsigned long delta,
+                                           struct clock_event_device *evt)
+{
+	if (delta < LG_CLOCK_MIN_DELTA) {
+		if (printk_ratelimit())
+			printk(KERN_DEBUG "%s: small delta %lu ns\n",
+			       __FUNCTION__, delta);
+		return -ETIME;
+	}
+	hcall(LHCALL_SET_CLOCKEVENT, delta, 0, 0);
+	return 0;
+}
+
+static void lguest_clockevent_set_mode(enum clock_event_mode mode,
+                                      struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		lguest_clockevent_shutdown();
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+	case CLOCK_EVT_MODE_PERIODIC:
+		BUG();
+	}
+}
+
+static struct clock_event_device lguest_clockevent = {
+	.name                   = "lguest",
+	.features               = CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event         = lguest_clockevent_set_next_event,
+	.set_mode               = lguest_clockevent_set_mode,
+	.rating                 = INT_MAX,
+	.mult                   = 1,
+	.shift                  = 0,
+	.min_delta_ns           = LG_CLOCK_MIN_DELTA,
+	.max_delta_ns           = LG_CLOCK_MAX_DELTA,
+};
+
+/* TODO: make this per-cpu for SMP */
+static void lguest_setup_clockevent(void)
+{
+	lguest_clockevent.cpumask = cpumask_of_cpu(0);
+	clockevents_register_device(&lguest_clockevent);
+}
+
+/* This is the Guest timer interrupt handler (hardware interrupt 0). */
+static void lguest_time_irq(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned long flags;
+	
+	local_irq_save(flags);
+	lguest_clockevent.event_handler(&lguest_clockevent);
+	local_irq_restore(flags);
+}
+
 /* At some point in the boot process, we get asked to set up our timing
  * infrastructure.  The kernel doesn't expect timer interrupts before this, but
  * we cleverly initialized the "blocked_interrupts" field of "struct
@@ -652,11 +702,7 @@ static void lguest_time_init(void)
 	 * routine */
 	set_irq_handler(0, lguest_time_irq);
 	lguest_setup_clocksource();
-	/* Ask the Host for the time once.  Since the TIMER_READ hypercall
-	 * returns the number of ticks since it was last called, this means it
-	 * will return the right thing when we call it next time, from
-	 * lguest_time_irq(). */
-	hcall(LHCALL_TIMER_READ, 0, 0, 0);
+	lguest_setup_clockevent();
 	/* Finally, we unblock the timer interrupt. */
 	enable_lguest_irq(0);
 }
diff --git a/drivers/lguest/lguest_user.c b/drivers/lguest/lguest_user.c
index 7c9440b..a439cdb 100644
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -230,6 +230,11 @@ static int initialize(struct file *file, const u32 __user *input)
 	 * when the same Guest runs on the same CPU twice. */
 	lg->last_pages = NULL;
 
+	/* The clock device is a hrtimer programmed via the SET_CLOCKEVENT
+	 * hypercall.  This comment is fully compliant with Rusty's commenting
+	 * style 1.0. */
+	init_clockdev(lg);
+
 	/* We keep our "struct lguest" in the file's private_data. */
 	file->private_data = lg;
 
@@ -303,6 +308,8 @@ static int close(struct inode *inode, struct file *file)
 	/* We need the big lock, to protect from inter-guest I/O and other
 	 * Launchers initializing guests. */
 	mutex_lock(&lguest_lock);
+	/* Cancels the hrtimer set via LHCALL_SET_CLOCKEVENT. */
+	hrtimer_cancel(&lg->hrt);
 	/* Free any DMA buffers the Guest had bound. */
 	release_all_dma(lg);
 	/* Free up the shadow page tables for the Guest. */
diff --git a/include/linux/lguest.h b/include/linux/lguest.h
index 6ce0865..99548c5 100644
--- a/include/linux/lguest.h
+++ b/include/linux/lguest.h
@@ -12,7 +12,7 @@
 #define LHCALL_LOAD_IDT_ENTRY	6
 #define LHCALL_SET_STACK	7
 #define LHCALL_TS		8
-#define LHCALL_TIMER_READ	9
+#define LHCALL_SET_CLOCKEVENT	9
 #define LHCALL_HALT		10
 #define LHCALL_GET_WALLCLOCK	11
 #define LHCALL_BIND_DMA		12
@@ -23,6 +23,9 @@
 
 #define LGUEST_TRAP_ENTRY 0x1F
 
+#define LG_CLOCK_MIN_DELTA	100UL
+#define LG_CLOCK_MAX_DELTA	ULONG_MAX
+
 #ifndef __ASSEMBLY__
 #include <asm/irq.h>
 
-- 
1.5.0.6
