Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A8BC48BE6
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E7661438
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E7661438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15887831A2;
	Thu, 10 Jun 2021 08:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s--sfMEAlw5W; Thu, 10 Jun 2021 08:22:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 867E48293D;
	Thu, 10 Jun 2021 08:22:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79EF9C002D;
	Thu, 10 Jun 2021 08:22:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A2F4C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CC80606F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7FUex1H__Ig
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25149606A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0UbxH89d_1623313332; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UbxH89d_1623313332) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Jun 2021 16:22:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 08/15] virtio-net: split the receive_mergeable
 function
Date: Thu, 10 Jun 2021 16:22:02 +0800
Message-Id: <20210610082209.91487-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

receive_mergeable() is too complicated, so this function is split here.
One is to make the function more readable. On the other hand, the two
independent functions will be called separately in subsequent patches.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 181 ++++++++++++++++++++++++---------------
 1 file changed, 111 insertions(+), 70 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3fd87bf2b2ad..989aba600e63 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -733,6 +733,109 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	return NULL;
 }
 
+static void merge_drop_follow_bufs(struct net_device *dev,
+				   struct receive_queue *rq,
+				   u16 num_buf,
+				   struct virtnet_rq_stats *stats)
+{
+	struct page *page;
+	unsigned int len;
+	void *buf;
+
+	while (num_buf-- > 1) {
+		buf = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!buf)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 dev->name, num_buf);
+			dev->stats.rx_length_errors++;
+			break;
+		}
+		stats->bytes += len;
+		page = virt_to_head_page(buf);
+		put_page(page);
+	}
+}
+
+static struct sk_buff *merge_receive_follow_bufs(struct net_device *dev,
+						 struct virtnet_info *vi,
+						 struct receive_queue *rq,
+						 struct sk_buff *head_skb,
+						 u16 num_buf,
+						 struct virtnet_rq_stats *stats)
+{
+	struct sk_buff *curr_skb;
+	unsigned int truesize;
+	unsigned int len, num;
+	struct page *page;
+	void *buf, *ctx;
+	int offset;
+
+	curr_skb = head_skb;
+	num = num_buf;
+
+	while (--num_buf) {
+		int num_skb_frags;
+
+		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
+		if (unlikely(!buf)) {
+			pr_debug("%s: rx error: %d buffers out of %d missing\n",
+				 dev->name, num_buf, num);
+			dev->stats.rx_length_errors++;
+			goto err_buf;
+		}
+
+		stats->bytes += len;
+		page = virt_to_head_page(buf);
+
+		truesize = mergeable_ctx_to_truesize(ctx);
+		if (unlikely(len > truesize)) {
+			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+				 dev->name, len, (unsigned long)ctx);
+			dev->stats.rx_length_errors++;
+			goto err_skb;
+		}
+
+		num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
+		if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
+			struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
+
+			if (unlikely(!nskb))
+				goto err_skb;
+			if (curr_skb == head_skb)
+				skb_shinfo(curr_skb)->frag_list = nskb;
+			else
+				curr_skb->next = nskb;
+			curr_skb = nskb;
+			head_skb->truesize += nskb->truesize;
+			num_skb_frags = 0;
+		}
+		if (curr_skb != head_skb) {
+			head_skb->data_len += len;
+			head_skb->len += len;
+			head_skb->truesize += truesize;
+		}
+		offset = buf - page_address(page);
+		if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
+			put_page(page);
+			skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
+					     len, truesize);
+		} else {
+			skb_add_rx_frag(curr_skb, num_skb_frags, page,
+					offset, len, truesize);
+		}
+	}
+
+	return head_skb;
+
+err_skb:
+	put_page(page);
+	merge_drop_follow_bufs(dev, rq, num_buf, stats);
+err_buf:
+	stats->drops++;
+	dev_kfree_skb(head_skb);
+	return NULL;
+}
+
 static struct sk_buff *receive_small(struct net_device *dev,
 				     struct virtnet_info *vi,
 				     struct receive_queue *rq,
@@ -909,7 +1012,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
-	struct sk_buff *head_skb, *curr_skb;
+	struct sk_buff *head_skb;
 	struct bpf_prog *xdp_prog;
 	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
@@ -1054,65 +1157,15 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
 			       metasize, !!headroom);
-	curr_skb = head_skb;
-
-	if (unlikely(!curr_skb))
+	if (unlikely(!head_skb))
 		goto err_skb;
-	while (--num_buf) {
-		int num_skb_frags;
 
-		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
-		if (unlikely(!buf)) {
-			pr_debug("%s: rx error: %d buffers out of %d missing\n",
-				 dev->name, num_buf,
-				 virtio16_to_cpu(vi->vdev,
-						 hdr->num_buffers));
-			dev->stats.rx_length_errors++;
-			goto err_buf;
-		}
-
-		stats->bytes += len;
-		page = virt_to_head_page(buf);
-
-		truesize = mergeable_ctx_to_truesize(ctx);
-		if (unlikely(len > truesize)) {
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, len, (unsigned long)ctx);
-			dev->stats.rx_length_errors++;
-			goto err_skb;
-		}
-
-		num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
-		if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
-			struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
-
-			if (unlikely(!nskb))
-				goto err_skb;
-			if (curr_skb == head_skb)
-				skb_shinfo(curr_skb)->frag_list = nskb;
-			else
-				curr_skb->next = nskb;
-			curr_skb = nskb;
-			head_skb->truesize += nskb->truesize;
-			num_skb_frags = 0;
-		}
-		if (curr_skb != head_skb) {
-			head_skb->data_len += len;
-			head_skb->len += len;
-			head_skb->truesize += truesize;
-		}
-		offset = buf - page_address(page);
-		if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
-			put_page(page);
-			skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
-					     len, truesize);
-		} else {
-			skb_add_rx_frag(curr_skb, num_skb_frags, page,
-					offset, len, truesize);
-		}
-	}
+	if (num_buf > 1)
+		head_skb = merge_receive_follow_bufs(dev, vi, rq, head_skb,
+						     num_buf, stats);
+	if (head_skb)
+		ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);
 
-	ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);
 	return head_skb;
 
 err_xdp:
@@ -1120,19 +1173,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	stats->xdp_drops++;
 err_skb:
 	put_page(page);
-	while (num_buf-- > 1) {
-		buf = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!buf)) {
-			pr_debug("%s: rx error: %d buffers missing\n",
-				 dev->name, num_buf);
-			dev->stats.rx_length_errors++;
-			break;
-		}
-		stats->bytes += len;
-		page = virt_to_head_page(buf);
-		put_page(page);
-	}
-err_buf:
+	merge_drop_follow_bufs(dev, rq, num_buf, stats);
 	stats->drops++;
 	dev_kfree_skb(head_skb);
 xdp_xmit:
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
