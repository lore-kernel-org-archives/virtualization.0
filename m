Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3A45BE3
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155531; cv=none; b=V4u92y9JobbrrxK9FDr7TI2MV7lz+WgS3wuVLLHYsHwJrGFjEjYO5sApnqgmdYytkNOtkczDFD5Fw/4M2mP8gc3ARvn3y2TTNWysWs0if0uSTywSKhPf5uW5CMXp9RqmoGjJHGluQk+XbiygWKELaQoXMV6QNqvTDJUSOqZYDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155531; c=relaxed/simple;
	bh=Te0x5hlODp+W8AKryq+l7/SXhpSkgbvArbq33/n59QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrSx91R7Rkh8U7XfU+KWPg4fq2cMESrFBniD3abY316d1o/1DkDPeVgofT2c4zdBjX37qiUtXE98/TFwEMy/M2WmAS6IuiDKnMQ3qRN93jkMWQ520VFGkNVDqhpdnRmsU5tCv8AVe6p1Ts1NszHqeIlPZQVaqncprC+7bsB31H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FNPayale; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FNPayale"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715155527; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KV0nvtldkaQ2bcwhhJ6rkZloeyeG7gVopjQSHqxFBgg=;
	b=FNPayalexqKg3F9HwahuTugCR+2D1PRfX0+j0vBEuoS8NFyNU9+8MeNEDUBu3y/w4oErKxS55xsC6dud1CKd1f+UY2mMY07Cc8viFNYvK30JKQiGIW8OlhYHEW+aXstA6MlpgLCOOUNX6iL0wW76u4WJDKRWpSOiMUHI8Iub+IQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W62mvi3_1715155523;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62mvi3_1715155523)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 16:05:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 6/7] virtio_net: separate receive_mergeable
Date: Wed,  8 May 2024 16:05:13 +0800
Message-Id: <20240508080514.99458-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 7cdcbabd0b89
Content-Transfer-Encoding: 8bit

This commit separates the function receive_mergeable(),
put the logic of appending frag to the skb as an independent function.
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet.h      |  4 ++
 drivers/net/virtio/virtnet_main.c | 77 +++++++++++++++++++------------
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
index 9dce5df88fe1..35e8526d2ef3 100644
--- a/drivers/net/virtio/virtnet.h
+++ b/drivers/net/virtio/virtnet.h
@@ -239,4 +239,8 @@ void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
+struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					struct sk_buff *curr_skb,
+					struct page *page, void *buf,
+					int len, int truesize);
 #endif
diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index 1701640980ba..fcfe190300a6 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -1549,6 +1549,49 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	return NULL;
 }
 
+struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					struct sk_buff *curr_skb,
+					struct page *page, void *buf,
+					int len, int truesize)
+{
+	int num_skb_frags;
+	int offset;
+
+	num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
+	if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
+		struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
+
+		if (unlikely(!nskb))
+			return NULL;
+
+		if (curr_skb == head_skb)
+			skb_shinfo(curr_skb)->frag_list = nskb;
+		else
+			curr_skb->next = nskb;
+		curr_skb = nskb;
+		head_skb->truesize += nskb->truesize;
+		num_skb_frags = 0;
+	}
+
+	if (curr_skb != head_skb) {
+		head_skb->data_len += len;
+		head_skb->len += len;
+		head_skb->truesize += truesize;
+	}
+
+	offset = buf - page_address(page);
+	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
+		put_page(page);
+		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
+				     len, truesize);
+	} else {
+		skb_add_rx_frag(curr_skb, num_skb_frags, page,
+				offset, len, truesize);
+	}
+
+	return curr_skb;
+}
+
 static struct sk_buff *receive_mergeable(struct net_device *dev,
 					 struct virtnet_info *vi,
 					 struct virtnet_rq *rq,
@@ -1598,8 +1641,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(!curr_skb))
 		goto err_skb;
 	while (--num_buf) {
-		int num_skb_frags;
-
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
@@ -1624,34 +1665,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_skb;
 		}
 
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
+		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+						    buf, len, truesize);
+		if (!curr_skb)
+			goto err_skb;
 	}
 
 	ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);
-- 
2.32.0.3.g01195cf9f

