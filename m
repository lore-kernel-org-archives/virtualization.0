From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/2] lguest: handle dodgy/non-existent TSC.  Guest code.
Date: Wed, 04 Jul 2007 16:20:33 +1000
Message-ID: <1183530033.6005.3.camel@localhost.localdomain>
References: <1183529972.6005.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183529972.6005.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: virtualization <virtualization@lists.linux-foundation.org>, Matt Mackall <mpm@selenic.com>
List-Id: virtualization@lists.linuxfoundation.org

We create an "lguest_clock" which the guest uses: either TSC or
jiffies, depending on whether the host tells us the TSC frequency.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c |   51 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

===================================================================
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -212,8 +212,8 @@ static void lguest_cpuid(unsigned int *e
 	case 1:	/* Basic feature request. */
 		/* We only allow kernel to see SSE3, CMPXCHG16B and SSSE3 */
 		*ecx &= 0x00002201;
-		/* SSE, SSE2, FXSR, MMX, CMOV, CMPXCHG8B, TSC, FPU. */
-		*edx &= 0x07808111;
+		/* SSE, SSE2, FXSR, MMX, CMOV, CMPXCHG8B, FPU. */
+		*edx &= 0x07808101;
 		/* Host wants to know when we flush kernel pages: set PGE. */
 		*edx |= 0x00002000;
 		break;
@@ -348,16 +348,19 @@ static unsigned long lguest_get_wallcloc
 	return hcall(LHCALL_GET_WALLCLOCK, 0, 0, 0);
 }
 
-/* This is what we tell the kernel is our clocksource.  It's the normal "Time
- * Stamp Counter": the Host tells us what speed it's going at. */
+static cycle_t lguest_clock_read(void)
+{
+	if (lguest_data.tsc_khz)
+		return native_read_tsc();
+	else
+		return jiffies;
+}
+
+/* This is what we tell the kernel is our clocksource.  */
 static struct clocksource lguest_clock = {
 	.name		= "lguest",
 	.rating		= 400,
-	.read		= native_read_tsc,
-	.mask		= CLOCKSOURCE_MASK(64),
-	.mult		= 0, /* to be set */
-	.shift		= 22,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read		= lguest_clock_read,
 };
 
 /* We also need a "struct clock_event_device": Linux asks us to set it to go
@@ -414,14 +417,6 @@ static void lguest_time_irq(unsigned int
 {
 	unsigned long flags;
 
-	/* Check in case host TSC has changed rate. */
-	if (unlikely(tsc_khz != lguest_data.tsc_khz)) {
-		tsc_khz = lguest_data.tsc_khz;
-		lguest_clock.mult = clocksource_khz2mult(tsc_khz, 22);
-		__get_cpu_var(sc_data).cyc2ns_scale
-			= (1000000 << CYC2NS_SCALE_FACTOR) / tsc_khz;
-	}
-
 	/* Don't interrupt us while this is running. */
 	local_irq_save(flags);
 	lguest_clockevent.event_handler(&lguest_clockevent);
@@ -432,7 +427,20 @@ static void lguest_time_init(void)
 {
 	set_irq_handler(0, lguest_time_irq);
 
-	lguest_clock.mult = clocksource_khz2mult(tsc_khz, 22);
+	/* We use the TSC if the Host tells us we can, otherwise a dumb
+	 * jiffies-based clock. */
+	if (lguest_data.tsc_khz) {
+		lguest_clock.shift = 22;
+		lguest_clock.mult = clocksource_khz2mult(lguest_data.tsc_khz,
+							 lguest_clock.shift);
+		lguest_clock.mask = CLOCKSOURCE_MASK(64);
+		lguest_clock.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	} else {
+		/* To understand this, start at kernel/time/jiffies.c... */
+		lguest_clock.shift = 8;
+		lguest_clock.mult = (((u64)NSEC_PER_SEC<<8)/ACTHZ) << 8;
+		lguest_clock.mask = CLOCKSOURCE_MASK(32);
+	}
 	clocksource_register(&lguest_clock);
 
 	/* We can't set cpumask in the initializer: damn C limitations! */
@@ -440,12 +448,6 @@ static void lguest_time_init(void)
 	clockevents_register_device(&lguest_clockevent);
 
 	enable_lguest_irq(0);
-}
-
-static unsigned long lguest_get_cpu_khz(void)
-{
-	/* The Host tells us the TSC speed */
-	return lguest_data.tsc_khz;
 }
 
 static void lguest_load_esp0(struct tss_struct *tss,
@@ -584,7 +586,6 @@ __init void lguest_init(void *boot)
 	paravirt_ops.time_init = lguest_time_init;
 	paravirt_ops.set_lazy_mode = lguest_lazy_mode;
 	paravirt_ops.wbinvd = lguest_wbinvd;
-	paravirt_ops.get_cpu_khz = lguest_get_cpu_khz;
 
 	hcall(LHCALL_LGUEST_INIT, __pa(&lguest_data), 0, 0);
