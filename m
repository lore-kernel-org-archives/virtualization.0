From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/54] Staging: hv: add the Hyper-V virtual bus to the build
Date: Fri, 17 Jul 2009 11:09:00 -0700
Message-ID: <20090717180917.450231213@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-add-the-hyper-v-virtual-bus-to-the-build.patch
In-Reply-To: <20090720160025.GA20249@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Add the Hyper-V virtual bus to the kernel build system.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/Kconfig     |    2 ++
 drivers/staging/Makefile    |    1 +
 drivers/staging/hv/Kconfig  |    8 ++++++++
 drivers/staging/hv/Makefile |    3 +++
 4 files changed, 14 insertions(+)

--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -129,5 +129,7 @@ source "drivers/staging/pata_rdc/Kconfig
 
 source "drivers/staging/udlfb/Kconfig"
 
+source "drivers/staging/hv/Kconfig"
+
 endif # !STAGING_EXCLUDE_BUILD
 endif # STAGING
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_VT6655)		+= vt6655/
 obj-$(CONFIG_USB_CPC)		+= cpc-usb/
 obj-$(CONFIG_RDC_17F3101X)	+= pata_rdc/
 obj-$(CONFIG_FB_UDL)		+= udlfb/
+obj-$(CONFIG_HYPERV)		+= hv/
--- /dev/null
+++ b/drivers/staging/hv/Kconfig
@@ -0,0 +1,8 @@
+config HYPERV
+	tristate "Microsoft Hyper-V client drivers"
+	depends on X86
+	default n
+	help
+	  Select this option to run Linux as a Hyper-V client operating
+	  system.
+
--- /dev/null
+++ b/drivers/staging/hv/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
+
+hv_vmbus-objs := vmbus_drv.o osd.o Sources.o
