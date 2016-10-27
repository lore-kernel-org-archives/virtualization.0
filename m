From: Alexey Makhalov <amakhalov@vmware.com>
Subject: [RESEND PATCH 1/3] x86/vmware: Use tsc_khz value for calibrate_cpu()
Date: Thu, 27 Oct 2016 12:44:52 -0700
Message-ID: <20161027194454.9729-1-amakhalov__48142.9756539457$1477936040$gmane$org@vmware.com>
References: <alpine.DEB.2.20.1610262247030.5013@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1610262247030.5013@nanos>
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

After aa297292d708, there are separate native calibrations for cpu_khz and
tsc_khz. The code sets x86_platform.calibrate_cpu to native_calibrate_cpu()
which looks in cpuid leaf 0x16 or msrs for the cpu frequency. Since we keep
the tsc_khz constant (even after vmotion), the cpu_khz and tsc_khz may
start diverging.

tsc_init() now does

	cpu_khz = x86_platform.calibrate_cpu();
	tsc_khz = x86_platform.calibrate_tsc();
	if (tsc_khz == 0)
		tsc_khz = cpu_khz;
	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
		cpu_khz = tsc_khz;

We want the cpu_khz and tsc_khz to be sync even if they diverge less then
10%.
This patch resolves this issue by setting x86_platform.calibrate_cpu to
vmware_get_tsc_khz().

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
