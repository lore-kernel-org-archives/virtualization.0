Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F01CD6E54
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 09:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8E3A82446;
	Wed, 11 Oct 2023 09:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8E3A82446
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jLxmBpMSBJLD; Wed, 11 Oct 2023 09:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E1125823FF;
	Wed, 11 Oct 2023 09:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1125823FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD8DC0DD8;
	Wed, 11 Oct 2023 09:27:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2455CC0088
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CFB94183C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CFB94183C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qa4c4QJA1X6y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:55 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C8BB41833
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C8BB41833
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VtwDbl-_1697016470; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtwDbl-_1697016470) by smtp.aliyun-inc.com;
 Wed, 11 Oct 2023 17:27:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 19/22] virtio_net: xsk: rx: introduce receive_xsk() to
 recv xsk buffer
Date: Wed, 11 Oct 2023 17:27:25 +0800
Message-Id: <20231011092728.105904-20-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
 drivers/net/virtio/main.c       |  14 ++--
 drivers/net/virtio/virtio_net.h |   4 ++
 drivers/net/virtio/xsk.c        | 120 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |   4 ++
 4 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 55a643a1f129..61be5a353ff3 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -828,10 +828,10 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 	}
 }
 
-static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
-			       struct net_device *dev,
-			       unsigned int *xdp_xmit,
-			       struct virtnet_rq_stats *stats)
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats)
 {
 	struct xdp_frame *xdpf;
 	int err;
@@ -1595,13 +1595,17 @@ static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
 		return;
 	}
 
-	if (vi->mergeable_rx_bufs)
+	rcu_read_lock();
+	if (rcu_dereference(rq->xsk.pool))
+		skb = virtnet_receive_xsk(dev, vi, rq, buf, len, xdp_xmit, stats);
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
index 532df71a4c08..a8aa1a68a237 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -345,6 +345,10 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int
 		return false;
 }
 
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats);
 void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index d7f0a81e8635..7abd46bb0e3d 100644
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
 static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
@@ -37,6 +49,114 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
 		netif_stop_subqueue(dev, qnum);
 }
 
+static void merge_drop_follow_xdp(struct net_device *dev,
+				  struct virtnet_rq *rq,
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
+static struct sk_buff *construct_skb(struct virtnet_rq *rq,
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
+struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct virtnet_info *vi,
+				    struct virtnet_rq *rq, void *buf,
+				    unsigned int len, unsigned int *xdp_xmit,
+				    struct virtnet_rq_stats *stats)
+{
+	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct sk_buff *skb = NULL;
+	u32 ret, headroom, num_buf;
+	struct bpf_prog *prog;
+	struct xdp_buff *xdp;
+
+	len -= vi->hdr_len;
+
+	xdp = (struct xdp_buff *)buf;
+
+	xsk_buff_set_size(xdp, len);
+
+	hdr = xdp->data - vi->hdr_len;
+
+	num_buf = virtnet_receive_buf_num(vi, (char *)hdr);
+	if (num_buf > 1)
+		goto drop;
+
+	headroom = xdp->data - xdp->data_hard_start;
+
+	xdp_prepare_buff(xdp, xdp->data_hard_start, headroom, len, true);
+	xsk_buff_dma_sync_for_cpu(xdp, rq->xsk.pool);
+
+	ret = XDP_PASS;
+	rcu_read_lock();
+	prog = rcu_dereference(rq->xdp_prog);
+	if (prog)
+		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	rcu_read_unlock();
+
+	switch (ret) {
+	case XDP_PASS:
+		skb = construct_skb(rq, xdp);
+		xsk_buff_free(xdp);
+		break;
+
+	case XDP_TX:
+	case XDP_REDIRECT:
+		goto consumed;
+
+	default:
+		goto drop;
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
 static int virtnet_add_recvbuf_batch(struct virtnet_info *vi, struct virtnet_rq *rq,
 				     struct xsk_buff_pool *pool, gfp_t gfp)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index bef41a3f954e..dbd2839a5f61 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -25,4 +25,8 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
 			    struct xsk_buff_pool *pool, gfp_t gfp);
+struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct virtnet_info *vi,
+				    struct virtnet_rq *rq, void *buf,
+				    unsigned int len, unsigned int *xdp_xmit,
+				    struct virtnet_rq_stats *stats);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
