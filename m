Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27021D3E6
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874969; cv=none; b=S94jNqarQv8naNUk1+XhebiNiBDQl2CRU+fSbcScwcFrvaPHzFLEEMebGhOXjDLRA+Vp2B6cBh1eEGnxFht4o5wDS/tvpZArOHzxh96FfkLoYbSiPn7UbcDXX/zscDtnEkznUvdcgKX6S9SQyoMJ1k25AYm9rfp6FXHTRiaIjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874969; c=relaxed/simple;
	bh=KiR5G6Fufw0SgHFVKQy2aPbgCtBtp88qoVVLIiw5sm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3iJqjB4l4OP+smX7B+2uJOkFYOqLb3+STMhdtHOvYw1xIcPCSGuG12e4bGsiVO4qIDr6TK1g24RWdmpIorGkb9TXmjv+MfkAKr2Fa24X5CBxvHWfRcwtq39nFijA3dsmhZnwx1knMOGc5/CRMVfds0cCotB+TxCTn+Q27X/Qmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YItP54UE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YItP54UE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fb0f619dso5579965ad.1
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874967; x=1745479767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3MstdJ91xUeyQ36419gRDtbusN2ivJYwyYBaexXaX8=;
        b=YItP54UEQ1bJrBsvkrUvgQLS4tVwfAjGhLPiTOniWRur3fS/jGuZC38CngxoQLqXWt
         GOYvI06ZSbbSLCBJd+lfz5b1h3tc/sbQXnyR7JyNaj9W0vTb7P9XphobUncd6I8wLtZ/
         dQgj9uCAGHdOtI6ArU09Gu3poLZjkOopRuOjiivhRhYpVOFaJyU3Q13wP95ReaOSd1v2
         Hb6YNizFXGK0dDno9kVQu4ztZvVOotU2vorPs7SjHHi0Q5/ylknMOrpYXyEdEV0PaEz5
         W+GjHnZ22+Cam2Ih8KRYFwVz9lyBKl62/8xmSBrhOA+0YuNuiD3/TyOtw5KkgFx0XsXX
         qS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874967; x=1745479767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3MstdJ91xUeyQ36419gRDtbusN2ivJYwyYBaexXaX8=;
        b=vR9SVFVc5DF3aYvfUbFeWCLndKW44TWaw9Sk4e6lui8MAlLirkoEc25Qu3CBMMk0uz
         oTWjPYkUHC9GbfnnqC7E0+pu3/rqKgsElGeIHIAD9deuBoPWiZU5DtL2m4PvZxv+tb//
         V24lASd8ZgsESCnL9hcfjjCfipM0fu1fB3RJD4S9kaKyx7TqLxxHQhFV51QFUr5ajdMx
         MtpJ0i6IXjGuTwbn+gBVDjEnWhM0gvf3kN4YPMStoUO2C5UZpB2ZMHuweIH3HuoDfMYt
         TtgLZYljJ7HKdUT1KCsJSPmwd8rTIF/M0AOBdO/pdk74IEp+E9qbhFW4j0CfT3OEMRyV
         GE/w==
X-Gm-Message-State: AOJu0YyMIhYO4sPTLp4INxYviyVO5G6H9kYTmBuj+xyT7p0Owb+LSGIk
	et5UyJCl4lmI+As+RH4DKwV47mnJqV3CN3Vt57UcgeQf3a59/FDIl7azQWjD
X-Gm-Gg: ASbGncvaSxWswgG+yUnhJhyT/kCW9aKGzUbyMW/45dASQ1IWG7GW38HRmJ9GiQel+Np
	w5r5EJbfjTSoydyRDaHafEkEl0vLWLTH3OLPf7ootcHgB81MITMpCbgf08VmHgTwyJYOpy4/mC+
	VU5sx8ThYOV1VrodawNa2wit+tPHmBQavMPLHCF4r/UXjjli4ltbWHJh4mnh2qcmBVGEiQ07l9H
	wtU+23qjR5rOl+Zscd1IMN9QnKu67hJ/isxMI2sQZ26wqkTbRmRqkw9yTfCUyFPCn0bjCCkBatY
	zgW9iGEsHOnV9X0Ccp7D63pFUN8oamsdS/mCacngXpp0X3j8fw2fFRWt
