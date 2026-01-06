Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD223385B5
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711909; cv=none; b=lYITvZir8uFUTvKU6VO9nbnS4p1NyXYCLAAtHX9cS/QK9TTsOObfx7+HzNZXlO0zNO49/4qy4Ik1Ybf5GkoU3wgKbfLJzXnxV15QPyRkrXSk0BJ4R2XZUMMsnT3T3W1o9avSW4x1ntWdqSLpQa4oJO5fRAH58N1Ht0bqim7FJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711909; c=relaxed/simple;
	bh=8+XWm0MkuACUvng7Kj4q22bZFUfjvp4RMxeN/ue62pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhsicIg/dCTtPO1Mnl5AAZ35/y65EQof5qVN3c3/palPAu/8iymQLPXgdjhgmNqrYIkbQncS5/tAhn+IGihoqx5H7D/RmXhEkAJD6EsI1QERGuecfPGQwlR7lqJyCn/aSVX9j1qPScxjqukDgfFxAksSHftsYqHwE7osICWSVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImTWtwAb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImTWtwAb"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso549407a12.0
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 07:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711907; x=1768316707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dx88BuQonAnFzYSa3hWDepRze012ELPUSAZLctBXB8=;
        b=ImTWtwAbjLlTxw17eC91Lj9r+Y7gXmGX/vET7sokkXq4UC5ZhbzCRdgDpfh7ng2HU+
         PVN3h0HKTByHfB4EMmz8Xqqwwy8AWNG5fm7v7S7dSjWUGBvuYL5aIkx9gL0q4p96ZCtj
         jOpdYQsgHp362eS1nMPQY6mqmeSKyBN3sAy3lPhJsS5toHAcDSzlai1ChBgiP/pBqES5
         I4SHegcIZFh4Iw64g7QR7lH+qorp+f7ycrDZ2W7AIuSpbHnB4UzQAGOFjZbck+svWLgf
         L4CPDs3LP99uWnLSEVSrBnAE87igdt6kADsEgrrJMeZJ8f1f4T04j+GJQb8wYd0OGFEa
         b8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711907; x=1768316707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dx88BuQonAnFzYSa3hWDepRze012ELPUSAZLctBXB8=;
        b=k1m8Nfdt8D6QKGOXjqmf8p4zBIqmLJqcB7KMhKYyTbnmkrpan5gehiuLPDFOQWLTdI
         2lFmZEEz4JnxZbsJcuG5t4vgDnEb8cevN5mhuD+0J2bXeHTDPz7nPIh0wSxDQnnQEUyE
         bhTXGuvR+BWMcXTHTyaYO9fjkc0sQcf1qKA+dyIAhy0pdRr9qvj69JkhlPQgD1Gut8dI
         gCiG4JhrQN68/jdwo8fde9LCQm1b2DZOQJOoO8csIUf1SWcaXxkYzIhLIlesTG4b40dg
         s/3IrQqN01zQW52pLVrVNXFf6D0zoBn/jGnOLMdZnPgYYb7/VZ2koXaWD3l5g/DptxLe
         Le4g==
X-Forwarded-Encrypted: i=1; AJvYcCWEMXoqkq65ERgNJMGwW4ivjc4ZQRLx8bpOJZpPWE2I0TFwb+g2roXdNx8aolixZnkYxWZsb9cU0kR24wbw+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu7QITGqULzeM2c/RCNrD9wgrXYFiSxJ5WdQDczJVYfD7xwwDE
	FDErk7NeCSfKo1EaIvtNeGxy8xYdhPDQhl6TXBg43pwRmtw8ppRUUTm+
