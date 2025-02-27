Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9EE26D5B3
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682244; cv=none; b=ZFpVAP5BCIp+xaYXxRLvftgJAP2ygZg5VnorBqNEZ5RwyqMXj9IjI8pXlseL4LODr4qDMqSaIFHjKkkUgMeN+O6xNEbhYUvkWEkGvWcBuV3Olk6ZXvX1bHA8ReCD5lKMJtT1SvrZAgLJ2Zk20oCDzt6ObiK2dMYb04QRP/KIC50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682244; c=relaxed/simple;
	bh=oZEKZBNyzTFUQoyDm8VLIwp8l+Uss/+aDmlef+L4zKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RybrsKDCiur29a8nh2Wwt2uE+YQ2G05Di/fGCaKueBlBA0hsYlBoCMjVzXSrMAuGtQJ4pi0yhZ/Y0yvcvMmQAwNeT5Ctg5DS+Od/PpHfq4W2BIiq66QzrmdlFC7IzBSJgQk9U5WLM2hdrjQCg+9irVq3igoc/PsVIQcqhRh7bOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aWUoRkmB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aWUoRkmB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2234e5347e2so27346275ad.1
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682242; x=1741287042; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=aWUoRkmBt8ovfppb4fkekR3wI5OM0Sq3hAh02UKmXFD+Fxo0bVymq1KxgtvQQ/1zKU
         Gr+LoX4yS+gMi5sKGHhMUh0G2D8nJ5IXTJHdM6iCO/7TIncaM/K7iuIYLaikWhd/YKqB
         0YbC5wQ0pusukG4y6Qd0qPu+e1b32OZzFeqg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682242; x=1741287042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=FOLf5Ob9+I8byRgEE9g1FiIfysW1t6sreTjHewPBIe2bZJA8kUgmIXB6ketAym43PY
         +gwxuZJZKQYYg9kss7hmBDhjILR9e/r5Vr7icjUedxbOw2i1wvmulympFboyB5d7DFRI
         bl0jYjo49UqCbujFNNvX5/9k/BSBHjeLqOcW2a9qJ+sTF9S4NnC+l9MHnskKXtFHwGPk
         O+8gwNPoYHdiz8UgFzKHAupIn0B0SFaMIO161byiIVI+Dux+RINY3wgG2TijCzelpxIk
         2s7YE2OPzE4dNTpvm9KCcoQJyNz0KhDSaXXt1Beay5s0+MsICFfs1E6HH5ZRC5jVevjg
         Okww==
X-Forwarded-Encrypted: i=1; AJvYcCVkuF34sGnr7y5fPc6GXwvYPYwS6GmM4oMzpVYEaVWuJw/3IkqGhqHJorzU8HBjqaAKeW9AoO/T8nLsiEdYvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIkd/Rik0IYco37BbdBGYc68hJGO1G7H2QiSX9i4F7u+4iDjpi
	KNOcHHyOrvpikiRN+K9jKcYriNgsQG2U6h15+Fi42rhiYV/dUuFSuEh0juvm0f8=
X-Gm-Gg: ASbGncu1aBqCfJzRiq3gCMuB9/i9r1nDMNi8aM8FPHMflKGyYxBvXmlUnf2c1lrTCUn
	HZIzFSFlJGKPtqaRLVZdiN6Qm0QxveUbe91mBh1l7WXBLtCE5wrcx6sv0UKgboDsGE6txiABle/
	9t6LD7iqUdRsPGW9koc47dYfZv1B6rO1Zhznc5lKs4Ljev969WSJmfWG/sqQDMkUvaofLAQEaXt
	Mn7E8D6EKP4Lz446MlPfPnZxCySoQo2ef7KvDZqsBA6AI0j3MFaxDE51mWZ2FYYlQW4b1PD1ifF
	yZENHz7Acm4jJ7xyWniegkvwse/XcgQfUQ==
X-Google-Smtp-Source: AGHT+IGZcb+iC6eZQd5zAGhqgRUruIqyeQKBvaS/JmNMwuWmIIK9UyEnnF0UseSHFo77HzWGMN4JpA==
X-Received: by 2002:a17:902:fccf:b0:220:e63c:5b08 with SMTP id d9443c01a7336-22368f6a1b5mr3409305ad.11.1740682242112;
        Thu, 27 Feb 2025 10:50:42 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:41 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 1/4] virtio-net: Refactor napi_enable paths
Date: Thu, 27 Feb 2025 18:50:11 +0000
Message-ID: <20250227185017.206785-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor virtnet_napi_enable and virtnet_napi_tx_enable to take a struct
receive_queue. Create a helper, virtnet_napi_do_enable, which contains
the logic to enable a NAPI.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac26a6201c44..133b004c7a9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2807,7 +2807,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2820,10 +2821,16 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
-static void virtnet_napi_tx_enable(struct virtnet_info *vi,
-				   struct virtqueue *vq,
-				   struct napi_struct *napi)
+static void virtnet_napi_enable(struct receive_queue *rq)
 {
+	virtnet_napi_do_enable(rq->vq, &rq->napi);
+}
+
+static void virtnet_napi_tx_enable(struct send_queue *sq)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct napi_struct *napi = &sq->napi;
+
 	if (!napi->weight)
 		return;
 
@@ -2835,7 +2842,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(sq->vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
@@ -2856,7 +2863,7 @@ static void refill_work(struct work_struct *work)
 
 		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3073,8 +3080,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
-	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
+	virtnet_napi_enable(&vi->rq[qp_index]);
+	virtnet_napi_tx_enable(&vi->sq[qp_index]);
 
 	return 0;
 
@@ -3339,7 +3346,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3402,7 +3409,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
 	__netif_tx_unlock_bh(txq);
 
 	if (running)
-		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+		virtnet_napi_tx_enable(sq);
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
@@ -5983,9 +5990,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 
@@ -6000,9 +6006,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 	if (prog)
-- 
2.45.2

