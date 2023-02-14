Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4C9C6379F
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 07:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 633B461103;
	Tue, 14 Feb 2023 07:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 633B461103
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulol88q6zOwG; Tue, 14 Feb 2023 07:27:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA485610EA;
	Tue, 14 Feb 2023 07:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA485610EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6FEDC0082;
	Tue, 14 Feb 2023 07:27:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59BD9C0033
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3370361129
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3370361129
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2RJivXydrHAy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D19561098
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D19561098
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VbeojhG_1676359627; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VbeojhG_1676359627) by smtp.aliyun-inc.com;
 Tue, 14 Feb 2023 15:27:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 03/10] virtio_ring: packed: refactor
 virtqueue_add_packed() for premapped
Date: Tue, 14 Feb 2023 15:26:57 +0800
Message-Id: <20230214072704.126660-4-xuanzhuo@linux.alibaba.com>
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

DMA-related logic is separated from virtqueue_add_packed to prepare for
the subsequent support for premapped.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 150 ++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 72 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 42b1ff87518e..47b6f9152f9f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1329,7 +1329,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int total_sg,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
-					 void *data,
 					 struct vring_packed_desc *desc)
 {
 	struct scatterlist *sg;
@@ -1345,14 +1344,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
-
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
 						0 : VRING_DESC_F_WRITE);
-			desc[i].addr = cpu_to_le64(addr);
+			desc[i].addr = cpu_to_le64(sg->dma_address);
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
 		}
@@ -1363,7 +1357,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			total_sg * sizeof(struct vring_packed_desc),
 			DMA_TO_DEVICE);
 	if (vring_mapping_error(vq, addr))
-		goto unmap_release;
+		return -ENOMEM;
 
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
 	vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
@@ -1404,53 +1398,30 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
-	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
-	END_USE(vq);
 
 	return 0;
-
-unmap_release:
-	err_idx = i;
-
-	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
-
-	kfree(desc);
-
-	END_USE(vq);
-	return -ENOMEM;
 }
 
-static inline int virtqueue_add_packed(struct virtqueue *_vq,
-				       struct scatterlist *sgs[],
-				       unsigned int total_sg,
-				       unsigned int out_sgs,
-				       unsigned int in_sgs,
-				       void *data,
-				       void *ctx,
-				       gfp_t gfp)
+static inline int virtqueue_add_packed_prepare(struct vring_virtqueue *vq,
+					       unsigned int total_sg,
+					       void *data,
+					       void *ctx,
+					       struct vring_packed_desc **pdesc,
+					       gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
-	struct scatterlist *sg;
-	unsigned int i, n, c, descs_used, err_idx;
-	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
-	int err;
-
-	START_USE(vq);
+	unsigned int descs_used;
 
 	BUG_ON(data == NULL);
 	BUG_ON(ctx && vq->indirect);
 
 	if (unlikely(vq->broken)) {
-		END_USE(vq);
 		return -EIO;
 	}
 
@@ -1458,39 +1429,55 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	BUG_ON(total_sg == 0);
 
+	desc = NULL;
+
 	if (virtqueue_use_indirect(vq, total_sg)) {
 		desc = alloc_indirect_packed(total_sg, gfp);
 		if (desc) {
 			if (unlikely(vq->vq.num_free < 1)) {
 				pr_debug("Can't add buf len 1 - avail = 0\n");
 				kfree(desc);
-				END_USE(vq);
 				return -ENOSPC;
 			}
 
-			return virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-							     in_sgs, data, desc);
+			return 0;
 		}
 
 		/* fall back on direct */
 	}
 
-	head = vq->packed.next_avail_idx;
-	avail_used_flags = vq->packed.avail_used_flags;
-
 	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
 
-	desc = vq->packed.vring.desc;
-	i = head;
 	descs_used = total_sg;
 
 	if (unlikely(vq->vq.num_free < descs_used)) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 descs_used, vq->vq.num_free);
-		END_USE(vq);
 		return -ENOSPC;
 	}
 
+	*pdesc = desc;
+
+	return 0;
+}
+
+static void virtqueue_add_packed_vring(struct vring_virtqueue *vq,
+				       struct scatterlist *sgs[],
+				       unsigned int total_sg,
+				       unsigned int out_sgs,
+				       unsigned int in_sgs)
+{
+	struct vring_packed_desc *desc;
+	struct scatterlist *sg;
+	unsigned int i, n, c, descs_used;
+	__le16 head_flags, flags;
+	u16 head, id, prev, curr;
+
+	desc = vq->packed.vring.desc;
+	head = vq->packed.next_avail_idx;
+	i = head;
+	descs_used = total_sg;
+
 	id = vq->free_head;
 	BUG_ON(id == vq->packed.vring.num);
 
@@ -1498,11 +1485,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	c = 0;
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
-
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
 				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
 				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
@@ -1511,12 +1493,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			else
 				desc[i].flags = flags;
 
-			desc[i].addr = cpu_to_le64(addr);
+			desc[i].addr = cpu_to_le64(sg->dma_address);
 			desc[i].len = cpu_to_le32(sg->length);
 			desc[i].id = cpu_to_le16(id);
 
 			if (unlikely(vq->use_dma_api)) {
-				vq->packed.desc_extra[curr].addr = addr;
+				vq->packed.desc_extra[curr].addr = sg->dma_address;
 				vq->packed.desc_extra[curr].len = sg->length;
 				vq->packed.desc_extra[curr].flags =
 					le16_to_cpu(flags);
@@ -1545,8 +1527,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	/* Store token. */
 	vq->packed.desc_state[id].num = descs_used;
-	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
 
 	/*
@@ -1559,29 +1539,55 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->num_added += descs_used;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
-	END_USE(vq);
+}
 
-	return 0;
+static inline int virtqueue_add_packed(struct virtqueue *_vq,
+				       struct scatterlist *sgs[],
+				       unsigned int total_sg,
+				       unsigned int out_sgs,
+				       unsigned int in_sgs,
+				       void *data,
+				       void *ctx,
+				       gfp_t gfp)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_packed_desc *desc;
+	u16 id;
+	int err;
 
-unmap_release:
-	err_idx = i;
-	i = head;
-	curr = vq->free_head;
+	START_USE(vq);
 
-	vq->packed.avail_used_flags = avail_used_flags;
+	/* check vq state and try to alloc desc for indirect. */
+	err = virtqueue_add_packed_prepare(vq, total_sg, data, ctx, &desc, gfp);
+	if (err)
+		goto end;
 
-	for (n = 0; n < total_sg; n++) {
-		if (i == err_idx)
-			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
-		curr = vq->packed.desc_extra[curr].next;
-		i++;
-		if (i >= vq->packed.vring.num)
-			i = 0;
+	err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (err)
+		goto err;
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
 	}
 
+	vq->packed.desc_state[id].data = data;
+
+	goto end;
+
+err:
+	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	kfree(desc);
+
+end:
 	END_USE(vq);
-	return -EIO;
+	return err;
 }
 
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
