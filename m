From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/54] Staging: hv: add the Hyper-V virtual scsi driver to the
	build
Date: Fri, 17 Jul 2009 11:09:02 -0700
Message-ID: <20090717180917.788904562@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-add-the-hyper-v-virtual-scsi-driver-to-the-build.patch
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
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Greg KH <greg@kroah.com>
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Add the Hyper-V virtual scsi driver to the kernel build system.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/Kconfig  |    6 ++++++
 drivers/staging/hv/Makefile |    2 ++
 2 files changed, 8 insertions(+)

--- a/drivers/staging/hv/Kconfig
+++ b/drivers/staging/hv/Kconfig
@@ -6,3 +6,9 @@ config HYPERV
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_STORAGE
+	tristate "Microsoft Hyper-V virtual storage driver"
+	depends on SCSI
+	default n
+	help
+	 Select this option to enable the Hyper-V virtual storage driver.
--- a/drivers/staging/hv/Makefile
+++ b/drivers/staging/hv/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
+obj-$(CONFIG_HYPERV_STORAGE)	+= hv_storvsc.o
 
 hv_vmbus-objs := vmbus_drv.o osd.o Sources.o
+hv_storvsc-objs := storvsc_drv.o osd.o StorVsc.o
