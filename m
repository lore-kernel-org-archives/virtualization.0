Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC86C77B7F
	for <virtualization@archiver.kernel.org>; Tue, 18 Apr 2023 06:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 573BC613BC;
	Tue, 18 Apr 2023 06:53:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 573BC613BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NmUtMbRXEPE; Tue, 18 Apr 2023 06:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 000B7614A1;
	Tue, 18 Apr 2023 06:53:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 000B7614A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E483C0092;
	Tue, 18 Apr 2023 06:53:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D924DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE6A740C12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE6A740C12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id an0xc9gEwZyj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC081415C8
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC081415C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VgOKk2I_1681800820; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgOKk2I_1681800820) by smtp.aliyun-inc.com;
 Tue, 18 Apr 2023 14:53:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 12/14] virtio_net: small: optimize code
Date: Tue, 18 Apr 2023 14:53:25 +0800
Message-Id: <20230418065327.72281-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d931ac25730a
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

In the case of XDP-PASS, skb_reserve uses the delta to compatible
non-XDP, now remove this logic.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 34220f5f27d1..f6f5903face2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -959,9 +959,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int buflen;
 	struct xdp_buff xdp;
 	struct sk_buff *skb;
-	unsigned int delta = 0;
 	unsigned int metasize = 0;
-	void *orig_data;
 	u32 act;
 
 	if (unlikely(hdr->hdr.gso_type))
@@ -994,14 +992,12 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
 	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
-	orig_data = xdp.data;
 
 	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case VIRTNET_XDP_RES_PASS:
 		/* Recalculate length in case bpf program changed it */
-		delta = orig_data - xdp.data;
 		len = xdp.data_end - xdp.data;
 		metasize = xdp.data - xdp.data_meta;
 		break;
@@ -1017,7 +1013,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
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
