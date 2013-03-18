From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 10/22] virtio_blk: remove nents member.
Date: Mon, 18 Mar 2013 20:04:41 +1030
Message-ID: <1363599293-23065-11-git-send-email-rusty@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It's simply a flag as to whether we have data now, so make it an
explicit function parameter rather than a member of struct
virtblk_req.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Reviewed-by: Asias He <asias@redhat.com>
---
 drivers/block/virtio_blk.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index cc88b29..6472395 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -62,7 +62,6 @@ struct virtblk_req
 	struct virtio_blk *vblk;
 	int flags;
 	u8 status;
-	int nents;
 	struct scatterlist sg[];
 };
 
@@ -104,7 +103,7 @@ static inline struct virtblk_req *virtblk_alloc_req(struct virtio_blk *vblk,
 static int __virtblk_add_req(struct virtqueue *vq,
 			     struct virtblk_req *vbr,
 			     struct scatterlist *data_sg,
-			     unsigned data_nents)
+			     bool have_data)
 {
 	struct scatterlist hdr, status, cmd, sense, inhdr, *sgs[6];
 	unsigned int num_out = 0, num_in = 0;
@@ -124,7 +123,7 @@ static int __virtblk_add_req(struct virtqueue *vq,
 		sgs[num_out++] = &cmd;
 	}
 
-	if (data_nents) {
+	if (have_data) {
 		if (vbr->out_hdr.type & VIRTIO_BLK_T_OUT)
 			sgs[num_out++] = data_sg;
 		else
@@ -144,7 +143,7 @@ static int __virtblk_add_req(struct virtqueue *vq,
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
 }
 
-static void virtblk_add_req(struct virtblk_req *vbr)
+static void virtblk_add_req(struct virtblk_req *vbr, bool have_data)
 {
 	struct virtio_blk *vblk = vbr->vblk;
 	DEFINE_WAIT(wait);
@@ -152,7 +151,7 @@ static void virtblk_add_req(struct virtblk_req *vbr)
 
 	spin_lock_irq(vblk->disk->queue->queue_lock);
 	while (unlikely((ret = __virtblk_add_req(vblk->vq, vbr, vbr->sg,
-						 vbr->nents)) < 0)) {
+						 have_data)) < 0)) {
 		prepare_to_wait_exclusive(&vblk->queue_wait, &wait,
 					  TASK_UNINTERRUPTIBLE);
 
@@ -173,30 +172,31 @@ static void virtblk_bio_send_flush(struct virtblk_req *vbr)
 	vbr->out_hdr.type = VIRTIO_BLK_T_FLUSH;
 	vbr->out_hdr.sector = 0;
 	vbr->out_hdr.ioprio = 0;
-	vbr->nents = 0;
 
-	virtblk_add_req(vbr);
+	virtblk_add_req(vbr, false);
 }
 
 static void virtblk_bio_send_data(struct virtblk_req *vbr)
 {
 	struct virtio_blk *vblk = vbr->vblk;
 	struct bio *bio = vbr->bio;
+	bool have_data;
 
 	vbr->flags &= ~VBLK_IS_FLUSH;
 	vbr->out_hdr.type = 0;
 	vbr->out_hdr.sector = bio->bi_sector;
 	vbr->out_hdr.ioprio = bio_prio(bio);
 
-	vbr->nents = blk_bio_map_sg(vblk->disk->queue, bio, vbr->sg);
-	if (vbr->nents) {
+	if (blk_bio_map_sg(vblk->disk->queue, bio, vbr->sg)) {
+		have_data = true;
 		if (bio->bi_rw & REQ_WRITE)
 			vbr->out_hdr.type |= VIRTIO_BLK_T_OUT;
 		else
 			vbr->out_hdr.type |= VIRTIO_BLK_T_IN;
-	}
+	} else
+		have_data = false;
 
-	virtblk_add_req(vbr);
+	virtblk_add_req(vbr, have_data);
 }
 
 static void virtblk_bio_send_data_work(struct work_struct *work)
-- 
1.7.10.4
