From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 2/2] virtio+vhost: event idx feature
Date: Fri, 20 May 2011 02:24:19 +0300
Message-ID: <84d319ab137613d7a4faf7836a01e3642338b5f5.1305846930.git.mst__11386.5917003297$1305848295$gmane$org@redhat.com>
References: <cover.1305846929.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1305846929.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Add support for used_event feature, and utilize it to
reduce the number of interrupts and exits for the guest.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vhost_net.c |    6 ++++
 hw/virtio.c    |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/virtio.h    |    9 +++++-
 3 files changed, 97 insertions(+), 10 deletions(-)

diff --git a/hw/vhost_net.c b/hw/vhost_net.c
index 7e94f61..41841d9 100644
--- a/hw/vhost_net.c
+++ b/hw/vhost_net.c
@@ -50,6 +50,9 @@ uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
     if (!(net->dev.features & (1 << VIRTIO_RING_F_INDIRECT_DESC))) {
         features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
     }
+    if (!(net->dev.features & (1 << VIRTIO_RING_F_EVENT_IDX))) {
+        features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
+    }
     if (!(net->dev.features & (1 << VIRTIO_NET_F_MRG_RXBUF))) {
         features &= ~(1 << VIRTIO_NET_F_MRG_RXBUF);
     }
@@ -65,6 +68,9 @@ void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
     if (features & (1 << VIRTIO_RING_F_INDIRECT_DESC)) {
         net->dev.acked_features |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
     }
+    if (features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+        net->dev.acked_features |= (1 << VIRTIO_RING_F_EVENT_IDX);
+    }
     if (features & (1 << VIRTIO_NET_F_MRG_RXBUF)) {
         net->dev.acked_features |= (1 << VIRTIO_NET_F_MRG_RXBUF);
     }
diff --git a/hw/virtio.c b/hw/virtio.c
index b9acbd4..d51ac93 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -72,7 +72,17 @@ struct VirtQueue
     VRing vring;
     target_phys_addr_t pa;
     uint16_t last_avail_idx;
+    /* Last used index value we have signalled on */
+    uint16_t signalled_used;
+
+    /* Last used index value we have signalled on */
+    bool signalled_used_valid;
+
+    /* Notification enabled? */
+    bool notification;
+
     int inuse;
+
     uint16_t vector;
     void (*handle_output)(VirtIODevice *vdev, VirtQueue *vq);
     VirtIODevice *vdev;
@@ -141,6 +151,11 @@ static inline uint16_t vring_avail_ring(VirtQueue *vq, int i)
     return lduw_phys(pa);
 }
 
+static inline uint16_t vring_used_event(VirtQueue *vq)
+{
+    return vring_avail_ring(vq, vq->vring.num);
+}
+
 static inline void vring_used_ring_id(VirtQueue *vq, int i, uint32_t val)
 {
     target_phys_addr_t pa;
@@ -162,11 +177,11 @@ static uint16_t vring_used_idx(VirtQueue *vq)
     return lduw_phys(pa);
 }
 
-static inline void vring_used_idx_increment(VirtQueue *vq, uint16_t val)
+static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
 {
     target_phys_addr_t pa;
     pa = vq->vring.used + offsetof(VRingUsed, idx);
-    stw_phys(pa, vring_used_idx(vq) + val);
+    stw_phys(pa, val);
 }
 
 static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
@@ -183,12 +198,26 @@ static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
     stw_phys(pa, lduw_phys(pa) & ~mask);
 }
 
+static inline void vring_avail_event(VirtQueue *vq, uint16_t val)
+{
+    target_phys_addr_t pa;
+    if (!vq->notification) {
+        return;
+    }
+    pa = vq->vring.used + offsetof(VRingUsed, ring[vq->vring.num]);
+    stw_phys(pa, val);
+}
+
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
-    if (enable)
+    vq->notification = enable;
+    if (vq->vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+        vring_avail_event(vq, vring_avail_idx(vq));
+    } else if (enable) {
         vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
-    else
+    } else {
         vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
+    }
 }
 
 int virtio_queue_ready(VirtQueue *vq)
@@ -234,11 +263,16 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
 
 void virtqueue_flush(VirtQueue *vq, unsigned int count)
 {
+    uint16_t old, new;
     /* Make sure buffer is written before we update index. */
     wmb();
     trace_virtqueue_flush(vq, count);
-    vring_used_idx_increment(vq, count);
+    old = vring_used_idx(vq);
+    new = old + count;
+    vring_used_idx_set(vq, new);
     vq->inuse -= count;
+    if (unlikely((int16_t)(new - vq->signalled_used) < (uint16_t)(new - old)))
+        vq->signalled_used_valid = false;
 }
 
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
@@ -395,6 +429,9 @@ int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem)
     max = vq->vring.num;
 
     i = head = virtqueue_get_head(vq, vq->last_avail_idx++);
