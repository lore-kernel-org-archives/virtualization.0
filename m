From: Asias He <asias@redhat.com>
Subject: [PATCH v2 2/3] block: Add blk_bio_map_sg() helper
Date: Mon, 18 Jun 2012 14:53:09 +0800
Message-ID: <1340002390-3950-3-git-send-email-asias@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1340002390-3950-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Add a helper to map a bio to a scatterlist, modelled after
blk_rq_map_sg.

This helper is useful for any driver that wants to create
a scatterlist from its ->make_request_fn method.

Changes in v2:
 - Use __blk_segment_map_sg to avoid duplicated code
 - Add cocbook style function comment

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Minchan Kim <minchan.kim@gmail.com>
Signed-off-by: Asias He <asias@redhat.com>
---
 block/blk-merge.c      |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |    2 ++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 576b68e..e76279e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -209,6 +209,43 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_sg);
 
+/**
+ * blk_bio_map_sg - map a bio to a scatterlist
+ * @q: request_queue in question
+ * @bio: bio being mapped
+ * @sglist: scatterlist being mapped
+ *
+ * Note:
+ *    Caller must make sure sg can hold bio->bi_phys_segments entries
+ *
+ * Will return the number of sg entries setup
+ */
+int blk_bio_map_sg(struct request_queue *q, struct bio *bio,
+		   struct scatterlist *sglist)
+{
+	struct bio_vec *bvec, *bvprv;
+	struct scatterlist *sg;
+	int nsegs, cluster;
+	unsigned long i;
+
+	nsegs = 0;
+	cluster = blk_queue_cluster(q);
+
+	bvprv = NULL;
+	sg = NULL;
+	bio_for_each_segment(bvec, bio, i) {
+		__blk_segment_map_sg(q, bvec, sglist, &bvprv, &sg,
+				     &nsegs, &cluster);
+	} /* segments in bio */
+
+	if (sg)
+		sg_mark_end(sg);
+
+	BUG_ON(bio->bi_phys_segments && nsegs > bio->bi_phys_segments);
+	return nsegs;
+}
+EXPORT_SYMBOL(blk_bio_map_sg);
+
 static inline int ll_new_hw_segment(struct request_queue *q,
 				    struct request *req,
 				    struct bio *bio)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba43f40..46916af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -884,6 +884,8 @@ extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
 extern int blk_rq_map_sg(struct request_queue *, struct request *, struct scatterlist *);
+extern int blk_bio_map_sg(struct request_queue *q, struct bio *bio,
+			  struct scatterlist *sglist);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern long nr_blockdev_pages(void);
 
-- 
1.7.10.2
