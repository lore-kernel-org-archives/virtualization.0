Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216234BA34
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503630; cv=none; b=sylqZDI43KL4mW4tLn4KeDOtLFUS3h7VaoPiwRPexDjSCipm45VncujkiYaEwMYsjWShoMWywfZDgQLgr+2zs6mV+uenQyG16SdFtOHjvgE9IqNaF36nAe1tbu6EOK0U9ysQLbKZivTBIUv2JtpBQPtgIXgipD0wAmyibCXVXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503630; c=relaxed/simple;
	bh=KiQ0ZThXMAIWhbfHJPrDxjl8hzo1pgPh+udcXeksnfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZp+U+fW0n/TALgyyo09Q56OQtwuuQK3VrPMWybJS7bfBwi59MZimRtfrml8Gh8UTsAcRFcYPnRVOUJazNjYV9YsmVgCywVU/hfjoRNPmJTM1YFMPqsVf+sFGs4AQ5vChW9rzVanYj9eryTXwNVKtstcR/G77z/QShXpDU7ot8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZST+W1Rh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZST+W1Rh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso3664273a91.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503628; x=1767108428; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLWPkTU7zzF478AH6f0FqkR0eLCmJiyjEedfPTiBhIU=;
        b=ZST+W1RhT//4Aw2mug9gFW8j8aXN6iGLJZFApIN4CaXr4sdwopBpTq+umOzGDkYnoz
         6bJJ8OTfGR8hT78T0iOy0VVXldF5eFd1IBmTEttik7nBbXf02YpS7nfljq9cqXepD8js
         xTR8Sko8TBdmyXpHrfj/PnOlbJydgCMGxdxlHRpbsGphGwwemEoM5Zj2qdAojd0r6zov
         2amppzjaL8/nKCKgOu6PWBGuBdAPZeEzzzJ0rJSgelrabr1EJB6B3sMdSBoswyLn8DIK
         5Uyl6OfFXRhBk+K4Vvkr4ERjs/O89V+6ieXmvWW0FC3SgxFcffxUzr/vLOZ9vGGLETsx
         84sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503628; x=1767108428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLWPkTU7zzF478AH6f0FqkR0eLCmJiyjEedfPTiBhIU=;
        b=lqs0hTp2uWH8hGDUihC7DSalkFMfv8O2Z9fSBwV6JtTX/N5eQjh2LIUAUjUQP8AtmA
         GxVCkqHoRr7p5J2LU9XvCO0U7MSTiSQdKoufWCQq2Vpr9x1MDrIOd7niBg+KyHlBaGe5
         w5sK1LwXBBWhpFEYIIopItypNS07ZKsPzS+6cb7Lr+z0lUVrACAXUI60u+BCj/PYOIbY
         enQpg2QJKl6Y69rgZXKYanrTAslP+qtD28Gp2Y4QYqHvA6nIjDG7BQyP86mYsmXl8Rie
         HxXqtjcQQuuMuQzYeMec68PTdZReEUrmW1AZsQkPl2hkVuZXayczEwSYz3Jxq9rqFR1d
         ZtRA==
X-Forwarded-Encrypted: i=1; AJvYcCXRzF9HOgJSueSKXmuzYyAlIKat5VenCfLon9vea78b9hF3o7csFEZMTG9hxeKjQkRYr+x6XfVLmftYQBnzLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEdvh29mzHOWkP+B7fvV8vVT1RVm9dtjietEz4zFU+u//EvFJy
	aggAtTZP9wq/lHZqIvrpl9LJAS/SLEiD+oR8UPxnN38lRakCoYA6hI0K
X-Gm-Gg: AY/fxX5I1A/DLNzDVfGIcWyYDy9v6u+UdnF1LuwLzMAo+UceVnQG+0eZVbG8Msusleq
	RCVF87KBEjOi5N/mTiNAdor3sSvR5iw4Ko0fPZr8cmStQz4ZRnTywEXhvTXVKzHdIn4L+/iUaJ/
	9VMZuCw8v+HKh4UyJQFQQBlUm1YS49juUdD2iavJhFQj/W9Q2v6gZJYYauG2BYIOlH7yXoTzIYW
	krzrGJuAlZ4HwPipTGUfuWiL/KuO8y5tYls5Uu+bTLyTKYLhH8k7gvheUpOAKDb1ItCRVBCrtVr
	TgPi2qNPcTR9iTKfbOTiCOJFGTY7WI4bLB42FwoA5Fhbu8q4+ajEKvaRgxQrlj2Vg9fDFqXXmcO
	PE7URhFFJXvlOci7SE+TgEEpG10rnU3k51b8EeK+JjbrP0e+8SyqJAU9hDJty+FDOu09i01dh/V
	Wqc7AmEV0GpC1jJkfmzafUsqL1
X-Google-Smtp-Source: AGHT+IEVnhKR3V8FNtZi0Ym6mdYKVy9uIOFKC8GdabAruSwJL2IXyye60twQ8EXVcOpM73gSn0aWcg==
X-Received: by 2002:a17:90a:e18e:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-34e921cc9c6mr13306528a91.29.1766503627601;
        Tue, 23 Dec 2025 07:27:07 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:07 -0800 (PST)
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
Subject: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
Date: Tue, 23 Dec 2025 22:25:31 +0700
Message-ID: <20251223152533.24364-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223152533.24364-1-minhquangbui99@gmail.com>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the refill work is a global delayed work for all the receive
queues. This commit makes the refill work a per receive queue so that we
can manage them separately and avoid further mistakes. It also helps the
successfully refilled queue avoid the napi_disable in the global delayed
refill work like before.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 155 ++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 83 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..63126e490bda 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -379,6 +379,15 @@ struct receive_queue {
 	struct xdp_rxq_info xsk_rxq_info;
 
 	struct xdp_buff **xsk_buffs;
+
+	/* Is delayed refill enabled? */
+	bool refill_enabled;
+
+	/* The lock to synchronize the access to refill_enabled */
+	spinlock_t refill_lock;
+
+	/* Work struct for delayed refilling if we run low on memory. */
+	struct delayed_work refill;
 };
 
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
@@ -441,9 +450,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
 	/* UDP tunnel support */
 	bool tx_tnl;
 
