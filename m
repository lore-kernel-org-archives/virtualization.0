From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/22] Staging: hv: Get rid of the forward declaration of
	blkvsc_do_flush()
Date: Mon, 28 Mar 2011 10:00:39 -0700
Message-ID: <1301331653-26265-8-git-send-email-kys@microsoft.com>
References: <1301331615-26226-1-git-send-email-kys@microsoft.com>
	<1301331653-26265-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301331653-26265-1-git-send-email-kys@microsoft.com>
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

Get rid of the forward declaration of blkvsc_do_flush() by moving the code 
around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   71 +++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 8e575d9..f673337 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -462,6 +462,41 @@ static void blkvsc_cmd_completion(struct hv_storvsc_request *request)
 	complete(&blkvsc_req->request.wait_event);
 }
 
+static int blkvsc_do_flush(struct block_device_context *blkdev)
+{
+	struct blkvsc_request *blkvsc_req;
+
+	DPRINT_DBG(BLKVSC_DRV, "blkvsc_do_flush()\n");
+
+	if (blkdev->device_type != HARDDISK_TYPE)
+		return 0;
+
+	blkvsc_req = kmem_cache_zalloc(blkdev->request_pool, GFP_KERNEL);
+	if (!blkvsc_req)
+		return -ENOMEM;
+
+	memset(blkvsc_req, 0, sizeof(struct blkvsc_request));
+	init_completion(&blkvsc_req->request.wait_event);
+	blkvsc_req->dev = blkdev;
+	blkvsc_req->req = NULL;
+	blkvsc_req->write = 0;
+
+	blkvsc_req->request.data_buffer.pfn_array[0] = 0;
+	blkvsc_req->request.data_buffer.offset = 0;
+	blkvsc_req->request.data_buffer.len = 0;
+
+	blkvsc_req->cmnd[0] = SYNCHRONIZE_CACHE;
+	blkvsc_req->cmd_len = 10;
+
+	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
+
+	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
+
+	kmem_cache_free(blkvsc_req->dev->request_pool, blkvsc_req);
+
+	return 0;
+}
+
 
 /* Static decl */
 static int blkvsc_probe(struct device *dev);
@@ -477,7 +512,6 @@ static int blkvsc_do_request(struct block_device_context *blkdev,
 static int blkvsc_do_inquiry(struct block_device_context *blkdev);
 static int blkvsc_do_read_capacity(struct block_device_context *blkdev);
 static int blkvsc_do_read_capacity16(struct block_device_context *blkdev);
-static int blkvsc_do_flush(struct block_device_context *blkdev);
 static int blkvsc_cancel_pending_reqs(struct block_device_context *blkdev);
 static int blkvsc_do_pending_reqs(struct block_device_context *blkdev);
 
@@ -767,41 +801,6 @@ static void blkvsc_shutdown(struct device *device)
 	spin_unlock_irqrestore(&blkdev->lock, flags);
 }
 
-static int blkvsc_do_flush(struct block_device_context *blkdev)
-{
-	struct blkvsc_request *blkvsc_req;
-
-	DPRINT_DBG(BLKVSC_DRV, "blkvsc_do_flush()\n");
-
-	if (blkdev->device_type != HARDDISK_TYPE)
-		return 0;
-
-	blkvsc_req = kmem_cache_zalloc(blkdev->request_pool, GFP_KERNEL);
-	if (!blkvsc_req)
-		return -ENOMEM;
-
-	memset(blkvsc_req, 0, sizeof(struct blkvsc_request));
-	init_completion(&blkvsc_req->request.wait_event);
-	blkvsc_req->dev = blkdev;
-	blkvsc_req->req = NULL;
-	blkvsc_req->write = 0;
-
-	blkvsc_req->request.data_buffer.pfn_array[0] = 0;
-	blkvsc_req->request.data_buffer.offset = 0;
-	blkvsc_req->request.data_buffer.len = 0;
-
-	blkvsc_req->cmnd[0] = SYNCHRONIZE_CACHE;
-	blkvsc_req->cmd_len = 10;
-
-	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
-
-	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
-
-	kmem_cache_free(blkvsc_req->dev->request_pool, blkvsc_req);
-
-	return 0;
-}
-
 /* Do a scsi INQUIRY cmd here to get the device type (ie disk or dvd) */
 static int blkvsc_do_inquiry(struct block_device_context *blkdev)
 {
-- 
1.7.4.1
