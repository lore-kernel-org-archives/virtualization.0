Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653E4C9F
	for <virtualization@lists.linux.dev>; Tue, 18 Feb 2025 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846365; cv=none; b=iGEb5FOgaLObm6ajxr31KvWbjm9YWfEcTo59ocvF7WIrChHK/4fNlrrY/hXm4pE9TgQiGqlGLOgibYYvm9vhsCYbinOPLO7gXaPsOUbUYiR3nAzZifX4Z2QZ42I1RH3CO0+jsiTM8d94dF4C11ug6dADEaojxvP4wj2F+QyA9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846365; c=relaxed/simple;
	bh=XYKTxWIY8WkAi6EQk9rM5/LYwSGuFSyR39aS7SeeGxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAB4v56Rvp6xObqAdi+nFTvDC2a82hMISJEttyoCY+lUKGGdVAroXodBaoTOwsyW/lJdCvJr4z1AB9ABUSi93L60benfTNovXaiebc5yxCg/VK9TRKowOtJcYbHPk57wnpz0k4HV2mnoHvgsjQL0KiatZVhusYvEZWxCBbYBY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmGPSo0j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmGPSo0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739846361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BSJXCcaXZJnQ9dzb7rdYVPIMXJ/QVoaHaudkSEF5u+A=;
	b=BmGPSo0jHT8Kh8u5dVyybY5LkO5USksLmlDbiVnS25jLtx9oRp4tmbcdWiLWgbYWCH9EHe
	6hEBuu6+KhTouj3RWF+OPWTuHAd8rtTTmVqgm9h9L9JjqWKpfvzvjeCscHSJazO8wj0sWo
	YK9LB2u8cVxSQLGpHI0Tdrd2euDJwKE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-vBSwEWu6OOyeqHoKwRWg1w-1; Mon,
 17 Feb 2025 21:39:20 -0500
X-MC-Unique: vBSwEWu6OOyeqHoKwRWg1w-1
X-Mimecast-MFC-AGG-ID: vBSwEWu6OOyeqHoKwRWg1w_1739846359
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DBB91800373;
	Tue, 18 Feb 2025 02:39:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.151])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A35A19560AB;
	Tue, 18 Feb 2025 02:39:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] virtio-net: tweak for better TX performance in NAPI mode
Date: Tue, 18 Feb 2025 10:39:08 +0800
Message-ID: <20250218023908.1755-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

There are several issues existed in start_xmit():

- Transmitted packets need to be freed before sending a packet, this
  introduces delay and increases the average packets transmit
  time. This also increase the time that spent in holding the TX lock.
- Notification is enabled after free_old_xmit_skbs() which will
  introduce unnecessary interrupts if TX notification happens on the
  same CPU that is doing the transmission now (actually, virtio-net
  driver are optimized for this case).

So this patch tries to avoid those issues by not cleaning transmitted
packets in start_xmit() when TX NAPI is enabled and disable
notifications even more aggressively. Notification will be since the
beginning of the start_xmit(). But we can't enable delayed
notification after TX is stopped as we will lose the
notifications. Instead, the delayed notification needs is enabled
after the virtqueue is kicked for best performance.

Performance numbers:

1) single queue 2 vcpus guest with pktgen_sample03_burst_single_flow.sh
   (burst 256) + testpmd (rxonly) on the host:

- When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
  increased 55% from 6.89 Mpps to 10.7 Mpps and 32% TX interrupts were
  eliminated. Packed virtqueue PPS were increased 50% from 7.09 Mpps to
  10.7 Mpps, 99% TX interrupts were eliminated.

- When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
  were increased 96% from 5.29 Mpps to 10.4 Mpps and 45% TX interrupts
  were eliminated; Packed virtqueue PPS were increased 78% from 6.12
  Mpps to 10.9 Mpps and 99% TX interrupts were eliminated.

2) single queue 1 vcpu guest + vhost-net/TAP on the host: single
   session netperf from guest to host shows 82% improvement from
   31Gb/s to 58Gb/s, %stddev were reduced from 34.5% to 1.9% and 88%
   of TX interrupts were eliminated.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..ac26a6201c44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void check_sq_full_and_disable(struct virtnet_info *vi,
-				      struct net_device *dev,
-				      struct send_queue *sq)
+static bool tx_may_stop(struct virtnet_info *vi,
+			struct net_device *dev,
+			struct send_queue *sq)
 {
-	bool use_napi = sq->napi.weight;
 	int qnum;
 
 	qnum = sq - vi->sq;
@@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 		u64_stats_update_begin(&sq->stats.syncp);
 		u64_stats_inc(&sq->stats.stop);
 		u64_stats_update_end(&sq->stats.syncp);
+
+		return true;
+	}
+
+	return false;
+}
+
+static void check_sq_full_and_disable(struct virtnet_info *vi,
+				      struct net_device *dev,
+				      struct send_queue *sq)
+{
+	bool use_napi = sq->napi.weight;
+	int qnum;
+
+	qnum = sq - vi->sq;
+
+	if (tx_may_stop(vi, dev, sq)) {
+		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
+
 		if (use_napi) {
 			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
@@ -3253,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool use_napi = sq->napi.weight;
 	bool kick;
 
-	/* Free up any pending old buffers before queueing new ones. */
-	do {
-		if (use_napi)
-			virtqueue_disable_cb(sq->vq);
-
+	if (!use_napi)
 		free_old_xmit(sq, txq, false);
-
-	} while (use_napi && !xmit_more &&
-	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
+	else
+		virtqueue_disable_cb(sq->vq);
 
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
@@ -3287,7 +3300,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		nf_reset_ct(skb);
 	}
 
-	check_sq_full_and_disable(vi, dev, sq);
+	if (use_napi)
+		tx_may_stop(vi, dev, sq);
+	else
+		check_sq_full_and_disable(vi, dev,sq);
 
 	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
 			  !xmit_more || netif_xmit_stopped(txq);
@@ -3299,6 +3315,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+	if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
+		virtqueue_napi_schedule(&sq->napi, sq->vq);
+
 	return NETDEV_TX_OK;
 }
 
-- 
2.34.1

