Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FB214812
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639031; cv=none; b=BznLQqDQBsaNLFZLJ2ttHvFETVFUWocWhXp3UDzTW98C3WAfFQtNPbGq7BdtDcw5ju35e2TTysfoETEU/hQOvFkC+1oSkEVd4piVfVd36VXDuTNiE+6vfMnI6G4oCz1E3bfHjcCEMls0AJgSO9DmjOeP8EPgRxe6gDTHJ4+HTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639031; c=relaxed/simple;
	bh=qlxhEf7og7XY0BAdORZmSlDcPIyHYlLNMY9NqLmZ/ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RH9akJxULyfUmm/dbF/CGozzyJvyBdmDhAmTBZap3igPm2n3x+EBpndf2/Hxr/MGVSXgDJqzU7zamIjPeFanrqWmEfNkcmNfSWY3/T8LCgo+/i4tLESSwfIawawtrJ6iQyFJQdDIVUE3IDCyJarFh+QiMmtb003C278D3Pstfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4pm8Ved; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4pm8Ved"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso3263261a91.3
        for <virtualization@lists.linux.dev>; Wed, 04 Mar 2026 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639030; x=1773243830; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo7Dt9cz18bSdlnkGrgHpe/DU8igK0QAeFj626A+mxo=;
        b=X4pm8VedK6UsXBv+N+TOTMjsV1SaSnjOhGt+xyE9lFb3HhGNu2B+B02gc/uz1sc/HY
         SOUQTVyPKPK4AVAM1QG3ntuHmV4C+dTP3eri/+XxR051WZvPeDKUHcXrM47bDoxU4vV+
         kdmYdhoOU5F3+hQSL+/1sg/dPh9DYBbYxbcue0+3cBxLAaE24XvTXYIQzTss8H6nhXoV
         ntqY5TfnxcZKjnLsZNX2nVv+UluIxZcKJ+1HploIed3x7snLgXrqzuWcN7JBBmHdSy8V
         uGkHGBHRN+aQAMNgV0moc187sY6Y9gMUIkWkvEtaJ/4mysi6p9DoqEdqqiiRoOnCHkqw
         rmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639030; x=1773243830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo7Dt9cz18bSdlnkGrgHpe/DU8igK0QAeFj626A+mxo=;
        b=N7wDrF/00fWhx/DSi3gpCqmczMJitcfaGfxPPZ+4yGfO6vS6NDG1vDnEGoNJOUOpNI
         SkqVATa3HztDSPLW3IRViL+ylcq+04+ICs338VGS+HfETyTVv0Y/sViMzgFXP7mtoi7w
         yUx/qJNWN0Q1kIpBTaR+huDyLxY1yY+Yb177NpFUTE22IDQwb3H6nnjSPl7TVrHOiLHA
         SyrJAZOLJAV3/0Ry2qjX74sQZaJjWzaWWgUrsvNKu+Covvc4hHEIxc3E20TWJzCN3CQJ
         PQVzWBjk3jHX9nmUhDigleDyhvYmTL/VpQp9NIcOksoEyVGiSzsO6TsyZ6DAmV4kAZIZ
         KkUw==
X-Forwarded-Encrypted: i=1; AJvYcCUaqwmxzDaXexHKyxCGwxdUUkP/a1lAYazgfxuR3oB0bXbQ1vp+Kt1hHEV9aThMB/ocJap13cuuCV1IcBvGjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQl1B44d8bSiOMfZLgyKfKoPCP5Ooe7ZLA0kh1HLDXjZ1p8llK
	vPmPnq8sNTBlzx7neFvxRxUvZ2AqzVXFWGxnAfYY1klEp4JM9EpZdQi3
X-Gm-Gg: ATEYQzw9Wpsomf+8z0UV/yFvIws7ekOb8vXonSE4lj+S1VvvYQXHwq4TYGiVZpLWpS6
	L1VoYPHHdn5nh4MxlsP2Df6dkFt7Hte/PbPETSKJQBTgh+fnJ96QfncbhFLLqyAcbE0QxXMK0Rq
	pejUtZjwqOEwZ+JDrjY5Wmv4jte6QBApeUllBXglyIyoqAT4/MEhWo8qKbadrSUMFQfpMx98My5
	NxVS/HHuU6uTnjiVcOn8WDFuekHEPwtUkJF4aLJqdXgRy8qVX4UtR+uhre8i5KQ+UO5sziSJqOm
	xD5zbFH+nV3lOJXa9A23njduLo5teEILDyZKRCwyc5Oyh87ThgluO+HIP7VJMoPJ0Cq4OI3qi5a
	kXgHKuh+W8QSoW0E2RqLKyAnTap0Aztoepf6ZSRsLrVj1TZzV9YUFw3UGrJs8PifPS/4WGilSpO
	MZLk+FqEmRy2mfOAej+gthAGUslXGsAp6vqzOcqjx2d2horgY2dg==
X-Received: by 2002:a17:90a:d40d:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-359a6a51d09mr2171432a91.25.1772639029637;
        Wed, 04 Mar 2026 07:43:49 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f0f:b1d0:50db:9305:a4f4:d29d])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-359a91522e5sm631547a91.2.2026.03.04.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:43:49 -0800 (PST)
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
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v3] virtio-net: xsk: Support wakeup on RX side
Date: Wed,  4 Mar 2026 22:43:17 +0700
Message-ID: <20260304154317.7506-1-minhquangbui99@gmail.com>
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

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v3:
- Update the comment of try_fill_recv
- Link to v2: https://lore.kernel.org/netdev/20260302164158.4394-1-minhquangbui99@gmail.com/
Changes in v2:
- Fix the flag check in virtnet_xsk_wakeup
- Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..4f4f4046a760 100644
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
 
@@ -1588,20 +1599,19 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
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
 
 	if (!netif_running(dev))
 		return -ENETDOWN;
@@ -1609,9 +1619,18 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	if (qid >= vi->curr_queue_pairs)
 		return -EINVAL;
 
-	sq = &vi->sq[qid];
+	if (flag & XDP_WAKEUP_TX) {
+		struct send_queue *sq = &vi->sq[qid];
+
+		xsk_wakeup(&sq->napi, sq->vq);
+	}
+
+	if (flag & XDP_WAKEUP_RX) {
+		struct receive_queue *rq = &vi->rq[qid];
+
+		xsk_wakeup(&rq->napi, rq->vq);
+	}
 
-	xsk_wakeup(sq);
 	return 0;
 }
 
@@ -1623,7 +1642,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
 	 * wakeup the tx napi to consume the xsk tx queue, because the tx
 	 * interrupt may not be triggered.
 	 */
-	xsk_wakeup(sq);
+	xsk_wakeup(&sq->napi, sq->vq);
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
@@ -2816,7 +2835,9 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 }
 
 /*
- * Returns false if we couldn't fill entirely (OOM).
+ * Returns false if we couldn't fill entirely (OOM) and need to retry.
+ * In XSK mode, it's when the receive buffer is not allocated and
+ * xsk_use_need_wakeup is not set.
  *
  * Normally run in the receive path, but can also be run from ndo_open
  * before we're receiving packets, or from refill_work which is
-- 
2.43.0

