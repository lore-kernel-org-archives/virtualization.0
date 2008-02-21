From: yamahata@valinux.co.jp
Subject: [PATCH 27/28] ia64/xen: update Kconfig to allow xen domU Linux
Date: Thu, 21 Feb 2008 18:17:58 +0900
Message-ID: <20080221091906.904111000__38069.579008925$1203635186$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GB17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0027-ia64-xen-update-Kconfig-to-allow-xen-domU-Linux.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/Kconfig     |    6 +++++-
 arch/ia64/xen/Kconfig |   29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)
 create mode 100644 arch/ia64/xen/Kconfig

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bc84008..31313bc 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -178,7 +178,7 @@ config PARAVIRT_NOP_B_PATCH
 	  "br.cond.sptk.many <native_xxx>" and replace it with 'nop.b 0'
 	  when running on xen.
 
-#source "arch/ia64/xen/Kconfig"
+source "arch/ia64/xen/Kconfig"
 
 endif
 
@@ -238,6 +238,10 @@ config IA64_HP_SIM
 	bool "Ski-simulator"
 	select SWIOTLB
 
+config IA64_XEN
+	bool "Xen guest"
+	depends on XEN
+
 endchoice
 
 choice
diff --git a/arch/ia64/xen/Kconfig b/arch/ia64/xen/Kconfig
new file mode 100644
index 0000000..30f54c3
--- /dev/null
+++ b/arch/ia64/xen/Kconfig
@@ -0,0 +1,29 @@
+#
+# This Kconfig describes xen/ia64 options
+#
+
+config XEN
+	bool "Xen hypervisor support"
+	default y
+	select PARAVIRT
+	select PARAVIRT_ALT
+	select PARAVIRT_ENTRY
+	select PARAVIRT_NOP_B_PATCH
+	select XEN_XENCOMM
+	select IA64_XEN
+	help
+	  Enable Xen hypervisor support.  Resulting kernel runs
+	  both as a guest OS on Xen and natively on hardware.
+
+if XEN
+config XEN_INTERFACE_VERSION
+	hex
+	default 0x00030207
+
+config XEN_XENCOMM
+	def_bool y
+
+config NO_IDLE_HZ
+	def_bool y
+
+endif
-- 
1.5.3

-- 
yamahata
