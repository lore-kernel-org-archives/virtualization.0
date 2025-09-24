Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF5266B6B
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697269; cv=none; b=ar0/91AU6FHOUbLSrpGkqQqAZAsLva3rfHy9suoFyYno8yZk8rPbpq7EwhwiJ7ZE1O2TxruMFhT4oWWRNmZyH4q2RfwFOzRMCwPlPP6p4mx6ewRqFH29X/zPeOxznE8mJqMfu+Xo7XIsBiCpff/UfKlkCHiKsPYgEb+ejRRkGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697269; c=relaxed/simple;
	bh=oJn6kFHaRJjo+9Rydz6db0lcwstUDlWvdDG5ca7d4TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5FPKcdAnWjn0FaECdLlw0Bf2xHu20ILy4/sLfZNA6svHY3hEb9iQyIagJKVeZZg1Al6/3Q+QC1xVpBoS1pOSOJXIpVgjnQ1j8BxXknuV7oLZfXMXdyWY23qtZHXzUSEe+ZyRKJ3zjK+rSd0yMIEGYAV+i6XwSqTO5SFEuptgis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4roRy3O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4roRy3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758697266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o92MnsX1tO2Tjt/ETqvuPKhptU7wZU1sM/64+jL2FLU=;
	b=L4roRy3OXAiWXbP5nO3yKKc0OcfmObF8lrDAp3G2VWHuQjGiJA6CLieAYQv74uJZmvcRy7
	EbD8BLAc0IsjfnC66ZC9DyIE6c+3xFZc7FhnEZ3QXY93Iux5JQr/JII9vZYTT7mgOELqU8
	GUj0+OHN3uCfN9HmlVsVNWf9WPzzkI0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-QhA-I6VKMV6Lp2a7AZIi0w-1; Wed,
 24 Sep 2025 03:01:03 -0400
X-MC-Unique: QhA-I6VKMV6Lp2a7AZIi0w-1
X-Mimecast-MFC-AGG-ID: QhA-I6VKMV6Lp2a7AZIi0w_1758697262
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02F471956094;
	Wed, 24 Sep 2025 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8819300018D;
	Wed, 24 Sep 2025 07:00:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 2/2] vduse: switch to use virtio map API instead of DMA API
Date: Wed, 24 Sep 2025 15:00:45 +0800
Message-ID: <20250924070045.10361-3-jasowang@redhat.com>
In-Reply-To: <20250924070045.10361-1-jasowang@redhat.com>
References: <20250924070045.10361-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Lacking the support of device specific mapping supported in virtio,
VDUSE must trick the DMA API in order to make virtio-vdpa transport
work. This is done by advertising vDPA device as dma device with a
VDUSE specific dma_ops even if it doesn't do DMA at all.

This will be fixed by this patch. Thanks to the new mapping operations
support by virtio and vDPA. VDUSE can simply switch to advertise its
specific mappings operations to virtio via virtio-vdpa then DMA API is
not needed for VDUSE any more and iova domain could be used as the
mapping token instead.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/Kconfig                 |  8 +--
 drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 78 ++++++++++++++--------------
 include/linux/virtio.h               |  4 ++
 5 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 559fb9d3271f..857cf288c876 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
 
 config VDPA_USER
 	tristate "VDUSE (vDPA Device in Userspace) support"
-	depends on EVENTFD && MMU && HAS_DMA
-	#
-	# This driver incorrectly tries to override the dma_ops.  It should
-	# never have done that, but for now keep it working on architectures
-	# that use dma ops
-	#
-	depends on ARCH_HAS_DMA_OPS
+	depends on EVENTFD && MMU
 	select VHOST_IOTLB
 	select IOMMU_IOVA
 	help
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 58116f89d8da..ccaed24b7ef8 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -447,7 +447,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 
 void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag, unsigned long attrs)
+				  gfp_t flag)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	unsigned long limit = domain->iova_limit;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 7f3f0928ec78..1f3c30be272a 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -64,7 +64,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 
 void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag, unsigned long attrs);
