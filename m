Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE130FC1D
	for <virtualization@lists.linux.dev>; Fri, 12 Dec 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553279; cv=none; b=f2T7U/JMxzmHANJK+m9M6ZvP0sLTY5yILAUqplHIvUf/RP0jViGAgvEs4En7uCUvfPUy/VLiH1HiP3yI5w/RgBif4czBmAaCw5mPKeXIl4Z6oKKiNUH8hvBR8Q7eahnfRoYabbTv+/XkSPr8OroDFtcYWbB6IVsstoi1c3XILg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553279; c=relaxed/simple;
	bh=i+qr47P2eCDHTXJAVkjOdS7xg57iGJ43qDshBEK6miY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGfM7hbHiOrXtpG9mxei/U/mzAXxTAQSmt3Jd+USobRhOG7xyxwH7vXnYgS8pqwO6xmCHtiVUnovbuKweLDUeZzevPWemtYRTNpPbBSxv/6vdhY5sAU1uSos5ovUSpqhmuEKU+mWvmDUoV7m6EIJDpDrHNL7Ka1c/N08ttpS5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/A8myA7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/A8myA7"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso293350a91.3
        for <virtualization@lists.linux.dev>; Fri, 12 Dec 2025 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553277; x=1766158077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzENitL8AUZ68RERyt6xp7p+jtCblr0NyYweq7WA0Os=;
        b=b/A8myA7WKfJo37xp65NzYKYZBXDC1UoJL7NH90oVVhGCZ+1wS53qzF3hRuPjlQZ/r
         yf+AmXVfITBxpvBtTwvJn4h+nBroI5iQqkD9uzU4mwPzf9sAajLmBr/SqsvCc1OVMlxj
         LGyyRZNQebjGC3p1A2GUohfcKEONT0G21RZle1ueYedsH9LDod1t7bM890L0CuLlXVe7
         9GhRLxEoec7oHifOg4lU/cXpQjKCGwOKduNoaabaJN2L1IHhzQPJsputHzrl8g1OnB/f
         FdES1iceG5m+J5vK84WL9othM/3pumxlOOKr2voBQydXYIi/VAluXUmIB8taMJQWu+0f
         xdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553277; x=1766158077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzENitL8AUZ68RERyt6xp7p+jtCblr0NyYweq7WA0Os=;
        b=vvssNcW1CzoLQKxL51SWDPH/TnX28xmY8Nd3FkkEFAd0uxUN3fnyl6Qzgw45O5C1Dg
         +W7xvgXNQZo9WHGMTa0WQNhaSE31Xb5ySsdM1xOUw/SfjvcW/b1ZPOutjdg3er7k4jF9
         IsSKAo/heikEmfnVEajYE1PP00KGPk7v97Gahnz7BMo2l7ebBmO1ZY4InsYB2SNQkg/B
         mMBQVowExmCQ8OjIVLyHqp52cPIqwWee1BPQnu1AcXJv1fwyJyI3zh5IbfEQVAydMsKA
         fSo9V0jBE9SBXAbZ6jsdAmkbnijYDD9xnRjKuIQoIFlkRRyNALV8OfFf9KAm8OwPjv+Y
         2dyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD9cNYQMoPs+3Dd/qdMa0UKhj2GGwruhvJCzNBT1zWBxW4Ao7Ujp4EfNnJqP/cYdNQ/byu9tepzPnVX9PRpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlsjbUM6tfEpy9/rOSsaB5oWL9YQKRRb9kKosXuN0t02mYeOaR
	RTc2nZFBA5Z1Vd7Zb9FUCjGb2YQP7WA+1XKqUr3251Ly18USHdgL+1Fr
