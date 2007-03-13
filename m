From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 27/34] Xen-pv_ops: Implement Xen clockevent device
Date: Tue, 13 Mar 2007 16:30:44 -0700
Message-ID: <20070313233034.377094084@goop.org>
References: <20070313233017.933601256@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=xen-dynticks.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This patch implements a Xen clockevent device, using the set_timer_op
hypercall.  Unfortunately this will generate timer events on the same
event channel as the 100Hz tick which Xen helpfully generates for us.
This doesn't matter, other than generating a stream of what appear to
be spurious timer events.  The clockevent infrastucture can deal with
this, though it may be worth suppressing them by checking the current
time against the event time.

This patch does not attempt to account for lost/stolen time.  That
will have to be done in a more general way.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Thomas Gleixner <tglx@linutronix.de>

---
 arch/i386/xen/Kconfig     |    2 =

 arch/i386/xen/enlighten.c |    2 =

 arch/i386/xen/time.c      |  482 ++++++++++++++++++++---------------------=
----
 arch/i386/xen/xen-ops.h   |    3 =

 4 files changed, 225 insertions(+), 264 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/Kconfig
+++ b/arch/i386/xen/Kconfig
@@ -4,7 +4,7 @@
 =

 config XEN
 	bool "Enable support for Xen hypervisor"
-	depends on PARAVIRT && HZ_100 && !PREEMPT && !NO_HZ
+	depends on PARAVIRT && !PREEMPT
 	default y
 	help
 	  This is the Linux Xen port.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -149,11 +149,9 @@ static void xen_irq_enable(void)
 =

 static void xen_safe_halt(void)
 {
-	stop_hz_timer();
 	/* Blocking includes an implicit local_irq_enable(). */
 	if (HYPERVISOR_sched_op(SCHEDOP_block, 0) !=3D 0)
 		BUG();
-	start_hz_timer();
 }
 =

 static void xen_halt(void)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/time.c
+++ b/arch/i386/xen/time.c
@@ -1,10 +1,10 @@
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
 #include <linux/clocksource.h>
-
+#include <linux/clockchips.h>
+
+#include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
-#include <asm/arch_hooks.h>
 =

 #include <xen/events.h>
 #include <xen/interface/xen.h>
@@ -13,16 +13,9 @@
 #include "xen-ops.h"
 =

 #define XEN_SHIFT 22
-
-/* Permitted clock jitter, in nsecs, beyond which a warning will be printe=
d. */
-static unsigned long permitted_clock_jitter =3D 10000000UL; /* 10ms */
-static int __init __permitted_clock_jitter(char *str)
-{
-	permitted_clock_jitter =3D simple_strtoul(str, NULL, 0);
-	return 1;
-}
-__setup("permitted_clock_jitter=3D", __permitted_clock_jitter);
-
+#define TIMER_SLOP	100000	/* Xen may fire a timer up to this many ns early=
 */
