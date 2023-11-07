Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DB4C41535
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 03:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1C8B61335;
	Tue,  7 Nov 2023 03:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1C8B61335
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wh1Ncr-VhcYc; Tue,  7 Nov 2023 03:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2FD4061324;
	Tue,  7 Nov 2023 03:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FD4061324
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F232C0DD5;
	Tue,  7 Nov 2023 03:12:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43BA6C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0481E416E6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0481E416E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbITowlRoaSC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:51 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15816416CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15816416CA
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VvsNiiw_1699326766; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VvsNiiw_1699326766) by smtp.aliyun-inc.com;
 Tue, 07 Nov 2023 11:12:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 16/21] virtio_net: xsk: rx: introduce
 add_recvbuf_xsk()
Date: Tue,  7 Nov 2023 11:12:22 +0800
Message-Id: <20231107031227.100015-17-xuanzhuo@linux.alibaba.com>
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

Implement the logic of filling rq with XSK buffers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  4 ++-
 drivers/net/virtio/virtio_net.h |  5 ++++
 drivers/net/virtio/xsk.c        | 49 ++++++++++++++++++++++++++++++++-
 drivers/net/virtio/xsk.h        |  2 ++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 6210a6e37396..15943a22e17d 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -1798,7 +1798,9 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
 	bool oom;
 
 	do {
-		if (vi->mergeable_rx_bufs)
+		if (rq->xsk.pool)
+			err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk.pool, gfp);
+		else if (vi->mergeable_rx_bufs)
 			err = add_recvbuf_mergeable(vi, rq, gfp);
 		else if (vi->big_packets)
 			err = add_recvbuf_big(vi, rq, gfp);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index a13d6d301fdb..1242785e311e 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -140,6 +140,11 @@ struct virtnet_rq {
 
 		/* xdp rxq used by xsk */
 		struct xdp_rxq_info xdp_rxq;
+
+		struct xdp_buff **xsk_buffs;
+		u32 nxt_idx;
+		u32 num;
+		u32 size;
 	} xsk;
 };
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index ea5804ddd44e..e737c3353212 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -38,6 +38,41 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
 		netif_stop_subqueue(dev, qnum);
 }
 
+int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
+			    struct xsk_buff_pool *pool, gfp_t gfp)
+{
+	struct xdp_buff **xsk_buffs;
+	dma_addr_t addr;
+	u32 len, i;
+	int err = 0;
+
+	xsk_buffs = rq->xsk.xsk_buffs;
+
+	if (rq->xsk.nxt_idx >= rq->xsk.num) {
+		rq->xsk.num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->xsk.size);
+		if (!rq->xsk.num)
+			return -ENOMEM;
+		rq->xsk.nxt_idx = 0;
+	}
+
+	i = rq->xsk.nxt_idx;
+
+	/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
+	addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
+	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+
+	sg_init_table(rq->sg, 1);
+	sg_fill_dma(rq->sg, addr, len);
+
+	err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
+	if (err)
+		return err;
+
+	rq->xsk.nxt_idx++;
+
+	return 0;
+}
+
 static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
 				struct xsk_buff_pool *pool,
 				struct xdp_desc *desc)
@@ -213,7 +248,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct virtnet_sq *sq;
 	struct device *dma_dev;
 	dma_addr_t hdr_dma;
-	int err;
+	int err, size;
 
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
@@ -249,6 +284,16 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!dma_dev)
 		return -EPERM;
 
+	size = virtqueue_get_vring_size(rq->vq);
+
+	rq->xsk.xsk_buffs = kcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
+	if (!rq->xsk.xsk_buffs)
+		return -ENOMEM;
+
+	rq->xsk.size = size;
+	rq->xsk.nxt_idx = 0;
+	rq->xsk.num = 0;
+
 	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, hdr_dma))
 		return -ENOMEM;
@@ -307,6 +352,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
 
+	kfree(rq->xsk.xsk_buffs);
+
 	return err1 | err2;
 }
 
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 7ebc9bda7aee..bef41a3f954e 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
 int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
+int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
+			    struct xsk_buff_pool *pool, gfp_t gfp);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
