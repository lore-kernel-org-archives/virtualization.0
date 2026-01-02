Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4130261393
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367250; cv=none; b=d3Ym53qjBaJZvhYPXUwyBgYQRUx6uH4BOkc6CmVlXLcHKrWGXbUPwNhuYKx1hImmmskDxP/wba5/vUTpdGiB8iW10zuQBkmYrN/cIGh3z30mGqWE1PpYxyOFuAteYskRd85vz0ZNP8KahPIeH0pWMtnWC3kEpCwXQ8iD0wrDg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367250; c=relaxed/simple;
	bh=AVmbCTua2itYQSdqi67Rg2DvQJpSs9Fw5lo+ym0KgKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkNprmWRDbs1LWoDrtvmFhBYYvTB9eZZ9XYbpwfwZdVr9q3J9WlaBBEYrzX++XX6JeeuQxch0Z2kdSLVzXmVYKeOyJEEjUSAAvEFIJ1E8A4hFRWm49TyBWsfLBKun+CQStg9MQW0v5NjITUJU2A5KxQZG+oX0p6o3ErJ2D0jKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoFqa12Z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoFqa12Z"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso9694814b3a.0
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367248; x=1767972048; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viiMT0mJ8A1eQE5ko81RyEvaps1qhf8umuQOghYhhoM=;
        b=SoFqa12ZbgTB5FNDNr04oFFpobzJ6zj7rKxDr/GPLCybmLk4xKcRjTvk2DjlG0SZBD
         Ttg9ty1b2D3aSkRLeGH3ktxRcmWjBBkoHJH/JFMunGBI38eLmf4srqGMb23JYzWNl27u
         3R0pNNIIqrQPBV19DE0xntkRk74OY8UNNzvEIIqgpxSQRgvFm80kvmD+pVJi2egt24hv
         g2X0kTsQNh7OjnOhiWX5BHiYuOG+0txdITI4j/zG0a1rt8kjk07I5vrkj6fBGxrQfg/N
         Nb7vSmnIWMPmbDvgu2CgCBzWZjSL9DlaLnKLzZSzUly9UfLkxjDASgR8P9qzf7/PAPpu
         DChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367248; x=1767972048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viiMT0mJ8A1eQE5ko81RyEvaps1qhf8umuQOghYhhoM=;
        b=efXyEiyj+QUA4qJpiC40Rx/lQwhrTGE7dt9RDQ+KUf9xUBJpvUY25WAWxEPsRFYMUU
         lxUvJbzu0LhK14B0Gd+LWHgc6Js1+4BtQMrGDIt71D6wKw41oIWEz99bk3++9h44BSzd
         JWvo6D2WhjS03f5lm+F9W4cDTRG+A7zcE9N9UOHiN8N1JV8bWXXNcBg23H4m1mQUCkzE
         petLYd5Po41z+kt1Ku6NWZLB4lOqEoffs31JH+Y6/SBOesoXF1984xItzQ/f5//IUGrz
         fZFL4eL8gFMdG2NPCe9VbS/92AYWPQXH3fiyX3SpQks1YEcLkRZrowPa8O0KsAr+6x9q
         /yOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkm2mTFDuVGtq/SaR6Ao8C9H5iCFW7E9zfnHU8EXXlUjxa/7Yju/NeZi1yW+4PBzaZP9Uoj4f5HHm7nCrOxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzow5MVgU5U2TJNT/nR9BcxZz50GnUOCPxJPRbwLr/M4PTRCfMD
	U1bn6QBt3mbXyllRswwdbq3nlSCxCaXLb74PQVi5p26H9a1BIL8s2mM7
