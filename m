Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B979AC77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 03:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34DE8403AC;
	Mon, 17 Apr 2023 03:28:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34DE8403AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id beZw9CVvBWfX; Mon, 17 Apr 2023 03:28:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69EED401AE;
	Mon, 17 Apr 2023 03:28:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69EED401AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC6BC0037;
	Mon, 17 Apr 2023 03:28:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D065C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54F7660BD9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:28:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54F7660BD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CBQM-ZT2od-f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:27:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D000560BC9
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D000560BC9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:27:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R571e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0VgBt9Ys_1681702070; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgBt9Ys_1681702070) by smtp.aliyun-inc.com;
 Mon, 17 Apr 2023 11:27:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next] xsk: introduce xsk_dma_ops
Date: Mon, 17 Apr 2023 11:27:50 +0800
Message-Id: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 60759681f964
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

The purpose of this patch is to allow driver pass the own dma_ops to
xsk.

This is to cope with the scene of virtio-net. If virtio does not have
VIRTIO_F_ACCESS_PLATFORM, then virtio cannot use DMA API. In this case,
XSK cannot use DMA API directly to achieve DMA address. Based on this
scene, we must let XSK support driver to use the driver's dma_ops.

On the other hand, the implementation of XSK as a highlevel code
should put the underlying operation of DMA to the driver layer.
The driver layer determines the implementation of the final DMA. XSK
should not make such assumptions. Everything will be simplified if DMA
is done at the driver level.

More is here:
    https://lore.kernel.org/virtualization/1681265026.6082013-1-xuanzhuo@linux.alibaba.com/

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/net/xdp_sock_drv.h  | 20 +++++++++++++++-
 include/net/xsk_buff_pool.h | 19 +++++++++++++++
 net/xdp/xsk_buff_pool.c     | 47 +++++++++++++++++++++++--------------
 3 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 9c0d860609ba..181583ff6a26 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -67,7 +67,17 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
 {
 	struct xdp_umem *umem = pool->umem;
 
-	return xp_dma_map(pool, dev, attrs, umem->pgs, umem->npgs);
+	return xp_dma_map(pool, dev, NULL, attrs, umem->pgs, umem->npgs);
+}
+
+static inline int xsk_pool_dma_map_with_ops(struct xsk_buff_pool *pool,
+					    struct device *dev,
+					    struct xsk_dma_ops *dma_ops,
+					    unsigned long attrs)
+{
+	struct xdp_umem *umem = pool->umem;
+
+	return xp_dma_map(pool, dev, dma_ops, attrs, umem->pgs, umem->npgs);
 }
 
 static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
@@ -226,6 +236,14 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
 	return 0;
 }
 
+static inline int xsk_pool_dma_map_with_ops(struct xsk_buff_pool *pool,
+					    struct device *dev,
+					    struct xsk_dma_ops *dma_ops,
+					    unsigned long attrs)
+{
+	return 0;
+}
+
 static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
 {
 	return 0;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 3e952e569418..1299b9d12484 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -43,6 +43,23 @@ struct xsk_dma_map {
 	bool dma_need_sync;
 };
 
+struct xsk_dma_ops {
+	dma_addr_t (*map_page)(struct device *dev, struct page *page,
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
+			   size_t size, enum dma_data_direction dir,
+			   unsigned long attrs);
+	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
+	bool (*need_sync)(struct device *dev, dma_addr_t dma);
+	void (*sync_single_range_for_cpu)(struct device *dev, dma_addr_t addr,
+					  unsigned long offset, size_t size,
+					  enum dma_data_direction dir);
+	void (*sync_single_range_for_device)(struct device *dev, dma_addr_t addr,
+					     unsigned long offset, size_t size,
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
+	struct xsk_dma_ops dma_ops;
 	struct xdp_buff_xsk *free_heads[];
 };
 
@@ -131,6 +149,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
 /* AF_XDP ZC drivers, via xdp_sock_buff.h */
 void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
+	       struct xsk_dma_ops *dma_ops,
 	       unsigned long attrs, struct page **pages, u32 nr_pages);
 void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
 struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index b2df1e0f8153..646090cae8ec 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -328,7 +328,8 @@ static void xp_destroy_dma_map(struct xsk_dma_map *dma_map)
 	kfree(dma_map);
 }
 
