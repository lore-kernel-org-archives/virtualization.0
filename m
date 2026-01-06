Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998633375C3
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711906; cv=none; b=crhQFtFphrVAj6JMFSwnE5wZ8pBbMnHPZbjPQBzk5cyYpksfBCVo024+iqm72w0Aq5ZB5698R7dmj34TKsFgUIHTUp25FXMtcYYvadAfXV2u4HV/035rvFqVr1NbPtvqc8fGwsiAcDsdPFHiLDurAmlrLBrXG73Rwu7GYwtLDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711906; c=relaxed/simple;
	bh=xszaQ3qzOot1odzGyBA0Zkfa9b0Ivks3e8yQFqhs2jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX+PTwtHBgN5+tKDIyN+cOffmn9/stJAycH/yof+Q5kb6IGf1ASg4P5st7N/poAGbSyvMllzdA4kFF2Udi1Pqaem4O40wv4f7sOqt6V6tzFJ+mBTRf6tbwQhF/cGwsYPOGA5gF31KfFM0InyDWXoeRVuZbeXm+5+C6yHc9AIhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnErZBuX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnErZBuX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so915941b3a.3
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711901; x=1768316701; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCgDdsFcTcXxf+qbWNQRt/nwxivkvn3dRLkqvh820N0=;
        b=VnErZBuXe31nzadIR3AZUidQ8Ftsj2731e7U5BlLcGHQMHfEwaXm5f0ek3kxXxK1SL
         dA6EHKLL9svVvdw/tF7KmEK36KVWTuQWHUZGw+cOxj2HwFxq3LUHKGQDxE0G81hUxwm5
         ieezl8VpImXug0j+sQTYAUE4mte58P48d2EEybBc7C5EHyC+N7Eyum/8x7shn12bOvWT
         7ym10XSvErZGawfksT7VUDhJ3DXe8ndWmRiAzlp59GXbc1N3I2WV68to3LJgdZsfhqTt
         19t7yN8Y6D+9wzoJx4lkred3NbbWs5F8vGz04H0TlWbJq0mx0PqFlkehfyRumNsAyjca
         BWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711901; x=1768316701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCgDdsFcTcXxf+qbWNQRt/nwxivkvn3dRLkqvh820N0=;
        b=uMfJgXhkE4zs3Qddv7+kpP2IHaAwpWkx/ARUrcTy6d1BfaDr7u9PiQowfUEn1je/jI
         u0iFR3kyYiynv6HUY/lbkJfoYWxU/bwsgSrjHbUR7se+ykcLV9mPDyMdf7UwjAJX2igZ
         aVSO6wwHnk9JQeMlXrx/YF1sRwHA9SgpbBFlBjWL+/KjgxXat/yEsphiVJKRezRNAUk9
         drhjaxIafp7ZaW4ub02tGxsh6K/CY+yLsfFIfbIPUWHWmUtIHCQHeXq5Q+W+cOQgc3rI
         7rcpgbBf8qWlh+6fcmhobYdT4dEloSCXcXiMit6XhwyP2xRWAUwS2qsTljsiUkuEcrsr
         nQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ePrQhLXFIUvjNn0DZE3euKXsSnw9JPTsNWsHzk74mOyi6SC4NHkwV+5J5wsjMCFqqju0TfAhrvtj/9O7mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXVsXPXYidkM3Jg6JJWKYnhIgTpbPgijd826LOQoC30xCZlxaU
	pZeAhMY/tOnZ8Rnx7IK8II+iH8pNNV3O81iYdYeD/3FozdyUi5UDPI7n
X-Gm-Gg: AY/fxX4bhWkpeeU1hq6jU1bt2MNOstg5b0ZzQ6CKYIaDZvvOl2fStOhBfIztVzgzlrR
	T1VtFQM+4KA+zuSYYGkwWFHwEzwvngh1SFYyy9RcGbTX8ER8/eirzo9HAjW1qp10DDNKUgrprTj
	F0OGXwFCcjnsg/BEmzvhaLbFLHsAPJDVMM8yzVhmLib2tBfjqReGZRmvqpj+gAL/1b2Ol5Hx2Z5
	5IdOXcysSWwB+HII6+MmGYnip29L8mSo3rWUXqHzCP4wt8jhkNYwKUqSFaOVVAfQXr0xLt5feSp
	MGQeNflT1p6DlNeTpmHkpXI6Vqe2yBsf9UhWw0YXzTrwlB7hDr417RcZm8GHqrV57BME95BPXGr
	aswT0yb6WUtilNiBcwjLA5j+/5qfRxlMSUYdu3M7g/XK1nJgOHQbz23u4xVBCHYK0fPhraK3h1K
	UIX+YAxzML6BY7ZxvLkd0=
X-Google-Smtp-Source: AGHT+IHDogIdZKcYrYsV8f80P4yM3C43vbE23Xgd+qTKk7rTQsoMMRcLT36sPlF6l2euTU7zw8ZVRA==
X-Received: by 2002:a05:6a20:244a:b0:34f:2070:89d5 with SMTP id adf61e73a8af0-389822449d3mr2785149637.11.1767711901107;
        Tue, 06 Jan 2026 07:05:01 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:05:00 -0800 (PST)
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
Subject: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill worker
Date: Tue,  6 Jan 2026 22:04:36 +0700
Message-ID: <20260106150438.7425-2-minhquangbui99@gmail.com>
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

When we fail to refill the receive buffers, we schedule a delayed worker
to retry later. However, this worker creates some concurrency issues.
For example, when the worker runs concurrently with virtnet_xdp_set,
both need to temporarily disable queue's NAPI before enabling again.
Without proper synchronization, a deadlock can happen when
napi_disable() is called on an already disabled NAPI. That
napi_disable() call will be stuck and so will the subsequent
napi_enable() call.

To simplify the logic and avoid further problems, we will instead retry
refilling in the next NAPI poll.

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Cc: stable@vger.kernel.org
Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..f986abf0c236 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	else
 		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
 
+	u64_stats_set(&stats.packets, packets);
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
-		}
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+			/* We need to retry refilling in the next NAPI poll so
+			 * we must return budget to make sure the NAPI is
+			 * repolled.
+			 */
+			packets = budget;
 	}
 
-	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
 	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
@@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+			/* Pre-fill rq agressively, to make sure we are ready to
+			 * get packets immediately.
+			 */
+			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 				struct receive_queue *rq,
 				bool refill)
 {
-	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
+	if (netif_running(vi->dev)) {
+		/* Pre-fill rq agressively, to make sure we are ready to get
+		 * packets immediately.
+		 */
+		if (refill)
+			try_fill_recv(vi, rq, GFP_KERNEL);
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
 		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	}
 succ:
 	vi->curr_queue_pairs = queue_pairs;
-	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		local_bh_disable();
+		for (int i = 0; i < vi->curr_queue_pairs; ++i)
+			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
+
+		local_bh_enable();
+	}
 
 	return 0;
 }
-- 
2.43.0

