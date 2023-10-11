Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A19CD6E55
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 09:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EF6F41842;
	Wed, 11 Oct 2023 09:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EF6F41842
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v18pZJFS8fwx; Wed, 11 Oct 2023 09:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F2CA41833;
	Wed, 11 Oct 2023 09:27:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F2CA41833
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A185C0039;
	Wed, 11 Oct 2023 09:27:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 411C4C0088
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 168C282477
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 168C282477
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OtTRTWJaUxgm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:50 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2597382444
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2597382444
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VtwMrtQ_1697016464; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtwMrtQ_1697016464) by smtp.aliyun-inc.com;
 Wed, 11 Oct 2023 17:27:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 14/22] virtio_net: xsk: tx: support tx
Date: Wed, 11 Oct 2023 17:27:20 +0800
Message-Id: <20231011092728.105904-15-xuanzhuo@linux.alibaba.com>
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

The driver's tx napi is very important for XSK. It is responsible for
obtaining data from the XSK queue and sending it out.

At the beginning, we need to trigger tx napi.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  12 +++-
 drivers/net/virtio/virtio_net.h |   3 +-
 drivers/net/virtio/xsk.c        | 108 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |  13 ++++
 4 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 90219fa4a6cd..87bed583b6c4 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -2060,6 +2060,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_sq *sq = container_of(napi, struct virtnet_sq, napi);
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
+	struct xsk_buff_pool *pool;
 	struct netdev_queue *txq;
 	int busy = 0;
 	int opaque;
@@ -2074,7 +2075,16 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, true);
+
+	rcu_read_lock();
+	pool = rcu_dereference(sq->xsk.pool);
+	if (pool) {
+		busy |= virtnet_xsk_xmit(sq, pool, budget);
+		rcu_read_unlock();
+	} else {
+		rcu_read_unlock();
+		free_old_xmit(sq, true);
+	}
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 0603033b76a0..58eb7a46c489 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -9,7 +9,8 @@
 #include <net/xdp_sock_drv.h>
 
 #define VIRTIO_XDP_FLAG	BIT(0)
-#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
+#define VIRTIO_XSK_FLAG	BIT(1)
+#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG | VIRTIO_XSK_FLAG)
 
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index adbaefb77480..a96e23ad577e 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -7,6 +7,114 @@
 
 static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
+static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct net_device *dev = vi->dev;
+	int qnum = sq - vi->sq;
+
+	/* If it is a raw buffer queue, it does not check whether the status
+	 * of the queue is stopped when sending. So there is no need to check
+	 * the situation of the raw buffer queue.
+	 */
+	if (virtnet_is_xdp_raw_buffer_queue(vi, qnum))
+		return;
+
+	/* If this sq is not the exclusive queue of the current cpu,
+	 * then it may be called by start_xmit, so check it running out
+	 * of space.
+	 *
+	 * Stop the queue to avoid getting packets that we are
+	 * then unable to transmit. Then wait the tx interrupt.
+	 */
+	if (sq->vq->num_free < 2 + MAX_SKB_FRAGS)
+		netif_stop_subqueue(dev, qnum);
+}
+
+static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
+				struct xsk_buff_pool *pool,
+				struct xdp_desc *desc)
+{
+	struct virtnet_info *vi;
+	dma_addr_t addr;
+
+	vi = sq->vq->vdev->priv;
+
+	addr = xsk_buff_raw_get_dma(pool, desc->addr);
+	xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
+
+	sg_init_table(sq->sg, 2);
+
+	sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
+	sg_fill_dma(sq->sg + 1, addr, desc->len);
+
+	return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
+				    virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
+}
+
+static int virtnet_xsk_xmit_batch(struct virtnet_sq *sq,
+				  struct xsk_buff_pool *pool,
+				  unsigned int budget,
+				  struct virtnet_sq_stats *stats)
+{
+	struct xdp_desc *descs = pool->tx_descs;
+	u32 nb_pkts, max_pkts, i;
+	bool kick = false;
+	int err;
+
+	max_pkts = min_t(u32, budget, sq->vq->num_free / 2);
+
+	nb_pkts = xsk_tx_peek_release_desc_batch(pool, max_pkts);
+	if (!nb_pkts)
+		return 0;
+
+	for (i = 0; i < nb_pkts; i++) {
+		err = virtnet_xsk_xmit_one(sq, pool, &descs[i]);
+		if (unlikely(err))
+			break;
+
+		kick = true;
+	}
+
+	if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
+		++stats->kicks;
+
+	stats->xdp_tx += i;
+
+	return i;
+}
+
+bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
+		      int budget)
+{
+	struct virtnet_sq_stats stats = {};
+	int sent;
+
+	virtnet_free_old_xmit(sq, true, &stats);
+
+	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &stats);
+
+	virtnet_xsk_check_queue(sq);
+
+	u64_stats_update_begin(&sq->stats.syncp);
+	sq->stats.packets += stats.packets;
+	sq->stats.bytes += stats.bytes;
+	sq->stats.kicks += stats.kicks;
+	sq->stats.xdp_tx += stats.xdp_tx;
+	u64_stats_update_end(&sq->stats.syncp);
+
+	if (xsk_uses_need_wakeup(pool))
+		xsk_set_tx_need_wakeup(pool);
+
+	return sent == budget;
+}
+
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
 				    struct xsk_buff_pool *pool)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 1918285c310c..73ca8cd5308b 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -3,5 +3,18 @@
 #ifndef __XSK_H__
 #define __XSK_H__
 
+#define VIRTIO_XSK_FLAG_OFFSET	4
+
+static inline void *virtnet_xsk_to_ptr(u32 len)
+{
+	unsigned long p;
+
+	p = len << VIRTIO_XSK_FLAG_OFFSET;
+
+	return (void *)(p | VIRTIO_XSK_FLAG);
+}
+
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
+bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
+		      int budget);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
