Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB513633F
	for <virtualization@lists.linux.dev>; Sat, 26 Apr 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745656146; cv=none; b=hgfTptcRYWfONrZC6XCTMnl9so30zzr+2We2ek2aOUVmPRfaKwdnoxpOFr6Rwxs3UHwdVSM/epig7YMwqCr1C4zppqfKciZ6E5nVgSubCEdV6KV3lMXMcFy/C23xoH2tNQiAvy1lXYl2TDTLcvU3LWiRQjpwW1OXa2CpnJMxiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745656146; c=relaxed/simple;
	bh=BlPT224zKcRmpKp/wnthT4KPe5thFT9m4jEmdANvCiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhtMxsIPJ7jaQWTAa8ZHxia4XqbOmAp+/GiQlKD/crh+pcafu9sRJl9ugUmB+3EUmMrixmtEVrmMh3KjHfxHpD+nBKa99NJDY7aRxIjJhrr6FeH8EgFHlIS1TguNP01euwBIAarZ6maEZwqObCyKInjsfThCQjwTqu6Ya9/afAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPJUE///; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPJUE///"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224019ad9edso45577055ad.1
        for <virtualization@lists.linux.dev>; Sat, 26 Apr 2025 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745656144; x=1746260944; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FM8A37+YXmFikaBp3T7wLJanwbx1aYEE9fR5m8vuRi4=;
        b=MPJUE///I5clo9W84UpxigupuFoaMYlb9dDDiNLQ9L/5I0nerPvZlefpSToi3cDid7
         u7CoFqml5WDHSHCOGWEAcjWom+AqoDgYhDrxUfAwmkRxRbhVfh41FNd+7GUv9BDFj3SI
         yytKzbgLL3+cwdM1kUVE5ahYCXkVgBMG2Ed5GRpOQAj5q8DclCqZom5d8ptxfjZ6hqdz
         d/836amJ1E/A7EebZbJwegIYuHdUdnctI5gNqXxKZMiGZbELGzOzFEcb1cmkbOlfi51j
         irqf6UuyknN+i5ShhrIg4cVcEnJ0hPECdC9WHYYCC0dFR2dPcl35Ngoz6ajV4fcOl3HR
         eHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745656144; x=1746260944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM8A37+YXmFikaBp3T7wLJanwbx1aYEE9fR5m8vuRi4=;
        b=hKJFM2MWiP/4OGEA2gDJLFbkZUn1vl+VcpJT3q4k7nOT7WFCfOUeSn0Z5xOlQR1zYZ
         8hKsyMa/TLfz9h/T3Iq3GoT72jis7dn7qJEOw84j4+Eojndj3hklXQXNgCJE+oNmRiMX
         8FDQ/4RliymszaR803OAT3s3Kx6hEVS8D0nnhNs+VzBO8alxZF0fkwJ58tYh2nZyZfTe
         D7BVjznF4RdfLgWPBgniyc6uf8BHvVqoi4fJn98VSTC4PkKyXU8FJMh2KssqInVmSNm3
         2uiXdhtr9/sNf1cG/9+gsAD+Qs7OiSVHpry8MI1yZvj0RwaBJavZs1NAjoaMoQr+Tbt6
         c4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWLwOMrOsqHnLoeFAOlN5TDrnZ1QJzGNJ7I8apgrMEGEinRdrHxokegvPDIHIxx5o9bkZTAdlckVC1elXqHiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIIccygtVi5NsW/geAeBJQtOvkfyXwGOhfszoirTHHc2SvhC9y
	zpEXAamPljk0NNlOrjj5cMi89SKhst+FtoPM6dmT44sLE1Ch8AoW
X-Gm-Gg: ASbGnctTRvwkbydHegw06h9SwDzs5d4/Gd51VZ3dpHlDnspIeLxXdk44yzVsgXY71EL
	36QGuMX9QKq8MlE/nFtaVbYOv1t4hwsqYCT0jAT68HQeXluCa01qJ4MPmHBvSaFQvapIhKO1QZS
	Ms1NRnKl1IasH4ys1+Tts+7WiLuZruyXh5K0o2M6hc93ibckA0xLbU8DsROM4xPSb6r8IemlA2/
	nbfiUP/5/w2qemafoJq7YlPwn/duVnDbziZmK+KTT3+nId7e4I2ZJyv4K9roxI6UqRkZkZzyEvG
	x16K9xWMU7bPvZlwYLaKrCTb1cQUhTvilv0l8Oz1yvpZcoU229sZ6mWD
X-Google-Smtp-Source: AGHT+IEbUSASmLNrEsQTJTPBK3hQZC0/5KtkWZdyCfJJQEIBmwlysntni1JLhUzFc4HajkuPZxOc7w==
X-Received: by 2002:a17:902:ccc4:b0:224:c76:5e57 with SMTP id d9443c01a7336-22dbf62255bmr81362875ad.39.1745656144410;
        Sat, 26 Apr 2025 01:29:04 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52b1:1f45:145e:af27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db5100ab2sm45155165ad.183.2025.04.26.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 01:29:03 -0700 (PDT)
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
Subject: [RFC PATCH net-next] virtio-net: support zerocopy multi buffer XDP in mergeable
Date: Sat, 26 Apr 2025 15:27:52 +0700
Message-ID: <20250426082752.43222-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/net/virtio_net.c | 107 +++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 848fab51dfa1..8d21767dd607 100644
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
@@ -1307,23 +1297,28 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 
 	ret = XDP_PASS;
+	if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
+		goto drop;
+
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
+	if (prog)
 		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
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
 
@@ -1332,14 +1327,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
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
@@ -1396,6 +1388,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		return -ENOMEM;
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+	/* Reserve some space for skb_shared_info */
+	len -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	for (i = 0; i < num; ++i) {
 		/* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
@@ -6721,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->netdev_ops = &virtnet_netdev;
 	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
+	dev->xdp_zc_max_segs = VIRTNET_MAX_ZC_SEGS;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
-- 
2.43.0

