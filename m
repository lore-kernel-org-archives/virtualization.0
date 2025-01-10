Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481721B199
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540785; cv=none; b=uWrD+wFXzxZOW/u6DBV+yaqExfkfPnzlvhniooDhUdRKy/hiIln67dx0TbbrAznCMrYXD0xXqHdnXi3WBECkkzC6DxMJuSpIAKZOmNcugRUpE/DI5y/X51vPu89lJjOUqoud7vPYTSPJEuv8UlJMtaFFtQKGGJlkzGklus+zOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540785; c=relaxed/simple;
	bh=nXNvmseKjVxOB/p5zaC6W1Bj1mcIQTUBPceRSuG8Qpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHTZOi8gZq6xVgFospAAYAND0FadfpofU0lvoS+eGbaXFn807bhOIn5zoIRfD1B/hVY66NRsJdhm2MzK5KXnXKqgxpd0LykACEktJda12kh4/OsKDR0QYoscQR6hpQ07LUgISrjYXPGivYCoIUxPkbt0pUJJGaGo6wLHgmW38r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=A4ZCVl4I; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="A4ZCVl4I"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso3521867a91.1
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540783; x=1737145583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5Wc1BZX0qLlows6HUppLFsWMw9e/cDJxHu3IFsmtDc=;
        b=A4ZCVl4IiDMG6+AZHWoOduFvbe39SYa0TCZeOlrF3KzefqmkaF27cw/A7yzAdzCJuA
         8lggz7t46zZjaZjydmLRqe88h5F4kfdRxMtOZpgu3FPAnzm+daWBlQo+19CAjknPRjrR
         ktzJpSsIrZ+TmKIuWF3zdWTJ2ntLxBzyWkAt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540783; x=1737145583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5Wc1BZX0qLlows6HUppLFsWMw9e/cDJxHu3IFsmtDc=;
        b=uiQoB6hj5UbOUukXhWcNeadA+pR4Rb86LE4bcibS/+J2aFJJY0KDFYuxy8cwYV02u2
         l+su8azi3RoVsurT9x58F5GlUB/B8PFk85cryJykExGnt3HT9SBGbcAlhR2SVrOWVQTT
         GaYSquf7JwP4q/lXFbym+vxZ0DcrnGs9VzOfQxGVBmgsaOyFXlN1WUV+uGxY5UCdInNd
         xKvpGN6OpZCh4ofF/s44q+VIH13Ba19kK2QG/1kxyQ4wnuypQx131qzSl7kwC5akg1BH
         CATzu/EDttYjhs0myOFsNieyplcgxQFzE0jRVmkTUFgZk7FLu7+XFoE7EpSTmCZlKVO5
         N/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX33+TQgWE6md5r5SJY87rCdFPDyEWEzdj/09I4pUz9YVbGhBa9T5IjzB3o4MXt/jlxwuY+MNu9ijvsyDZTNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyie/e5vdB3PcTqssWxZU5N/zscgF347HbwRGUVX/3pCdpe9RUj
	0mdKF7ThbnkB+kXxf3t7d3CxyxJxSxXOqfY+vOhOiLuDgKCb9AzWikasd1iRhw4=
X-Gm-Gg: ASbGnctD3mP8+7F6biGzO4ay2gaBDrR+yxfUOZCUSlwirjQwi99BtoLcJgCKs5Z2XAz
	biTquJMHksUxhPuAPeySRq2UM0r7k8QmadzytTIIKbb9ht5yNuPHEOWXTWUzBBEOj1U+AhAe8Qd
	2il76RFHulwwrL1P3HtHZ9PXI6AtqY9aNUtOrYoz47Zh3HixtL6I4ucF6GqKJEtGJeqmPRFncdV
	+CtyubpTccQrtyQrQ8+B88z899sO3Ed1G5wA+tfw0WVQQHCWE9YzMuoSSNljiaM
X-Google-Smtp-Source: AGHT+IGIJhOnEc3zWaTR7ImuwsB7dqzjQabiuroM48+nisL8PT0O38c5xZ0k4VU0MQuusWD0teh7Jg==
X-Received: by 2002:a17:90b:520f:b0:2ee:db8a:29f0 with SMTP id 98e67ed59e1d1-2f548f1b7e6mr16773814a91.27.1736540783484;
        Fri, 10 Jan 2025 12:26:23 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:22 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
Date: Fri, 10 Jan 2025 20:26:04 +0000
Message-Id: <20250110202605.429475-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
References: <20250110202605.429475-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps.

$ ethtool -i ens4 | grep driver
driver: virtio_net

$ sudo ethtool -L ens4 combined 4

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
the lack of 'napi-id' in the above output is expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4e88d352d3eb..8f0f26cc5a94 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2804,14 +2804,28 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 }
 
 static void virtnet_napi_enable_lock(struct virtqueue *vq,
-				     struct napi_struct *napi)
+				     struct napi_struct *napi,
+				     bool need_rtnl)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	int q = vq2rxq(vq);
+
 	virtnet_napi_do_enable(vq, napi);
+
+	if (q < vi->curr_queue_pairs) {
+		if (need_rtnl)
+			rtnl_lock();
+
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
+
+		if (need_rtnl)
+			rtnl_unlock();
+	}
 }
 
 static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
-	virtnet_napi_enable_lock(vq, napi);
+	virtnet_napi_enable_lock(vq, napi, false);
 }
 
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
@@ -2848,9 +2862,13 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
+		rtnl_lock();
+		netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+		rtnl_unlock();
 		napi_disable(&rq->napi);
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable_lock(rq->vq, &rq->napi);
+		virtnet_napi_enable_lock(rq->vq, &rq->napi, true);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3048,6 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
+	netif_queue_set_napi(vi->dev, qp_index, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable(&vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
@@ -3317,8 +3336,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
+	int q = vq2rxq(rq->vq);
 
 	if (running) {
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NULL);
 		napi_disable(&rq->napi);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
@@ -5943,6 +5964,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
+			netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX,
+					     NULL);
 			napi_disable(&vi->rq[i].napi);
 			virtnet_napi_tx_disable(&vi->sq[i].napi);
 		}
-- 
2.25.1

