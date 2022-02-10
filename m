Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68089C433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 08:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9CEE400F2;
	Thu, 10 Feb 2022 08:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8aKPMRPL8Rz; Thu, 10 Feb 2022 08:51:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 39AA140127;
	Thu, 10 Feb 2022 08:51:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 020F8C0011;
	Thu, 10 Feb 2022 08:51:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35559C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F932410D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MSOU0BWYRzsZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83CDE410C1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V43X.Fa_1644483086; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V43X.Fa_1644483086) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Feb 2022 16:51:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v1 2/6] virtio: remove flags check for unmap split indirect
 desc
Date: Thu, 10 Feb 2022 16:51:20 +0800
Message-Id: <20220210085124.15466-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
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

When calling vring_unmap_one_split_indirect(), it will not encounter the
situation that the flags contains VRING_DESC_F_INDIRECT. So remove this
logic.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7cf3ae057833..fadd0a7503e9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -379,19 +379,11 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
-	if (flags & VRING_DESC_F_INDIRECT) {
-		dma_unmap_single(vring_dma_dev(vq),
-				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
-				 virtio32_to_cpu(vq->vq.vdev, desc->len),
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		dma_unmap_page(vring_dma_dev(vq),
-			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
-			       virtio32_to_cpu(vq->vq.vdev, desc->len),
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
+		       virtio32_to_cpu(vq->vq.vdev, desc->len),
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
