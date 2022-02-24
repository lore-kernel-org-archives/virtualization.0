Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8118CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 11:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FE5C409D7;
	Thu, 24 Feb 2022 11:04:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SWnxjrLQelR; Thu, 24 Feb 2022 11:04:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 579E240527;
	Thu, 24 Feb 2022 11:04:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 297B4C0072;
	Thu, 24 Feb 2022 11:04:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEC59C0035
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF95D408F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NW0qbIC6GIBh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E74BE41675
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V5Nr1rK_1645700645; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5Nr1rK_1645700645) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 19:04:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 3/9] virtio_ring: remove flags check for unmap packed
 indirect desc
Date: Thu, 24 Feb 2022 19:03:56 +0800
Message-Id: <20220224110402.108161-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d02e086a8668
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

When calling vring_unmap_desc_packed(), it will not encounter the
situation that the flags contains VRING_DESC_F_INDIRECT. So remove this
logic.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fadd0a7503e9..cfb028ca238e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1009,19 +1009,11 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 
 	flags = le16_to_cpu(desc->flags);
 
-	if (flags & VRING_DESC_F_INDIRECT) {
-		dma_unmap_single(vring_dma_dev(vq),
-				 le64_to_cpu(desc->addr),
-				 le32_to_cpu(desc->len),
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		dma_unmap_page(vring_dma_dev(vq),
-			       le64_to_cpu(desc->addr),
-			       le32_to_cpu(desc->len),
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       le64_to_cpu(desc->addr),
+		       le32_to_cpu(desc->len),
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
