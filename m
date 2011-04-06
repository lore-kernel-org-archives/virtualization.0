From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/22] Staging: hv: Get rid of the forward declaration of blkvsc_ioctl()
Date: Wed,  6 Apr 2011 14:35:04 -0700
Message-ID: <1302125720-10808-6-git-send-email-kys@microsoft.com>
References: <1302125655-10741-1-git-send-email-kys@microsoft.com>
 <1302125720-10808-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1302125720-10808-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the forward declaration of blkvsc_ioctl() by moving the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   56 ++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 5f14bb6..a16f38c 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -415,6 +415,33 @@ static void blkvsc_init_rw(struct blkvsc_request *blkvsc_req)
 }
 
 
+static int blkvsc_ioctl(struct block_device *bd, fmode_t mode,
+			unsigned cmd, unsigned long argument)
+{
+/*	struct block_device_context *blkdev = bd->bd_disk->private_data; */
+	int ret;
+
+	switch (cmd) {
+	/*
+	 * TODO: I think there is certain format for HDIO_GET_IDENTITY rather
+	 * than just a GUID. Commented it out for now.
+	 */
+#if 0
+	case HDIO_GET_IDENTITY:
+		DPRINT_INFO(BLKVSC_DRV, "HDIO_GET_IDENTITY\n");
+		if (copy_to_user((void __user *)arg, blkdev->device_id,
+				 blkdev->device_id_len))
+			ret = -EFAULT;
+		break;
+#endif
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 /* Static decl */
 static int blkvsc_probe(struct device *dev);
 static int blkvsc_remove(struct device *device);
@@ -422,8 +449,6 @@ static void blkvsc_shutdown(struct device *device);
 
 static int blkvsc_release(struct gendisk *disk, fmode_t mode);
 static int blkvsc_revalidate_disk(struct gendisk *gd);
-static int blkvsc_ioctl(struct block_device *bd, fmode_t mode,
-			unsigned cmd, unsigned long argument);
 static void blkvsc_request(struct request_queue *queue);
 static void blkvsc_request_completion(struct hv_storvsc_request *request);
 static int blkvsc_do_request(struct block_device_context *blkdev,
@@ -1508,33 +1533,6 @@ static int blkvsc_revalidate_disk(struct gendisk *gd)
 	return 0;
 }
 
-static int blkvsc_ioctl(struct block_device *bd, fmode_t mode,
-			unsigned cmd, unsigned long argument)
-{
-/*	struct block_device_context *blkdev = bd->bd_disk->private_data; */
-	int ret;
-
-	switch (cmd) {
-	/*
-	 * TODO: I think there is certain format for HDIO_GET_IDENTITY rather
-	 * than just a GUID. Commented it out for now.
-	 */
-#if 0
-	case HDIO_GET_IDENTITY:
-		DPRINT_INFO(BLKVSC_DRV, "HDIO_GET_IDENTITY\n");
-		if (copy_to_user((void __user *)arg, blkdev->device_id,
-				 blkdev->device_id_len))
-			ret = -EFAULT;
-		break;
-#endif
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 static int __init blkvsc_init(void)
 {
 	int ret;
-- 
1.7.4.1
