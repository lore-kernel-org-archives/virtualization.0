From: Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH v2 3/3] x86/vmware: Add paravirt sched clock
Date: Wed, 26 Oct 2016 09:51:13 -0700
Message-ID: <20161026165113.16745-1-amakhalov__4273.37247315354$1477936040$gmane$org@vmware.com>
References: <alpine.DEB.2.20.1610261213000.4983@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1610261213000.4983@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: corbet@lwn.net, akataria@vmware.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, Alexey Makhalov <amakhalov@vmware.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Set pv_time_ops.sched_clock to vmware_sched_clock(). It is simplified
version of native_sched_clock() without ring buffer of mult/shift/offset
triplets and preempt toggling.
Since VMware hypervisor provides constant tsc we can use constant
mult/shift/offset triplet calculated at boot time.

no-vmw-sched-clock kernel parameter is added to disable the paravirt
sched clock.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Alok N Kataria <akataria@vmware.com>
---
 Documentation/kernel-parameters.txt |  4 ++++
 arch/x86/kernel/cpu/vmware.c        | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 37babf9..b3b2ec0 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2754,6 +2754,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
 			fault handling.
 
+	no-vmw-sched-clock
+			[X86,PV_OPS] Disable paravirtualized VMware scheduler
+			clock and use the default one.
+
 	no-steal-acc    [X86,KVM] Disable paravirtualized steal time accounting.
 			steal time is computed, but won't influence scheduler
 			behaviour
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index e3fb320..e284ebf 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -24,10 +24,15 @@
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/clocksource.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
 #include <asm/apic.h>
+#include <asm/timer.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"vmware: " fmt
 
 #define CPUID_VMWARE_INFO_LEAF	0x40000000
 #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
@@ -62,10 +67,46 @@ static unsigned long vmware_get_tsc_khz(void)
 }
 
 #ifdef CONFIG_PARAVIRT
+static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
+static int vmw_sched_clock __initdata = 1;
+
+static __init int setup_vmw_sched_clock(char *s)
+{
+	vmw_sched_clock = 0;
+	return 0;
+}
+early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
+
+static unsigned long long vmware_sched_clock(void)
+{
+	unsigned long long ns;
+
+	ns = mul_u64_u32_shr(rdtsc(), vmware_cyc2ns.cyc2ns_mul,
+			     vmware_cyc2ns.cyc2ns_shift);
+	ns -= vmware_cyc2ns.cyc2ns_offset;
+	return ns;
+}
+
 static void __init vmware_paravirt_ops_setup(void)
 {
 	pv_info.name = "VMware";
 	pv_cpu_ops.io_delay = paravirt_nop;
+
+	if (vmware_tsc_khz && vmw_sched_clock) {
+		unsigned long long tsc_now = rdtsc();
+
+		clocks_calc_mult_shift(&vmware_cyc2ns.cyc2ns_mul,
+				       &vmware_cyc2ns.cyc2ns_shift,
+				       vmware_tsc_khz,
+				       NSEC_PER_MSEC, 0);
+		vmware_cyc2ns.cyc2ns_offset =
+			mul_u64_u32_shr(tsc_now, vmware_cyc2ns.cyc2ns_mul,
+					vmware_cyc2ns.cyc2ns_shift);
+
+		pv_time_ops.sched_clock = vmware_sched_clock;
+		pr_info("using sched offset of %llu ns\n",
+			vmware_cyc2ns.cyc2ns_offset);
+	}
 }
 #else
 #define vmware_paravirt_ops_setup() do {} while (0)
-- 
2.10.1