@@ -451,12 +457,6 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -720,18 +720,18 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct virtnet_info *vi)
+static void enable_delayed_refill(struct receive_queue *rq)
 {
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = true;
-	spin_unlock_bh(&vi->refill_lock);
+	spin_lock_bh(&rq->refill_lock);
+	rq->refill_enabled = true;
+	spin_unlock_bh(&rq->refill_lock);
 }
 
-static void disable_delayed_refill(struct virtnet_info *vi)
+static void disable_delayed_refill(struct receive_queue *rq)
 {
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = false;
-	spin_unlock_bh(&vi->refill_lock);
+	spin_lock_bh(&rq->refill_lock);
+	rq->refill_enabled = false;
+	spin_unlock_bh(&rq->refill_lock);
 }
 
 static void enable_rx_mode_work(struct virtnet_info *vi)
@@ -2950,38 +2950,19 @@ static void virtnet_napi_disable(struct receive_queue *rq)
 
 static void refill_work(struct work_struct *work)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, refill.work);
+	struct receive_queue *rq =
+		container_of(work, struct receive_queue, refill.work);
 	bool still_empty;
-	int i;
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
 
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
+	napi_disable(&rq->napi);
+	still_empty = !try_fill_recv(rq->vq->vdev->priv, rq, GFP_KERNEL);
+	virtnet_napi_do_enable(rq->vq, &rq->napi);
 
-		/* In theory, this can happen: if we don't get any buffers in
-		 * we will *never* try to fill again.
-		 */
-		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
-	}
+	/* In theory, this can happen: if we don't get any buffers in
+	 * we will *never* try to fill again.
+	 */
+	if (still_empty)
+		schedule_delayed_work(&rq->refill, HZ / 2);
 }
 
 static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
@@ -3048,10 +3029,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
 		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
+			spin_lock(&rq->refill_lock);
+			if (rq->refill_enabled)
+				schedule_delayed_work(&rq->refill, 0);
+			spin_unlock(&rq->refill_lock);
 		}
 	}
 
@@ -3226,13 +3207,13 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
+		if (i < vi->curr_queue_pairs) {
+			enable_delayed_refill(&vi->rq[i]);
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+		}
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3251,10 +3232,9 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-
 	for (i--; i >= 0; i--) {
+		disable_delayed_refill(&vi->rq[i]);
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
@@ -3447,14 +3427,15 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 {
 	int i;
 
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-	for (i = 0; i < vi->max_queue_pairs; i++)
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		/*
+		 * Make sure refill_work does not run concurrently to
+		 * avoid napi_disable race which leads to deadlock.
+		 */
+		disable_delayed_refill(&vi->rq[i]);
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		__virtnet_rx_pause(vi, &vi->rq[i]);
+	}
 }
 
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
@@ -3463,8 +3444,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	 * Make sure refill_work does not run concurrently to
 	 * avoid napi_disable race which leads to deadlock.
 	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
+	disable_delayed_refill(rq);
+	cancel_delayed_work_sync(&rq->refill);
 	__virtnet_rx_pause(vi, rq);
 }
 
@@ -3481,25 +3462,26 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 		virtnet_napi_enable(rq);
 
 	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
+		schedule_delayed_work(&rq->refill, 0);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
+		if (i < vi->curr_queue_pairs) {
+			enable_delayed_refill(&vi->rq[i]);
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
+		} else {
 			__virtnet_rx_resume(vi, &vi->rq[i], false);
+		}
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
+	enable_delayed_refill(rq);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
@@ -3830,10 +3812,16 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		int i;
+
+		for (i = 0; i < vi->curr_queue_pairs; i++) {
+			spin_lock_bh(&vi->rq[i].refill_lock);
+			if (vi->rq[i].refill_enabled)
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+			spin_unlock_bh(&vi->rq[i].refill_lock);
+		}
+	}
 
 	return 0;
 }
@@ -3843,10 +3831,6 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
-	/* Make sure NAPI doesn't schedule refill work */
-	disable_delayed_refill(vi);
-	/* Make sure refill_work doesn't re-enable napi! */
-	cancel_delayed_work_sync(&vi->refill);
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -3857,6 +3841,10 @@ static int virtnet_close(struct net_device *dev)
 	cancel_work_sync(&vi->config_work);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		/* Make sure NAPI doesn't schedule refill work */
+		disable_delayed_refill(&vi->rq[i]);
+		/* Make sure refill_work doesn't re-enable napi! */
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
@@ -5802,7 +5790,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
@@ -6559,8 +6546,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
-	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		INIT_DELAYED_WORK(&vi->rq[i].refill, refill_work);
+		spin_lock_init(&vi->rq[i].refill_lock);
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
 				      i);
@@ -6901,7 +6889,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
-	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7165,7 +7152,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	net_failover_destroy(vi->failover);
 free_vqs:
 	virtio_reset_device(vdev);
-	cancel_delayed_work_sync(&vi->refill);
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		cancel_delayed_work_sync(&vi->rq[i].refill);
+
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:
-- 
2.43.0

