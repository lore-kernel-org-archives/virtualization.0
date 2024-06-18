Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC4200CB
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721905; cv=none; b=mn8V3bbdyCXZvuKLpXWJQoUbT2eHE64d7qxYOhmO4DPX14NnelCYOqQkGSsQmu93zBb1crfpze2OojKaMPTdjEE7ohpoyf2f121ZDl2Yy/Y0mlhukwCrCMqfRzOZxv4iIAAk+RoJFb7TWqP2TSnhpkNwT+vz4inyvurRwcBkv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721905; c=relaxed/simple;
	bh=DRMavt8N2YnlZCvD17z11VwAfNLnw/2GNeVmSBQxuzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0bkLThSPgGSCOzdDXJVgTrXHcbcA0nnFhiSXmiwIYJh72q0ATU1j/XRuzaYQg/nYEmd7uBdmRlTGdhMFAXWxdTYBBkqL0CZTqy++Gfrw2lWxptHz5NgS2rgs0rIQIOmHerW7PoHqr1sQWO31VP49dk/JN/WEtXvjIn7GYuiXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hM52hjKv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hM52hjKv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so49031685e9.0
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718721900; x=1719326700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDHbCFW7qj4JoJ70BZacxRKzokWqUTwX9tIpuWgcM6Q=;
        b=hM52hjKvumEUxNh3BszugdEP1JUKDUTGH5sNidZfTBZNcEsZwpNrL3C0MtfmkoLQva
         1xIVKhkkn96UpkYf5F/26HWTD7Q8n7Fcr1c1L1NDosw1VqiBBCpfflB4CrWQj9zhIG6h
         G4IhczlMR8WrcndqfBOuyjR5fEw4HRyYAtJMLcURKWBH1PnVOxU/c4MupV59CZ4ohKwV
         hF2KVcsKX4UUV2nBwNeHulPiKuJclz/v+ZhqzA4THkvRdHIBP7wqVLvKf3GEEA2Kr5zG
         jDztxzj5nSoPlR5Sd8kGvJMHZmOEcTtu0sDfoecZFrGVh/TNl7IBJ7aMn7Tco8JRiucT
         2ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721900; x=1719326700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDHbCFW7qj4JoJ70BZacxRKzokWqUTwX9tIpuWgcM6Q=;
        b=qBw8gtzibw4YB+NUVkBVBz1kNpCWjImjMG37XZwYtDY+k1JisAehb3mwrIiqyJZbBI
         jFKzDtyMbUCpg30DCi/2IMot0amqNtqCSIh4ejBkUz8JaIONcKf22c6TFp9bcoqdT5Z1
         0NNvPjGSl+oCADIbVgwo19PjML5CgC81rr5U0zI2TWUiPFprcPXvPgXsLXkB0VJvxw90
         juReIPw/z8jq2NWdP5eoR37Fe+Ca1o6usqCNfmt3Qn/WV/ngJvK8eUvqrm3DIgAukScA
         mqTRxqI9QZmdSlRffs6xXFSgSa3F2ztwHY89xf5uZpEFkUgLYH3ldxJ1+3bD9Qdid6JQ
         Pw2g==
X-Forwarded-Encrypted: i=1; AJvYcCWZoZAnBzV66TOC1/wSYmMlOQ/OlSLTVjj8FbPeps2L5E1Gzjeg4ny02GMLyE4U8HdIyZoItcLJNnJbFpwBP8MTJybRpACIjblstYty9q4=
X-Gm-Message-State: AOJu0YxZuT8pFGZS3ErKi69XoDY5a+Lmg6gfx1PY05yclimx92yd/ghh
	tmsgNdv0atPlPZLT9Fnk7qV8WM5wYRja1cUl5Nwhd1/778B70IecEtoeoxEQ63o=
X-Google-Smtp-Source: AGHT+IFQNOdfZ4EHM+UVjCKTW7opa7MiMU0Dy+RbzU/tevZyt9DEt1izlXiF6hJtTIomD95rPErt/A==
X-Received: by 2002:a5d:5917:0:b0:35f:296c:27b2 with SMTP id ffacd0b85a97d-3607a7b6255mr9687120f8f.22.1718721900104;
        Tue, 18 Jun 2024 07:45:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c79bsm14426978f8f.41.2024.06.18.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:44:59 -0700 (PDT)
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
	john.fastabend@gmail.com,
	dave.taht@gmail.com,
	kerneljasonxing@gmail.com,
	hengqi@linux.alibaba.com
Subject: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Date: Tue, 18 Jun 2024 16:44:56 +0200
Message-ID: <20240618144456.1688998-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add support for Byte Queue Limits (BQL).

Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
running in background. Netperf TCP_RR results:

NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
  BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
  BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
  BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
  BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
  BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
  BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- fixed the switch from/to orphan mode while skbs are yet to be
  completed by using the second least significant bit in virtqueue
  token pointer to indicate skb is orphan. Don't account orphan
  skbs in completion.
- reorganized parallel skb/xdp free stats accounting to napi/others.
- fixed kick condition check in orphan mode
v1->v2:
- moved netdev_tx_completed_queue() call into __free_old_xmit(),
  propagate use_napi flag to __free_old_xmit() and only call
  netdev_tx_completed_queue() in case it is true
