Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169E5C7618E
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 03:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6C0741EE7;
	Thu, 27 Apr 2023 03:05:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6C0741EE7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1OlUR28fvx6R; Thu, 27 Apr 2023 03:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1516641ED7;
	Thu, 27 Apr 2023 03:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1516641ED7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFAC5C0037;
	Thu, 27 Apr 2023 03:05:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C393C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD42261599
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD42261599
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bhY5MaDnEzHJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F8986158B
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F8986158B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vh5Z4Vt_1682564747; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vh5Z4Vt_1682564747) by smtp.aliyun-inc.com;
 Thu, 27 Apr 2023 11:05:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v4 11/15] virtio_net: small: remove the delta
Date: Thu, 27 Apr 2023 11:05:30 +0800
Message-Id: <20230427030534.115066-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
References: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 69b1082fef22
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

In the case of XDP-PASS, skb_reserve uses the "delta" to compatible
non-XDP, now that is not shared between xdp and non-xdp, so we can
remove this logic.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3b0f13ab6ccb..b8ec642899c9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -945,9 +945,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int buflen;
 	struct xdp_buff xdp;
 	struct sk_buff *skb;
-	unsigned int delta = 0;
 	unsigned int metasize = 0;
-	void *orig_data;
 	u32 act;
 
 	if (unlikely(hdr->hdr.gso_type))
@@ -980,14 +978,12 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
 	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
-	orig_data = xdp.data;
 
 	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
 		/* Recalculate length in case bpf program changed it */
-		delta = orig_data - xdp.data;
 		len = xdp.data_end - xdp.data;
 		metasize = xdp.data - xdp.data_meta;
 		break;
@@ -1004,7 +1000,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	if (!skb)
 		goto err;
 
-	skb_reserve(skb, headroom - delta);
+	skb_reserve(skb, xdp.data - buf);
 	skb_put(skb, len);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
