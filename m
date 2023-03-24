Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F76DC76195
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC7BB84115;
	Fri, 24 Mar 2023 06:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC7BB84115
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8oD58wosydK6; Fri, 24 Mar 2023 06:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1901E8215A;
	Fri, 24 Mar 2023 06:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1901E8215A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4B36C0089;
	Fri, 24 Mar 2023 06:30:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65189C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3334560E28
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3334560E28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jY5rOPJcobiP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 854D660E24
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 854D660E24
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeWd0F3_1679639413; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeWd0F3_1679639413) by smtp.aliyun-inc.com;
 Fri, 24 Mar 2023 14:30:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v5 04/11] virtio_ring: split: support premapped
Date: Fri, 24 Mar 2023 14:30:03 +0800
Message-Id: <20230324063010.48670-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
References: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 4338850ae009
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

virtio core only supports virtual addresses, dma is completed in virtio
core.

In some scenarios (such as the AF_XDP), the memory is allocated
and DMA mapping is completed in advance, so it is necessary for us to
support passing the DMA address to virtio core.

Drives can use sg->dma_address to pass the mapped dma address to virtio
core. If one sg->dma_address is used then all sgs must use
sg->dma_address, otherwise all must be null when passing it to the APIs
of virtio.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3ada30b475d2..1c3084a8f4e3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -67,9 +67,12 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
+#define VRING_STATE_F_MAP_INTERNAL BIT(0)
+
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	u64 flags;			/* State flags. */
 };
 
 struct vring_desc_state_packed {
@@ -448,7 +451,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 }
 
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  unsigned int i, bool dma_map_internal)
 {
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
@@ -465,6 +468,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (!dma_map_internal)
+			goto out;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra[i].addr,
 			       extra[i].len,
@@ -615,7 +621,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev;
-	bool indirect;
+	bool indirect, dma_map_internal;
 	int head;
 
 	START_USE(vq);
@@ -668,7 +674,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		return -ENOSPC;
 	}
 
-	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
+	dma_map_internal = !sgs[0]->dma_address;
+	if (dma_map_internal && virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
 		goto err_map;
 
 	for (n = 0; n < out_sgs; n++) {
@@ -735,6 +742,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	else
 		vq->split.desc_state[head].indir_desc = ctx;
 
+	vq->split.desc_state[head].flags = dma_map_internal ? VRING_STATE_F_MAP_INTERNAL : 0;
+
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
@@ -759,7 +768,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
-	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (dma_map_internal)
+		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
 
 err_map:
 	if (indirect)
@@ -805,20 +815,22 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	bool dma_map_internal;
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
+	dma_map_internal = !!(vq->split.desc_state[head].flags & VRING_STATE_F_MAP_INTERNAL);
 
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, dma_map_internal);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, dma_map_internal);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -840,8 +852,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		for (j = 0; j < len / sizeof(struct vring_desc); j++)
-			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+		if (dma_map_internal) {
+			for (j = 0; j < len / sizeof(struct vring_desc); j++)
+				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+		}
 
 		kfree(indir_desc);
 		vq->split.desc_state[head].indir_desc = NULL;
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