+				  gfp_t flag);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 				void *vaddr, dma_addr_t dma_addr,
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ad782d20a8ed..e7bced0b5542 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -814,59 +814,53 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.free			= vduse_vdpa_free,
 };
 
-static void vduse_dev_sync_single_for_device(struct device *dev,
+static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = token.iova_domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
 
-static void vduse_dev_sync_single_for_cpu(struct device *dev,
+static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = token.iova_domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
 
-static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
+static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = token.iova_domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
 
-static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_addr,
-				size_t size, enum dma_data_direction dir,
-				unsigned long attrs)
+static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
+				 size_t size, enum dma_data_direction dir,
+				 unsigned long attrs)
 {
-	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = token.iova_domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
 
-static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_addr, gfp_t flag,
-					unsigned long attrs)
+static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
+				      dma_addr_t *dma_addr, gfp_t flag)
 {
-	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = token.iova_domain;
 	unsigned long iova;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
 	addr = vduse_domain_alloc_coherent(domain, size,
-				(dma_addr_t *)&iova, flag, attrs);
+					   (dma_addr_t *)&iova, flag);
 	if (!addr)
 		return NULL;
 
@@ -875,31 +869,45 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 	return addr;
 }
 
-static void vduse_dev_free_coherent(struct device *dev, size_t size,
-					void *vaddr, dma_addr_t dma_addr,
-					unsigned long attrs)
+static void vduse_dev_free_coherent(union virtio_map token, size_t size,
+				    void *vaddr, dma_addr_t dma_addr,
+				    unsigned long attrs)
 {
-	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = token.iova_domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
-static size_t vduse_dev_max_mapping_size(struct device *dev)
+static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
-	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = token.iova_domain;
+
+	return dma_addr < domain->bounce_size;
+}
+
+static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
+{
+	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
+		return -ENOMEM;
+	return 0;
+}
+
+static size_t vduse_dev_max_mapping_size(union virtio_map token)
+{
+	struct vduse_iova_domain *domain = token.iova_domain;
 
 	return domain->bounce_size;
 }
 
-static const struct dma_map_ops vduse_dev_dma_ops = {
+static const struct virtio_map_ops vduse_map_ops = {
 	.sync_single_for_device = vduse_dev_sync_single_for_device,
 	.sync_single_for_cpu = vduse_dev_sync_single_for_cpu,
 	.map_page = vduse_dev_map_page,
 	.unmap_page = vduse_dev_unmap_page,
 	.alloc = vduse_dev_alloc_coherent,
 	.free = vduse_dev_free_coherent,
+	.need_sync = vduse_dev_need_sync,
+	.mapping_error = vduse_dev_mapping_error,
 	.max_mapping_size = vduse_dev_max_mapping_size,
 };
 
@@ -2003,27 +2011,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
 static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 {
 	struct vduse_vdpa *vdev;
-	int ret;
 
 	if (dev->vdev)
 		return -EEXIST;
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
-				 &vduse_vdpa_config_ops, NULL,
+				 &vduse_vdpa_config_ops, &vduse_map_ops,
 				 1, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
 	dev->vdev = vdev;
 	vdev->dev = dev;
-	vdev->vdpa.dev.dma_mask = &vdev->vdpa.dev.coherent_dma_mask;
-	ret = dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK(64));
-	if (ret) {
-		put_device(&vdev->vdpa.dev);
-		return ret;
-	}
-	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
-	vdev->vdpa.vmap.dma_dev = &vdev->vdpa.dev;
 	vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
 
 	return 0;
@@ -2056,6 +2055,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return -ENOMEM;
 	}
 
+	dev->vdev->vdpa.vmap.iova_domain = dev->domain;
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3386a4a8d06b..96c66126c074 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -41,9 +41,13 @@ struct virtqueue {
 	void *priv;
 };
 
+struct vduse_iova_domain;
+
 union virtio_map {
 	/* Device that performs DMA */
 	struct device *dma_dev;
+	/* VDUSE specific mapping data */
+	struct vduse_iova_domain *iova_domain;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.31.1

