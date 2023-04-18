Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57948C7EE26
	for <virtualization@archiver.kernel.org>; Tue, 18 Apr 2023 06:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDD1981E05;
	Tue, 18 Apr 2023 06:53:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDD1981E05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWNNvE6gnbow; Tue, 18 Apr 2023 06:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8362A817EB;
	Tue, 18 Apr 2023 06:53:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8362A817EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41206C002A;
	Tue, 18 Apr 2023 06:53:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C01C008B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 994C341043
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 994C341043
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RaJq8ZrbpnVJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BE4140CC8
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BE4140CC8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VgOLniu_1681800813; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgOLniu_1681800813) by smtp.aliyun-inc.com;
 Tue, 18 Apr 2023 14:53:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 06/14] virtio_net: separate the logic of freeing
 xdp shinfo
Date: Tue, 18 Apr 2023 14:53:19 +0800
Message-Id: <20230418065327.72281-7-xuanzhuo@linux.alibaba.com>
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

This patch introduce a new function that releases the
xdp shinfo. The subsequent patch will reuse this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4dfdc211d355..5cec4b418110 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -798,6 +798,21 @@ static int virtnet_xdp_xmit(struct net_device *dev,
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
@@ -1315,12 +1330,9 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
 		unsigned int xdp_frags_truesz = 0;
-		struct skb_shared_info *shinfo;
-		struct page *xdp_page;
 		struct xdp_buff xdp;
 		void *data;
 		u32 act;
-		int i;
 
 		data = mergeable_xdp_prepare(vi, rq, xdp_prog, ctx, &frame_sz,
 					     &num_buf, &page, offset, &len, hdr);
@@ -1351,14 +1363,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			break;
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
