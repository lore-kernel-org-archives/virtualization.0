Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092911BC3C
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607367; cv=none; b=hHy8m8NFMHGbomdeNT5rsVhPNE9bu3NdV36ZojafqBmXwyL3qcKcrqQksdho6NlDzCRo7ySvEd4u44xnhebK7D02M53qGUZqMDRsEVq4fFsVocZTpshBIr4EvWUH1QzSMLstm0UjXEDwqjeaonY4gjBWQ85Ol1halXtYthgmXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607367; c=relaxed/simple;
	bh=LAqM7pdFY5uYBhtKsTe5wOlUvRbdtlTtvnMwlz4eVRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR6eXeocEu4or47tx+6YlGi1PQsU9jOhQVFZ/QNLWi8atczPeUJY8cwzU4abh90LH6/68d5Li1gzo8z0FLKUT1AmdcVyLvI4G2u9h1j27I5m1areSVxusAQuDAmPCx1XkPWbhnK92AQzQSQRDd40tLzuy1tdnPcxRYvXkVfFvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSOjnqN8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSOjnqN8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso52471215ad.2
        for <virtualization@lists.linux.dev>; Sun, 13 Apr 2025 22:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607364; x=1745212164; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTXn7wUxtDAnsVPk+xJ6XC8d5pS18e6iNJS/eIvyuiA=;
        b=cSOjnqN8ycDpK/aLovBNTx6VSEjoPPXozyFn4OKTOMZxJhmTYDhTJdiqPuoBrVcNtq
         tESfjBVR/kErULSnjKCK2rsvIuvnjhPHt6lc16f7SxCerBJ1kkfY00k4K71lij60uhDh
         s8gruH13sLNiVX+rqVQY7AfnmsuYdwyKx4J/z4gI1vxqDf0oNCFWTAxqVUz48taek45b
         Tn9+/vLTCHq+IhWvMiQM3vbx8hGGMycxzrE/2Io2k7qLiVgsH8eqwr3W3KRR8dV5PX5W
         DyB1Os/EIJXWy23f/rMc6aNmJ67MI5nKOt1jJyNmgHFY6xpFbzr8cfVSQMsOWb0AP0iW
         0y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607364; x=1745212164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTXn7wUxtDAnsVPk+xJ6XC8d5pS18e6iNJS/eIvyuiA=;
        b=L4U5yeo4hHL8XZ/qmLyFOC3WpqKZLBUKaDQnvHwRNYszW0OEMbc7eJESrh0dUKlF6W
         tpajTPr5gCUvPc6iNHWWxGS7KnOwVBfmp0F1fQHhcBe9GYNSv5Y9wMeZq4P7w/2u/2Eo
         /m9jSVUctLBGDwSD6X2SXYuCUR4+WNeEBACzyxALvzmZhEUsNhGwxcVmEJDyHAa3p6dT
         gAoyyAbFASRxw694YZ8VhbulepkKEcWaUDeraHGuBRuUj018jHEWoDYf40FVYM5YNeV/
         G9zIcznxaL3QcXGf4lMYUjPN2ns5/n7WAmHV8bpXYbtO04vQHl4lvHI3e2/hv27cWxHO
         fPag==
X-Gm-Message-State: AOJu0YzJq297r+fu52PMufP2/cQqLc5fb7sR6n2sqHQmnKHbmJ1ftowl
	+szUwEHP1l4dwWTOtgw/Vcq3g2s5it7z0Ys3M0nwjbyySPnvXVj+xC7FNrC1is0=
X-Gm-Gg: ASbGncuwVUfNAgcryUH2by2+m9sLAaIpZ8FpUdeQF13dao4djTVHPnP1mCX62fPr5AJ
	Aw+AwQ8M1mkgt4iEIIAV8kSbOTjk8n4xQUVwkp5f0MDv4UMOJQauE+1F4dkLwk/b9lzLI5/5G/k
	cfojDL/RFZ4D2rcX5jemAtv7acdf+Nsg66VBdP8u2MweueumVCXZwomeNB0lyUTt4chuWe5N2ts
	TeGTjZ5PZGSW6t8MtIwgnFxZX8dTxddivvVZnh98aQjgFQX2S5/c8xQrPswm4NggUnlKtjxMq2z
	K9w0eCBcRIEBpY7E+3JzkoEpjPC07VpQHkCbmyGoYMxlaOkiKdPZtcUIukCo+CFK0A==
X-Google-Smtp-Source: AGHT+IH7f0CknUb+6MEjVojl4lI4iFs1kPGlPHbcWFIW45FscoSes5CP7bnZxlO1IqjFQUpKfftBEA==
X-Received: by 2002:a17:902:d2d1:b0:223:f928:4553 with SMTP id d9443c01a7336-22bea50bb7dmr157537155ad.44.1744607364148;
        Sun, 13 Apr 2025 22:09:24 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:23 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
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
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v2 1/3] virtio-net: disable delayed refill when pausing rx
Date: Mon, 14 Apr 2025 12:08:35 +0700
Message-ID: <20250414050837.31213-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414050837.31213-1-minhquangbui99@gmail.com>
References: <20250414050837.31213-1-minhquangbui99@gmail.com>
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
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 60 ++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..4361b91ccc64 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3342,10 +3342,53 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static void virtnet_rx_pause_all(struct virtnet_info *vi)
+{
+	bool running = netif_running(vi->dev);
+
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+	if (running) {
+		int i;
+
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			virtnet_napi_disable(&vi->rq[i]);
+			virtnet_cancel_dim(vi, &vi->rq[i].dim);
+		}
+	}
+}
+
+static void virtnet_rx_resume_all(struct virtnet_info *vi)
+{
+	bool running = netif_running(vi->dev);
+	int i;
+
+	enable_delayed_refill(vi);
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (i < vi->curr_queue_pairs) {
+			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+				schedule_delayed_work(&vi->refill, 0);
+		}
+
+		if (running)
+			virtnet_napi_enable(&vi->rq[i]);
+	}
+}
+
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
 	if (running) {
 		virtnet_napi_disable(rq);
 		virtnet_cancel_dim(vi, &rq->dim);
@@ -3356,6 +3399,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
+	enable_delayed_refill(vi);
 	if (!try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
@@ -5959,12 +6003,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
@@ -5996,13 +6040,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
@@ -6014,11 +6057,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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

