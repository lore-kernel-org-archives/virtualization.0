From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 03/14] virtio_ring: support event idx feature
Date: Fri, 20 May 2011 02:10:44 +0300
Message-ID: <960f3e3b260844011b004c81dbda0661c977b79a.1305846412.git.mst__39837.1970550672$1305846897$gmane$org@redhat.com>
References: <cover.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1305846412.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Support for the new event idx feature:
1. When enabling interrupts, publish the current avail index
   value to the host to get interrupts on the next update.
2. Use the new avail_event feature to reduce the number
   of exits from the guest.

Simple test with the simulator:

[virtio]# time ./virtio_test
spurious wakeus: 0x7

real    0m0.169s
user    0m0.140s
sys     0m0.019s
[virtio]# time ./virtio_test --no-event-idx
spurious wakeus: 0x11

real    0m0.649s
user    0m0.295s
sys     0m0.335s

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cc2f73e..1d0f9be 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -82,6 +82,9 @@ struct vring_virtqueue
 	/* Host supports indirect buffers */
 	bool indirect;
 
+	/* Host publishes avail event idx */
+	bool event;
+
 	/* Number of free buffers */
 	unsigned int num_free;
 	/* Head of free buffer list. */
@@ -237,18 +240,22 @@ EXPORT_SYMBOL_GPL(virtqueue_add_buf_gfp);
 void virtqueue_kick(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 new, old;
 	START_USE(vq);
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
 	virtio_wmb();
 
-	vq->vring.avail->idx += vq->num_added;
+	old = vq->vring.avail->idx;
+	new = vq->vring.avail->idx = old + vq->num_added;
 	vq->num_added = 0;
 
 	/* Need to update avail index before checking if we should notify */
 	virtio_mb();
 
-	if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
+	if (vq->event ?
+	    vring_need_event(vring_avail_event(&vq->vring), new, old) :
+	    !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
 		/* Prod other side to tell it about changes. */
 		vq->notify(&vq->vq);
 
@@ -324,6 +331,14 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	ret = vq->data[i];
 	detach_buf(vq, i);
 	vq->last_used_idx++;
+	/* If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call. */
+	if (!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
+		vring_used_event(&vq->vring) = vq->last_used_idx;
+		virtio_mb();
+	}
+
 	END_USE(vq);
 	return ret;
 }
@@ -345,7 +360,11 @@ bool virtqueue_enable_cb(struct virtqueue *_vq)
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always do both to keep code simple. */
 	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
+	vring_used_event(&vq->vring) = vq->last_used_idx;
 	virtio_mb();
 	if (unlikely(more_used(vq))) {
 		END_USE(vq);
@@ -437,6 +456,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 #endif
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC);
+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback)
@@ -471,6 +491,8 @@ void vring_transport_features(struct virtio_device *vdev)
 		switch (i) {
 		case VIRTIO_RING_F_INDIRECT_DESC:
 			break;
+		case VIRTIO_RING_F_EVENT_IDX:
+			break;
 		default:
 			/* We don't understand this bit. */
 			clear_bit(i, vdev->features);
-- 
1.7.5.53.gc233e
