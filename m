Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481719DF7A
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796129; cv=none; b=VZMpexkmz1fC9zbbjisIPeQqSMTW59ABk83Qr8ylRoQFG3A1Fuw7M5/2+O9cpS4HzFG1h6LDJPpthb3Usiv3myttyRzAglNjvZgXTR+pyT9SafxLLNant0aQf9drUM1pel1V4QrOFS9O+qaK5pgxh/azbT7IpDak/1/43AjyAkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796129; c=relaxed/simple;
	bh=eb4zfgoqrUoHsA1IKUHl+rvs9sM/sWJqs5cMZ/lWZ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=BBS5B4EN/wQr7B+HTectWXJkUz8Z46VD3L3lm4inPXtpBMW1zSdxE7kHp2hj8JxS9LlIN43qattmIJnhXeEjm0vN30mTk1s7n5/xKXpPtv5IMZeZJC177QvCWCjYN+aag9h2iDxdmN9argU2+927vMpznmtGEaoIiRP51YAUVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hiZh6+A1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiZh6+A1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742796126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFf1y7rSG0aaixiUJ9FXI01wdX33Ii9P/J3vi62gCbU=;
	b=hiZh6+A1t5silbyuJbEh8+JhC3k2Hy716eUS5D+uV5zDRqczCjqKZjp9rGkRYM4vcCR420
	1mmFvBe9wVDlzlnSRM/6Hx6rGo8SUzp4XaHTETbPZVi1V0LsvtOrFyX7ak6H50pl7uIPKV
	y6E6c5ZemWyWf0XcC/+Y8ce3ULiUSnw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-qoFpSjfSP4eln84YnoyICQ-1; Mon,
 24 Mar 2025 02:02:02 -0400
X-MC-Unique: qoFpSjfSP4eln84YnoyICQ-1
X-Mimecast-MFC-AGG-ID: qoFpSjfSP4eln84YnoyICQ_1742796121
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A3DF180AF50;
	Mon, 24 Mar 2025 06:02:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B29CB195609D;
	Mon, 24 Mar 2025 06:01:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] virtio_ring: add in order support
Date: Mon, 24 Mar 2025 14:01:27 +0800
Message-ID: <20250324060127.2358-7-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
References: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch implements in order support for both split virtqueue and
packed virtqueue. Dedicate virtqueue ops are introduced for the packed
virtqueue. Most of the ops were reused but the ones that have major
difference.

KVM guest + testpmd on the host shows 5% improvement in packed
virtqueue TX PPS. No obvious changes in other test cases.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 451 +++++++++++++++++++++++++++++++++--
 1 file changed, 434 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0fad8e8419c8..4341c178d53f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -74,6 +74,7 @@ struct vring_desc_state_split {
 	 * allocated together. So we won't stress more to the memory allocator.
 	 */
 	struct vring_desc *indir_desc;
+	u32 total_len;			/* Buffer Length */
 };
 
 struct vring_desc_state_packed {
@@ -85,6 +86,7 @@ struct vring_desc_state_packed {
 	struct vring_packed_desc *indir_desc;
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
+	u32 total_len;			/* Buffer Length */
 };
 
 struct vring_desc_extra {
@@ -198,8 +200,15 @@ struct vring_virtqueue {
 	/* Host publishes avail event idx */
 	bool event;
 
+	/* Device supports in order */
+	bool in_order;
+
 	/* Head of free buffer list. */
 	unsigned int free_head;
+
+	/* Head of the batched used buffers, vq->num means no batching */
+	unsigned int batch_head;
+
 	/* Number we've added since last sync. */
 	unsigned int num_added;
 
@@ -562,7 +571,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, c, avail, descs_used, err_idx;
+	unsigned int i, n, c, avail, descs_used, err_idx, total_len = 0;
 	int head;
 	bool indirect;
 
@@ -638,6 +647,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
 						     flags,
 						     premapped);
+			total_len += len;
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -657,6 +667,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			 */
 			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
 						     flags, premapped);
+			total_len += len;
 		}
 	}
 
