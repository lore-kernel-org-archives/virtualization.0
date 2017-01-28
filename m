From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/5] virtio_blk: remove struct request backpointer from
	virtblk_req
Date: Sat, 28 Jan 2017 09:32:52 +0100
Message-ID: <1485592373-29837-5-git-send-email-hch@lst.de>
References: <1485592373-29837-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1485592373-29837-1-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@fb.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We can simply use blk_mq_rq_from_pdu to get back at the request at
I/O completion time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3027d2e..7c730e2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -53,7 +53,6 @@ struct virtio_blk {
 
 struct virtblk_req {
 	struct scsi_request sreq;	/* for SCSI passthrough */
-	struct request *req;
 	struct virtio_blk_outhdr out_hdr;
 	struct virtio_scsi_inhdr in_hdr;
 	u8 status;
@@ -148,7 +147,9 @@ static void virtblk_done(struct virtqueue *vq)
 	do {
 		virtqueue_disable_cb(vq);
 		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
-			blk_mq_complete_request(vbr->req, vbr->req->errors);
+			struct request *req = blk_mq_rq_from_pdu(vbr);
+
+			blk_mq_complete_request(req, req->errors);
 			req_done = true;
 		}
 		if (unlikely(virtqueue_is_broken(vq)))
@@ -175,27 +176,26 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
 
-	vbr->req = req;
 	if (req_op(req) == REQ_OP_FLUSH) {
 		vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_FLUSH);
 		vbr->out_hdr.sector = 0;
-		vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(vbr->req));
+		vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
 	} else {
 		switch (req->cmd_type) {
 		case REQ_TYPE_FS:
 			vbr->out_hdr.type = 0;
-			vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, blk_rq_pos(vbr->req));
-			vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(vbr->req));
+			vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, blk_rq_pos(req));
+			vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
 			break;
 		case REQ_TYPE_BLOCK_PC:
 			vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_SCSI_CMD);
 			vbr->out_hdr.sector = 0;
-			vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(vbr->req));
+			vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
 			break;
 		case REQ_TYPE_DRV_PRIV:
 			vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
 			vbr->out_hdr.sector = 0;
-			vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(vbr->req));
+			vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
 			break;
 		default:
 			/* We don't put anything else in the queue. */
@@ -205,9 +205,9 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	num = blk_rq_map_sg(hctx->queue, vbr->req, vbr->sg);
+	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
 	if (num) {
-		if (rq_data_dir(vbr->req) == WRITE)
+		if (rq_data_dir(req) == WRITE)
 			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);
 		else
 			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_IN);
-- 
2.1.4
