Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFC28DB54
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146633; cv=none; b=ngV/SJKa0e4pHYauQkuYTb+lVZxru28D1zczE8EMc5iOEDcn2m+JYun+ibdZhCPilYcXiPGv8RS4XZLGfsCFsAYEKxsApfcp999YkwSP6NVxF3yfpojhPIJE2MKVPRZO+Jms+aLqSZUnphJ0h/bJiIiXBZYtohv13S2V6hhVyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146633; c=relaxed/simple;
	bh=RoRVrNiX+bgef/3jboe+9nL/6JI24Go7+Wl95RFBf3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVEs261z20HudnJM6Qv1mWaNlRPYOpeXb7a/P1NceiQy7qTq8wKcWDWwJ9jVgppk66gVrA5Gxf7J1mdjyolYRuNtuukWiclYXbuHPyiLzfksPqM10aafFIjDrjvUf6p/1S6aS/0fOSZgmNNafzpiXnwmavTPpoIFJRAxV3Zktvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/bC1eJm; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/bC1eJm"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-842273a2c4dso5093803b3a.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146631; x=1781751431; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGuObVQF66WCHyv524cNB4gmmTWm0m/X8koQNLAf5D4=;
        b=H/bC1eJmZPOB41iVRjXOLA/LyqteDRl4bS8+Ch+z8sBRmFT8Fz4mt+CODMzXB5dYZW
         fN2eapA9jP37RjErvJxmX55G1V7+/PiG8ESu40ntI9RUehIS1w3bZPnQwFcXpAK4XKP6
         QNKUVKQdzzvEwLAqHg+ngqnb/nqRw4KgbZ4OTsYPVRMXON8qkkYxQPNdY0SYpbVionfF
         F8NIxfhG+vDKefva2UUOv63OLz2ncLygjjrSv/6Qdw8PEs2NSyADRnMOr5RJS6hFXI3X
         akMWtkHhV6McO70rJk4v9TbzxrK1uNaY/OM3c0iW1tKzM81liRsgUTAfevXhtWsG+2kk
         Y+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146631; x=1781751431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGuObVQF66WCHyv524cNB4gmmTWm0m/X8koQNLAf5D4=;
        b=YpGL9VUIuMPcAilZ6Et+XbrZg65EgJDADN3tARN9By21pUxatcNLwiNbaYX1KdcHIp
         ACl0NoGIMHKBiHjg7AHbncjtSsbPAPT0vrJ8POQiArbgh/irX4CTR8G550vi5yki5Ktt
         xreMd5t+EXv91BNSvVcVE1gn/fRPq9xsxm9choD6XVrdIm3OmIabw9pFIb4PLoPmT/IC
         rKrrtW+QyAb3XsTKT9jUvJ0UZ39niZxPEI6Evkq6oZcFnZT+A0Aq9FTz3vNBiwltLAJ+
         3ZvN5WOTf+f7E8811El2Xr8OXLJNCCuJ4iIMrPMcfN4hbzhshp5iNpPprkzHHtrfDhGP
         m1FA==
X-Forwarded-Encrypted: i=1; AFNElJ+UAngFFgTb3w1ra7u9dJmUpKThQ/+OrktBimnZYWBjpteU8/7vk4Oxw6Lf+5qqhXH+xz0Ce1oYnEfPgVDaVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeqLbYxJckZZhLXSfTk+TSSsfwpbnTdInbAKvvHFHn8M7NLpWB
	xm/m92MsNeAN1b2ev5nMo/vt1DiRuKfvoPFVYUI/Z9wgM2aebNUucCCW
X-Gm-Gg: Acq92OEXPpvEB/7CD0qKu2vufavteGvzFVxqJ+zFlDWzwGuj4J19wtrVcOmrN1bUyF5
	sNq+mIArtZH38TyNTbSP1vECSygOMtiqewNNAEGCN7Fus4PPHVzkDwwIwybiL6db9a6yzgW3XZw
	Z9ABOtuPGJxdFbqN94C9YAZcPGlpmu21vBYKceMnFWf55DjStFfqxrDr6OEKF5lyXWZOZw7jQAG
	OzBRruFaj2jMJqyp6QyIM19J+w/cP4zXD+vBGg909B8BALelQkB6bR0tm1SnmAQ79d5i51lWRta
	XDg6KLHTMmQEBXAUiP61QSNC71a77G5ZUXk3lhLaeB/h7XQjvQ6iE12Z5+Nb8RrnaIgYy+jFWLT
	KNvLwhBffls/TWabJMYvbeMmpasKeFr/Fh3HVdnAd/BBy01lzRkQ8a0WCF10q3OfUGCBkWLYqr9
	ZcdUo1VQZz9xBRD9PB3/j1lSlpvqHtH5jeazlQsfheJGfOlISxnexLvduxJZfRLg==
X-Received: by 2002:a05:6a00:ccb:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-843367ea47cmr848637b3a.4.1781146631159;
        Wed, 10 Jun 2026 19:57:11 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338316f0fsm233006b3a.50.2026.06.10.19.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:57:10 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	minhquangbui99@gmail.com,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] virtio-net: xsk: support tx wake up
Date: Thu, 11 Jun 2026 10:56:44 +0800
Message-ID: <20260611025644.2431148-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
References: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
in the tx path for example: we set xsk_set_tx_need_wakeup() in
virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
anywhere, which means the user will call send() for every packet.

We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
is empty, as we can't be wakeup by the skb_xmit_done() in this case.
Otherwise, we will clear the wakeup flag.

Race condition is considered for tx path.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4b5b3fa62008..86b5c1ca568c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1459,8 +1459,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtnet_sq_free_stats stats = {};
 	struct net_device *dev = vi->dev;
+	int sent, vring_size;
+	bool need_wakeup;
 	u64 kicks = 0;
-	int sent;
 
 	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
 	 * free_old_xmit().
@@ -1470,8 +1471,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	if (stats.xsk)
 		xsk_tx_completed(sq->xsk_pool, stats.xsk);
 
+	vring_size = virtqueue_get_vring_size(sq->vq);
+	need_wakeup = xsk_uses_need_wakeup(pool);
+	/* If the sq->vq is empty, and the tx ring is empty, and the user
+	 * submit an entry to the tx ring after virtnet_xsk_xmit_batch() and
+	 * before xsk_set_tx_need_wakeup(), we will lose the chance to wake
+	 * up the tx napi, so we have to set the need_wakeup flag here.
+	 */
+	if (need_wakeup && vring_size == sq->vq->num_free)
+		xsk_set_tx_need_wakeup(pool);
+
 	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
 
+	if (need_wakeup) {
+		if (vring_size == sq->vq->num_free)
+			/* we can't wake up by ourself, and it should be done
+			 * by the user.
+			 */
+			xsk_set_tx_need_wakeup(pool);
+		else
+			/* we can wake up from skb_xmit_done() */
+			xsk_clear_tx_need_wakeup(pool);
+	}
+
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		check_sq_full_and_disable(vi, vi->dev, sq);
 
@@ -1489,9 +1511,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64_stats_add(&sq->stats.xdp_tx,  sent);
 	u64_stats_update_end(&sq->stats.syncp);
 
-	if (xsk_uses_need_wakeup(pool))
-		xsk_set_tx_need_wakeup(pool);
-
 	return sent;
 }
 
-- 
2.54.0

