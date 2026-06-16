Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E244BC92
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611160; cv=none; b=KbRcbTq/oZUaKyB9NDyJYgKesxwVNIuUgB+3DMN2kBFWv3m9OhYNfDiErUDpZ4xPXKSy4amWw5cuHHSUKI76B9pcasv+QKw0b2fbFkiMapNRjxbIj77vamysnnC0IIFULImqqtzdVlbB2S2noPDli756grHn3fJOA5e6XL4Yh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611160; c=relaxed/simple;
	bh=kQx7S1lN4paJYctsV2z4hkTK7SF/owMDbAW+qh6X9Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wc6F6cDia2mBBlhkGK4nZ0+6zyyg3pIiCcVo+mnlT3xcSDcfOF7WztjO8TSosHF1rAxpZcwiPBJyS3kQszKOSpWKEoZO1l7E3YtUeQ9T5zIWLML2dK0FZMtovPna91cVRpgt66wjn6Z6jJ81tVz8x2ON0BMYb6VdrUuKFQdxNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ4EPMVQ; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ4EPMVQ"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-30759632453so6787614eec.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781611158; x=1782215958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4g6o7WznQqMD7DmuskukA26zlCv9hBZUO8oTLjiGHU=;
        b=XJ4EPMVQ0+g0JBgpvRn826Ipux2Lo2tMN+XXVVszKPdNGYj07mGUEE7NmJtshgyV+t
         lRp+ubvaBr8nQetTkJa3bdi0vvWfWvtlyU1uZHlBDZSDPumWHQ8xaOF8huFEdIk3WagB
         Pm753Oh3Lo7IPFXhyGKcQC8sVES0Vq+Q/HQhw92YDcEueNTFklXNWydEkdf6nAN5ssLI
         cMaSeCTPlgEuPUzKCRbhAgEACczuojrTJdW/64jcmIMCaWsPFiAZUrJqmgZzSSQvcP0R
         8htoGpO6vUWVKcyEUu1EQJYCv1JEHYEY3dVc9yEtq5xbNIvMU6XIPUwODwPrrfTWjeGF
         tXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611158; x=1782215958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4g6o7WznQqMD7DmuskukA26zlCv9hBZUO8oTLjiGHU=;
        b=auRWvbKjHRn0yI3NN8vK5/3z0rqhMjPmhKF+3FRndAHr8Pk1HcXJa1QWF7g0FpUE6P
         hdfpqIy1Epe2S/+9Bd8OhRn4RIa6LKkqA4bLwaeKZYiqjvuhQ/DfCJdwBs+FaJJsqVt2
         DRaWtC4QjA67b+h2KzvT4uNNS8Bxo1RkAwHo8qiC5msdR1jo0xp7M1EChriG9Q1KFHmR
         MsT3BgcQ7OyqGVI8+kE4rGdyh33UmpQpVuIdoFxMjm3+ZGm3jaE4bG3MBSAO7sTHtJGd
         IJzPIoR5C0zoZiydrIC7agOdgPCX59wgPhJlZMp08Z0HF7woQsge17tDjNdb+eCgHbql
         RRfw==
X-Forwarded-Encrypted: i=1; AFNElJ+vB9g4b93qqaY5oABkEodsdZQZ+4F/w2qZ4SzKksrmtFHkC3995ISm8+MwEeMrpKPdn/4QE3XxkU3Ca/rxgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMZMgb+Y7mvIr8bgzaKMcWQ3r2F54eMhap47lcapxCBc0IxCpf
	sRNajowS1cEvYbDb2BsXslXtnlLBdSmG6f8wzmPW2tftfQcQ/URd9C8Q
X-Gm-Gg: Acq92OErcqeuB2s2GB7dH6vJ7DnoYK5F4rf/CU9NWfr3dCZYdEywLDmCBWp7wHaw729
	RJXb5yE54Mb8Z0l0nrRcOzroWZFkoUF7qMw8m7aBku7VWyECTf6j4M17WzyWhNY09XAbC+mOPD0
	lzZR8mtvOGUoegzIsXTbWGWvGf+er/Y23pjnsHEHTHVhri8W2xdHSoTKGCKftv8Xvp+i9JcKpg/
	AMGhIiijQiKg+YxUhurl76JuzC/x8hNqfsphQraJQfV5RlukTKA42xq9kkic+7M2PXlalqfYPLT
	wERRk4VxVr9QFiiEztJVHkz+BVom+C0wA3IqarLPNDcYdrVO1oJPkw2vANDPbcfFE5SAiGgT2HI
	NdekNsgAyBiZt1qgX5qX7V5Qf8DmEmILfA+2KJ/hYvN2AxCAEWq0/Nodj1f34die9WVpYq+nixe
	6pmrIChO4c/xNpKKRmN7sDFmIfRd3AtX8DHe8Ct6PE
X-Received: by 2002:a05:7301:9f0a:b0:304:dfae:68a with SMTP id 5a478bee46e88-30820213e52mr9174117eec.28.1781611157637;
        Tue, 16 Jun 2026 04:59:17 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea447b4sm17474328eec.23.2026.06.16.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:59:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Tue, 16 Jun 2026 19:59:12 +0800
Message-ID: <20260616115912.513183-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v3:
- remove the confusing comment

v2:
- add the Fixes tag
---
 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..6e099edef6e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1440,8 +1440,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtnet_sq_free_stats stats = {};
 	struct net_device *dev = vi->dev;
+	int sent, vring_size;
+	bool need_wakeup;
 	u64 kicks = 0;
-	int sent;
 
 	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
 	 * free_old_xmit().
@@ -1451,8 +1452,25 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	if (stats.xsk)
 		xsk_tx_completed(sq->xsk_pool, stats.xsk);
 
+	vring_size = virtqueue_get_vring_size(sq->vq);
+	need_wakeup = xsk_uses_need_wakeup(pool);
+
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
 
@@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64_stats_add(&sq->stats.xdp_tx,  sent);
 	u64_stats_update_end(&sq->stats.syncp);
 
-	if (xsk_uses_need_wakeup(pool))
-		xsk_set_tx_need_wakeup(pool);
-
 	return sent;
 }
 
-- 
2.54.0

