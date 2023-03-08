Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47FBC6FD1E
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0D1261114;
	Wed,  8 Mar 2023 06:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0D1261114
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SgGiiltTZ4D; Wed,  8 Mar 2023 06:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 29EBB61102;
	Wed,  8 Mar 2023 06:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29EBB61102
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D685C0091;
	Wed,  8 Mar 2023 06:44:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F5FC0071
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 231F44038E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 231F44038E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFcpdN2vka-j
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEA84400B9
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEA84400B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R681e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VdOOYPw_1678257887; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdOOYPw_1678257887) by smtp.aliyun-inc.com;
 Wed, 08 Mar 2023 14:44:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v2 04/12] virtio_ring: split: support premapped
Date: Wed,  8 Mar 2023 14:44:35 +0800
Message-Id: <20230308064443.50639-5-xuanzhuo@linux.alibaba.com>
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

virtio core only supports virtual addresses, dma is completed in virtio
core.

In some scenarios (such as the AF_XDP), the memory is allocated
and DMA is completed in advance, so it is necessary for us to support
passing the DMA address to virtio core.

Drives can use sg->dma_address to pass the mapped dma address to virtio
core. If one sg->dma_address is used then all sgs must use sg->
dma_address, otherwise all dma_address must be null.

On the non-indirect path, if dma_address is used, extra.addr will be
set to DMA_MAPPING_ERROR. So when do unmap, we can pass it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 221ff54fe58b..61deaf0a4faf 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -457,6 +457,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (extra[i].addr == DMA_MAPPING_ERROR)
+			goto out;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra[i].addr,
 			       extra[i].len,
@@ -497,7 +500,8 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    dma_addr_t addr,
 						    unsigned int len,
 						    u16 flags,
-						    bool indirect)
+						    bool indirect,
+						    bool do_map)
 {
 	struct vring_virtqueue *vring = to_vvq(vq);
 	struct vring_desc_extra *extra = vring->split.desc_extra;
@@ -511,7 +515,7 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 		next = extra[i].next;
 		desc[i].next = cpu_to_virtio16(vq->vdev, next);
 
-		extra[i].addr = addr;
+		extra[i].addr = do_map ? addr : DMA_MAPPING_ERROR;
 		extra[i].len = len;
 		extra[i].flags = flags;
 	} else
@@ -604,7 +608,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev;
-	bool indirect;
+	bool indirect, do_map;
 	int head;
 
 	START_USE(vq);
@@ -657,7 +661,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		return -ENOSPC;
 	}
 
-	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
+	do_map = !sgs[0]->dma_address;
+	if (do_map && virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
 		return -ENOMEM;
 
 	for (n = 0; n < out_sgs; n++) {
@@ -670,7 +675,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     sg->dma_address,
 						     sg->length,
 						     VRING_DESC_F_NEXT,
-						     indirect);
+						     indirect, do_map);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -684,7 +689,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
-						     indirect);
+						     indirect, do_map);
 		}
 	}
 	/* Last one doesn't continue. */
@@ -705,7 +710,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 					 head, addr,
 					 total_sg * sizeof(struct vring_desc),
 					 VRING_DESC_F_INDIRECT,
-					 false);
+					 false, true);
 	}
 
 	/* We're using some buffers from the free list. */
@@ -748,7 +753,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
-	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (do_map)
+		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
 
 	if (indirect)
 		kfree(desc);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
