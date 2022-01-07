Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA2FC433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 06:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E53B401A4;
	Fri,  7 Jan 2022 06:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-hJknrvQpO3; Fri,  7 Jan 2022 06:33:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A1C04248C;
	Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34858C0031;
	Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3912FC0075
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1BDD40283
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQRN5PPnRazO
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D90D942481
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V19hjz5_1641537187; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V19hjz5_1641537187) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 07 Jan 2022 14:33:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 2/6] virtio: split: alloc indirect desc with extra
Date: Fri,  7 Jan 2022 14:33:02 +0800
Message-Id: <20220107063306.23240-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

In the scenario where indirect is not used, each desc corresponds to an
extra, which is used to record information such as dma, flags, and
next.

In the scenario of using indirect, the assigned desc does not have the
corresponding extra record dma information, and the dma information must
be obtained from the desc when unmap.

This patch allocates the corresponding extra array when indirect desc is
allocated. This has these advantages:
1. Record the dma information of desc, no need to read desc when unmap
2. It will be more convenient and unified in processing
3. Some additional information can be recorded in extra, which will be
   used in subsequent patches.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 197 ++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 106 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 81531cbb08a7..64b4d2b03016 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -66,9 +66,21 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
+struct vring_desc_extra {
+	dma_addr_t addr;		/* Descriptor DMA addr. */
+	u32 len;			/* Descriptor length. */
+	u16 flags;			/* Descriptor flags. */
+	u16 next;			/* The next desc state in a list. */
+};
+
+struct vring_indirect_split {
+	struct vring_desc_extra *extra;
+	struct vring_desc desc[];
+};
+
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
-	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	struct vring_indirect_split *in;/* Indirect descriptor, if any. */
 };
 
 struct vring_desc_state_packed {
@@ -78,13 +90,6 @@ struct vring_desc_state_packed {
 	u16 last;			/* The last desc state in a list. */
 };
 
-struct vring_desc_extra {
-	dma_addr_t addr;		/* Descriptor DMA addr. */
-	u32 len;			/* Descriptor length. */
-	u16 flags;			/* Descriptor flags. */
-	u16 next;			/* The next desc state in a list. */
-};
-
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -369,66 +374,40 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
  * Split ring specific functions - *_split().
  */
 
-static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   struct vring_desc *desc)
-{
-	u16 flags;
-
-	if (!vq->use_dma_api)
-		return;
-
-	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
-
-	if (flags & VRING_DESC_F_INDIRECT) {
-		dma_unmap_single(vring_dma_dev(vq),
-				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
-				 virtio32_to_cpu(vq->vq.vdev, desc->len),
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		dma_unmap_page(vring_dma_dev(vq),
-			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
-			       virtio32_to_cpu(vq->vq.vdev, desc->len),
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
-}
-
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  struct vring_desc_extra *extra)
 {
-	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
 
 	if (!vq->use_dma_api)
 		goto out;
 
-	flags = extra[i].flags;
+	flags = extra->flags;
 
 	if (flags & VRING_DESC_F_INDIRECT) {
 		dma_unmap_single(vring_dma_dev(vq),
-				 extra[i].addr,
-				 extra[i].len,
+				 extra->addr,
+				 extra->len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
 		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
+			       extra->addr,
+			       extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
 
 out:
-	return extra[i].next;
+	return extra->next;
 }
 
-static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
-					       unsigned int total_sg,
-					       gfp_t gfp)
+static struct vring_indirect_split *alloc_indirect_split(struct virtqueue *_vq,
+							 unsigned int total_sg,
+							 gfp_t gfp)
 {
-	struct vring_desc *desc;
-	unsigned int i;
+	struct vring_indirect_split *in;
+	unsigned int i, size;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -437,40 +416,52 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
-	if (!desc)
+	size = sizeof(struct vring_desc) + sizeof(struct vring_desc_extra);
+	size = size * total_sg + sizeof(*in);
+
+	in = kmalloc(size, gfp);
+	if (!in)
 		return NULL;
 
+	in->extra = (struct vring_desc_extra *)(in->desc + total_sg);
+
 	for (i = 0; i < total_sg; i++)
-		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
-	return desc;
+		in->extra[i].next = i + 1;
+
+	return in;
 }
 
 static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
-						    struct vring_desc *desc,
+						    struct vring_indirect_split *in,
 						    unsigned int i,
 						    dma_addr_t addr,
 						    unsigned int len,
-						    u16 flags,
-						    bool indirect)
+						    u16 flags)
 {
 	struct vring_virtqueue *vring = to_vvq(vq);
-	struct vring_desc_extra *extra = vring->split.desc_extra;
+	struct vring_desc_extra *extra;
+	struct vring_desc *desc;
 	u16 next;
 
-	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
-	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
-	desc[i].len = cpu_to_virtio32(vq->vdev, len);
+	if (!in) {
+		desc = vring->split.vring.desc + i;
+		extra = vring->split.desc_extra + i;
+
+	} else {
+		desc = in->desc + i;
+		extra = in->extra + i;
+	}
+
+	next = extra->next;
 
-	if (!indirect) {
-		next = extra[i].next;
-		desc[i].next = cpu_to_virtio16(vq->vdev, next);
+	desc->flags = cpu_to_virtio16(vq->vdev, flags);
+	desc->addr = cpu_to_virtio64(vq->vdev, addr);
+	desc->len = cpu_to_virtio32(vq->vdev, len);
+	desc->next = cpu_to_virtio16(vq->vdev, next);
 
-		extra[i].addr = addr;
-		extra[i].len = len;
-		extra[i].flags = flags;
-	} else
-		next = virtio16_to_cpu(vq->vdev, desc[i].next);
+	extra->addr = addr;
+	extra->len = len;
+	extra->flags = flags;
 
 	return next;
 }
@@ -485,11 +476,11 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_indirect_split *in = NULL;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
-	bool indirect;
 
 	START_USE(vq);
 
@@ -507,21 +498,21 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
-	if (virtqueue_use_indirect(_vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
-	else {
+	if (virtqueue_use_indirect(_vq, total_sg)) {
+		in = alloc_indirect_split(_vq, total_sg, gfp);
+		if (in)
+			desc = in->desc;
+	} else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
 	}
 
 	if (desc) {
 		/* Use a single buffer which doesn't continue */
-		indirect = true;
 		/* Set up rest to use this indirect table. */
 		i = 0;
 		descs_used = 1;
 	} else {
-		indirect = false;
 		desc = vq->split.vring.desc;
 		i = head;
 		descs_used = total_sg;
@@ -535,8 +526,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		 * host should service the ring ASAP. */
 		if (out_sgs)
 			vq->notify(&vq->vq);
-		if (indirect)
-			kfree(desc);
+		kfree(in);
 		END_USE(vq);
 		return -ENOSPC;
 	}
@@ -551,9 +541,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr, sg->length,
-						     VRING_DESC_F_NEXT,
-						     indirect);
+			i = virtqueue_add_desc_split(_vq, in, i, addr, sg->length,
+						     VRING_DESC_F_NEXT);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -566,20 +555,19 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr,
+			i = virtqueue_add_desc_split(_vq, in, i, addr,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE,
-						     indirect);
+						     VRING_DESC_F_WRITE);
 		}
 	}
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vq->use_dma_api)
+	if (!in && vq->use_dma_api)
 		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
 
