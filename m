Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C1BC05027
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 07:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E82AB40AE7;
	Tue, 14 Feb 2023 07:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E82AB40AE7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r02wrrDektuG; Tue, 14 Feb 2023 07:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CA5540AA3;
	Tue, 14 Feb 2023 07:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CA5540AA3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11DE9C0033;
	Tue, 14 Feb 2023 07:27:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AAFBC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35DB681E1F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35DB681E1F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-5cV4wZpVLH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F8EB81E18
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F8EB81E18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vbeojgm_1676359625; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vbeojgm_1676359625) by smtp.aliyun-inc.com;
 Tue, 14 Feb 2023 15:27:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 01/10] virtio_ring: split: refactor
 virtqueue_add_split() for premapped
Date: Tue, 14 Feb 2023 15:26:55 +0800
Message-Id: <20230214072704.126660-2-xuanzhuo@linux.alibaba.com>
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

DMA-related logic is separated from the virtqueue_add_split to prepare
for subsequent support for premapped.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 219 ++++++++++++++++++++++++-----------
 1 file changed, 152 insertions(+), 67 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 41144b5246a8..560ee30d942c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -520,29 +520,83 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	return next;
 }
 
-static inline int virtqueue_add_split(struct virtqueue *_vq,
-				      struct scatterlist *sgs[],
-				      unsigned int total_sg,
-				      unsigned int out_sgs,
-				      unsigned int in_sgs,
-				      void *data,
-				      void *ctx,
-				      gfp_t gfp)
+static int virtqueue_map_sgs(struct vring_virtqueue *vq,
+			     struct scatterlist *sgs[],
+			     unsigned int total_sg,
+			     unsigned int out_sgs,
+			     unsigned int in_sgs)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
-	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
-	int head;
-	bool indirect;
+	unsigned int n;
 
-	START_USE(vq);
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
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			if (!sg->dma_address)
+				return;
+
+			dma_unmap_single(vring_dma_dev(vq), sg->dma_address,
+					 sg->length, DMA_TO_DEVICE);
+		}
+	}
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			if (!sg->dma_address)
+				return;
+
+			dma_unmap_single(vring_dma_dev(vq), sg->dma_address,
+					 sg->length, DMA_FROM_DEVICE);
+		}
+	}
+}
+
+static inline int virtqueue_add_split_prepare(struct vring_virtqueue *vq,
+					      unsigned int total_sg,
+					      unsigned int out_sgs,
+					      void *data,
+					      void *ctx,
+					      gfp_t gfp,
+					      struct vring_desc **pdesc)
+{
+	struct vring_desc *desc;
+	unsigned int descs_used;
 
 	BUG_ON(data == NULL);
 	BUG_ON(ctx && vq->indirect);
 
 	if (unlikely(vq->broken)) {
-		END_USE(vq);
 		return -EIO;
 	}
 
@@ -550,27 +604,17 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	BUG_ON(total_sg == 0);
 
-	head = vq->free_head;
-
 	if (virtqueue_use_indirect(vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
+		desc = alloc_indirect_split(&vq->vq, total_sg, gfp);
 	else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
 	}
 
-	if (desc) {
-		/* Use a single buffer which doesn't continue */
-		indirect = true;
-		/* Set up rest to use this indirect table. */
-		i = 0;
+	if (desc)
 		descs_used = 1;
-	} else {
-		indirect = false;
-		desc = vq->split.vring.desc;
-		i = head;
+	else
 		descs_used = total_sg;
-	}
 
 	if (unlikely(vq->vq.num_free < descs_used)) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
@@ -580,38 +624,64 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		 * host should service the ring ASAP. */
 		if (out_sgs)
 			vq->notify(&vq->vq);
-		if (indirect)
-			kfree(desc);
-		END_USE(vq);
+		kfree(desc);
 		return -ENOSPC;
 	}
 
+	*pdesc = desc;
+
+	return 0;
+}
+
+static inline int virtqueue_add_split_vring(struct vring_virtqueue *vq,
+					    struct scatterlist *sgs[],
+					    unsigned int total_sg,
+					    unsigned int out_sgs,
+					    unsigned int in_sgs,
+					    struct vring_desc *desc)
+{
+	unsigned int n, i, avail, descs_used, prev;
+	struct virtqueue *_vq = &vq->vq;
+	struct scatterlist *sg;
+	bool indirect;
+	int head;
+
+	head = vq->free_head;
+
+	if (desc) {
+		/* Use a single buffer which doesn't continue */
+		indirect = true;
+		/* Set up rest to use this indirect table. */
+		i = 0;
+		descs_used = 1;
+	} else {
+		indirect = false;
+		desc = vq->split.vring.desc;
+		i = head;
+		descs_used = total_sg;
+	}
+
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
@@ -630,7 +700,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
 		if (vring_mapping_error(vq, addr))
-			goto unmap_release;
+			return -ENOMEM;
 
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
 					 head, addr,
@@ -648,13 +718,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	else
 		vq->free_head = i;
 
-	/* Store token and indirect buffer state. */
-	vq->split.desc_state[head].data = data;
-	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
-	else
-		vq->split.desc_state[head].indir_desc = ctx;
-
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
@@ -677,30 +740,52 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		virtqueue_kick(_vq);
 
 	return 0;
+}
 
-unmap_release:
-	err_idx = i;
+static inline int virtqueue_add_split(struct virtqueue *_vq,
+				      struct scatterlist *sgs[],
+				      unsigned int total_sg,
+				      unsigned int out_sgs,
+				      unsigned int in_sgs,
+				      void *data,
+				      void *ctx,
+				      gfp_t gfp)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_desc *desc;
+	int head;
+	int err;
 
-	if (indirect)
-		i = 0;
-	else
-		i = head;
+	START_USE(vq);
 
-	for (n = 0; n < total_sg; n++) {
-		if (i == err_idx)
-			break;
-		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
-			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
-		} else
-			i = vring_unmap_one_split(vq, i);
-	}
+	/* check vq state and try to alloc desc for indirect. */
+	err = virtqueue_add_split_prepare(vq, total_sg, out_sgs, data, ctx, gfp, &desc);
+	if (err)
+		goto end;
 
-	if (indirect)
-		kfree(desc);
+	err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (err)
+		goto err;
 
+	head = vq->free_head;
+	err = virtqueue_add_split_vring(vq, sgs, total_sg, out_sgs, in_sgs, desc);
+	if (err)
+		goto err;
+
+	/* Store token and indirect buffer state. */
+	vq->split.desc_state[head].data = data;
+	vq->split.desc_state[head].indir_desc = desc ? desc : ctx;
+
+	goto end;
+
+err:
+	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+
+	kfree(desc);
+
+end:
 	END_USE(vq);
-	return -ENOMEM;
+	return err;
 }
 
 static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
