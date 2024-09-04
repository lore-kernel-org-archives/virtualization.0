Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DED198E7F
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440764; cv=none; b=ucjyLUAtPgY9fO6cvyn85VYKT4xQ+DtY25M11EoxplT/wIUCNQalBrw1BG3Pz2cii+DqfOtxb9FeyMGDhmt235koLcU2+weK18TqYgOjEWaMdr/bTjW8mZNhJc0BOIe0mlG52mZS35wMnSYEEwONQQ3jEabniWCkbcJSYLZzX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440764; c=relaxed/simple;
	bh=jDBq4Ng87U5vWLCtGk/fTMd743FQxW3hZo2L1hthBoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHf4mceJkvIwaycgiDhPHAwdY0fga5Talo+3AOcIr4ASg6rp4NHpGM8dNHy9qa5yAVfZsyB4caTL/1q/Y184zOYCQ2ZG3hTX2yuzfGf14oXMaxCfLAGIcuWeuy1Wl9zedntHqYnd3n5VUcBLQNdd2TJC3vVenSn2sOdINpxbFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f5J3cUry; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f5J3cUry"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2068a7c9286so19240465ad.1
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440762; x=1726045562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2WW0Uh5MFwXmQymV6WF9+7CjegjBeXRtTOVI/P2KHw=;
        b=f5J3cUry8HLsHNZl+oHpO71df5fG+G0DBO9jKkgeUfn+rF790qCHRa+WcAqJGVwJ/j
         qt5TuePrU8mBeCHmLUdZvdWJD133zyfUw8fxhWjhNroQIqWKvPlmfZlEMdcQZvrRqnQ1
         RWXF3hd0GNM9GuBG1+myv1CSJ4nOho5nmFCr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440762; x=1726045562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2WW0Uh5MFwXmQymV6WF9+7CjegjBeXRtTOVI/P2KHw=;
        b=MB7cW0MofVJLxJzxAi8CV6+CtPeRKOeTcmco5ypVYlcS2JLlfHR0AFVRutARgMkK74
         2OZnxU7/I1HsV4qwAmvPh30kESO/U1xY5VfT4+QW4P34Z4LFssqAMiPaDbbDHVdy3wCO
         TRNZaCLk45j/TydUMfZ197vQAWPqn/Szwk5cN1WHWjVOqznV6rIZvtdlgbc43afeRzEZ
         6+WSO9FGAog6s9VpvlVUyPFYVLtvTs6L7xTcWdj/vUsTmXEsjqOavZUZkJs0DK8djLdh
         f+NItKRghfnlaS7/u3eq64/HZtoMmqXpeg6wvsWJhhpN5c/NpdRsZSr3Jxxw0wmqRHWA
         5GrA==
X-Forwarded-Encrypted: i=1; AJvYcCXBB9baxRzk7yNfT7uSfWP23b/Gf75E9GSpRSTauSepxPHtmGYi5DAgUOoo7f2rc68/PDOW81USOljBppkWXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCFX1svQg2Z1sGyBqpjM9QxNFd40WLfuZy4gSK2hrr5o86NStb
	QS/+eugEakOBRJaqhC1ckMK79ti9fXZXCH/Eqh37mGZnYsWE9gywyyax4YKa6g==
X-Google-Smtp-Source: AGHT+IEBsx5mNF1aMY3Pulj+ByK6nJUa4wjeFTWqbIBmNujyGWU5qrkO+va3WqSnQ1IWgwTrsH7VXw==
X-Received: by 2002:a17:902:ce10:b0:205:8456:df0c with SMTP id d9443c01a7336-2058456df32mr82458875ad.26.1725440761785;
        Wed, 04 Sep 2024 02:06:01 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm9670135ad.182.2024.09.04.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:06:01 -0700 (PDT)
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
Subject: [PATCH v5.15] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 02:05:53 -0700
Message-Id: <20240904090553.15076-1-shivani.agarwal@broadcom.com>
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
[Shivani: Modified to apply on v5.15.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bd0cb3a03b7b..d8138ad4f865 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1548,7 +1548,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1561,7 +1561,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	if (__netif_tx_trylock(txq)) {
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -1580,7 +1580,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1683,7 +1683,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
2.39.4

