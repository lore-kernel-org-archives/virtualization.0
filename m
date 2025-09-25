Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450232F5319
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796725; cv=none; b=pQ/HnXA/Mfi104yr81CtSZyIBGQUdUQgzYZs2Jctl4PM1VKr9P8GRi4yoAOx9lYZOUKJWXm7XsAqXBdKktA7COjaxSf+OvB6WbikcV0cv7gfN+wb1i2gLSt4ItTy5FxkqNR0FekPtf6mBgsGQkAh5qrAdcqcRAeUogSqsenSShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796725; c=relaxed/simple;
	bh=5X4j21XktRkZI0n5xrEdrmi6yAWjTkU6n2hDs90tOAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjgGZDLN+Wi4HAxDMlp5DVIFSO5ExuuBuaD46kmtMBuzmJIRZN2gIk+iKD53QDiDpcT1RRHS4j+SH3wYdrTMOP3pS5wUZ4bEqhZRALYzaic2qE4Lvm9a0jgGE78Iw8X6Li4J6dI1sy3XdK5YI8iIYlgg5QyIFaLSoJGyYP6D1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCLrtgcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCLrtgcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpUETgDmvHcMr9BFSxinHphZ/0OgzHTand3oLSjO+vs=;
	b=iCLrtgcfU64q3azBub8hf9Jlpf87Hd/6XQT1bKb+yoT8tvWvsNEJglymggN3q6dQbSaBJZ
	S1TLG4+0ZRgZrtCQNG/t8J8k7ARCWMX2r8NPm6izbhxZk/GM4ikS640fv9vBLt6TdIbRUY
	wD75oZWQCoRdWezqnzLwOPcQxn3TBoM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-3p6YuN4sMT6Z0SIGif--2g-1; Thu,
 25 Sep 2025 06:38:38 -0400
X-MC-Unique: 3p6YuN4sMT6Z0SIGif--2g-1
X-Mimecast-MFC-AGG-ID: 3p6YuN4sMT6Z0SIGif--2g_1758796718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D97D919774D6;
	Thu, 25 Sep 2025 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71E1019560A2;
	Thu, 25 Sep 2025 10:38:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 19/19] virtio_ring: add in order support
Date: Thu, 25 Sep 2025 18:37:08 +0800
Message-ID: <20250925103708.44589-20-jasowang@redhat.com>
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch implements in order support for both split virtqueue and
packed virtqueue. Performance could be gained for the device where the
memory access could be expensive (e.g vhost-net or a real PCI device):

Benchmark with KVM guest:

Vhost-net on the host: (pktgen + XDP_DROP):

         in_order=off | in_order=on | +%
    TX:  5.20Mpps     | 6.20Mpps    | +19%
    RX:  3.47Mpps     | 3.61Mpps    | + 4%

Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):

For split virtqueue:

         in_order=off | in_order=on | +%
    TX:  5.60Mpps     | 5.60Mpps    | +0.0%
    RX:  9.16Mpps     | 9.61Mpps    | +4.9%

For packed virtqueue:

         in_order=off | in_order=on | +%
    TX:  5.60Mpps     | 5.70Mpps    | +1.7%
    RX:  10.6Mpps     | 10.8Mpps    | +1.8%

Benchmark also shows no performance impact for in_order=off for queue
size with 256 and 1024.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 429 +++++++++++++++++++++++++++++++++--
 1 file changed, 407 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e134f914a408..75cc28dc3011 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -70,6 +70,8 @@
 enum vq_layout {
 	SPLIT = 0,
 	PACKED,
+	SPLIT_IN_ORDER,
+	PACKED_IN_ORDER,
 	VQ_TYPE_MAX,
 };
 
