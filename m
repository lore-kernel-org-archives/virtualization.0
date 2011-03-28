From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 19/22] Staging: hv: Get rid of the forward declaration for
	blkvsc_request()
Date: Mon, 28 Mar 2011 10:00:50 -0700
Message-ID: <1301331653-26265-19-git-send-email-kys@microsoft.com>
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

Get rid of the forward declaration for blkvsc_request() by moving the code
around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   86 +++++++++++++++++++-------------------
 1 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 535f315..c45677b 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -1167,9 +1167,51 @@ static int blkvsc_do_pending_reqs(struct block_device_context *blkdev)
 	return ret;
 }
 
+
+static void blkvsc_request(struct request_queue *queue)
+{
+	struct block_device_context *blkdev = NULL;
+	struct request *req;
+	int ret = 0;
+
+	DPRINT_DBG(BLKVSC_DRV, "- enter\n");
+	while ((req = blk_peek_request(queue)) != NULL) {
+		DPRINT_DBG(BLKVSC_DRV, "- req %p\n", req);
+
+		blkdev = req->rq_disk->private_data;
+		if (blkdev->shutting_down || req->cmd_type != REQ_TYPE_FS ||
+		    blkdev->media_not_present) {
+			__blk_end_request_cur(req, 0);
+			continue;
+		}
+
+		ret = blkvsc_do_pending_reqs(blkdev);
+
+		if (ret != 0) {
+			DPRINT_DBG(BLKVSC_DRV,
+				   "- stop queue - pending_list not empty\n");
+			blk_stop_queue(queue);
+			break;
+		}
+
+		blk_start_request(req);
+
+		ret = blkvsc_do_request(blkdev, req);
+		if (ret > 0) {
+			DPRINT_DBG(BLKVSC_DRV, "- stop queue - no room\n");
+			blk_stop_queue(queue);
+			break;
+		} else if (ret < 0) {
+			DPRINT_DBG(BLKVSC_DRV, "- stop queue - no mem\n");
+			blk_requeue_request(queue, req);
+			blk_stop_queue(queue);
+			break;
+		}
+	}
+}
+
 /* Static decl */
 static int blkvsc_probe(struct device *dev);
-static void blkvsc_request(struct request_queue *queue);
 
 static int blkvsc_ringbuffer_size = BLKVSC_RING_BUFFER_SIZE;
 module_param(blkvsc_ringbuffer_size, int, S_IRUGO);
@@ -1496,48 +1538,6 @@ static void blkvsc_request_completion(struct hv_storvsc_request *request)
 	spin_unlock_irqrestore(&blkdev->lock, flags);
 }
 
-static void blkvsc_request(struct request_queue *queue)
-{
-	struct block_device_context *blkdev = NULL;
-	struct request *req;
-	int ret = 0;
-
-	DPRINT_DBG(BLKVSC_DRV, "- enter\n");
-	while ((req = blk_peek_request(queue)) != NULL) {
-		DPRINT_DBG(BLKVSC_DRV, "- req %p\n", req);
-
-		blkdev = req->rq_disk->private_data;
-		if (blkdev->shutting_down || req->cmd_type != REQ_TYPE_FS ||
-		    blkdev->media_not_present) {
-			__blk_end_request_cur(req, 0);
-			continue;
-		}
-
-		ret = blkvsc_do_pending_reqs(blkdev);
-
-		if (ret != 0) {
-			DPRINT_DBG(BLKVSC_DRV,
-				   "- stop queue - pending_list not empty\n");
-			blk_stop_queue(queue);
-			break;
-		}
-
-		blk_start_request(req);
-
-		ret = blkvsc_do_request(blkdev, req);
-		if (ret > 0) {
-			DPRINT_DBG(BLKVSC_DRV, "- stop queue - no room\n");
-			blk_stop_queue(queue);
-			break;
-		} else if (ret < 0) {
-			DPRINT_DBG(BLKVSC_DRV, "- stop queue - no mem\n");
-			blk_requeue_request(queue, req);
-			blk_stop_queue(queue);
-			break;
-		}
-	}
-}
-
 static int __init blkvsc_init(void)
 {
 	int ret;
-- 
1.7.4.1
