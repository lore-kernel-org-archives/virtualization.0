Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F21422A8
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449115; cv=none; b=OP2ovhQvGjA5CJg7FoKC1gj2iitcmY7w7tG0aWg4xep612NqxnNA9SiulZSXrmkRJOJo5XWfr7s9oCxU24MHv3YIsNOrmZCkR4Zp4QnIxr5k6qQssvCTUp+fuA/6uoLhx3p0CvSWjmH7BBXwqNB2m66un9r9vdr7oDOtEJmQrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449115; c=relaxed/simple;
	bh=GWWDChFIQB2blY/jPfW79k1D8RtfKUSWn6cGyll0Ezg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZglE4a/BhsxdGWS+54ZwxsIgHO6tEpTS+rQ72xX2/BO0z9l3sZk6rt9GuBBoI31vEpDvtng2vGKXaePZBjEQrUl3kzLx7OMsRfTLeFVBZn7VxXdct/RLYqHNCa9heFIihxcXkRJNNascsq/hu97bJROqCL2ejHSEfxz7SAwrpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GiGkR5Ia; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GiGkR5Ia"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22128b7d587so97966295ad.3
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 18:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449113; x=1741053913; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nd9NSzHqA5rIn7zkDOos29JmkSo0ut7TBrki2afWb8=;
        b=GiGkR5IaUrESo6XqtNxs9mJdYZ2m+vJE6LPoM6fKktWJuKBLzzD8fm+gpZqN6zVVo2
         qPzWN7iee+fhr0/w2lJRkFrZTXK5NrxAgDf9RAC89OsQJWCfTTQ+yPqLRCI4rfzmlJmD
         Wa8rrV8cQlPrzJLVvW/bI0Menmg8TmU/IZt2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449113; x=1741053913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nd9NSzHqA5rIn7zkDOos29JmkSo0ut7TBrki2afWb8=;
        b=OJaFOMhHb4LEvgi97amW/ZodkEVULTIv3TKDVX503YAKsKjtg9RygfUQMcV9eRjcZB
         8BtR4ISScCYjec+fAT8WxTLA8W5JNLCt+2RLnPOXqJRJC8Wt7DZFZuAAId+ylpBNGDk1
         dLULUBqho8oKngApCaFqzb0ZRtS5hMUmdjL9ECI7UL08cCYGJWibvPNxN+/Lbeq73lNO
         2AJ/EHkqRA/XWX5nVQTb/MoP3HUAxsXOS98vMUXdq9CDqjhk43/zMvV9gHzFxHy/N4QK
         Px/9krRAPNJTVOqlBiMg7FuMoT82+Gjs2OZSa92VlPmSK9F3RBb73kcx7xnSPMUSA1LG
         aeDg==
X-Forwarded-Encrypted: i=1; AJvYcCXr6iWR1GaHTFamJBU6z4m07vCiZ5nZyNqSsfIaetiF0Ybp7CuxO0E/ZwYDppTEj/NG1LGkND54cVySZenI+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxh+btcyR1eJORhxzvM4f1IJDVX9cxQnxHzou6YcTmEjrkvxdk
	K3SlFbzrAfVBkdk5jOSI3YTqUiv12apa4p8Q72os28p0zepT5uBv2M5ctF+LYBE=
X-Gm-Gg: ASbGnctisTe4akWk1SB+pjFpTr7SqOVD26j+Uo/sd8RJ+1ublmiz5reAufv8rZfqeX2
	eq33TG5pBDYFE2rkepJTW8UYMieuoSKIkqfffXcQ72V+uWgZUVDLLM+VQPpQi77LYRji9cQ0Up2
	sbpLWpwNihDGLig2OcRd/QoNv01g1bwU2f/TYJzj6Oxbw8Moa64+Wav3IgSB5NquZA7Y8VMRtjz
	q1hC9Z6OR2rNCwSp/V0vZ0gUS9Wo3uhwI3pWLdR4RjCrvo03BKemvXx/epP2OfzcaC02Wp9PgEo
	q8481Iy4I4bQYtIMuOCqYOkV67twkwuKhA==
X-Google-Smtp-Source: AGHT+IFv9Txtr44zQZYD0oHJYIFMzObgMUa7hD66RW/Qe+HC1Hn+TXbMiigLaJAVRrR47Zqg0gTjmg==
X-Received: by 2002:a17:902:d4cf:b0:21d:cd54:c7ef with SMTP id d9443c01a7336-2219ff31902mr229422035ad.9.1740449113075;
        Mon, 24 Feb 2025 18:05:13 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:12 -0800 (PST)
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
Subject: [PATCH net-next v4 2/4] virtio-net: Refactor napi_disable paths
Date: Tue, 25 Feb 2025 02:04:49 +0000
Message-ID: <20250225020455.212895-3-jdamato@fastly.com>
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

Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
to take a struct send_queue.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 133b004c7a9a..e578885c1093 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2845,12 +2845,21 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	virtnet_napi_do_enable(sq->vq, napi);
 }
 
-static void virtnet_napi_tx_disable(struct napi_struct *napi)
+static void virtnet_napi_tx_disable(struct send_queue *sq)
 {
+	struct napi_struct *napi = &sq->napi;
+
 	if (napi->weight)
 		napi_disable(napi);
 }
 
+static void virtnet_napi_disable(struct receive_queue *rq)
+{
+	struct napi_struct *napi = &rq->napi;
+
+	napi_disable(napi);
+}
+
 static void refill_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
@@ -2861,7 +2870,7 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq);
 
@@ -3060,8 +3069,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
-	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_tx_disable(&vi->sq[qp_index]);
+	virtnet_napi_disable(&vi->rq[qp_index]);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3333,7 +3342,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -3375,7 +3384,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 	qindex = sq - vi->sq;
 
 	if (running)
-		virtnet_napi_tx_disable(&sq->napi);
+		virtnet_napi_tx_disable(sq);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -5952,8 +5961,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
-			virtnet_napi_tx_disable(&vi->sq[i].napi);
+			virtnet_napi_disable(&vi->rq[i]);
+			virtnet_napi_tx_disable(&vi->sq[i]);
 		}
 	}
 
-- 
2.45.2

