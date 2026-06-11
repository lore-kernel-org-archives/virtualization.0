Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785F31691A
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146627; cv=none; b=Y3o4iqi6yo42ZAwIlhLl7wKGT5kTRktkb1/THSOwShPnGwPjbbdpKuz9MH/EfNVBU0Zgsh4IDC0rKqG4YKUysiZKleVauz8ffFqsi9Duz6yKg1V9jbm8l1rJKwu2YPBpaLi+ieXMKQZq5k3ZFL69n/IFkryWH9/zZsMg++Owtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146627; c=relaxed/simple;
	bh=b/o18kh6Flqc7FfSc4cmM0rvw3m5Gzf1uhnBV5Z4EKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn+9/Utqk/S4RZ3kj5m/+2qc3ZGrqSfrF4uZcX5R/obHKu9xvKwaK8EvZaI0CzXgR47/mL9jHrGHzyo1BEHATdPZvsM7xxE7bswdKKKHFGsM59SP9Eprx6WsYfslNpHGpKPFHrEdMvlymY2EqgMWT+CtmleZKgSRDX/yw4d+3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn5hLdpF; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn5hLdpF"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8423f52af13so5189912b3a.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146626; x=1781751426; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9re1bjpsG4J1aHkLAKyTTv5gQJj14gA4eTFrX1qtWI=;
        b=dn5hLdpFmrPU2zwqNACrZ2q4xNTSyUTgnXM5yRcps3DShRMZa5bGe0eX37kL5csvXW
         YsWRsvG3guoSaReu9eqJMZqCtmxlur+E+uu1MOyRjcliWwUEYW+5XEdgexLfGA7uDvWg
         ACR5KLkg+YezUQnHJ6x5mH+MSNSTNUHN8cmUGzmt4U/rpbZUYY5m+OdM7wWFmta09UcL
         IvcWPiSB4w3HxyzwIAEgU/lwP3T14tp8SiTzQzrzOR1Lp3CvhXCXWrgITDv9cD58j8HE
         RrWbQKBi2nHH4ocxH6veKi01nosJ0dJMDbqx2ofOjAjCE+XODq1Py/klmZlnD5TWr07H
         RvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146626; x=1781751426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9re1bjpsG4J1aHkLAKyTTv5gQJj14gA4eTFrX1qtWI=;
        b=RuSQFwdo2pyUSUlk6EiY4uoFtjiBqPLbGJBke7OfuJW4+ZnQEYUwYMXQfCUYJ38/vo
         rTSP4PmtdRVyqt87PjhyMTY/VCLadJJVXIlwCQb46LXEx7HKtB7cmU1YN7JySNXJHa2N
         RNMa0SthIn8kR9AKEXKIzMFhut6gqStA36ErOuFaueRimOgsAPtuQlca8bfwNWPZCkLk
         q1d2v0bm5zV8t+hytZ+C6tRChA+8im0VsBlrqGd+1G/K4vC96LBZKgcHmlSvNfrpJbMv
         +2ky2e6r90MsvqpQdhN1z/UFcIjv2sQsxAKpT9N3O5CY0JpwT3cDRAs21qGJ35xSPO2D
         w+nQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EWas9rT9ZGBf6G1nE4UtA5+Kp5sb4LrFEHVnRCEZvvEthzNGvvgjUhcR0gpeXX6W0Nhx0c6kDDoHbEAbTJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg7cWL2xcKGONr0mabhcFpbtTE+tP8iWXp1hHa8Fcxow9wuPRu
	89Mf+uk2kjPULbrNndZ7aDRpesuiSHNe0mxMTJuZtMgJEnZzQyVo9ziK
X-Gm-Gg: Acq92OFhyCTD5EFNaAY1O7fFQlW9km6B0YaJ0d3VvHfIOmo7ql29xSyv7vfTqp6y6Wh
	T2A4h1E67xX1hLBVPTQALfJUf0jbnc1nHwP8bu8Vj9YbkKZC9pMpZEduX9gQrzkh6yUOTz1h/P7
	P7i0ff36c1cb6Eb1UCE1n0jTWpAYnlF+7DrIpTPLq/G1iC39sGagCor07s/xGA693e91ByhiE01
	OXKWI2dcw8TyQBbnoWcGbijSfUo41dSFp0LMITIipFq3XV/dWluZztJOKSHyWuftD245JS6uplo
	Tniha5T2GfntBaofNTECPKuRSwEZvX7i7ApDE2ywkZK1qax7mABDp81A6AD70BmCapOly4QRcSW
	gf7dR2VSsAsVAadN1rmV9Y+qwLUaHWViYhaswXFeM96fQfRsPRylvcA7rFLCdX72ygQtOlhVPFE
	L/0w9gHWi1Ae+yMUz6sxJ10lSY5MdTqQexy/cYrxEIOT5MoMHhYkA=
X-Received: by 2002:a05:6a00:3391:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-84336a8cf92mr846580b3a.24.1781146626022;
        Wed, 10 Jun 2026 19:57:06 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338316f0fsm233006b3a.50.2026.06.10.19.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:57:05 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Thu, 11 Jun 2026 10:56:43 +0800
Message-ID: <20260611025644.2431148-2-dongml2@chinatelecom.cn>
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

During packet receiving in virtio-net, the rq can be empty, which means
"rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
can be empty too, which means we can't allocate anything from
xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.

However, if the user clean all the data in rx ring and fill the
"fill ring" and check the XDP_RING_NEED_WAKEUP flag after
xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
napi will never be scheduled: the rx ring is empty, which means we will
never receive a packet to trigger the further recv fill. The rx ring is
empty now, so the user will not check the flag too.

Fix this by set the XDP_RING_NEED_WAKEUP flag before
xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.

Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
rq->vq.

Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..4b5b3fa62008 100644
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
-- 
2.54.0

