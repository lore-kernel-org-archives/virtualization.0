Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD51B412A
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806340; cv=none; b=ohisOryDWMbW9/G2dmS4NtoPCJiE1WGioU9Dbrwf4RHX3o6OshSMW3TVCNzTU6hPCh1CGQ2WRbzKK77geGDwrlz3Z0f3tLupXRgRxW+h5/3MkKGyIkXGTIYiquC+2G/BqZ29wnOk/LhgZtVEzdrjxAuqtUao0QQt3YPciJvrkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806340; c=relaxed/simple;
	bh=/36CE0phXBG0MeOf6QLXocdFQpIS5/31UussTrs7a1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=lIuqB4FUypUUZANmzrgc3a7wZB0ZFHOgJhUvwkfRF9v+6p7Bb7yONLMYb4HgUm+lkwMjNwWZpK3Rnt0ALI8/p97PNIOsaPjcomYBD/tlPoowKQli69IzqfKBJ/Jdk9P3e32V90Eq/OKgmgHLHMbNUTHtR93UfTOFgwNm0MomPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdSk1s0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdSk1s0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752806337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvFrMdu0v43ZLfEJ1ed92+yUT7QLayELxU9kpRzone4=;
	b=MdSk1s0CO4f4OrOb0zAoe+KDbp4u31eW7IVsj6hniQInJLa/c+ig/LRV5E0sFrtXpZSsrv
	hVolEIiGP5+rzm1Y48gmZ5EOUhJxqmgJw316hpR8PTR56i0pJsVOYcm2V/cGXXyCOniC30
	17pUKDklZXfGc3ooq6cp3MNx0wL+Jao=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-aNVvWMp6NEGxRbZXK3Dm0A-1; Thu,
 17 Jul 2025 22:38:54 -0400
X-MC-Unique: aNVvWMp6NEGxRbZXK3Dm0A-1
X-Mimecast-MFC-AGG-ID: aNVvWMp6NEGxRbZXK3Dm0A_1752806333
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCA591956089;
	Fri, 18 Jul 2025 02:38:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40A4F30001B1;
	Fri, 18 Jul 2025 02:38:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 9/9] vduse: switch to use virtio map API instead of DMA API
Date: Fri, 18 Jul 2025 10:37:58 +0800
Message-ID: <20250718023758.36866-10-jasowang@redhat.com>
In-Reply-To: <20250718023758.36866-1-jasowang@redhat.com>
References: <20250718023758.36866-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eojmjAV7UnjVTFeYwivK_v-Hj29qOeyA-MPHy_vZZnw_1752806333
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Lacking the support of device specific mapping supported in virtio,
VDUSE must trick the DMA API in order to make virtio-vdpa transport
work. This is done by advertising vDPA device as dma device with a
VDUSE specific dma_ops even if it doesn't do DMA at all.

This will be fixed by this patch. Thanks to the new mapping operations
support by virtio and vDPA. VDUSE can simply switch to advertise its
specific mappings operations to virtio via virtio-vdpa then DMA API is
not needed for VDUSE any more.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/Kconfig                 |  8 +------
 drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 31 ++++++++++++++++------------
 4 files changed, 21 insertions(+), 22 deletions(-)

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
index 019f3305c0ac..8ea311692545 100644
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
index 846572b95c23..a2316571671f 100644
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
index 934c50d15b28..d858c4389cc1 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -814,51 +814,55 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.free			= vduse_vdpa_free,
 };
 
-static void vduse_dev_sync_single_for_device(struct device *dev,
+static void vduse_dev_sync_single_for_device(void *token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
+	struct device *dev = token;
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
 
-static void vduse_dev_sync_single_for_cpu(struct device *dev,
+static void vduse_dev_sync_single_for_cpu(void *token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
+	struct device *dev = token;
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
 
-static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
+static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
+	struct device *dev = token;
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
 
-static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_addr,
+static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
 				size_t size, enum dma_data_direction dir,
 				unsigned long attrs)
 {
+	struct device *dev = token;
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
 
-static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_addr, gfp_t flag,
-					unsigned long attrs)
+static void *vduse_dev_alloc_coherent(void *token, size_t size,
+				      dma_addr_t *dma_addr, gfp_t flag)
 {
+	struct device *dev = token;
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 	unsigned long iova;
@@ -866,7 +870,7 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_addr = DMA_MAPPING_ERROR;
 	addr = vduse_domain_alloc_coherent(domain, size,
-				(dma_addr_t *)&iova, flag, attrs);
+					   (dma_addr_t *)&iova, flag);
 	if (!addr)
 		return NULL;
 
@@ -875,25 +879,27 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 	return addr;
 }
 
-static void vduse_dev_free_coherent(struct device *dev, size_t size,
+static void vduse_dev_free_coherent(void *token, size_t size,
 					void *vaddr, dma_addr_t dma_addr,
 					unsigned long attrs)
 {
+	struct device *dev = token;
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
-static size_t vduse_dev_max_mapping_size(struct device *dev)
+static size_t vduse_dev_max_mapping_size(void *token)
 {
+	struct device *dev = token;
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	return domain->bounce_size;
 }
 
-static const struct dma_map_ops vduse_dev_dma_ops = {
+static const struct virtio_map_ops vduse_map_ops = {
 	.sync_single_for_device = vduse_dev_sync_single_for_device,
 	.sync_single_for_cpu = vduse_dev_sync_single_for_cpu,
 	.map_page = vduse_dev_map_page,
@@ -2009,7 +2015,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 		return -EEXIST;
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
-				 &vduse_vdpa_config_ops, NULL,
+				 &vduse_vdpa_config_ops, &vduse_map_ops,
 				 1, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
@@ -2022,7 +2028,6 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 		put_device(&vdev->vdpa.dev);
 		return ret;
 	}
-	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
 	vdev->vdpa.map_token = &vdev->vdpa.dev;
 	vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
 
-- 
2.42.0

