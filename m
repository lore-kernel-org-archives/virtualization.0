From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH net-next v3 02/13] virtio_ring: add _split suffix for split
	ring functions
Date: Wed, 21 Nov 2018 18:03:19 +0800
Message-ID: <20181121100330.24846-3-tiwei.bie__38109.8257763826$1542794615$gmane$org@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add _split suffix for split ring specific functions. This
is a preparation for introducing the packed ring support.
There is no functional change.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 269 ++++++++++++++++++++++++++-----------------
 1 file changed, 164 insertions(+), 105 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 814b395007b2..29fab2fb39cb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -200,8 +200,8 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 			      cpu_addr, size, direction);
 }
 
-static void vring_unmap_one(const struct vring_virtqueue *vq,
-			    struct vring_desc *desc)
+static void vring_unmap_one_split(const struct vring_virtqueue *vq,
+				  struct vring_desc *desc)
 {
 	u16 flags;
 
@@ -234,8 +234,9 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
 	return dma_mapping_error(vring_dma_dev(vq), addr);
 }
 
-static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
-					 unsigned int total_sg, gfp_t gfp)
+static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
+					       unsigned int total_sg,
+					       gfp_t gfp)
 {
 	struct vring_desc *desc;
 	unsigned int i;
@@ -256,14 +257,14 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 	return desc;
 }
 
-static inline int virtqueue_add(struct virtqueue *_vq,
-				struct scatterlist *sgs[],
-				unsigned int total_sg,
-				unsigned int out_sgs,
-				unsigned int in_sgs,
-				void *data,
-				void *ctx,
-				gfp_t gfp)
+static inline int virtqueue_add_split(struct virtqueue *_vq,
+				      struct scatterlist *sgs[],
+				      unsigned int total_sg,
+				      unsigned int out_sgs,
+				      unsigned int in_sgs,
+				      void *data,
+				      void *ctx,
+				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
@@ -302,7 +303,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
 	if (vq->indirect && total_sg > 1 && vq->vq.num_free)
-		desc = alloc_indirect(_vq, total_sg, gfp);
+		desc = alloc_indirect_split(_vq, total_sg, gfp);
 	else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->vring.num && !vq->indirect);
@@ -423,7 +424,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_one(vq, &desc[i]);
+		vring_unmap_one_split(vq, &desc[i]);
 		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
 	}
 
@@ -434,6 +435,19 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	return -EIO;
 }
 
+static inline int virtqueue_add(struct virtqueue *_vq,
+				struct scatterlist *sgs[],
+				unsigned int total_sg,
+				unsigned int out_sgs,
+				unsigned int in_sgs,
+				void *data,
+				void *ctx,
+				gfp_t gfp)
+{
+	return virtqueue_add_split(_vq, sgs, total_sg,
+				   out_sgs, in_sgs, data, ctx, gfp);
+}
+
 /**
  * virtqueue_add_sgs - expose buffers to other end
  * @vq: the struct virtqueue we're talking about.
@@ -536,18 +550,7 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
-/**
- * virtqueue_kick_prepare - first half of split virtqueue_kick call.
- * @vq: the struct virtqueue
- *
- * Instead of virtqueue_kick(), you can do:
- *	if (virtqueue_kick_prepare(vq))
- *		virtqueue_notify(vq);
- *
- * This is sometimes useful because the virtqueue_kick_prepare() needs
- * to be serialized, but the actual virtqueue_notify() call does not.
- */
-bool virtqueue_kick_prepare(struct virtqueue *_vq)
+static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old;
@@ -579,6 +582,22 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 	END_USE(vq);
 	return needs_kick;
 }
+
+/**
+ * virtqueue_kick_prepare - first half of split virtqueue_kick call.
+ * @vq: the struct virtqueue
+ *
+ * Instead of virtqueue_kick(), you can do:
+ *	if (virtqueue_kick_prepare(vq))
+ *		virtqueue_notify(vq);
+ *
+ * This is sometimes useful because the virtqueue_kick_prepare() needs
+ * to be serialized, but the actual virtqueue_notify() call does not.
+ */
+bool virtqueue_kick_prepare(struct virtqueue *_vq)
+{
+	return virtqueue_kick_prepare_split(_vq);
+}
 EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
 
 /**
@@ -625,8 +644,8 @@ bool virtqueue_kick(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick);
 
-static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
-		       void **ctx)
+static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
+			     void **ctx)
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
@@ -638,12 +657,12 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->vring.desc[i].flags & nextflag) {
-		vring_unmap_one(vq, &vq->vring.desc[i]);
+		vring_unmap_one_split(vq, &vq->vring.desc[i]);
 		i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one(vq, &vq->vring.desc[i]);
+	vring_unmap_one_split(vq, &vq->vring.desc[i]);
 	vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
 	vq->free_head = head;
 
@@ -665,7 +684,7 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
 		for (j = 0; j < len / sizeof(struct vring_desc); j++)
-			vring_unmap_one(vq, &indir_desc[j]);
+			vring_unmap_one_split(vq, &indir_desc[j]);
 
 		kfree(indir_desc);
 		vq->desc_state[head].indir_desc = NULL;
@@ -674,29 +693,14 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
 	}
 }
 
-static inline bool more_used(const struct vring_virtqueue *vq)
+static inline bool more_used_split(const struct vring_virtqueue *vq)
 {
 	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, vq->vring.used->idx);
 }
 
-/**
- * virtqueue_get_buf - get the next used buffer
- * @vq: the struct virtqueue we're talking about.
- * @len: the length written into the buffer
- *
- * If the device wrote data into the buffer, @len will be set to the
- * amount written.  This means you don't need to clear the buffer
- * beforehand to ensure there's no data leakage in the case of short
- * writes.
- *
- * Caller must ensure we don't call this with other virtqueue
- * operations at the same time (except where noted).
- *
- * Returns NULL if there are no used buffers, or the "data" token
- * handed to virtqueue_add_*().
- */
-void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
-			    void **ctx)
+static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
+					 unsigned int *len,
+					 void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	void *ret;
@@ -710,7 +714,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 		return NULL;
 	}
 
