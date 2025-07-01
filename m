Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DE1DE8A8
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332514; cv=none; b=pztoCdDlcKtlCLMM3bZCbs2LzAZb9vTgDvv86ucuu7O0e7TVVI2lA7e9tdZmv0x866ytTv693QLH9TNbtw3+qtOmSup3eGBkaHwMmSUMQAiENFHdj1lmceLGKfb3Ftjru7y1xxBCFkh/rJfumltEcFplRontU1FtuFegt8/lLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332514; c=relaxed/simple;
	bh=VUVsBfN9svwjFZAwqjMlXux23lDyc72bG0JSXdyitQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhvGaoZLPRYe2sexTDMkSeLZau3stUt2RvCwITwz9KT7kbyUvb7uhZgiO5eYVTOD/xU9YQ6Zu8QfV195iyOIsJrFvAHD5JYmPggYJo5il8dn48QnxM1HKLkjZONk7IeYo0hEUG/WoT7iAZDTaaWk+BMzf/IEvUuVyUbhMoaoIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxJCZAC3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxJCZAC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751332511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztKCE441E4iY+w5SsH1xNzKVblctvlPQOmwjwNGLiFI=;
	b=TxJCZAC3QGHDdRwbK8vbDzZZXbJAtSLnU3ckZqQhnrnx0fxKCysLRQtC1MMdF3sW5KRjFh
	MDUJ+WCLDe8Jvqfqw4wKj3f/2DjzMsyM6xvgL0LarWfVpNORUDgRDKLOPAOIIesE14+BRv
	WUS0+Q1qGQkps7Dl9sf1DWDo+QfCLng=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-XtNNRmT3N0WeBEmXCozKYA-1; Mon,
 30 Jun 2025 21:15:08 -0400
X-MC-Unique: XtNNRmT3N0WeBEmXCozKYA-1
X-Mimecast-MFC-AGG-ID: XtNNRmT3N0WeBEmXCozKYA_1751332506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDC1918002EC;
	Tue,  1 Jul 2025 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6F4030001B1;
	Tue,  1 Jul 2025 01:15:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	xieyongji@bytedance.com
Subject: [PATCH 9/9] vduse: switch to use virtio map API instead of DMA API
Date: Tue,  1 Jul 2025 09:14:01 +0800
Message-ID: <20250701011401.74851-10-jasowang@redhat.com>
In-Reply-To: <20250701011401.74851-1-jasowang@redhat.com>
References: <20250701011401.74851-1-jasowang@redhat.com>
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
not needed for VDUSE any more.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 31 ++++++++++++++++------------
 3 files changed, 20 insertions(+), 15 deletions(-)

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
index 64bc39722007..f86d7111e103 100644
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
2.34.1

