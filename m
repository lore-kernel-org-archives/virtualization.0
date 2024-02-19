Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72614446AD
	for <virtualization@lists.linux.dev>; Mon, 19 Feb 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362392; cv=none; b=JEi+mfOxqc/xakYl0AmsOjy7fK0dGVIcVnY4e1OT6iY/QomMPsFYioEaVVWMOUXF3PfgOr+HsbJxhwPhi1XoCDkWyJGUJxDbt8UQ052YHzlZCrEMkcFDXjS4kjKdK2iv5Uxe+P2jbl6/FJV+IHFT3+nnP1byNFnW94Yde3djtNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362392; c=relaxed/simple;
	bh=fZ2d/O8CXx/zfhB3r9fEfF8ZYXaxYaSpaL7xiQcTgE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rX5jPpj4qkS6WBmx5JTC1nwvvQoLD5GlM9PWOTfdY/inb9qzq9vidOUzzUS40TaUHKikESbs9DxlSq5nZ5z6NRMVyP+E9VeExyVMOaT6Hhw8kMJB0ZEOxGyOjG8QeuM5whfI5EmaWHz1Ui9VU5bj9aKb0b1zmsFIEZFMwZvuWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ei3/lhSP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei3/lhSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708362389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S21g+iuM5V51KZv+tPhGk9U1eIXrbnWFmHjIoHqqoA8=;
	b=Ei3/lhSP/nWmdl8QGVeRDyisIq5sDBmKM/y/3/HvWTM/TTUjjeOjrP8MaU7DOZtSGilteF
	Z13Mn3+2vCkwu0XRsgpwq8XjPPbSD5ExyI+1EGxKdK5hWvHEtzIdT0SNbcZEA3Rk7CTgpM
	2F7SZcyOFDvzMLAFAk7aNMBt0eon/dM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_nrqxU57M7KIOQonqX4PUQ-1; Mon,
 19 Feb 2024 12:06:17 -0500
X-MC-Unique: _nrqxU57M7KIOQonqX4PUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D59C01C0BA43;
	Mon, 19 Feb 2024 17:06:16 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE7031C060B3;
	Mon, 19 Feb 2024 17:06:13 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	brauner@kernel.org,
	lstoakes@gmail.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	david.marchand@redhat.com,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vduse: implement DMA sync callbacks
Date: Mon, 19 Feb 2024 18:06:06 +0100
Message-ID: <20240219170606.587290-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Since commit 295525e29a5b ("virtio_net: merge dma
operations when filling mergeable buffers"), VDUSE device
require support for DMA's .sync_single_for_cpu() operation
as the memory is non-coherent between the device and CPU
because of the use of a bounce buffer.

This patch implements both .sync_single_for_cpu() and
.sync_single_for_device() callbacks, and also skip bounce
buffer copies during DMA map and unmap operations if the
DMA_ATTR_SKIP_CPU_SYNC attribute is set to avoid extra
copies of the same buffer.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 27 ++++++++++++++++++++++++---
 drivers/vdpa/vdpa_user/iova_domain.h |  8 ++++++++
 drivers/vdpa/vdpa_user/vduse_dev.c   | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 5e4a77b9bae6..791d38d6284c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -373,6 +373,26 @@ static void vduse_domain_free_iova(struct iova_domain *iovad,
 	free_iova_fast(iovad, iova >> shift, iova_len);
 }
 
+void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir)
+{
+	read_lock(&domain->bounce_lock);
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		vduse_domain_bounce(domain, dma_addr, size, DMA_TO_DEVICE);
+	read_unlock(&domain->bounce_lock);
+}
+
+void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir)
+{
+	read_lock(&domain->bounce_lock);
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
+	read_unlock(&domain->bounce_lock);
+}
+
 dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 				 struct page *page, unsigned long offset,
 				 size_t size, enum dma_data_direction dir,
@@ -393,7 +413,8 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 	if (vduse_domain_map_bounce_page(domain, (u64)iova, (u64)size, pa))
 		goto err_unlock;
 
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		vduse_domain_bounce(domain, iova, size, DMA_TO_DEVICE);
 
 	read_unlock(&domain->bounce_lock);
@@ -411,9 +432,9 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 			     enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->stream_iovad;
-
 	read_lock(&domain->bounce_lock);
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
 		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
 
 	vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 173e979b84a9..f92f22a7267d 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -44,6 +44,14 @@ int vduse_domain_set_map(struct vduse_iova_domain *domain,
 void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 			    struct vhost_iotlb *iotlb);
 
+void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir);
+
+void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir);
+
 dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 				 struct page *page, unsigned long offset,
 				 size_t size, enum dma_data_direction dir,
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1d24da79c399..75354ce186a1 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -798,6 +798,26 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.free			= vduse_vdpa_free,
 };
 
+static void vduse_dev_sync_single_for_device(struct device *dev,
+					     dma_addr_t dma_addr, size_t size,
+					     enum dma_data_direction dir)
+{
+	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_iova_domain *domain = vdev->domain;
+
+	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
+}
+
+static void vduse_dev_sync_single_for_cpu(struct device *dev,
+					     dma_addr_t dma_addr, size_t size,
+					     enum dma_data_direction dir)
+{
+	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_iova_domain *domain = vdev->domain;
+
+	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
+}
+
 static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
@@ -858,6 +878,8 @@ static size_t vduse_dev_max_mapping_size(struct device *dev)
 }
 
 static const struct dma_map_ops vduse_dev_dma_ops = {
+	.sync_single_for_device = vduse_dev_sync_single_for_device,
+	.sync_single_for_cpu = vduse_dev_sync_single_for_cpu,
 	.map_page = vduse_dev_map_page,
 	.unmap_page = vduse_dev_unmap_page,
 	.alloc = vduse_dev_alloc_coherent,
-- 
2.43.0

