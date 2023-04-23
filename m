Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D936C77B76
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 06:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 887FA821A6;
	Sun, 23 Apr 2023 06:25:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 887FA821A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hY03l1y8yCC0; Sun, 23 Apr 2023 06:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD445820E7;
	Sun, 23 Apr 2023 06:25:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD445820E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F1F5C0037;
	Sun, 23 Apr 2023 06:25:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51AEFC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A6E1417C0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:25:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A6E1417C0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5awgqF0BCmFo
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:25:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CD724170E
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CD724170E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:25:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0VgicXij_1682231146; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgicXij_1682231146) by smtp.aliyun-inc.com;
 Sun, 23 Apr 2023 14:25:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v1] xsk: introduce xsk_dma_cbs
Date: Sun, 23 Apr 2023 14:25:45 +0800
Message-Id: <20230423062546.96880-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 01b328918880
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Eric Dumazet <edumazet@google.com>, Guenter Roeck <linux@roeck-us.net>,
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

The purpose of this patch is to allow driver pass the own dma callbacks
to xsk.

This is to cope with the scene of virtio-net. If virtio does not have
VIRTIO_F_ACCESS_PLATFORM, then virtio cannot use DMA API. In this case,
xsk cannot use DMA API directly to achieve DMA address. Based on this
scene, we must let xsk support driver to use the driver's dma callbacks.

More is here:
    https://lore.kernel.org/virtualization/1681265026.6082013-1-xuanzhuo@linux.alibaba.com/
    https://lore.kernel.org/all/20230421065059.1bc78133@kernel.org

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/net/xdp_sock_drv.h  | 20 ++++++++++-
 include/net/xsk_buff_pool.h | 19 ++++++++++
 net/xdp/xsk_buff_pool.c     | 71 +++++++++++++++++++++++++++----------
 3 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 9c0d860609ba..8b5284b272e4 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -67,7 +67,17 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
 {
 	struct xdp_umem *umem = pool->umem;
 
-	return xp_dma_map(pool, dev, attrs, umem->pgs, umem->npgs);
+	return xp_dma_map(pool, dev, NULL, attrs, umem->pgs, umem->npgs);
+}
+
+static inline int xsk_pool_dma_map_with_cbs(struct xsk_buff_pool *pool,
+					    struct device *dev,
+					    struct xsk_dma_cbs *dma_cbs,
+					    unsigned long attrs)
+{
+	struct xdp_umem *umem = pool->umem;
+
+	return xp_dma_map(pool, dev, dma_cbs, attrs, umem->pgs, umem->npgs);
 }
 
 static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
@@ -226,6 +236,14 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
 	return 0;
 }
 
+static inline int xsk_pool_dma_map_with_cbs(struct xsk_buff_pool *pool,
+					    struct device *dev,
+					    struct xsk_dma_cbs *dma_cbs,
+					    unsigned long attrs)
+{
+	return 0;
+}
+
 static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
 {
 	return 0;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 3e952e569418..2de88be9188b 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -43,6 +43,23 @@ struct xsk_dma_map {
 	bool dma_need_sync;
 };
 
+struct xsk_dma_cbs {
+	dma_addr_t (*map_page)(struct device *dev, struct page *page,
+			       size_t offset, size_t size,
+			       enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_page)(struct device *dev, dma_addr_t addr,
+			   size_t size, enum dma_data_direction dir,
+			   unsigned long attrs);
+	int (*mapping_error)(struct device *dev, dma_addr_t addr);
+	bool (*need_sync)(struct device *dev, dma_addr_t addr);
+	void (*sync_single_range_for_cpu)(struct device *dev, dma_addr_t addr,
+					  size_t offset, size_t size,
+					  enum dma_data_direction dir);
+	void (*sync_single_range_for_device)(struct device *dev, dma_addr_t addr,
+					     size_t offset, size_t size,
+					     enum dma_data_direction dir);
+};
+
 struct xsk_buff_pool {
 	/* Members only used in the control path first. */
 	struct device *dev;
@@ -85,6 +102,7 @@ struct xsk_buff_pool {
 	 * sockets share a single cq when the same netdev and queue id is shared.
 	 */
 	spinlock_t cq_lock;
+	struct xsk_dma_cbs *dma_cbs;
 	struct xdp_buff_xsk *free_heads[];
 };
 
@@ -131,6 +149,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
 /* AF_XDP ZC drivers, via xdp_sock_buff.h */
 void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
+	       struct xsk_dma_cbs *dma_cbs,
 	       unsigned long attrs, struct page **pages, u32 nr_pages);
 void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
 struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index b2df1e0f8153..e7e6c91f6e51 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -328,7 +328,8 @@ static void xp_destroy_dma_map(struct xsk_dma_map *dma_map)
 	kfree(dma_map);
 }
 
