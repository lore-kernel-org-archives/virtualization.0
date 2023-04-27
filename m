Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B851C77B60
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 03:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA2316159C;
	Thu, 27 Apr 2023 03:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA2316159C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNvxAC2ll_GQ; Thu, 27 Apr 2023 03:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2989C615A2;
	Thu, 27 Apr 2023 03:06:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2989C615A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87123C008E;
	Thu, 27 Apr 2023 03:05:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 987ADC0090
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53CA840B79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53CA840B79
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynH6vl1WDfK0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB77541C78
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB77541C78
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vh5kKqO_1682564749; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vh5kKqO_1682564749) by smtp.aliyun-inc.com;
 Thu, 27 Apr 2023 11:05:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v4 13/15] virtio_net: small: remove skip_xdp
Date: Thu, 27 Apr 2023 11:05:32 +0800
Message-Id: <20230427030534.115066-14-xuanzhuo@linux.alibaba.com>
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

Because the skb build code is not shared between xdp and non-xdp, and
the xdp code in receive_small() is simpler, so "skip_xdp" is not needed.
We can remove it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f832ab8a3e6e..a76db3d19eb7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1024,13 +1024,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
 				     unsigned int *xdp_xmit,
 				     struct virtnet_rq_stats *stats)
 {
-	struct sk_buff *skb;
-	struct bpf_prog *xdp_prog;
 	unsigned int xdp_headroom = (unsigned long)ctx;
 	struct page *page = virt_to_head_page(buf);
 	unsigned int header_offset;
 	unsigned int headroom;
 	unsigned int buflen;
+	struct sk_buff *skb;
 
 	len -= vi->hdr_len;
 	stats->bytes += len;
@@ -1042,22 +1041,21 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		goto err;
 	}
 
-	if (likely(!vi->xdp_enabled)) {
-		xdp_prog = NULL;
-		goto skip_xdp;
-	}
+	if (unlikely(vi->xdp_enabled)) {
+		struct bpf_prog *xdp_prog;
 
-	rcu_read_lock();
-	xdp_prog = rcu_dereference(rq->xdp_prog);
-	if (xdp_prog) {
-		skb = receive_small_xdp(dev, vi, rq, xdp_prog, buf, xdp_headroom,
-					len, xdp_xmit, stats);
+		rcu_read_lock();
+		xdp_prog = rcu_dereference(rq->xdp_prog);
+		if (xdp_prog) {
+			skb = receive_small_xdp(dev, vi, rq, xdp_prog, buf,
+						xdp_headroom, len, xdp_xmit,
+						stats);
+			rcu_read_unlock();
+			return skb;
+		}
 		rcu_read_unlock();
-		return skb;
 	}
-	rcu_read_unlock();
 
-skip_xdp:
 	header_offset = VIRTNET_RX_PAD + xdp_headroom;
 	headroom = vi->hdr_len + header_offset;
 	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
