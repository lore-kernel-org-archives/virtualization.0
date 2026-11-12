Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482417;
	b=gu1C/AEVoXcCnp+oTsEp7V4+20PaEyB2ePc9RR4YQT1/rqhDrl4ZRi7vDraYCbeRPcSh
	 PrQbh7YxIdNXH/cckvEEN8ObjwiUepNwVyuKhaHTfkBwh6OJKiz4p6OZIcksvUtvLYHgW
	 77XrMHrshv4zXiHVBDgi9puOzhaiFNVobGVAoMd/bdVy+SGKxjlpUeOVWfPPA41lgn9Jk
	 Y2NfklDl3cq5nTOuVRJbQ2L7Mr/pqcGJPNFl7Y4uuvkRKp4sBp+vgUdhPCDUss3a5li1z
	 Lltn3IHD7/q22xIHgpTRapwqJNrP60o/tUoDZNG9gKY0JWuDGHo+H4fvqJLDju7ELRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482417;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DAoJLDq8Ga0Al0IQkwwR6XXBD9eqgfhjwmrtsUdqWQo=;
	b=H+lUblFOvGuf4T84Uoc1JWcj+lGUlqCZobTRznM/+1m4IA7ftth1zPaPy6H+PdaCo2eJ
	 XGnxsKO8DBlv/e0dZuSonJYLJaZ5uuoqMnZ3lqRalVayDOxTBql7rzruZhDVPCe79WRDM
	 z2xUwx7eUhEbmgibFJvstxra1FtwjXDqbbKwyhcR5HUWTBrPTrppodFu2B9gUTI8LIRgb
	 iOlWomMUH3kA9nYxFTi3LzTFIzJZARP9Q05TXzrvl4hwFvEK8yWqeBaGZRRXUAVb/FiUh
	 Q7hqN2g1sEOa+MxgcpkYbEmQBnuVBsgPkVOuwvwOSZrlD32YK5zCn8K+tTB0G+mpWyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FETPGWu2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4E60A2634
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D4E60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FETPGWu2
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 31679202C92;
	Thu, 12 Nov 2026 12:20:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAoJLDq8Ga0Al0IQkwwR6XXBD9eqgfhjwmrtsUdqWQo=;
	b=FETPGWu2fT7jsp0NaN/SAGSZGujN+8Sx0qbEiYoi7D/1UwDQA3LiM3gQIl5gOpiBDKf0AP
	vi3G38aRbsDfVdrdL+m/Q+9TYo8lSKHUy8VgD9pdJnxBrJAITL9N1TpAFeQ6kWo7cCJOLr
	6Y6fACGoZn1hQusAZy1OG7s0KeYbe4kGM4LkVwYsKrMrmIOOy+XWEULbXBA8RopknGy+vX
	UzU8dHGyRn/mL3ChSjOdjUlKC4ONuCw+l68Bfwbdl5N9PeeKO3Mq2XgQ8c0yqZMLiJWo6A
	3AP9kFgi98CHZs7RHexx8CVP+NKLgTymHPVU4Z7Ij3+6TIDqujc6RFciUjhoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAoJLDq8Ga0Al0IQkwwR6XXBD9eqgfhjwmrtsUdqWQo=;
	b=Xp1q48rGAcyUlFCto3UZI6ONCpoCC5n0Pnu9WiJgWlxPXXp2sv5zFT7fXvG+xpPIEY19xV
	oiTipiEa3BAjNhW4RiPTaHF88t4mZVslfhtqM8DIZaOfZooQMmucu5s+Lo2xg4vXNx+vGC
	9wgSsqWAGykLUD6IPZkg1xHCqhGdTlx0WPyEidT1lbMX/Rb0oq1TRd9PkD4dOmTdb1ZI6t
	fYNzBeW8DMtf0L5XiVScOlI0xE6nr3IWAV6IW3ZPhofCW0m+7ObDFe2mpismur52XJ6H0M
	480TTAPd9XBP5F9sysGoXC68E+01HSq1mTWphSqo8cfeMztWQCNTHhOqPq9plQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482415; a=rsa-sha256;
	cv=none;
	b=WnfzFs5xEPwZ++46gnIZArpzfiSiXEJJh2TTWeZmNOXqtpJu33aa4Dl3LY7GXRhd7wdOew
	fLIrRhSbXp/u+xPw124TdCKV//VP0wDLbmGFPiNt/HDdYGJxsnw6Yqpd2MAdihrpU1aEfL
	lRKfqslWdRdE/SGYnxy+jpmum/7hGYC2/iSvRgbZsRxeKzOnYxcZD1q5oTq20JyfPs3fMv
	DfcteTnfueVFk82aRIxN+vb6rsBRa/UMEGRsee04x90eDJ+p8jKbYNjMyRaN050HDCULk2
	ZHtaigttA1cTukdwNEYwjtj1tGP1AgTbFQ3aCh+T7QicFjyZiIm36AEn4hTTXA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:35 +0100
