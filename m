Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610E1411E0
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785264; cv=none; b=I2xckDTS4SDfhIzJ4LQ5/s9H7vru6m18+lJSg+Vm4hm7fV5jivck5caS+0AeEf5KUOXoL6LuuPZQmeY3g63J1nsqVc3M3ditK+hqlmBncp4mJ5/a3ZeLv7lSMXQlKACjevN505MjkPycs393LzTP5NN7XPVqVRnw1TotYJ5R4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785264; c=relaxed/simple;
	bh=6jQq9w4RlXoevsFAm7Zi5RQIGcv8h3svhEsJaymp9as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soYvhLa05BZ5QvQPy2zorxcfY2iqwS6e/lb93cOpl5Ra+8RpgyibiNjA8IT2foAWGsM4D72neKyfCj2ieOup+zpv83BK2/XiVXgfhzefbCFNMPZwlNje1SZL9pyKjX1ujDmbDgMcy0l3XWPvgE5waqf0bHS+M0qnLcRZsB/0QkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so2719275a12.2
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 04:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720785261; x=1721390061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aylUUjY+eZRZ5UTaJ9YsIwls7PGxo5tR8Y5wxZlssUg=;
        b=BVfQqO7abC9MIACsnPXUunSdjJkoyuBqla1UdUfFovJYRpdtc4jzZFnJIgVLRYwYoI
         tb8lqAOmLM/0HtMKyojonT//YYr2R153/TgNyd0s9hEM3sekDMHZuS+5P7VGS2KSVNAv
         psmSIF9HFr19G36Qaoa8in2yq1iKA+/pYkMQo01vNrWjefBwxBQZEDKOdQFDr6DmyKEQ
         qTtG5CpZEVLuMN0+T5xVX/VVCIPpE8EyYq1FRFrKzpLGKm/gW0c+rw7uInmER401/daW
         bG2/8JIzQFUckj4xJBXUoJMubempI9v7GsrI3k9lJdBb2V5FTtU2GjW50oGXgF9cBiHB
         i77Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJbGkalmkpLZtKEtfz7KqR9j4HRBOS2/7kr6VjfmYO255DfMNAvED6K5SpZGJ5KU87+aT2xud1jG4z342T8UnwiOUVHyTpYEuwXsA78PY=
X-Gm-Message-State: AOJu0YyWwD+Vd2zSlqsbJa9mnoCZNKGCV7dKAgS7dOyuvaxBIyN7YuER
	UQptOaN+vZO09gomjK8V0mwGTMvV5p0+Z3ZeOGsRa9I3cSV8DPNP
X-Google-Smtp-Source: AGHT+IFjCvvGOIX9tsFRJ9Dy0AlCrRfCMApaUx1noM7pWNy8sfC/jqsyqBLhaPGYhuXidj8vb8G5sQ==
X-Received: by 2002:a05:6402:210f:b0:58b:6096:5554 with SMTP id 4fb4d7f45d1cf-594bcba7e40mr9350900a12.37.1720785260712;
        Fri, 12 Jul 2024 04:54:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2d0f4sm4570995a12.35.2024.07.12.04.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 04:54:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: rbc@meta.com,
	horms@kernel.org,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Date: Fri, 12 Jul 2024 04:53:25 -0700
Message-ID: <20240712115325.54175-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") was merged, the following warning began to appear:

	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0

	  __warn+0x12f/0x340
	  napi_skb_cache_put+0x82/0x4b0
	  napi_skb_cache_put+0x82/0x4b0
	  report_bug+0x165/0x370
	  handle_bug+0x3d/0x80
	  exc_invalid_op+0x1a/0x50
	  asm_exc_invalid_op+0x1a/0x20
	  __free_old_xmit+0x1c8/0x510
	  napi_skb_cache_put+0x82/0x4b0
	  __free_old_xmit+0x1c8/0x510
	  __free_old_xmit+0x1c8/0x510
	  __pfx___free_old_xmit+0x10/0x10

The issue arises because virtio is assuming it's running in NAPI context
even when it's not, such as in the netpoll case.

To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
is available. Same for virtnet_poll_cleantx(), which always assumed that
it was in a NAPI context.

Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0b4747e81464..fb1331827308 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2341,7 +2341,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return packets;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -2359,7 +2359,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit(sq, txq, true);
+			free_old_xmit(sq, txq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
@@ -2404,7 +2404,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 	rq->packets_in_napi += received;
@@ -2526,7 +2526,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, txq, true);
+	free_old_xmit(sq, txq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
 		if (netif_tx_queue_stopped(txq)) {
-- 
2.43.0