X-Gm-Gg: AY/fxX6XavJftkwZnp5ScwthcCkir6tYH4l8c5x9YIOQKdGYiYVxJ4qYbPhOlrOuoei
	nd8tVlYnh7FGO9YgIj/tYm/jZEOGKwEmu9l7Hix+2JyTv2/PbI4pUoJ4+8U0vayi1ncsiN43s+6
	BdHAgSJAN6o5Ukwim7LPw19mpJ6SwkkKv6BvumK0eiCBqjshDGdGqCXKN4aKYmqrQD/pWKdLdcb
	jWeRR/NH4eC4db+C4BmUntQKnwF5NEiUv6JVuh1oRLugrw+SlyYFnMa5vR4pgTS+P5hPU2NC/w0
	bSYO0pFs5S9MRnX0wZr4Fbi9W/l/zUlFwgGMWs8ylN+fSt5kzLSmT767jqnIooqv5WkuyffeNJR
	fOGg6lzI9j02k1BfaDmUCvzWnprj3WmAmSoCzLYzCkJOd3erMJQWxweDuKVErxzKZnN8BJRxsHx
	srOk4xqi4plPkGcYjrPTo=
X-Google-Smtp-Source: AGHT+IGb/fa1WaHzo7cAnun0Ah7pdwWSpOYpISNRLWZukJJRzWm7hWnHLE4Xc81NGkVkfkP9FNYbHA==
X-Received: by 2002:a17:90b:2dc3:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-34f5f26df41mr2777359a91.6.1767711907045;
        Tue, 06 Jan 2026 07:05:07 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:05:06 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v3 2/3] virtio-net: remove unused delayed refill worker
Date: Tue,  6 Jan 2026 22:04:37 +0700
Message-ID: <20260106150438.7425-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106150438.7425-1-minhquangbui99@gmail.com>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we switched to retry refilling receive buffer in NAPI poll instead
of delayed worker, remove all now unused delayed refill worker code.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 86 ----------------------------------------
 1 file changed, 86 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f986abf0c236..a4dbc958689b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,9 +441,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
 	/* UDP tunnel support */
 	bool tx_tnl;
 
@@ -451,12 +448,6 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -720,20 +711,6 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = true;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
-static void disable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = false;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
 	rtnl_lock();
@@ -2948,42 +2925,6 @@ static void virtnet_napi_disable(struct receive_queue *rq)
 	napi_disable(napi);
 }
 
-static void refill_work(struct work_struct *work)
-{
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, refill.work);
-	bool still_empty;
-	int i;
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
-
-		/*
-		 * When queue API support is added in the future and the call
-		 * below becomes napi_disable_locked, this driver will need to
-		 * be refactored.
-		 *
-		 * One possible solution would be to:
-		 *   - cancel refill_work with cancel_delayed_work (note:
-		 *     non-sync)
-		 *   - cancel refill_work with cancel_delayed_work_sync in
-		 *     virtnet_remove after the netdev is unregistered
-		 *   - wrap all of the work in a lock (perhaps the netdev
-		 *     instance lock)
-		 *   - check netif_running() and return early to avoid a race
-		 */
-		napi_disable(&rq->napi);
-		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_do_enable(rq->vq, &rq->napi);
-
-		/* In theory, this can happen: if we don't get any buffers in
-		 * we will *never* try to fill again.
-		 */
-		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
-	}
-}
-
 static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
 				    struct receive_queue *rq,
 				    int budget,
@@ -3226,8 +3167,6 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Pre-fill rq agressively, to make sure we are ready to
@@ -3252,9 +3191,6 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-
 	for (i--; i >= 0; i--) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
@@ -3448,24 +3384,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 {
 	int i;
 
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		__virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	__virtnet_rx_pause(vi, rq);
 }
 
@@ -3488,7 +3412,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
@@ -3499,7 +3422,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
@@ -3845,10 +3767,6 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
-	/* Make sure NAPI doesn't schedule refill work */
-	disable_delayed_refill(vi);
-	/* Make sure refill_work doesn't re-enable napi! */
-	cancel_delayed_work_sync(&vi->refill);
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -5804,7 +5722,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
@@ -6561,7 +6478,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
-	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -6903,7 +6819,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
-	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7167,7 +7082,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	net_failover_destroy(vi->failover);
 free_vqs:
 	virtio_reset_device(vdev);
-	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:
-- 
2.43.0