Subject: [PATCH net-next v5 3/9] virtio-net: copy the XDP rx hash before
 the program runs
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-3-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Liang Chen <liangchen.linux@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7436;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=Wt4xzMKr8sKjwDtAffVOd9/ZHwoEf2KWjXEHHQAs2iU=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBa+llZf4XjEVSSxW1s1eeab9MMcczyCdqX/ikgXOZ
 hVELD3XUcrCIMbFICumyKKysIJP1OODZ+Q0ES6YOaxMIEMYuDgFYCLbNBkZFidkaphfe7cmc+2F
 XxcyWjzmTDrGuUOP9zGrhf9Nk4NGNowM0xzXNDp+kow92zrDMWmWQsAu9upTXEK/3nU/zpr27f1
 XdgA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

virtnet_xdp_rx_hash() reads the hash from the vnet header at
xdp->data - vi->hdr_len when the XDP program calls
bpf_xdp_metadata_rx_hash(). That is only the header until the program
changes the buffer: bpf_xdp_adjust_meta() writes the metadata right in
front of xdp->data, over the header, and bpf_xdp_adjust_head() moves
xdp->data, so the callback then reads metadata or packet bytes.

Wrap struct xdp_buff in struct virtnet_xdp_buff, copy hash value and
report type into it in virtnet_xdp_handler() before
bpf_prog_run_xdp(), and let the callback read the copy. The small and
mergeable paths put the wrapper on the stack; for AF_XDP the fields are
in the cb of struct xdp_buff_xsk, checked with XSK_CHECK_PRIV_TYPE().

Move virtio_net_hash_value() up so the copy can use it.

Fixes: aa37f8916d20 ("virtio_net: Support RX hash XDP hint")
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c | 86 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4c740b403ad1e..ffd7313663c18 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -491,6 +491,26 @@ struct padded_vnet_hdr {
 	char padding[12];
 };
 
+/*
+ * The vnet header sits in the headroom in front of xdp->data, which the
+ * XDP program may overwrite with bpf_xdp_adjust_head() or
+ * bpf_xdp_adjust_meta(). What the metadata kfuncs report is copied from
+ * it before the program runs. For AF_XDP the fields behind xdp live in
+ * the cb of struct xdp_buff_xsk.
+ */
+struct virtnet_xdp_buff {
+	struct xdp_buff xdp;
+	u32 hash_value;
+	u16 hash_report;
+};
+
+static inline u32
+virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
+{
+	return __le16_to_cpu(hdr_hash->hash_value_lo) |
+		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
+}
+
 struct virtio_net_common_hdr {
 	union {
 		struct virtio_net_hdr hdr;
@@ -1687,6 +1707,24 @@ static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
 	}
 }
 