@@ -80,6 +82,7 @@ struct vring_desc_state_split {
 	 * allocated together. So we won't stress more to the memory allocator.
 	 */
 	struct vring_desc *indir_desc;
+	u32 total_len;			/* Buffer Length */
 };
 
 struct vring_desc_state_packed {
@@ -91,6 +94,7 @@ struct vring_desc_state_packed {
 	struct vring_packed_desc *indir_desc;
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
+	u32 total_len;			/* Buffer Length */
 };
 
 struct vring_desc_extra {
@@ -168,7 +172,7 @@ struct vring_virtqueue_packed {
 struct vring_virtqueue;
 
 struct virtqueue_ops {
-	int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
+	int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
 		   unsigned int total_sg, unsigned int out_sgs,
 		   unsigned int in_sgs,	void *data,
 		   void *ctx, bool premapped, gfp_t gfp);
@@ -206,6 +210,17 @@ struct vring_virtqueue {
 
 	/* Head of free buffer list. */
 	unsigned int free_head;
+
+	/*
+	 * With IN_ORDER, devices write a single used ring entry with
+	 * the id corresponding to the head entry of the descriptor chain
+	 * describing the last buffer in the batch
+	 */
+	struct used_entry {
+		u32 id;
+		u32 len;
+	} batch_last;
+
 	/* Number we've added since last sync. */
 	unsigned int num_added;
 
@@ -258,7 +273,12 @@ static void vring_free(struct virtqueue *_vq);
 
 static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
 {
-	return vq->layout == PACKED;
+	return vq->layout == PACKED || vq->layout == PACKED_IN_ORDER;
+}
+
+static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
+{
+	return vq->layout == SPLIT_IN_ORDER || vq->layout == PACKED_IN_ORDER;
 }
 
 static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
@@ -575,6 +595,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, err_idx, c = 0;
+	/* Total length for in-order */
+	unsigned int total_len = 0;
 	int head;
 	bool indirect;
 
@@ -644,6 +666,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
 						     ++c == total_sg ? 0 : VRING_DESC_F_NEXT,
 						     premapped);
+			total_len += len;
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -661,6 +684,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 				i, addr, len,
 				(++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
 				VRING_DESC_F_WRITE, premapped);
+			total_len += len;
 		}
 	}
 
@@ -683,7 +707,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	vq->vq.num_free -= descs_used;
 
 	/* Update free pointer */
-	if (indirect)
+	if (virtqueue_is_in_order(vq)) {
+		vq->free_head += descs_used;
+		if (vq->free_head >= vq->split.vring.num)
+			vq->free_head -= vq->split.vring.num;
+		vq->split.desc_state[head].total_len = total_len;;
+	} else if (indirect)
 		vq->free_head = vq->split.desc_extra[head].next;
 	else
 		vq->free_head = i;
@@ -857,6 +886,14 @@ static bool more_used_split(const struct vring_virtqueue *vq)
 	return virtqueue_poll_split(vq, vq->last_used_idx);
 }
 
+static bool more_used_split_in_order(const struct vring_virtqueue *vq)
+{
+	if (vq->batch_last.id != vq->split.vring.num)
+		return true;
+
+	return virtqueue_poll_split(vq, vq->last_used_idx);
+}
+
 static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 					 unsigned int *len,
 					 void **ctx)
@@ -914,6 +951,73 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	return ret;
 }
 
+static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
+						  unsigned int *len,
+						  void **ctx)
+{
+	void *ret;
+	unsigned int num = vq->split.vring.num;
+	u16 last_used;
+
+	START_USE(vq);
+
+	if (unlikely(vq->broken)) {
+		END_USE(vq);
+		return NULL;
+	}
+
+	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
+
+	if (vq->batch_last.id == num) {
+		if (!more_used_split(vq)) {
+			pr_debug("No more buffers in queue\n");
+			END_USE(vq);
+			return NULL;
+		}
+
+		/* Only get used array entries after they have been
+		 * exposed by host. */
+		virtio_rmb(vq->weak_barriers);
+		vq->batch_last.id = virtio32_to_cpu(vq->vq.vdev,
+				    vq->split.vring.used->ring[last_used].id);
+		vq->batch_last.len = virtio32_to_cpu(vq->vq.vdev,
+				     vq->split.vring.used->ring[last_used].len);
+	}
+
+	if (vq->batch_last.id == last_used) {
+		vq->batch_last.id = num;
+		*len = vq->batch_last.len;
+	} else
+		*len = vq->split.desc_state[last_used].total_len;
+
+	if (unlikely(last_used >= num)) {
+		BAD_RING(vq, "id %u out of range\n", last_used);
+		return NULL;
+	}
+	if (unlikely(!vq->split.desc_state[last_used].data)) {
+		BAD_RING(vq, "id %u is not a head!\n", last_used);
+		return NULL;
+	}
+
+	/* detach_buf_split clears data, so grab it now. */
+	ret = vq->split.desc_state[last_used].data;
+	detach_buf_split_in_order(vq, last_used, ctx);
+
+	vq->last_used_idx++;
+	/* If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call. */
+	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
+		virtio_store_mb(vq->weak_barriers,
+				&vring_used_event(&vq->split.vring),
+				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
+
+	LAST_ADD_TIME_INVALID(vq);
+
+	END_USE(vq);
+	return ret;
+}
+
 static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
 {
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
@@ -1007,7 +1111,10 @@ static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
-		detach_buf_split(vq, i, NULL);
+		if (virtqueue_is_in_order(vq))
+			detach_buf_split_in_order(vq, i, NULL);
+		else
+			detach_buf_split(vq, i, NULL);
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
 				vq->split.avail_idx_shadow);
@@ -1070,6 +1177,7 @@ static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
+	vq->batch_last.id = vq->split.vring.num;
 }
 
 static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
