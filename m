Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33B36A34D
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087677; cv=none; b=AqDmSNz5ICpyCCjGOuauv6na3qjTbPYiAtR8Pq5d1e2d2A5GdgnX2WdKphEPvmjSU/t/R3pOG7+EY7NoFtNB5pIjeqjaC/7KEwPUmkth0Miw/xf5F3dhhsrn+VKa23R6uMQBqZKi4Brvul8Tnuc9djyCc8P3K54qBgqTpkmeR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087677; c=relaxed/simple;
	bh=sQ4O2jTkJyVANwguPKTX7uSE+0uEUWAyONehAUPRYKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ra9CiLHQ8WIYSiFe89L5TWrqACVf48CUDJ3V5Ul6KeyJ4+HLcEptWxyK5auJstyJj2s4CDDCSDb7E/iWdIitQM/F6CRopqdVTgDRi+5NIS9pwdoyf9TiHyNdoLYxrwLcusGxZjq+fRC/5glnPGFQ5OFSzROowlYu7CgdzcsjiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ug/AE7Jz; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ug/AE7Jz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087675; x=1818623675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eBm0I6pljeRS5P8NSJP3GZxfiYJqndB1Fee3unaYmjY=;
  b=Ug/AE7Jz930pwO2Kb+aNV/d4lQAEcEk7PkEToxTNTFhb7IsakI8c8xHj
   2wq7e3wFHgkj2T2092CW7/1c+o+FqEn2LmU0CbQGlyaZawauX6tmE7luM
   2wPQaL6mN8WX/MrjRxEV6d9BxJGzBWbpZ2rgO43GVWi031g+lMI9DoqMs
   1MKklNYimOdKt8li+wuggv+x/v0X9IFKfDjpkf+jB2SGprQjTl5kRC5yS
   Tg5BZH5crXUqcR2deLCqahOKbUDIIf3pNkfaNswLhiTeWhYEOoZjfWw0S
   OhN4d8ob1isXaTWtAW+inUfePI7OWt1TTtUsobbzgK04IYFRhmqHWTVSA
   g==;
X-CSE-ConnectionGUID: P9Kxuw+ZRmaJ+4Kbo/mksg==
X-CSE-MsgGUID: JwaPAgBfS4+kT/8inOXy7w==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="26314366"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:14:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:2070]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.40:2525] with esmtp (Farcaster)
 id e23a89a7-918c-4ef9-bb7e-5436830d62c0; Tue, 18 Aug 2026 21:14:33 +0000 (UTC)
X-Farcaster-Flow-ID: e23a89a7-918c-4ef9-bb7e-5436830d62c0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:14:32 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:14:30 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Parav
 Pandit" <parav@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: [PATCH v2 01/12] virtio_ring: remove the unused map sync API
Date: Tue, 18 Aug 2026 21:14:14 +0000
Message-ID: <20260818211425.91009-2-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260818211425.91009-1-graf@amazon.com>
References: <20260818211425.91009-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

virtqueue_map_need_sync(), virtqueue_map_sync_single_range_for_cpu() and
virtqueue_map_sync_single_range_for_device() are exported, but no driver
in the tree calls them. They are the only path into the sync members of
struct virtio_map_ops, so whoever implements that struct next has to
decide what those members do with no caller to learn it from.

Remove the three functions, their prototypes and their exports, and the
DMA sync shims that the virtio userspace harness kept for them. With
this, virtio_ring no longer exports a way to sync a mapping.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Kiro:claude-opus-5 checkpatch
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio_ring.c     | 89 --------------------------------
 include/linux/virtio.h           |  8 ---
 tools/virtio/linux/dma-mapping.h |  7 ---
 3 files changed, 104 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b438dc2ce1b8..ea8e774b6d8e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3890,94 +3890,5 @@ int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
 
-/**
- * virtqueue_map_need_sync - check a dma address needs sync
- * @_vq: the struct virtqueue we're talking about.
- * @addr: DMA address
- *
- * Check if the dma address mapped by the virtqueue_map_* APIs needs to be
- * synchronized
- *
- * return bool
- */
-bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
-{
-	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
-
-	if (!vq->use_map_api)
-		return false;
-
-	if (vdev->map)
-		return vdev->map->need_sync(vq->map, addr);
-	else
-		return dma_need_sync(vring_dma_dev(vq), addr);
-}
-EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
-
-/**
- * virtqueue_map_sync_single_range_for_cpu - map sync for cpu
- * @_vq: the struct virtqueue we're talking about.
- * @addr: DMA address
- * @offset: DMA address offset
- * @size: buf size for sync
- * @dir: DMA direction
- *
- * Before calling this function, use virtqueue_map_need_sync() to confirm that
- * the DMA address really needs to be synchronized
- *
- */
-void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
-					     dma_addr_t addr,
-					     unsigned long offset, size_t size,
-					     enum dma_data_direction dir)
-{
-	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
-
-	if (!vq->use_map_api)
-		return;
-
-	if (vdev->map)
-		vdev->map->sync_single_for_cpu(vq->map,
-					       addr + offset, size, dir);
-	else
-		dma_sync_single_range_for_cpu(vring_dma_dev(vq),
-					      addr, offset, size, dir);
-}
-EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_cpu);
-
-/**
- * virtqueue_map_sync_single_range_for_device - map sync for device
- * @_vq: the struct virtqueue we're talking about.
- * @addr: DMA address
- * @offset: DMA address offset
- * @size: buf size for sync
- * @dir: DMA direction
- *
- * Before calling this function, use virtqueue_map_need_sync() to confirm that
- * the DMA address really needs to be synchronized
- */
-void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
-						dma_addr_t addr,
-						unsigned long offset, size_t size,
-						enum dma_data_direction dir)
-{
-	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
-
-	if (!vq->use_map_api)
-		return;
-
-	if (vdev->map)
-		vdev->map->sync_single_for_device(vq->map,
-						  addr + offset,
-						  size, dir);
-	else
-		dma_sync_single_range_for_device(vring_dma_dev(vq), addr,
-						 offset, size, dir);
-}
-EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
-
 MODULE_DESCRIPTION("Virtio ring implementation");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 93e573c56563..3122fc52a7c3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -312,14 +312,6 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
 				      unsigned long attrs);
 int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
 
-bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
-void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
-					     unsigned long offset, size_t size,
-					     enum dma_data_direction dir);
-void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
-						unsigned long offset, size_t size,
-						enum dma_data_direction dir);
-
 #ifdef CONFIG_VIRTIO_DEBUG
 void virtio_debug_device_init(struct virtio_device *dev);
 void virtio_debug_device_exit(struct virtio_device *dev);
diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
index b9fc5e8338e3..eae160ce7142 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -36,16 +36,9 @@ enum dma_data_direction {
 
 #define sg_dma_address(sg) (0)
 #define sg_dma_len(sg) (0)
-#define dma_need_sync(v, a) (0)
 #define dma_unmap_single_attrs(d, a, s, r, t) do { \
 	(void)(d); (void)(a); (void)(s); (void)(r); (void)(t); \
 } while (0)
-#define dma_sync_single_range_for_cpu(d, a, o, s, r) do { \
-	(void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
-} while (0)
-#define dma_sync_single_range_for_device(d, a, o, s, r) do { \
-	(void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
-} while (0)
 #define dma_max_mapping_size(...) SIZE_MAX
 
 /*
