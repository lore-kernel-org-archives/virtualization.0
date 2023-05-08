Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8233C7EE24
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D77E410E4;
	Mon,  8 May 2023 06:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D77E410E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yM8EIgp_Cy0Y; Mon,  8 May 2023 06:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 789644138D;
	Mon,  8 May 2023 06:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 789644138D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D17C0037;
	Mon,  8 May 2023 06:14:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 495BCC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3084061411
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3084061411
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HIZtth3eEvm7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B14FA6140D
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B14FA6140D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:40 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vi.E8Al_1683526475; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vi.E8Al_1683526475) by smtp.aliyun-inc.com;
 Mon, 08 May 2023 14:14:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 15/15] virtio_net: introduce virtnet_build_skb()
Date: Mon,  8 May 2023 14:14:17 +0800
Message-Id: <20230508061417.65297-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com>
References: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 847ebbc5df1e
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
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

This logic is used in multiple places, now we separate it into
a helper.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 37287ede1959..97241006d64a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -443,6 +443,22 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
+static struct sk_buff *virtnet_build_skb(void *buf, unsigned int buflen,
+					 unsigned int headroom,
+					 unsigned int len)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(buf, buflen);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, len);
+
+	return skb;
+}
+
 /* Called from bottom half context */
 static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   struct receive_queue *rq,
@@ -476,13 +492,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	/* copy small packet so we can reuse these pages */
 	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
-		skb = build_skb(buf, truesize);
+		skb = virtnet_build_skb(buf, truesize, p - buf, len);
 		if (unlikely(!skb))
 			return NULL;
 
-		skb_reserve(skb, p - buf);
-		skb_put(skb, len);
-
 		page = (struct page *)page->private;
 		if (page)
 			give_pages(rq, page);
@@ -946,13 +959,10 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
 	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	skb = build_skb(buf, buflen);
-	if (!skb)
+	skb = virtnet_build_skb(buf, buflen, headroom, len);
+	if (unlikely(!skb))
 		return NULL;
 
-	skb_reserve(skb, headroom);
-	skb_put(skb, len);
-
 	buf += header_offset;
 	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
 
@@ -1028,12 +1038,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		goto err_xdp;
 	}
 
-	skb = build_skb(buf, buflen);
-	if (!skb)
+	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
+	if (unlikely(!skb))
 		goto err;
 
-	skb_reserve(skb, xdp.data - buf);
-	skb_put(skb, len);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
