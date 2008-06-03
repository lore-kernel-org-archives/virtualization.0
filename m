From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/5] Make xen use the paravirt clocksource structs and
	functions.
Date: Tue,  3 Jun 2008 15:07:16 +0200
Message-ID: <1212498439-1283-3-git-send-email-kraxel@redhat.com>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-owner@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch updates the xen guest to use the pvclock structs
and helper functions.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/xen/Kconfig        |    1 +
 arch/x86/xen/time.c         |  130 ++++---------------------------------------
 include/xen/interface/xen.h |    5 +-
 3 files changed, 14 insertions(+), 122 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 2e641be..3a4f16a 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -5,6 +5,7 @@
 config XEN
 	bool "Xen guest support"
 	select PARAVIRT
+	select PARAVIRT_CLOCK
 	depends on X86_32
 	depends on X86_CMPXCHG && X86_TSC && !(X86_VISWS || X86_VOYAGER)
 	help
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index c39e1a5..bf31fb5 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -13,6 +13,7 @@
 #include <linux/clockchips.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -30,17 +31,6 @@
 
 static cycle_t xen_clocksource_read(void);
 
-/* These are perodically updated in shared_info, and then copied here. */
-struct shadow_time_info {
-	u64 tsc_timestamp;     /* TSC at last update of time vals.  */
-	u64 system_timestamp;  /* Time, in nanosecs, since boot.    */
-	u32 tsc_to_nsec_mul;
-	int tsc_shift;
-	u32 version;
-};
-
-static DEFINE_PER_CPU(struct shadow_time_info, shadow_time);
-
 /* runstate info updated by Xen */
 static DEFINE_PER_CPU(struct vcpu_runstate_info, runstate);
 
@@ -230,121 +220,26 @@ unsigned long xen_cpu_khz(void)
 	return xen_khz;
 }
 
-/*
- * Reads a consistent set of time-base values from Xen, into a shadow data
- * area.
- */
-static unsigned get_time_values_from_xen(void)
-{
-	struct vcpu_time_info   *src;
-	struct shadow_time_info *dst;
-
-	/* src is shared memory with the hypervisor, so we need to
-	   make sure we get a consistent snapshot, even in the face of
-	   being preempted. */
-	src = &__get_cpu_var(xen_vcpu)->time;
-	dst = &__get_cpu_var(shadow_time);
-
-	do {
-		dst->version = src->version;
-		rmb();		/* fetch version before data */
-		dst->tsc_timestamp     = src->tsc_timestamp;
-		dst->system_timestamp  = src->system_time;
-		dst->tsc_to_nsec_mul   = src->tsc_to_system_mul;
-		dst->tsc_shift         = src->tsc_shift;
-		rmb();		/* test version after fetching data */
-	} while ((src->version & 1) | (dst->version ^ src->version));
-
-	return dst->version;
-}
-
-/*
- * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
- * yielding a 64-bit result.
- */
-static inline u64 scale_delta(u64 delta, u32 mul_frac, int shift)
-{
-	u64 product;
-#ifdef __i386__
-	u32 tmp1, tmp2;
-#endif
-
-	if (shift < 0)
-		delta >>= -shift;
-	else
-		delta <<= shift;
-
-#ifdef __i386__
-	__asm__ (
-		"mul  %5       ; "
-		"mov  %4,%%eax ; "
-		"mov  %%edx,%4 ; "
-		"mul  %5       ; "
-		"xor  %5,%5    ; "
-		"add  %4,%%eax ; "
-		"adc  %5,%%edx ; "
-		: "=A" (product), "=r" (tmp1), "=r" (tmp2)
-		: "a" ((u32)delta), "1" ((u32)(delta >> 32)), "2" (mul_frac) );
-#elif __x86_64__
-	__asm__ (
-		"mul %%rdx ; shrd $32,%%rdx,%%rax"
-		: "=a" (product) : "0" (delta), "d" ((u64)mul_frac) );
-#else
-#error implement me!
-#endif
-
-	return product;
-}
-
-static u64 get_nsec_offset(struct shadow_time_info *shadow)
-{
-	u64 now, delta;
-	now = native_read_tsc();
-	delta = now - shadow->tsc_timestamp;
-	return scale_delta(delta, shadow->tsc_to_nsec_mul, shadow->tsc_shift);
-}
-
 static cycle_t xen_clocksource_read(void)
 {
-	struct shadow_time_info *shadow = &get_cpu_var(shadow_time);
+        struct vcpu_time_info *src;
 	cycle_t ret;
-	unsigned version;
-
-	do {
-		version = get_time_values_from_xen();
-		barrier();
-		ret = shadow->system_timestamp + get_nsec_offset(shadow);
-		barrier();
-	} while (version != __get_cpu_var(xen_vcpu)->time.version);
-
-	put_cpu_var(shadow_time);
 
+	src = &get_cpu_var(xen_vcpu)->time;
+	ret = pvclock_clocksource_read((void*)src);
+	put_cpu_var(xen_vcpu);
 	return ret;
 }
 
 static void xen_read_wallclock(struct timespec *ts)
 {
-	const struct shared_info *s = HYPERVISOR_shared_info;
-	u32 version;
-	u64 delta;
-	struct timespec now;
-
-	/* get wallclock at system boot */
-	do {
-		version = s->wc_version;
-		rmb();		/* fetch version before time */
-		now.tv_sec  = s->wc_sec;
-		now.tv_nsec = s->wc_nsec;
-		rmb();		/* fetch time before checking version */
-	} while ((s->wc_version & 1) | (version ^ s->wc_version));
+	struct shared_info *s = HYPERVISOR_shared_info;
+	struct pvclock_wall_clock *wall_clock = &(s->wc);
+        struct vcpu_time_info *vcpu_time;
 
-	delta = xen_clocksource_read();	/* time since system boot */
-	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
-
-	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
-	now.tv_sec = delta;
-
-	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
+	vcpu_time = &get_cpu_var(xen_vcpu)->time;
+	pvclock_read_wallclock(wall_clock, (void*)vcpu_time, ts);
+	put_cpu_var(xen_vcpu);
 }
 
 unsigned long xen_get_wallclock(void)
@@ -352,7 +247,6 @@ unsigned long xen_get_wallclock(void)
 	struct timespec ts;
 
 	xen_read_wallclock(&ts);
-
 	return ts.tv_sec;
 }
 
@@ -576,8 +470,6 @@ __init void xen_time_init(void)
 {
 	int cpu = smp_processor_id();
 
-	get_time_values_from_xen();
-
 	clocksource_register(&xen_clocksource);
 
 	if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, cpu, NULL) == 0) {
diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 9b018da..aeee096 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -10,6 +10,7 @@
 #define __XEN_PUBLIC_XEN_H__
 
 #include <asm/xen/interface.h>
+#include <asm/pvclock-abi.h>
 
 /*
  * XEN "SYSTEM CALLS" (a.k.a. HYPERCALLS).
@@ -384,9 +385,7 @@ struct shared_info {
 	 * Wallclock time: updated only by control software. Guests should base
 	 * their gettimeofday() syscall on this wallclock-base value.
 	 */
-	uint32_t wc_version;      /* Version counter: see vcpu_time_info_t. */
-	uint32_t wc_sec;          /* Secs  00:00:00 UTC, Jan 1, 1970.  */
-	uint32_t wc_nsec;         /* Nsecs 00:00:00 UTC, Jan 1, 1970.  */
+	struct pvclock_wall_clock wc;
 
 	struct arch_shared_info arch;
 
-- 
1.5.4.1
