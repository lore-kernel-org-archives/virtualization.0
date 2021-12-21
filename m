Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074A2C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 01:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59499409C9;
	Tue, 21 Dec 2021 01:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-j84W4wXGfi; Tue, 21 Dec 2021 01:58:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF7FB40129;
	Tue, 21 Dec 2021 01:58:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 998B8C001E;
	Tue, 21 Dec 2021 01:58:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A843FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8188A409BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:58:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4mA_oX2jg2b2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:58:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F68240129
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:58:43 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 46D20B8110B;
 Tue, 21 Dec 2021 01:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FC0C36AEA;
 Tue, 21 Dec 2021 01:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640051919;
 bh=i5NdvtJkmeX104ODEzdrBY1EYBH6FWDEKFIIEEhroZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iqyNH4gIOdq8Bn3lBJsfQZmNYDHlIS2rbi4BwsJLZBSi3myck1v6Pi55L/qBtSQAx
 SR3V2jANl9EThRd+eWC0s1x3S1UuwOqUdaxvTvoHHuyJ2/jtkQwY3x5Ou6fKKR7Pi9
 IeKOweltyZRGXcIj/f5WkjsU0u0zHBa1ka1P3ui0e5j62IllHfO/KCrJi6G4nqA6cJ
 fvhmqkQo6dB0AUN2ZLZ+titrMFL82xAM44FCSbLY0LKUAtURcW9M5pjaDHwzcB67aJ
 pdUjeeOObXbZLCcHJ2zyo9WBukrBfzKLnMO9HNNqSAudGU38V+scXGBXyySqRr80h6
 vO/JUo+Ot7Bfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 22/29] virtio_net: fix rx_drops stat for small
 pkts
Date: Mon, 20 Dec 2021 20:57:43 -0500
Message-Id: <20211221015751.116328-22-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221015751.116328-1-sashal@kernel.org>
References: <20211221015751.116328-1-sashal@kernel.org>
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
index 4ad25a8b0870c..1231b48f7183e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -730,7 +730,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		pr_debug("%s: rx error: len %u exceeds max size %d\n",
 			 dev->name, len, GOOD_PACKET_LEN);
 		dev->stats.rx_length_errors++;
-		goto err_len;
+		goto err;
 	}
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
@@ -815,10 +815,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
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
@@ -829,13 +827,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
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
