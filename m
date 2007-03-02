From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 7/9] Fix nohz compile.patch
Date: Thu, 1 Mar 2007 18:55:37 -0800
Message-ID: <200703020255.l222tb5W009688@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422797AbXCBC4u@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <ingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

More goo from hrtimers integration.  We do compile and run properly with NO_HZ
enabled.  There was a period when we didn't because of a missing export, but
that was since fixed.

And with the clocksource code now firmly in place, we can get rid of code
that fixes up the wallclock, since this is done in the common infrastructure.
This actually fixes a timer bug as well, that was caused by do_settimeofday
no longer being callable with interrupts disabled due to the use of
on_each_cpu().

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 5d41588419ab arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Feb 27 17:24:55 2007 -0800
+++ b/arch/i386/Kconfig	Tue Feb 27 17:25:44 2007 -0800
@@ -220,7 +220,7 @@ config PARAVIRT
 
 config VMI
 	bool "VMI Paravirt-ops support"
-	depends on PARAVIRT && !NO_HZ
+	depends on PARAVIRT
 	default y
 	help
 	  VMI provides a paravirtualized interface to multiple hypervisors
diff -r 5d41588419ab arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Tue Feb 27 17:24:55 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Tue Feb 27 18:46:26 2007 -0800
@@ -934,6 +934,7 @@ void __init vmi_init(void)
 #ifdef CONFIG_X86_IO_APIC
 	no_timer_check = 1;
 #endif
+	no_sync_cmos_clock = 1;
 
 	local_irq_restore(flags & X86_EFLAGS_IF);
 }
diff -r 5d41588419ab arch/i386/kernel/vmitime.c
--- a/arch/i386/kernel/vmitime.c	Tue Feb 27 17:24:55 2007 -0800
+++ b/arch/i386/kernel/vmitime.c	Tue Feb 27 18:47:51 2007 -0800
@@ -153,13 +153,6 @@ static void vmi_get_wallclock_ts(struct 
 	ts->tv_sec = wallclock;
 }
 
-static void update_xtime_from_wallclock(void)
-{
-	struct timespec ts;
-	vmi_get_wallclock_ts(&ts);
-	do_settimeofday(&ts);
-}
-
 unsigned long vmi_get_wallclock(void)
 {
 	struct timespec ts;
@@ -197,18 +190,10 @@ void __init vmi_time_init(void)
 	set_intr_gate(LOCAL_TIMER_VECTOR, apic_vmi_timer_interrupt);
 #endif
 
-	no_sync_cmos_clock = 1;
-
-	vmi_get_wallclock_ts(&xtime);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
-
 	real_cycles_accounted_system = read_real_cycles();
-	update_xtime_from_wallclock();
 	per_cpu(process_times_cycles_accounted_cpu, 0) = read_available_cycles();
 
 	cycles_per_sec = vmi_timer_ops.get_cycle_frequency();
-
 	cycles_per_jiffy = cycles_per_sec;
 	(void)do_div(cycles_per_jiffy, HZ);
 	cycles_per_alarm = cycles_per_sec;
