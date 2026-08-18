Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25C37E5C5
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087678; cv=none; b=Paj1nU/d8hZXLmHiW8BIv6Cpva+89sDycxbdvFyLUFtiu/RHv1L6nMt+9vdFGqp7ZvKzPBTwfCFc6ePNyUlvItTaaITpqw7BrBMJmrTCduMXwvUHb4+o50mFRms6R1yuFMKP5F1g1uU2/p6FaKUnyPx1gonogTl/zrc/MNUtTsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087678; c=relaxed/simple;
	bh=CXevXFcEe5yAQgDustCLZyeQtEsmuo8/JhSQAryM+Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z73MiQ0B5r8I2AG5/f7UPaLKLpMv6ihxonlfkueXCSwD6l23GVxot3E/vVaB2XLQzzChpqh0Z3xY8bDnjRRCiRnSn0e+JlaBrp27KEpwnwoKPBFoBz+7rK5PG61xLP7/XHpWcKLLMoGcWWt+5a8KmCwRMyvfhM0MtDgwcn+zO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sux4/a8T; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sux4/a8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087677; x=1818623677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7veFhxpt1ZiUHTdI8AdtWDRskJzgpE4wDktGq4tKkE=;
  b=sux4/a8TO6+0Zz8bTjOSELz6SQq8905XMpJECpSIONPgZTjt5uM2u/Td
   Qfr0K9TyFXC1ZxBCPqHNetTKQTAPelOsUvxc+vROxSAjivfVcJLouT5Z9
   /v3NhyD1+JaFHO8PW54pj8X7w3PKIENQUP0jTltE0zY1eqz61Aq+pjOSb
   xxdA8hViXTgBCr5isjRLvTIKfR478aLqyrZpIngBO3MOkJjpRKP3sIiaJ
   VfqECUDtuxiL079PH4lkiTlYbSxjOqfEd4SaM9WsU51U+6gnTVRUtgwVr
   nwe2+c4gC+0nlOwBvk0eLaQUE1KZ+athP8LBCR6kXIJLrvUgjmnN13IC7
   w==;
X-CSE-ConnectionGUID: bXMxsTsxSlaqw+WSlXctxA==
X-CSE-MsgGUID: sT4ztmkoTU657651sTj8Nw==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="26307959"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:14:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:2307]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.183:2525] with esmtp (Farcaster)
 id 7ead279c-fd53-45ab-a60b-626deb58a021; Tue, 18 Aug 2026 21:14:34 +0000 (UTC)
X-Farcaster-Flow-ID: 7ead279c-fd53-45ab-a60b-626deb58a021
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:14:34 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:14:32 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 02/12] virtio: drop the sync operations from virtio_map_ops
Date: Tue, 18 Aug 2026 21:14:15 +0000
Message-ID: <20260818211425.91009-3-graf@amazon.com>
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

With the map sync API gone, sync_single_for_cpu, sync_single_for_device
and need_sync in struct virtio_map_ops are members the virtqueue never
calls. vduse is the only implementation in the tree and provides all
three, and the next implementer has to decide what to put in them.

Drop the three members and their kernel-doc, and remove the vduse
functions that provided them. vduse_domain_bounce() stays, because
vduse_domain_map_page() and vduse_domain_unmap_page() bounce through it
as well. That way the struct asks an implementation for six operations
instead of nine.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Kiro:claude-opus-5 checkpatch
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 20 --------------
 drivers/vdpa/vdpa_user/iova_domain.h |  8 ------
 drivers/vdpa/vdpa_user/vduse_dev.c   | 40 ----------------------------
 include/linux/virtio_config.h        | 20 --------------
 4 files changed, 88 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 4dc76c0d0d13..094fe1ec02c3 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -424,26 +424,6 @@ static void vduse_domain_free_iova(struct iova_domain *iovad,
 	free_iova_fast(iovad, iova >> shift, iova_len);
 }
 
-void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domain,
-				      dma_addr_t dma_addr, size_t size,
-				      enum dma_data_direction dir)
-{
-	read_lock(&domain->bounce_lock);
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-		vduse_domain_bounce(domain, dma_addr, size, DMA_TO_DEVICE);
-	read_unlock(&domain->bounce_lock);
-}
-
-void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
-				      dma_addr_t dma_addr, size_t size,
-				      enum dma_data_direction dir)
-{
-	read_lock(&domain->bounce_lock);
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
-	read_unlock(&domain->bounce_lock);
-}
-
 dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 				 struct page *page, unsigned long offset,
 				 size_t size, enum dma_data_direction dir,
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index e50e55d1396f..66f14764a5db 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -48,14 +48,6 @@ int vduse_domain_set_map(struct vduse_iova_domain *domain,
 void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 			    struct vhost_iotlb *iotlb);
 
