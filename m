Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC85C76195
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 04:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38A6E8138B;
	Wed, 15 Mar 2023 04:11:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38A6E8138B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Co4QqP2xk6rv; Wed, 15 Mar 2023 04:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BF91881386;
	Wed, 15 Mar 2023 04:11:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF91881386
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F448C0095;
	Wed, 15 Mar 2023 04:11:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F6A5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B56C402C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:10:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B56C402C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MB9Jm7Pr6Lkm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:10:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D498840490
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D498840490
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:10:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vdui0Pt_1678853447; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vdui0Pt_1678853447) by smtp.aliyun-inc.com;
 Wed, 15 Mar 2023 12:10:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [RFC net-next 4/8] virtio_net: separate the logic of freeing xdp
 shinfo
Date: Wed, 15 Mar 2023 12:10:38 +0800
Message-Id: <20230315041042.88138-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230315041042.88138-1-xuanzhuo@linux.alibaba.com>
References: <20230315041042.88138-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: a046238c058f
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

This patch introduce a new function that releases the
xdp shinfo. The subsequent patch will reuse this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 13c43b609465..cd6ee3060259 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -728,6 +728,21 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	return ret;
 }
 
+static void put_xdp_frags(struct xdp_buff *xdp)
+{
+	struct skb_shared_info *shinfo;
+	struct page *xdp_page;
+	int i;
+
+	if (xdp_buff_has_frags(xdp)) {
+		shinfo = xdp_get_shared_info_from_buff(xdp);
+		for (i = 0; i < shinfo->nr_frags; i++) {
+			xdp_page = skb_frag_page(&shinfo->frags[i]);
+			put_page(xdp_page);
+		}
+	}
+}
+
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -1242,12 +1257,9 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
 		unsigned int xdp_frags_truesz = 0;
-		struct skb_shared_info *shinfo;
-		struct page *xdp_page;
 		struct xdp_buff xdp;
 		void *data;
 		u32 act;
-		int i;
 
 		data = mergeable_xdp_prepare(vi, rq, xdp_prog, ctx, &frame_sz, &num_buf, &page,
 					     offset, &len, hdr);
@@ -1278,14 +1290,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_xdp_frags;
 		}
 err_xdp_frags:
-		if (xdp_buff_has_frags(&xdp)) {
-			shinfo = xdp_get_shared_info_from_buff(&xdp);
-			for (i = 0; i < shinfo->nr_frags; i++) {
-				xdp_page = skb_frag_page(&shinfo->frags[i]);
-				put_page(xdp_page);
-			}
-		}
-
+		put_xdp_frags(&xdp);
 		goto err_xdp;
 	}
 	rcu_read_unlock();
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
