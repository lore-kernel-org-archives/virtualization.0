From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 7/7] virtio: move vring structure into struct virtqueue.
Date: Fri,  5 Apr 2013 14:07:05 +1030
Message-ID: <1365133025-5397-8-git-send-email-rusty@rustcorp.com.au>
References: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
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

Back in 2010 (7c5e9ed0c84e7d70d887878574590638d5572659) MST removed
the abstraction between virtio and the virtio ring, removing the various
ops pointers, and we haven't really missed it.

Now we hoist the struct vring out from the private struct
vring_virtqueue into the struct virtqueue: we've already demonstrated
that it's useful to be able to see the ring size, and the new virtio
pci layout wants to know the location of each part of the ring.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |  114 +++++++++++++++++-------------------------
 include/linux/virtio.h       |    8 ++-
 2 files changed, 54 insertions(+), 68 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ba58e29..7f9d4e9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -53,13 +53,9 @@
 #define END_USE(vq)
 #endif
 
-struct vring_virtqueue
-{
+struct vring_virtqueue {
 	struct virtqueue vq;
 
-	/* Actual memory layout for this queue */
-	struct vring vring;
-
 	/* Can we use weak barriers? */
 	bool weak_barriers;
 
@@ -171,12 +167,12 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 
 	/* Use a single buffer which doesn't continue */
 	head = vq->free_head;
-	vq->vring.desc[head].flags = VRING_DESC_F_INDIRECT;
-	vq->vring.desc[head].addr = virt_to_phys(desc);
-	vq->vring.desc[head].len = i * sizeof(struct vring_desc);
+	vq->vq.vring.desc[head].flags = VRING_DESC_F_INDIRECT;
+	vq->vq.vring.desc[head].addr = virt_to_phys(desc);
+	vq->vq.vring.desc[head].len = i * sizeof(struct vring_desc);
 
 	/* Update free pointer */
-	vq->free_head = vq->vring.desc[head].next;
+	vq->free_head = vq->vq.vring.desc[head].next;
 
 	return head;
 }
@@ -226,7 +222,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 			goto add_head;
 	}
 
-	BUG_ON(total_sg > vq->vring.num);
+	BUG_ON(total_sg > vq->vq.vring.num);
 	BUG_ON(total_sg == 0);
 
 	if (vq->vq.num_free < total_sg) {
@@ -247,24 +243,24 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	head = i = vq->free_head;
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
-			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
-			vq->vring.desc[i].addr = sg_phys(sg);
-			vq->vring.desc[i].len = sg->length;
+			vq->vq.vring.desc[i].flags = VRING_DESC_F_NEXT;
+			vq->vq.vring.desc[i].addr = sg_phys(sg);
+			vq->vq.vring.desc[i].len = sg->length;
 			prev = i;
-			i = vq->vring.desc[i].next;
+			i = vq->vq.vring.desc[i].next;
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
-			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			vq->vring.desc[i].addr = sg_phys(sg);
-			vq->vring.desc[i].len = sg->length;
+			vq->vq.vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
+			vq->vq.vring.desc[i].addr = sg_phys(sg);
+			vq->vq.vring.desc[i].len = sg->length;
 			prev = i;
-			i = vq->vring.desc[i].next;
+			i = vq->vq.vring.desc[i].next;
 		}
 	}
 	/* Last one doesn't continue. */
-	vq->vring.desc[prev].flags &= ~VRING_DESC_F_NEXT;
+	vq->vq.vring.desc[prev].flags &= ~VRING_DESC_F_NEXT;
 
 	/* Update free pointer */
 	vq->free_head = i;
@@ -275,13 +271,13 @@ add_head:
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
-	avail = (vq->vring.avail->idx & (vq->vring.num-1));
-	vq->vring.avail->ring[avail] = head;
+	avail = (vq->vq.vring.avail->idx & (vq->vq.vring.num-1));
+	vq->vq.vring.avail->ring[avail] = head;
 
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
 	virtio_wmb(vq->weak_barriers);
-	vq->vring.avail->idx++;
+	vq->vq.vring.avail->idx++;
 	vq->num_added++;
 
 	/* This is very unlikely, but theoretically possible.  Kick
@@ -431,8 +427,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 	 * event. */
 	virtio_mb(vq->weak_barriers);
 
-	old = vq->vring.avail->idx - vq->num_added;
-	new = vq->vring.avail->idx;
+	old = vq->vq.vring.avail->idx - vq->num_added;
+	new = vq->vq.vring.avail->idx;
 	vq->num_added = 0;
 
 #ifdef DEBUG
