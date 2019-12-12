From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] virtio-blk: remove VIRTIO_BLK_F_SCSI support
Date: Thu, 12 Dec 2019 17:37:19 +0100
Message-ID: <20191212163719.28432-1-hch@lst.de>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Since the need for a special flag to support SCSI passthrough on a
block device was added in May 2017 the SCSI passthrough support in
virtio-blk has been disabled.  It has always been a bad idea
(just ask the original author..) and we have virtio-scsi for proper
passthrough.  The feature also never made it into the virtio 1.0
or later specifications.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/configs/guest.config |   1 -
 drivers/block/Kconfig             |  10 ---
 drivers/block/virtio_blk.c        | 115 +-----------------------------
 3 files changed, 1 insertion(+), 125 deletions(-)

diff --git a/arch/powerpc/configs/guest.config b/arch/powerpc/configs/guest.config
index 8b8cd18ecd7c..209f58515d88 100644
--- a/arch/powerpc/configs/guest.config
+++ b/arch/powerpc/configs/guest.config
@@ -1,5 +1,4 @@
 CONFIG_VIRTIO_BLK=y
-CONFIG_VIRTIO_BLK_SCSI=y
 CONFIG_SCSI_VIRTIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_NET_FAILOVER=y
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..025b1b77b11a 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -432,16 +432,6 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
-config VIRTIO_BLK_SCSI
-	bool "SCSI passthrough request for the Virtio block driver"
-	depends on VIRTIO_BLK
-	select BLK_SCSI_REQUEST
-	---help---
-	  Enable support for SCSI passthrough (e.g. the SG_IO ioctl) on
-	  virtio-blk devices.  This is only supported for the legacy
-	  virtio protocol and not enabled by default by any hypervisor.
-	  You probably want to use virtio-scsi instead.
-
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7ffd719d89de..54158766334b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -11,7 +11,6 @@
 #include <linux/virtio_blk.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
-#include <scsi/scsi_cmnd.h>
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-virtio.h>
@@ -56,11 +55,6 @@ struct virtio_blk {
 };
 
 struct virtblk_req {
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	struct scsi_request sreq;	/* for SCSI passthrough, must be first */
-	u8 sense[SCSI_SENSE_BUFFERSIZE];
-	struct virtio_scsi_inhdr in_hdr;
-#endif
 	struct virtio_blk_outhdr out_hdr;
 	u8 status;
 	struct scatterlist sg[];
@@ -78,80 +72,6 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
 	}
 }
 
-/*
- * If this is a packet command we need a couple of additional headers.  Behind
- * the normal outhdr we put a segment with the scsi command block, and before
- * the normal inhdr we put the sense data and the inhdr with additional status
- * information.
- */
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-static int virtblk_add_req_scsi(struct virtqueue *vq, struct virtblk_req *vbr,
-		struct scatterlist *data_sg, bool have_data)
-{
-	struct scatterlist hdr, status, cmd, sense, inhdr, *sgs[6];
-	unsigned int num_out = 0, num_in = 0;
-
-	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
-	sgs[num_out++] = &hdr;
-	sg_init_one(&cmd, vbr->sreq.cmd, vbr->sreq.cmd_len);
-	sgs[num_out++] = &cmd;
-
-	if (have_data) {
-		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
-			sgs[num_out++] = data_sg;
-		else
-			sgs[num_out + num_in++] = data_sg;
-	}
-
-	sg_init_one(&sense, vbr->sense, SCSI_SENSE_BUFFERSIZE);
-	sgs[num_out + num_in++] = &sense;
-	sg_init_one(&inhdr, &vbr->in_hdr, sizeof(vbr->in_hdr));
-	sgs[num_out + num_in++] = &inhdr;
-	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
-	sgs[num_out + num_in++] = &status;
-
-	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
-}
-
-static inline void virtblk_scsi_request_done(struct request *req)
-{
-	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	struct virtio_blk *vblk = req->q->queuedata;
-	struct scsi_request *sreq = &vbr->sreq;
-
-	sreq->resid_len = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.residual);
-	sreq->sense_len = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.sense_len);
-	sreq->result = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.errors);
-}
-
-static int virtblk_ioctl(struct block_device *bdev, fmode_t mode,
-			     unsigned int cmd, unsigned long data)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	struct virtio_blk *vblk = disk->private_data;
-
-	/*
-	 * Only allow the generic SCSI ioctls if the host can support it.
-	 */
-	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_SCSI))
-		return -ENOTTY;
-
-	return scsi_cmd_blk_ioctl(bdev, mode, cmd,
-				  (void __user *)data);
-}
-#else
-static inline int virtblk_add_req_scsi(struct virtqueue *vq,
-		struct virtblk_req *vbr, struct scatterlist *data_sg,
-		bool have_data)
-{
-	return -EIO;
-}
-static inline void virtblk_scsi_request_done(struct request *req)
-{
-}
-#define virtblk_ioctl	NULL
-#endif /* CONFIG_VIRTIO_BLK_SCSI */
-
 static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
 		struct scatterlist *data_sg, bool have_data)
 {
@@ -216,13 +136,6 @@ static inline void virtblk_request_done(struct request *req)
 		      req->special_vec.bv_offset);
 	}
 
-	switch (req_op(req)) {
-	case REQ_OP_SCSI_IN:
-	case REQ_OP_SCSI_OUT:
-		virtblk_scsi_request_done(req);
-		break;
-	}
-
 	blk_mq_end_request(req, virtblk_result(vbr));
 }
 
@@ -299,10 +212,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		type = VIRTIO_BLK_T_WRITE_ZEROES;
 		unmap = !(req->cmd_flags & REQ_NOUNMAP);
 		break;
-	case REQ_OP_SCSI_IN:
-	case REQ_OP_SCSI_OUT:
-		type = VIRTIO_BLK_T_SCSI_CMD;
-		break;
 	case REQ_OP_DRV_IN:
 		type = VIRTIO_BLK_T_GET_ID;
 		break;
@@ -333,10 +242,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
-	if (blk_rq_is_scsi(req))
-		err = virtblk_add_req_scsi(vblk->vqs[qid].vq, vbr, vbr->sg, num);
-	else
-		err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
+	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
 		blk_mq_stop_hw_queue(hctx);
@@ -404,7 +310,6 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 }
 
 static const struct block_device_operations virtblk_fops = {
-	.ioctl  = virtblk_ioctl,
 	.owner  = THIS_MODULE,
 	.getgeo = virtblk_getgeo,
 };
@@ -683,9 +588,6 @@ static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	struct virtio_blk *vblk = set->driver_data;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
 
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	vbr->sreq.sense = vbr->sense;
-#endif
 	sg_init_table(vbr->sg, vblk->sg_elems);
 	return 0;
 }
@@ -698,23 +600,11 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
 					vblk->vdev, 0);
 }
 
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-static void virtblk_initialize_rq(struct request *req)
-{
-	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-
-	scsi_req_init(&vbr->sreq);
-}
-#endif
-
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.commit_rqs	= virtio_commit_rqs,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	.initialize_rq_fn = virtblk_initialize_rq,
-#endif
 	.map_queues	= virtblk_map_queues,
 };
 
@@ -991,9 +881,6 @@ static const struct virtio_device_id id_table[] = {
 static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	VIRTIO_BLK_F_SCSI,
-#endif
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 }
-- 
2.20.1
