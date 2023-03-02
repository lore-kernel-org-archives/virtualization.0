Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D24C6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56EA66120F;
	Thu,  2 Mar 2023 11:59:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56EA66120F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Y1qU7JcLOZG; Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AEB1261162;
	Thu,  2 Mar 2023 11:59:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEB1261162
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0426C008E;
	Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1656CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C1B140FD1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C1B140FD1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f7CSSKKhDKlu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C883B40CB1
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C883B40CB1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxMh2B_1677758350; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxMh2B_1677758350) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 02/12] virtio_ring: split: separate DMA codes
Date: Thu,  2 Mar 2023 19:58:58 +0800
Message-Id: <20230302115908.1461-3-xuanzhuo@linux.alibaba.com>
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

DMA-related logic is separated from the virtqueue_add_vring_split() to
prepare for subsequent support for premapped.

DMA address will be saved as sg->dma_address, then
virtqueue_add_vring_split() will use it directly.

If it is a premapped scene, the transmitted sgs should have saved DMA
address in dma_address, and in virtio core, we need to pass
virtqueue_map_sgs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 116 ++++++++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 36 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3005893ecc61..17520f0d7649 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -520,6 +520,73 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	return next;
 }
 
+static int virtqueue_map_sgs(struct vring_virtqueue *vq,
+			     struct scatterlist *sgs[],
+			     unsigned int total_sg,
+			     unsigned int out_sgs,
+			     unsigned int in_sgs)
+{
+	struct scatterlist *sg;
+	unsigned int n;
+
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
+
+			if (vring_mapping_error(vq, addr))
+				return -ENOMEM;
+
+			sg->dma_address = addr;
+		}
+	}
+
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
+
+			if (vring_mapping_error(vq, addr))
+				return -ENOMEM;
+
+			sg->dma_address = addr;
+		}
+	}
+
+	return 0;
+}
+
+static void virtqueue_unmap_sgs(struct vring_virtqueue *vq,
+				struct scatterlist *sgs[],
+				unsigned int total_sg,
+				unsigned int out_sgs,
+				unsigned int in_sgs)
+{
+	struct scatterlist *sg;
+	unsigned int n;
+
+	if (!vq->use_dma_api)
+		return;
+
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			if (!sg->dma_address)
+				return;
+
+			dma_unmap_page(vring_dma_dev(vq), sg->dma_address,
+				       sg->length, DMA_TO_DEVICE);
+		}
+	}
+
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			if (!sg->dma_address)
+				return;
+
+			dma_unmap_page(vring_dma_dev(vq), sg->dma_address,
+				       sg->length, DMA_FROM_DEVICE);
+		}
+	}
+}
+
 /* note: return NULL means no indirect that is valid. */
 static struct vring_desc *virtqueue_get_desc_split(struct vring_virtqueue *vq,
 						   unsigned int total_sg,
@@ -577,7 +644,7 @@ static inline int virtqueue_add_vring_split(struct vring_virtqueue *vq,
 {
 	struct virtqueue *_vq = &vq->vq;
 	struct scatterlist *sg;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, prev;
 	int head;
 	bool indirect;
 
@@ -598,30 +665,25 @@ static inline int virtqueue_add_vring_split(struct vring_virtqueue *vq,
 
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
-
 			prev = i;
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr, sg->length,
+			i = virtqueue_add_desc_split(_vq, desc, i,
+						     sg->dma_address,
+						     sg->length,
 						     VRING_DESC_F_NEXT,
 						     indirect);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
-
 			prev = i;
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr,
+			i = virtqueue_add_desc_split(_vq, desc, i,
+						     sg->dma_address,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
@@ -640,7 +702,7 @@ static inline int virtqueue_add_vring_split(struct vring_virtqueue *vq,
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
 		if (vring_mapping_error(vq, addr))
-			goto unmap_release;
+			return -ENOMEM;
 
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
 					 head, addr,
@@ -680,30 +742,6 @@ static inline int virtqueue_add_vring_split(struct vring_virtqueue *vq,
 		virtqueue_kick(_vq);
 
 	return 0;
-
-unmap_release:
-	err_idx = i;
-
-	if (indirect)
-		i = 0;
-	else
-		i = head;
-
-	for (n = 0; n < total_sg; n++) {
-		if (i == err_idx)
-			break;
-		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
-			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
-		} else
-			i = vring_unmap_one_split(vq, i);
-	}
-
-	if (indirect)
-		kfree(desc);
-
-	END_USE(vq);
-	return -ENOMEM;
 }
 
 static inline int virtqueue_add_split(struct virtqueue *_vq,
@@ -729,6 +767,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		goto end;
 	}
 
+	err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (err)
+		goto err;
+
 	head = vq->free_head;
 	err = virtqueue_add_vring_split(vq, sgs, total_sg, out_sgs, in_sgs, desc);
 	if (err)
@@ -741,6 +783,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	goto end;
 
 err:
+	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+
 	kfree(desc);
 
 end:
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
