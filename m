Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CC373BE7
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079428; cv=none; b=P05dmBY3s3VkcNyoxsnd1v5Cizz+WULQk7YAOneMgk5HfXKSbI0OkCFmg0Ui4pl5cAOFULZ/G7qTiy6n0N4w3u/E0A45XKDcMLTgXY+cnJzDYae7A/ehzlAvkv/bmwddOvcLgNN4CoOFXHyxC3aU9+AeEpE5uavDaSgG3LQAuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079428; c=relaxed/simple;
	bh=eD6bS/8t0ZEWwpl1zMDjka9rvyv+ATYSkVg6tY4k5Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOxCti7LFuNxFsq+aWgTwF68C8T0c+xHuJA2UPEhQXM59t8dSLZAreo6fOkWg6QwRc26lU4v/xgVqLHrXVtYsi28tBamopduJqXDYRtz/Pnsz4db+Wzw5pL2YXEPLMSlUu++3jvX2J0CnH1+Oc/dVqxpWtUWq9Jcy9iG4wbJ1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdb7hoGC; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdb7hoGC"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8423f1d8902so2789018b3a.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079424; x=1781684224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1GzByE5mWAgP6oTg0byjBWbc8PVfX/Ft6v3MKkID9I=;
        b=gdb7hoGCQy30Hr2Ag+GhUG+t2o6EaKdKb+6a6uGe/JxuDf4tu913zKM9aN+i7Zv4Mg
         lDIAbJ9QFhxQgGSJtMEy3E/SsUnbQwvzdpl2lE0PSIsbHRt0STY+5XTvfzdmgQrB8SHT
         KgNYYgqOEsXaU79RkQNFc3aHnamQ4SXmzj6eYmVcg//xf00ww6DiYgxOGrQpRYDYr1dT
         n8OuoNeHL/AEMTrvSiEMUEzao9lqYwiYj2aYIkGPfBrEfXGe8ep/eYtIEY4DdbMK3wdT
         9eDtqtuXoihaG98Md5MxnuyQAJKHxGnNNLspcXhVhOeXjNCIFv+SIZO209Yq7VnlLAAe
         lMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079424; x=1781684224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1GzByE5mWAgP6oTg0byjBWbc8PVfX/Ft6v3MKkID9I=;
        b=slOzOaV5a7y+1xDuDAh3t1uAYuSZJy05z4a+W4rSX5pF9B4gRAzud8dDc4WflS56Ab
         WU1H2MMYwtnJjD9Z6hHnkZUxd1BInHKXzIjl/6CPtBs7AxCNQnAPZkCmSELX9JbkKa30
         /LDMCyd4Yyi0eEBDwfV2ChrVJrs5mkMtYPGu0lmLVz5GXzrxRVTh+tvfkRo5bC459W1/
         IjYXLpmRxQGKnheGh5mDqGSDMl8MdAyFshMG4FL9sO0gPn5WrsvtiOL2eyakUdB12LMJ
         4pq/FfFj1dtTVpnPR62c4aD8wkEYwyjdWwUoSF9givJJzxvHSMgXhTVmZaiBu7breyGG
         I8cQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IB9rxoL5Aq5si3dal4Ide9P1WSkHc5lAbWAU2WWktXFQ3qbT/kJ0xrn6nFisIghbJCl9ZOk87dqHeNQGs5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz42OGn+E/QtjIJBv70EK1dLLVahC+kR+XY333VOWAMSJgw6rxw
	w8tCUOaxWXcLl81rCHGHte47SGqmumcYB7/Z/tm5OBUdzFKVpwnY2a0p
