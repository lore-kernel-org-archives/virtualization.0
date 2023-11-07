Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534F9C4167D
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 03:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F273F4213F;
	Tue,  7 Nov 2023 03:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F273F4213F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dy2hJvIiZKXL; Tue,  7 Nov 2023 03:12:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 303F742137;
	Tue,  7 Nov 2023 03:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 303F742137
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE669C0039;
	Tue,  7 Nov 2023 03:12:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01276C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1ECE416EB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1ECE416EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9dITGwdhKPS
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:55 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 713A4416DB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 713A4416DB
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VvsQhei_1699326768; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VvsQhei_1699326768) by smtp.aliyun-inc.com;
 Tue, 07 Nov 2023 11:12:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 18/21] virtio_net: xsk: rx: introduce
 receive_xsk() to recv xsk buffer
Date: Tue,  7 Nov 2023 11:12:24 +0800
Message-Id: <20231107031227.100015-19-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 59a160d210e8
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
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

The virtnet_xdp_handler() is re-used. But

1. We need to copy data to create skb for XDP_PASS.
2. We need to call xsk_buff_free() to release the buffer.
3. The handle for xdp_buff is difference.

If we pushed this logic into existing receive handle(merge and small),
we would have to maintain code scattered inside merge and small (and big).
So I think it is a good choice for us to put the xsk code into an
independent function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  12 ++--
 drivers/net/virtio/virtio_net.h |   4 ++
 drivers/net/virtio/xsk.c        | 120 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |   4 ++
 4 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index a318b2533b94..095f4acb0577 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -831,10 +831,10 @@ static void put_xdp_frags(struct xdp_buff *xdp)
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
@@ -1598,7 +1598,9 @@ static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
 		return;
 	}
 
-	if (vi->mergeable_rx_bufs)
+	if (rq->xsk.pool)
+		skb = virtnet_receive_xsk(dev, vi, rq, buf, len, xdp_xmit, stats);
+	else if (vi->mergeable_rx_bufs)
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
 	else if (vi->big_packets)
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 2005d0cd22e2..f520fec06662 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -339,4 +339,8 @@ void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats);
 #endif
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index b09c473c29fb..5c7eb19ab04b 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -14,6 +14,18 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
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
@@ -38,6 +50,114 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
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
+		u64_stats_add(&stats->bytes, len);
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
+	u64_stats_inc(&stats->drops);
+
+	xsk_buff_free(xdp);
+
+	if (num_buf > 1)
+		merge_drop_follow_xdp(dev, rq, num_buf, stats);
+consumed:
+	return NULL;
+}
+
 int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
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
