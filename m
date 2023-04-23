Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB26C77B7C
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 10:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B210611D4;
	Sun, 23 Apr 2023 10:57:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B210611D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibZlag-3b-wq; Sun, 23 Apr 2023 10:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F30BA60F2A;
	Sun, 23 Apr 2023 10:57:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F30BA60F2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2A26C008F;
	Sun, 23 Apr 2023 10:57:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BAC9C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 10:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4CBF40BCB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 10:57:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4CBF40BCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id manblWaMqLak
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 10:57:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4A9E40BB7
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4A9E40BB7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 10:57:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vgjkwjl_1682247469; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vgjkwjl_1682247469) by smtp.aliyun-inc.com;
 Sun, 23 Apr 2023 18:57:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v3 10/15] virtio_net: introduce receive_small_xdp()
Date: Sun, 23 Apr 2023 18:57:31 +0800
Message-Id: <20230423105736.56918-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 3bb17d92efad
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

The purpose of this patch is to simplify the receive_small().
Separate all the logic of XDP of small into a function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 165 ++++++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 65 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index de5a579e8603..9b5fd2e0d27f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -931,6 +931,99 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	return NULL;
 }
 
+static struct sk_buff *receive_small_xdp(struct net_device *dev,
+					 struct virtnet_info *vi,
+					 struct receive_queue *rq,
+					 struct bpf_prog *xdp_prog,
+					 void *buf,
+					 unsigned int xdp_headroom,
+					 unsigned int len,
+					 unsigned int *xdp_xmit,
+					 struct virtnet_rq_stats *stats)
+{
+	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
+	unsigned int headroom = vi->hdr_len + header_offset;
+	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
+	struct page *page = virt_to_head_page(buf);
+	struct page *xdp_page;
+	unsigned int buflen;
+	struct xdp_buff xdp;
+	struct sk_buff *skb;
+	unsigned int delta = 0;
+	unsigned int metasize = 0;
+	void *orig_data;
+	u32 act;
+
+	if (unlikely(hdr->hdr.gso_type))
+		goto err_xdp;
+
+	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	if (unlikely(xdp_headroom < virtnet_get_headroom(vi))) {
+		int offset = buf - page_address(page) + header_offset;
+		unsigned int tlen = len + vi->hdr_len;
+		int num_buf = 1;
+
+		xdp_headroom = virtnet_get_headroom(vi);
+		header_offset = VIRTNET_RX_PAD + xdp_headroom;
+		headroom = vi->hdr_len + header_offset;
+		buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
+			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+		xdp_page = xdp_linearize_page(rq, &num_buf, page,
+					      offset, header_offset,
+					      &tlen);
+		if (!xdp_page)
+			goto err_xdp;
+
+		buf = page_address(xdp_page);
+		put_page(page);
+		page = xdp_page;
+	}
+
+	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
+	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
+			 xdp_headroom, len, true);
+	orig_data = xdp.data;
+
+	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+
+	switch (act) {
+	case XDP_PASS:
+		/* Recalculate length in case bpf program changed it */
+		delta = orig_data - xdp.data;
+		len = xdp.data_end - xdp.data;
+		metasize = xdp.data - xdp.data_meta;
+		break;
+
+	case XDP_TX:
+	case XDP_REDIRECT:
+		goto xdp_xmit;
+
+	default:
+		goto err_xdp;
+	}
+
+	skb = build_skb(buf, buflen);
+	if (!skb)
+		goto err;
+
+	skb_reserve(skb, headroom - delta);
+	skb_put(skb, len);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
+	return skb;
+
+err_xdp:
+	stats->xdp_drops++;
+err:
+	stats->drops++;
+	put_page(page);
+xdp_xmit:
+	return NULL;
+}
+
 static struct sk_buff *receive_small(struct net_device *dev,
 				     struct virtnet_info *vi,
 				     struct receive_queue *rq,
@@ -947,9 +1040,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	unsigned int buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 			      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct page *page = virt_to_head_page(buf);
-	unsigned int delta = 0;
-	struct page *xdp_page;
-	unsigned int metasize = 0;
 
 	len -= vi->hdr_len;
 	stats->bytes += len;
@@ -969,56 +1059,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
-		struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
-		struct xdp_buff xdp;
-		void *orig_data;
-		u32 act;
-
-		if (unlikely(hdr->hdr.gso_type))
-			goto err_xdp;
-
-		if (unlikely(xdp_headroom < virtnet_get_headroom(vi))) {
-			int offset = buf - page_address(page) + header_offset;
-			unsigned int tlen = len + vi->hdr_len;
-			int num_buf = 1;
-
-			xdp_headroom = virtnet_get_headroom(vi);
-			header_offset = VIRTNET_RX_PAD + xdp_headroom;
-			headroom = vi->hdr_len + header_offset;
-			buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
-				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-			xdp_page = xdp_linearize_page(rq, &num_buf, page,
-						      offset, header_offset,
-						      &tlen);
-			if (!xdp_page)
-				goto err_xdp;
-
-			buf = page_address(xdp_page);
-			put_page(page);
-			page = xdp_page;
-		}
-
-		xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
-		xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
-				 xdp_headroom, len, true);
-		orig_data = xdp.data;
-
-		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
-
-		switch (act) {
-		case XDP_PASS:
-			/* Recalculate length in case bpf program changed it */
-			delta = orig_data - xdp.data;
-			len = xdp.data_end - xdp.data;
-			metasize = xdp.data - xdp.data_meta;
-			break;
-		case XDP_TX:
-		case XDP_REDIRECT:
-			rcu_read_unlock();
-			goto xdp_xmit;
-		default:
-			goto err_xdp;
-		}
+		skb = receive_small_xdp(dev, vi, rq, xdp_prog, buf, xdp_headroom,
+					len, xdp_xmit, stats);
+		rcu_read_unlock();
+		return skb;
 	}
 	rcu_read_unlock();
 
@@ -1026,25 +1070,16 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	skb = build_skb(buf, buflen);
 	if (!skb)
 		goto err;
-	skb_reserve(skb, headroom - delta);
+	skb_reserve(skb, headroom);
 	skb_put(skb, len);
-	if (!xdp_prog) {
-		buf += header_offset;
-		memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
-	} /* keep zeroed vnet hdr since XDP is loaded */
-
-	if (metasize)
-		skb_metadata_set(skb, metasize);
 
+	buf += header_offset;
+	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
 	return skb;
 
-err_xdp:
-	rcu_read_unlock();
-	stats->xdp_drops++;
 err:
 	stats->drops++;
 	put_page(page);
-xdp_xmit:
 	return NULL;
 }
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
