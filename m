From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 013/206] Staging: hv: Get rid of the indirection for removing
	stor device
Date: Mon,  9 May 2011 14:54:55 -0700
Message-ID: <1304978288-22999-13-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 830f257..8b8d960 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -197,7 +197,6 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 		    stor_driver->max_outstanding_req_per_channel);
 
 	/* Setup the dispatch table */
-	stor_driver->base.dev_rm = storvsc_dev_remove;
 	stor_driver->base.cleanup = stor_vsc_on_cleanup;
 	stor_driver->on_io_request = stor_vsc_on_io_request;
 
@@ -543,8 +542,6 @@ out:
  */
 static int blkvsc_remove(struct hv_device *dev)
 {
-	struct storvsc_driver *storvsc_drv =
-				drv_to_stordrv(dev->device.driver);
 	struct block_device_context *blkdev = dev_get_drvdata(&dev->device);
 	unsigned long flags;
 
@@ -552,7 +549,7 @@ static int blkvsc_remove(struct hv_device *dev)
 	 * Call to the vsc driver to let it know that the device is being
 	 * removed
 	 */
-	storvsc_drv->base.dev_rm(dev);
+	storvsc_dev_remove(dev);
 
 	/* Get to a known state */
 	spin_lock_irqsave(&blkdev->lock, flags);
@@ -934,9 +931,6 @@ static void blkvsc_drv_exit(void)
  */
 static int blkvsc_probe(struct hv_device *dev)
 {
-	struct storvsc_driver *storvsc_drv =
-			drv_to_stordrv(dev->device.driver);
-
 	struct block_device_context *blkdev = NULL;
 	struct storvsc_device_info device_info;
 	struct storvsc_major_info major_info;
@@ -1033,7 +1027,7 @@ static int blkvsc_probe(struct hv_device *dev)
 	return ret;
 
 remove:
-	storvsc_drv->base.dev_rm(dev);
+	storvsc_dev_remove(dev);
 
 cleanup:
 	if (blkdev) {
-- 
1.7.4.1