X-Gm-Gg: AY/fxX4PijnSdIBaV29wCu5IwKKLO71pRDQ8seTGmuUBUNhx1pdW6hjiovpplVdIjXP
	hiFYwhuEHe2Qv7Z1ewwcwqn11GavNFqpC/vlD/KiX2t+8LaMMWbJQjBQV3JEQHbrkibGX9m4h1V
	VF5C5PldrwX9zzBCvXLprNNV+4QEZLxJt8L46LBpNTs7ZAjnD83hpiKsWN6pTawGo9jzY94BTgR
	d9xkH25Y/1wLLufQlAOiOlOlMtoPK3h0KB+CVFcg9tsml59MJtcODm5JDFSONW6VytyR1ZPvtUd
	Rom6t8xkslU1vxC/1qS5ttsXBacO28vyUSjBBKfPnHowaVu4bxke3GobxfOwEi8D5Oaet0ub++N
	s4oZU7WDnI0qJdCT/DQz1JawyCrn7c8b1i9ftgjwGvtBTl+Q0b5adcls8CIRbdksAEaQ3d5C6K/
	jntAxG4PjiNgsOkJR6XVjilqEEq7XYjUUbtw==
X-Google-Smtp-Source: AGHT+IGW/oGz/NZjf+BGO8R4q9EUzB2Mdtq7Z2nuodi9vs6ehE50GZWiOZQO50TBdIV5gsvGFMRUSA==
X-Received: by 2002:a05:6a21:99a4:b0:342:9cb7:649d with SMTP id adf61e73a8af0-376a7cec847mr41356285637.26.1767367248120;
        Fri, 02 Jan 2026 07:20:48 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:47 -0800 (PST)
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
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill worker
Date: Fri,  2 Jan 2026 22:20:21 +0700
Message-ID: <20260102152023.10773-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we fail to refill the receive buffers, we schedule a delayed worker
to retry later. However, this worker creates some concurrency issues
such as races and deadlocks. To simplify the logic and avoid further
problems, we will instead retry refilling in the next NAPI poll.

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Cc: stable@vger.kernel.org
Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..ac514c9383ae 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 }
 
 static int virtnet_receive(struct receive_queue *rq, int budget,
-			   unsigned int *xdp_xmit)
+			   unsigned int *xdp_xmit, bool *retry_refill)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rq_stats stats = {};
@@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
-		}
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+			*retry_refill = true;
 	}
 
 	u64_stats_set(&stats.packets, packets);
@@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	struct send_queue *sq;
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
-	bool napi_complete;
+	bool napi_complete, retry_refill = false;
 
 	virtnet_poll_cleantx(rq, budget);
 
-	received = virtnet_receive(rq, budget, &xdp_xmit);
+	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
 	rq->packets_in_napi += received;
 
 	if (xdp_xmit & VIRTIO_XDP_REDIR)
 		xdp_do_flush();
 
 	/* Out of packets? */
-	if (received < budget) {
+	if (received < budget && !retry_refill) {
 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
 		/* Intentionally not taking dim_lock here. This may result in a
 		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
@@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 		virtnet_xdp_put_sq(vi, sq);
 	}
 
-	return received;
+	return retry_refill ? budget : received;
 }
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
@@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+			/* If this fails, we will retry later in
+			 * NAPI poll, which is scheduled in the below
+			 * virtnet_enable_queue_pair
+			 */
+			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 				bool refill)
 {
 	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
+	if (refill)
+		/* If this fails, we will retry later in NAPI poll, which is
+		 * scheduled in the below virtnet_napi_enable
+		 */
+		try_fill_recv(vi, rq, GFP_KERNEL);
+
 	if (running)
 		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	struct virtio_net_rss_config_trailer old_rss_trailer;
 	struct net_device *dev = vi->dev;
 	struct scatterlist sg;
+	int i;
 
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
@@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	}
 succ:
 	vi->curr_queue_pairs = queue_pairs;
-	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		/* Let the NAPI poll refill the receive buffer for us. We can't
+		 * safely call try_fill_recv() here because the NAPI might be
+		 * enabled already.
+		 */
+		local_bh_disable();
+		for (i = 0; i < vi->curr_queue_pairs; i++)
+			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
+
+		local_bh_enable();
+	}
 
 	return 0;
 }
-- 
2.43.0

