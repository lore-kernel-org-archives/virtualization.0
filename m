Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9542CC4332F
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 11:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F1B3416BF;
	Thu, 24 Feb 2022 11:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JPtE7R-vIOIa; Thu, 24 Feb 2022 11:04:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDA4A4168F;
	Thu, 24 Feb 2022 11:04:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7365C0037;
	Thu, 24 Feb 2022 11:04:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4D23C0035
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C34D41675
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v_xJg4OS-Xqu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9700E4167A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R971e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V5O7aur_1645700649; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5O7aur_1645700649) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 19:04:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 6/9] virtio_ring: packed: virtqueue_add_packed() support
 premapped
Date: Thu, 24 Feb 2022 19:03:59 +0800
Message-Id: <20220224110402.108161-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d02e086a8668
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

Record this premapped information in desc_extra[id]->premapped, which
can be skipped when executing dma unmap.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 76 +++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 35cb804dcf2d..c8d63cae8b33 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1007,7 +1007,8 @@ static struct virtqueue *vring_create_virtqueue_split(
  */
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra *extra)
+				     struct vring_desc_extra *extra,
+				     bool premapped)
 {
 	u16 flags;
 
@@ -1022,6 +1023,9 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (premapped)
+			return;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
@@ -1069,7 +1073,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
 					 void *data,
-					 gfp_t gfp)
+					 gfp_t gfp,
+					 bool premapped)
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
@@ -1095,10 +1100,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
+			if (premapped) {
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
@@ -1128,6 +1138,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 						  vq->packed.avail_used_flags;
 	}
 
+	vq->packed.desc_extra[id].premapped = premapped;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1166,10 +1178,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return 0;
 
 unmap_release:
-	err_idx = i;
-
-	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+	if (!premapped) {
+		err_idx = i;
+		for (i = 0; i < err_idx; i++)
+			vring_unmap_desc_packed(vq, &desc[i]);
+	}
 
 	kfree(desc);
 
@@ -1184,7 +1197,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       unsigned int in_sgs,
 				       void *data,
 				       void *ctx,
-				       gfp_t gfp)
+				       gfp_t gfp,
+				       bool premapped)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
@@ -1210,7 +1224,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	if (virtqueue_use_indirect(_vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, gfp);
+						    in_sgs, data, gfp, premapped);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1242,10 +1256,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	c = 0;
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
+			dma_addr_t addr;
+
+			if (premapped) {
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
@@ -1265,6 +1286,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				vq->packed.desc_extra[curr].flags =
 					le16_to_cpu(flags);
 			}
+
 			prev = curr;
 			curr = vq->packed.desc_extra[curr].next;
 
@@ -1293,6 +1315,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
 
+	vq->packed.desc_extra[id].premapped = premapped;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1308,22 +1332,26 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
+	vq->packed.avail_used_flags = avail_used_flags;
+
+	if (premapped)
+		goto unmap_free;
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
 
+unmap_free:
 	END_USE(vq);
 	return -EIO;
 }
@@ -1383,9 +1411,12 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
+	bool premapped;
 
 	state = &vq->packed.desc_state[id];
 
+	premapped = vq->packed.desc_extra[state->last].premapped;
+
 	/* Clear data ptr. */
 	state->data = NULL;
 
@@ -1397,7 +1428,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 premapped);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1410,7 +1442,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_dma_api && !premapped) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -1816,7 +1848,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp) :
+					out_sgs, in_sgs, data, ctx, gfp, premapped) :
 				 virtqueue_add_split(_vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, gfp, premapped);
 }
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