@@ -444,10 +440,10 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 #endif
 
 	if (vq->event) {
-		needs_kick = vring_need_event(vring_avail_event(&vq->vring),
+		needs_kick = vring_need_event(vring_avail_event(&vq->vq.vring),
 					      new, old);
 	} else {
-		needs_kick = !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
+		needs_kick = !(vq->vq.vring.used->flags&VRING_USED_F_NO_NOTIFY);
 	}
 	END_USE(vq);
 	return needs_kick;
@@ -497,15 +493,15 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 	i = head;
 
 	/* Free the indirect table */
-	if (vq->vring.desc[i].flags & VRING_DESC_F_INDIRECT)
-		kfree(phys_to_virt(vq->vring.desc[i].addr));
+	if (vq->vq.vring.desc[i].flags & VRING_DESC_F_INDIRECT)
+		kfree(phys_to_virt(vq->vq.vring.desc[i].addr));
 
-	while (vq->vring.desc[i].flags & VRING_DESC_F_NEXT) {
-		i = vq->vring.desc[i].next;
+	while (vq->vq.vring.desc[i].flags & VRING_DESC_F_NEXT) {
+		i = vq->vq.vring.desc[i].next;
 		vq->vq.num_free++;
 	}
 
-	vq->vring.desc[i].next = vq->free_head;
+	vq->vq.vring.desc[i].next = vq->free_head;
 	vq->free_head = head;
 	/* Plus final descriptor */
 	vq->vq.num_free++;
@@ -513,7 +509,7 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 
 static inline bool more_used(const struct vring_virtqueue *vq)
 {
-	return vq->last_used_idx != vq->vring.used->idx;
+	return vq->last_used_idx != vq->vq.vring.used->idx;
 }
 
 /**
@@ -555,11 +551,11 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	/* Only get used array entries after they have been exposed by host. */
 	virtio_rmb(vq->weak_barriers);
 
-	last_used = (vq->last_used_idx & (vq->vring.num - 1));
-	i = vq->vring.used->ring[last_used].id;
-	*len = vq->vring.used->ring[last_used].len;
+	last_used = (vq->last_used_idx & (vq->vq.vring.num - 1));
+	i = vq->vq.vring.used->ring[last_used].id;
+	*len = vq->vq.vring.used->ring[last_used].len;
 
-	if (unlikely(i >= vq->vring.num)) {
+	if (unlikely(i >= vq->vq.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
 		return NULL;
 	}
@@ -575,8 +571,8 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
-		vring_used_event(&vq->vring) = vq->last_used_idx;
+	if (!(vq->vq.vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
+		vring_used_event(&vq->vq.vring) = vq->last_used_idx;
 		virtio_mb(vq->weak_barriers);
 	}
 
@@ -602,7 +598,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+	vq->vq.vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
@@ -628,8 +624,8 @@ bool virtqueue_enable_cb(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always do both to keep code simple. */
-	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
-	vring_used_event(&vq->vring) = vq->last_used_idx;
+	vq->vq.vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
+	vring_used_event(&vq->vq.vring) = vq->last_used_idx;
 	virtio_mb(vq->weak_barriers);
 	if (unlikely(more_used(vq))) {
 		END_USE(vq);
@@ -666,12 +662,12 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always do both to keep code simple. */
-	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
+	vq->vq.vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
 	/* TODO: tune this threshold */
-	bufs = (u16)(vq->vring.avail->idx - vq->last_used_idx) * 3 / 4;
-	vring_used_event(&vq->vring) = vq->last_used_idx + bufs;
+	bufs = (u16)(vq->vq.vring.avail->idx - vq->last_used_idx) * 3 / 4;
+	vring_used_event(&vq->vq.vring) = vq->last_used_idx + bufs;
 	virtio_mb(vq->weak_barriers);
-	if (unlikely((u16)(vq->vring.used->idx - vq->last_used_idx) > bufs)) {
+	if (unlikely((u16)(vq->vq.vring.used->idx-vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
 	}
@@ -697,18 +693,18 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 
 	START_USE(vq);
 
-	for (i = 0; i < vq->vring.num; i++) {
+	for (i = 0; i < vq->vq.vring.num; i++) {
 		if (!vq->data[i])
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->data[i];
 		detach_buf(vq, i);
-		vq->vring.avail->idx--;
+		vq->vq.vring.avail->idx--;
 		END_USE(vq);
 		return buf;
 	}
 	/* That should have freed everything. */
-	BUG_ON(vq->vq.num_free != vq->vring.num);
+	BUG_ON(vq->vq.num_free != vq->vq.vring.num);
 
 	END_USE(vq);
 	return NULL;
@@ -758,7 +754,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	if (!vq)
 		return NULL;
 
-	vring_init(&vq->vring, num, pages, vring_align);
+	vring_init(&vq->vq.vring, num, pages, vring_align);
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
@@ -780,12 +776,12 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback)
-		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+		vq->vq.vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 	for (i = 0; i < num-1; i++) {
-		vq->vring.desc[i].next = i+1;
+		vq->vq.vring.desc[i].next = i+1;
 		vq->data[i] = NULL;
 	}
 	vq->data[i] = NULL;
@@ -820,20 +816,4 @@ void vring_transport_features(struct virtio_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vring_transport_features);
 
-/**
- * virtqueue_get_vring_size - return the size of the virtqueue's vring
- * @vq: the struct virtqueue containing the vring of interest.
- *
- * Returns the size of the vring.  This is mainly used for boasting to
- * userspace.  Unlike other operations, this need not be serialized.
- */
-unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
-{
-
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	return vq->vring.num;
-}
-EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
-
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a05f7c7..09883f5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
 #include <linux/vringh.h>
+#include <uapi/linux/virtio_ring.h>
 
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
@@ -19,6 +20,7 @@
  * @priv: a pointer for the virtqueue implementation to use.
  * @index: the zero-based ordinal number for this queue.
  * @num_free: number of elements we expect to be able to fit.
+ * @vring: the layout of the virtio ring.
  *
  * A note on @num_free: with indirect buffers, each buffer needs one
  * element in the queue, otherwise a buffer will need one element per
@@ -31,6 +33,7 @@ struct virtqueue {
 	struct virtio_device *vdev;
 	unsigned int index;
 	unsigned int num_free;
+	struct vring vring;
 	void *priv;
 };
 
@@ -74,7 +77,10 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
-unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
+static inline unsigned int virtqueue_get_vring_size(struct virtqueue *vq)
+{
+	return vq->vring.num;
+}
 
 /* FIXME: Obsolete accessor, but required for virtio_net merge. */
 static inline unsigned int virtqueue_get_queue_index(struct virtqueue *vq)
-- 
1.7.10.4
