Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0332D62C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53B4E81F2C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53B4E81F2C
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fmSkMEqXODm
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 11:31:13 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75B3D8216F
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75B3D8216F
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VwPHAPM_1699961465;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VwPHAPM_1699961465)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 19:31:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Tue, 14 Nov 2023 19:31:01 +0800
Message-Id: <20231114113104.33994-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 52aa29c00172
Content-Transfer-Encoding: 8bit

introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
get buf from virtio core for premapped mode.

If the virtio queue is premapped mode, the virtio-net send buf may
have many desc. Every desc dma address need to be unmap. So here we
introduce a new helper to collect the dma address of the buffer from
the virtio core.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 148 ++++++++++++++++++++++++++---------
 include/linux/virtio.h       |   2 +
 2 files changed, 115 insertions(+), 35 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c10..0b3caee4ef9d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -362,6 +362,20 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 	return vq->dma_dev;
 }
 
+static void store_dma_to_sg(struct scatterlist **sgp, dma_addr_t addr, unsigned int length)
+{
+	struct scatterlist *sg;
+
+	sg = *sgp;
+
+	sg->dma_address = addr;
+	sg->length = length;
+
+	sg = sg_next(sg);
+
+	*sgp = sg;
+}
+
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
@@ -441,12 +455,18 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
  */
 
 static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   const struct vring_desc *desc)
+					   const struct vring_desc *desc,
+					   struct scatterlist **sg)
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vq->do_unmap) {
+		if (*sg)
+			store_dma_to_sg(sg,
+					virtio64_to_cpu(vq->vq.vdev, desc->addr),
+					virtio32_to_cpu(vq->vq.vdev, desc->len));
 		return;
+	}
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
@@ -458,7 +478,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 }
 
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  unsigned int i, struct scatterlist **sg)
 {
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
@@ -475,8 +495,11 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vq->do_unmap)
+		if (!vq->do_unmap) {
+			if (*sg)
+				store_dma_to_sg(sg, extra[i].addr, extra[i].len);
 			goto out;
+		}
 
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra[i].addr,
@@ -717,10 +740,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
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
@@ -763,7 +786,7 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 }
 
 static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+			     struct scatterlist *sg, void **ctx)
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
@@ -775,12 +798,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, &sg);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, &sg);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -794,7 +817,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		if (!indir_desc)
-			return;
+			goto end;
 
 		len = vq->split.desc_extra[head].len;
 
@@ -802,9 +825,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		if (vq->do_unmap) {
+		if (vq->do_unmap || sg) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+				vring_unmap_one_split_indirect(vq, &indir_desc[j], &sg);
+
 		}
 
 		kfree(indir_desc);
@@ -812,6 +836,11 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	} else if (ctx) {
 		*ctx = vq->split.desc_state[head].indir_desc;
 	}
+
+end:
+	/* sg point to the next. So we mark the last one as the end. */
+	if (!vq->do_unmap && sg)
+		sg_mark_end(sg - 1);
 }
 
 static bool more_used_split(const struct vring_virtqueue *vq)
@@ -822,6 +851,7 @@ static bool more_used_split(const struct vring_virtqueue *vq)
 
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 					 unsigned int *len,
+					 struct scatterlist *sg,
 					 void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -862,7 +892,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
-	detach_buf_split(vq, i, ctx);
+	detach_buf_split(vq, i, sg, ctx);
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -984,7 +1014,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
-		detach_buf_split(vq, i, NULL);
+		detach_buf_split(vq, i, NULL, NULL);
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
 				vq->split.avail_idx_shadow);
@@ -1221,7 +1251,8 @@ static u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     const struct vring_desc_extra *extra)
+				     const struct vring_desc_extra *extra,
+				     struct scatterlist **sg)
 {
 	u16 flags;
 
@@ -1236,8 +1267,11 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vq->do_unmap)
+		if (!vq->do_unmap) {
+			if (*sg)
+				store_dma_to_sg(sg, extra->addr, extra->len);
 			return;
+		}
 
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
@@ -1247,12 +1281,17 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 }
 
 static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				    const struct vring_packed_desc *desc)
+				    const struct vring_packed_desc *desc,
+				    struct scatterlist **sg)
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vq->do_unmap) {
+		if (*sg)
+			store_dma_to_sg(sg, le64_to_cpu(desc->addr),
+					le32_to_cpu(desc->len));
 		return;
+	}
 
 	flags = le16_to_cpu(desc->flags);
 
@@ -1389,7 +1428,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_desc_packed(vq, &desc[i], NULL);
 
 free_desc:
 	kfree(desc);
@@ -1539,7 +1578,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], NULL);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1600,7 +1639,9 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 }
 
 static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+			      unsigned int id,
+			      struct scatterlist *sg,
+			      void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
@@ -1615,13 +1656,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
-	if (unlikely(vq->do_unmap)) {
-		curr = id;
-		for (i = 0; i < state->num; i++) {
-			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
-			curr = vq->packed.desc_extra[curr].next;
-		}
+	curr = id;
+	for (i = 0; i < state->num; i++) {
+		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], &sg);
+		curr = vq->packed.desc_extra[curr].next;
 	}
 
 	if (vq->indirect) {
@@ -1630,19 +1668,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		/* Free the indirect table, if any, now that it's unmapped. */
 		desc = state->indir_desc;
 		if (!desc)
-			return;
+			goto end;
 
-		if (vq->do_unmap) {
+		if (vq->do_unmap || sg) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+				vring_unmap_desc_packed(vq, &desc[i], &sg);
 		}
 		kfree(desc);
 		state->indir_desc = NULL;
 	} else if (ctx) {
 		*ctx = state->indir_desc;
 	}
+
+end:
+	/* sg point to the next. So we mark the last one as the end. */
+	if (!vq->do_unmap && sg)
+		sg_mark_end(sg - 1);
 }
 
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
@@ -1672,6 +1715,7 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 					  unsigned int *len,
+					  struct scatterlist *sg,
 					  void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1712,7 +1756,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
-	detach_buf_packed(vq, id, ctx);
+	detach_buf_packed(vq, id, sg, ctx);
 
 	last_used += vq->packed.desc_state[id].num;
 	if (unlikely(last_used >= vq->packed.vring.num)) {
@@ -1877,7 +1921,7 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
-		detach_buf_packed(vq, i, NULL);
+		detach_buf_packed(vq, i, NULL, NULL);
 		END_USE(vq);
 		return buf;
 	}
@@ -2417,11 +2461,45 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
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
+ * @sg: scatterlist array to store the dma info
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
+ * Only when the vq is in premapped mode and the sg is not null, we store the
+ * dma info of every descriptor of this buf to the sg array. The sg array must
+ * point to a scatterlist array, with the last element marked as the sg last.
+ * Once the function is done, we mark the last sg stored with dma info as the
+ * last one. If the sg array size is too small, some dma info may be missed.
+ *
+ * Returns NULL if there are no used buffers, or the "data" token
+ * handed to virtqueue_add_*().
+ */
+void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len,
+				struct scatterlist *sg, void **ctx)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, sg, ctx) :
+				 virtqueue_get_buf_ctx_split(_vq, len, sg, ctx);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx_dma);
+
 void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 {
 	return virtqueue_get_buf_ctx(_vq, len, NULL);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4cc614a38376..0b919786ade5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -74,6 +74,8 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 
 void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
 			    void **ctx);
+void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len,
+				struct scatterlist *sg, void **ctx);
 
 void virtqueue_disable_cb(struct virtqueue *vq);
 
-- 
2.32.0.3.g01195cf9f

