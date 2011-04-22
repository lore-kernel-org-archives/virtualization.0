From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/21] Staging: hv: Get rid of blkvsc_do_read_capacity16()
Date: Fri, 22 Apr 2011 14:55:10 -0700
Message-ID: <1303509326-3094-5-git-send-email-kys@microsoft.com>
References: <1303509246-3053-1-git-send-email-kys@microsoft.com>
	<1303509326-3094-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303509326-3094-1-git-send-email-kys@microsoft.com>
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

Get rid of blkvsc_do_read_capacity16() and instead use the common function
for retrieving capacity.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   81 +--------------------------------------
 1 files changed, 2 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index b2d149d..7fab3c7 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -752,82 +752,6 @@ static int blkvsc_release(struct gendisk *disk, fmode_t mode)
 }
 
 
-static int blkvsc_do_read_capacity16(struct block_device_context *blkdev)
-{
-	struct blkvsc_request *blkvsc_req;
-	struct page *page_buf;
-	unsigned char *buf;
-	struct scsi_sense_hdr sense_hdr;
-	struct vmscsi_request *vm_srb;
-
-	DPRINT_DBG(BLKVSC_DRV, "blkvsc_do_read_capacity16()\n");
-
-	blkdev->sector_size = 0;
-	blkdev->capacity = 0;
-	blkdev->media_not_present = 0; /* assume a disk is present */
-
-	blkvsc_req = kmem_cache_zalloc(blkdev->request_pool, GFP_KERNEL);
-	if (!blkvsc_req)
-		return -ENOMEM;
-
-	memset(blkvsc_req, 0, sizeof(struct blkvsc_request));
-	vm_srb = &blkvsc_req->request.vstor_packet.vm_srb;
-	page_buf = alloc_page(GFP_KERNEL);
-	if (!page_buf) {
-		kmem_cache_free(blkvsc_req->dev->request_pool, blkvsc_req);
-		return -ENOMEM;
-	}
-
-	init_completion(&blkvsc_req->request.wait_event);
-	blkvsc_req->dev = blkdev;
-	blkvsc_req->req = NULL;
-	blkvsc_req->write = 0;
-
-	blkvsc_req->request.data_buffer.pfn_array[0] =
-	page_to_pfn(page_buf);
-	blkvsc_req->request.data_buffer.offset = 0;
-	blkvsc_req->request.data_buffer.len = 12;
-
-	blkvsc_req->cmnd[0] = 0x9E; /* READ_CAPACITY16; */
-	blkvsc_req->cmd_len = 16;
-
-	/*
-	 * Set this here since the completion routine may be invoked
-	 * and completed before we return
-	 */
-
-	blkvsc_submit_request(blkvsc_req, blkvsc_cmd_completion);
-
-	DPRINT_DBG(BLKVSC_DRV, "waiting %p to complete\n",
-		   blkvsc_req);
-
-	wait_for_completion_interruptible(&blkvsc_req->request.wait_event);
-
-	/* check error */
-	if (vm_srb->scsi_status) {
-		scsi_normalize_sense(blkvsc_req->sense_buffer,
-				     SCSI_SENSE_BUFFERSIZE, &sense_hdr);
-		if (sense_hdr.asc == 0x3A) {
-			/* Medium not present */
-			blkdev->media_not_present = 1;
-		}
-		return 0;
-	}
-	buf = kmap(page_buf);
-
-	/* be to le */
-	blkdev->capacity = be64_to_cpu(*(unsigned long long *) &buf[0]) + 1;
-	blkdev->sector_size = be32_to_cpu(*(unsigned int *)&buf[8]);
-
-	kunmap(page_buf);
-
-	__free_page(page_buf);
-
-	kmem_cache_free(blkvsc_req->dev->request_pool, blkvsc_req);
-
-	return 0;
-}
-
 static int blkvsc_revalidate_disk(struct gendisk *gd)
 {
 	struct block_device_context *blkdev = gd->private_data;
@@ -1312,9 +1236,8 @@ static int blkvsc_probe(struct device *device)
 		set_disk_ro(blkdev->gd, 1);
 		blkdev->gd->flags |= GENHD_FL_REMOVABLE;
 		blkvsc_do_operation(blkdev, DO_CAPACITY);
-	} else {
-		blkvsc_do_read_capacity16(blkdev);
-	}
+	} else
+		blkvsc_do_operation(blkdev, DO_CAPACITY);
 
 	set_capacity(blkdev->gd, blkdev->capacity * (blkdev->sector_size/512));
 	blk_queue_logical_block_size(blkdev->gd->queue, blkdev->sector_size);
-- 
1.7.4.1
