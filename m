Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAD14EC46
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449117; cv=none; b=PnsLxcL8dYjqsbGqR5AvU/zrc7odxUCTPIrCT9OtuExUJecRiQz6wy3K5IEUpMC/LSEMCV+1RNMPmlmChnDFTJOkd3GW6ff+Ctsr/l34oaiKpvdg8/FIB9id+cPjNbgQT+T4bOpmdc2z9kuMLz8kii5cPCi8HNXjvZnkdseYA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449117; c=relaxed/simple;
	bh=YqThljS+z2rvWEULTOq783byam96cUms4PJNbrKe1eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJS8/A4O9htKHE4e/vxYMNeuk1PcuCOHmETso7xZERpz3c9qmRwzggVF40t9iOHMtoSvWJk9x/LUFK6KwDgt3xQVibGGj7oz7WgQUU9Vxk7bPonJudjbeDdS9yBGLMBa97T1BHr/g817E6+SGX9ofY/dUFjyAj2v0ZyX0qXARe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GS974NA+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GS974NA+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d398bea9so80468385ad.3
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449115; x=1741053915; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Snh9ND17tUPe0ximyCM9OYF2x7OPKQXCCkpOdmoFuU=;
        b=GS974NA+2ha8gtbaFbhUlTp5HeaQh8L9VJ7vemH34E9N0eqjz8m6SZp8+1T+TBH4vd
         JVBP/AqHOJOvJZ6FH8VjII1ckCuZ56B4ZrZZSygyen6JrgjJ1WAeIAWQfyhxNSMgcjqo
         OthYOVGdarbpFg1Isc3g9x+FSBsapcyarrckg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449115; x=1741053915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Snh9ND17tUPe0ximyCM9OYF2x7OPKQXCCkpOdmoFuU=;
        b=PRFoAVYJyuRck9kK+Am5vJJtxIAl1YkM7uIwFzCLEvRleCgVaXvOJYmaX2Ls+SqiDh
         o3umWRbkFw8GKmEVrFd2fqjSX3zxXQR/JAJTYoRqh0CCnVz7brKHSHMQS5GOvCNabX9m
         /ja1WAKZ8Pw9UROPNhUhXyPZwsPCoufTGD6u3XkPmELvC95aSMV6uEuH27fK9QlFqG3K
         E3LLv7QLO5Lk9pJRTo4F0dAivKMOUoxqP8V8AGYtjWPAOTEEKyOWRVfVMpgxx1nXIQDD
         QztJbFlhR3fIm9/f/QVXnl3V7UjFrZJN4GGJHDg+9V1qZwsPH3z2oaLIzdgP83lt0STb
         9HwA==
X-Forwarded-Encrypted: i=1; AJvYcCULmAw4wwbM/4viUHgDtV8m8iJQVMa5by8ZRwocv4h+wEj+76mNj7iwz4kW/mXXHgSAtfkLzQVwAZEFCtYcgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZoip+zL+s9suZSujSTLiyMt7gk7/jlOn6/xkhtJs1GoFXfNn+
	EZUzAG/ULPW7GS5XB5TXAj1wwVNl5iEwr4jlu1Qt7RvqwC0XLmsqcawR5Vg3ZsGs3n/Rgpxv2UW
	Kp6w=
X-Gm-Gg: ASbGncvB8jy2/zZ0aJs5g2YENNFABNqYxPnaGs6OxT+U5jq5eeVk3tCKzAdYH8vsQWQ
	VV9v95W4hXqchazwgKGvPM4/MHTTw4tvBRgECbaZtMEFj5hnsxHRjQLBKYGfDcuPVYYJMPxWPmD
	pvtjZM0q842mZHjfDKgzzKLgh/Ipbn+JNqXYuTr93Fm8zf117iQMAS6c5DQmrN6LH3hkGddF1Su
	0NcCJcAB2QBa78uCO0S+VX8o7paABlQWjXY7bt0/KtVJ/2eiwHnUJLSap101HHbHqiKlpQWIT+u
	TfLHuuhNV5QyunhKtPKhBLpNdg/1kJRKvA==
X-Google-Smtp-Source: AGHT+IHCvop7PHEGOGbAsvCw/IG/lFcjljiGLYpCNBBJXObyJXhimwHpVmnD5+SRMh+DiFNZX2lEQg==
X-Received: by 2002:a17:902:ce8c:b0:21f:522b:690f with SMTP id d9443c01a7336-221a11b9bfdmr255955815ad.46.1740449114783;
        Mon, 24 Feb 2025 18:05:14 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:14 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Date: Tue, 25 Feb 2025 02:04:50 +0000
Message-ID: <20250225020455.212895-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
References: <20250225020455.212895-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps, taking care to hold RTNL as needed.

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
 drivers/net/virtio_net.c | 73 ++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e578885c1093..13bb4a563073 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2807,6 +2807,20 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
