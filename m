From: Asias He <asias@redhat.com>
Subject: [RFC PATCH 1/5] block: Introduce q->abort_queue_fn()
Date: Mon, 21 May 2012 17:08:29 +0800
Message-ID: <1337591313-26333-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

When user hot-unplug a disk which is busy serving I/O, __blk_run_queue
might be unable to drain all the requests. As a result, the
blk_drain_queue() would loop forever and blk_cleanup_queue would not
return. So hot-unplug will fail.

This patch adds a callback in blk_drain_queue() for low lever driver to
abort requests.

Currently, this is useful for virtio-blk to do cleanup in hot-unplug.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Signed-off-by: Asias He <asias@redhat.com>
---
 block/blk-core.c       |    3 +++
 block/blk-settings.c   |   12 ++++++++++++
 include/linux/blkdev.h |    3 +++
 3 files changed, 18 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1f61b74..ca42fd7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -369,6 +369,9 @@ void blk_drain_queue(struct request_queue *q, bool drain_all)
 		if (drain_all)
 			blk_throtl_drain(q);
 
+		if (q->abort_queue_fn)
+			q->abort_queue_fn(q);
+
 		/*
 		 * This function might be called on a queue which failed
 		 * driver init after queue creation.  Some drivers
diff --git a/block/blk-settings.c b/block/blk-settings.c
index d3234fc..83ccb48 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -100,6 +100,18 @@ void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn)
 EXPORT_SYMBOL_GPL(blk_queue_lld_busy);
 
 /**
+ * blk_queue_abort_queue - set driver specific abort function
+ * @q:		queue
+ * @mbfn:	abort_queue_fn
+ */
+void blk_queue_abort_queue(struct request_queue *q, abort_queue_fn *afn)
+{
+	q->abort_queue_fn = afn;
+}
+EXPORT_SYMBOL(blk_queue_abort_queue);
+
+
+/**
  * blk_set_default_limits - reset limits to default values
  * @lim:  the queue_limits structure to reset
  *
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2aa2466..e2d58bd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -200,6 +200,7 @@ struct request_pm_state
 
 typedef void (request_fn_proc) (struct request_queue *q);
 typedef void (make_request_fn) (struct request_queue *q, struct bio *bio);
+typedef void (abort_queue_fn) (struct request_queue *q);
 typedef int (prep_rq_fn) (struct request_queue *, struct request *);
 typedef void (unprep_rq_fn) (struct request_queue *, struct request *);
 
@@ -282,6 +283,7 @@ struct request_queue {
 
 	request_fn_proc		*request_fn;
 	make_request_fn		*make_request_fn;
+	abort_queue_fn		*abort_queue_fn;
 	prep_rq_fn		*prep_rq_fn;
 	unprep_rq_fn		*unprep_rq_fn;
 	merge_bvec_fn		*merge_bvec_fn;
@@ -821,6 +823,7 @@ extern struct request_queue *blk_init_allocated_queue(struct request_queue *,
 						      request_fn_proc *, spinlock_t *);
 extern void blk_cleanup_queue(struct request_queue *);
 extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
+extern void blk_queue_abort_queue(struct request_queue *, abort_queue_fn *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_limits_max_hw_sectors(struct queue_limits *, unsigned int);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
-- 
1.7.10.1
