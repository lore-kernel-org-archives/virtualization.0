From: Ladi Prosek <lprosek@redhat.com>
Subject: [PATCH v2] virtio_ring: Make interrupt suppression spec compliant
Date: Wed, 31 Aug 2016 14:00:04 +0200
Message-ID: <1472644804-20660-1-git-send-email-lprosek__24598.5628491782$1473186390$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: lprosek@redhat.com, stable@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

According to the spec, if the VIRTIO_RING_F_EVENT_IDX feature bit is
negotiated the driver MUST set flags to 0. Not dirtying the available
ring in virtqueue_disable_cb also has a minor positive performance
impact, improving L1 dcache load missed by ~0.5% in vring_bench.

Writes to the used event field (vring_used_event) are still unconditional.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: <stable@vger.kernel.org> # f277ec4 virtio_ring: shadow available
Cc: <stable@vger.kernel.org>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---

v1->v2:
* fixed coding style
* perf measurement results added to commit message
* patch sent to virtualization@lists.linux-foundation.org (was kvm@vger.kernel.org)


 drivers/virtio/virtio_ring.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e383ecd..926ecb7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -732,7 +732,8 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 
 	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
 	}
 
 }
@@ -764,7 +765,8 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	 * entry. Always do both to keep code simple. */
 	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
 		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
-		vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
 	}
 	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
 	END_USE(vq);
@@ -832,10 +834,11 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	 * more to do. */
 	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
-	 * entry. Always do both to keep code simple. */
+	 * entry. Always update the event index to keep code simple. */
 	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
 		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
-		vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
 	}
 	/* TODO: tune this threshold */
 	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
@@ -953,7 +956,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		vq->vring.avail->flags = cpu_to_virtio16(vdev, vq->avail_flags_shadow);
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(vdev, vq->avail_flags_shadow);
 	}
 
 	/* Put everything in free lists. */
-- 
2.5.5
