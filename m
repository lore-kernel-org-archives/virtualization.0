From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 03/24] blk-mq: Implement blk_mq_rq_is_reserved()
Date: Wed, 11 Mar 2020 00:25:29 +0800
Message-ID: <1583857550-12049-4-git-send-email-john.garry@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hannes Reinecke <hare@suse.com>

Add function to check if a blk-mq request is from the reserved pool

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c         | 13 +++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d92088dec6c3..603c60a1956c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -269,6 +269,19 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS)) || rq->q->elevator;
 }
 
+/**
+ * blk_mq_rq_is_reserved - Check if a request has a reserved tag
+ *
+ * @rq: Request to check
+ */
+bool blk_mq_rq_is_reserved(struct request *rq)
+{
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	return blk_mq_tag_is_reserved(hctx->tags, rq->tag);
+}
+EXPORT_SYMBOL_GPL(blk_mq_rq_is_reserved);
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, unsigned int op, u64 alloc_time_ns)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..8bdc35ac4a63 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -548,6 +548,8 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	return rq + 1;
 }
 
+bool blk_mq_rq_is_reserved(struct request *rq);
+
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
 	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
-- 
2.17.1
