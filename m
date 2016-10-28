From: Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH v3 2/3] x86/vmware: Add basic paravirt ops support
Date: Fri, 28 Oct 2016 00:54:31 -0700
Message-ID: <20161028075432.90579-3-amakhalov__15313.9436421499$1477936090$gmane$org@vmware.com>
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

Add basic paravirt support:
 1. set pv_info.name to "VMware hypervisor" to have proper boot log message
	Booting paravirtualized kernel on VMware hypervisor
    instead of "... on bare hardware"
 2. set pv_cpu_ops.io_delay() to empty function - paravirt_nop() to
    avoid vm-exits on IO delays.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Alok N Kataria <akataria@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 480790f..098a524 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -61,6 +61,16 @@ static unsigned long vmware_get_tsc_khz(void)
 	return vmware_tsc_khz;
 }
 
+#ifdef CONFIG_PARAVIRT
+static void __init vmware_paravirt_ops_setup(void)
+{
+	pv_info.name = "VMware hypervisor";
+	pv_cpu_ops.io_delay = paravirt_nop;
+}
+#else
+#define vmware_paravirt_ops_setup() do {} while (0)
+#endif
+
 static void __init vmware_platform_setup(void)
 {
 	uint32_t eax, ebx, ecx, edx;
@@ -94,6 +104,8 @@ static void __init vmware_platform_setup(void)
 	} else {
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
+
+	vmware_paravirt_ops_setup();
 }
 
 /*
-- 
2.10.1
