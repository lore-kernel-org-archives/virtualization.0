Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71859C6FD1C
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 04:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC96560B9B;
	Mon,  6 Mar 2023 04:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC96560B9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KfsErEWGD6ng; Mon,  6 Mar 2023 04:15:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C852560BBB;
	Mon,  6 Mar 2023 04:15:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C852560BBB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F69BC0090;
	Mon,  6 Mar 2023 04:15:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89F84C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5943940391
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5943940391
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NdapeafSuYOW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C029A400C8
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C029A400C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:44 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vd8WMOf_1678076138; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vd8WMOf_1678076138) by smtp.aliyun-inc.com;
 Mon, 06 Mar 2023 12:15:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net 2/2] virtio_net: add checking sq is full inside xdp xmit
Date: Mon,  6 Mar 2023 12:15:35 +0800
Message-Id: <20230306041535.73319-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 340c28a36929
Cc: Yichun Zhang <yichun@openresty.com>,
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

If the queue of xdp xmit is not an independent queue, then when the xdp
xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
the following error.

net ens4: Unexpected TXQ (0) queue failure: -28

This patch adds a check whether sq is full in XDP Xmit.

Reported-by: Yichun Zhang <yichun@openresty.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 777de0ec0b1b..3001b9a548e5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -302,6 +302,8 @@ struct padded_vnet_hdr {
 
 static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
+			  struct send_queue *sq);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -341,6 +343,16 @@ static int rxq2vq(int rxq)
 	return rxq * 2;
 }
 
+static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
+{
+	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
+		return false;
+	else if (q < vi->curr_queue_pairs)
+		return true;
+	else
+		return false;
+}
+
 static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
 {
 	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
@@ -686,6 +698,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 	ret = nxmit;
 
+	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
+		check_sq_full(vi, dev, sq);
+
 	if (flags & XDP_XMIT_FLUSH) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
 			kicks = 1;
@@ -1784,16 +1799,6 @@ static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
 	}
 }
 
-static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
-{
-	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
-		return false;
-	else if (q < vi->curr_queue_pairs)
-		return true;
-	else
-		return false;
-}
-
 static void virtnet_poll_cleantx(struct receive_queue *rq)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