+    if (vq->vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+        vring_avail_event(vq, vring_avail_idx(vq));
+    }
 
     if (vring_desc_flags(desc_pa, i) & VRING_DESC_F_INDIRECT) {
         if (vring_desc_len(desc_pa, i) % sizeof(VRingDesc)) {
@@ -478,6 +515,9 @@ void virtio_reset(void *opaque)
         vdev->vq[i].last_avail_idx = 0;
         vdev->vq[i].pa = 0;
         vdev->vq[i].vector = VIRTIO_NO_VECTOR;
+        vdev->vq[i].signalled_used = 0;
+        vdev->vq[i].signalled_used_valid = false;
+        vdev->vq[i].notification = true;
     }
 }
 
@@ -629,13 +669,45 @@ void virtio_irq(VirtQueue *vq)
     virtio_notify_vector(vq->vdev, vq->vector);
 }
 
-void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
+/* Assuming a given event_idx value from the other size, if
+ * we have just incremented index from old to new_idx,
+ * should we trigger an event? */
+static inline int vring_need_event(uint16_t event, uint16_t new, uint16_t old)
+{
+	/* Note: Xen has similar logic for notification hold-off
+	 * in include/xen/interface/io/ring.h with req_event and req_prod
+	 * corresponding to event_idx + 1 and new respectively.
+	 * Note also that req_event and req_prod in Xen start at 1,
+	 * event indexes in virtio start at 0. */
+	return (uint16_t)(new - event - 1) < (uint16_t)(new - old);
+}
+
+static bool vring_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
+    uint16_t old, new;
+    bool v;
     /* Always notify when queue is empty (when feature acknowledge) */
-    if ((vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT) &&
-        (!(vdev->guest_features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY)) ||
-         (vq->inuse || vring_avail_idx(vq) != vq->last_avail_idx)))
+    if (((vdev->guest_features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY)) &&
+         !vq->inuse && vring_avail_idx(vq) == vq->last_avail_idx)) {
+        return true;
+    }
+
+    if (!(vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX))) {
+        return !(vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT);
+    }
+
+    v = vq->signalled_used_valid;
+    vq->signalled_used_valid = true;
+    old = vq->signalled_used;
+    new = vq->signalled_used = vring_used_idx(vq);
+    return !v || vring_need_event(vring_used_event(vq), new, old);
+}
+
+void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
+{
+    if (!vring_notify(vdev, vq)) {
         return;
+    }
 
     trace_virtio_notify(vdev, vq);
     vdev->isr |= 0x01;
@@ -732,6 +804,8 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f)
         vdev->vq[i].vring.num = qemu_get_be32(f);
         vdev->vq[i].pa = qemu_get_be64(f);
         qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
+        vdev->vq[i].signalled_used_valid = false;
+        vdev->vq[i].notification = true;
 
         if (vdev->vq[i].pa) {
             uint16_t nheads;
diff --git a/hw/virtio.h b/hw/virtio.h
index 9517b97..3438a91 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -46,6 +46,11 @@
 #define VIRTIO_F_NOTIFY_ON_EMPTY        24
 /* We support indirect buffer descriptors */
 #define VIRTIO_RING_F_INDIRECT_DESC     28
+/* The Guest publishes the used index for which it expects an interrupt
+ * at the end of the avail ring. Host should ignore the avail->flags field. */
+/* The Host publishes the avail index for which it expects a kick
+ * at the end of the used ring. Guest should ignore the used->flags field. */
+#define VIRTIO_RING_F_EVENT_IDX		29
 /* A guest should never accept this.  It implies negotiation is broken. */
 #define VIRTIO_F_BAD_FEATURE		30
 
@@ -213,7 +218,9 @@ void virtio_serial_exit(VirtIODevice *vdev);
 
 #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
 	DEFINE_PROP_BIT64("indirect_desc", _state, _field, \
-			  VIRTIO_RING_F_INDIRECT_DESC, true)
+			  VIRTIO_RING_F_INDIRECT_DESC, true), \
+	DEFINE_PROP_BIT64("event_idx", _state, _field, \
+			  VIRTIO_RING_F_EVENT_IDX, true)
 
 target_phys_addr_t virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 target_phys_addr_t virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
-- 
1.7.5.53.gc233e
