Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14B27D776
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362777; cv=none; b=ghkYaOp3ss45mY5ZFHyfJcdpmt3VC8uLShKi2Lcn2noknTqp6sokxcRPszCKHydf1SB1yzkUrqldOPSVRgKewtrT1rFei4i9n5xgLF2Ze3dfpNtuIyhDREfpgDX01wmlLYdxj6XGDndy13+2r8ZbeMU+pek8/Cb2fJkc7D4xtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362777; c=relaxed/simple;
	bh=IUzh3BLEMlZQ5rPvOCcCqz3khKM+z1S4yWpg+KfuQZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8mpGIS7cDStob6qBYk3Idd8AKlNrYFmflnmQJNxd6CkgnQRtvZN4OdVefNbi2HosXt3psDoMrVd9eXXXOrSgmOlhJLAOfouKwtNAiHrWcAEfajaKvsgvHugTJ7exPzeBxJZw0+6lIvH9MkvU1KWnCisAQX0ssyW4vuPesKW21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUDEchrr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUDEchrr"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af6a315b491so2759812a12.1
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748362774; x=1748967574; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyumaTW6lo7mIeb7nd+vfxQ27K0rqMNzwb6ZVHOGqO4=;
        b=iUDEchrrD8+Kr//OniNyjv96AJdRMYGRQypX9hHHgxKfMIFKy+IaNc1rPjkqRSi22G
         PJetnPqmWnG0TD1ED7/fvKgaoR8Bio8ejLVsEtBu96xX9r2E8wIWhZ3MpTNJgwUnP7Ci
         pTm/liGggb32VqiWgF/twFI56LnJrRuLkUwx7EiwrzaeGtJH8uYxc5H3Tn16H+t6uJIF
         iE0v9OuOg7rAatyYH8DO5qoGdVh2Qc8wMn7H+WqbHCoudrbXYDJAA2lYnIgm+yow3I+z
         MfiKEgTwgThgVRY/P/Ow1oDQ31I6mbqGq9bmvuiCTvVzhSrlhtZ4cm/MqJHjzKMGypC0
         fMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362774; x=1748967574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyumaTW6lo7mIeb7nd+vfxQ27K0rqMNzwb6ZVHOGqO4=;
        b=bbL1n24z7x5oFw8ZbBeE73nhENgSiBAHfuN18Q2yvvYBXTd7HpgHGzi4bL3vXeMviD
         Sa9WWCNqdQce1U9X+fP4f0KM7SH1hbEzHk1JEMSObsXiaPrWsj4uj5aTVq+hgMxAc5y9
         ZMfMqaCCZgmc0lERtiYcNZCyIq11GBKII585GXgmks/6kuonX/iAYAtI2hayY8ccB0l/
         CDcw3upe3N7vYCKfUvhOy5N834/soEIxI33Z7M9QxRjTsXoa6APPunJULKMoIUDuv7yH
         7hXeWXi3eo7rUXpMuwn7Te3XzPTHkVylgBWBAUyOz8MbwcspBQpGkiIjOs3mXPO7Kson
         2XpA==
X-Forwarded-Encrypted: i=1; AJvYcCXAK2FLcbsb6wYqW4VSVSkU4mCH4x9SmG8rEdBj4mqylm2IBSJek5eCaZ6c4cGu0k8bPRYpBsKZ0ml8A3RTbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzauHmpasSNqrCK2iZx16y1NYZrrjJ4QFofi9MBAxe0eB7Nt98/
	z8i8gOedZhxyVpMXUaqpdl+S1pAstcoY2dGOG4ewKkQxWvSvfGJXm//S
X-Gm-Gg: ASbGncs2GACfsZ/9EIYjCKWj7ymsH4IvC+xLCpacPRgF7LdHkPyANLnZGVvHtbLGTJE
	sHoYhp/ItQufuQeGfGC0MsO7ySQ3Whx0nRNECW+zIHGHoZ+N0HBUG1ivxISiQ3BMMcgd+7OSgWT
	mUjxwTKKYWfhu6AHxBEQd+lZCg6+YC3ZoePogCWg+RIOznfsPVxJ4zTdeAMOP6TE8zt5amGFaG8
	0/seSXOSSrdV8tdwEm052FdIuJef7V0G/GfFSktNMa4/i7hIugyRvDX0xopcI53YQsgXbTXRO6d
	aUeB+YLXvurkysfFMiL6uomVUshLMmogDUHao2MrSeIN1RHFeAO80yLeGa5nrQXd3OU=
X-Google-Smtp-Source: AGHT+IHgfUjhe5piUBHcuQNK/0nrtm0tXgcRsbtKkH28640CNrWGf0iRv7DTvT+hKCAanahN8yWIzA==
X-Received: by 2002:a05:6a21:329a:b0:215:d611:5d9b with SMTP id adf61e73a8af0-2188c240698mr21613605637.12.1748362774298;
        Tue, 27 May 2025 09:19:34 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52e0:fc81:ee8a:bb3f])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7462aefb414sm1118121b3a.34.2025.05.27.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:19:33 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi buffer XDP in mergeable
