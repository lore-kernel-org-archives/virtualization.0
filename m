From: Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH v3 1/3] x86/vmware: Use tsc_khz value for calibrate_cpu()
Date: Fri, 28 Oct 2016 00:54:30 -0700
Message-ID: <20161028075432.90579-2-amakhalov__36052.1303992302$1477936117$gmane$org@vmware.com>
References: <alpine.DEB.2.20.1610272244060.4913@nanos>
	<20161028075432.90579-1-amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161028075432.90579-1-amakhalov@vmware.com>
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

Commit aa297292d708 ("x86/tsc: Enumerate SKL cpu_khz and tsc_khz via
CPUID") separated the calibration mechanisms for cpu_khz and tsc_khz.

Since the vmware hypervisor provides a constant frequency TSC to the guest,
this change can lead to divergence between the tsc and the cpu frequency
after vmotion, which might confuse the user.

Solve this by overriding the x86 platform cpu calibration callback with the
vmware specific tsc calibration function.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Alok N Kataria <akataria@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 4e34da4b..480790f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -83,6 +83,7 @@ static void __init vmware_platform_setup(void)
 
 		vmware_tsc_khz = tsc_khz;
 		x86_platform.calibrate_tsc = vmware_get_tsc_khz;
+		x86_platform.calibrate_cpu = vmware_get_tsc_khz;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
-- 
2.10.1
