Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1062C77B6D
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DCBD61209;
	Tue, 28 Mar 2023 09:29:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DCBD61209
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qhSRZlhIUMD9; Tue, 28 Mar 2023 09:29:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4715D61205;
	Tue, 28 Mar 2023 09:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4715D61205
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04319C0037;
	Tue, 28 Mar 2023 09:29:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20266C0098
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7545418FA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7545418FA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WUqmyt9eh8lE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87BEF418FE
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87BEF418FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R621e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vesd9Jr_1679995741; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vesd9Jr_1679995741) by smtp.aliyun-inc.com;
 Tue, 28 Mar 2023 17:29:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 12/16] virtio_net: introduce virtnet_get_netdev()
Date: Tue, 28 Mar 2023 17:28:43 +0800
Message-Id: <20230328092847.91643-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e880b402863c
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

Adding an API to get netdev_ops. Avoid to use the netdev_ops directly.

This is prepare for separating the virtio-related funcs.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet.c | 11 ++++++++---
 drivers/net/virtio/virtnet.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/virtnet.c b/drivers/net/virtio/virtnet.c
index 3f58af7d1550..5f508d9500f3 100644
--- a/drivers/net/virtio/virtnet.c
+++ b/drivers/net/virtio/virtnet.c
@@ -2054,7 +2054,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
 	if (netif_running(vi->dev))
-		virtnet_close(vi->dev);
+		virtnet_get_netdev()->ndo_stop(vi->dev);
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -2073,7 +2073,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	enable_delayed_refill(vi);
 
 	if (netif_running(vi->dev)) {
-		err = virtnet_open(vi->dev);
+		err = virtnet_get_netdev()->ndo_open(vi->dev);
 		if (err)
 			return err;
 	}
@@ -2319,6 +2319,11 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_tx_timeout		= virtnet_tx_timeout,
 };
 
+const struct net_device_ops *virtnet_get_netdev(void)
+{
+	return &virtnet_netdev;
+}
+
 static void virtnet_config_changed_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
@@ -2796,7 +2801,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	/* Set up network device as normal. */
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
 			   IFF_TX_SKB_NO_LINEAR;
-	dev->netdev_ops = &virtnet_netdev;
+	dev->netdev_ops = virtnet_get_netdev();
 	dev->features = NETIF_F_HIGHDMA;
 
 	dev->ethtool_ops = virtnet_get_ethtool_ops();
diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
index 48e0c5ba346a..269ddc386418 100644
--- a/drivers/net/virtio/virtnet.h
+++ b/drivers/net/virtio/virtnet.h
@@ -185,4 +185,5 @@ int virtnet_rx_resize(struct virtnet_info *vi, struct virtnet_rq *rq, u32 ring_n
 int virtnet_tx_resize(struct virtnet_info *vi, struct virtnet_sq *sq, u32 ring_num);
 int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs);
 void virtnet_dev_rx_queue_group(struct virtnet_info *vi, struct net_device *dev);
+const struct net_device_ops *virtnet_get_netdev(void);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
