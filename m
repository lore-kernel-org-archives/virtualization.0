From: Renat Valiullin <rvaliullin@vmware.com>
Subject: [PATCH] x86/vmware: Skip lapic calibration on VMware.
Date: Tue, 4 Oct 2016 13:11:48 -0700
Message-ID: <20161004201148.GA1421@uu64vm>
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

In virtualized environment the APIC timer calibration could go wrong
when the host is overcommitted or the guest is running nested,
this would result in the APIC timers operating at an incorrect frequency.
Since VMware supports a mechanism to retrieve the local APIC frequency
we can ask the hypervisor for it and skip this APIC calibration loop.

Signed-off-by: Renat Valiullin <rvaliullin@vmware.com>
Acked-by: Alok N Kataria <akataria@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 1ff0598..8116057 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -27,6 +27,7 @@
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
+#include <asm/apic.h>
 
 #define CPUID_VMWARE_INFO_LEAF	0x40000000
 #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
@@ -82,10 +83,17 @@ static void __init vmware_platform_setup(void)
 
 	VMWARE_PORT(GETHZ, eax, ebx, ecx, edx);
 
-	if (ebx != UINT_MAX)
+	if (ebx != UINT_MAX) {
 		x86_platform.calibrate_tsc = vmware_get_tsc_khz;
-	else
+#ifdef CONFIG_X86_LOCAL_APIC
+		/* Skip lapic calibration since we know the bus frequency. */
+		lapic_timer_frequency = ecx / HZ;
+		pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
+			ecx);
+#endif
+	} else {
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
+	}
 }
 
 /*
-- 
2.7.4
