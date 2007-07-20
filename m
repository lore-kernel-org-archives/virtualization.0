From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] lguest: override sched_clock
Date: Fri, 20 Jul 2007 22:15:01 +1000
Message-ID: <1184933701.10380.303.camel__3209.97585445202$1184933867$gmane$org@localhost.localdomain>
References: <1184933473.10380.296.camel@localhost.localdomain>
	<1184933576.10380.299.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184933576.10380.299.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Guests currently use the default scheduler clock: this means they
always use jiffies even if TSC is actually available.  It doesn't make
any noticeable difference here, but it's a better thing to do.

Also remove commented-out asm/sched-clock.h from -mm tree.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -r d9973bf15010 drivers/lguest/lguest.c
--- a/drivers/lguest/lguest.c	Fri Jul 20 21:40:49 2007 +1000
+++ b/drivers/lguest/lguest.c	Fri Jul 20 22:08:10 2007 +1000
@@ -39,7 +39,6 @@
 #include <asm/e820.h>
 #include <asm/mce.h>
 #include <asm/io.h>
-//#include <asm/sched-clock.h>
 
 /* Declarations for definitions in lguest_guest.S */
 extern char lguest_noirq_start[], lguest_noirq_end[];
@@ -57,6 +56,7 @@ struct lguest_data lguest_data = {
 	.blocked_interrupts = { 1 }, /* Block timer interrupts */
 };
 struct lguest_device_desc *lguest_devices;
+static cycle_t clock_base;
 
 static enum paravirt_lazy_mode lazy_mode;
 static void lguest_lazy_mode(enum paravirt_lazy_mode mode)
@@ -363,6 +363,11 @@ static struct clocksource lguest_clock =
 	.read		= lguest_clock_read,
 };
 
+static unsigned long long lguest_sched_clock(void)
+{
+	return cyc2ns(&lguest_clock, lguest_clock_read() - clock_base);
+}
+
 /* We also need a "struct clock_event_device": Linux asks us to set it to go
  * off some time in the future.  Actually, James Morris figured all this out, I
  * just applied the patch. */
@@ -439,6 +444,7 @@ static void lguest_time_init(void)
 		lguest_clock.mult = (((u64)NSEC_PER_SEC<<8)/ACTHZ) << 8;
 		lguest_clock.mask = CLOCKSOURCE_MASK(32);
 	}
+	clock_base = lguest_clock_read();
 	clocksource_register(&lguest_clock);
 
 	/* We can't set cpumask in the initializer: damn C limitations! */
@@ -584,6 +590,7 @@ __init void lguest_init(void *boot)
 	paravirt_ops.time_init = lguest_time_init;
 	paravirt_ops.set_lazy_mode = lguest_lazy_mode;
 	paravirt_ops.wbinvd = lguest_wbinvd;
+	paravirt_ops.sched_clock = lguest_sched_clock;
 
 	hcall(LHCALL_LGUEST_INIT, __pa(&lguest_data), 0, 0);