@@ -1181,7 +1289,6 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 	if (!vq)
 		return NULL;
 
-	vq->layout = SPLIT;
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
@@ -1201,6 +1308,8 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+	vq->layout = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
+		     SPLIT_IN_ORDER : SPLIT;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
@@ -1358,13 +1467,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int in_sgs,
 					 void *data,
 					 bool premapped,
-					 gfp_t gfp)
+					 gfp_t gfp,
+					 u16 id)
 {
 	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i, n, err_idx, len;
-	u16 head, id;
+	unsigned int i, n, err_idx, len, total_len = 0;
+	u16 head;
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
@@ -1382,8 +1492,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	}
 
 	i = 0;
-	id = vq->free_head;
-	BUG_ON(id == vq->packed.vring.num);
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
@@ -1403,6 +1511,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
 			}
 
+			total_len += len;
 			i++;
 		}
 	}
@@ -1449,13 +1558,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				1 << VRING_PACKED_DESC_F_USED;
 	}
 	vq->packed.next_avail_idx = n;
-	vq->free_head = vq->packed.desc_extra[id].next;
+	if (!virtqueue_is_in_order(vq))
+		vq->free_head = vq->packed.desc_extra[id].next;
 
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
+	vq->packed.desc_state[id].total_len = total_len;
 
 	vq->num_added += 1;
 
@@ -1508,8 +1619,11 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 	BUG_ON(total_sg == 0);
 
 	if (virtqueue_use_indirect(vq, total_sg)) {
+		id = vq->free_head;
+		BUG_ON(id == vq->packed.vring.num);
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, premapped, gfp);
+						    in_sgs, data, premapped,
+						    gfp, id);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1630,6 +1744,152 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 	return -EIO;
 }
 
