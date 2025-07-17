Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4327A445
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739408; cv=none; b=GCRUMeVmlkBV3SdVWqJQ78vrXvGbCxxlBtg6iTGj4WwiGi4vq7O211H2b8TMv0+U2JXONvxQ9YJRuyza8tVXBKKWFzI1pFd3H8TWquefA8EM/rVXyjVaYwyeGN6BdtGFFgGGpDYX1wex4rdx1nn2BX9Pa7QPwPdKJicSxNmNBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739408; c=relaxed/simple;
	bh=lL589PvPT4KTfflVdVUyQv7x8p3JUceecWC3WMMq10g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rBvo0MbzN67dR0tc06SsKs4uxQlVBIV10JFNrmfguf2WBTsrwqcAYDI2pR4TQDC0oVHBjX923w0FBwyBtdRWvHl9P7yTOY3e90wakz84ZbAvDtsIdFd4HctIqvZWeP4JpHXuBR6cKVtnWIO1YQvPFQYGEmv+bB6r7LP9pggKDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/o8411P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/o8411P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752739406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9ljCXt9se2XE7TI+aqXqlzZ/C1Iw+R4FGL6HTIhv/U=;
	b=U/o8411P3GOEXnbnoPKUadHS5N4ISyL0GHV/C8nmyeoFK7w8ocSakKqnu/Y8jfF1MgGzj3
	HLu9YkpY/SIpyJsnfRZd+QT2cnCbUoKNZidav62RLAjvJHc4BYcGlityodN7Kq0YdS2dF4
	lUHKHD309aWq5Fnr3/qPlE1OMCFCOz8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-9AWOA7HkPHOBfKPPWlOUDA-1; Thu,
 17 Jul 2025 04:03:22 -0400
X-MC-Unique: 9AWOA7HkPHOBfKPPWlOUDA-1
X-Mimecast-MFC-AGG-ID: 9AWOA7HkPHOBfKPPWlOUDA_1752739401
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 584AD19560A2;
	Thu, 17 Jul 2025 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27EDA1956089;
	Thu, 17 Jul 2025 08:03:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org
Subject: [PATCH V2 9/9] vduse: switch to use virtio map API instead of DMA API
Date: Thu, 17 Jul 2025 16:02:37 +0800
Message-ID: <20250717080237.6518-10-jasowang@redhat.com>
In-Reply-To: <20250717080237.6518-1-jasowang@redhat.com>
References: <20250717080237.6518-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pkz4rnIrG35zWgV2DZJ9hYo5aEXZnSSrezpsTXa5EwY_1752739401
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
2.47.3

