From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 13/17] paravirt_ops - time updates
Date: Thu, 08 Mar 2007 01:02:31 -0500
Message-ID: <1173333751.25848.14.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-time.patch)
General time changes for paravirt_ops.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: clean-start/include/asm-x86_64/time.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ clean-start/include/asm-x86_64/time.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_X86_64_TIME_H
+#define _ASM_X86_64_TIME_H
+
+inline void time_init_hook(void);
+unsigned long do_get_cmos_time(void);
+void do_set_rtc_mmss(unsigned long nowtime);
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else /* !CONFIG_PARAVIRT */
+
+#define get_wallclock() do_get_cmos_time()
+#define set_wallclock(x) do_set_rtc_mmss(x)
+#define do_time_init() time_init_hook()
+
+#endif /* CONFIG_PARAVIRT */
+
+#endif
Index: clean-start/arch/x86_64/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/time.c
+++ clean-start/arch/x86_64/kernel/time.c
@@ -42,6 +42,7 @@
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
 #include <asm/apic.h>
+#include <asm/time.h>
 =

 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
@@ -204,17 +205,11 @@ EXPORT_SYMBOL(profile_pc);
  * sheet for details.
  */
 =

-static void set_rtc_mmss(unsigned long nowtime)
+void do_set_rtc_mmss(unsigned long nowtime)
 {
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char control, freq_select;
 =

-/*
- * IRQs are disabled when we're called from the timer interrupt,
- * no need for spin_lock_irqsave()
- */
-
-	spin_lock(&rtc_lock);
 =

 /*
  * Tell the clock it's being set and stop it.
@@ -263,9 +258,18 @@ static void set_rtc_mmss(unsigned long n
 	CMOS_WRITE(control, RTC_CONTROL);
 	CMOS_WRITE(freq_select, RTC_FREQ_SELECT);
 =

-	spin_unlock(&rtc_lock);
 }
 =

+static void set_rtc_mmss(unsigned long nowtime)
+{
+/*
+ * IRQs are disabled when we're called from the timer interrupt,
+ * no need for spin_lock_irqsave()
+ */
+	spin_lock(&rtc_lock);
+	set_wallclock(nowtime);
+	spin_unlock(&rtc_lock);
+}
 =

 /* monotonic_clock(): returns # of nanoseconds passed since time_init()
  *		Note: This function is required to return accurate
@@ -494,13 +498,11 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 =

-static unsigned long get_cmos_time(void)
+unsigned long do_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	unsigned long flags;
 	unsigned extyear =3D 0;
 =

-	spin_lock_irqsave(&rtc_lock, flags);
 =

 	do {
 		sec =3D CMOS_READ(RTC_SECONDS);
@@ -516,7 +518,6 @@ static unsigned long get_cmos_time(void)
 #endif
 	} while (sec !=3D CMOS_READ(RTC_SECONDS));
 =

-	spin_unlock_irqrestore(&rtc_lock, flags);
 =

 	/*
 	 * We know that x86-64 always uses BCD format, no need to check the
@@ -545,6 +546,15 @@ static unsigned long get_cmos_time(void)
 	return mktime(year, mon, day, hour, min, sec);
 }
 =

+static unsigned long get_cmos_time(void)
+{
+	unsigned long retval, flags;
+	/* XXX : lock being held more than necessary. */
+	spin_lock_irqsave(&rtc_lock, flags);
+	retval =3D get_wallclock();
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return retval;
+}
 #ifdef CONFIG_CPU_FREQ
 =

 /* Frequency scaling support. Adjust the TSC based timer when the cpu freq=
uency
@@ -893,6 +903,11 @@ static struct irqaction irq0 =3D {
 	timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL
 };
 =

+inline void time_init_hook()
+{
+	setup_irq(0, &irq0);
+}
+
 void __init time_init(void)
 {
 	if (nohpet)
@@ -932,7 +947,7 @@ void __init time_init(void)
 	vxtime.tsc_quot =3D (USEC_PER_MSEC << US_SCALE) / cpu_khz;
 	vxtime.last_tsc =3D get_cycles_sync();
 	set_cyc2ns_scale(cpu_khz);
-	setup_irq(0, &irq0);
+	do_time_init();
 =

 #ifndef CONFIG_SMP
 	time_init_gtod();
Index: clean-start/include/asm-x86_64/timex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/timex.h
+++ clean-start/include/asm-x86_64/timex.h
@@ -31,14 +31,29 @@ static __always_inline cycles_t get_cycl
 {
 	unsigned long long ret;
 	unsigned eax;
+	unsigned int (*fn)(unsigned int) =3D &cpuid_eax;
 	/* Don't do an additional sync on CPUs where we know
 	   RDTSC is already synchronous. */
-	alternative_io("cpuid", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
-			  "=3Da" (eax), "0" (1) : "ebx","ecx","edx","memory");
+	alternative_io("call *%3", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
+			"=3Da" (eax) , "D" (1) , "m" (fn));
 	rdtscll(ret);
 	return ret;
 }
 =

+/* Inside a vsyscall, we cannot call paravirt functions. (like rdtsc
+ * and cpuid). For the host, use this function instead */
+static __always_inline cycles_t vget_cycles_sync(void)
+{
+	unsigned long ret;
+	unsigned eax;
+	/* Don't do an additional sync on CPUs where we know
+	   RDTSC is already synchronous. */
+	alternative_io("cpuid", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
+			  "=3Da" (eax), "0" (1) : "ebx","ecx","edx","memory");
+
+	asm volatile("rdtsc" : "=3DA" (ret));
+	return ret;
+}
 extern unsigned int cpu_khz;
 =

 extern int read_current_timer(unsigned long *timer_value);

--
