From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 23/23] ia64/pv_ops: update Kconfig for paravirtualized guest
	and xen.
Date: Wed, 30 Apr 2008 21:30:54 +0900
Message-ID: <12095586542310-git-send-email-yamahata__11856.5491204665$1209559415$gmane$org@valinux.co.jp>
References: <1209558654694-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1209558654694-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, Alex Williamson <alex.williamson@hp.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

introduce CONFIG_PARAVIRT_GUEST, CONFIG_PARAVIRT for
paravirtualized guest.
introduce CONFING_XEN, CONFIG_IA64_XEN for xen.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/Kconfig     |   32 ++++++++++++++++++++++++++++++++
 arch/ia64/xen/Kconfig |   21 +++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 arch/ia64/xen/Kconfig

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0df5f6f..d6806c0 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -116,6 +116,33 @@ config AUDIT_ARCH
 	bool
 	default y
 
+menuconfig PARAVIRT_GUEST
+	bool "Paravirtualized guest support"
+	help
+	  Say Y here to get to see options related to running Linux under
+	  various hypervisors.  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if PARAVIRT_GUEST
+
+config PARAVIRT
+	bool "Enable paravirtualization code"
+	depends on PARAVIRT_GUEST
+	default y
+	bool
+	default y
+	help
+	  This changes the kernel so it can modify itself when it is run
+	  under a hypervisor, potentially improving performance significantly
+	  over full virtualization.  However, when run without a hypervisor
+	  the kernel is theoretically slower and slightly larger.
+
+
+source "arch/ia64/xen/Kconfig"
+
+endif
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
@@ -136,6 +163,7 @@ config IA64_GENERIC
 	  HP-zx1/sx1000+swiotlb	For HP systems with (broken) DMA-constrained devices.
 	  SGI-SN2		For SGI Altix systems
 	  Ski-simulator		For the HP simulator <http://www.hpl.hp.com/research/linux/ski/>
+	  Xen-domU		For xen domU system
 
 	  If you don't know what to do, choose "generic".
 
@@ -174,6 +202,10 @@ config IA64_HP_SIM
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
index 0000000..d525fbb
--- /dev/null
+++ b/arch/ia64/xen/Kconfig
@@ -0,0 +1,21 @@
+#
+# This Kconfig describes xen/ia64 options
+#
+
+config XEN
+	bool "Xen hypervisor support"
+	default y
+	depends on PARAVIRT && MCKINLEY && IA64_PAGE_SIZE_16KB && EXPERIMENTAL
+	select XEN_XENCOMM
+	select NO_IDLE_HZ
+	help
+	  Enable Xen hypervisor support.  Resulting kernel runs
+	  both as a guest OS on Xen and natively on hardware.
+
+config XEN_XENCOMM
+	depends on XEN
+	bool
+
+config NO_IDLE_HZ
+	depends on XEN
+	bool
-- 
1.5.3
