Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DA5E80A8C
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 05:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF50D828A9;
	Wed, 27 Sep 2023 05:52:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF50D828A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oQquu8nVbBPi; Wed, 27 Sep 2023 05:52:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 803628289B;
	Wed, 27 Sep 2023 05:52:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 803628289B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55AF0C0071;
	Wed, 27 Sep 2023 05:52:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1040C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 05:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8175E828A9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 05:52:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8175E828A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nMczQi1oq7YD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 05:52:55 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A584B8289B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 05:52:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A584B8289B
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VszCD.b_1695793966; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VszCD.b_1695793966) by smtp.aliyun-inc.com;
 Wed, 27 Sep 2023 13:52:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost] virtio_net: fix the missing of the dma cpu sync
Date: Wed, 27 Sep 2023 13:52:46 +0800
Message-Id: <20230927055246.121544-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: c5d9aae29ad9
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Michael Roth <michael.roth@amd.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

Commit 295525e29a5b ("virtio_net: merge dma operations when filling
mergeable buffers") unmaps the buffer with DMA_ATTR_SKIP_CPU_SYNC when
the dma->ref is zero. We do that with DMA_ATTR_SKIP_CPU_SYNC, because we
do not want to do the sync for the entire page_frag. But that misses the
sync for the current area.

This patch does cpu sync regardless of whether the ref is zero or not.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Reported-by: Michael Roth <michael.roth@amd.com>
Closes: http://lore.kernel.org/all/20230926130451.axgodaa6tvwqs3ut@amd.com
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 98dc9b49d56b..9ece27dc5144 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -589,16 +589,16 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 
 	--dma->ref;
 
-	if (dma->ref) {
-		if (dma->need_sync && len) {
-			offset = buf - (head + sizeof(*dma));
+	if (dma->need_sync && len) {
+		offset = buf - (head + sizeof(*dma));
 
-			virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr, offset,
-								len, DMA_FROM_DEVICE);
-		}
+		virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr,
+							offset, len,
+							DMA_FROM_DEVICE);
+	}
 
+	if (dma->ref)
 		return;
-	}
 
 	virtqueue_dma_unmap_single_attrs(rq->vq, dma->addr, dma->len,
 					 DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