-static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
+static void __xp_dma_unmap(struct xsk_dma_map *dma_map,
+			   struct xsk_dma_ops *dma_ops, unsigned long attrs)
 {
 	dma_addr_t *dma;
 	u32 i;
@@ -337,8 +338,8 @@ static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
 		dma = &dma_map->dma_pages[i];
 		if (*dma) {
 			*dma &= ~XSK_NEXT_PG_CONTIG_MASK;
-			dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
-					     DMA_BIDIRECTIONAL, attrs);
+			dma_ops->unmap_page(dma_map->dev, *dma, PAGE_SIZE,
+					    DMA_BIDIRECTIONAL, attrs);
 			*dma = 0;
 		}
 	}
@@ -362,7 +363,7 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 	if (!refcount_dec_and_test(&dma_map->users))
 		return;
 
-	__xp_dma_unmap(dma_map, attrs);
+	__xp_dma_unmap(dma_map, &pool->dma_ops, attrs);
 	kvfree(pool->dma_pages);
 	pool->dma_pages_cnt = 0;
 	pool->dev = NULL;
@@ -407,6 +408,7 @@ static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_map *dma_
 }
 
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
+	       struct xsk_dma_ops *dma_ops,
 	       unsigned long attrs, struct page **pages, u32 nr_pages)
 {
 	struct xsk_dma_map *dma_map;
@@ -424,18 +426,29 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 		return 0;
 	}
 
+	if (!dma_ops) {
+		pool->dma_ops.map_page = dma_map_page_attrs;
+		pool->dma_ops.mapping_error = dma_mapping_error;
+		pool->dma_ops.need_sync = dma_need_sync;
+		pool->dma_ops.sync_single_range_for_device = dma_sync_single_range_for_device;
+		pool->dma_ops.sync_single_range_for_cpu = dma_sync_single_range_for_cpu;
+		dma_ops = &pool->dma_ops;
+	} else {
+		pool->dma_ops = *dma_ops;
+	}
+
 	dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem);
 	if (!dma_map)
 		return -ENOMEM;
 
 	for (i = 0; i < dma_map->dma_pages_cnt; i++) {
-		dma = dma_map_page_attrs(dev, pages[i], 0, PAGE_SIZE,
-					 DMA_BIDIRECTIONAL, attrs);
-		if (dma_mapping_error(dev, dma)) {
-			__xp_dma_unmap(dma_map, attrs);
+		dma = dma_ops->map_page(dev, pages[i], 0, PAGE_SIZE,
+					DMA_BIDIRECTIONAL, attrs);
+		if (dma_ops->mapping_error(dev, dma)) {
+			__xp_dma_unmap(dma_map, dma_ops, attrs);
 			return -ENOMEM;
 		}
-		if (dma_need_sync(dev, dma))
+		if (dma_ops->need_sync(dev, dma))
 			dma_map->dma_need_sync = true;
 		dma_map->dma_pages[i] = dma;
 	}
@@ -445,7 +458,7 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 
 	err = xp_init_dma_info(pool, dma_map);
 	if (err) {
-		__xp_dma_unmap(dma_map, attrs);
+		__xp_dma_unmap(dma_map, dma_ops, attrs);
 		return err;
 	}
 
@@ -532,9 +545,9 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 	xskb->xdp.data_meta = xskb->xdp.data;
 
 	if (pool->dma_need_sync) {
-		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
-						 pool->frame_len,
-						 DMA_BIDIRECTIONAL);
+		pool->dma_ops.sync_single_range_for_device(pool->dev, xskb->dma, 0,
+							   pool->frame_len,
+							   DMA_BIDIRECTIONAL);
 	}
 	return &xskb->xdp;
 }
@@ -670,15 +683,15 @@ EXPORT_SYMBOL(xp_raw_get_dma);
 
 void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb)
 {
-	dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
-				      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
+	xskb->pool->dma_ops.sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
+						      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(xp_dma_sync_for_cpu_slow);
 
 void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
 				 size_t size)
 {
-	dma_sync_single_range_for_device(pool->dev, dma, 0,
-					 size, DMA_BIDIRECTIONAL);
+	pool->dma_ops.sync_single_range_for_device(pool->dev, dma, 0,
+						   size, DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(xp_dma_sync_for_device_slow);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
