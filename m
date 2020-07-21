From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 01/10] block: introduce blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 13:52:30 +0300
Message-ID: <20200721105239.8270-2-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
Sender: linux-block-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

Kernel block layer has never supported logical block
sizes less that SECTOR_SIZE nor larger that PAGE_SIZE.

Some drivers have runtime configurable block size,
so it makes sense to have common helper for that.

Signed-off-by: Maxim Levitsky  <mlevitsk@redhat.com>
---
 block/blk-settings.c   | 18 ++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9a2c23cd97007..3c4ef0d00c2bc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -311,6 +311,21 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 }
 EXPORT_SYMBOL(blk_queue_max_segment_size);
 
+
+/**
+ * blk_check_logical_block_size - check if logical block size is supported
+ * by the kernel
+ * @size:  the logical block size, in bytes
+ *
+ * Description:
+ *   This function checks if the block layers supports given block size
+ **/
+bool blk_is_valid_logical_block_size(unsigned int size)
+{
+	return size >= SECTOR_SIZE && size <= PAGE_SIZE && !is_power_of_2(size);
+}
+EXPORT_SYMBOL(blk_is_valid_logical_block_size);
+
 /**
  * blk_queue_logical_block_size - set logical block size for the queue
  * @q:  the request queue for the device
@@ -323,6 +338,8 @@ EXPORT_SYMBOL(blk_queue_max_segment_size);
  **/
 void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
+	WARN_ON(!blk_is_valid_logical_block_size(size));
+
 	q->limits.logical_block_size = size;
 
 	if (q->limits.physical_block_size < size)
@@ -330,6 +347,7 @@ void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 
 	if (q->limits.io_min < q->limits.physical_block_size)
 		q->limits.io_min = q->limits.physical_block_size;
+
 }
 EXPORT_SYMBOL(blk_queue_logical_block_size);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 57241417ff2f8..2ed3151397e41 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1099,6 +1099,7 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern bool blk_is_valid_logical_block_size(unsigned int size);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
-- 
2.26.2