+
+static DEFINE_PER_CPU(struct clock_event_device, xen_clock_events);
 =

 /* These are perodically updated in shared_info, and then copied here. */
 struct shadow_time_info {
@@ -34,20 +27,6 @@ struct shadow_time_info {
 };
 =

 static DEFINE_PER_CPU(struct shadow_time_info, shadow_time);
-
-/* Keep track of last time we did processing/updating of jiffies and xtime=
. */
-static u64 processed_system_time;   /* System time (ns) at last processing=
. */
-static DEFINE_PER_CPU(u64, processed_system_time);
-
-/* How much CPU time was spent blocked and how much was 'stolen'? */
-static DEFINE_PER_CPU(u64, processed_stolen_time);
-static DEFINE_PER_CPU(u64, processed_blocked_time);
-
-/* Current runstate of each CPU (updated automatically by the hypervisor).=
 */
-static DEFINE_PER_CPU(struct vcpu_runstate_info, runstate);
-
-/* Must be signed, as it's compared with s64 quantities which can be -ve. =
*/
-#define NS_PER_TICK (1000000000LL/HZ)
 =

 unsigned long xen_cpu_khz(void)
 {
@@ -87,19 +66,6 @@ static void get_time_values_from_xen(voi
 	} while ((src->version & 1) | (dst->version ^ src->version));
 =

 	put_cpu_var(shadow_time);
-}
-
-static inline int time_values_up_to_date(void)
-{
-	struct vcpu_time_info   *src;
-	unsigned dstversion;
-
-	src =3D &read_pda(xen.vcpu)->time;
-	dstversion =3D get_cpu_var(shadow_time).version;
-	put_cpu_var(shadow_time);
-
-	rmb();
-	return (dstversion =3D=3D src->version);
 }
 =

 /*
@@ -148,104 +114,6 @@ static u64 get_nsec_offset(struct shadow
 	return scale_delta(delta, shadow->tsc_to_nsec_mul, shadow->tsc_shift);
 }
 =

-
-static void xen_timer_interrupt_hook(void)
-{
-	s64 delta, delta_cpu, stolen, blocked;
-	u64 sched_time;
-	int i, cpu =3D smp_processor_id();
-	unsigned long ticks;
-	struct shadow_time_info *shadow =3D &__get_cpu_var(shadow_time);
-	struct vcpu_runstate_info *runstate =3D &__get_cpu_var(runstate);
-
-	do {
-		get_time_values_from_xen();
-
-		/* Obtain a consistent snapshot of elapsed wallclock cycles. */
-		delta =3D delta_cpu =3D
-			shadow->system_timestamp + get_nsec_offset(shadow);
-		if (0)
-			printk("tsc_timestamp=3D%llu system_timestamp=3D%llu tsc_to_nsec=3D%u t=
sc_shift=3D%d, version=3D%u, delta=3D%lld processed_system_time=3D%lld\n",
-			       shadow->tsc_timestamp, shadow->system_timestamp,
-			       shadow->tsc_to_nsec_mul, shadow->tsc_shift,
-			       shadow->version, delta, processed_system_time);
-
-		delta     -=3D processed_system_time;
-		delta_cpu -=3D __get_cpu_var(processed_system_time);
-
-		/*
-		 * Obtain a consistent snapshot of stolen/blocked cycles. We
-		 * can use state_entry_time to detect if we get preempted here.
-		 */
-		do {
-			sched_time =3D runstate->state_entry_time;
-			barrier();
-			stolen =3D runstate->time[RUNSTATE_runnable] +
-				runstate->time[RUNSTATE_offline] -
-				__get_cpu_var(processed_stolen_time);
-			blocked =3D runstate->time[RUNSTATE_blocked] -
-				__get_cpu_var(processed_blocked_time);
-			barrier();
-		} while (sched_time !=3D runstate->state_entry_time);
-	} while (!time_values_up_to_date());
-
-	if ((unlikely(delta < -(s64)permitted_clock_jitter) ||
-	     unlikely(delta_cpu < -(s64)permitted_clock_jitter))
-	    && printk_ratelimit()) {
-		printk("Timer ISR/%d: Time went backwards: "
-		       "delta=3D%lld delta_cpu=3D%lld shadow=3D%lld "
-		       "off=3D%lld processed=3D%lld cpu_processed=3D%lld\n",
-		       cpu, delta, delta_cpu, shadow->system_timestamp,
-		       (s64)get_nsec_offset(shadow),
-		       processed_system_time,
-		       __get_cpu_var(processed_system_time));
-		for (i =3D 0; i < num_online_cpus(); i++)
-			printk(" %d: %lld\n", i,
-			       per_cpu(processed_system_time, i));
-	}
-
-	/* System-wide jiffy work. */
-	ticks =3D 0;
-	while(delta > NS_PER_TICK) {
-		delta -=3D NS_PER_TICK;
-		processed_system_time +=3D NS_PER_TICK;
-		ticks++;
-	}
-	do_timer(ticks);
-
-	/*
-	 * Account stolen ticks.
-	 * HACK: Passing NULL to account_steal_time()
-	 * ensures that the ticks are accounted as stolen.
-	 */
-	if ((stolen > 0) && (delta_cpu > 0)) {
-		delta_cpu -=3D stolen;
-		if (unlikely(delta_cpu < 0))
-			stolen +=3D delta_cpu; /* clamp local-time progress */
-		do_div(stolen, NS_PER_TICK);
-		__get_cpu_var(processed_stolen_time) +=3D stolen * NS_PER_TICK;
-		__get_cpu_var(processed_system_time) +=3D stolen * NS_PER_TICK;
-		account_steal_time(NULL, (cputime_t)stolen);
-	}
-
-	/*
-	 * Account blocked ticks.
-	 * HACK: Passing idle_task to account_steal_time()
-	 * ensures that the ticks are accounted as idle/wait.
-	 */
-	if ((blocked > 0) && (delta_cpu > 0)) {
-		delta_cpu -=3D blocked;
-		if (unlikely(delta_cpu < 0))
-			blocked +=3D delta_cpu; /* clamp local-time progress */
-		do_div(blocked, NS_PER_TICK);
-		__get_cpu_var(processed_blocked_time) +=3D blocked * NS_PER_TICK;
-		__get_cpu_var(processed_system_time)  +=3D blocked * NS_PER_TICK;
-		account_steal_time(idle_task(cpu), (cputime_t)blocked);
-	}
-
-	update_process_times(user_mode_vm(get_irq_regs()));
-}
-
 static cycle_t xen_clocksource_read(void)
 {
 	struct shadow_time_info *shadow =3D &get_cpu_var(shadow_time);
@@ -300,7 +168,7 @@ int xen_set_wallclock(unsigned long now)
 	return -1;
 }
 =