@@ -679,7 +690,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	vq->vq.num_free -= descs_used;
 
 	/* Update free pointer */
-	if (indirect)
+	if (vq->in_order) {
+		vq->free_head += descs_used;
+		if (vq->free_head >= vq->split.vring.num)
+			vq->free_head -= vq->split.vring.num;
+		vq->split.desc_state[head].total_len = total_len;;
+	} else if (indirect)
 		vq->free_head = vq->split.desc_extra[head].next;
 	else
 		vq->free_head = i;
@@ -816,8 +832,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
-
 	vring_unmap_one_split(vq, &extra[i]);
+
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -830,6 +846,40 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		*ctx = vq->split.desc_state[head].indir_desc;
 }
 
+static void detach_buf_split_in_order(struct vring_virtqueue *vq, unsigned int head,
+				      void **ctx)
+{
+	struct vring_desc_extra *extra;
+	unsigned int i;
+	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+
+	/* Clear data ptr. */
+	vq->split.desc_state[head].data = NULL;
+
+	extra = vq->split.desc_extra;
+
+	/* Put back on free list: unmap first-level descriptors and find end */
+	i = head;
+
+	while (vq->split.vring.desc[i].flags & nextflag) {
+		vring_unmap_one_split(vq, &extra[i]);
+		i++;
+		if (i >= vq->split.vring.num)
+			i = 0;
+		vq->vq.num_free++;
+	}
+
+	vring_unmap_one_split(vq, &extra[i]);
+
+	/* Plus final descriptor */
+	vq->vq.num_free++;
+
+	if (vq->indirect)
+		detach_indirect_split(vq, head);
+	else if (ctx)
+		*ctx = vq->split.desc_state[head].indir_desc;
+}
+
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
 				 u16 last_used_idx)
 {
@@ -899,6 +949,83 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	return ret;
 }
 
+static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
+						  unsigned int *len,
+						  void **ctx)
+{
+	void *ret;
+	unsigned int i, num = vq->split.vring.num, num_free = vq->vq.num_free;
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
+	if (vq->batch_head == num) {
+		if (!more_used_split(vq)) {
+			pr_debug("No more buffers in queue\n");
+			END_USE(vq);
+			return NULL;
+		}
+
+		/* Only get used array entries after they have been
+		 * exposed by host. */
+		virtio_rmb(vq->weak_barriers);
+
+		i = virtio32_to_cpu(vq->vq.vdev,
+				    vq->split.vring.used->ring[last_used].id);
+		if (i != last_used) {
+			vq->batch_head = i;
+			i = last_used;
+			*len = vq->split.desc_state[i].total_len;
+		} else {
+			*len = virtio32_to_cpu(vq->vq.vdev,
+					vq->split.vring.used->ring[last_used].len);
+		}
+	} else {
+		i = vq->next_avail_idx;
+		*len = vq->split.desc_state[i].total_len;
+		if (i == vq->batch_head)
+			vq->batch_head = num;
+	}
+
+	if (unlikely(i >= num)) {
+		BAD_RING(vq, "id %u out of range\n", i);
+		return NULL;
+	}
+	if (unlikely(!vq->split.desc_state[i].data)) {
+		BAD_RING(vq, "id %u is not a head!\n", i);
+		return NULL;
+	}
+
+	/* detach_buf_split clears data, so grab it now. */
+	ret = vq->split.desc_state[i].data;
+	detach_buf_split_in_order(vq, i, ctx);
+
+	vq->next_avail_idx += vq->vq.num_free - num_free;
+	if (vq->next_avail_idx >= num)
+		vq->next_avail_idx -= num;
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
@@ -992,7 +1119,10 @@ static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
-		detach_buf_split(vq, i, NULL);
+		if (vq->in_order)
+			detach_buf_split_in_order(vq, i, NULL);
+		else
+			detach_buf_split(vq, i, NULL);
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
 				vq->split.avail_idx_shadow);
@@ -1055,6 +1185,7 @@ static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
+	vq->batch_head = vq->split.vring.num;
 }
 
 static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
