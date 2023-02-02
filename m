Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77254C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AF6F41971;
	Thu,  2 Feb 2023 11:01:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AF6F41971
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KfwB75jPG6vv; Thu,  2 Feb 2023 11:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2298D41B76;
	Thu,  2 Feb 2023 11:01:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2298D41B76
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7098C0086;
	Thu,  2 Feb 2023 11:01:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13CEDC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC8A2408A7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC8A2408A7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b44qqn9crlll
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B873841949
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B873841949
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:41 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VakkMAt_1675335696; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VakkMAt_1675335696) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 33/33] virtio_net: xsk: rx: introduce receive_xsk() to recv
 xsk buffer
Date: Thu,  2 Feb 2023 19:00:58 +0800
Message-Id: <20230202110058.130695-34-xuanzhuo@linux.alibaba.com>
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

Implementing the logic of xsk rx. If this packet is not for XSK
determined in XDP, then we need to copy once to generate a SKB.
If it is for XSK, it is a zerocopy receive packet process.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  11 ++-
 drivers/net/virtio/virtio_net.h |   5 ++
 drivers/net/virtio/xsk.c        | 116 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |   4 ++
 4 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 2aff0eee35d3..c96183b99e46 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -140,11 +140,6 @@ static int rxq2vq(int rxq)
 	return rxq * 2;
 }
 
-static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
-{
-	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
-}
-
 /*
  * private is used to chain pages for big packets, put the whole
  * most recent used list in the beginning for reuse
@@ -1161,13 +1156,17 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
-	if (vi->mergeable_rx_bufs)
+	rcu_read_lock();
+	if (rcu_dereference(rq->xsk.pool))
+		skb = receive_xsk(dev, vi, rq, buf, len, xdp_xmit, stats);
+	else if (vi->mergeable_rx_bufs)
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
 	else if (vi->big_packets)
 		skb = receive_big(dev, vi, rq, buf, len, stats);
 	else
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+	rcu_read_unlock();
 
 	if (unlikely(!skb))
 		return;
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 100ce48c6d55..d9d2e9dcc36c 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -220,6 +220,11 @@ struct receive_queue {
 	} xsk;
 };
 
+static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
+{
+	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
+}
+
 static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 {
 	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index a5e88f919c46..1287b25cb207 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -13,6 +13,18 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
+static unsigned int virtnet_receive_buf_num(struct virtnet_info *vi, char *buf)
+{
+	struct virtio_net_hdr_mrg_rxbuf *hdr;
+
+	if (vi->mergeable_rx_bufs) {
+		hdr = (struct virtio_net_hdr_mrg_rxbuf *)buf;
+		return virtio16_to_cpu(vi->vdev, hdr->num_buffers);
+	}
+
+	return 1;
+}
+
 static void virtnet_xsk_check_queue(struct send_queue *sq)
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
@@ -37,6 +49,110 @@ static void virtnet_xsk_check_queue(struct send_queue *sq)
 		netif_stop_subqueue(dev, qnum);
 }
 
+static void merge_drop_follow_xdp(struct net_device *dev,
+				  struct receive_queue *rq,
+				  u32 num_buf,
+				  struct virtnet_rq_stats *stats)
+{
+	struct xdp_buff *xdp;
+	u32 len;
+
+	while (num_buf-- > 1) {
+		xdp = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!xdp)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 dev->name, num_buf);
+			dev->stats.rx_length_errors++;
+			break;
+		}
+		stats->bytes += len;
+		xsk_buff_free(xdp);
+	}
+}
+
+static struct sk_buff *construct_skb(struct receive_queue *rq,
+				     struct xdp_buff *xdp)
+{
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+	unsigned int size;
+
+	size = xdp->data_end - xdp->data_hard_start;
+	skb = napi_alloc_skb(&rq->napi, size);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+
+	size = xdp->data_end - xdp->data_meta;
+	memcpy(__skb_put(skb, size), xdp->data_meta, size);
+
+	if (metasize) {
+		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
+	}
+
+	return skb;
+}
+
+struct sk_buff *receive_xsk(struct net_device *dev, struct virtnet_info *vi,
+			    struct receive_queue *rq, void *buf,
+			    unsigned int len, unsigned int *xdp_xmit,
+			    struct virtnet_rq_stats *stats)
+{
+	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct sk_buff *skb = NULL;
+	u32 ret, headroom, num_buf;
+	struct bpf_prog *prog;
+	struct xdp_buff *xdp;
+
+	xdp = (struct xdp_buff *)buf;
+
+	hdr = xdp->data - vi->hdr_len;
+
+	num_buf = virtnet_receive_buf_num(vi, (char *)hdr);
+	if (num_buf > 1)
+		goto drop;
+
+	len -= vi->hdr_len;
+	headroom = xdp->data - xdp->data_hard_start;
+
+	xdp_prepare_buff(xdp, xdp->data_hard_start, headroom, len, true);
+	xsk_buff_dma_sync_for_cpu(xdp, rq->xsk.pool);
+
+	ret = VIRTNET_XDP_RES_PASS;
+	rcu_read_lock();
+	prog = rcu_dereference(rq->xdp_prog);
+	if (prog)
+		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	rcu_read_unlock();
+
+	switch (ret) {
+	case VIRTNET_XDP_RES_PASS:
+		skb = construct_skb(rq, xdp);
+		xsk_buff_free(xdp);
+		break;
+
+	case VIRTNET_XDP_RES_DROP:
+		goto drop;
+
+	case VIRTNET_XDP_RES_CONSUMED:
+		goto consumed;
+	}
+
+	return skb;
+
+drop:
+	stats->drops++;
+
+	xsk_buff_free(xdp);
+
+	if (num_buf > 1)
+		merge_drop_follow_xdp(dev, rq, num_buf, stats);
+consumed:
+	return NULL;
+}
+
 int add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
 		    struct xsk_buff_pool *pool, gfp_t gfp)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 5549143ef118..ebdee62b9dc8 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -26,4 +26,8 @@ bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 int add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
 		    struct xsk_buff_pool *pool, gfp_t gfp);
+struct sk_buff *receive_xsk(struct net_device *dev, struct virtnet_info *vi,
+			    struct receive_queue *rq, void *buf,
+			    unsigned int len, unsigned int *xdp_xmit,
+			    struct virtnet_rq_stats *stats);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
