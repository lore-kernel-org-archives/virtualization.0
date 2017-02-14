From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 1/3] x86/hyperv: implement hv_get_tsc_page()
Date: Tue, 14 Feb 2017 13:44:06 +0100
Message-ID: <20170214124408.25931-2-vkuznets@redhat.com>
References: <20170214124408.25931-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170214124408.25931-1-vkuznets@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

To use Hyper-V TSC page clocksource from vDSO we need to make tsc_pg
available. Implement hv_get_tsc_page() and add CONFIG_HYPERV_TSCPAGE to
make #ifdef-s simple.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c       | 9 +++++++--
 arch/x86/include/asm/mshyperv.h | 8 ++++++++
 drivers/hv/Kconfig              | 3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b371d0e..0ce8485 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -27,10 +27,15 @@
 #include <linux/clockchips.h>
 
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_HYPERV_TSCPAGE
 
 static struct ms_hyperv_tsc_page *tsc_pg;
 
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return tsc_pg;
+}
+
 static u64 read_hv_clock_tsc(struct clocksource *arg)
 {
 	u64 current_tick;
@@ -136,7 +141,7 @@ void hyperv_init(void)
 	/*
 	 * Register Hyper-V specific clocksource.
 	 */
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_HYPERV_TSCPAGE
 	if (ms_hyperv.features & HV_X64_MSR_REFERENCE_TSC_AVAILABLE) {
 		union hv_x64_msr_hypercall_contents tsc_msr;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f8dc370..14dd92c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -173,4 +173,12 @@ void hyperv_report_panic(struct pt_regs *regs);
 bool hv_is_hypercall_page_setup(void);
 void hyperv_cleanup(void);
 #endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+#else
+static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return NULL;
+}
+#endif
 #endif
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0403b51..c29cd53 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -7,6 +7,9 @@ config HYPERV
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_TSCPAGE
+       def_bool HYPERV && X86_64
+
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
 	depends on HYPERV && CONNECTOR && NLS
-- 
2.9.3
