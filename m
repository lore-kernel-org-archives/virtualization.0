Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A74C6FD1B
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 04:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FF2C410E9;
	Mon,  6 Mar 2023 04:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FF2C410E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q55DnYjYlWQY; Mon,  6 Mar 2023 04:15:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87700410C5;
	Mon,  6 Mar 2023 04:15:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87700410C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 600D7C0035;
	Mon,  6 Mar 2023 04:15:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB049C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 866BD410C3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 866BD410C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFRbOPpF2K-8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29142410C4
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29142410C4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 04:15:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vd8Os24_1678076137; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vd8Os24_1678076137) by smtp.aliyun-inc.com;
 Mon, 06 Mar 2023 12:15:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net 1/2] virtio_net: separate the logic of checking whether sq
 is full
Date: Mon,  6 Mar 2023 12:15:34 +0800
Message-Id: <20230306041535.73319-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 340c28a36929
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
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

Separate the logic of checking whether sq is full. The subsequent patch
will reuse this func.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 59 ++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fb5e68ed3ec2..777de0ec0b1b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1750,6 +1750,40 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
+static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
+			  struct send_queue *sq)
+{
+	bool use_napi = sq->napi.weight;
+	int qnum;
+
+	qnum = sq - vi->sq;
+
+	/* If running out of space, stop queue to avoid getting packets that we
+	 * are then unable to transmit.
+	 * An alternative would be to force queuing layer to requeue the skb by
+	 * returning NETDEV_TX_BUSY. However, NETDEV_TX_BUSY should not be
+	 * returned in a normal path of operation: it means that driver is not
+	 * maintaining the TX queue stop/start state properly, and causes
+	 * the stack to do a non-trivial amount of useless work.
+	 * Since most packets only take 1 or 2 ring slots, stopping the queue
+	 * early means 16 slots are typically wasted.
+	 */
+	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
+		netif_stop_subqueue(dev, qnum);
+		if (use_napi) {
+			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
+				virtqueue_napi_schedule(&sq->napi, sq->vq);
+		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
+			/* More just got used, free them then recheck. */
+			free_old_xmit_skbs(sq, false);
+			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
+				netif_start_subqueue(dev, qnum);
+				virtqueue_disable_cb(sq->vq);
+			}
+		}
+	}
+}
+
 static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 {
 	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
@@ -1989,30 +2023,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		nf_reset_ct(skb);
 	}
 
-	/* If running out of space, stop queue to avoid getting packets that we
-	 * are then unable to transmit.
-	 * An alternative would be to force queuing layer to requeue the skb by
-	 * returning NETDEV_TX_BUSY. However, NETDEV_TX_BUSY should not be
-	 * returned in a normal path of operation: it means that driver is not
-	 * maintaining the TX queue stop/start state properly, and causes
-	 * the stack to do a non-trivial amount of useless work.
-	 * Since most packets only take 1 or 2 ring slots, stopping the queue
-	 * early means 16 slots are typically wasted.
-	 */
-	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
-		netif_stop_subqueue(dev, qnum);
-		if (use_napi) {
-			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
-				virtqueue_napi_schedule(&sq->napi, sq->vq);
-		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
-			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq, false);
-			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
-				netif_start_subqueue(dev, qnum);
-				virtqueue_disable_cb(sq->vq);
-			}
-		}
-	}
+	check_sq_full(vi, dev, sq);
 
 	if (kick || netif_xmit_stopped(txq)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
