Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCE0C7EE36
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A8D361241;
	Thu,  2 Mar 2023 11:59:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A8D361241
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mGMzTIzO_KXp; Thu,  2 Mar 2023 11:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C53176124D;
	Thu,  2 Mar 2023 11:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C53176124D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00C88C008E;
	Thu,  2 Mar 2023 11:59:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2177EC008D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F31EC40988
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F31EC40988
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N-obuqZAvtPt
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C25A409A6
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C25A409A6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R781e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxLYm8_1677758353; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxLYm8_1677758353) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 07/12] virtio_ring: packed: introduce
 virtqueue_add_packed_premapped()
Date: Thu,  2 Mar 2023 19:59:03 +0800
Message-Id: <20230302115908.1461-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: b21604ee9ed7
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
passing the DMA address to virtio core.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 81a9c0692fec..5e98f828236d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,6 +78,7 @@ struct vring_desc_state_packed {
 	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
+	bool dma_map;			/* Addr is mapped by virtio core or not. */
 };
 
 struct vring_desc_extra {
@@ -1286,7 +1287,8 @@ static inline u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra *extra)
+				     struct vring_desc_extra *extra,
+				     bool dma_map)
 {
 	u16 flags;
 
@@ -1301,6 +1303,9 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (!dma_map)
+			return;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
@@ -1564,6 +1569,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       unsigned int in_sgs,
 				       void *data,
 				       void *ctx,
+				       bool dma_map,
 				       gfp_t gfp)
 {
 
@@ -1581,9 +1587,11 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		goto end;
 	}
 
-	err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
-	if (err)
-		goto err;
+	if (dma_map) {
+		err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+		if (err)
+			goto err;
+	}
 
 	id = vq->free_head;
 
@@ -1597,11 +1605,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	}
 
 	vq->packed.desc_state[id].data = data;
+	vq->packed.desc_state[id].dma_map = dma_map;
 
 	goto end;
 
 err:
-	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (dma_map)
+		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+
 	kfree(desc);
 
 end:
@@ -1664,8 +1675,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
+	bool dma_map;
 
 	state = &vq->packed.desc_state[id];
+	dma_map = state->dma_map;
 
 	/* Clear data ptr. */
 	state->data = NULL;
@@ -1678,7 +1691,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 dma_map);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1691,7 +1705,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_dma_api && dma_map) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -2218,7 +2232,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp) :
+					out_sgs, in_sgs, data, ctx, true, gfp) :
 				 virtqueue_add_split(_vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, true, gfp);
 }
@@ -2234,8 +2248,10 @@ static inline int virtqueue_add_premapped(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return virtqueue_add_split(_vq, sgs, total_sg, out_sgs, in_sgs, data,
-				   ctx, false, gfp);
+	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
+						      out_sgs, in_sgs, data, ctx, false, gfp) :
+				virtqueue_add_split(_vq, sgs, total_sg, out_sgs,
+						    in_sgs, data, ctx, false, gfp);
 }
 
 /**
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