+/* xdp must be embedded in struct virtnet_xdp_buff or struct xdp_buff_xsk */
+static void virtnet_xdp_save_hdr(const struct virtnet_info *vi,
+				 struct xdp_buff *xdp)
+{
+	struct virtnet_xdp_buff *ctx = container_of(xdp, struct virtnet_xdp_buff, xdp);
+	const struct virtio_net_hdr_v1_hash *hdr_hash = xdp->data - vi->hdr_len;
+
+	XSK_CHECK_PRIV_TYPE(struct virtnet_xdp_buff);
+
+	if (vi->has_rss_hash_report) {
+		ctx->hash_value = virtio_net_hash_value(hdr_hash);
+		ctx->hash_report = __le16_to_cpu(hdr_hash->hash_report);
+	} else {
+		ctx->hash_value = 0;
+		ctx->hash_report = VIRTIO_NET_HASH_REPORT_NONE;
+	}
+}
+
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -1696,6 +1734,8 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 	int err;
 	u32 act;
 
+	virtnet_xdp_save_hdr(netdev_priv(dev), xdp);
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	u64_stats_inc(&stats->xdp_packets);
 
@@ -1867,7 +1907,8 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
 	struct page *page = virt_to_head_page(buf);
 	struct page *xdp_page;
-	struct xdp_buff xdp;
+	struct virtnet_xdp_buff vxdp;
+	struct xdp_buff *xdp = &vxdp.xdp;
 	struct sk_buff *skb;
 	unsigned int metasize = 0;
 	u32 act;
@@ -1900,17 +1941,17 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		page = xdp_page;
 	}
 
-	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
-	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
+	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
+	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
 		/* Recalculate length in case bpf program changed it */
-		len = xdp.data_end - xdp.data;
-		metasize = xdp.data - xdp.data_meta;
+		len = xdp->data_end - xdp->data;
+		metasize = xdp->data - xdp->data_meta;
 		break;
 
 	case XDP_TX:
@@ -1921,7 +1962,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		goto err_xdp;
 	}
 
-	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
+	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
 	if (unlikely(!skb)) {
 		u64_stats_inc(&stats->alloc_fail);
 		goto err;
@@ -2288,7 +2329,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	unsigned int xdp_frags_truesz = 0;
 	struct sk_buff *head_skb;
 	unsigned int frame_sz;
-	struct xdp_buff xdp;
+	struct virtnet_xdp_buff vxdp;
+	struct xdp_buff *xdp = &vxdp.xdp;
 	void *data;
 	u32 act;
 	int err;
@@ -2298,16 +2340,16 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	if (unlikely(!data))
 		goto err_xdp;
 
-	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
+	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
 					 &num_buf, &xdp_frags_truesz, stats);
 	if (unlikely(err))
 		goto err_xdp;
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
-		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
+		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb)) {
 			u64_stats_inc(&stats->alloc_fail);
 			break;
@@ -2324,7 +2366,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(rq, &xdp);
+	put_xdp_frags(rq, xdp);
 
 err_xdp:
 	page_pool_put_page(rq->page_pool, page, -1, true);
@@ -2477,13 +2519,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return NULL;
 }
 
-static inline u32
-virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
-{
-	return __le16_to_cpu(hdr_hash->hash_value_lo) |
-		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
-}
-
 static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 				struct sk_buff *skb)
 {
@@ -6760,23 +6795,18 @@ virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] = {
 static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type)
 {
-	const struct xdp_buff *xdp = (void *)_ctx;
-	struct virtio_net_hdr_v1_hash *hdr_hash;
-	struct virtnet_info *vi;
+	const struct virtnet_xdp_buff *ctx = (void *)_ctx;
 	u16 hash_report;
 
-	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
+	if (!(ctx->xdp.rxq->dev->features & NETIF_F_RXHASH))
 		return -ENODATA;
 
-	vi = netdev_priv(xdp->rxq->dev);
-	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
-	hash_report = __le16_to_cpu(hdr_hash->hash_report);
-
+	hash_report = ctx->hash_report;
 	if (hash_report >= VIRTIO_NET_HASH_REPORT_MAX_TABLE)
 		hash_report = VIRTIO_NET_HASH_REPORT_NONE;
 
 	*rss_type = virtnet_xdp_rss_type[hash_report];
-	*hash = virtio_net_hash_value(hdr_hash);
+	*hash = ctx->hash_value;
 	return 0;
 }
 

-- 
2.56.0

