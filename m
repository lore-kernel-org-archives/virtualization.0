Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F2145A17
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165065; cv=none; b=fIaMw8mib678gGZgM2Pf0uPgCp19t2ZA/jhKfhsBnE6WUNQxXSzW45qTc3C43bJBgrYWteuQxesRR58/0ZNP9GcPvXSTP6InY6ePmVRHiPC1OyoFKPcjisLTr/cDRRKtw2eEVyWvIAY4s5L123Z4ceRd/3hjdmvQhiHKB/XKmbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165065; c=relaxed/simple;
	bh=Q8quGDSZzYUbIq22I2pv0We8cWtmL2jLiqoJdbdM8As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nC1sd82O/6Q16rIGOIWGHkxLQrgirXq0+hATumxD7mLyqcgZEkM0w3b4tapXB6BomVo7kjnZ48LsTJniOSvOzPbSKYgdiSYCbFxAIW1PpxSKfxS3p3msbZa21GVgLyrpBxRx4svBm8G3wtKerq3Q/ivVHTNSpHEmGw4R5nwkMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A/YSxbdv; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A/YSxbdv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720165061; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zNeiDwdkqzBfnWgHli0nRbhmznR8NhiOcj4IWvM1Tec=;
	b=A/YSxbdvYcwo9JaRbSOtu0kr1eMuNMT2SfkmK6wVqRYMYTjWt1s8Sb+QXL8qCeC1yeWMjQM0f1Oa0aBDwhuIfNZyGeYotv5wbXSpkOTCyyFyrC3a1C8sDzGdl4YKcnYwKjZPAX70aRmIoc1HNhubTqhq4MnkZuqXTuJA+k0A9V4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9u53pV_1720165059;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9u53pV_1720165059)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 15:37:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 05/10] virtio_net: separate receive_mergeable
Date: Fri,  5 Jul 2024 15:37:29 +0800
Message-Id: <20240705073734.93905-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: bfc652b69f2c
Content-Transfer-Encoding: 8bit

This commit separates the function receive_mergeable(),
put the logic of appending frag to the skb as an independent function.
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 77 ++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index abfc84af90ce..3c828cdd438b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1821,6 +1821,49 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	return NULL;
 }
 
+static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					       struct sk_buff *curr_skb,
+					       struct page *page, void *buf,
+					       int len, int truesize)
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
 					 struct receive_queue *rq,
@@ -1870,8 +1913,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(!curr_skb))
 		goto err_skb;
 	while (--num_buf) {
-		int num_skb_frags;
-
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
@@ -1896,34 +1937,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
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

