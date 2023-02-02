Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477E5C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B69D781288;
	Thu,  2 Feb 2023 11:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B69D781288
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6lsh9ALZKI5m; Thu,  2 Feb 2023 11:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D524D8132E;
	Thu,  2 Feb 2023 11:01:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D524D8132E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB928C0082;
	Thu,  2 Feb 2023 11:01:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CBDEC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3848540C05
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3848540C05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yMcg1yVlRZdq
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44D6C40C07
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44D6C40C07
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaksaTH_1675335662; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaksaTH_1675335662) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 03/33] virtio_ring: packed: virtqueue_add_packed() support
 premapped
Date: Thu,  2 Feb 2023 19:00:28 +0800
Message-Id: <20230202110058.130695-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d7589ab6ea10
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
 drivers/virtio/virtio_ring.c | 71 +++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ec622403cbd5..25027a35fcf8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,6 +78,7 @@ struct vring_desc_state_packed {
 	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
+	bool premapped;
 };
 
 struct vring_desc_extra {
@@ -1200,7 +1201,8 @@ static inline u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra *extra)
+				     struct vring_desc_extra *extra,
+				     bool premapped)
 {
 	u16 flags;
 
@@ -1215,6 +1217,9 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (premapped)
+			return;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
@@ -1262,7 +1267,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
 					 void *data,
-					 gfp_t gfp)
+					 gfp_t gfp,
+					 bool premapped)
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
@@ -1288,10 +1294,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
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
@@ -1350,6 +1361,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
+	vq->packed.desc_state[id].premapped = premapped;
 
 	vq->num_added += 1;
 
@@ -1359,10 +1371,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
 
@@ -1377,6 +1390,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       unsigned int in_sgs,
 				       void *data,
 				       void *ctx,
+				       bool premapped,
 				       gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1403,7 +1417,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	if (virtqueue_use_indirect(vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, gfp);
+						    in_sgs, data, gfp, premapped);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1435,10 +1449,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
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
@@ -1485,6 +1506,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
+	vq->packed.desc_state[id].premapped = premapped;
 
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
@@ -1501,22 +1523,26 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
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
@@ -1576,8 +1602,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
+	bool premapped;
 
 	state = &vq->packed.desc_state[id];
+	premapped = state->premapped;
 
 	/* Clear data ptr. */
 	state->data = NULL;
@@ -1590,7 +1618,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 premapped);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1603,7 +1632,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_dma_api && !premapped) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -2122,7 +2151,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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
