From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 2/2] use paravirt function to calculate cpu khz
Date: Tue, 22 Jul 2008 13:15:28 -0300
Message-ID: <1216743328-3213-3-git-send-email-gcosta__41816.2677241073$1216743971$gmane$org@redhat.com>
References: <1216743328-3213-1-git-send-email-gcosta@redhat.com>
	<1216743328-3213-2-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1216743328-3213-2-git-send-email-gcosta@redhat.com>
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

We're currently facing timing problems in guests that do
calibration under heavy load, and then the load vanishes.
This means we'll have a much lower lpj than we actually should,
and delays end up taking less time than they should, which is a
nasty bug.

Solution is to pass on the lpj value from host to guest, and have it
preset.

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kernel/kvmclock.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index d02def0..84db1bb 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -78,6 +78,34 @@ static cycle_t kvm_clock_read(void)
 	return ret;
 }
 
+/*
+ * If we don't do that, there is the possibility that the guest
+ * will calibrate under heavy load - thus, getting a lower lpj -
+ * and execute the delays themselves without load. This is wrong,
+ * because no delay loop can finish beforehand.
+ * Any heuristics is subject to fail, because ultimately, a large
+ * poll of guests can be running and trouble each other. So we preset
+ * lpj here
+ */
+static unsigned long kvm_get_tsc_khz(void)
+{
+	return preset_lpj;
+}
+
+static void kvm_get_preset_lpj(void)
+{
+	struct pvclock_vcpu_time_info *src;
+	unsigned long khz;
+	u64 lpj;
+
+	src = &per_cpu(hv_clock, 0);
+	khz = pvclock_tsc_khz(src);
+
+        lpj = ((u64)khz * 1000);
+        do_div(lpj, HZ);
+	preset_lpj = lpj;
+}
+
 static struct clocksource kvm_clock = {
 	.name = "kvm-clock",
 	.read = kvm_clock_read,
@@ -153,6 +181,7 @@ void __init kvmclock_init(void)
 		pv_time_ops.get_wallclock = kvm_get_wallclock;
 		pv_time_ops.set_wallclock = kvm_set_wallclock;
 		pv_time_ops.sched_clock = kvm_clock_read;
+		pv_time_ops.get_tsc_khz = kvm_get_tsc_khz;
 #ifdef CONFIG_X86_LOCAL_APIC
 		pv_apic_ops.setup_secondary_clock = kvm_setup_secondary_clock;
 #endif
@@ -163,6 +192,7 @@ void __init kvmclock_init(void)
 #ifdef CONFIG_KEXEC
 		machine_ops.crash_shutdown  = kvm_crash_shutdown;
 #endif
+		kvm_get_preset_lpj();
 		clocksource_register(&kvm_clock);
 	}
 }
-- 
1.5.5.1
