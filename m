Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E09C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 01:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EA2640929;
	Tue, 21 Dec 2021 01:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mU5wKEfezMHa; Tue, 21 Dec 2021 01:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 276CF4090E;
	Tue, 21 Dec 2021 01:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F40B3C001E;
	Tue, 21 Dec 2021 01:59:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7066C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C707E60692
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YyGYormkNZ_i
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:59:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BDF26064D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:59:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ECE3B61166;
 Tue, 21 Dec 2021 01:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7A3C36AEB;
 Tue, 21 Dec 2021 01:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640051989;
 bh=+31zAUEqLZ4p24DVIeYtdQ9QUYg7k8xqpKZZRE+cjjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mrQ08xn+AqWnvTEmOZzwRfLhIH7McrMszdA789U2HplUiYcWVnD2HJz/F2r0RV+Av
 X2U/jN7caLrjcQcYSaYWrLrfdosDSaHdiEa6iFmh2x4Ng/jtYrMZvSFaXHFIVb1EG0
 M98wPJpiRwZChyrFbCTCI0tOEOf2+J7jIcgyBn2mYDVqWFUdEEqij6p9DClgplplvd
 +EfgRyY1uTw0JYKZI/4GLpgl9GEnhgVmnS7iOxshWhpxhqpezypA9Mb6blMoXwyrzE
 BjCagMVjyUZX6dPxo60Jemi8lBlZbR+qvGOIWK385xjDxRmT4AXAIOKro3c+qFCzhP
 yS4kzMigl5QMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/19] virtio_net: fix rx_drops stat for small
 pkts
Date: Mon, 20 Dec 2021 20:59:12 -0500
Message-Id: <20211221015914.116767-17-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221015914.116767-1-sashal@kernel.org>
References: <20211221015914.116767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, Wenliang Wang <wangwenliang.1995@bytedance.com>,
 "David S . Miller" <davem@davemloft.net>
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

From: Wenliang Wang <wangwenliang.1995@bytedance.com>

[ Upstream commit 053c9e18c6f9cf82242ef35ac21cae1842725714 ]

We found the stat of rx drops for small pkts does not increment when
build_skb fail, it's not coherent with other mode's rx drops stat.

Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cbe47eed7cc3c..3ba289b695f04 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -697,7 +697,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		pr_debug("%s: rx error: len %u exceeds max size %d\n",
 			 dev->name, len, GOOD_PACKET_LEN);
 		dev->stats.rx_length_errors++;
-		goto err_len;
+		goto err;
 	}
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
@@ -782,10 +782,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	rcu_read_unlock();
 
 	skb = build_skb(buf, buflen);
-	if (!skb) {
-		put_page(page);
+	if (!skb)
 		goto err;
-	}
 	skb_reserve(skb, headroom - delta);
 	skb_put(skb, len);
 	if (!xdp_prog) {
@@ -796,13 +794,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
-err:
 	return skb;
 
 err_xdp:
 	rcu_read_unlock();
 	stats->xdp_drops++;
-err_len:
+err:
 	stats->drops++;
 	put_page(page);
 xdp_xmit:
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
