Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C11E49A
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92E8280C50
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92E8280C50
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AmTq3XO7AMkF
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 08:04:02 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6BDA812DD
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6BDA812DD
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vy.5bgc_1701936234;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vy.5bgc_1701936234)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 16:03:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/5] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Thu,  7 Dec 2023 16:03:49 +0800
Message-Id: <20231207080353.6575-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com>
References: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: b3688db07ee6
Content-Transfer-Encoding: 8bit

introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
get buf from virtio core for premapped mode.

If the virtio queue is premapped mode, the virtio-net send buf may
have many desc. Every desc dma address need to be unmap. So here we
introduce a new helper to collect the dma address of the buffer from
the virtio core.

Because the BAD_RING is called (that may set vq->broken), so
the relative "const" of vq is removed.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 170 +++++++++++++++++++++++++----------
 include/linux/virtio.h       |  16 ++++
 2 files changed, 138 insertions(+), 48 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c10..3bcf3e6067af 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -362,6 +362,37 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 	return vq->dma_dev;
 }
 
+static bool get_dma_info(struct vring_virtqueue *vq,
+			 struct virtio_dma_head *dma,
+			 dma_addr_t addr, unsigned int length)
+{
+	if (vq->do_unmap)
+		return true;
+
+	/* Only premapped mode. we should return the dma info to driver.
+	 * If the use_dma_api is false, then do_unmap is false. But
+	 * we should not return the dma info to driver.
+	 */
+	if (!vq->premapped)
+		return false;
+
+	if (!dma)
+		return false;
+
+	if (unlikely(dma->next >= dma->num)) {
+		BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u\n",
+			 &addr, length);
+		return false;
+	}
+
+	dma->items[dma->next].addr = addr;
+	dma->items[dma->next].length = length;
+
+	++dma->next;
+
+	return false;
+}
+
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
@@ -440,12 +471,14 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
  * Split ring specific functions - *_split().
  */
 
-static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   const struct vring_desc *desc)
+static void vring_unmap_one_split_indirect(struct vring_virtqueue *vq,
+					   const struct vring_desc *desc,
+					   struct virtio_dma_head *dma)
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!get_dma_info(vq, dma, virtio64_to_cpu(vq->vq.vdev, desc->addr),
+			  virtio32_to_cpu(vq->vq.vdev, desc->len)))
 		return;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
@@ -457,8 +490,8 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+static unsigned int vring_unmap_one_split(struct vring_virtqueue *vq,
+					  unsigned int i, struct virtio_dma_head *dma)
 {
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
@@ -474,17 +507,16 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 extra[i].len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vq->do_unmap)
-			goto out;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		goto out;
 	}
 
+	if (!get_dma_info(vq, dma, extra[i].addr, extra[i].len))
+		goto out;
+
+	dma_unmap_page(vring_dma_dev(vq), extra[i].addr, extra[i].len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+
 out:
 	return extra[i].next;
 }
@@ -717,10 +749,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (i == err_idx)
 			break;
 		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
+			vring_unmap_one_split_indirect(vq, &desc[i], NULL);
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		} else
-			i = vring_unmap_one_split(vq, i);
+			i = vring_unmap_one_split(vq, i, NULL);
 	}
 
 free_indirect:
@@ -763,11 +795,13 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 }
 
 static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+			     struct virtio_dma_head *dma, void **ctx)
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
+	WARN_ON_ONCE(vq->premapped && !dma);
+
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
 
@@ -775,12 +809,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, dma);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, dma);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -802,9 +836,9 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		if (vq->do_unmap) {
+		if (vq->do_unmap || dma) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+				vring_unmap_one_split_indirect(vq, &indir_desc[j], dma);
 		}
 
 		kfree(indir_desc);
@@ -822,6 +856,7 @@ static bool more_used_split(const struct vring_virtqueue *vq)
 
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 					 unsigned int *len,
+					 struct virtio_dma_head *dma,
 					 void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -862,7 +897,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
-	detach_buf_split(vq, i, ctx);
+	detach_buf_split(vq, i, dma, ctx);
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -984,7 +1019,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
-		detach_buf_split(vq, i, NULL);
+		detach_buf_split(vq, i, NULL, NULL);
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
 				vq->split.avail_idx_shadow);
@@ -1220,8 +1255,9 @@ static u16 packed_last_used(u16 last_used_idx)
 	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 }
 
