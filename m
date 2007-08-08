From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 19/25] [PATCH] time-related functions paravirt provisions
Date: Wed,  8 Aug 2007 01:19:06 -0300
Message-ID: <11865468281860-git-send-email-gcosta__32416.0234340981$1186559720$gmane$org@redhat.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865467592921-git-send-email-gcosta@redhat.com>
	<1186546763582-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
	<11865467702103-git-send-email-gcosta@redhat.com>
	<11865467741753-git-send-email-gcosta@redhat.com>
	<11865467773012-git-send-email-gcosta@redhat.com>
	<11865467812610-git-send-email-gcosta@redhat.com>
	<1186546785346-git-send-email-gcosta@redhat.com>
	<1186546789356-git-send-email-gcosta@redhat.com>
	<11865467931543-git-send-email-gcosta@redhat.com>
	<11865467973510-git-send-email-gcosta@redhat.com>
	<11865468003673-git-send-email-gcosta@redhat.com>
	<11865468043920-git-send-email-gcosta@redhat.com>
	<118654680831-git-send-email-gcosta@redhat.com>
	<11865468122642-git-send-email-gcosta@redhat.com>
	<11865468162812-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865468243612-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch add provisions for time related functions so they
can be later replaced by paravirt versions.

it basically encloses {g,s}et_wallclock inside the
already existent functions update_persistent_clock and
read_persistent_clock, and defines {s,g}et_wallclock
to the core of such functions.

The timer interrupt setup also have to be replaced.
The job is done by time_init_hook().

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86_64/kernel/time.c |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 6d48a4e..29fcd91 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -42,6 +42,7 @@
 #include <asm/sections.h>
 #include <linux/hpet.h>
 #include <asm/apic.h>
+#include <asm/time.h>
 #include <asm/hpet.h>
 #include <asm/mpspec.h>
 #include <asm/nmi.h>
@@ -82,18 +83,12 @@ EXPORT_SYMBOL(profile_pc);
  * sheet for details.
  */
 
-static int set_rtc_mmss(unsigned long nowtime)
+int do_set_rtc_mmss(unsigned long nowtime)
 {
 	int retval = 0;
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char control, freq_select;
 
-/*
- * IRQs are disabled when we're called from the timer interrupt,
- * no need for spin_lock_irqsave()
- */
-
-	spin_lock(&rtc_lock);
 
 /*
  * Tell the clock it's being set and stop it.
@@ -143,14 +138,22 @@ static int set_rtc_mmss(unsigned long nowtime)
 	CMOS_WRITE(control, RTC_CONTROL);
 	CMOS_WRITE(freq_select, RTC_FREQ_SELECT);
 
-	spin_unlock(&rtc_lock);
-
 	return retval;
 }
 
 int update_persistent_clock(struct timespec now)
 {
-	return set_rtc_mmss(now.tv_sec);
+	int retval;
+
+/*
+ * IRQs are disabled when we're called from the timer interrupt,
+ * no need for spin_lock_irqsave()
+ */
+	spin_lock(&rtc_lock);
+	retval = set_wallclock(now.tv_sec);
+	spin_unlock(&rtc_lock);
+
+	return retval;
 }
 
 void main_timer_handler(void)
@@ -195,7 +198,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-unsigned long read_persistent_clock(void)
+unsigned long do_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
@@ -246,6 +249,11 @@ unsigned long read_persistent_clock(void)
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+unsigned long read_persistent_clock(void)
+{
+	return get_wallclock();
+}
+
 /* calibrate_cpu is used on systems with fixed rate TSCs to determine
  * processor frequency */
 #define TICK_COUNT 100000000
@@ -365,6 +373,11 @@ static struct irqaction irq0 = {
 	.name		= "timer"
 };
 
+inline void time_init_hook()
+{
+	setup_irq(0, &irq0);
+}
+
 void __init time_init(void)
 {
 	if (nohpet)
@@ -403,7 +416,7 @@ void __init time_init(void)
 		cpu_khz / 1000, cpu_khz % 1000);
 	init_tsc_clocksource();
 
-	setup_irq(0, &irq0);
+	do_time_init();
 }
 
 /*
-- 
1.4.4.2