@@ -1147,6 +1278,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 }
 
 struct virtqueue_ops split_ops;
+struct virtqueue_ops split_in_order_ops;
 
 static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 					       struct vring_virtqueue_split *vring_split,
@@ -1166,7 +1298,6 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 		return NULL;
 
 	vq->packed_ring = false;
-	vq->ops = &split_ops;
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
@@ -1186,6 +1317,9 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+	vq->in_order = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER);
+
+	vq->ops = vq->in_order ? &split_in_order_ops : &split_ops;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
@@ -1349,13 +1483,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
 
 	head = vq->next_avail_idx;
@@ -1373,8 +1508,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	}
 
 	i = 0;
-	id = vq->free_head;
-	BUG_ON(id == vq->packed.vring.num);
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
@@ -1394,6 +1527,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
 			}
 
+			total_len += len;
 			i++;
 		}
 	}
@@ -1447,6 +1581,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
+	vq->packed.desc_state[id].total_len = total_len;
 
 	vq->num_added += 1;
 
@@ -1499,8 +1634,11 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
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
@@ -1621,6 +1759,152 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
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
+						    vq->next_avail_idx);
+		if (err != -ENOMEM) {
+			END_USE(vq);
+			return err;
+		}
+
+		/* fall back on direct */
+	}
+
+	head = vq->next_avail_idx;
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
+			if (unlikely(vq->use_dma_api)) {
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
+	vq->next_avail_idx = i;
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
@@ -1741,7 +2025,7 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
+static bool __virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
 {
 	bool wrap_counter;
 	u16 used_idx;
@@ -1752,6 +2036,20 @@ static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap
 	return is_used_desc_packed(vq, used_idx, wrap_counter);
 }
 
+static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
+{
+	return __virtqueue_poll_packed(vq, off_wrap);
+}
+
+static bool virtqueue_poll_packed_in_order(const struct vring_virtqueue *vq,
+					   u16 off_wrap)
+{
+	if (vq->batch_head != vq->packed.vring.num)
+		return true;
+
+	return __virtqueue_poll_packed(vq, off_wrap);
+}
+
 static bool more_used_packed(const struct vring_virtqueue *vq)
 {
 	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
@@ -1781,10 +2079,88 @@ static void update_last_used_idx_packed(struct vring_virtqueue *vq,
 				cpu_to_le16(vq->last_used_idx));
 }
 
+static bool more_used_packed_in_order(const struct vring_virtqueue *vq)
+{
+	return virtqueue_poll_packed_in_order(vq, READ_ONCE(vq->last_used_idx));
+}
+
+static bool __more_used_packed(const struct vring_virtqueue *vq)
+{
+	return __virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
+}
+
+static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
+						   unsigned int *len,
+						   void **ctx)
+{
+	unsigned int num = vq->packed.vring.num;
+	u16 last_used, id, last_used_idx, batch_head;
+	bool used_wrap_counter;
+	void *ret;
+
+	START_USE(vq);
+
+	batch_head = READ_ONCE(vq->batch_head);
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
+	if (batch_head == num) {
+		if (!__more_used_packed(vq)) {
+			pr_debug("No more buffers in queue\n");
+			END_USE(vq);
+			return NULL;
+		}
+		/* Only get used elements after they have been exposed by host. */
+		virtio_rmb(vq->weak_barriers);
+
+		id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
+		if (id != last_used) {
+			vq->batch_head = id;
+			id = last_used;
+			*len = vq->packed.desc_state[id].total_len;
+		} else {
+			*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
+		}
+	} else {
+		id = last_used;
+		*len = vq->packed.desc_state[id].total_len;
+		if (id == batch_head)
+			vq->batch_head = num;
+	}
+
+	if (unlikely(id >= num)) {
+		BAD_RING(vq, "id %u out of range\n", id);
+		return NULL;
+	}
+	if (unlikely(!vq->packed.desc_state[id].data)) {
+		BAD_RING(vq, "id %u is not a head!\n", id);
+		return NULL;
+	}
+
+	/* detach_buf_packed clears data, so grab it now. */
+	ret = vq->packed.desc_state[id].data;
+	__detach_buf_packed(vq, id, ctx);
+
+	update_last_used_idx_packed(vq, id, last_used, used_wrap_counter);
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
@@ -1796,7 +2172,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 		return NULL;
 	}
 
