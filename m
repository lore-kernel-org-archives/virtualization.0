Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8A423A66
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469740; cv=none; b=dYiYA4YGdiahhC/M/pQpYL+4xJzzBNTC9Wa7jZkUck3qga1FpqjQFUZv3pToPe9K+4jvKKFNifNDPenZYKNxS3oRoIRJWhPFC5ybZa/SveCjllvYTNYgcQkPDN3MFFsjO1wz8lI1JhXcjFGwVTUEwtR0CLJgL/+muFVy89AXIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469740; c=relaxed/simple;
	bh=VFASPJvhciehL7F+IA6+SdXs77TNKb/sys4Vs9JnaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPQP7vrTkW86hJ33RKbXUUlYQz0PBzwJlphO6hxfvSAABNfzzLtNuDloNCUfZ7Nk0W3+KnBTaHFmxIpjDyHtrtPM6H+Qyp6HrREigfOW4sLplJpI4KXdivd3RvhsS6P0CsO9+AZrhm+mwr43W4QEeffkN+Qj7hn99QBjhdMUxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTP+edzq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTP+edzq"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41985so2754457b3a.2
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772469738; x=1773074538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZaKRJcz+mujuLo0S8DFt3UkN8fu6YsunVoMPBDL58A=;
        b=BTP+edzqNuAJ56D8FUMAGhv0welxsyJukL3zPhrKfyVMwNRbb/i4Gb/CC4+rd9/INr
         29YWkd2zPGCP+m0DFC4HURWy9SQDuhxC8uOY8+OSxK63PXnS+FnV3DBMppjwROnnV3Qy
         kfg2NwwB5WKYycGlvE2V1BmVM1GOWySkQ6bPFgAeNCG66E2E21JZdKrf4R56OY387IO7
         0iiR2Sa9vJXu3vj606676/qmSWsBVniPzOilPlUgndrEWum4eu3bStRY63J9g5moeN0A
         ffUdEj14ZKta88aTdgx8J76dzP0t7s2a5sEaOYL4sIUTfIb6k3fcwaUadieUA403VlNF
         cXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469738; x=1773074538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZaKRJcz+mujuLo0S8DFt3UkN8fu6YsunVoMPBDL58A=;
        b=KTPpEWg7oDQQlKbjIJgphob0iw7SSfrACCk/zxwqLqHfgVuYUrD3j1y6+PCyw+Wn1s
         1ZggKspBhFXI+WXWuyK4Ao2DxC9q6zycBoUW4TsCohGzRT7SIjTAO+oJ82C/+8/5HpK+
         Iuw7zRZA18/zNtSizjAtkeMx9V7+chmgKLpXajqzQMNdiYqAiQSpfodi39i1hP/u39OL
         FBWruV9KM+9obdqmSyzXgb73yXhFaPbr49V+LEj/znfdmwL8jkIauDZgW2fkQEQ9yKys
         hSnEcCEqgM06mgIGj0BUn4nkoXqpzfo+D/ClulqNYATw2/SFVB0HeqJydg+UNlC2/DIW
         9KQA==
X-Forwarded-Encrypted: i=1; AJvYcCXoB9rgCQ/Tzw8Do9u5FCzildQsqqM3+7YaCC5ulcgeLhtL2sAfinvoqIj2xG7Wb7GGaO5Gmjjhw6y4nIIs+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5w2TlWsYWa2rqBB6DHr0czDt5meU74sdbkVkVVxutjkmLbxbJ
	o0sZz9P2IJ+neIp18Bq2NnD5ZvkhFMRN72FNCLG2DFIcduFaXGbKWXte
X-Gm-Gg: ATEYQzwKqKwZarCxWgbdNL7iXAN5szPOx2sG6+qAKNnIGpaUMuM2L/KSxz+9zrgYqLl
	swH0RxWNVhjGqmT3lZbd64jNRfSh1stEDLrJl4T+xiqFMjwHDFutXX973HBgkqcjOpKVaD7EgOM
	TekUNkpRbWUzMHuBK2gI0DkBV887qc+WVwgzuieIBjbgVdEwRf2WPIn1SFI2sjXknIjHHkuWKyf
	dYxdQ7f8oJJ478nxtB3zber+RyTwSgNzB9RHhUa1Woh7jMwHp2NiiUHXcxRSxeqwxO5FiOg2xcB
	sRbK9YOYthlkEpzlvhSCGC9F28XH3QaPqCrv12xo3Q1FKYczrGFb/huqCyMxbPqFUGqekAJafBS
	dwoJ8A8I/8XZkkme+vqS90rmiTuDghnKXAc2h9PvsLQEiJ6oKQUURKoOvpiE61jf9k7XPMuOUoS
	V1OG/4VVIhPrscgeL+vZQ=
X-Received: by 2002:a05:6a20:a10d:b0:38d:efcb:2e84 with SMTP id adf61e73a8af0-395c3a86fb2mr12074081637.32.1772469737400;
        Mon, 02 Mar 2026 08:42:17 -0800 (PST)
Received: from minh.192.168.1.1 ([2a09:bac1:31c0:8::246:f5])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c70fa801849sm12681295a12.20.2026.03.02.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:42:15 -0800 (PST)
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
Subject: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
Date: Mon,  2 Mar 2026 23:41:58 +0700
Message-ID: <20260302164158.4394-1-minhquangbui99@gmail.com>
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
Changes in v2:
- Fix the flag check in virtnet_xsk_wakeup
- Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..3614002fc87c 100644
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
-- 
2.43.0

