Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C861C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D32E5419E4;
	Thu,  2 Feb 2023 11:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D32E5419E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95JLrbsabB-Z; Thu,  2 Feb 2023 11:01:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE75741B82;
	Thu,  2 Feb 2023 11:01:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE75741B82
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4F65C0032;
	Thu,  2 Feb 2023 11:01:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65006C007D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32B8B81F12
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32B8B81F12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VcMd_oyONpeJ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9D9481F14
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9D9481F14
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R301e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VakkM2s_1675335670; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VakkM2s_1675335670) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 10/33] xsk: support virtio DMA map
Date: Thu,  2 Feb 2023 19:00:35 +0800
Message-Id: <20230202110058.130695-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d7589ab6ea10
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

When device is a virtio device, use virtio's DMA interface.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 net/xdp/xsk_buff_pool.c | 59 +++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 78e325e195fa..e2785aca8396 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -3,6 +3,7 @@
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/virtio.h>
 
 #include "xsk_queue.h"
 #include "xdp_umem.h"
@@ -334,8 +335,12 @@ static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
 		dma = &dma_map->dma_pages[i];
 		if (*dma) {
 			*dma &= ~XSK_NEXT_PG_CONTIG_MASK;
-			dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
-					     DMA_BIDIRECTIONAL, attrs);
+			if (is_virtio_device(dma_map->dev))
+				virtio_dma_unmap(dma_map->dev, *dma, PAGE_SIZE,
+						 DMA_BIDIRECTIONAL);
+			else
+				dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
+						     DMA_BIDIRECTIONAL, attrs);
 			*dma = 0;
 		}
 	}
@@ -435,22 +440,40 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 		return 0;
 	}
 
-	pool->dma_sync_for_cpu = dma_sync_for_cpu;
-	pool->dma_sync_for_device = dma_sync_for_device;
+	if (is_virtio_device(dev)) {
+		pool->dma_sync_for_cpu = virtio_dma_sync_signle_range_for_cpu;
+		pool->dma_sync_for_device = virtio_dma_sync_signle_range_for_device;
+
+	} else {
+		pool->dma_sync_for_cpu = dma_sync_for_cpu;
+		pool->dma_sync_for_device = dma_sync_for_device;
+	}
 
 	dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem);
 	if (!dma_map)
 		return -ENOMEM;
 
 	for (i = 0; i < dma_map->dma_pages_cnt; i++) {
-		dma = dma_map_page_attrs(dev, pages[i], 0, PAGE_SIZE,
-					 DMA_BIDIRECTIONAL, attrs);
-		if (dma_mapping_error(dev, dma)) {
-			__xp_dma_unmap(dma_map, attrs);
-			return -ENOMEM;
+		if (is_virtio_device(dev)) {
+			dma = virtio_dma_map_page(dev, pages[i], 0, PAGE_SIZE,
+						  DMA_BIDIRECTIONAL);
+
+			if (virtio_dma_mapping_error(dev, dma))
+				goto err;
+
+			if (virtio_dma_need_sync(dev, dma))
+				dma_map->dma_need_sync = true;
+
+		} else {
+			dma = dma_map_page_attrs(dev, pages[i], 0, PAGE_SIZE,
+						 DMA_BIDIRECTIONAL, attrs);
+
+			if (dma_mapping_error(dev, dma))
+				goto err;
+
+			if (dma_need_sync(dev, dma))
+				dma_map->dma_need_sync = true;
 		}
-		if (dma_need_sync(dev, dma))
-			dma_map->dma_need_sync = true;
 		dma_map->dma_pages[i] = dma;
 	}
 
@@ -464,6 +487,9 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 	}
 
 	return 0;
+err:
+	__xp_dma_unmap(dma_map, attrs);
+	return -ENOMEM;
 }
 EXPORT_SYMBOL(xp_dma_map);
 
@@ -546,9 +572,14 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 	xskb->xdp.data_meta = xskb->xdp.data;
 
 	if (pool->dma_need_sync) {
-		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
-						 pool->frame_len,
-						 DMA_BIDIRECTIONAL);
+		if (is_virtio_device(pool->dev))
+			virtio_dma_sync_signle_range_for_device(pool->dev, xskb->dma, 0,
+								pool->frame_len,
+								DMA_BIDIRECTIONAL);
+		else
+			dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
+							 pool->frame_len,
+							 DMA_BIDIRECTIONAL);
 	}
 	return &xskb->xdp;
 }
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