-static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
+static void __xp_dma_unmap(struct xsk_dma_map *dma_map,
+			   struct xsk_dma_cbs *dma_cbs, unsigned long attrs)
 {
 	dma_addr_t *dma;
 	u32 i;
@@ -337,8 +338,12 @@ static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
 		dma = &dma_map->dma_pages[i];
 		if (*dma) {
 			*dma &= ~XSK_NEXT_PG_CONTIG_MASK;
-			dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
-					     DMA_BIDIRECTIONAL, attrs);
+			if (unlikely(dma_cbs))
+				dma_cbs->unmap_page(dma_map->dev, *dma, PAGE_SIZE,
+						    DMA_BIDIRECTIONAL, attrs);
+			else
+				dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
+						     DMA_BIDIRECTIONAL, attrs);
 			*dma = 0;
 		}
 	}
@@ -362,7 +367,7 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 	if (!refcount_dec_and_test(&dma_map->users))
 		return;
 
-	__xp_dma_unmap(dma_map, attrs);
+	__xp_dma_unmap(dma_map, pool->dma_cbs, attrs);
 	kvfree(pool->dma_pages);
 	pool->dma_pages_cnt = 0;
 	pool->dev = NULL;
@@ -407,6 +412,7 @@ static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_map *dma_
 }
 
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
+	       struct xsk_dma_cbs *dma_cbs,
 	       unsigned long attrs, struct page **pages, u32 nr_pages)
 {
 	struct xsk_dma_map *dma_map;
@@ -424,19 +430,32 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 		return 0;
 	}
 
+	pool->dma_cbs = dma_cbs;
+
 	dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem);
 	if (!dma_map)
 		return -ENOMEM;
 
 	for (i = 0; i < dma_map->dma_pages_cnt; i++) {
-		dma = dma_map_page_attrs(dev, pages[i], 0, PAGE_SIZE,
-					 DMA_BIDIRECTIONAL, attrs);
-		if (dma_mapping_error(dev, dma)) {
-			__xp_dma_unmap(dma_map, attrs);
-			return -ENOMEM;
+		if (likely(!dma_cbs)) {
+			dma = dma_map_page_attrs(dev, pages[i], 0, PAGE_SIZE,
+						 DMA_BIDIRECTIONAL, attrs);
+			if (dma_mapping_error(dev, dma)) {
+				__xp_dma_unmap(dma_map, dma_cbs, attrs);
+				return -ENOMEM;
+			}
+			if (dma_need_sync(dev, dma))
+				dma_map->dma_need_sync = true;
+		} else {
+			dma = dma_cbs->map_page(dev, pages[i], 0, PAGE_SIZE,
+						DMA_BIDIRECTIONAL, attrs);
+			if (dma_cbs->mapping_error(dev, dma)) {
+				__xp_dma_unmap(dma_map, dma_cbs, attrs);
+				return -ENOMEM;
+			}
+			if (dma_cbs->need_sync(dev, dma))
+				dma_map->dma_need_sync = true;
 		}
-		if (dma_need_sync(dev, dma))
-			dma_map->dma_need_sync = true;
 		dma_map->dma_pages[i] = dma;
 	}
 
@@ -445,7 +464,7 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 
 	err = xp_init_dma_info(pool, dma_map);
 	if (err) {
-		__xp_dma_unmap(dma_map, attrs);
+		__xp_dma_unmap(dma_map, dma_cbs, attrs);
 		return err;
 	}
 
@@ -532,9 +551,14 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 	xskb->xdp.data_meta = xskb->xdp.data;
 
 	if (pool->dma_need_sync) {
-		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
-						 pool->frame_len,
-						 DMA_BIDIRECTIONAL);
+		if (unlikely(pool->dma_cbs))
+			pool->dma_cbs->sync_single_range_for_device(pool->dev, xskb->dma, 0,
+								    pool->frame_len,
+								    DMA_BIDIRECTIONAL);
+		else
+			dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
+							 pool->frame_len,
+							 DMA_BIDIRECTIONAL);
 	}
 	return &xskb->xdp;
 }
@@ -670,15 +694,24 @@ EXPORT_SYMBOL(xp_raw_get_dma);
 
 void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb)
 {
-	dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
-				      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
+	if (unlikely(xskb->pool->dma_cbs))
+		xskb->pool->dma_cbs->sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
+							       xskb->pool->frame_len,
+							       DMA_BIDIRECTIONAL);
+	else
+		dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
+					      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(xp_dma_sync_for_cpu_slow);
 
 void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
 				 size_t size)
 {
-	dma_sync_single_range_for_device(pool->dev, dma, 0,
-					 size, DMA_BIDIRECTIONAL);
+	if (unlikely(pool->dma_cbs))
+		pool->dma_cbs->sync_single_range_for_device(pool->dev, dma, 0,
+							    size, DMA_BIDIRECTIONAL);
+	else
+		dma_sync_single_range_for_device(pool->dev, dma, 0,
+						 size, DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(xp_dma_sync_for_device_slow);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
