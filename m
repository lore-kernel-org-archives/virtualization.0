Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6917C22D
	for <virtualization@lists.linux.dev>; Tue, 11 Jun 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106121; cv=none; b=mMnCF7Ggj6R5zOOgCNoysoWeKyK4lkBN18qRgIIEX9zxghWx2EQDxwb2BBVt2bSq06ueqNeUXmbRFLUjMKvz7NeCivaxDJiqDmEQrwoGdBh9IUq/JmQHtIpaVEUArpVGWsiiXi8mc41+FpjjSoVSRBSjW5DmnenmjTiu3+btVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106121; c=relaxed/simple;
	bh=wByw0bT2yfYbSS2RCYMCVKjRqbg2fzSsRoeS4hrYkC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+dXFLj9m7bvNNquMV9iVclAGpQb55NimFRNqXxSNPZ+4auWykLRyFRVr9DBAKcgN50FDzrzQunUbEWNd5sB0shPXj8dE/u0vNetBYt6VmSKYQWyn+9xeqriq8CgtuFiL2skjbyD59OsVVwwIxeLJRGiQcHCoDs5o1DY2jvf7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T2Vz/4k3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T2Vz/4k3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106117; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MWecKdKmfziyZ50SMpKq4drSxB5pIfvjl3IquVboWWc=;
	b=T2Vz/4k3yVhySRFdG7k72Htb5k3WRuu0dfvs1JfEY4kXtkoWkyYkG5FBohmcAGcyLrjnPqSf+Vv6gRwJD1dDf7IqBmetx9mwYRstjzuHoYaSPcKFL7W7zg1YZvg2wDqSA8kNuqgZVzwnjesoF0ougn7G+ojqpKbjz5Q4e+Ppuyw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GMZNy_1718106115;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GMZNy_1718106115)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:55 +0800
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
Subject: [PATCH net-next v4 07/15] virtio_net: refactor the xmit type
Date: Tue, 11 Jun 2024 19:41:39 +0800
Message-Id: <20240611114147.31320-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: c1658a8c15b0
Content-Transfer-Encoding: 8bit

Because the af-xdp and sq premapped mode will introduce two
new xmit type, so I refactor the xmit type mechanism first.

We use the last two bits of the pointer to distinguish the xmit type,
so we can distinguish four xmit types. Now we have two xmit types:
SKB and XDP.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 58 +++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 161694957065..e84a4624549b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -47,8 +47,6 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG	BIT(0)
-
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -491,42 +489,62 @@ struct virtio_net_common_hdr {
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
-static bool is_xdp_frame(void *ptr)
+enum virtnet_xmit_type {
+	VIRTNET_XMIT_TYPE_SKB,
+	VIRTNET_XMIT_TYPE_XDP,
+};
+
+#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)
+
+static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
 {
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
+	unsigned long p = (unsigned long)*ptr;
+
+	*ptr = (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
+
+	return p & VIRTNET_XMIT_TYPE_MASK;
 }
 
-static void *xdp_to_ptr(struct xdp_frame *ptr)
+static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
 {
-	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
+	return (void *)((unsigned long)ptr | type);
 }
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
+static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
+			      enum virtnet_xmit_type type)
 {
-	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
+	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
+				    virtnet_xmit_ptr_mix(data, type),
+				    GFP_ATOMIC);
 }
 
 static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 			    struct virtnet_sq_free_stats *stats)
 {
+	struct xdp_frame *frame;
+	struct sk_buff *skb;
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
-		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr;
+		switch (virtnet_xmit_ptr_strip(&ptr)) {
+		case VIRTNET_XMIT_TYPE_SKB:
+			skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
 
 			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
+			break;
+
+		case VIRTNET_XMIT_TYPE_XDP:
+			frame = ptr;
 
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+			break;
 		}
 	}
 }
@@ -1064,8 +1082,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT_TYPE_XDP);
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -2557,7 +2574,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+	return virtnet_add_outbuf(sq, num_sg, skb, VIRTNET_XMIT_TYPE_SKB);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -5263,10 +5280,15 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
-	if (!is_xdp_frame(buf))
+	switch (virtnet_xmit_ptr_strip(&buf)) {
+	case VIRTNET_XMIT_TYPE_SKB:
 		dev_kfree_skb(buf);
-	else
-		xdp_return_frame(ptr_to_xdp(buf));
+		break;
+
+	case VIRTNET_XMIT_TYPE_XDP:
+		xdp_return_frame(buf);
+		break;
+	}
 }
 
 static void free_unused_bufs(struct virtnet_info *vi)
-- 
2.32.0.3.g01195cf9f

