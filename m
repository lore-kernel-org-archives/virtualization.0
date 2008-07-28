From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 1/2] factor out cpu_khz to common code
Date: Mon, 28 Jul 2008 11:47:52 -0300
Message-ID: <1217256473-10222-2-git-send-email-gcosta__28058.1820327372$1217257073$gmane$org@redhat.com>
References: <1216743328-3213-1-git-send-email-gcosta@redhat.com>
	<1217256473-10222-1-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1217256473-10222-1-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: aliguori@codemonkey.ws, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

KVM intends to use paravirt code to calibrate khz. Xen
current code will do just fine. So as a first step, factor out
code to pvclock.c.

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kernel/pvclock.c |   12 ++++++++++++
 arch/x86/xen/time.c       |   11 ++---------
 include/asm-x86/pvclock.h |    1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 05fbe9a..1c54b5f 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -97,6 +97,18 @@ static unsigned pvclock_get_time_values(struct pvclock_shadow_time *dst,
 	return dst->version;
 }
 
+unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src)
+{
+	u64 tsc_khz = 1000000ULL << 32;
+
+	do_div(tsc_khz, src->tsc_to_system_mul);
+	if (src->tsc_shift < 0)
+		tsc_khz <<= -src->tsc_shift;
+	else
+		tsc_khz >>= src->tsc_shift;
+	return tsc_khz;
+}
+
 cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 {
 	struct pvclock_shadow_time shadow;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 685b774..1eb88fe 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -200,17 +200,10 @@ unsigned long long xen_sched_clock(void)
 /* Get the TSC speed from Xen */
 unsigned long xen_tsc_khz(void)
 {
-	u64 xen_khz = 1000000ULL << 32;
-	const struct pvclock_vcpu_time_info *info =
+	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
 
-	do_div(xen_khz, info->tsc_to_system_mul);
-	if (info->tsc_shift < 0)
-		xen_khz <<= -info->tsc_shift;
-	else
-		xen_khz >>= info->tsc_shift;
-
-	return xen_khz;
+	return pvclock_tsc_khz(info);
 }
 
 static cycle_t xen_clocksource_read(void)
diff --git a/include/asm-x86/pvclock.h b/include/asm-x86/pvclock.h
index 85b1bba..28783bc 100644
--- a/include/asm-x86/pvclock.h
+++ b/include/asm-x86/pvclock.h
@@ -6,6 +6,7 @@
 
 /* some helper functions for xen and kvm pv clock sources */
 cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
+unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src);
 void pvclock_read_wallclock(struct pvclock_wall_clock *wall,
 			    struct pvclock_vcpu_time_info *vcpu,
 			    struct timespec *ts);
-- 
1.5.5.1
