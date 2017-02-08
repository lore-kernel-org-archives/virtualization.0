From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 1/2] hyperv: implement hv_get_tsc_page()
Date: Wed,  8 Feb 2017 18:07:43 +0100
Message-ID: <20170208170744.7632-2-vkuznets__43186.1422177919$1486573678$gmane$org@redhat.com>
References: <20170208170744.7632-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170208170744.7632-1-vkuznets@redhat.com>
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
available. Implement hv_get_tsc_page() and add CONFIG_HYPERV_CLOCK to
make #ifdef-s simple.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c       | 5 +++++
 arch/x86/include/asm/mshyperv.h | 8 ++++++++
 drivers/hv/Kconfig              | 5 +++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b371d0e..aa36049 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -31,6 +31,11 @@
 
 static struct ms_hyperv_tsc_page *tsc_pg;
 
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return tsc_pg;
+}
+
 static u64 read_hv_clock_tsc(struct clocksource *arg)
 {
 	u64 current_tick;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f8dc370..005d0bc 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -173,4 +173,12 @@ void hyperv_report_panic(struct pt_regs *regs);
 bool hv_is_hypercall_page_setup(void);
 void hyperv_cleanup(void);
 #endif
+#ifdef CONFIG_HYPERV_CLOCK
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+#else
+static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return NULL;
+}
+#endif
 #endif
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0403b51..3b45e69 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -3,10 +3,15 @@ menu "Microsoft Hyper-V guest support"
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	select HYPERV_CLOCK
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_CLOCK
+       bool
+       depends on X86_64
+
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
 	depends on HYPERV && CONNECTOR && NLS
-- 
2.9.3
