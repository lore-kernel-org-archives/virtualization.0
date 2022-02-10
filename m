Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D56C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 08:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A553582CFA;
	Thu, 10 Feb 2022 08:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24t7abkFOqxG; Thu, 10 Feb 2022 08:51:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3547282C61;
	Thu, 10 Feb 2022 08:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07BBAC0011;
	Thu, 10 Feb 2022 08:51:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B93EC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D038410D7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ULzlrx9LK9s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50C5240A04
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:32 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V43Qccp_1644483089; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V43Qccp_1644483089) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Feb 2022 16:51:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v1 6/6] virtio: packed: virtqueue_add_packed() support dma
 address
Date: Thu, 10 Feb 2022 16:51:24 +0800
Message-Id: <20220210085124.15466-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
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

virtqueue_add_packed() only supports virtual addresses, dma is completed
in virtqueue_add_packed().

In some scenarios (such as the AF_XDP scenario), the memory is allocated
and DMA is completed in advance, so it is necessary for us to support
passing the DMA address to virtqueue_add_packed().

Record this predma information in extra->flags, which can be skipped
when executing dma unmap.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 79 ++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d32c0bf6016f..b8c7697e925d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1011,7 +1011,8 @@ static struct virtqueue *vring_create_virtqueue_split(
  */
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra *extra)
+				     struct vring_desc_extra *extra,
+				     bool predma)
 {
 	u16 flags;
 
@@ -1026,6 +1027,9 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (predma)
+			return;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
@@ -1073,7 +1077,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
 					 void *data,
-					 gfp_t gfp)
+					 gfp_t gfp,
+					 bool predma)
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
@@ -1099,10 +1104,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
+			if (predma) {
+				addr = sg_dma_address(sg);
+
+			} else {
+				addr = vring_map_one_sg(vq, sg, n < out_sgs ?
+							DMA_TO_DEVICE : DMA_FROM_DEVICE);
+				if (vring_mapping_error(vq, addr))
+					goto unmap_release;
+			}
 
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
 						0 : VRING_DESC_F_WRITE);
@@ -1132,6 +1142,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 						  vq->packed.avail_used_flags;
 	}
 
+	if (predma)
+		vq->packed.desc_extra[id].flags |= VIRTIO_DESC_F_PREDMA;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1170,10 +1183,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return 0;
 
 unmap_release:
-	err_idx = i;
-
-	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+	if (!predma) {
+		err_idx = i;
+		for (i = 0; i < err_idx; i++)
+			vring_unmap_desc_packed(vq, &desc[i]);
+	}
 
 	kfree(desc);
 
@@ -1188,7 +1202,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       unsigned int in_sgs,
 				       void *data,
 				       void *ctx,
-				       gfp_t gfp)
+				       gfp_t gfp,
+				       bool predma)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
@@ -1214,7 +1229,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	if (virtqueue_use_indirect(_vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, gfp);
+						    in_sgs, data, gfp, predma);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1246,10 +1261,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	c = 0;
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
+			dma_addr_t addr;
+
+			if (predma) {
+				addr = sg_dma_address(sg);
+
+			} else {
+				addr = vring_map_one_sg(vq, sg, n < out_sgs ?
+							DMA_TO_DEVICE : DMA_FROM_DEVICE);
+				if (vring_mapping_error(vq, addr))
+					goto unmap_release;
+			}
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
 				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
@@ -1297,6 +1319,9 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
 
+	if (predma)
+		vq->packed.desc_extra[id].flags |= VIRTIO_DESC_F_PREDMA;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1312,22 +1337,27 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
+	vq->packed.avail_used_flags = avail_used_flags;
+
+	if (predma)
+		goto skip_unmap;
+
 	err_idx = i;
 	i = head;
 	curr = vq->free_head;
 
-	vq->packed.avail_used_flags = avail_used_flags;
-
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], false);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
 			i = 0;
 	}
 
+skip_unmap:
+
 	END_USE(vq);
 	return -EIO;
 }
@@ -1387,9 +1417,13 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
+	bool predma = false;
 
 	state = &vq->packed.desc_state[id];
 
+	if (vq->packed.desc_extra[state->last].flags & VIRTIO_DESC_F_PREDMA)
+		predma = true;
+
 	/* Clear data ptr. */
 	state->data = NULL;
 
@@ -1401,7 +1435,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 predma);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1414,7 +1449,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_dma_api && !predma) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -1820,7 +1855,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp) :
+					out_sgs, in_sgs, data, ctx, gfp, predma) :
 				 virtqueue_add_split(_vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, gfp, predma);
 }
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
