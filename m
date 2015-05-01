From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC 2/4] virtio_ring: Add option for DMA mapped sgs in virtqueue_add
Date: Fri,  1 May 2015 15:01:45 +1000
Message-ID: <1430456507-26862-3-git-send-email-edgar.iglesias@gmail.com>
References: <1430456507-26862-1-git-send-email-edgar.iglesias@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1430456507-26862-1-git-send-email-edgar.iglesias@gmail.com>
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
Cc: edgar.iglesias@xilinx.com, linux@arm.linux.org.uk, mst@redhat.com, michal.simek@xilinx.com, j.wu@xilinx.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 drivers/virtio/virtio_ring.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 66d2cb9..233f3c6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -123,11 +123,13 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 static inline void vring_desc_set(struct virtio_device *vdev,
 				  struct vring_desc *desc,
 				  struct scatterlist *sg,
-				  unsigned int flags)
+				  unsigned int flags,
+				  bool dma)
 {
 	desc->flags = cpu_to_virtio16(vdev, flags);
-	desc->addr = cpu_to_virtio64(vdev, sg_phys(sg));
-	desc->len = cpu_to_virtio32(vdev, sg->length);
+	desc->addr = cpu_to_virtio64(vdev,
+				     dma ? sg_dma_address(sg) : sg_phys(sg));
+	desc->len = cpu_to_virtio32(vdev, dma ? sg_dma_len(sg) : sg->length);
 }
 
 static inline int virtqueue_add(struct virtqueue *_vq,
@@ -136,7 +138,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 				unsigned int out_sgs,
 				unsigned int in_sgs,
 				void *data,
-				gfp_t gfp)
+				gfp_t gfp,
+				bool dma)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
@@ -174,7 +177,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
-	if (vq->indirect && total_sg > 1 && vq->vq.num_free)
+	if (!dma && vq->indirect && total_sg > 1 && vq->vq.num_free)
 		desc = alloc_indirect(_vq, total_sg, gfp);
 	else
 		desc = NULL;
@@ -216,7 +219,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			vring_desc_set(_vq->vdev, desc + i, sg,
-				       VRING_DESC_F_NEXT);
+				       VRING_DESC_F_NEXT, dma);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		}
@@ -224,7 +227,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			vring_desc_set(_vq->vdev, desc + i, sg,
-				       VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
+				       VRING_DESC_F_NEXT | VRING_DESC_F_WRITE,
+				       dma);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		}
@@ -292,7 +296,8 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 		for (sg = sgs[i]; sg; sg = sg_next(sg))
 			total_sg++;
 	}
-	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs, data, gfp);
+	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs, data, gfp,
+			     false);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
@@ -314,7 +319,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, gfp, false);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -336,7 +341,7 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, gfp, false);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
-- 
1.9.1
