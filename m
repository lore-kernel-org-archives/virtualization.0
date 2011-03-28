From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 10/22] Staging: hv: Get rid of the forward declaration of blkvsc_remove()
Date: Mon, 28 Mar 2011 10:00:41 -0700
Message-ID: <1301331653-26265-10-git-send-email-kys@microsoft.com>
References: <1301331615-26226-1-git-send-email-kys@microsoft.com>
 <1301331653-26265-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301331653-26265-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the forward declaration of blkvsc_remove() by moving the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |  130 +++++++++++++++++++-------------------
 1 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index c1e673b..f67d983 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -577,9 +577,73 @@ out:
 	return ret;
 }
 
+
+/*
+ * blkvsc_remove() - Callback when our device is removed
+ */
+static int blkvsc_remove(struct device *device)
+{
+	struct hv_driver *drv =
+				drv_to_hv_drv(device->driver);
+	struct storvsc_driver_object *storvsc_drv_obj =
+				drv->priv;
+	struct hv_device *device_obj = device_to_hv_device(device);
+	struct block_device_context *blkdev = dev_get_drvdata(device);
+	unsigned long flags;
+	int ret;
+
+	DPRINT_DBG(BLKVSC_DRV, "blkvsc_remove()\n");
+
+	if (!storvsc_drv_obj->base.dev_rm)
+		return -1;
+
+	/*
+	 * Call to the vsc driver to let it know that the device is being
+	 * removed
+	 */
+	ret = storvsc_drv_obj->base.dev_rm(device_obj);
+	if (ret != 0) {
+		/* TODO: */
+		DPRINT_ERR(BLKVSC_DRV,
+			   "unable to remove blkvsc device (ret %d)", ret);
+	}
+
+	/* Get to a known state */
+	spin_lock_irqsave(&blkdev->lock, flags);
+
+	blkdev->shutting_down = 1;
+
+	blk_stop_queue(blkdev->gd->queue);
+
+	spin_unlock_irqrestore(&blkdev->lock, flags);
+
+	while (blkdev->num_outstanding_reqs) {
+		DPRINT_INFO(STORVSC, "waiting for %d requests to complete...",
+			    blkdev->num_outstanding_reqs);
+		udelay(100);
+	}
+
+	blkvsc_do_flush(blkdev);
+
+	spin_lock_irqsave(&blkdev->lock, flags);
+
+	blkvsc_cancel_pending_reqs(blkdev);
+
+	spin_unlock_irqrestore(&blkdev->lock, flags);
+
+	blk_cleanup_queue(blkdev->gd->queue);
+
+	del_gendisk(blkdev->gd);
+
+	kmem_cache_destroy(blkdev->request_pool);
+
+	kfree(blkdev);
+
+	return ret;
+}
+
 /* Static decl */
 static int blkvsc_probe(struct device *dev);
-static int blkvsc_remove(struct device *device);
 static void blkvsc_shutdown(struct device *device);
 
 static int blkvsc_release(struct gendisk *disk, fmode_t mode);
@@ -1116,70 +1180,6 @@ static int blkvsc_do_read_capacity16(struct block_device_context *blkdev)
 }
 
 /*
- * blkvsc_remove() - Callback when our device is removed
- */
-static int blkvsc_remove(struct device *device)
-{
-	struct hv_driver *drv =
-				drv_to_hv_drv(device->driver);
-	struct storvsc_driver_object *storvsc_drv_obj =
-				drv->priv;
-	struct hv_device *device_obj = device_to_hv_device(device);
-	struct block_device_context *blkdev = dev_get_drvdata(device);
-	unsigned long flags;
-	int ret;
-
-	DPRINT_DBG(BLKVSC_DRV, "blkvsc_remove()\n");
-
-	if (!storvsc_drv_obj->base.dev_rm)
-		return -1;
-
-	/*
-	 * Call to the vsc driver to let it know that the device is being
-	 * removed
-	 */
-	ret = storvsc_drv_obj->base.dev_rm(device_obj);
-	if (ret != 0) {
-		/* TODO: */
-		DPRINT_ERR(BLKVSC_DRV,
-			   "unable to remove blkvsc device (ret %d)", ret);
-	}
-
-	/* Get to a known state */
-	spin_lock_irqsave(&blkdev->lock, flags);
-
-	blkdev->shutting_down = 1;
-
-	blk_stop_queue(blkdev->gd->queue);
-
-	spin_unlock_irqrestore(&blkdev->lock, flags);
-
-	while (blkdev->num_outstanding_reqs) {
-		DPRINT_INFO(STORVSC, "waiting for %d requests to complete...",
-			    blkdev->num_outstanding_reqs);
-		udelay(100);
-	}
-
-	blkvsc_do_flush(blkdev);
-
-	spin_lock_irqsave(&blkdev->lock, flags);
-
-	blkvsc_cancel_pending_reqs(blkdev);
-
-	spin_unlock_irqrestore(&blkdev->lock, flags);
-
-	blk_cleanup_queue(blkdev->gd->queue);
-
-	del_gendisk(blkdev->gd);
-
-	kmem_cache_destroy(blkdev->request_pool);
-
-	kfree(blkdev);
-
-	return ret;
-}
-
-/*
  * We break the request into 1 or more blkvsc_requests and submit
  * them.  If we cant submit them all, we put them on the
  * pending_list. The blkvsc_request() will work on the pending_list.
-- 
1.7.4.1
