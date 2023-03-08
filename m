Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598CAC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D15DE40121;
	Wed,  8 Mar 2023 06:44:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D15DE40121
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6gUQnHDZO_DX; Wed,  8 Mar 2023 06:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46663400B9;
	Wed,  8 Mar 2023 06:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46663400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59306C008C;
	Wed,  8 Mar 2023 06:44:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADB0BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89F6E81E55
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89F6E81E55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0_mnf0c9ks0L
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D72781E50
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D72781E50
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VdORVtl_1678257885; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdORVtl_1678257885) by smtp.aliyun-inc.com;
 Wed, 08 Mar 2023 14:44:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v2 02/12] virtio_ring: packed: separate dma codes
Date: Wed,  8 Mar 2023 14:44:33 +0800
Message-Id: <20230308064443.50639-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: a39da90ba7d5
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

DMA-related logic is separated from the virtqueue_add_packed(). DMA
address will be saved as sg->dma_address, then virtqueue_add_packed()
will use it directly. Unmap operation will be simpler.

The purpose of this is to facilitate subsequent support to receive
dma address mapped by drivers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 37 +++++++-----------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8ace2f503953..b4beb51072f7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1419,9 +1419,9 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i, n, c, descs_used, err_idx;
+	unsigned int i, n, c, descs_used;
 	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
+	u16 head, id, prev, curr;
 	int err;
 
 	START_USE(vq);
@@ -1450,7 +1450,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	}
 
 	head = vq->packed.next_avail_idx;
-	avail_used_flags = vq->packed.avail_used_flags;
 
 	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
 
@@ -1468,15 +1467,13 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	id = vq->free_head;
 	BUG_ON(id == vq->packed.vring.num);
 
+	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
+		return -ENOMEM;
+
 	curr = id;
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
@@ -1485,12 +1482,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
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
@@ -1536,26 +1533,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	END_USE(vq);
 
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
-	END_USE(vq);
-	return -EIO;
 }
 
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
