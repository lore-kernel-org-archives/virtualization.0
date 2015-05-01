From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC 1/4] virtio_ring: Break out vring descriptor setup code
Date: Fri,  1 May 2015 15:01:44 +1000
Message-ID: <1430456507-26862-2-git-send-email-edgar.iglesias@gmail.com>
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

Break out descriptor setup into a separate inline function.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 drivers/virtio/virtio_ring.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 096b857..66d2cb9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -120,6 +120,16 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 	return desc;
 }
 
+static inline void vring_desc_set(struct virtio_device *vdev,
+				  struct vring_desc *desc,
+				  struct scatterlist *sg,
+				  unsigned int flags)
+{
+	desc->flags = cpu_to_virtio16(vdev, flags);
+	desc->addr = cpu_to_virtio64(vdev, sg_phys(sg));
+	desc->len = cpu_to_virtio32(vdev, sg->length);
+}
+
 static inline int virtqueue_add(struct virtqueue *_vq,
 				struct scatterlist *sgs[],
 				unsigned int total_sg,
@@ -205,18 +215,16 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
-			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
+			vring_desc_set(_vq->vdev, desc + i, sg,
+				       VRING_DESC_F_NEXT);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
-			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
+			vring_desc_set(_vq->vdev, desc + i, sg,
+				       VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		}
-- 
1.9.1