-static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     const struct vring_desc_extra *extra)
+static void vring_unmap_extra_packed(struct vring_virtqueue *vq,
+				     const struct vring_desc_extra *extra,
+				     struct virtio_dma_head *dma)
 {
 	u16 flags;
 
@@ -1235,23 +1271,24 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 extra->addr, extra->len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vq->do_unmap)
-			return;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr, extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		return;
 	}
+
+	if (!get_dma_info(vq, dma, extra->addr, extra->len))
+		return;
+
+	dma_unmap_page(vring_dma_dev(vq), extra->addr, extra->len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				    const struct vring_packed_desc *desc)
+static void vring_unmap_desc_packed(struct vring_virtqueue *vq,
+				    const struct vring_packed_desc *desc,
+				    struct virtio_dma_head *dma)
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!get_dma_info(vq, dma, le64_to_cpu(desc->addr), le32_to_cpu(desc->len)))
 		return;
 
 	flags = le16_to_cpu(desc->flags);
@@ -1389,7 +1426,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_desc_packed(vq, &desc[i], NULL);
 
 free_desc:
 	kfree(desc);
@@ -1539,7 +1576,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], NULL);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1600,12 +1637,16 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 }
 
 static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+			      unsigned int id,
+			      struct virtio_dma_head *dma,
+			      void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 
+	WARN_ON_ONCE(vq->premapped && !dma);
+
 	state = &vq->packed.desc_state[id];
 
 	/* Clear data ptr. */
@@ -1615,11 +1656,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
-	if (unlikely(vq->do_unmap)) {
+	if (vq->do_unmap || dma) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
-			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+			vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], dma);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1632,11 +1672,11 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->do_unmap) {
+		if (vq->do_unmap || dma) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+				vring_unmap_desc_packed(vq, &desc[i], dma);
 		}
 		kfree(desc);
 		state->indir_desc = NULL;
@@ -1672,6 +1712,7 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 					  unsigned int *len,
+					  struct virtio_dma_head *dma,
 					  void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1712,7 +1753,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
-	detach_buf_packed(vq, id, ctx);
+	detach_buf_packed(vq, id, dma, ctx);
 
 	last_used += vq->packed.desc_state[id].num;
 	if (unlikely(last_used >= vq->packed.vring.num)) {
@@ -1877,7 +1918,7 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
-		detach_buf_packed(vq, i, NULL);
+		detach_buf_packed(vq, i, NULL, NULL);
 		END_USE(vq);
 		return buf;
 	}
@@ -2417,11 +2458,44 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
-				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, NULL, ctx) :
+				 virtqueue_get_buf_ctx_split(_vq, len, NULL, ctx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
+/**
+ * virtqueue_get_buf_ctx_dma - get the next used buffer with the dma info
+ * @_vq: the struct virtqueue we're talking about.
+ * @len: the length written into the buffer
+ * @dma: the head of the array to store the dma info
+ * @ctx: extra context for the token
+ *
+ * If the device wrote data into the buffer, @len will be set to the
+ * amount written.  This means you don't need to clear the buffer
+ * beforehand to ensure there's no data leakage in the case of short
+ * writes.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * We store the dma info of every descriptor of this buf to the dma->items
+ * array. If the array size is too small, some dma info may be missed, so
+ * the caller must ensure the array is large enough. The dma->next is the out
+ * value to the caller, indicates the num of the used items.
+ *
+ * Returns NULL if there are no used buffers, or the "data" token
+ * handed to virtqueue_add_*().
+ */
+void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len,
+				struct virtio_dma_head *dma, void **ctx)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, dma, ctx) :
+				 virtqueue_get_buf_ctx_split(_vq, len, dma, ctx);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx_dma);
+
 void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 {
 	return virtqueue_get_buf_ctx(_vq, len, NULL);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4cc614a38376..572aecec205b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -75,6 +75,22 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
 			    void **ctx);
 
+struct virtio_dma_item {
+	dma_addr_t addr;
+	unsigned int length;
+};
+
+struct virtio_dma_head {
+	/* total num of items. */
+	u16 num;
+	/* point to the next item to store dma info. */
+	u16 next;
+	struct virtio_dma_item items[];
+};
+
+void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len,
+				struct virtio_dma_head *dma, void **ctx);
+
 void virtqueue_disable_cb(struct virtqueue *vq);
 
 bool virtqueue_enable_cb(struct virtqueue *vq);
-- 
2.32.0.3.g01195cf9f

