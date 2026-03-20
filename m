Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A531A045
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773970541; cv=none; b=EZx0zhaSr8k/ao79t2Ci7Tw/0lX8EBKGwaaZqOxU9wHfWRgg9sdOCX3zXrOTGBKMyc/mEtT7XRq9jfyjD9Wfx4k9ExURe8kxoTBYLAumt0BE3NTXFCvUrz8A2pgDhRkXhnfy/VbBXpWzt5XegKanJ/y09YzYnlZPGJKP8PdbFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773970541; c=relaxed/simple;
	bh=VkRQdVuBJATzzzZhpZR3rhJXQQ7erJTIEDbMp4KTufc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpFKiMpE6vyYe9nu+r6Km00Xnn2eQ9nmaBAMArfEMh76TBVJWx1DGShB1OiBdbi4+Kclq5+uB+CyPxuINTIRKl8QkdYOU1k4lXyEM3Fn9DYOSnV9xXMS9LMF/+lBCVUP+ucNTniZvHONLbb8SQVqKFnaXB452EtBLrZiuc3SiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bt9Lpbyd; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bt9Lpbyd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773970532; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FeQQv6rGFps7zJrCnlqon+i7LcIT7xaD3R6sIA0LYi0=;
	b=bt9LpbydXUZqSuuqKduZsCwSN+Gy0znDUi8G8ZGVxGaCRQwEOq7gthqml6zi26F+6rwys6UVQjgf6d5kFm+d46JamJaB/4eEfQdlVcWuETlu2sBfvrlcHxlPjqD0Z2uKJhC08+hjp44VM3eM75ziyDc2hsDOkVuijpvzcK4pVrQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X.Jl-Yj_1773970531;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.Jl-Yj_1773970531 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 09:35:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
	virtualization@lists.linux.dev
Subject: [PATCH net] virtio-net: correct DMA unmap vq mismatch in virtnet_xsk_pool_enable()
Date: Fri, 20 Mar 2026 09:35:31 +0800
Message-Id: <20260320013531.36931-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: d2e7c67b4765
Content-Transfer-Encoding: 8bit

When enabling the XSK pool, the header DMA address is mapped against
the send queue's virtqueue (sq->vq). However, the error handling path
incorrectly attempts to unmap it against the receive queue's virtqueue
(rq->vq).

Ensure the unmap operation uses the same virtqueue used for mapping to
maintain DMA API consistency.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..7c6f304b7be5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5917,7 +5917,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
-	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
+	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
 				     DMA_TO_DEVICE, 0);
 err_free_buffs:
 	kvfree(rq->xsk_buffs);
-- 
2.32.0.3.g01195cf9f