X-Gm-Gg: AY/fxX5arxJsXurJIPGFrjIe5LM0eSXqgikidU9zfBbSgthGKCcjdoyTDPgpNDK0e3c
	mFSYgi4F/0/woA8TVeC2jXoCBe/6vja9rFWJthDi3MFqPkdoBfoAN/pQxdlOTqt3YxL3aBRXW4+
	H1+wS6AbcnyrP3hjIH2vg3ZHs7eDOjezTgkiRkcjnmHcun4NkLGZrdHcdAO8iU9h3Co+QMidFuB
	dSuSQhpO3nyr4VQAcCWNUumq2+G+z0TAyuT1KBvER6OcVnKQkKVWY05w33lCUlQO8XNXxXC/gQP
	bMap2h3HcD/oTYHqFK+rdMHzdR9eFybK4ES866sxHHJCjU+Yzd8WeTK7zRAyXNGCdke8bEXZzHd
	S0eE8QO60/zvohu5KG2z6lRc9u0IQPP6lIwgMOETFSD0xuLzEG2WmWLvbOKi2/Jul+MYbBWjx5S
	dINCsRTPPLsp2yMeHWk1LjPfIe
X-Google-Smtp-Source: AGHT+IGJkdJ9hixisUeeYL/0HntI53jNSy5a6YB1w0C5X5lbrmy3dicEMz346CEDNpxcNlRXqX/xeA==
X-Received: by 2002:a17:90b:35c9:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-34abd858b3cmr2097689a91.26.1765553277401;
        Fri, 12 Dec 2025 07:27:57 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:5402:1cf7:eb53:9399])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34abe3dea94sm2288511a91.11.2025.12.12.07.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:27:56 -0800 (PST)
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
Subject: [PATCH net v2] virtio-net: enable all napis before scheduling refill work
Date: Fri, 12 Dec 2025 22:27:41 +0700
Message-ID: <20251212152741.11656-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

This fixes the deadlock by ensuring all receive queue's napis are
enabled before we enable the delayed refill work in
virtnet_rx_resume_all() and virtnet_open().

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Move try_fill_recv() before rx napi_enable()
- Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..4e08880a9467 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool schedule_refill = false;
 	int i, err;
 
-	enable_delayed_refill(vi);
-
+	/* - We must call try_fill_recv before enabling napi of the same receive
+	 * queue so that it doesn't race with the call in virtnet_receive.
+	 * - We must enable and schedule delayed refill work only when we have
+	 * enabled all the receive queue's napi. Otherwise, in refill_work, we
+	 * have a deadlock when calling napi_disable on an already disabled
+	 * napi.
+	 */
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+				schedule_refill = true;
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
 	}
 
+	enable_delayed_refill(vi);
+	if (schedule_refill)
+		schedule_delayed_work(&vi->refill, 0);
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
@@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	__virtnet_rx_pause(vi, rq);
 }
 
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
+static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
-	bool running = netif_running(vi->dev);
 	bool schedule_refill = false;
+	int i;
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
-		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
-}
+	if (netif_running(vi->dev)) {
+		/* See the comment in virtnet_open for the ordering rule
+		 * of try_fill_recv, receive queue napi_enable and delayed
+		 * refill enable/schedule.
+		 */
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			if (i < vi->curr_queue_pairs)
+				if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+					schedule_refill = true;
 
-static void virtnet_rx_resume_all(struct virtnet_info *vi)
-{
-	int i;
+			virtnet_napi_enable(&vi->rq[i]);
+		}
 
-	enable_delayed_refill(vi);
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+		enable_delayed_refill(vi);
+		if (schedule_refill)
+			schedule_delayed_work(&vi->refill, 0);
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
-	__virtnet_rx_resume(vi, rq, true);
+	bool schedule_refill = false;
+
+	if (netif_running(vi->dev)) {
+		/* See the comment in virtnet_open for the ordering rule
+		 * of try_fill_recv, receive queue napi_enable and delayed
+		 * refill enable/schedule.
+		 */
+		if (!try_fill_recv(vi, rq, GFP_KERNEL))
+			schedule_refill = true;
+
+		virtnet_napi_enable(rq);
+
+		enable_delayed_refill(vi);
+		if (schedule_refill)
+			schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
-- 
2.43.0

