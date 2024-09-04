Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19E188A03
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440325; cv=none; b=HprgcdUGTFSlN89i//WVkge1iCSLe22pSr37hOvCImaiCHKbq5PWEHvUWUu0ID14az12H+wMwo6l9gCsJ0RtChKsaz8X6G8EaBKS0U5xNjyvfn5pmrxlW9Ebn5ueO/67M6lx1vAnoqCYSNyQl7JvfhrPwVLi6N4sgUIf97Vl4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440325; c=relaxed/simple;
	bh=XfKP8unbbPBjVgS+QzaKOcNAm22jNvgAVhT2scaF0BM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mUdX0smF/du4O+fhgE+Z8ruQAq4DFPvFtgdWQ653tRAeGIXOE7knfFwhetaenos1nZJN1W/9QK3t15K4ec9ymN/kdzFqQpuPtH/qHI6HDQFR9qVHctJe9XdQpDTlh73EB146V0RubWr5FiilhQqzVXeDP4QJE4wv7CBsVGsHcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hMXIg15W; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hMXIg15W"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so391251a91.0
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440322; x=1726045122; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+t37x9TLIsk4O4gRZ6eWG8xD3/DMOHyXQXhYkfg2vsc=;
        b=hMXIg15WxD7xIA40s9oqXhi+Xv55bdV5MoTiXOcpHiUNwSN0+GHbTR06bSrvIcoO6M
         pvOPgFxC2ILAD0QERgsFrCQoX3OUDBhlFTXkMcdEzVKODXS/kATRur+SSNszyNlAityi
         U6pLaUXXI/yBjCcQgJfoO36w8/0gpH1a0wB1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440322; x=1726045122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+t37x9TLIsk4O4gRZ6eWG8xD3/DMOHyXQXhYkfg2vsc=;
        b=ZKU0N3mtUynlMiaFxTfYDlUon/o2k6ndx5R9Xe9TGs96oofRnUpZuPqUD74xe9JKYF
         1i38pyWhq+al0S7Wi6BesrIb7Kfx0dJz7EMvzezfarjFh4PzeDZTL7WJgbbXqNaUEFal
         /l4ASqCEFtuigBvlPIlm6UQMCWig/IixXWNBBKOZ5D1QV6iMTmN5ViDZTNEn4zFEB4/D
         nzWyVLy2z36n4htbS7MbGvWrRPQ2K8KzfSHWknUdYzRCKrt5HQDmXGfpiDlTooA+5Gbk
         vWV+LZiKemddnPc9Z2XCtMXp3RShT+XOIXtCc4XJiqRvonKfj40Vfg4temcQsxhun6Ir
         NbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp+0yyUTVjpZgYbDKViDotphp4gtIzOFsjKMPXNaEaAYjFlTAYXn7jP1/+q9+FGRF/ivHCy+dYY+z32THwgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9jEFE/V057ofl5TEINpLVGe5/bUlbnM8j0w83CDK+D9as6AxO
	D8amgIZ6rXdbroWQcHsi6LFlNHWQptbwTAWgn2XY9VTO6afsQNzF7HhfZZORFA==
X-Google-Smtp-Source: AGHT+IGhKGqxiqy44JngHWHRLAJzqxdbahk1woNkmt3+2VUIw1+4M6eU68DZSnvt573TLX01XI6S5w==
X-Received: by 2002:a17:90a:bc9:b0:2da:50e6:5ab with SMTP id 98e67ed59e1d1-2da8f3028b9mr2329713a91.18.1725440321498;
        Wed, 04 Sep 2024 01:58:41 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da6fb086cfsm2813801a91.24.2024.09.04.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:58:41 -0700 (PDT)
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
Subject: [PATCH v6.6] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 01:58:29 -0700
Message-Id: <20240904085829.14684-1-shivani.agarwal@broadcom.com>
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
[Shivani: Modified to apply on v6.6.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 51ade909c84f..bc01f2dafa94 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2140,7 +2140,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return packets;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -2158,7 +2158,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -2177,7 +2177,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -2280,7 +2280,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
2.39.4

