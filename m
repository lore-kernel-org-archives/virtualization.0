From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/5] virtio: move queue_index and num_free fields into core
	struct virtqueue.
Date: Wed, 17 Oct 2012 00:00:48 +1030
Message-ID: <1350394252-23934-1-git-send-email-rusty@rustcorp.com.au>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

They're generic concepts, so hoist them.  This also avoids accessor
functions.

This goes even further than Jason Wang's 17bb6d4088 patch
("virtio-ring: move queue_index to vring_virtqueue") which moved the
queue_index from the specific transport.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_mmio.c |    4 ++--
 drivers/virtio/virtio_pci.c  |    6 ++----
 drivers/virtio/virtio_ring.c |   34 +++++++++++-----------------------
 include/linux/virtio.h       |    6 ++++--
 4 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 6b1b7e1..5a0e1d3 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -225,7 +225,7 @@ static void vm_notify(struct virtqueue *vq)
 
 	/* We write the queue's selector into the notification register to
 	 * signal the other end */
-	writel(virtqueue_get_queue_index(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
 }
 
 /* Notify all virtqueues on an interrupt. */
@@ -266,7 +266,7 @@ static void vm_del_vq(struct virtqueue *vq)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
 	struct virtio_mmio_vq_info *info = vq->priv;
 	unsigned long flags, size;
-	unsigned int index = virtqueue_get_queue_index(vq);
+	unsigned int index = vq->index;
 
 	spin_lock_irqsave(&vm_dev->lock, flags);
 	list_del(&info->node);
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index b59237c..e3ecc94 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -203,8 +203,7 @@ static void vp_notify(struct virtqueue *vq)
 
 	/* we write the queue's selector into the notification register to
 	 * signal the other end */
-	iowrite16(virtqueue_get_queue_index(vq),
-		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
+	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
 }
 
 /* Handle a configuration change: Tell driver if it wants to know. */
@@ -479,8 +478,7 @@ static void vp_del_vq(struct virtqueue *vq)
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
-	iowrite16(virtqueue_get_queue_index(vq),
-		vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
 	if (vp_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e639584..335dcec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -93,8 +93,6 @@ struct vring_virtqueue
 	/* Host publishes avail event idx */
 	bool event;
 
-	/* Number of free buffers */
-	unsigned int num_free;
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -106,9 +104,6 @@ struct vring_virtqueue
 	/* How to notify other side. FIXME: commonalize hcalls! */
 	void (*notify)(struct virtqueue *vq);
 
-	/* Index of the queue */
-	int queue_index;
-
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
 	unsigned int in_use;
@@ -160,7 +155,7 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	desc[i-1].next = 0;
 
 	/* We're about to use a buffer */
-	vq->num_free--;
+	vq->vq.num_free--;
 
 	/* Use a single buffer which doesn't continue */
 	head = vq->free_head;
@@ -174,13 +169,6 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	return head;
 }
 
-int virtqueue_get_queue_index(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	return vq->queue_index;
-}
-EXPORT_SYMBOL_GPL(virtqueue_get_queue_index);
-
 /**
  * virtqueue_add_buf - expose buffer to other end
  * @vq: the struct virtqueue we're talking about.
@@ -228,7 +216,7 @@ int virtqueue_add_buf(struct virtqueue *_vq,
 
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
-	if (vq->indirect && (out + in) > 1 && vq->num_free) {
+	if (vq->indirect && (out + in) > 1 && vq->vq.num_free) {
 		head = vring_add_indirect(vq, sg, out, in, gfp);
 		if (likely(head >= 0))
 			goto add_head;
@@ -237,9 +225,9 @@ int virtqueue_add_buf(struct virtqueue *_vq,
 	BUG_ON(out + in > vq->vring.num);
 	BUG_ON(out + in == 0);
 
-	if (vq->num_free < out + in) {
+	if (vq->vq.num_free < out + in) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
-			 out + in, vq->num_free);
+			 out + in, vq->vq.num_free);
 		/* FIXME: for historical reasons, we force a notify here if
 		 * there are outgoing parts to the buffer.  Presumably the
 		 * host should service the ring ASAP. */
@@ -250,7 +238,7 @@ int virtqueue_add_buf(struct virtqueue *_vq,
 	}
 
 	/* We're about to use some buffers from the free list. */
-	vq->num_free -= out + in;
+	vq->vq.num_free -= out + in;
 
 	head = vq->free_head;
 	for (i = vq->free_head; out; i = vq->vring.desc[i].next, out--) {
@@ -296,7 +284,7 @@ add_head:
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
 
-	return vq->num_free;
+	return vq->vq.num_free;
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_buf);
 
@@ -393,13 +381,13 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 
 	while (vq->vring.desc[i].flags & VRING_DESC_F_NEXT) {
 		i = vq->vring.desc[i].next;
-		vq->num_free++;
+		vq->vq.num_free++;
 	}
 
 	vq->vring.desc[i].next = vq->free_head;
 	vq->free_head = head;
 	/* Plus final descriptor */
-	vq->num_free++;
+	vq->vq.num_free++;
 }
 
 static inline bool more_used(const struct vring_virtqueue *vq)
@@ -599,7 +587,7 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 		return buf;
 	}
 	/* That should have freed everything. */
-	BUG_ON(vq->num_free != vq->vring.num);
+	BUG_ON(vq->vq.num_free != vq->vring.num);
 
 	END_USE(vq);
 	return NULL;
@@ -653,12 +641,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
+	vq->vq.num_free = num;
+	vq->vq.index = index;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
 	vq->num_added = 0;
-	vq->queue_index = index;
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 #ifdef DEBUG
 	vq->in_use = false;
@@ -673,7 +662,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 
 	/* Put everything in free lists. */
-	vq->num_free = num;
 	vq->free_head = 0;
 	for (i = 0; i < num-1; i++) {
 		vq->vring.desc[i].next = i+1;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 533b115..ed4c437 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -16,12 +16,16 @@
  * @name: the name of this virtqueue (mainly for debugging)
  * @vdev: the virtio device this queue was created for.
  * @priv: a pointer for the virtqueue implementation to use.
+ * @index: the zero-based ordinal number for this queue.
+ * @num_free: number of buffers we expect to be able to fit.
  */
 struct virtqueue {
 	struct list_head list;
 	void (*callback)(struct virtqueue *vq);
 	const char *name;
 	struct virtio_device *vdev;
+	unsigned int index;
+	unsigned int num_free;
 	void *priv;
 };
 
@@ -50,8 +54,6 @@ void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
 unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
 
-int virtqueue_get_queue_index(struct virtqueue *vq);
-
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
1.7.9.5
