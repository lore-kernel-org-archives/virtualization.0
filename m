Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2376C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:19:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0C660F0F
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B0C660F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4ABE080D58;
	Wed, 27 Oct 2021 06:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 57kD1XJeZ6qE; Wed, 27 Oct 2021 06:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1CAD80D8B;
	Wed, 27 Oct 2021 06:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 577A5C0023;
	Wed, 27 Oct 2021 06:19:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80945C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62B3B4013F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQmuHNJnBJU2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0ACB940109
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R661e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Utr.kIT_1635315554; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Utr.kIT_1635315554) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 14:19:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/3] virtio: cache indirect desc for packed
Date: Wed, 27 Oct 2021 14:19:12 +0800
Message-Id: <20211027061913.76276-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211027061913.76276-1-xuanzhuo@linux.alibaba.com>
References: <20211027061913.76276-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

In the case of using indirect, indirect desc must be allocated and
released each time, which increases a lot of cpu overhead.

Here, a cache is added for indirect. If the number of indirect desc to be
applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 57 +++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0b9a8544b0e8..4fd7bd5bcd70 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1074,10 +1074,45 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 	}
 }
 
-static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
+static void desc_cache_chain_free_packed(void *chain)
+{
+	struct vring_packed_desc *desc;
+
+	while (chain) {
+		desc = chain;
+		chain = (void *)desc->addr;
+		kfree(desc);
+	}
+}
+
+static void desc_cache_put_packed(struct vring_virtqueue *vq,
+				  struct vring_packed_desc *desc, int n)
+{
+	if (vq->use_desc_cache && n <= VIRT_QUEUE_CACHE_DESC_NUM) {
+		desc->addr = (u64)vq->desc_cache_chain;
+		vq->desc_cache_chain = desc;
+	} else {
+		kfree(desc);
+	}
+}
+
+static struct vring_packed_desc *alloc_indirect_packed(struct vring_virtqueue *vq,
+						       unsigned int total_sg,
 						       gfp_t gfp)
 {
 	struct vring_packed_desc *desc;
+	unsigned int n;
+
+	if (vq->use_desc_cache && total_sg <= VIRT_QUEUE_CACHE_DESC_NUM) {
+		if (vq->desc_cache_chain) {
+			desc = vq->desc_cache_chain;
+			vq->desc_cache_chain = (void *)desc->addr;
+			return desc;
+		}
+		n = VIRT_QUEUE_CACHE_DESC_NUM;
+	} else {
+		n = total_sg;
+	}
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -1086,7 +1121,7 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
+	desc = kmalloc_array(n, sizeof(struct vring_packed_desc), gfp);
 
 	return desc;
 }
@@ -1106,7 +1141,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
+	desc = alloc_indirect_packed(vq, total_sg, gfp);
 
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
@@ -1197,7 +1232,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	for (i = 0; i < err_idx; i++)
 		vring_unmap_desc_packed(vq, &desc[i]);
 
-	kfree(desc);
+	desc_cache_put_packed(vq, desc, total_sg);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -1422,20 +1457,22 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	}
 
 	if (vq->indirect) {
-		u32 len;
+		u32 len, n;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		desc = state->indir_desc;
 		if (!desc)
 			return;
 
+		n = len / sizeof(struct vring_packed_desc);
+
 		if (vq->use_dma_api) {
 			len = vq->packed.desc_extra[id].len;
-			for (i = 0; i < len / sizeof(struct vring_packed_desc);
-					i++)
+			for (i = 0; i < n; i++)
 				vring_unmap_desc_packed(vq, &desc[i]);
 		}
-		kfree(desc);
+
+		desc_cache_put_packed(vq, desc, n);
 		state->indir_desc = NULL;
 	} else if (ctx) {
 		*ctx = state->indir_desc;
@@ -1753,6 +1790,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+	vq->desc_cache_chain = NULL;
+	vq->use_desc_cache = vdev->desc_cache;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
@@ -2374,6 +2413,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
 		desc_cache_chain_free_split(vq->desc_cache_chain);
+	} else {
+		desc_cache_chain_free_packed(vq->desc_cache_chain);
 	}
 	kfree(vq);
 }
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
