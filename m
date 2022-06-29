Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D964C43334
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 06:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9036419C0;
	Wed, 29 Jun 2022 06:58:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9036419C0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oftTwuT4DHKi; Wed, 29 Jun 2022 06:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED1344017A;
	Wed, 29 Jun 2022 06:58:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED1344017A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C408AC0032;
	Wed, 29 Jun 2022 06:58:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 306FBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F154361212
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:58:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F154361212
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ih4agfPOaali
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 564616121B
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 564616121B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:58:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHml8K4_1656485902; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHml8K4_1656485902) by smtp.aliyun-inc.com;
 Wed, 29 Jun 2022 14:58:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v11 40/40] virtio_net: support set_ringparam
Date: Wed, 29 Jun 2022 14:56:56 +0800
Message-Id: <20220629065656.54420-41-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 3fdaf102dd89
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

Support set_ringparam based on virtio queue reset.

Users can use ethtool -G eth0 <ring_num> to modify the ring size of
virtio-net.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fd358462f802..cc554cbac431 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2330,6 +2330,53 @@ static void virtnet_get_ringparam(struct net_device *dev,
 	ring->tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
 }
 
+static int virtnet_set_ringparam(struct net_device *dev,
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *extack)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	u32 rx_pending, tx_pending;
+	struct receive_queue *rq;
+	struct send_queue *sq;
+	int i, err;
+
+	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
+		return -EINVAL;
+
+	rx_pending = virtqueue_get_vring_size(vi->rq[0].vq);
+	tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
+
+	if (ring->rx_pending == rx_pending &&
+	    ring->tx_pending == tx_pending)
+		return 0;
+
+	if (ring->rx_pending > virtqueue_get_vring_max_size(vi->rq[0].vq))
+		return -EINVAL;
+
+	if (ring->tx_pending > virtqueue_get_vring_max_size(vi->sq[0].vq))
+		return -EINVAL;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		rq = vi->rq + i;
+		sq = vi->sq + i;
+
+		if (ring->tx_pending != tx_pending) {
+			err = virtnet_tx_resize(vi, sq, ring->tx_pending);
+			if (err)
+				return err;
+		}
+
+		if (ring->rx_pending != rx_pending) {
+			err = virtnet_rx_resize(vi, rq, ring->rx_pending);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 {
 	struct net_device *dev = vi->dev;
@@ -2817,6 +2864,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
+	.set_ringparam = virtnet_set_ringparam,
 	.get_strings = virtnet_get_strings,
 	.get_sset_count = virtnet_get_sset_count,
 	.get_ethtool_stats = virtnet_get_ethtool_stats,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
