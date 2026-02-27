Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF140B6DD
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205223; cv=none; b=ggX8AZVToGFXFHj5FojCht/oSPUzLPboPj9f3WHQJdxRH8CdJD4bkyvLWeM0JzXfqUWuLpzW0FXW5hjsLidYCz38zI1x6YRMY/0jiIxB1rSbJ+GjyVc3UE4EnAYnO9NRiT1uBu+arMbrZED+NxbZE0WK5tLBU76fRw61rIh8W6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205223; c=relaxed/simple;
	bh=+pvLKOyDJeDYk8Ks51ufw2eQlUL8GJXsRvfZQAUcAhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0HRrp1Mj7b968Cnr4Gt9xRJ89iRjagDqXscZ0FUUZF+ZNvH2CLFD7q0tqKV/3wOSAhGPVRgvY5vTeE6AeJpSMAEz0buumlWIvKCPXY+z7Y0ORdnf/aLkI8dwRkQ+IJ8GO6aT30BEc+lyiqevXYPjGV5JKe6l+hFwLflEnqYYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTfj1t+s; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTfj1t+s"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-827270d50d4so2261261b3a.3
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772205222; x=1772810022; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wORT1SbE27ZIkrMMuUayvBmlw/YCk/ngCJoGzWhKHPo=;
        b=hTfj1t+sCBpRwDana4reRrkl/WKxAWl2crtITAbhVhBPFfb61rKafXezwuS7/5wPXx
         ywYJOVknxQ5LW5gJ5y7jkgqqijQM68BHi32KS4SOShuiIg+b2H5HH8t8pCBHZwD7PY8V
         DgLkPb4h35ZgUbejgQm/KTaOCBn3H3tViUC5gLcBxNcF5NW57f34iZ6/7gNSSM4zCfwc
         56G4BmO4HkNLy5lHHOccAa2NF+cmxmtFpqBpMWreckqS3sNlqZqV/NUVhe7pR5rklQnw
         ddg/PjLRh40h1gMqInCTTQ6cKj7S7nbyvZtPnVE4laAguSm6IiYCIGTj8Gm2awpWCz3z
         kiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772205222; x=1772810022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wORT1SbE27ZIkrMMuUayvBmlw/YCk/ngCJoGzWhKHPo=;
        b=PzkvPczrLx5lzJ+fV0uUUPlH13lt3TR9kTBGjpf/yJ0LhC5MN1/cU9xIp7x/WvZTuf
         oULyyi5Jj86PeYL4QF7WK8L4Se6nwOFJVuydC6xNSakR13ajKzxgBi2LTpsQA9W6F8XQ
         f5diZ4SC/YCs8uuSHujGUPnHfDpRvuAZ1GYZOOiDNDGgU/l/5ZawKuJfQ9XZT0qLbqf4
         Hno7PrncvUWpefrH44WoFaMMRlm4YjVNoljvkZUyX8zhkl+t/S4R6tUaoDiWO4r25nVA
         mopu1F5pfpUJKvZsn+/9E0pi7zQUlrRbI0O9/J3Tk5Jcre2ib091eJrsOWUCAfJlAsL2
         tUhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp5vuoaNWOHcfvtrAdKlhvV5qjmqVzAoqXI+vAkF5NZQjBK0ZYxosPb3lMvWq6jWtaBr1UjpkG75rQ2zZomg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrGPu5DcVScIzuJx3q9lk2p30GB+Vnlc4FkJjtkR8ul5oYI1tF
	czGKeC6ot9blzor7c9zv8x8/zLz69ylJ73agZBu7xyH4e3ielZyPBwuK
X-Gm-Gg: ATEYQzxlC2Xg2YO3PdSNWdHqyMfv/XBWlvykAWBRdCCrdgxM8lrlAA4aE4j3SXicDgN
	1qnX0va02RbedxYjVsSyzYYk5mIEJJOvIc3boSf29Phdvn6C1qbfIVt9fMB0Z1kGOhnm6ybwt8c
	6whc8hvZyd2xjenOb0OSQmxTgBDe3FFmcnWjLlKkT8DDN/Qz+n9yvBVA4dvCzNN32ZBIqDBG011
	PVd17rqWMiiuSICEUo7oWI4qfFcSV1eiZQF26M86sZ/Yfbbgi2vi+PylEsjBZxYYK93SqOenqAg
	Q9luHEZfJgOOfzycuPTB83fpTf53JJB+RM6re3IWpVy999i0X+Z2hhK7rckiNvPvvmmZuDpgWPi
	svt84M+ngTaf8ewu+4V5E25oUxwgq5Ehpd8aLmqMiLfAPyrvb4FDsfebIZ5D3PAnLav/UqjE9yO
	E1JvT8EXtTA1SpxPmfM2LKXAmCsf2Tq3w3RAsdZEql5sSgk4PsCA==
X-Received: by 2002:a05:6a20:d809:b0:38e:9acd:97d0 with SMTP id adf61e73a8af0-395c3ae8562mr3787342637.34.1772205221514;
        Fri, 27 Feb 2026 07:13:41 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f0f:b1d0:1fac:b09d:ba7c:fa17])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c70fa638dbcsm5034868a12.14.2026.02.27.07.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:13:41 -0800 (PST)
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
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net-next] virtio-net: xsk: Support wakeup on RX side
Date: Fri, 27 Feb 2026 22:09:49 +0700
Message-ID: <20260227150949.13089-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
is allocated on RX side, allow RX NAPI to be descheduled. This avoids
wasting CPU cycles on polling. Users will be notified and they need to
make a wakeup call after refilling the ring.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..494acc904b2c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 	xsk_buffs = rq->xsk_buffs;
 
 	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
-	if (!num)
+	if (!num) {
+		if (xsk_uses_need_wakeup(pool)) {
+			xsk_set_rx_need_wakeup(pool);
+			/* Return 0 instead of -ENOMEM so that NAPI is
+			 * descheduled.
+			 */
+			return 0;
+		}
+
 		return -ENOMEM;
+	} else {
+		xsk_clear_rx_need_wakeup(pool);
+	}
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
 
@@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return sent;
 }
 
-static void xsk_wakeup(struct send_queue *sq)
+static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
 {
-	if (napi_if_scheduled_mark_missed(&sq->napi))
+	if (napi_if_scheduled_mark_missed(napi))
 		return;
 
 	local_bh_disable();
-	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	virtqueue_napi_schedule(napi, vq);
 	local_bh_enable();
 }
 
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct send_queue *sq;
+	struct napi_struct *napi;
+	struct virtqueue *vq;
 
 	if (!netif_running(dev))
 		return -ENETDOWN;
@@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	if (qid >= vi->curr_queue_pairs)
 		return -EINVAL;
 
-	sq = &vi->sq[qid];
+	if (flag == XDP_WAKEUP_TX) {
+		struct send_queue *sq = &vi->sq[qid];
+
+		napi = &sq->napi;
+		vq = sq->vq;
+	} else {
+		struct receive_queue *rq = &vi->rq[qid];
+
+		napi = &rq->napi;
+		vq = rq->vq;
+	}
 
-	xsk_wakeup(sq);
+	xsk_wakeup(napi, vq);
 	return 0;
 }
 
@@ -1623,7 +1645,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
 	 * wakeup the tx napi to consume the xsk tx queue, because the tx
 	 * interrupt may not be triggered.
 	 */
-	xsk_wakeup(sq);
+	xsk_wakeup(&sq->napi, sq->vq);
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
-- 
2.43.0

