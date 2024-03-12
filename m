Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56973FBA0
	for <virtualization@lists.linux.dev>; Tue, 12 Mar 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214576; cv=none; b=R6SjUQXoUGorlCCtuYZnsJAg8De+je3njUd33LESU0JHgy91gz/lt2iqvUXvq8CzwRcJoI2UUXoLKx6XvAC/1eUSOd2SKDP+SDF9b5b0/C8yQQ+4RPX5Ap72KSULql0yvcUvDW/wvQMEOx283kQB1aAhIQ5gv5lBLsoAOYRHvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214576; c=relaxed/simple;
	bh=fp/MotJROp/H4WrRMICPwFhFJNHO55PHNY0TiiTypQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sooIPzZOfjqjNPY2K0pkErvQ6PwbK5f3sF2N5K5AxFMZRjRF8g1r3Ler6A5JRJUYk7LDBSDa5kB2Mu00SuSH8ieHZjaR6pGRhMt/aZzRfn3Mb5e1gGp5p1rKhst4OlLtb5ek6KSbAsUO4fCsulV0Fp0chqIBqPvdh8aoKY4z+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AHTIaNA5; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AHTIaNA5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710214567; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ny61D4SKhBzL/Bg5IqcXxzUjRCAEekZ6D79qv0EtkN8=;
	b=AHTIaNA52IpsHsQCRFJOH0EGwvnE8pQ+1fc3qCL61xNbrpC/lCqf7lIg7uzRvPcbh4knQ8SI13WX3Nrnj+BVDlFy9CsEnK2dltuWpfqjh7mk5bXWO4Uj+1so5YqO+f/4LdpHo07L5B0f9gCR98qXiN6l2LW7eBr4f/xZ64olBd0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W2KFrEL_1710214565;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2KFrEL_1710214565)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 11:36:06 +0800
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
Subject: [PATCH vhost v4 08/10] virtio_ring: export premapped to driver by struct virtqueue
Date: Tue, 12 Mar 2024 11:35:55 +0800
Message-Id: <20240312033557.6351-9-xuanzhuo@linux.alibaba.com>
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

Export the premapped to drivers, then drivers can check
the vq premapped mode after the find_vqs().
Because the find_vqs() just try to enable the vq premapped mode,
the driver must check that after find_vqs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 13 +++++--------
 include/linux/virtio.h       |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 538940ede46a..34f4b2c0c31e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -191,9 +191,6 @@ struct vring_virtqueue {
 	/* Host publishes avail event idx */
 	bool event;
 
-	/* Do DMA mapping by driver */
-	bool premapped;
-
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -311,7 +308,7 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 
 static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
 {
-	return vring->use_dma_api && !vring->premapped;
+	return vring->use_dma_api && !vring->vq.premapped;
 }
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev)
@@ -383,7 +380,7 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
 {
-	if (vq->premapped) {
+	if (vq->vq.premapped) {
 		*addr = sg_dma_address(sg);
 		return 0;
 	}
@@ -2157,7 +2154,7 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2705,7 +2702,7 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 #endif
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2841,7 +2838,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	vq->premapped = true;
+	vq->vq.premapped = true;
 
 	if (vq->packed_ring) {
 		kfree(vq->packed.desc_dma);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..407277d5a16b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -36,6 +36,7 @@ struct virtqueue {
 	unsigned int num_free;
 	unsigned int num_max;
 	bool reset;
+	bool premapped;
 	void *priv;
 };
 
-- 
2.32.0.3.g01195cf9f