- added forgotten call to netdev_tx_reset_queue()
- fixed stats for xdp packets
- fixed bql accounting when __free_old_xmit() is called from xdp path
- handle the !use_napi case in start_xmit() kick section
---
 drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..9f9b86874173 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -47,7 +47,8 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG	BIT(0)
+#define VIRTIO_XDP_FLAG		BIT(0)
+#define VIRTIO_ORPHAN_FLAG	BIT(1)
 
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
@@ -85,6 +86,8 @@ struct virtnet_stat_desc {
 struct virtnet_sq_free_stats {
 	u64 packets;
 	u64 bytes;
+	u64 napi_packets;
+	u64 napi_bytes;
 };
 
 struct virtnet_sq_stats {
@@ -506,29 +509,50 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
-static void __free_old_xmit(struct send_queue *sq, bool in_napi,
-			    struct virtnet_sq_free_stats *stats)
+static bool is_orphan_skb(void *ptr)
+{
+	return (unsigned long)ptr & VIRTIO_ORPHAN_FLAG;
+}
+
+static void *skb_to_ptr(struct sk_buff *skb, bool orphan)
+{
+	return (void *)((unsigned long)skb | (orphan ? VIRTIO_ORPHAN_FLAG : 0));
+}
+
+static struct sk_buff *ptr_to_skb(void *ptr)
+{
+	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
+}
+
+static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
+			    bool in_napi, struct virtnet_sq_free_stats *stats)
 {
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		++stats->packets;
-
 		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr;
+			struct sk_buff *skb = ptr_to_skb(ptr);
 
 			pr_debug("Sent skb %p\n", skb);
 
-			stats->bytes += skb->len;
+			if (is_orphan_skb(ptr)) {
+				stats->packets++;
+				stats->bytes += skb->len;
+			} else {
+				stats->napi_packets++;
+				stats->napi_bytes += skb->len;
+			}
 			napi_consume_skb(skb, in_napi);
 		} else {
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
+			stats->packets++;
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 		}
 	}
+	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
 }
 
 /* Converting between virtqueue no. and kernel tx/rx queue no.
@@ -955,21 +979,22 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
-static void free_old_xmit(struct send_queue *sq, bool in_napi)
+static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
+			  bool in_napi)
 {
 	struct virtnet_sq_free_stats stats = {0};
 
-	__free_old_xmit(sq, in_napi, &stats);
+	__free_old_xmit(sq, txq, in_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
 	 */
-	if (!stats.packets)
+	if (!stats.packets && !stats.napi_packets)
 		return;
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_add(&sq->stats.bytes, stats.bytes);
-	u64_stats_add(&sq->stats.packets, stats.packets);
+	u64_stats_add(&sq->stats.bytes, stats.bytes + stats.napi_bytes);
+	u64_stats_add(&sq->stats.packets, stats.packets + stats.napi_packets);
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
@@ -1003,7 +1028,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	 * early means 16 slots are typically wasted.
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
-		netif_stop_subqueue(dev, qnum);
+		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
+
+		netif_tx_stop_queue(txq);
 		u64_stats_update_begin(&sq->stats.syncp);
 		u64_stats_inc(&sq->stats.stop);
 		u64_stats_update_end(&sq->stats.syncp);
@@ -1012,7 +1039,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
 		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit(sq, false);
+			free_old_xmit(sq, txq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				u64_stats_update_begin(&sq->stats.syncp);
@@ -1138,7 +1165,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, false, &stats);
+	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
+			false, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -2313,7 +2341,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit(sq, true);
+			free_old_xmit(sq, txq, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
@@ -2412,6 +2440,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 		goto err_xdp_reg_mem_model;
 
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
+	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
 	return 0;
@@ -2471,7 +2500,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, true);
+	free_old_xmit(sq, txq, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
 		if (netif_tx_queue_stopped(txq)) {
@@ -2505,7 +2534,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	return 0;
 }
 
-static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
+static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
@@ -2549,7 +2578,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg,
+				    skb_to_ptr(skb, orphan), GFP_ATOMIC);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -2559,24 +2589,25 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct send_queue *sq = &vi->sq[qnum];
 	int err;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
-	bool kick = !netdev_xmit_more();
+	bool xmit_more = netdev_xmit_more();
 	bool use_napi = sq->napi.weight;
+	bool kick;
 
 	/* Free up any pending old buffers before queueing new ones. */
 	do {
 		if (use_napi)
 			virtqueue_disable_cb(sq->vq);
 
-		free_old_xmit(sq, false);
+		free_old_xmit(sq, txq, false);
 
-	} while (use_napi && kick &&
+	} while (use_napi && !xmit_more &&
 	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
 
 	/* Try to transmit */
-	err = xmit_skb(sq, skb);
+	err = xmit_skb(sq, skb, !use_napi);
 
 	/* This should not happen! */
 	if (unlikely(err)) {
@@ -2598,7 +2629,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	check_sq_full_and_disable(vi, dev, sq);
 
-	if (kick || netif_xmit_stopped(txq)) {
+	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
+			  !xmit_more || netif_xmit_stopped(txq);
+	if (kick) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
 			u64_stats_inc(&sq->stats.kicks);
-- 
2.45.1

