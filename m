Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A097BC4332F
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 06:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 360854296F;
	Fri,  7 Jan 2022 06:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Ruv3i9Hh-eV; Fri,  7 Jan 2022 06:33:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D05CB42958;
	Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE54C006F;
	Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC267C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E0E542958
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jv-0usPmly95
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 667EE42940
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V19LP-k_1641537189; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V19LP-k_1641537189) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 07 Jan 2022 14:33:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 4/6] virtio: split: virtqueue_add_split() support dma address
Date: Fri,  7 Jan 2022 14:33:04 +0800
Message-Id: <20220107063306.23240-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
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

virtqueue_add_split() only supports virtual addresses, dma is completed
in virtqueue_add_split().

In some scenarios (such as the AF_XDP scenario), the memory is allocated
and DMA is completed in advance, so it is necessary for us to support
passing the DMA address to virtqueue_add_split().

This patch stipulates that if sg->dma_address is not NULL, use this
address as the DMA address. And record this information in extra->flags,
which can be skipped when executing dma unmap.

    extra->flags |= VRING_DESC_F_PREDMA;

This relies on the previous patch, in the indirect scenario, for each
desc allocated, an extra is allocated at the same time.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7420741cb750..add8430d9678 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -66,6 +66,9 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
+/* This means the buffer dma is pre-alloc. Just used by vring_desc_extra */
+#define VRING_DESC_F_PREDMA	(1 << 15)
+
 struct vring_desc_extra {
 	dma_addr_t addr;		/* Descriptor DMA addr. */
 	u32 len;			/* Descriptor length. */
@@ -336,11 +339,19 @@ static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 	return vq->vq.vdev->dev.parent;
 }
 
+static inline bool sg_is_predma(struct scatterlist *sg)
+{
+	return !!sg->dma_address;
+}
+
 /* Map one sg entry. */
 static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 				   struct scatterlist *sg,
 				   enum dma_data_direction direction)
 {
+	if (sg_is_predma(sg))
+		return sg_dma_address(sg);
+
 	if (!vq->use_dma_api)
 		return (dma_addr_t)sg_phys(sg);
 
@@ -396,6 +407,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (flags & VRING_DESC_F_PREDMA)
+			goto out;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr,
 			       extra->len,
@@ -441,7 +455,8 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    unsigned int i,
 						    dma_addr_t addr,
 						    unsigned int len,
-						    u16 flags)
+						    u16 flags,
+						    bool predma)
 {
 	struct vring_virtqueue *vring = to_vvq(vq);
 	struct vring_desc_extra *extra;
@@ -468,6 +483,9 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	extra->len = len;
 	extra->flags = flags;
 
+	if (predma)
+		extra->flags |= VRING_DESC_F_PREDMA;
+
 	return next;
 }
 
@@ -547,7 +565,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			 * table since it use stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(_vq, in, i, addr, sg->length,
-						     VRING_DESC_F_NEXT);
+						     VRING_DESC_F_NEXT,
+						     sg_is_predma(sg));
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -563,7 +582,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			i = virtqueue_add_desc_split(_vq, in, i, addr,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE);
+						     VRING_DESC_F_WRITE,
+						     sg_is_predma(sg));
 		}
 	}
 	/* Last one doesn't continue. */
@@ -582,7 +602,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 		virtqueue_add_desc_split(_vq, NULL, head, addr,
 					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT);
+					 VRING_DESC_F_INDIRECT, false);
 	}
 
 	/* We're using some buffers from the free list. */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