-	if (!more_used(vq)) {
+	if (!more_used_split(vq)) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
@@ -732,9 +736,9 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 		return NULL;
 	}
 
-	/* detach_buf clears data, so grab it now. */
+	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->desc_state[i].data;
-	detach_buf(vq, i, ctx);
+	detach_buf_split(vq, i, ctx);
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -751,6 +755,28 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 	END_USE(vq);
 	return ret;
 }
+
+/**
+ * virtqueue_get_buf - get the next used buffer
+ * @vq: the struct virtqueue we're talking about.
+ * @len: the length written into the buffer
+ *
+ * If the device wrote data into the buffer, @len will be set to the
+ * amount written.  This means you don't need to clear the buffer
+ * beforehand to ensure there's no data leakage in the case of short
+ * writes.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * Returns NULL if there are no used buffers, or the "data" token
+ * handed to virtqueue_add_*().
+ */
+void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
+			    void **ctx)
+{
+	return virtqueue_get_buf_ctx_split(_vq, len, ctx);
+}
 EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
 void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
@@ -758,6 +784,18 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	return virtqueue_get_buf_ctx(_vq, len, NULL);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf);
+
+static void virtqueue_disable_cb_split(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
+		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+	}
+}
+
 /**
  * virtqueue_disable_cb - disable callbacks
  * @vq: the struct virtqueue we're talking about.
@@ -769,17 +807,32 @@ EXPORT_SYMBOL_GPL(virtqueue_get_buf);
  */
 void virtqueue_disable_cb(struct virtqueue *_vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
-		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
-			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
-	}
-
+	virtqueue_disable_cb_split(_vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
+static unsigned virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 last_used_idx;
+
+	START_USE(vq);
+
+	/* We optimistically turn back on interrupts, then check if there was
+	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always do both to keep code simple. */
+	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
+		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+	}
+	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
+	END_USE(vq);
+	return last_used_idx;
+}
+
 /**
  * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
  * @vq: the struct virtqueue we're talking about.
@@ -794,27 +847,18 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
  */
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 last_used_idx;
-
-	START_USE(vq);
-
-	/* We optimistically turn back on interrupts, then check if there was
-	 * more to do. */
-	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
-	 * either clear the flags bit or point the event index at the next
-	 * entry. Always do both to keep code simple. */
-	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
-		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
-			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
-	}
-	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
-	END_USE(vq);
-	return last_used_idx;
+	return virtqueue_enable_cb_prepare_split(_vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
+static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned last_used_idx)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
+			vq->vring.used->idx);
+}
+
 /**
  * virtqueue_poll - query pending used buffers
  * @vq: the struct virtqueue we're talking about.
@@ -829,7 +873,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	virtio_mb(vq->weak_barriers);
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev, vq->vring.used->idx);
+	return virtqueue_poll_split(_vq, last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
@@ -851,20 +895,7 @@ bool virtqueue_enable_cb(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
 
-/**
- * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
- * @vq: the struct virtqueue we're talking about.
- *
- * This re-enables callbacks but hints to the other side to delay
- * interrupts until most of the available buffers have been processed;
- * it returns "false" if there are many pending buffers in the queue,
- * to detect a possible race between the driver checking for more work,
- * and enabling callbacks.
- *
- * Caller must ensure we don't call this with other virtqueue
- * operations at the same time (except where noted).
- */
-bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
+static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 bufs;
@@ -896,17 +927,27 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	END_USE(vq);
 	return true;
 }
+
+/**
+ * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * This re-enables callbacks but hints to the other side to delay
+ * interrupts until most of the available buffers have been processed;
+ * it returns "false" if there are many pending buffers in the queue,
+ * to detect a possible race between the driver checking for more work,
+ * and enabling callbacks.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ */
+bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
+{
+	return virtqueue_enable_cb_delayed_split(_vq);
+}
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
-/**
- * virtqueue_detach_unused_buf - detach first unused buffer
- * @vq: the struct virtqueue we're talking about.
- *
- * Returns NULL or the "data" token handed to virtqueue_add_*().
- * This is not valid on an active queue; it is useful only for device
- * shutdown.
- */
-void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
@@ -917,9 +958,9 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 	for (i = 0; i < vq->vring.num; i++) {
 		if (!vq->desc_state[i].data)
 			continue;
-		/* detach_buf clears data, so grab it now. */
+		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->desc_state[i].data;
-		detach_buf(vq, i, NULL);
+		detach_buf_split(vq, i, NULL);
 		vq->avail_idx_shadow--;
 		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
 		END_USE(vq);
@@ -931,8 +972,26 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 	END_USE(vq);
 	return NULL;
 }
+
+/**
+ * virtqueue_detach_unused_buf - detach first unused buffer
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * Returns NULL or the "data" token handed to virtqueue_add_*().
+ * This is not valid on an active queue; it is useful only for device
+ * shutdown.
+ */
+void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
+{
+	return virtqueue_detach_unused_buf_split(_vq);
+}
 EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
+static inline bool more_used(const struct vring_virtqueue *vq)
+{
+	return more_used_split(vq);
+}
+
 irqreturn_t vring_interrupt(int irq, void *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.14.5
