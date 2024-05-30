Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7F17E452
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068258; cv=none; b=ulIPqcKosUVTZ5O52NRDcZ3GtvmVAJHPA4GxQOx11i9XR6fEe5X9ApNU5Qr9g8fEaGaWKZzVev6c9wUoj3mNIIoNFbwSDdMkgW3BV5mRVWtbOTLM3JBXRWZDUcSS++vsHmL/NzRzQdZ01nRpXovcNEThQs/JmEq/QYK+RiYd+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068258; c=relaxed/simple;
	bh=4HJatNvYnORyBk9YePt0lzmlzyy66lhq7SzHlAlBsCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXMZYuAv4KjAknY8iM4wJbMpg/VuTBiB4gLfBSK0XJSpOOcqo1v2riqlkF4vWuQcm7U1hUcpuuiETLAFQgFR31OidOI4+Ad9TUNtK1ZkavW9rkM0rw7A2bgtyYkk3RHuEP2sHPWaFwCoMfhMHX8pUuKtlVjIr5fj+zKQADdjA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J34Tkgnj; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J34Tkgnj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068255; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+HRhomPQPCScn3cKxU1gXulNr5Gidi15NEakvEBHYh8=;
	b=J34Tkgnjm056mKhQPn32ylp0FXmiYa5WBgQRWfzSsqI4oxr08K+BqY+2L9Bq0aTbGXg9H5yRp7tAyNICU1xQ0qTvLlXyDwg7VqM8cJ0sRdJuEP3XHJ4/Vwq4nvuf2LCNxIV6ZnemQy9FV9qtXUAx4eUKZX33TxoQI1ZPjT6UH8Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7Wnmmj_1717068253;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7Wnmmj_1717068253)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 07/12] virtio_net: separate receive_buf
Date: Thu, 30 May 2024 19:24:01 +0800
Message-Id: <20240530112406.94452-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: fcf606ca5ff8
Content-Transfer-Encoding: 8bit

This commit separates the function receive_buf(), then we wrap the logic
of handling the skb to an independent function virtnet_receive_done().
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/virtnet_main.c | 56 ++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index 6cc99d9b768b..68b90ee788bd 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -1721,32 +1721,11 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
-static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
-			void *buf, unsigned int len, void **ctx,
-			unsigned int *xdp_xmit,
-			struct virtnet_rq_stats *stats)
+static void virtnet_receive_done(struct virtnet_info *vi, struct virtnet_rq *rq,
+				 struct sk_buff *skb)
 {
-	struct net_device *dev = vi->dev;
-	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-
-	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
-		pr_debug("%s: short packet %i\n", dev->name, len);
-		DEV_STATS_INC(dev, rx_length_errors);
-		virtnet_rq_free_buf(vi, rq, buf);
-		return;
-	}
-
-	if (vi->mergeable_rx_bufs)
-		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
-					stats);
-	else if (vi->big_packets)
-		skb = receive_big(dev, vi, rq, buf, len, stats);
-	else
-		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
-
-	if (unlikely(!skb))
-		return;
+	struct net_device *dev = vi->dev;
 
 	hdr = skb_vnet_common_hdr(skb);
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
@@ -1776,6 +1755,35 @@ static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
 	dev_kfree_skb(skb);
 }
 
+static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
+			void *buf, unsigned int len, void **ctx,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats)
+{
+	struct net_device *dev = vi->dev;
+	struct sk_buff *skb;
+
+	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
+		pr_debug("%s: short packet %i\n", dev->name, len);
+		DEV_STATS_INC(dev, rx_length_errors);
+		virtnet_rq_free_buf(vi, rq, buf);
+		return;
+	}
+
+	if (vi->mergeable_rx_bufs)
+		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
+					stats);
+	else if (vi->big_packets)
+		skb = receive_big(dev, vi, rq, buf, len, stats);
+	else
+		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+
+	if (unlikely(!skb))
+		return;
+
+	virtnet_receive_done(vi, rq, skb);
+}
+
 /* Unlike mergeable buffers, all buffers are allocated to the
  * same size, except for the headroom. For this reason we do
  * not need to use  mergeable_len_to_ctx here - it is enough
-- 
2.32.0.3.g01195cf9f