-	if (!more_used_packed(vq)) {
+	if (!__more_used_packed(vq)) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
@@ -1811,7 +2187,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
 	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
 
-	if (unlikely(id >= vq->packed.vring.num)) {
+	if (unlikely(id >= num)) {
 		BAD_RING(vq, "id %u out of range\n", id);
 		return NULL;
 	}
@@ -1931,6 +2307,7 @@ static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
 	last_used_idx = READ_ONCE(vq->last_used_idx);
 	wrap_counter = packed_used_wrap_counter(last_used_idx);
 	used_idx = packed_last_used(last_used_idx);
+
 	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
 		END_USE(vq);
 		return false;
@@ -1952,7 +2329,7 @@ static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
-		detach_buf_packed(vq, i, NULL);
+		__detach_buf_packed(vq, i, NULL);
 		END_USE(vq);
 		return buf;
 	}
@@ -1978,6 +2355,8 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 	for (i = 0; i < num - 1; i++)
 		desc_extra[i].next = i + 1;
 
+	desc_extra[num - 1].next = 0;
+
 	return desc_extra;
 }
 
@@ -2108,8 +2487,12 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
 {
 	vq->packed = *vring_packed;
 
-	/* Put everything in free lists. */
-	vq->free_head = 0;
+	if (vq->in_order)
+		vq->batch_head = vq->split.vring.num;
+	else {
+		/* Put everything in free lists. */
+		vq->free_head = 0;
+	}
 }
 
 static void virtqueue_reset_packed(struct vring_virtqueue *vq)
@@ -2125,6 +2508,7 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
 }
 
 struct virtqueue_ops packed_ops;
+struct virtqueue_ops packed_in_order_ops;
 
 static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 					       struct vring_virtqueue_packed *vring_packed,
@@ -2164,6 +2548,9 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+	vq->in_order = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER);
+
+	vq->ops = vq->in_order ? &packed_in_order_ops : &packed_ops;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
@@ -2259,6 +2646,20 @@ struct virtqueue_ops split_ops = {
 	.reset = virtqueue_reset_split,
 };
 
+struct virtqueue_ops split_in_order_ops = {
+	.add = virtqueue_add_split,
+	.get = virtqueue_get_buf_ctx_split_in_order,
+	.kick_prepare = virtqueue_kick_prepare_split,
+	.disable_cb = virtqueue_disable_cb_split,
+	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
+	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
+	.poll = virtqueue_poll_split,
+	.detach_unused_buf = virtqueue_detach_unused_buf_split,
+	.more_used = more_used_split,
+	.resize = virtqueue_resize_split,
+	.reset = virtqueue_reset_split,
+};
+
 struct virtqueue_ops packed_ops = {
 	.add = virtqueue_add_packed,
 	.get = virtqueue_get_buf_ctx_packed,
@@ -2273,6 +2674,20 @@ struct virtqueue_ops packed_ops = {
 	.reset = virtqueue_reset_packed,
 };
 
+struct virtqueue_ops packed_in_order_ops = {
+	.add = virtqueue_add_packed_in_order,
+	.get = virtqueue_get_buf_ctx_packed_in_order,
+	.kick_prepare = virtqueue_kick_prepare_packed,
+	.disable_cb = virtqueue_disable_cb_packed,
+	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
+	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
+	.poll = virtqueue_poll_packed_in_order,
+	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
+	.more_used = more_used_packed_in_order,
+	.resize = virtqueue_resize_packed,
+	.reset = virtqueue_reset_packed,
+};
+
 static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
 					 void (*recycle)(struct virtqueue *vq, void *buf))
 {
@@ -3016,6 +3431,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_NOTIFICATION_DATA:
 			break;
+		case VIRTIO_F_IN_ORDER:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.42.0