-static struct clocksource xen_clocksource =3D {
+static struct clocksource xen_clocksource __read_mostly =3D {
 	.name =3D "xen",
 	.rating =3D 400,
 	.read =3D xen_clocksource_read,
@@ -310,64 +178,227 @@ static struct clocksource xen_clocksourc
 	.flags =3D CLOCK_SOURCE_IS_CONTINUOUS,
 };
 =

-static void init_missing_ticks_accounting(int cpu)
-{
-	struct vcpu_register_runstate_memory_area area;
-	struct vcpu_runstate_info *runstate =3D &per_cpu(runstate, cpu);
-
-	memset(runstate, 0, sizeof(*runstate));
-
-	area.addr.v =3D runstate;
-	HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area, cpu, &area);
-
-	per_cpu(processed_blocked_time, cpu) =3D
-		runstate->time[RUNSTATE_blocked];
-	per_cpu(processed_stolen_time, cpu) =3D
-		runstate->time[RUNSTATE_runnable] +
-		runstate->time[RUNSTATE_offline];
-}
-
-static irqreturn_t xen_timer_interrupt(int irq, void *dev_id)
-{
-	/*
-	 * Here we are in the timer irq handler. We just have irqs locally
-	 * disabled but we don't know if the timer_bh is running on the other
-	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
-	 * the irq version of write_lock because as just said we have irq
-	 * locally disabled. -arca
-	 */
-	write_seqlock(&xtime_lock);
-
-	xen_timer_interrupt_hook();
-
-	write_sequnlock(&xtime_lock);
-
-	return IRQ_HANDLED;
-}
-
-static void setup_cpu0_timer_irq(void)
-{
-	printk(KERN_DEBUG "installing Xen timer for CPU 0\n");
-
-	bind_virq_to_irqhandler(
-		VIRQ_TIMER,
-		0,
-		xen_timer_interrupt,
-		SA_INTERRUPT,
-		"timer0",
-		NULL);
+
+/*
+   Xen clockevent implementation
+
+   Xen has two clockevent implementations:
+
+   The old timer_op one works with all released versions of Xen prior
+   to version 3.0.4.  This version of the hypervisor provides a
+   single-shot timer with nanosecond resolution.  However, sharing the
+   same event channel is a 100Hz tick which is delivered while the
+   vcpu is running.  We don't care about or use this tick, so it
+   appears as a stream of spurious timer events which need to be
+   filtered out.
+
+   The new vcpu_op-based timer interface allows the tick timer period
+   to be changed or turned off.  The tick timer is not useful as a
+   periodic timer because events are only delivered to running vcpus.
+   The one-shot timer can report when a timeout is in the past, so
+   set_next_event is capable of returning -ETIME when appropriate.
+   This interface is used when available.
+*/
+
+
+/*
+  Get a hypervisor absolute time.  In theory we could maintain an
+  offset between the kernel's time and the hypervisor's time, and
+  apply that to a kernel's absolute timeout.  Unfortunately the
+  hypervisor and kernel times can drift even if the kernel is using
+  the Xen clocksource, because ntp can warp the kernel's clocksource.
+*/
+static s64 get_abs_timeout(unsigned long delta)
+{
+	return xen_clocksource_read() + delta;
+}
+
+static void xen_timerop_set_mode(enum clock_event_mode mode,
+				 struct clock_event_device *evt)
+{
+	switch(mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* unsupported */
+		WARN_ON(1);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		HYPERVISOR_set_timer_op(0);  /* cancel timeout */
+		break;
+	}
+}
+
+static int xen_timerop_set_next_event(unsigned long delta,
+				      struct clock_event_device *evt)
+{
+	WARN_ON(evt->mode !=3D CLOCK_EVT_MODE_ONESHOT);
+
+	if (HYPERVISOR_set_timer_op(get_abs_timeout(delta)) < 0)
+		BUG();
+
+	/* We may have missed the deadline, but there's no real way of
+	   knowing for sure.  If the event was in the past, then we'll
+	   get an immediate interrupt. */
+
+	return 0;
+}
+
+static irqreturn_t xen_timerop_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt =3D &__get_cpu_var(xen_clock_events);
+	irqreturn_t ret;
+
+	ret =3D IRQ_NONE;
+	if (evt->event_handler) {
+		cycle_t now =3D xen_clocksource_read();
+		s64 offset =3D now - ktime_to_ns(ktime_get());
+		s64 event =3D offset + ktime_to_ns(evt->next_event);
+
+		/* filter out spurious tick timer events */
+		if ((now+TIMER_SLOP) >=3D event)
+			evt->event_handler(evt);
+		ret =3D IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static const struct clock_event_device xen_timerop_clockevent =3D {
+	.name =3D "xen",
+	.features =3D CLOCK_EVT_FEAT_ONESHOT,
+
+	.max_delta_ns =3D 0xffffffff,
+	.min_delta_ns =3D TIMER_SLOP,
+
+	.mult =3D 1,
+	.shift =3D 0,
+	.rating =3D 500,
+
+	.set_mode =3D xen_timerop_set_mode,
+	.set_next_event =3D xen_timerop_set_next_event,
+};
+
+
+
+static void xen_vcpuop_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	int cpu =3D smp_processor_id();
+
+	switch(mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		WARN_ON(1);	/* unsupported */
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, cpu, NULL))
+			BUG();
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		if (HYPERVISOR_vcpu_op(VCPUOP_stop_singleshot_timer, cpu, NULL) ||
+		    HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, cpu, NULL))
+			BUG();
+		break;
+	}
+}
+
+static int xen_vcpuop_set_next_event(unsigned long delta,
+				     struct clock_event_device *evt)
+{
+	int cpu =3D smp_processor_id();
+	struct vcpu_set_singleshot_timer single;
+	int ret;
+
+	WARN_ON(evt->mode !=3D CLOCK_EVT_MODE_ONESHOT);
+
+	single.timeout_abs_ns =3D get_abs_timeout(delta);
+	single.flags =3D VCPU_SSHOTTMR_future;
+
+	ret =3D HYPERVISOR_vcpu_op(VCPUOP_set_singleshot_timer, cpu, &single);
+
+	BUG_ON(ret !=3D 0 && ret !=3D -ETIME);
+
+	return ret;
+}
+
+static irqreturn_t xen_vcpuop_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt =3D &__get_cpu_var(xen_clock_events);
+	irqreturn_t ret;
+
+	ret =3D IRQ_NONE;
+	if (evt->event_handler) {
+		evt->event_handler(evt);
+		ret =3D IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static const struct clock_event_device xen_vcpuop_clockevent =3D {
+	.name =3D "xen",
+	.features =3D CLOCK_EVT_FEAT_ONESHOT,
+
+	.max_delta_ns =3D 0xffffffff,
+	.min_delta_ns =3D TIMER_SLOP,
+
+	.mult =3D 1,
+	.shift =3D 0,
+	.rating =3D 500,
+
+	.set_mode =3D xen_vcpuop_set_mode,
+	.set_next_event =3D xen_vcpuop_set_next_event,
+};
+
+static const struct clock_event_device *xen_clockevent =3D &xen_timerop_cl=
ockevent;
+static irq_handler_t xen_timer_interrupt =3D xen_timerop_timer_interrupt;
+
+static void xen_setup_timer(int cpu)
+{
+	const char *name;
+	struct clock_event_device *evt;
+	int irq;
+
+	printk("installing Xen timer for CPU %d\n", cpu);
+
+	name =3D kasprintf(GFP_KERNEL, "timer%d", cpu);
+	if (!name)
+		name =3D "<timer kasprintf failed>";
+
+	irq =3D bind_virq_to_irqhandler(VIRQ_TIMER, cpu, xen_timer_interrupt,
+				      SA_INTERRUPT, name, NULL);
+
+	evt =3D &get_cpu_var(xen_clock_events);
+	memcpy(evt, xen_clockevent, sizeof(*evt));
+
+	evt->cpumask =3D cpumask_of_cpu(cpu);
+	evt->irq =3D irq;
+	clockevents_register_device(evt);
+
+	put_cpu_var(xen_clock_events);
 }
 =

 __init void xen_time_init(void)
 {
+	int cpu =3D smp_processor_id();
+
 	get_time_values_from_xen();
 =

-	processed_system_time =3D per_cpu(shadow_time, 0).system_timestamp;
-	per_cpu(processed_system_time, 0) =3D processed_system_time;
-
-	init_missing_ticks_accounting(0);
-
 	clocksource_register(&xen_clocksource);
+
+	if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, cpu, NULL) =3D=3D 0) {
+		/* Successfully turned off 100hz tick, so we have the
+		   vcpuop-based timer interface */
+		printk(KERN_DEBUG "Xen: using vcpuop timer interface\n");
+		xen_clockevent =3D &xen_vcpuop_clockevent;
+		xen_timer_interrupt =3D xen_vcpuop_timer_interrupt;
+	}
 =

 	/* Set initial system time with full resolution */
 	xen_read_wallclock(&xtime);
