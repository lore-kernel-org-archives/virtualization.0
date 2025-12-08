Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBC1E832A
	for <virtualization@lists.linux.dev>; Mon,  8 Dec 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208108; cv=none; b=IQ7u8+soJvCnl5BdZyawqTtZQjzIEnj7tVGKbmJfyOrQmCIobSBVDwaRyOzDgVnoEAJyo+KJJUit6MIfBTbgXpgzIONIH5GOOmt5MyPHGDPYZBnpgGBuIwHBwOr1xw4yWv/7SPkq4w0oyjNV4qSKp3OBsHfvNOykFxJD2BnXkBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208108; c=relaxed/simple;
	bh=+dA/FLXdh91Tj4KvXzdrCX9sD7l/ZFnkWVRU35JvuQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCpw/2RlXWpp5pQRa3WL9+vFMm96U7PG0/Aq3keRrLHU7IX8lY2+0kLZjwgUaKYhOgEDCnF6LgDXZFS5cdsnQQBzKvy+DcbsZcgGH3IsCg28IADI5ZlTqSzTIn8RIHZRj0TpRAejUwD8sBXFCMAp314EEAF1ytBbStjLMOhVuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsTo7ED4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsTo7ED4"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aace33b75bso4456307b3a.1
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208106; x=1765812906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWpFolnAyO+/LNdlTubeymU5rZAhEOvt75iUUlk8FxM=;
        b=EsTo7ED40x2c8Lm6Qd76n8a/z48zMx/rtPQvTZM36v9s4h3JuabWVLNgi0qSJhCzxa
         lVNHe57526+OGD1TO4K+B3xsrHs4Ui3NWe8x6JaperARsX8Wn0HYm9+Ps7OfJDEK96an
         gC5sJg4uXums0axWUzschwryCU/dlNb6antx0x/vpa3/YK3S7GhV089PbghPS0NIgJDl
         VgI5Ot37Ubf2SRToOV/EU/slAJUAjs0WS0v9OqnOX8CEjJfOA2Lv+V/Sh9SkBVuzcF5P
         3ljqGZpm/ho0V10dSI7k6N+vVnj4XMxOBwFL4382jLCAyrooHkvR76O4SdRqrdQ60nfs
         HR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208106; x=1765812906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpFolnAyO+/LNdlTubeymU5rZAhEOvt75iUUlk8FxM=;
        b=snsuznX6cI37Rb+iSlx/YBrkwcazQkGH4Wm3tiR+UlD8BI74TmR/nELyEvG6wJJpUS
         JW4ZaqtKVf15w3P1nVW0FJrGIn3wpth/ER5p05p5lBjyFC8kdSPglfLbPgBw8v/o6ZmL
         k/EYVwcU8IvL3qDBiKxP9CZ/dTdBz+bDMflUwLMlzEljtG3Mqum67bkJA3zNFGsiioFQ
         HU8TYNjIXEBMZvaUzLhlf3PSbCR6f8WAz781jfmtNR5jntUnBIYLgO8/SZvtzGhx5nY/
         ldevqRNuQM58ZirUbaZ6rHsjzOYyvSi+IEK2Bn4xjy2VRNxLZ2QSKechF0A5Dbo3A0HF
         zLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQHS04kkbLb79UR6lH6lcZMCOayPMwTGxKI6jADoGZs0AOnF/CEGoK+Yma7ptdqrZ6E8zOLj4SvV3nCylHgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YygPgJ71xAURd9jDX4HpngWIfreTyIR6su2Etau5nsXXDEfxOGE
	f326/ezbumHxrZI+muwxi8jU9LGEA5oxhCMF+vlBelR+Uu2nFbvKsr7H
X-Gm-Gg: ASbGncuui50CL8evkk0nqTPU1gVoLau6Qxdl2t9c5zDC1pMGIsQLjeb2tQ/zcHXQcRw
	tUYWBP3f3ZX1fDKCZTYnhEwCvnk+/n78mJLXsQcOujLNtICq7WTywTeFqaCr9Lscakk2LNy/gTn
	YPjj0x3/sPtDiwicZoJT5rkcjURvx1Ic607OZGFORRFEK+h50MnaAAwYS+DanYA7w8ANNvwgVW7
	gZIr4mbzrIhXJ5W+oMwCwH5NqrGb8V+hvz9rjFVzQ8fim5hRexzJUL01BGMz1oKG9WzXHZ/pgge
	OJ2yU5l8QH/uK3HOXBCKypI9R5kNJG1Uuay+ynwPaaLVGZk1XLPerE36pJ8DW9noTmwRS2OH2nD
	8lFLQOxugMYrUfpxylnrQbjvOoBdGVKy0cMXoxwqvz9sA8o66jJ2gcbJ+hbG/kmJPBmkujhU5B5
	8T5VrnKmj4iooCtwmigpHqK80U
X-Google-Smtp-Source: AGHT+IHbKnsyQgrUfLKGFjvZ3WkKGG8QW0enhqd/Ng7kJy9ybz2AnhuklB93e/amB8t20kVBAd65NA==
X-Received: by 2002:a05:6a20:914c:b0:366:14ac:e1e4 with SMTP id adf61e73a8af0-3661814c501mr7552324637.74.1765208106236;
        Mon, 08 Dec 2025 07:35:06 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:2998:e0cd:90d5:9648])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bf6a14f40f5sm13106127a12.21.2025.12.08.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:35:00 -0800 (PST)
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
Subject: [PATCH net] virtio-net: enable all napis before scheduling refill work
Date: Mon,  8 Dec 2025 22:34:19 +0700
Message-ID: <20251208153419.18196-1-minhquangbui99@gmail.com>
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
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..f2b1ea65767d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return err != -ENOMEM;
 }
 
+static void virtnet_rx_refill_all(struct virtnet_info *vi)
+{
+	bool schedule_refill = false;
+	int i;
+
+	enable_delayed_refill(vi);
+	for (i = 0; i < vi->curr_queue_pairs; i++)
+		if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+			schedule_refill = true;
+
+	if (schedule_refill)
+		schedule_delayed_work(&vi->refill, 0);
+}
+
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
@@ -3216,19 +3230,14 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
-
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
 	}
 
+	virtnet_rx_refill_all(vi);
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
@@ -3463,39 +3472,27 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	__virtnet_rx_pause(vi, rq);
 }
 
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
-{
-	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
-
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
-		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
-}
-
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+	if (netif_running(vi->dev)) {
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			virtnet_napi_enable(&vi->rq[i]);
+
+		virtnet_rx_refill_all(vi);
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
-	__virtnet_rx_resume(vi, rq, true);
+	if (netif_running(vi->dev)) {
+		virtnet_napi_enable(rq);
+
+		enable_delayed_refill(vi);
+		if (!try_fill_recv(vi, rq, GFP_KERNEL))
+			schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
-- 
2.43.0

