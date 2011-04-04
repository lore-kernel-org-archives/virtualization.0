From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/22] Staging hv: Get rid of the state media_not_present
Date: Mon,  4 Apr 2011 15:47:57 -0700
Message-ID: <1301957291-8035-8-git-send-email-kys@microsoft.com>
References: <1301957186-7853-1-git-send-email-kys@microsoft.com>
	<1301957291-8035-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301957291-8035-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The block driver in Hyper-V does not handle removable media, get rid of the
media_not_present state.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 0715cba..1ea5f9c 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -103,7 +103,6 @@ struct block_device_context {
 	unsigned int device_id_len;
 	int num_outstanding_reqs;
 	int shutting_down;
-	int media_not_present;
 	unsigned int sector_size;
 	sector_t capacity;
 	unsigned int port;
@@ -445,7 +444,6 @@ static int blkvsc_do_operation(struct block_device_context *blkdev,
 	case DO_CAPACITY:
 		blkdev->sector_size = 0;
 		blkdev->capacity = 0;
-		blkdev->media_not_present = 0; /* assume a disk is present */
 
 		blkvsc_req->cmnd[0] = READ_CAPACITY;
 		blkvsc_req->cmd_len = 16;
@@ -472,10 +470,6 @@ static int blkvsc_do_operation(struct block_device_context *blkdev,
 		scsi_normalize_sense(blkvsc_req->sense_buffer,
 				     SCSI_SENSE_BUFFERSIZE, &sense_hdr);
 
-		if (sense_hdr.asc == 0x3A)
-			/* Medium not present */
-			blkdev->media_not_present = 1;
-
 		return 0;
 	}
 
@@ -963,8 +957,7 @@ static void blkvsc_request(struct request_queue *queue)
 		DPRINT_DBG(BLKVSC_DRV, "- req %p\n", req);
 
 		blkdev = req->rq_disk->private_data;
-		if (blkdev->shutting_down || req->cmd_type != REQ_TYPE_FS ||
-		    blkdev->media_not_present) {
+		if (blkdev->shutting_down || req->cmd_type != REQ_TYPE_FS) {
 			__blk_end_request_cur(req, 0);
 			continue;
 		}
-- 
1.7.4.1
