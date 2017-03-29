From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/6] virtio: allow extra context per descriptor
Date: Wed, 29 Mar 2017 23:48:53 +0300
Message-ID: <1490820507-8005-4-git-send-email-mst@redhat.com>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1490820507-8005-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Allow extra context per descriptor. To avoid slow down for data path,
this disables use of indirect descriptors for this vq.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++++++++++--------
 include/linux/virtio.h       |  9 ++++++
 2 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b23b5fa..5e1b548 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -263,6 +263,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 				unsigned int out_sgs,
 				unsigned int in_sgs,
 				void *data,
+				void *ctx,
 				gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -275,6 +276,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	START_USE(vq);
 
 	BUG_ON(data == NULL);
+	BUG_ON(ctx && vq->indirect);
 
 	if (unlikely(vq->broken)) {
 		END_USE(vq);
@@ -389,6 +391,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	vq->desc_state[head].data = data;
 	if (indirect)
 		vq->desc_state[head].indir_desc = desc;
+	if (ctx)
+		vq->desc_state[head].indir_desc = ctx;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
@@ -461,7 +465,8 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 		for (sg = sgs[i]; sg; sg = sg_next(sg))
 			total_sg++;
 	}
-	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs, data, gfp);
+	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
+			     data, NULL, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
@@ -483,7 +488,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -505,11 +510,35 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
 /**
+ * virtqueue_add_inbuf_ctx - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @ctx: extra context for the token
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
+			struct scatterlist *sg, unsigned int num,
+			void *data,
+			void *ctx,
+			gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
+
+/**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
  * @vq: the struct virtqueue
  *
@@ -598,7 +627,8 @@ bool virtqueue_kick(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick);
 
-static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
+static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
+		       void **ctx)
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
@@ -622,10 +652,15 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 	/* Plus final descriptor */
 	vq->vq.num_free++;
 
-	/* Free the indirect table, if any, now that it's unmapped. */
-	if (vq->desc_state[head].indir_desc) {
+	if (vq->indirect) {
 		struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
-		u32 len = virtio32_to_cpu(vq->vq.vdev, vq->vring.desc[head].len);
+		u32 len;
+
+		/* Free the indirect table, if any, now that it's unmapped. */
+		if (!indir_desc)
+			return;
+
+		len = virtio32_to_cpu(vq->vq.vdev, vq->vring.desc[head].len);
 
 		BUG_ON(!(vq->vring.desc[head].flags &
 			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
@@ -634,8 +669,10 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 		for (j = 0; j < len / sizeof(struct vring_desc); j++)
 			vring_unmap_one(vq, &indir_desc[j]);
 
-		kfree(vq->desc_state[head].indir_desc);
+		kfree(indir_desc);
 		vq->desc_state[head].indir_desc = NULL;
+	} else if (ctx) {
+		*ctx = vq->desc_state[head].indir_desc;
 	}
 }
 
@@ -660,7 +697,8 @@ static inline bool more_used(const struct vring_virtqueue *vq)
  * Returns NULL if there are no used buffers, or the "data" token
  * handed to virtqueue_add_*().
  */
-void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
+void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
+			    void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	void *ret;
@@ -698,7 +736,7 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 
 	/* detach_buf clears data, so grab it now. */
 	ret = vq->desc_state[i].data;
-	detach_buf(vq, i);
+	detach_buf(vq, i, ctx);
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -715,8 +753,13 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	END_USE(vq);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(virtqueue_get_buf);
+EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
+void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
+{
+	return virtqueue_get_buf_ctx(_vq, len, NULL);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_buf);
 /**
  * virtqueue_disable_cb - disable callbacks
  * @vq: the struct virtqueue we're talking about.
@@ -878,7 +921,7 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->desc_state[i].data;
-		detach_buf(vq, i);
+		detach_buf(vq, i, NULL);
 		vq->avail_idx_shadow--;
 		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
 		END_USE(vq);
@@ -951,7 +994,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->last_add_time_valid = false;
 #endif
 
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC);
+	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	/* No callback?  Tell other side not to bother us. */
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 04b0d3f9..193fea9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -44,6 +44,12 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp);
 
+int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
+			    struct scatterlist sg[], unsigned int num,
+			    void *data,
+			    void *ctx,
+			    gfp_t gfp);
+
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
 		      unsigned int out_sgs,
@@ -59,6 +65,9 @@ bool virtqueue_notify(struct virtqueue *vq);
 
 void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 
+void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
+			    void **ctx);
+
 void virtqueue_disable_cb(struct virtqueue *vq);
 
 bool virtqueue_enable_cb(struct virtqueue *vq);
-- 
MST
