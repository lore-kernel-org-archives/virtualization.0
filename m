Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C67C64ED6
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 07:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F96D61145;
	Tue, 14 Feb 2023 07:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F96D61145
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qj6k8jj1k6OX; Tue, 14 Feb 2023 07:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD3036110B;
	Tue, 14 Feb 2023 07:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD3036110B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97833C007D;
	Tue, 14 Feb 2023 07:27:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C071C007D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15A3D416BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15A3D416BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 32aFOAoeD0L0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 468CC416B7
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 468CC416B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VbeyoxX_1676359628; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VbeyoxX_1676359628) by smtp.aliyun-inc.com;
 Tue, 14 Feb 2023 15:27:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 05/10] virtio_ring: packed: introduce
 virtqueue_add_packed_premapped()
Date: Tue, 14 Feb 2023 15:26:59 +0800
Message-Id: <20230214072704.126660-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 1d14bf2ff3c2
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
 drivers/virtio/virtio_ring.c | 67 ++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a31155abe101..79244ccbae9e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,6 +78,7 @@ struct vring_desc_state_packed {
 	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
+	bool premapped;
 };
 
 struct vring_desc_extra {
@@ -1318,7 +1319,8 @@ static inline u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra *extra)
+				     struct vring_desc_extra *extra,
+				     bool premapped)
 {
 	u16 flags;
 
@@ -1333,6 +1335,9 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (premapped)
+			return;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
@@ -1382,7 +1387,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 struct vring_packed_desc *desc)
 {
 	struct scatterlist *sg;
-	unsigned int i, n, err_idx;
+	unsigned int i, n;
 	u16 head, id;
 	dma_addr_t addr;
 
@@ -1640,6 +1645,51 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return err;
 }
 
+static inline int virtqueue_add_packed_premapped(struct virtqueue *_vq,
+						 struct scatterlist *sgs[],
+						 unsigned int total_sg,
+						 unsigned int out_sgs,
+						 unsigned int in_sgs,
+						 void *data,
+						 void *ctx,
+						 gfp_t gfp)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_packed_desc *desc;
+	u16 id;
+	int err;
+
+	START_USE(vq);
+
+	/* check vq state and try to alloc desc for indirect. */
+	err = virtqueue_add_packed_prepare(vq, total_sg, data, ctx, &desc, gfp);
+	if (err)
+		goto end;
+
+	id = vq->free_head;
+
+	if (desc) {
+		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs, in_sgs, desc);
+		if (err)
+			goto err;
+	} else {
+		virtqueue_add_packed_vring(vq, sgs, total_sg, out_sgs, in_sgs);
+		vq->packed.desc_state[id].indir_desc = ctx;
+	}
+
+	vq->packed.desc_state[id].data = data;
+	vq->packed.desc_state[id].premapped = true;
+
+	goto end;
+
+err:
+	kfree(desc);
+
+end:
+	END_USE(vq);
+	return err;
+}
+
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1695,8 +1745,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
+	bool premapped;
 
 	state = &vq->packed.desc_state[id];
+	premapped = state->premapped;
 
 	/* Clear data ptr. */
 	state->data = NULL;
@@ -1709,7 +1761,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 premapped);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1722,7 +1775,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_dma_api && !premapped) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -2265,8 +2318,10 @@ static inline int virtqueue_add_premapped(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return virtqueue_add_split_premapped(_vq, sgs, total_sg, out_sgs,
-					     in_sgs, data, ctx, gfp);
+	return vq->packed_ring ? virtqueue_add_packed_premapped(_vq, sgs, total_sg, out_sgs,
+								in_sgs, data, ctx, gfp) :
+				virtqueue_add_split_premapped(_vq, sgs, total_sg, out_sgs,
+							      in_sgs, data, ctx, gfp);
 }
 
 /**
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