Date: Tue, 27 May 2025 23:19:03 +0700
Message-ID: <20250527161904.75259-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527161904.75259-1-minhquangbui99@gmail.com>
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, in zerocopy mode with mergeable receive buffer, virtio-net
does not support multi buffer but a single buffer only. This commit adds
support for multi mergeable receive buffer in the zerocopy XDP path by
utilizing XDP buffer with frags.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 57 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..a9558650f205 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
+#define VIRTNET_MAX_ZC_SEGS	8
+
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_device *dev,
 	}
 }
 
-static int xsk_append_merge_buffer(struct virtnet_info *vi,
-				   struct receive_queue *rq,
-				   struct sk_buff *head_skb,
-				   u32 num_buf,
-				   struct virtio_net_hdr_mrg_rxbuf *hdr,
-				   struct virtnet_rq_stats *stats)
+static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
+				      struct receive_queue *rq,
+				      u32 num_buf,
+				      struct xdp_buff *xdp,
+				      struct virtnet_rq_stats *stats)
 {
-	struct sk_buff *curr_skb;
-	struct xdp_buff *xdp;
-	u32 len, truesize;
-	struct page *page;
+	unsigned int len;
 	void *buf;
 
-	curr_skb = head_skb;
+	if (num_buf < 2)
+		return 0;
+
+	while (num_buf > 1) {
+		struct xdp_buff *new_xdp;
 
-	while (--num_buf) {
 		buf = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!buf)) {
-			pr_debug("%s: rx error: %d buffers out of %d missing\n",
-				 vi->dev->name, num_buf,
-				 virtio16_to_cpu(vi->vdev,
-						 hdr->num_buffers));
+		if (!unlikely(buf)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 vi->dev->name, num_buf);
 			DEV_STATS_INC(vi->dev, rx_length_errors);
-			return -EINVAL;
-		}
-
-		u64_stats_add(&stats->bytes, len);
-
-		xdp = buf_to_xdp(vi, rq, buf, len);
-		if (!xdp)
-			goto err;
-
-		buf = napi_alloc_frag(len);
-		if (!buf) {
-			xsk_buff_free(xdp);
-			goto err;
+			return -1;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
-
-		xsk_buff_free(xdp);
+		new_xdp = buf_to_xdp(vi, rq, buf, len);
+		if (!new_xdp)
+			goto drop_bufs;
 
-		page = virt_to_page(buf);
+		/* In virtnet_add_recvbuf_xsk(), we ask the host to fill from
+		 * xdp->data - vi->hdr_len with both virtio_net_hdr and data.
+		 * However, only the first packet has the virtio_net_hdr, the
+		 * following ones do not. So we need to adjust the following
+		 * packets' data pointer to the correct place.
+		 */
+		new_xdp->data -= vi->hdr_len;
+		new_xdp->data_end = new_xdp->data + len;
 
-		truesize = len;
+		if (!xsk_buff_add_frag(xdp, new_xdp))
+			goto drop_bufs;
 
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
-						    buf, len, truesize);
-		if (!curr_skb) {
-			put_page(page);
-			goto err;
-		}
+		num_buf--;
 	}
 
 	return 0;
 
-err:
+drop_bufs:
 	xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
-	return -EINVAL;
+	return -1;
 }
 
 static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
@@ -1307,23 +1297,42 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 
 	ret = XDP_PASS;
+	if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
+		goto drop;
+
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	if (prog) {
+		/* We are in zerocopy mode so we cannot copy the multi-buffer
+		 * xdp buff to a single linear xdp buff. If we do so, in case
+		 * the BPF program decides to redirect to a XDP socket (XSK),
+		 * it will trigger the zerocopy receive logic in XDP socket.
+		 * The receive logic thinks it receives zerocopy buffer while
+		 * in fact, it is the copy one and everything is messed up.
+		 * So just drop the packet here if we have a multi-buffer xdp
+		 * buff and the BPF program does not support it.
+		 */
+		if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_frags)
+			ret = XDP_DROP;
+		else
+			ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
+						  stats);
+	}
 	rcu_read_unlock();
 
 	switch (ret) {
 	case XDP_PASS:
-		skb = xsk_construct_skb(rq, xdp);
+		skb = xdp_build_skb_from_zc(xdp);
 		if (!skb)
-			goto drop_bufs;
+			break;
 
-		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
-			dev_kfree_skb(skb);
-			goto drop;
-		}
+		/* Later, in virtnet_receive_done(), eth_type_trans()
+		 * is called. However, in xdp_build_skb_from_zc(), it is called
+		 * already. As a result, we need to reset the data to before
+		 * the mac header so that the later call in
+		 * virtnet_receive_done() works correctly.
+		 */
+		skb_push(skb, ETH_HLEN);
 
 		return skb;
 
@@ -1332,14 +1341,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 		return NULL;
 
 	default:
-		/* drop packet */
-		xsk_buff_free(xdp);
+		break;
 	}
 
-drop_bufs:
-	xsk_drop_follow_bufs(dev, rq, num_buf, stats);
-
 drop:
+	xsk_buff_free(xdp);
 	u64_stats_inc(&stats->drops);
 	return NULL;
 }
@@ -1396,6 +1402,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		return -ENOMEM;
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+	/* Reserve some space for skb_shared_info */
+	len -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	for (i = 0; i < num; ++i) {
 		/* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
@@ -6734,6 +6742,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->netdev_ops = &virtnet_netdev;
 	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
+	dev->xdp_zc_max_segs = VIRTNET_MAX_ZC_SEGS;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
-- 
2.43.0

