Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81956131724
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255183; cv=none; b=BOo7EHgNDpEoij0w9tT8HoopnDVzb0lT4oDUCGPjavtbHhNqaeaKBHFvgdSSGvVTZ4oPI08QAnJ2Pub+fJ9COc+14typvNDU+jxqUCeK2y838SSvNzY5AoAorfxJDRD6hFl9DTQtKN+Mtl4ihux/FIIYF5N4wo3Wul9WS0+akeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255183; c=relaxed/simple;
	bh=41q6w+iDpR6FRQh1gTwi9bkZIR6ZbLJ/nt7XJX4mSGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Amg3cGk0coL9FekC/RgIITrI1+l81U34WMSJK5NVwd7rFLHbIPsxU08Cwy4Tu4Bs2/0kgElpzFQv1Cc5pTFvoTkWlFQjP4YioomLxei3UcDA4PLjB7bUoJRabY1a+AcLuBVJfNt7yC7Ea3VJa3tWZSUlG0BzJbhMC0Ed9EbT0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uOOGUwyv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uOOGUwyv"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so183360666b.0
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715255180; x=1715859980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33S2PQDlGKSgHvCStcnq/stwheT+yk8+mj4rEWpjP9k=;
        b=uOOGUwyvO+HIAyVW0Ks5KczHhPRA+EGkYxb+smsdREuxOg4ruEsK35S2Kjloxo5gCY
         DvBwuFnl4m5w3r4UPhqhcf8MdQ6BfxD8m+M4p0hBCN3m5zfdfZaLXM47hcOQnqQsyG6m
         FwnnMIUCpnUwNq5JhMB4HLnt1mHDFM4m+1YK7Yq6ixDvf4X8cSPFZkZ7gqAzZ8dVw9aC
         Y5YoVpjviJHmx+P3jupCS+n79GlUvkQP4TYpNbB1Z9+gZDXim9scDg7a6sPBpHy7EGEB
         moizlrhQ3wO7pB7ZJtL9mavD0vB3QTcuKeaklVeZ+5JOXbSGmjrqOyFcmEOIjdT/XaIG
         ifEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715255180; x=1715859980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33S2PQDlGKSgHvCStcnq/stwheT+yk8+mj4rEWpjP9k=;
        b=U9ZsAq369SQlwwCWeorn+sjp4OSMsHnmfPicQ0nqekuAnz7tvC4pLDQlMFDZWcaHj8
         T+4kE3/pBJr0ECUgFgrYO+A4KGk2mvXhEXTef3PqDDqw3De0gWVHsFmAL2+bIsyzrPXF
         CJljDcn1cgOp0FTYVpDcOwP8hHab8ysPKNCnkqyhBxwJkoJumVPip9V0NEVsUmB4IU2T
         jMGtbMwgPz8F/Uqsud8p+pZFakwS1Zj3JvXM4AiiivELIQGCh5gKMAXtbk23MaAr68Qs
         rdlAeIeIOuXt+CzkkH3aQUe2AeMZiL9kyVKQCJ1soQL8UD9ODZ0kelExwi32PDZJYMeC
         7g3g==
X-Forwarded-Encrypted: i=1; AJvYcCWqkzadZADp98OJhpAjXCvoYcBAyU2EOkmxAvBrJ+OQX62bOhbO6Q7seDVzokKj3uSZMCWKo9jL8Idtia+N1u27fiB887PXhSiwwkHzDCc=
X-Gm-Message-State: AOJu0YymH0n8C551zSzxbDAocYXMAla3sq7ZsR012rLZbQSJHxSpUo5R
	YS1vBpziLmYuosekfZl/wpcGFt4Gkt6l7DtCRqdOD7tQLn6TZUDCEVBmxTqQJ9c=
X-Google-Smtp-Source: AGHT+IE0bfVMxDyCH257TbVVCB/lGvx9ql36mre7hQWTqweS/pleK3AQjjwbgp0zDSE1Qv6l61MkDQ==
X-Received: by 2002:a17:906:f9c8:b0:a59:cdf4:f948 with SMTP id a640c23a62f3a-a59fb9dac78mr418908266b.65.1715255179576;
        Thu, 09 May 2024 04:46:19 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01724sm64615566b.162.2024.05.09.04.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:46:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [patch net-next] virtio_net: add support for Byte Queue Limits
Date: Thu,  9 May 2024 13:46:15 +0200
Message-ID: <20240509114615.317450-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add support for Byte Queue Limits (BQL).

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 218a446c4c27..c53d6dc6d332 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -84,7 +84,9 @@ struct virtnet_stat_desc {
 
 struct virtnet_sq_free_stats {
 	u64 packets;
+	u64 xdp_packets;
 	u64 bytes;
+	u64 xdp_bytes;
 };
 
 struct virtnet_sq_stats {
@@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		++stats->packets;
-
 		if (!is_xdp_frame(ptr)) {
 			struct sk_buff *skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
 
+			stats->packets++;
 			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
 		} else {
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
-			stats->bytes += xdp_get_frame_len(frame);
+			stats->xdp_packets++;
+			stats->xdp_bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 		}
 	}
@@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
-static void free_old_xmit(struct send_queue *sq, bool in_napi)
+static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
+			  bool in_napi)
 {
 	struct virtnet_sq_free_stats stats = {0};
 
@@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
 	 */
-	if (!stats.packets)
+	if (!stats.packets && !stats.xdp_packets)
 		return;
 
+	netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	u64_stats_add(&sq->stats.bytes, stats.bytes);
 	u64_stats_add(&sq->stats.packets, stats.packets);
@@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	 * early means 16 slots are typically wasted.
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
-		netif_stop_subqueue(dev, qnum);
+		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
+
+		netif_tx_stop_queue(txq);
 		if (use_napi) {
 			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
 		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit(sq, false);
+			free_old_xmit(sq, txq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);
@@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit(sq, true);
+			free_old_xmit(sq, txq, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, true);
+	free_old_xmit(sq, txq, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
@@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct send_queue *sq = &vi->sq[qnum];
 	int err;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
-	bool kick = !netdev_xmit_more();
+	bool xmit_more = netdev_xmit_more();
 	bool use_napi = sq->napi.weight;
 
 	/* Free up any pending old buffers before queueing new ones. */
@@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (use_napi)
 			virtqueue_disable_cb(sq->vq);
 
-		free_old_xmit(sq, false);
+		free_old_xmit(sq, txq, false);
 
-	} while (use_napi && kick &&
+	} while (use_napi && !xmit_more &&
 	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 	/* timestamp packet in software */
@@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	check_sq_full_and_disable(vi, dev, sq);
 
-	if (kick || netif_xmit_stopped(txq)) {
+	if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
 			u64_stats_inc(&sq->stats.kicks);
-- 
2.44.0