+static void virtnet_queue_set_napi(struct net_device *dev,
+				   struct napi_struct *napi,
+				   enum netdev_queue_type q_type, int qidx,
+				   bool need_rtnl)
+{
+	if (need_rtnl)
+		rtnl_lock();
+
+	netif_queue_set_napi(dev, qidx, q_type, napi);
+
+	if (need_rtnl)
+		rtnl_unlock();
+}
+
 static void virtnet_napi_do_enable(struct virtqueue *vq,
 				   struct napi_struct *napi)
 {
@@ -2821,15 +2835,21 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 	local_bh_enable();
 }
 
-static void virtnet_napi_enable(struct receive_queue *rq)
+static void virtnet_napi_enable(struct receive_queue *rq, bool need_rtnl)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	int qidx = vq2rxq(rq->vq);
+
 	virtnet_napi_do_enable(rq->vq, &rq->napi);
+	virtnet_queue_set_napi(vi->dev, &rq->napi,
+			       NETDEV_QUEUE_TYPE_RX, qidx, need_rtnl);
 }
 
-static void virtnet_napi_tx_enable(struct send_queue *sq)
+static void virtnet_napi_tx_enable(struct send_queue *sq, bool need_rtnl)
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
 	if (!napi->weight)
 		return;
@@ -2843,20 +2863,31 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	}
 
 	virtnet_napi_do_enable(sq->vq, napi);
+	virtnet_queue_set_napi(vi->dev, napi, NETDEV_QUEUE_TYPE_TX, qidx,
+			       need_rtnl);
 }
 
-static void virtnet_napi_tx_disable(struct send_queue *sq)
+static void virtnet_napi_tx_disable(struct send_queue *sq, bool need_rtnl)
 {
+	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
-	if (napi->weight)
+	if (napi->weight) {
+		virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX,
+				       qidx, need_rtnl);
 		napi_disable(napi);
+	}
 }
 
-static void virtnet_napi_disable(struct receive_queue *rq)
+static void virtnet_napi_disable(struct receive_queue *rq, bool need_rtnl)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct napi_struct *napi = &rq->napi;
+	int qidx = vq2rxq(rq->vq);
 
+	virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX, qidx,
+			       need_rtnl);
 	napi_disable(napi);
 }
 
@@ -2870,9 +2901,9 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		virtnet_napi_disable(rq);
+		virtnet_napi_disable(rq, true);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq);
+		virtnet_napi_enable(rq, true);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3069,8 +3100,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
-	virtnet_napi_tx_disable(&vi->sq[qp_index]);
-	virtnet_napi_disable(&vi->rq[qp_index]);
+	virtnet_napi_tx_disable(&vi->sq[qp_index], false);
+	virtnet_napi_disable(&vi->rq[qp_index], false);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3089,8 +3120,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(&vi->rq[qp_index]);
-	virtnet_napi_tx_enable(&vi->sq[qp_index]);
+	virtnet_napi_enable(&vi->rq[qp_index], false);
+	virtnet_napi_tx_enable(&vi->sq[qp_index], false);
 
 	return 0;
 
@@ -3342,7 +3373,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		virtnet_napi_disable(rq);
+		virtnet_napi_disable(rq, true);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -3355,7 +3386,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
-		virtnet_napi_enable(rq);
+		virtnet_napi_enable(rq, true);
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3384,7 +3415,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 	qindex = sq - vi->sq;
 
 	if (running)
-		virtnet_napi_tx_disable(sq);
+		virtnet_napi_tx_disable(sq, true);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -3418,7 +3449,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
 	__netif_tx_unlock_bh(txq);
 
 	if (running)
-		virtnet_napi_tx_enable(sq);
+		virtnet_napi_tx_enable(sq, true);
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
@@ -5961,8 +5992,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_disable(&vi->rq[i]);
-			virtnet_napi_tx_disable(&vi->sq[i]);
+			virtnet_napi_disable(&vi->rq[i], false);
+			virtnet_napi_tx_disable(&vi->sq[i], false);
 		}
 	}
 
@@ -5999,8 +6030,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
-			virtnet_napi_enable(&vi->rq[i]);
-			virtnet_napi_tx_enable(&vi->sq[i]);
+			virtnet_napi_enable(&vi->rq[i], false);
+			virtnet_napi_tx_enable(&vi->sq[i], false);
 		}
 	}
 
@@ -6015,8 +6046,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(&vi->rq[i]);
-			virtnet_napi_tx_enable(&vi->sq[i]);
+			virtnet_napi_enable(&vi->rq[i], false);
+			virtnet_napi_tx_enable(&vi->sq[i], false);
 		}
 	}
 	if (prog)
-- 
2.45.2

