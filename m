From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 28/40] Staging: hv: storvsc: Handle IDE devices using the
	storvsc driver
Date: Wed, 29 Jun 2011 07:39:25 -0700
Message-ID: <1309358377-8537-28-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, make storvsc driver handle all block devices. Make appropriate changes
to not build hv_blkvsc, since it won't be used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/Kconfig       |    7 -------
 drivers/staging/hv/Makefile      |    2 --
 drivers/staging/hv/storvsc_drv.c |    1 +
 3 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/Kconfig b/drivers/staging/hv/Kconfig
index 5e0c9f6..26b5064 100644
--- a/drivers/staging/hv/Kconfig
+++ b/drivers/staging/hv/Kconfig
@@ -15,13 +15,6 @@ config HYPERV_STORAGE
 	help
 	 Select this option to enable the Hyper-V virtual storage driver.
 
-config HYPERV_BLOCK
-	tristate "Microsoft Hyper-V virtual block driver"
-	depends on BLOCK && SCSI && (LBDAF || 64BIT)
-	default HYPERV
-	help
-	  Select this option to enable the Hyper-V virtual block driver.
-
 config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on NET
diff --git a/drivers/staging/hv/Makefile b/drivers/staging/hv/Makefile
index 3004674..bb89437 100644
--- a/drivers/staging/hv/Makefile
+++ b/drivers/staging/hv/Makefile
@@ -1,6 +1,5 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o hv_timesource.o
 obj-$(CONFIG_HYPERV_STORAGE)	+= hv_storvsc.o
-obj-$(CONFIG_HYPERV_BLOCK)	+= hv_blkvsc.o
 obj-$(CONFIG_HYPERV_NET)	+= hv_netvsc.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_MOUSE)	+= hv_mouse.o
@@ -9,6 +8,5 @@ hv_vmbus-y := vmbus_drv.o \
 		 hv.o connection.o channel.o \
 		 channel_mgmt.o ring_buffer.o
 hv_storvsc-y := storvsc_drv.o storvsc.o
-hv_blkvsc-y := blkvsc_drv.o  storvsc.o
 hv_netvsc-y := netvsc_drv.o netvsc.o rndis_filter.o
 hv_utils-y := hv_util.o hv_kvp.o
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index a6da132..fc53bf6 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -709,6 +709,7 @@ static struct scsi_host_template scsi_driver = {
 
 static const struct hv_vmbus_device_id id_table[] = {
 	{ "hv_scsi" },
+	{ "hv_block" },
 	{ "" }
 };
 
-- 
1.7.4.1