-void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domain,
-				      dma_addr_t dma_addr, size_t size,
-				      enum dma_data_direction dir);
-
-void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
-				      dma_addr_t dma_addr, size_t size,
-				      enum dma_data_direction dir);
-
 dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 				 struct page *page, unsigned long offset,
 				 size_t size, enum dma_data_direction dir,
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 10dcf016bfb0..7a1a344539b8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -932,34 +932,6 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.free			= vduse_vdpa_free,
 };
 
-static void vduse_dev_sync_single_for_device(union virtio_map token,
-					     dma_addr_t dma_addr, size_t size,
-					     enum dma_data_direction dir)
-{
-	struct vduse_iova_domain *domain;
-
-	if (!token.group)
-		return;
-
-	guard(vq_group_as_read_lock)(token.group);
-	domain = token.group->as->domain;
-	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
-}
-
-static void vduse_dev_sync_single_for_cpu(union virtio_map token,
-					     dma_addr_t dma_addr, size_t size,
-					     enum dma_data_direction dir)
-{
-	struct vduse_iova_domain *domain;
-
-	if (!token.group)
-		return;
-
-	guard(vq_group_as_read_lock)(token.group);
-	domain = token.group->as->domain;
-	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
-}
-
 static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
@@ -1037,15 +1009,6 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 	free_pages_exact(vaddr, size);
 }
 
-static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
-{
-	if (!token.group)
-		return false;
-
-	guard(vq_group_as_read_lock)(token.group);
-	return dma_addr < token.group->as->domain->bounce_size;
-}
-
 static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 {
 	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
@@ -1063,13 +1026,10 @@ static size_t vduse_dev_max_mapping_size(union virtio_map token)
 }
 
 static const struct virtio_map_ops vduse_map_ops = {
-	.sync_single_for_device = vduse_dev_sync_single_for_device,
-	.sync_single_for_cpu = vduse_dev_sync_single_for_cpu,
 	.map_page = vduse_dev_map_page,
 	.unmap_page = vduse_dev_unmap_page,
 	.alloc = vduse_dev_alloc_coherent,
 	.free = vduse_dev_free_coherent,
-	.need_sync = vduse_dev_need_sync,
 	.mapping_error = vduse_dev_mapping_error,
 	.max_mapping_size = vduse_dev_max_mapping_size,
 };
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..eb38c876a628 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -157,16 +157,6 @@ struct virtio_config_ops {
  *      size: the buffer size
  *      dir: mapping direction
  *      attrs: unmapping attributes
- * @sync_single_for_cpu: sync a single buffer from device to cpu
- *      map: metadata for performing mapping
- *      map_handle: the mapping address to sync
- *      size: the size of the buffer
- *      dir: synchronization direction
- * @sync_single_for_device: sync a single buffer from cpu to device
- *      map: metadata for performing mapping
- *      map_handle: the mapping address to sync
- *      size: the size of the buffer
- *      dir: synchronization direction
  * @alloc: alloc a coherent buffer mapping
  *      map: metadata for performing mapping
  *      size: the size of the buffer
@@ -179,10 +169,6 @@ struct virtio_config_ops {
  *      vaddr: virtual address of the buffer
  *      map_handle: the mapping address that needs to be freed
  *      attrs: unmapping attributes
- * @need_sync: if the buffer needs synchronization
- *      map: metadata for performing mapping
- *      map_handle: the mapped address
- *      Returns whether the buffer needs synchronization
  * @mapping_error: if the mapping address is error
  *      map: metadata for performing mapping
  *      map_handle: the mapped address
@@ -197,16 +183,10 @@ struct virtio_map_ops {
 	void (*unmap_page)(union virtio_map map, dma_addr_t map_handle,
 			   size_t size, enum dma_data_direction dir,
 			   unsigned long attrs);
-	void (*sync_single_for_cpu)(union virtio_map map, dma_addr_t map_handle,
-				    size_t size, enum dma_data_direction dir);
-	void (*sync_single_for_device)(union virtio_map map,
-				       dma_addr_t map_handle, size_t size,
-				       enum dma_data_direction dir);
 	void *(*alloc)(union virtio_map map, size_t size,
 		       dma_addr_t *map_handle, gfp_t gfp);
 	void (*free)(union virtio_map map, size_t size, void *vaddr,
 		     dma_addr_t map_handle, unsigned long attrs);
-	bool (*need_sync)(union virtio_map map, dma_addr_t map_handle);
 	int (*mapping_error)(union virtio_map map, dma_addr_t map_handle);
 	size_t (*max_mapping_size)(union virtio_map map);
 };
