Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009F0CDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 12:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CDA882148;
	Mon, 16 Oct 2023 12:00:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CDA882148
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPVsY-36X543; Mon, 16 Oct 2023 12:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 182A882142;
	Mon, 16 Oct 2023 12:00:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 182A882142
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6DABC0088;
	Mon, 16 Oct 2023 12:00:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10326C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58A5781FFC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58A5781FFC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RsQOHlpNPufS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:48 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9814814C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9814814C1
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VuH0NbG_1697457641; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuH0NbG_1697457641) by smtp.aliyun-inc.com;
 Mon, 16 Oct 2023 20:00:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v1 06/19] virtio_net: separate virtnet_rx_resize()
Date: Mon, 16 Oct 2023 20:00:20 +0800
Message-Id: <20231016120033.26933-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 9790cc452aab
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

This patch separates two sub-functions from virtnet_rx_resize():

* virtnet_rx_pause
* virtnet_rx_resume

Then the subsequent reset rx for xsk can share these two functions.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 29 +++++++++++++++++++++--------
 drivers/net/virtio/virtio_net.h |  3 +++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index ba38b6078e1d..e6b262341619 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -2120,26 +2120,39 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static int virtnet_rx_resize(struct virtnet_info *vi,
-			     struct virtnet_rq *rq, u32 ring_num)
+void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq)
 {
 	bool running = netif_running(vi->dev);
-	int err, qindex;
-
-	qindex = rq - vi->rq;
 
 	if (running)
 		napi_disable(&rq->napi);
+}
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
-	if (err)
-		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
+void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq)
+{
+	bool running = netif_running(vi->dev);
 
 	if (!try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
 		virtnet_napi_enable(rq->vq, &rq->napi);
+}
+
+static int virtnet_rx_resize(struct virtnet_info *vi,
+			     struct virtnet_rq *rq, u32 ring_num)
+{
+	int err, qindex;
+
+	qindex = rq - vi->rq;
+
+	virtnet_rx_pause(vi, rq);
+
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
+
+	virtnet_rx_resume(vi, rq);
 	return err;
 }
 
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 282504d6639a..70eea23adba6 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -253,4 +253,7 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int
 	else
 		return false;
 }
+
+void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
+void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