X-Google-Smtp-Source: AGHT+IH5uYTC/cGu4Dc/9NlFeecZ6WGePFx+PPCoX4AhrVa3ZlbIOZm4LGGHrLfJG5dI1m1/e/4FAw==
X-Received: by 2002:a17:902:db10:b0:22c:3609:97ed with SMTP id d9443c01a7336-22c36099969mr63425985ad.30.1744874966710;
        Thu, 17 Apr 2025 00:29:26 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:26 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v4 1/4] virtio-net: disable delayed refill when pausing rx
Date: Thu, 17 Apr 2025 14:28:03 +0700
Message-ID: <20250417072806.18660-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
napi_disable() on the receive queue's napi. In delayed refill_work, it
also calls napi_disable() on the receive queue's napi.  When
napi_disable() is called on an already disabled napi, it will sleep in
napi_disable_locked while still holding the netdev_lock. As a result,
later napi_enable gets stuck too as it cannot acquire the netdev_lock.
This leads to refill_work and the pause-then-resume tx are stuck
altogether.

This scenario can be reproducible by binding a XDP socket to virtio-net
interface without setting up the fill ring. As a result, try_fill_recv
will fail until the fill ring is set up and refill_work is scheduled.

This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
virtnet_rx_resume to disable future and cancel all inflights delayed
refill_work before calling napi_disable() to pause the rx.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 69 +++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..848fab51dfa1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3342,7 +3342,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
+static void __virtnet_rx_pause(struct virtnet_info *vi,
+			       struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3352,17 +3353,63 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	}
 }
 
-static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
+static void virtnet_rx_pause_all(struct virtnet_info *vi)
+{
+	int i;
+
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		__virtnet_rx_pause(vi, &vi->rq[i]);
+}
+
+static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+	__virtnet_rx_pause(vi, rq);
+}
+
+static void __virtnet_rx_resume(struct virtnet_info *vi,
+				struct receive_queue *rq,
+				bool refill)
 {
 	bool running = netif_running(vi->dev);
 
-	if (!try_fill_recv(vi, rq, GFP_KERNEL))
+	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
 		virtnet_napi_enable(rq);
 }
 
+static void virtnet_rx_resume_all(struct virtnet_info *vi)
+{
+	int i;
+
+	enable_delayed_refill(vi);
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (i < vi->curr_queue_pairs)
+			__virtnet_rx_resume(vi, &vi->rq[i], true);
+		else
+			__virtnet_rx_resume(vi, &vi->rq[i], false);
+	}
+}
+
+static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	enable_delayed_refill(vi);
+	__virtnet_rx_resume(vi, rq, true);
+}
+
 static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
@@ -5959,12 +6006,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	if (prog)
 		bpf_prog_add(prog, vi->max_queue_pairs - 1);
 
+	virtnet_rx_pause_all(vi);
+
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
-		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_disable(&vi->rq[i]);
+		for (i = 0; i < vi->max_queue_pairs; i++)
 			virtnet_napi_tx_disable(&vi->sq[i]);
-		}
 	}
 
 	if (!prog) {
@@ -5996,13 +6043,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		vi->xdp_enabled = false;
 	}
 
+	virtnet_rx_resume_all(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (old_prog)
 			bpf_prog_put(old_prog);
-		if (netif_running(dev)) {
-			virtnet_napi_enable(&vi->rq[i]);
+		if (netif_running(dev))
 			virtnet_napi_tx_enable(&vi->sq[i]);
-		}
 	}
 
 	return 0;
@@ -6014,11 +6060,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
 	}
 
+	virtnet_rx_resume_all(vi);
 	if (netif_running(dev)) {
-		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(&vi->rq[i]);
+		for (i = 0; i < vi->max_queue_pairs; i++)
 			virtnet_napi_tx_enable(&vi->sq[i]);
-		}
 	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
-- 
2.43.0

