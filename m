From: Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH] x86/vmware: Read tsc_khz only once - at boot time
Date: Wed, 19 Oct 2016 22:02:11 -0700
Message-ID: <20161020050211.GA25304__5952.01042383469$1477935935$gmane$org@amakhalov-virtual-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Re-factor the vmware platform setup code to query the hypervisor for tsc
frequency only once during boot. Since the VMware hypervisor guarantees
constant TSC, calibrate_tsc now uses the saved value.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Alok N Kataria <akataria@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 5130985..46c7b9d 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -48,6 +48,8 @@
 			"2"(VMWARE_HYPERVISOR_PORT), "3"(UINT_MAX) :	\
 			"memory");
 
+static unsigned long vmware_tsc_khz __ro_after_init;
+
 static inline int __vmware_platform(void)
 {
 	uint32_t eax, ebx, ecx, edx;
@@ -57,35 +59,32 @@ static inline int __vmware_platform(void)
 
 static unsigned long vmware_get_tsc_khz(void)
 {
-	uint64_t tsc_hz, lpj;
-	uint32_t eax, ebx, ecx, edx;
-
-	VMWARE_PORT(GETHZ, eax, ebx, ecx, edx);
-
-	tsc_hz = eax | (((uint64_t)ebx) << 32);
-	do_div(tsc_hz, 1000);
-	BUG_ON(tsc_hz >> 32);
-	pr_info("TSC freq read from hypervisor : %lu.%03lu MHz\n",
-			 (unsigned long) tsc_hz / 1000,
-			 (unsigned long) tsc_hz % 1000);
-
-	if (!preset_lpj) {
-		lpj = ((u64)tsc_hz * 1000);
-		do_div(lpj, HZ);
-		preset_lpj = lpj;
-	}
-
-	return tsc_hz;
+	return vmware_tsc_khz;
 }
 
 static void __init vmware_platform_setup(void)
 {
 	uint32_t eax, ebx, ecx, edx;
+	uint64_t lpj, tsc_khz;
 
 	VMWARE_PORT(GETHZ, eax, ebx, ecx, edx);
 
 	if (ebx != UINT_MAX) {
+		lpj = tsc_khz = eax | (((uint64_t)ebx) << 32);
+		do_div(tsc_khz, 1000);
+		WARN_ON(tsc_khz >> 32);
+		pr_info("TSC freq read from hypervisor : %lu.%03lu MHz\n",
+			(unsigned long) tsc_khz / 1000,
+			(unsigned long) tsc_khz % 1000);
+
+		if (!preset_lpj) {
+			do_div(lpj, HZ);
+			preset_lpj = lpj;
+		}
+
+		vmware_tsc_khz = tsc_khz;
 		x86_platform.calibrate_tsc = vmware_get_tsc_khz;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
 		lapic_timer_frequency = ecx / HZ;
-- 
1.9.1
