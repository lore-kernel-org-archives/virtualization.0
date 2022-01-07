Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C95C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 06:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D58316FC81;
	Fri,  7 Jan 2022 06:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6w3pdnomUBm; Fri,  7 Jan 2022 06:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 248906FC79;
	Fri,  7 Jan 2022 06:33:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00E67C006F;
	Fri,  7 Jan 2022 06:33:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39B6FC0071
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED2BB42959
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JzhNyvofTow3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BC4942954
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V19LP-f_1641537188; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V19LP-f_1641537188) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 07 Jan 2022 14:33:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 3/6] virtio: packed: alloc indirect desc with extra
Date: Fri,  7 Jan 2022 14:33:03 +0800
Message-Id: <20220107063306.23240-4-xuanzhuo@linux.alibaba.com>
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
 drivers/virtio/virtio_ring.c | 100 +++++++++++++++++------------------
 1 file changed, 49 insertions(+), 51 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 64b4d2b03016..7420741cb750 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,6 +78,11 @@ struct vring_indirect_split {
 	struct vring_desc desc[];
 };
 
+struct vring_indirect_packed {
+	struct vring_desc_extra *extra;
+	struct vring_packed_desc desc[];
+};
+
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_indirect_split *in;/* Indirect descriptor, if any. */
@@ -85,7 +90,7 @@ struct vring_desc_state_split {
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+	struct vring_indirect_packed *in; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -992,35 +997,11 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	}
 }
 
-static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				   struct vring_packed_desc *desc)
-{
-	u16 flags;
-
-	if (!vq->use_dma_api)
-		return;
-
-	flags = le16_to_cpu(desc->flags);
-
-	if (flags & VRING_DESC_F_INDIRECT) {
-		dma_unmap_single(vring_dma_dev(vq),
-				 le64_to_cpu(desc->addr),
-				 le32_to_cpu(desc->len),
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		dma_unmap_page(vring_dma_dev(vq),
-			       le64_to_cpu(desc->addr),
-			       le32_to_cpu(desc->len),
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
-}
-
-static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
-						       gfp_t gfp)
+static struct vring_indirect_packed *alloc_indirect_packed(unsigned int total_sg,
+							   gfp_t gfp)
 {
-	struct vring_packed_desc *desc;
+	struct vring_indirect_packed *in;
+	int size;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -1029,9 +1010,16 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
+	size = sizeof(struct vring_packed_desc) + sizeof(struct vring_desc_extra);
+	size = size * total_sg + sizeof(*in);
+
+	in = kmalloc(size, gfp);
+	if (!in)
+		return NULL;
 
-	return desc;
+	in->extra = (struct vring_desc_extra *)(in->desc + total_sg);
+
+	return in;
 }
 
 static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
@@ -1042,20 +1030,22 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
+	struct vring_indirect_packed *in;
 	struct vring_packed_desc *desc;
+	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
-	u16 head, id;
+	u16 head, id, flags;
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
-	if (!desc)
+	in = alloc_indirect_packed(total_sg, gfp);
+	if (!in)
 		return -ENOMEM;
 
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
-		kfree(desc);
+		kfree(in);
 		END_USE(vq);
 		return -ENOSPC;
 	}
@@ -1071,16 +1061,24 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
 
-			desc[i].flags = cpu_to_le16(n < out_sgs ?
-						0 : VRING_DESC_F_WRITE);
-			desc[i].addr = cpu_to_le64(addr);
-			desc[i].len = cpu_to_le32(sg->length);
+			flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
+
+			desc = in->desc + i;
+			desc->flags = cpu_to_le16(flags);
+			desc->addr = cpu_to_le64(addr);
+			desc->len = cpu_to_le32(sg->length);
+
+			extra = in->extra + i;
+			extra->addr  = addr;
+			extra->len   = sg->length;
+			extra->flags = flags;
+
 			i++;
 		}
 	}
 
 	/* Now that the indirect table is filled in, map it. */
-	addr = vring_map_single(vq, desc,
+	addr = vring_map_single(vq, in->desc,
 			total_sg * sizeof(struct vring_packed_desc),
 			DMA_TO_DEVICE);
 	if (vring_mapping_error(vq, addr))
@@ -1126,7 +1124,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].in = in;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
@@ -1140,9 +1138,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_extra_packed(vq, in->extra + i);
 
-	kfree(desc);
+	kfree(in);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -1259,7 +1257,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	/* Store token. */
 	vq->packed.desc_state[id].num = descs_used;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = ctx;
+	vq->packed.desc_state[id].in = ctx;
 	vq->packed.desc_state[id].last = prev;
 
 	/*
@@ -1350,7 +1348,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 			      unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
-	struct vring_packed_desc *desc;
+	struct vring_indirect_packed *in;
 	unsigned int i, curr;
 
 	state = &vq->packed.desc_state[id];
@@ -1375,20 +1373,20 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		u32 len;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
-		desc = state->indir_desc;
-		if (!desc)
+		in = state->in;
+		if (!in)
 			return;
 
 		if (vq->use_dma_api) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+				vring_unmap_extra_packed(vq, in->extra + i);
 		}
-		kfree(desc);
-		state->indir_desc = NULL;
+		kfree(in);
+		state->in = NULL;
 	} else if (ctx) {
-		*ctx = state->indir_desc;
+		*ctx = state->in;
 	}
 }
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
