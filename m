Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B47C7EE24
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 02:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EE5684229;
	Wed, 17 May 2023 02:23:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EE5684229
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1JZkellyL-F; Wed, 17 May 2023 02:23:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 40C5C84217;
	Wed, 17 May 2023 02:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40C5C84217
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B592C008C;
	Wed, 17 May 2023 02:23:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 863B8C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BF6241C59
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BF6241C59
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8MrIIG2MYccI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B74940134
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B74940134
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:00 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0ViqlPNB_1684290175; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0ViqlPNB_1684290175) by smtp.aliyun-inc.com;
 Wed, 17 May 2023 10:22:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v9 06/12] virtio_ring: packed: virtqueue_add_packed()
 support premapped
Date: Wed, 17 May 2023 10:22:43 +0800
Message-Id: <20230517022249.20790-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c00a8eb40cdd
Cc: Christoph Hellwig <hch@infradead.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

Record this information in desc_state, we can skip unmap based on this
when executing dma unmap.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 48 ++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bd5e84afab37..e169c7653b32 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,6 +78,7 @@ struct vring_desc_state_packed {
 	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
+	bool premapped;			/* DMA mapping is done by driver. */
 };
 
 struct vring_desc_extra {
@@ -1222,7 +1223,8 @@ static u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     const struct vring_desc_extra *extra)
+				     const struct vring_desc_extra *extra,
+				     bool premapped)
 {
 	u16 flags;
 
@@ -1237,6 +1239,9 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (premapped)
+			return;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
@@ -1284,7 +1289,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
 					 void *data,
-					 gfp_t gfp)
+					 gfp_t gfp,
+					 bool premapped)
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
@@ -1311,7 +1317,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
-					     DMA_TO_DEVICE : DMA_FROM_DEVICE, &addr))
+					     DMA_TO_DEVICE : DMA_FROM_DEVICE, premapped, &addr))
 				goto unmap_release;
 
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
@@ -1371,6 +1377,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
+	vq->packed.desc_state[id].premapped = premapped;
 
 	vq->num_added += 1;
 
@@ -1380,10 +1387,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
 
@@ -1398,6 +1406,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       unsigned int in_sgs,
 				       void *data,
 				       void *ctx,
+				       bool premapped,
 				       gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1424,7 +1433,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	if (virtqueue_use_indirect(vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, gfp);
+						    in_sgs, data, gfp, premapped);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1458,8 +1467,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 
-			if (vring_map_one_sg(vq, sg, n < out_sgs ?
-					     DMA_TO_DEVICE : DMA_FROM_DEVICE, &addr))
+			if (vring_map_one_sg(vq, sg, n < out_sgs ?  DMA_TO_DEVICE : DMA_FROM_DEVICE,
+					     premapped, &addr))
 				goto unmap_release;
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
@@ -1507,6 +1516,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
+	vq->packed.desc_state[id].premapped = premapped;
 
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
@@ -1523,16 +1533,21 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
+	vq->packed.avail_used_flags = avail_used_flags;
+
+	if (premapped) {
+		END_USE(vq);
+		return -EIO;
+	}
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
@@ -1612,7 +1627,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 state->premapped);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1625,7 +1641,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_dma_api && !state->premapped) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -2161,7 +2177,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp) :
+					out_sgs, in_sgs, data, ctx, premapped, gfp) :
 				 virtqueue_add_split(_vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, premapped, gfp);
 }
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