@@ -376,70 +407,5 @@ __init void xen_time_init(void)
 =

 	tsc_disable =3D 0;
 =

-	setup_cpu0_timer_irq();
-}
-
-/* Convert jiffies to system time. */
-static u64 jiffies_to_st(unsigned long j)
-{
-	unsigned long seq;
-	long delta;
-	u64 st;
-
-	do {
-		seq =3D read_seqbegin(&xtime_lock);
-		delta =3D j - jiffies;
-		if (delta < 1) {
-			/* Triggers in some wrap-around cases, but that's okay:
-			 * we just end up with a shorter timeout. */
-			st =3D processed_system_time + NS_PER_TICK;
-		} else if (((unsigned long)delta >> (BITS_PER_LONG-3)) !=3D 0) {
-			/* Very long timeout means there is no pending timer.
-			 * We indicate this to Xen by passing zero timeout. */
-			st =3D 0;
-		} else {
-			st =3D processed_system_time + delta * (u64)NS_PER_TICK;
-		}
-	} while (read_seqretry(&xtime_lock, seq));
-
-	return st;
-}
-
-/*
- * stop_hz_timer / start_hz_timer - enter/exit 'tickless mode' on an idle =
cpu
- * These functions are based on implementations from arch/s390/kernel/time=
.c
- */
-void stop_hz_timer(void)
-{
-	unsigned int cpu =3D smp_processor_id();
-	unsigned long j;
-
-	cpu_set(cpu, nohz_cpu_mask);
-
-	/*
-	 * See matching smp_mb in rcu_start_batch in rcupdate.c.  These mbs
-	 * ensure that if __rcu_pending (nested in rcu_needs_cpu) fetches a
-	 * value of rcp->cur that matches rdp->quiescbatch and allows us to
-	 * stop the hz timer then the cpumasks created for subsequent values
-	 * of cur in rcu_start_batch are guaranteed to pick up the updated
-	 * nohz_cpu_mask and so will not depend on this cpu.
-	 */
-
-	smp_mb();
-
-	/* Leave ourselves in tick mode if rcu or softirq or timer pending. */
-	if (rcu_needs_cpu(cpu) || local_softirq_pending() ||
-	    (j =3D next_timer_interrupt(), time_before_eq(j, jiffies))) {
-		cpu_clear(cpu, nohz_cpu_mask);
-		j =3D jiffies + 1;
-	}
-
-	if (HYPERVISOR_set_timer_op(jiffies_to_st(j)) !=3D 0)
-		BUG();
-}
-
-void start_hz_timer(void)
-{
-	cpu_clear(smp_processor_id(), nohz_cpu_mask);
-}
-
+	xen_setup_timer(cpu);
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/xen-ops.h
+++ b/arch/i386/xen/xen-ops.h
@@ -17,9 +17,6 @@ int xen_set_wallclock(unsigned long time
 =

 void xen_mark_init_mm_pinned(void);
 =

-void stop_hz_timer(void);
-void start_hz_timer(void);
-
 DECLARE_PER_CPU(unsigned, xen_lazy_mode);
 =

 static inline unsigned xen_get_lazy_mode(void)

-- =