X-Gm-Gg: Acq92OH+hk6JhdQtYSVowdGtmrD0shUuVuwCsYN9HAydrPz+9J+2Q10qjZXq1RdlZkV
	5B/FTwEzN0p4ux/esHVdstJnuFNwRIEv/TPW4QG3zGeqVYdzDutz7FUps6dXPxt9CP8SsMrivSm
	HFrtRuG0lswt51SKta0q5BwXytRtqML//QhrtjzoyQYioCupyJPIpdUm1rb7SjvcvOHiCxArNJx
	3RM43J0ztPzSlrnRHr8OSv28mAsa522dki3CG9SgC2M7mboDgg5yEtoN9nWzFPjhUevuUMNa/KS
	Nx3OHxnPu07y7XwOWPtGHq8yemeIXyF2MqTc2fLqrY/COnVaH6n8lIwwsfig8QBsN80vsjIDn/u
	f5DKaK3k70dbKAhPFYgF2ZKCHJeNTw+8UN4WS5VstdKUWgFwciVlLFzbYQwaNK9bP+QgzUvymRu
	2QYshFbx51RTf799LF1vFI1WtwafkAKsaNg1z31vSxTgb8isJQUI8=
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr24663991b3a.46.1781079423860;
        Wed, 10 Jun 2026 01:17:03 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e02f9sm23759546b3a.48.2026.06.10.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:17:03 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: xuanzhuo@linux.alibaba.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] virtio-net: support xsk wake up
Date: Wed, 10 Jun 2026 16:16:48 +0800
Message-ID: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net.
Take the tx path for example, we set xsk_set_tx_need_wakeup() in
virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
anywhere, which means the user will call send() for every packet.

For the tx path, we will call xsk_set_tx_need_wakeup() after
virtnet_xsk_xmit_batch() if sq->vq is empty, as we can't be wakeup by the
skb_xmit_done() in this case. Otherwise, we will clear the wakeup flag.

For the rx path, we will call xsk_set_rx_need_wakeup() if we have free
buffers in rq->vq.

Race condition is considered for both rx and tx path.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9b3da9f9786c..25e895b849a6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 				   struct xsk_buff_pool *pool, gfp_t gfp)
 {
 	struct xdp_buff **xsk_buffs;
+	bool need_wakeup;
 	dma_addr_t addr;
 	int err = 0;
 	u32 len, i;
 	int num;
 
+	need_wakeup = xsk_uses_need_wakeup(pool);
 	xsk_buffs = rq->xsk_buffs;
 
+	/* If both rq->vq and fill ring are empty, and then the user submit
+	 * all the chunks to the fill ring and check the wake up flag
+	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
+	 * we will lose the chance to wake up the rx napi, so we have to
+	 * set the need_wakeup flag here.
+	 */
+	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
+		xsk_set_rx_need_wakeup(pool);
+
 	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
 	if (!num) {
-		if (xsk_uses_need_wakeup(pool)) {
+		if (need_wakeup) {
 			xsk_set_rx_need_wakeup(pool);
 			/* Return 0 instead of -ENOMEM so that NAPI is
 			 * descheduled.
@@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		}
 
 		return -ENOMEM;
-	} else {
-		xsk_clear_rx_need_wakeup(pool);
 	}
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
@@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 			goto err;
 	}
 
+	if (need_wakeup) {
+		if (rq->vq->num_free)
+			/* We have free buffers, so we'd better wake up the
+			 * rx napi as soon as possible.
+			 */
+			xsk_set_rx_need_wakeup(pool);
+		else
+			xsk_clear_rx_need_wakeup(pool);
+	}
+
 	return num;
 
 err:
@@ -1440,8 +1459,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtnet_sq_free_stats stats = {};
 	struct net_device *dev = vi->dev;
+	int sent, vring_size;
+	bool need_wakeup;
 	u64 kicks = 0;
-	int sent;
 
 	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
 	 * free_old_xmit().
@@ -1451,8 +1471,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
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
 
@@ -1470,9 +1511,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64_stats_add(&sq->stats.xdp_tx,  sent);
 	u64_stats_update_end(&sq->stats.syncp);
 
-	if (xsk_uses_need_wakeup(pool))
-		xsk_set_tx_need_wakeup(pool);
-
 	return sent;
 }
 
-- 
2.54.0

