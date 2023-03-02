Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97E6C7EE33
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D68D8204D;
	Thu,  2 Mar 2023 11:59:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D68D8204D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqG_PCPRvEE9; Thu,  2 Mar 2023 11:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B16F81FA4;
	Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B16F81FA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B10EC0091;
	Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00B37C0035
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEFF8408B3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEFF8408B3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H8gE-U4vDItC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 513A940988
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 513A940988
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxMh4Z_1677758353; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxMh4Z_1677758353) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 06/12] virtio_ring: packed: separate DMA codes
Date: Thu,  2 Mar 2023 19:59:02 +0800
Message-Id: <20230302115908.1461-7-xuanzhuo@linux.alibaba.com>
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

DMA-related logic is separated from the virtqueue_add_vring_packed() to
prepare for subsequent support for premapped.

DMA address will be saved as sg->dma_address, then
virtqueue_add_vring_packed() will use it directly.

If it is a premapped scene, the transmitted sgs should have saved DMA
address in dma_address, and in virtio core, we need to pass
virtqueue_map_sgs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 59 ++++++++----------------------------
 1 file changed, 12 insertions(+), 47 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6796cbee0207..81a9c0692fec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1350,7 +1350,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 struct vring_packed_desc *desc)
 {
 	struct scatterlist *sg;
-	unsigned int i, n, err_idx;
+	unsigned int i, n;
 	u16 head, id;
 	dma_addr_t addr;
 
@@ -1362,14 +1362,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
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
@@ -1380,7 +1375,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			total_sg * sizeof(struct vring_packed_desc),
 			DMA_TO_DEVICE);
 	if (vring_mapping_error(vq, addr))
-		goto unmap_release;
+		return -ENOMEM;
 
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
 	vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
@@ -1429,16 +1424,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 
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
-	return -ENOMEM;
 }
 
 static inline struct vring_packed_desc *virtqueue_get_desc_packed(struct vring_virtqueue *vq,
@@ -1498,15 +1483,14 @@ static inline int virtqueue_add_vring_packed(struct vring_virtqueue *vq,
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i, n, c, descs_used, err_idx;
+	unsigned int i, n, c, descs_used;
 	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
+	u16 head, id, prev, curr;
 
 	desc = vq->packed.vring.desc;
 	head = vq->packed.next_avail_idx;
 	i = head;
 	descs_used = total_sg;
-	avail_used_flags = vq->packed.avail_used_flags;
 
 	id = vq->free_head;
 	BUG_ON(id == vq->packed.vring.num);
@@ -1515,11 +1499,6 @@ static inline int virtqueue_add_vring_packed(struct vring_virtqueue *vq,
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
@@ -1528,12 +1507,12 @@ static inline int virtqueue_add_vring_packed(struct vring_virtqueue *vq,
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
@@ -1576,25 +1555,6 @@ static inline int virtqueue_add_vring_packed(struct vring_virtqueue *vq,
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 
 	return 0;
-
-unmap_release:
-	err_idx = i;
-	i = head;
-	curr = vq->free_head;
-
-	vq->packed.avail_used_flags = avail_used_flags;
-
-	for (n = 0; n < total_sg; n++) {
-		if (i == err_idx)
-			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
-		curr = vq->packed.desc_extra[curr].next;
-		i++;
-		if (i >= vq->packed.vring.num)
-			i = 0;
-	}
-
-	return -EIO;
 }
 
 static inline int virtqueue_add_packed(struct virtqueue *_vq,
@@ -1621,6 +1581,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		goto end;
 	}
 
+	err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (err)
+		goto err;
+
 	id = vq->free_head;
 
 	if (desc) {
@@ -1637,6 +1601,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	goto end;
 
 err:
+	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
 	kfree(desc);
 
 end:
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
