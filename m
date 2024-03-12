Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6A1CA8F
	for <virtualization@lists.linux.dev>; Tue, 12 Mar 2024 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214571; cv=none; b=FWlvorj1oe8E//Vpl7n2t2f8s7VlphHV0sw7yddtL+N4/EPQKBYQjb+ux8J5nyfhSXpcQRaDEJYcdPiWpnuKs5sxn0f+ZWgxBLKZCBZgqUkb7K38FA37bXFfuxYo5Zd+xuA1O8WmyObH77qm+0gbu1d2940UvcE0+0+jMtiIfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214571; c=relaxed/simple;
	bh=tGkSVsVmj8YopHU3WBRt3AOWtWjt1Cz1snoWIt9PVxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQ+3k7Nr5qhVgNdHBYtmEmC6u483wJkBAjQyXDdSOxIEPuRg4/qsyWNXoobfaHCbhFFXmQly5WgyGcUMgUjE1NiMxDMfoqpElssYb6In5QWzOrRsC3lZzALDHU3JJIkWTOEvoZb8W/b9/yIEEw2eX50oz5ijFAzQvL0cgf7Nngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yqz2gK4M; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yqz2gK4M"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710214567; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7B472aPqcsRyDZlJcBwSfB84mkrZ8jOUT5VBX0yQkwE=;
	b=Yqz2gK4Ma8aWOBBxB79F9xzofaHnnWDoL1FWZfLTNyufCVfGGXi1Ov48ZxZL5H7YvLJFhp4GXjEg1CZmOIxuKKzE4GOYxEVedhtjvIVMxhDEKFPWZC8rrmD408z46aVxRwu9C2pGGYCcGcLGRxZbiYXYD4Hlvf3n1TOtsPKtyc8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W2KFrDu_1710214565;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2KFrDu_1710214565)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 11:36:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v4 07/10] virtio: find_vqs: add new parameter premapped
Date: Tue, 12 Mar 2024 11:35:54 +0800
Message-Id: <20240312033557.6351-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 89bc1d4948eb
Content-Transfer-Encoding: 8bit

If the premapped mode is enabled, the dma array(struct vring_desc_dma) of
virtio core will not be allocated. That is judged when find_vqs() is
called. To avoid allocating dma array in find_vqs() and releasing it
immediately by virtqueue_set_dma_premapped(). This patch introduces a
new parameter to find_vqs(). Then we can judge should we allocate the
dma array(struct vring_desc_dma) or not inside find_vqs().

The driver must check the premapped mode of every vq after find_vqs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c  | 4 ++--
 include/linux/virtio_config.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f5a72d22c838..538940ede46a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2157,7 +2157,7 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
+	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2705,7 +2705,7 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 #endif
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
+	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index d47188303d34..f1f62e57f395 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -107,6 +107,7 @@ struct virtio_vq_config {
 	vq_callback_t **callbacks;
 	const char **names;
 	const bool *ctx;
+	const bool *premapped;
 	struct irq_affinity *desc;
 };
 
-- 
2.32.0.3.g01195cf9f

