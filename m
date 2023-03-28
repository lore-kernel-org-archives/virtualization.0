Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32918C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 12:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFF37611D9;
	Tue, 28 Mar 2023 12:04:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFF37611D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyPQeT5pFQMg; Tue, 28 Mar 2023 12:04:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 356FA60D7B;
	Tue, 28 Mar 2023 12:04:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 356FA60D7B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C38BC0037;
	Tue, 28 Mar 2023 12:04:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C3A9C008F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6240560D7B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6240560D7B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id miamDwmdpXci
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 365C560F47
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 365C560F47
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:20 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vet498F_1680005054; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vet498F_1680005054) by smtp.aliyun-inc.com;
 Tue, 28 Mar 2023 20:04:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 2/8] virtio_net: mergeable xdp: introduce
 mergeable_xdp_prepare
Date: Tue, 28 Mar 2023 20:04:06 +0800
Message-Id: <20230328120412.110114-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 822c071fd47f
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

Separating the logic of preparation for xdp from receive_mergeable.

The purpose of this is to simplify the logic of execution of XDP.

The main logic here is that when headroom is insufficient, we need to
allocate a new page and calculate offset. It should be noted that if
there is new page, the variable page will refer to the new page.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 135 ++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 58 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4d2bf1ce0730..bb426958cdd4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1162,6 +1162,79 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 	return 0;
 }
 
+static void *mergeable_xdp_prepare(struct virtnet_info *vi,
+				   struct receive_queue *rq,
+				   struct bpf_prog *xdp_prog,
+				   void *ctx,
+				   unsigned int *frame_sz,
+				   int *num_buf,
+				   struct page **page,
+				   int offset,
+				   unsigned int *len,
+				   struct virtio_net_hdr_mrg_rxbuf *hdr)
+{
+	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
+	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
+	struct page *xdp_page;
+	unsigned int xdp_room;
+
+	/* Transient failure which in theory could occur if
+	 * in-flight packets from before XDP was enabled reach
+	 * the receive path after XDP is loaded.
+	 */
+	if (unlikely(hdr->hdr.gso_type))
+		return NULL;
+
+	/* Now XDP core assumes frag size is PAGE_SIZE, but buffers
+	 * with headroom may add hole in truesize, which
+	 * make their length exceed PAGE_SIZE. So we disabled the
+	 * hole mechanism for xdp. See add_recvbuf_mergeable().
+	 */
+	*frame_sz = truesize;
+
+	/* This happens when headroom is not enough because
+	 * of the buffer was prefilled before XDP is set.
+	 * This should only happen for the first several packets.
+	 * In fact, vq reset can be used here to help us clean up
+	 * the prefilled buffers, but many existing devices do not
+	 * support it, and we don't want to bother users who are
+	 * using xdp normally.
+	 */
+	if (!xdp_prog->aux->xdp_has_frags &&
+	    (*num_buf > 1 || headroom < virtnet_get_headroom(vi))) {
+		/* linearize data for XDP */
+		xdp_page = xdp_linearize_page(rq, num_buf,
+					      *page, offset,
+					      VIRTIO_XDP_HEADROOM,
+					      len);
+
+		if (!xdp_page)
+			return NULL;
+	} else if (unlikely(headroom < virtnet_get_headroom(vi))) {
+		xdp_room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
+					  sizeof(struct skb_shared_info));
+		if (*len + xdp_room > PAGE_SIZE)
+			return NULL;
+
+		xdp_page = alloc_page(GFP_ATOMIC);
+		if (!xdp_page)
+			return NULL;
+
+		memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
+		       page_address(*page) + offset, *len);
+	} else {
+		return page_address(*page) + offset;
+	}
+
+	*frame_sz = PAGE_SIZE;
+
+	put_page(*page);
+
+	*page = xdp_page;
+
+	return page_address(xdp_page) + VIRTIO_XDP_HEADROOM;
+}
+
 static struct sk_buff *receive_mergeable(struct net_device *dev,
 					 struct virtnet_info *vi,
 					 struct receive_queue *rq,
@@ -1181,7 +1254,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
 	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
-	unsigned int frame_sz, xdp_room;
+	unsigned int frame_sz;
 	int err;
 
 	head_skb = NULL;
@@ -1211,65 +1284,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		u32 act;
 		int i;
 
-		/* Transient failure which in theory could occur if
-		 * in-flight packets from before XDP was enabled reach
-		 * the receive path after XDP is loaded.
-		 */
-		if (unlikely(hdr->hdr.gso_type))
+		data = mergeable_xdp_prepare(vi, rq, xdp_prog, ctx, &frame_sz, &num_buf, &page,
+					     offset, &len, hdr);
+		if (!data)
 			goto err_xdp;
 
-		/* Now XDP core assumes frag size is PAGE_SIZE, but buffers
-		 * with headroom may add hole in truesize, which
-		 * make their length exceed PAGE_SIZE. So we disabled the
-		 * hole mechanism for xdp. See add_recvbuf_mergeable().
-		 */
-		frame_sz = truesize;
-
-		/* This happens when headroom is not enough because
-		 * of the buffer was prefilled before XDP is set.
-		 * This should only happen for the first several packets.
-		 * In fact, vq reset can be used here to help us clean up
-		 * the prefilled buffers, but many existing devices do not
-		 * support it, and we don't want to bother users who are
-		 * using xdp normally.
-		 */
-		if (!xdp_prog->aux->xdp_has_frags &&
-		    (num_buf > 1 || headroom < virtnet_get_headroom(vi))) {
-			/* linearize data for XDP */
-			xdp_page = xdp_linearize_page(rq, &num_buf,
-						      page, offset,
-						      VIRTIO_XDP_HEADROOM,
-						      &len);
-			frame_sz = PAGE_SIZE;
-
-			if (!xdp_page)
-				goto err_xdp;
-			offset = VIRTIO_XDP_HEADROOM;
-
-			put_page(page);
-			page = xdp_page;
-		} else if (unlikely(headroom < virtnet_get_headroom(vi))) {
-			xdp_room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
-						  sizeof(struct skb_shared_info));
-			if (len + xdp_room > PAGE_SIZE)
-				goto err_xdp;
-
-			xdp_page = alloc_page(GFP_ATOMIC);
-			if (!xdp_page)
-				goto err_xdp;
-
-			memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
-			       page_address(page) + offset, len);
-			frame_sz = PAGE_SIZE;
-			offset = VIRTIO_XDP_HEADROOM;
-
-			put_page(page);
-			page = xdp_page;
-		} else {
-			xdp_page = page;
-		}
-
-		data = page_address(xdp_page) + offset;
 		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
 						 &num_buf, &xdp_frags_truesz, stats);
 		if (unlikely(err))
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