-	if (indirect) {
+	if (in) {
 		/* Now that the indirect table is filled in, map it. */
 		dma_addr_t addr = vring_map_single(
 			vq, desc, total_sg * sizeof(struct vring_desc),
@@ -587,28 +575,26 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (vring_mapping_error(vq, addr))
 			goto unmap_release;
 
-		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
-					 head, addr,
+		virtqueue_add_desc_split(_vq, NULL, head, addr,
 					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT,
-					 false);
+					 VRING_DESC_F_INDIRECT);
 	}
 
 	/* We're using some buffers from the free list. */
 	vq->vq.num_free -= descs_used;
 
 	/* Update free pointer */
-	if (indirect)
+	if (in)
 		vq->free_head = vq->split.desc_extra[head].next;
 	else
 		vq->free_head = i;
 
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
-	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
+	if (in)
+		vq->split.desc_state[head].in = in;
 	else
-		vq->split.desc_state[head].indir_desc = ctx;
+		vq->split.desc_state[head].in = ctx;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
@@ -636,7 +622,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 unmap_release:
 	err_idx = i;
 
-	if (indirect)
+	if (in)
 		i = 0;
 	else
 		i = head;
@@ -644,15 +630,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
-			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
-		} else
-			i = vring_unmap_one_split(vq, i);
+		if (in)
+			i = vring_unmap_one_split(vq, in->extra + i);
+		else
+			i = vring_unmap_one_split(vq, vq->split.desc_extra + i);
 	}
 
-	if (indirect)
-		kfree(desc);
+	kfree(in);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -702,12 +686,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, vq->split.desc_extra + i);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, vq->split.desc_extra + i);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -715,12 +699,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	vq->vq.num_free++;
 
 	if (vq->indirect) {
-		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
+		struct vring_indirect_split *in;
 		u32 len;
 
+		in = vq->split.desc_state[head].in;
+
 		/* Free the indirect table, if any, now that it's unmapped. */
-		if (!indir_desc)
+		if (!in)
 			return;
 
 		len = vq->split.desc_extra[head].len;
@@ -730,12 +715,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
 		for (j = 0; j < len / sizeof(struct vring_desc); j++)
-			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+			vring_unmap_one_split(vq, in->extra + j);
 
-		kfree(indir_desc);
-		vq->split.desc_state[head].indir_desc = NULL;
+		kfree(in);
+		vq->split.desc_state[head].in = NULL;
 	} else if (ctx) {
-		*ctx = vq->split.desc_state[head].indir_desc;
+		*ctx = vq->split.desc_state[head].in;
 	}
 }
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
