From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/22] Staging: hv: Get rid of the forward declaration of
	blkvsc_ioctl()
Date: Mon, 28 Mar 2011 10:00:37 -0700
Message-ID: <1301331653-26265-6-git-send-email-kys@microsoft.com>
References: <1301331615-26226-1-git-send-email-kys@microsoft.com>
	<1301331653-26265-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1301331653-26265-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
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
index e9d45eb..30a37a2 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -412,6 +412,33 @@ static void blkvsc_init_rw(struct blkvsc_request *blkvsc_req)
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
@@ -419,8 +446,6 @@ static void blkvsc_shutdown(struct device *device);
 
 static int blkvsc_release(struct gendisk *disk, fmode_t mode);
 static int blkvsc_revalidate_disk(struct gendisk *gd);
-static int blkvsc_ioctl(struct block_device *bd, fmode_t mode,
-			unsigned cmd, unsigned long argument);
 static void blkvsc_request(struct request_queue *queue);
 static void blkvsc_request_completion(struct hv_storvsc_request *request);
 static int blkvsc_do_request(struct block_device_context *blkdev,
@@ -1505,33 +1530,6 @@ static int blkvsc_revalidate_disk(struct gendisk *gd)
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
