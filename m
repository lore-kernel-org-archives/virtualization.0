From: Asias He <asias@redhat.com>
Subject: [RFC PATCH 4/5] virtio-blk: Use q->abort_queue_fn() to abort requests
Date: Mon, 21 May 2012 17:08:32 +0800
Message-ID: <1337591313-26333-4-git-send-email-asias@redhat.com>
References: <1337591313-26333-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1337591313-26333-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

virtblk_abort_queue() will be called by the block layer when cleans up
the queue. blk_cleanup_queue -> blk_drain_queue() -> q->abort_queue_fn(q)

virtblk_abort_queue()
1) Abort requests in block which is not dispatched to driver
2) Abort requests already dispatched to driver
3) Wake up processes which is sleeping on get_request_wait()

This makes hot-unplug a disk which is busy serving I/O success.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/block/virtio_blk.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7d5f5b0..ba35509 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -182,6 +182,31 @@ static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
 	return true;
 }
 
+void virtblk_abort_queue(struct request_queue *q)
+{
+	struct virtio_blk *vblk = q->queuedata;
+	struct virtblk_req *vbr;
+	int i;
+
+	/* Abort requests in block layer. */
+	elv_abort_queue(q);
+
+	/* Abort requests dispatched to driver. */
+	while ((vbr = virtqueue_detach_unused_buf(vblk->vq))) {
+		vbr->req->cmd_flags |= REQ_QUIET;
+		__blk_end_request_all(vbr->req, -EIO);
+		mempool_free(vbr, vblk->pool);
+	}
+
+	/* Wake up threads sleeping on get_request_wait() */
+	for (i = 0; i < ARRAY_SIZE(q->rq.wait); i++) {
+		if (waitqueue_active(&q->rq.wait[i]))
+			wake_up_all(&q->rq.wait[i]);
+	}
+
+	return;
+}
+
 static void do_virtblk_request(struct request_queue *q)
 {
 	struct virtio_blk *vblk = q->queuedata;
@@ -462,6 +487,8 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
 		goto out_put_disk;
 	}
 
+	blk_queue_abort_queue(q, virtblk_abort_queue);
+
 	q->queuedata = vblk;
 
 	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
@@ -576,8 +603,6 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 	int index = vblk->index;
-	struct virtblk_req *vbr;
-	unsigned long flags;
 
 	/* Prevent config work handler from accessing the device. */
 	mutex_lock(&vblk->config_lock);
@@ -591,15 +616,6 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
 
 	flush_work(&vblk->config_work);
 
-
-	/* Abort requests dispatched to driver. */
-	spin_lock_irqsave(&vblk->lock, flags);
-	while ((vbr = virtqueue_detach_unused_buf(vblk->vq))) {
-		__blk_end_request_all(vbr->req, -EIO);
-		mempool_free(vbr, vblk->pool);
-	}
-	spin_unlock_irqrestore(&vblk->lock, flags);
-
 	blk_cleanup_queue(vblk->disk->queue);
 	put_disk(vblk->disk);
 	mempool_destroy(vblk->pool);
-- 
1.7.10.1
