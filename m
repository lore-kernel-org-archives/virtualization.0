Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD61A727F
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440604; cv=none; b=fb2WSmnF2mr8BTKsPY3bG+kNQJyhXkILjp7wdTVmafFYRpzFWrSnDi/Jc+IRXIITQIYlRSKz1l4hniVmtqJ/TqgLfvK3nflpUgcXf+PI/xflT4VOIznRamkgdC2qLT69gnZAQEkitXiGItAnl6KOUMOLNHVXhZ6aSRB87kYzqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440604; c=relaxed/simple;
	bh=5nUIKTbSg4q4zjEfAj6auMPQ/ltfU+x864zJsQBxEAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/BMiDfW0wfOmK9Dg6RJY1IJEatXgoIukb4h6okA2LG9SBDFXyIrAQoxq+XrAeIhbQ7+/WsPHUp6dAy1k4A21m7uoTpMfbgiKBszeaYnWmvxEC0DguGuNr5T1AGfqak1dnnROqxBgO1hsgZRam/VmbOmW84+zonJxK9cHVe2UTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TObAii0H; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TObAii0H"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7141feed424so4968813b3a.2
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440602; x=1726045402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wB/yV3+rf4Y8RzFigd5SfHDxwKiBR/fUQmaqW/rq9o=;
        b=TObAii0HGMwJoVPizVPAOJZhVH9S0Hlyyjdchpb7CUUbbLx7wNDeD6Kxmw+qacA0ax
         7LoWS2NGEsQAvaa5N6+AJ1IyO7AUoIAZ6AuEWz5JO2b8CLgEHFvRSQAtZbeSgQ8mbQ+s
         MUdRLFNoYL6RrtHVBK2AQGPzzEEwk7ygATBsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440602; x=1726045402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wB/yV3+rf4Y8RzFigd5SfHDxwKiBR/fUQmaqW/rq9o=;
        b=DLBuqspCq0WOUMsBIOMamhJFHKdS2YSdLD5GYJL+BwmybwsM7zymn8XNh6vu28awdb
         JOR934dopatSuWXVUJgq8CsH/188X98oyO/hix1EBsJFbNm5Lg46NCIreXDQxlvtCUoo
         Y5TKRP0D+GfNvbc/NZrS8SjwRwXcJBtttw6+rWhndjRHTFFL7UvCZ+Nb9yad85djSvXA
         dIUp3Bd3KOxWus42gYdCJhqBVHFqOpkA2nNShVYzwMfKguMIwIpEUaPB4d+AhW5nU6qg
         JaZqcrjy4XKOI0OdOY5bIFY+smFGlOdbddzLg78Y/0A/xrG0+7/dlRfnBZ44qx/zoPsN
         lQhA==
X-Forwarded-Encrypted: i=1; AJvYcCUDrvg13M1ZgGFT1RC1kfk3VZWDbD3sdD79GAU5YcQobZCdqJEuombM++qFH/+zdAcWgUCjWSgHSUOCETkbKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwQ/i5jfoJzHVQRtgvyH7hGWaA+xU5BuBlPi1+BJtfXlTdLNKA
	lIAdLbgWwqMNJSgHHq8oFKNCBZMf0OLEy+mK41uOEXQhALkgZBlhlhKvPoSlug==
X-Google-Smtp-Source: AGHT+IGJsrgHqz53yFeaiETqupdXCgzC4IvuSfWziAhSvnu7Z3D7dTorU48dhFcm1em0e/sX0x2smQ==
X-Received: by 2002:a05:6a21:6e4a:b0:1c2:8c32:1392 with SMTP id adf61e73a8af0-1cece503be4mr14192666637.22.1725440601553;
        Wed, 04 Sep 2024 02:03:21 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206b93468b3sm6483905ad.120.2024.09.04.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:03:20 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Breno Leitao <leitao@debian.org>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 02:03:12 -0700
Message-Id: <20240904090312.14965-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f8321fa75102246d7415a6af441872f6637c93ab ]

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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Link: https://patch.msgid.link/20240712115325.54175-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v6.1.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61cc0ed1ddc1..e3e5107adaca 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1638,7 +1638,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1656,7 +1656,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -1675,7 +1675,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1778,7 +1778,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
2.39.4

