From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/4] kvm/guest: fix paravirt clocksource to be
	compartible with xen.
Date: Fri, 16 May 2008 10:01:25 +0200
Message-ID: <1210924885-5353-5-git-send-email-kraxel@redhat.com>
References: <1210924885-5353-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1210924885-5353-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: virtualization@lists.osdl.org, kvm-devel@lists.sourceforge.net
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/Kconfig           |    1 +
 arch/x86/kernel/kvmclock.c |   86 ++++++++++++++++---------------------------
 2 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index deb3049..b749c85 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -390,6 +390,7 @@ config VMI
 config KVM_CLOCK
 	bool "KVM paravirtualized clock"
 	select PARAVIRT
+	select PARAVIRT_CLOCK
 	depends on !(X86_VISWS || X86_VOYAGER)
 	help
 	  Turning on this option will allow you to run a paravirtualized clock
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4bc1be5..135a8f7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -18,6 +18,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/kvm_para.h>
+#include <asm/pvclock.h>
 #include <asm/arch_hooks.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
@@ -37,17 +38,9 @@ early_param("no-kvmclock", parse_no_kvmclock);
 
 /* The hypervisor will put information about time periodically here */
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct kvm_vcpu_time_info, hv_clock);
-#define get_clock(cpu, field) per_cpu(hv_clock, cpu).field
-
-static inline u64 kvm_get_delta(u64 last_tsc)
-{
-	int cpu = smp_processor_id();
-	u64 delta = native_read_tsc() - last_tsc;
-	return (delta * get_clock(cpu, tsc_to_system_mul)) >> KVM_SCALE;
-}
 
 static struct kvm_wall_clock wall_clock;
-static cycle_t kvm_clock_read(void);
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
@@ -55,35 +48,19 @@ static cycle_t kvm_clock_read(void);
  */
 unsigned long kvm_get_wallclock(void)
 {
-	u32 wc_sec, wc_nsec;
-	u64 delta;
+	struct kvm_vcpu_time_info *vcpu_time;
 	struct timespec ts;
-	int version, nsec;
 	int low, high;
 
 	low = (int)__pa(&wall_clock);
 	high = ((u64)__pa(&wall_clock) >> 32);
-
-	delta = kvm_clock_read();
-
 	native_write_msr(MSR_KVM_WALL_CLOCK, low, high);
-	do {
-		version = wall_clock.wc_version;
-		rmb();
-		wc_sec = wall_clock.wc_sec;
-		wc_nsec = wall_clock.wc_nsec;
-		rmb();
-	} while ((wall_clock.wc_version != version) || (version & 1));
-
-	delta = kvm_clock_read() - delta;
-	delta += wc_nsec;
-	nsec = do_div(delta, NSEC_PER_SEC);
-	set_normalized_timespec(&ts, wc_sec + delta, nsec);
-	/*
-	 * Of all mechanisms of time adjustment I've tested, this one
-	 * was the champion!
-	 */
-	return ts.tv_sec + 1;
+
+	vcpu_time = &get_cpu_var(hv_clock);
+	pvclock_read_wallclock(&wall_clock, vcpu_time, &ts);
+	put_cpu_var(hv_clock);
+	
+	return ts.tv_sec;
 }
 
 int kvm_set_wallclock(unsigned long now)
@@ -91,28 +68,17 @@ int kvm_set_wallclock(unsigned long now)
 	return 0;
 }
 
-/*
- * This is our read_clock function. The host puts an tsc timestamp each time
- * it updates a new time. Without the tsc adjustment, we can have a situation
- * in which a vcpu starts to run earlier (smaller system_time), but probes
- * time later (compared to another vcpu), leading to backwards time
- */
 static cycle_t kvm_clock_read(void)
 {
-	u64 last_tsc, now;
-	int cpu;
-
-	preempt_disable();
-	cpu = smp_processor_id();
-
-	last_tsc = get_clock(cpu, tsc_timestamp);
-	now = get_clock(cpu, system_time);
+	struct kvm_vcpu_time_info *src;
+	cycle_t ret;
 
-	now += kvm_get_delta(last_tsc);
-	preempt_enable();
-
-	return now;
+	src = &get_cpu_var(hv_clock);
+	ret = pvclock_clocksource_read(src);
+	put_cpu_var(hv_clock);
+	return ret;
 }
+
 static struct clocksource kvm_clock = {
 	.name = "kvm-clock",
 	.read = kvm_clock_read,
@@ -123,13 +89,14 @@ static struct clocksource kvm_clock = {
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static int kvm_register_clock(void)
+static int kvm_register_clock(char *txt)
 {
 	int cpu = smp_processor_id();
 	int low, high;
 	low = (int)__pa(&per_cpu(hv_clock, cpu)) | 1;
 	high = ((u64)__pa(&per_cpu(hv_clock, cpu)) >> 32);
-
+	printk(KERN_INFO "kvm-clock: cpu %d, msr %x:%x, %s\n",
+	       cpu, high, low, txt);
 	return native_write_msr_safe(MSR_KVM_SYSTEM_TIME, low, high);
 }
 
@@ -140,12 +107,20 @@ static void kvm_setup_secondary_clock(void)
 	 * Now that the first cpu already had this clocksource initialized,
 	 * we shouldn't fail.
 	 */
-	WARN_ON(kvm_register_clock());
+	WARN_ON(kvm_register_clock("secondary cpu clock"));
 	/* ok, done with our trickery, call native */
 	setup_secondary_APIC_clock();
 }
 #endif
 
+#ifdef CONFIG_SMP
+void __init kvm_smp_prepare_boot_cpu(void)
+{
+	WARN_ON(kvm_register_clock("primary cpu clock"));
+	native_smp_prepare_boot_cpu();
+}
+#endif
+
 /*
  * After the clock is registered, the host will keep writing to the
  * registered memory location. If the guest happens to shutdown, this memory
@@ -174,7 +149,7 @@ void __init kvmclock_init(void)
 		return;
 
 	if (kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
-		if (kvm_register_clock())
+		if (kvm_register_clock("boot clock"))
 			return;
 		pv_time_ops.get_wallclock = kvm_get_wallclock;
 		pv_time_ops.set_wallclock = kvm_set_wallclock;
@@ -182,6 +157,9 @@ void __init kvmclock_init(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 		pv_apic_ops.setup_secondary_clock = kvm_setup_secondary_clock;
 #endif
+#ifdef CONFIG_SMP
+		smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
+#endif
 		machine_ops.shutdown  = kvm_shutdown;
 #ifdef CONFIG_KEXEC
 		machine_ops.crash_shutdown  = kvm_crash_shutdown;
-- 
1.5.4.1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
