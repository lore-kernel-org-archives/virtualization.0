From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/2] virtio: block: dynamic maximum segments
Date: Mon, 17 Nov 2008 17:34:54 +1030
Message-ID: <200811171734.55356.rusty@rustcorp.com.au>
References: <200811141215.33950.rusty@rustcorp.com.au>
	<200811171722.43792.rusty@rustcorp.com.au>
	<200811171724.15682.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200811171724.15682.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Enhance the driver to handle whatever maximum segment number the host
tells us to handle.  Do to this, we need to allocate the scatterlist
dynamically.

We set max_phys_segments and max_hw_segments to the same value (1 if
the host doesn't tell us, since that's safest and all known hosts do
tell us).

Note that kmalloc'ing the structure for large sg_elems might be
problematic: the fix for this is sg_table, but that requires more
work.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 177219c4da07 drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c	Mon Nov 17 17:16:35 2008 +1030
+++ b/drivers/block/virtio_blk.c	Mon Nov 17 17:16:41 2008 +1030
@@ -6,7 +6,6 @@
 #include <linux/virtio_blk.h>
 #include <linux/scatterlist.h>
 
-#define VIRTIO_MAX_SG	(3+MAX_PHYS_SEGMENTS)
 #define PART_BITS 4
 
 static int major, index;
@@ -26,8 +25,11 @@
 
 	mempool_t *pool;
 
+	/* What host tells us, plus 2 for header & tailer. */
+	unsigned int sg_elems;
+
 	/* Scatterlist: can be too big for stack. */
-	struct scatterlist sg[VIRTIO_MAX_SG];
+	struct scatterlist sg[/*sg_elems*/];
 };
 
 struct virtblk_req
@@ -97,8 +99,6 @@
 	if (blk_barrier_rq(vbr->req))
 		vbr->out_hdr.type |= VIRTIO_BLK_T_BARRIER;
 
-	/* This init could be done at vblk creation time */
-	sg_init_table(vblk->sg, VIRTIO_MAX_SG);
 	sg_set_buf(&vblk->sg[0], &vbr->out_hdr, sizeof(vbr->out_hdr));
 	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
 	sg_set_buf(&vblk->sg[num+1], &vbr->status, sizeof(vbr->status));
@@ -130,7 +130,7 @@
 
 	while ((req = elv_next_request(q)) != NULL) {
 		vblk = req->rq_disk->private_data;
-		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
+		BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
 
 		/* If this request fails, stop queue and wait for something to
 		   finish to restart it. */
@@ -196,12 +196,22 @@
 	int err;
 	u64 cap;
 	u32 v;
-	u32 blk_size;
+	u32 blk_size, sg_elems;
 
 	if (index_to_minor(index) >= 1 << MINORBITS)
 		return -ENOSPC;
 
-	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
+	/* We need to know how many segments before we allocate. */
+	err = virtio_config_val(vdev, VIRTIO_BLK_F_SEG_MAX,
+				offsetof(struct virtio_blk_config, seg_max),
+				&sg_elems);
+	if (err)
+		sg_elems = 1;
+
+	/* We need an extra sg elements at head and tail. */
+	sg_elems += 2;
+	vdev->priv = vblk = kmalloc(sizeof(*vblk) +
+				    sizeof(vblk->sg[0]) * sg_elems, GFP_KERNEL);
 	if (!vblk) {
 		err = -ENOMEM;
 		goto out;
@@ -210,6 +220,8 @@
 	INIT_LIST_HEAD(&vblk->reqs);
 	spin_lock_init(&vblk->lock);
 	vblk->vdev = vdev;
+	vblk->sg_elems = sg_elems;
+	sg_init_table(vblk->sg, vblk->sg_elems);
 
 	/* We expect one virtqueue, for output. */
 	vblk->vq = vdev->config->find_vq(vdev, 0, blk_done);
@@ -277,6 +289,10 @@
 	}
 	set_capacity(vblk->disk, cap);
 
+	/* We can handle whatever the host told us to handle. */
+	blk_queue_max_phys_segments(vblk->disk->queue, vblk->sg_elems-2);
+	blk_queue_max_hw_segments(vblk->disk->queue, vblk->sg_elems-2);
+
 	/* No real sector limit. */
 	blk_queue_max_sectors(vblk->disk->queue, -1U);
 
@@ -289,12 +305,6 @@
 		blk_queue_max_segment_size(vblk->disk->queue, v);
 	else
 		blk_queue_max_segment_size(vblk->disk->queue, -1UL);
-
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_SEG_MAX,
-				offsetof(struct virtio_blk_config, seg_max),
-				&v);
-	if (!err)
-		blk_queue_max_hw_segments(vblk->disk->queue, v);
 
 	/* Host can optionally specify the block size of the device */
 	err = virtio_config_val(vdev, VIRTIO_BLK_F_BLK_SIZE,
