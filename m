From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 20/20] Staging: hv: Get rid of synch primitive in struct
	blkvsc_request
Date: Mon, 28 Mar 2011 09:33:45 -0700
Message-ID: <1301330025-25542-20-git-send-email-kys@microsoft.com>
References: <1301329950-25490-1-git-send-email-kys@microsoft.com>
	<1301330025-25542-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301330025-25542-1-git-send-email-kys@microsoft.com>
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

Get rid of synch primitive in struct blkvsc_request and instead use the
synch primitive already embedded in the struct hv_storvsc_request structure.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   52 +++++++++++---------------------------
 1 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 86e0506..9af5347 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -72,9 +72,6 @@ struct blkvsc_request {
 	/* The group this request is part of. Maybe null */
 	struct blkvsc_request_group *group;
 
-	wait_queue_head_t wevent;
-	int cond;
-
 	int write;
 	sector_t sector_start;
 	unsigned long sector_count;
@@ -515,7 +512,7 @@ static int blkvsc_do_flush(struct block_device_context *blkdev)
 		return -ENOMEM;
 
 	memset(blkvsc_req, 0, sizeof(struct blkvsc_request));
-	init_waitqueue_head(&blkvsc_req->wevent);
+	init_completion(&blkvsc_req->request.wait_event);
 	blkvsc_req->dev = blkdev;
 	blkvsc_req->req = NULL;
 	blkvsc_req->write = 0;
@@ -527,14 +524,9 @@ static int blkvsc_do_flush(struct block_device_context *blkdev)
 	blkvsc_req->cmnd[0] = SYNCHRONIZE_CACHE;
 	blkvsc_req->cmd_len = 10;
 
-	/*
-	 * Set this here since the completion routine may be invoked and
-	 * completed before we return
-	 */
-	blkvsc_req->cond = 0;
 	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
 
-	wait_event_interruptible(blkvsc_req->wevent, blkvsc_req->cond);
+	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
 
 	kmem_cache_free(blkvsc_req->dev->request_pool, blkvsc_req);
 
@@ -562,7 +554,7 @@ static int blkvsc_do_inquiry(struct block_device_context *blkdev)
 		return -ENOMEM;
 	}
 
-	init_waitqueue_head(&blkvsc_req->wevent);
+	init_completion(&blkvsc_req->request.wait_event);
 	blkvsc_req->dev = blkdev;
 	blkvsc_req->req = NULL;
 	blkvsc_req->write = 0;
@@ -578,18 +570,12 @@ static int blkvsc_do_inquiry(struct block_device_context *blkdev)
 	blkvsc_req->cmnd[4] = 64;
 	blkvsc_req->cmd_len = 6;
 
-	/*
-	 * Set this here since the completion routine may be invoked and
-	 * completed before we return
-	 */
-	blkvsc_req->cond = 0;
-
 	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
 
-	DPRINT_DBG(BLKVSC_DRV, "waiting %p to complete - cond %d\n",
-		   blkvsc_req, blkvsc_req->cond);
+	DPRINT_DBG(BLKVSC_DRV, "waiting %p to complete\n",
+		   blkvsc_req);
 
-	wait_event_interruptible(blkvsc_req->wevent, blkvsc_req->cond);
+	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
 
 	buf = kmap(page_buf);
 
@@ -652,7 +638,7 @@ static int blkvsc_do_read_capacity(struct block_device_context *blkdev)
 	}
 
 	vm_srb = &blkvsc_req->request.vstor_packet.vm_srb;
-	init_waitqueue_head(&blkvsc_req->wevent);
+	init_completion(&blkvsc_req->request.wait_event);
 	blkvsc_req->dev = blkdev;
 	blkvsc_req->req = NULL;
 	blkvsc_req->write = 0;
@@ -665,18 +651,12 @@ static int blkvsc_do_read_capacity(struct block_device_context *blkdev)
 	blkvsc_req->cmnd[0] = READ_CAPACITY;
 	blkvsc_req->cmd_len = 16;
 
-	/*
-	 * Set this here since the completion routine may be invoked
-	 * and completed before we return
-	 */
-	blkvsc_req->cond = 0;
-
 	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
 
-	DPRINT_DBG(BLKVSC_DRV, "waiting %p to complete - cond %d\n",
-		   blkvsc_req, blkvsc_req->cond);
+	DPRINT_DBG(BLKVSC_DRV, "waiting %p to complete\n",
+		   blkvsc_req);
 
-	wait_event_interruptible(blkvsc_req->wevent, blkvsc_req->cond);
+	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
 
 	/* check error */
 	if (vm_srb->scsi_status) {
@@ -732,7 +712,7 @@ static int blkvsc_do_read_capacity16(struct block_device_context *blkdev)
 		return -ENOMEM;
 	}
 
-	init_waitqueue_head(&blkvsc_req->wevent);
+	init_completion(&blkvsc_req->request.wait_event);
 	blkvsc_req->dev = blkdev;
 	blkvsc_req->req = NULL;
 	blkvsc_req->write = 0;
@@ -749,14 +729,13 @@ static int blkvsc_do_read_capacity16(struct block_device_context *blkdev)
 	 * Set this here since the completion routine may be invoked
 	 * and completed before we return
 	 */
-	blkvsc_req->cond = 0;
 
 	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
 
-	DPRINT_DBG(BLKVSC_DRV, "waiting %p to complete - cond %d\n",
-		   blkvsc_req, blkvsc_req->cond);
+	DPRINT_DBG(BLKVSC_DRV, "waiting %p to complete\n",
+		   blkvsc_req);
 
-	wait_event_interruptible(blkvsc_req->wevent, blkvsc_req->cond);
+	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
 
 	/* check error */
 	if (vm_srb->scsi_status) {
@@ -1161,8 +1140,7 @@ static void blkvsc_cmd_completion(struct hv_storvsc_request *request)
 					 SCSI_SENSE_BUFFERSIZE, &sense_hdr))
 			scsi_print_sense_hdr("blkvsc", &sense_hdr);
 
-	blkvsc_req->cond = 1;
-	wake_up_interruptible(&blkvsc_req->wevent);
+	complete(&blkvsc_req->request.wait_event);
 }
 
 static void blkvsc_request_completion(struct hv_storvsc_request *request)
-- 
1.7.4.1