+static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
+						struct scatterlist *sgs[],
+						unsigned int total_sg,
+						unsigned int out_sgs,
+						unsigned int in_sgs,
+						void *data,
+						void *ctx,
+						bool premapped,
+						gfp_t gfp)
+{
+	struct vring_packed_desc *desc;
+	struct scatterlist *sg;
+	unsigned int i, n, c, err_idx, total_len = 0;
+	__le16 head_flags, flags;
+	u16 head, avail_used_flags;
+	int err;
+
+	START_USE(vq);
+
+	BUG_ON(data == NULL);
+	BUG_ON(ctx && vq->indirect);
+
+	if (unlikely(vq->broken)) {
+		END_USE(vq);
+		return -EIO;
+	}
+
+	LAST_ADD_TIME_UPDATE(vq);
+
+	BUG_ON(total_sg == 0);
+
+	if (virtqueue_use_indirect(vq, total_sg)) {
+		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
+						    in_sgs, data, premapped, gfp,
+						    vq->packed.next_avail_idx);
+		if (err != -ENOMEM) {
+			END_USE(vq);
+			return err;
+		}
+
+		/* fall back on direct */
+	}
+
+	head = vq->packed.next_avail_idx;
+	avail_used_flags = vq->packed.avail_used_flags;
+
+	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
+
+	desc = vq->packed.vring.desc;
+	i = head;
+
+	if (unlikely(vq->vq.num_free < total_sg)) {
+		pr_debug("Can't add buf len %i - avail = %i\n",
+			 total_sg, vq->vq.num_free);
+		END_USE(vq);
+		return -ENOSPC;
+	}
+
+	c = 0;
+	for (n = 0; n < out_sgs + in_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr;
+			u32 len;
+
+			if (vring_map_one_sg(vq, sg, n < out_sgs ?
+					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
+					     &addr, &len, premapped))
+				goto unmap_release;
+
+			flags = cpu_to_le16(vq->packed.avail_used_flags |
+				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
+				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
+			if (i == head)
+				head_flags = flags;
+			else
+				desc[i].flags = flags;
+
+
+			desc[i].addr = cpu_to_le64(addr);
+			desc[i].len = cpu_to_le32(len);
+			desc[i].id = cpu_to_le16(head);
+
+			if (unlikely(vq->use_map_api)) {
+				vq->packed.desc_extra[i].addr = premapped ?
+				      DMA_MAPPING_ERROR: addr;
+				vq->packed.desc_extra[i].len = len;
+				vq->packed.desc_extra[i].flags =
+					le16_to_cpu(flags);
+			}
+
+			if ((unlikely(++i >= vq->packed.vring.num))) {
+				i = 0;
+				vq->packed.avail_used_flags ^=
+					1 << VRING_PACKED_DESC_F_AVAIL |
+					1 << VRING_PACKED_DESC_F_USED;
+				vq->packed.avail_wrap_counter ^= 1;
+			}
+
+			total_len += len;
+		}
+	}
+
+	/* We're using some buffers from the free list. */
+	vq->vq.num_free -= total_sg;
+
+	/* Update free pointer */
+	vq->packed.next_avail_idx = i;
+
+	/* Store token. */
+	vq->packed.desc_state[head].num = total_sg;
+	vq->packed.desc_state[head].data = data;
+	vq->packed.desc_state[head].indir_desc = ctx;
+	vq->packed.desc_state[head].total_len = total_len;
+
+	/*
+	 * A driver MUST NOT make the first descriptor in the list
+	 * available before all subsequent descriptors comprising
+	 * the list are made available.
+	 */
+	virtio_wmb(vq->weak_barriers);
+	vq->packed.vring.desc[head].flags = head_flags;
+	vq->num_added += total_sg;
+
+	pr_debug("Added buffer head %i to %p\n", head, vq);
+	END_USE(vq);
+
+	return 0;
+
+unmap_release:
+	err_idx = i;
+	i = head;
+	vq->packed.avail_used_flags = avail_used_flags;
+
+	for (n = 0; n < total_sg; n++) {
+		if (i == err_idx)
+			break;
+		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i]);
+		i++;
+		if (i >= vq->packed.vring.num)
+			i = 0;
+	}
+
+	END_USE(vq);
+	return -EIO;
+}
+
 static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 {
 	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
@@ -1790,10 +2050,81 @@ static void update_last_used_idx_packed(struct vring_virtqueue *vq,
 				cpu_to_le16(vq->last_used_idx));
 }
 
+static bool more_used_packed_in_order(const struct vring_virtqueue *vq)
+{
+	if (vq->batch_last.id != vq->packed.vring.num)
+		return true;
+
+	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
+}
+
+static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
+						   unsigned int *len,
+						   void **ctx)
+{
+	unsigned int num = vq->packed.vring.num;
+	u16 last_used, last_used_idx;
+	bool used_wrap_counter;
+	void *ret;
+
+	START_USE(vq);
+
+	if (unlikely(vq->broken)) {
+		END_USE(vq);
+		return NULL;
+	}
+
+	last_used_idx = vq->last_used_idx;
+	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
+	last_used = packed_last_used(last_used_idx);
+
+	if (vq->batch_last.id == num) {
+		if (!more_used_packed(vq)) {
+			pr_debug("No more buffers in queue\n");
+			END_USE(vq);
+			return NULL;
+		}
+		/* Only get used elements after they have been exposed by host. */
+		virtio_rmb(vq->weak_barriers);
+		vq->batch_last.id =
+			le16_to_cpu(vq->packed.vring.desc[last_used].id);
+		vq->batch_last.len =
+			le32_to_cpu(vq->packed.vring.desc[last_used].len);
+	}
+
+	if (vq->batch_last.id == last_used) {
+		vq->batch_last.id = num;
+		*len = vq->batch_last.len;
+	} else
+		*len = vq->packed.desc_state[last_used].total_len;
+
+	if (unlikely(last_used >= num)) {
+		BAD_RING(vq, "id %u out of range\n", last_used);
+		return NULL;
+	}
+	if (unlikely(!vq->packed.desc_state[last_used].data)) {
+		BAD_RING(vq, "id %u is not a head!\n", last_used);
+		return NULL;
+	}
+
+	/* detach_buf_packed clears data, so grab it now. */
+	ret = vq->packed.desc_state[last_used].data;
+	detach_buf_packed_in_order(vq, last_used, ctx);
+
+	update_last_used_idx_packed(vq, last_used, last_used,
+				    used_wrap_counter);
+
+	LAST_ADD_TIME_INVALID(vq);
+
+	END_USE(vq);
+	return ret;
+}
+
 static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 					  unsigned int *len,
 					  void **ctx)
 {
+	unsigned int num = vq->packed.vring.num;
 	u16 last_used, id, last_used_idx;
 	bool used_wrap_counter;
 	void *ret;
@@ -1820,7 +2151,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
 	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
 
-	if (unlikely(id >= vq->packed.vring.num)) {
+	if (unlikely(id >= num)) {
 		BAD_RING(vq, "id %u out of range\n", id);
 		return NULL;
 	}
@@ -1961,7 +2292,10 @@ static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
-		detach_buf_packed(vq, i, NULL);
+		if (virtqueue_is_in_order(vq))
+			detach_buf_packed_in_order(vq, i, NULL);
+		else
+			detach_buf_packed(vq, i, NULL);
 		END_USE(vq);
 		return buf;
 	}
@@ -1987,6 +2321,8 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 	for (i = 0; i < num - 1; i++)
 		desc_extra[i].next = i + 1;
 
+	desc_extra[num - 1].next = 0;
+
 	return desc_extra;
 }
 
