From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 003/206] Staging: hv: Fix some locking issues
Date: Mon,  9 May 2011 14:54:45 -0700
Message-ID: <1304978288-22999-3-git-send-email-kys@microsoft.com>
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

Additional lock related cleanup. Properly serialize access to
state even for command related operations.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 74d51bb..8a577bc 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -331,10 +331,14 @@ static void blkvsc_cmd_completion(struct hv_storvsc_request *request)
 			(struct block_device_context *)blkvsc_req->dev;
 	struct scsi_sense_hdr sense_hdr;
 	struct vmscsi_request *vm_srb;
+	unsigned long flags;
 
 
 	vm_srb = &blkvsc_req->request.vstor_packet.vm_srb;
+
+	spin_lock_irqsave(&blkdev->lock, flags);
 	blkdev->num_outstanding_reqs--;
+	spin_unlock_irqrestore(&blkdev->lock, flags);
 
 	if (vm_srb->scsi_status)
 		if (scsi_normalize_sense(blkvsc_req->sense_buffer,
@@ -354,6 +358,7 @@ static int blkvsc_do_operation(struct block_device_context *blkdev,
 	unsigned char device_type;
 	struct scsi_sense_hdr sense_hdr;
 	struct vmscsi_request *vm_srb;
+	unsigned long flags;
 
 	int ret = 0;
 
@@ -407,7 +412,9 @@ static int blkvsc_do_operation(struct block_device_context *blkdev,
 		goto cleanup;
 	}
 
+	spin_lock_irqsave(&blkdev->lock, flags);
 	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
+	spin_unlock_irqrestore(&blkdev->lock, flags);
 
 	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
 
@@ -555,6 +562,8 @@ static int blkvsc_remove(struct hv_device *dev)
 
 	blk_stop_queue(blkdev->gd->queue);
 
+	blkvsc_cancel_pending_reqs(blkdev);
+
 	spin_unlock_irqrestore(&blkdev->lock, flags);
 
 	while (blkdev->num_outstanding_reqs) {
@@ -563,13 +572,8 @@ static int blkvsc_remove(struct hv_device *dev)
 		udelay(100);
 	}
 
-	blkvsc_do_operation(blkdev, DO_FLUSH);
-
-	spin_lock_irqsave(&blkdev->lock, flags);
 
-	blkvsc_cancel_pending_reqs(blkdev);
-
-	spin_unlock_irqrestore(&blkdev->lock, flags);
+	blkvsc_do_operation(blkdev, DO_FLUSH);
 
 	blk_cleanup_queue(blkdev->gd->queue);
 
@@ -597,6 +601,8 @@ static void blkvsc_shutdown(struct hv_device *dev)
 
 	blk_stop_queue(blkdev->gd->queue);
 
+	blkvsc_cancel_pending_reqs(blkdev);
+
 	spin_unlock_irqrestore(&blkdev->lock, flags);
 
 	while (blkdev->num_outstanding_reqs) {
@@ -605,13 +611,9 @@ static void blkvsc_shutdown(struct hv_device *dev)
 		udelay(100);
 	}
 
-	blkvsc_do_operation(blkdev, DO_FLUSH);
 
-	spin_lock_irqsave(&blkdev->lock, flags);
-
-	blkvsc_cancel_pending_reqs(blkdev);
+	blkvsc_do_operation(blkdev, DO_FLUSH);
 
-	spin_unlock_irqrestore(&blkdev->lock, flags);
 }
 
 static int blkvsc_release(struct gendisk *disk, fmode_t mode)
@@ -619,16 +621,14 @@ static int blkvsc_release(struct gendisk *disk, fmode_t mode)
 	struct block_device_context *blkdev = disk->private_data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&blkdev->lock, flags);
 	if (blkdev->users == 1) {
-		spin_unlock_irqrestore(&blkdev->lock, flags);
 		blkvsc_do_operation(blkdev, DO_FLUSH);
-		spin_lock_irqsave(&blkdev->lock, flags);
 	}
 
+	spin_lock_irqsave(&blkdev->lock, flags);
 	blkdev->users--;
-
 	spin_unlock_irqrestore(&blkdev->lock, flags);
+
 	return 0;
 }
 
@@ -943,7 +943,6 @@ static int blkvsc_probe(struct hv_device *dev)
 	struct storvsc_major_info major_info;
 	int ret = 0;
 
-
 	blkdev = kzalloc(sizeof(struct block_device_context), GFP_KERNEL);
 	if (!blkdev) {
 		ret = -ENOMEM;
-- 
1.7.4.1
