Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA8C6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 08:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D6AB40643;
	Tue, 14 Mar 2023 08:39:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D6AB40643
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvR-cgoCvz6B; Tue, 14 Mar 2023 08:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 004EC4058D;
	Tue, 14 Mar 2023 08:39:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 004EC4058D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE9C3C0071;
	Tue, 14 Mar 2023 08:39:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1C81C0071
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 08:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C59B5814C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 08:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C59B5814C9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T8ArwI0VXBOc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 08:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40125814BB
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40125814BB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 08:39:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VdraCBA_1678783143; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdraCBA_1678783143) by smtp.aliyun-inc.com;
 Tue, 14 Mar 2023 16:39:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net 2/2] virtio_net: free xdp shinfo frags when
 build_skb_from_xdp_buff() fails
Date: Tue, 14 Mar 2023 16:39:01 +0800
Message-Id: <20230314083901.40521-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230314083901.40521-1-xuanzhuo@linux.alibaba.com>
References: <20230314083901.40521-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 007492630ac1
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Heng Qi <hengqi@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

build_skb_from_xdp_buff() may return NULL, on this
scene we need to free the frags of xdp shinfo.

Fixes: fab89bafa95b ("virtio-net: support multi-buffer xdp")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8ecf7a341d54..d36183be0481 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1273,9 +1273,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 		switch (act) {
 		case XDP_PASS:
+			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
+			if (!head_skb)
+				goto err_xdp_frags;
+
 			if (unlikely(xdp_page != page))
 				put_page(page);
-			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 			rcu_read_unlock();
 			return head_skb;
 		case XDP_TX:
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