@@ -2118,8 +2454,12 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
 {
 	vq->packed = *vring_packed;
 
-	/* Put everything in free lists. */
-	vq->free_head = 0;
+	if (virtqueue_is_in_order(vq))
+		vq->batch_last.id = vq->packed.vring.num;
+	else {
+		/* Put everything in free lists. */
+		vq->free_head = 0;
+	}
 }
 
 static void virtqueue_reset_packed(struct vring_virtqueue *vq)
@@ -2166,13 +2506,14 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 #else
 	vq->broken = false;
 #endif
-	vq->layout = PACKED;
 	vq->map = map;
 	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+	vq->layout = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
+		     PACKED_IN_ORDER : PACKED;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
@@ -2282,9 +2623,39 @@ static const struct virtqueue_ops packed_ops = {
 	.reset = virtqueue_reset_packed,
 };
 
+static const struct virtqueue_ops split_in_order_ops = {
+	.add = virtqueue_add_split,
+	.get = virtqueue_get_buf_ctx_split_in_order,
+	.kick_prepare = virtqueue_kick_prepare_split,
+	.disable_cb = virtqueue_disable_cb_split,
+	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
+	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
+	.poll = virtqueue_poll_split,
+	.detach_unused_buf = virtqueue_detach_unused_buf_split,
+	.more_used = more_used_split_in_order,
+	.resize = virtqueue_resize_split,
+	.reset = virtqueue_reset_split,
+};
+
+static const struct virtqueue_ops packed_in_order_ops = {
+	.add = virtqueue_add_packed_in_order,
+	.get = virtqueue_get_buf_ctx_packed_in_order,
+	.kick_prepare = virtqueue_kick_prepare_packed,
+	.disable_cb = virtqueue_disable_cb_packed,
+	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
+	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
+	.poll = virtqueue_poll_packed,
+	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
+	.more_used = more_used_packed_in_order,
+	.resize = virtqueue_resize_packed,
+	.reset = virtqueue_reset_packed,
+};
+
 static const struct virtqueue_ops *const all_ops[VQ_TYPE_MAX] = {
 	[SPLIT] = &split_ops,
-	[PACKED] = &packed_ops
+	[PACKED] = &packed_ops,
+	[SPLIT_IN_ORDER] = &split_in_order_ops,
+	[PACKED_IN_ORDER] = &packed_in_order_ops,
 };
 
 static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
@@ -2340,6 +2711,12 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
 	case PACKED:							\
 		ret = all_ops[PACKED]->op(vq, ##__VA_ARGS__);		\
 		break;							\
+	case SPLIT_IN_ORDER:						\
+		ret = all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
+		break;							\
+	case PACKED_IN_ORDER:						\
+		ret = all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
+		break;							\
 	default:							\
 		BUG();							\
 		break;							\
@@ -2356,10 +2733,16 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
 	case PACKED:					\
 		all_ops[PACKED]->op(vq, ##__VA_ARGS__);	\
 		break;					\
-	default:					\
-		BUG();					\
-		break;					\
-	}						\
+	case SPLIT_IN_ORDER:						\
+		all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
+		break;							\
+	case PACKED_IN_ORDER:						\
+		all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
+		break;							\
+	default:							\
+		BUG();							\
+		break;							\
+	}								\
 })
 
 static inline int virtqueue_add(struct virtqueue *_vq,
@@ -3076,6 +3459,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_NOTIFICATION_DATA:
 			break;
+		case VIRTIO_F_IN_ORDER:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.31.1

