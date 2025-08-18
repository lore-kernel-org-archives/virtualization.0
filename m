Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D23093C6
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507460; cv=none; b=MbpopEpUOAU7hje06xBkemT950seS0KZ2iwCW5pAoLEjfuv+lmnwjbSQ7MvTCaYWc84DqESc37qnXGBn7Os7TB8OI9N9sumZneLkMYrbxKSz+NcZfDxo5hoUvoABPU1BbceXPJnFwBWgLLNR7crTjJ8DVsNARFBEKwku8U9b8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507460; c=relaxed/simple;
	bh=usLxxLCW1qadP/ouGgiHlbKdjEzjAq87u4VZ8+i0TZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7hcs7BIkDLKWHL/28KSc9aXNNnxRN6e5cViUK4Pk/e3C3txGeMtemeTVpDzvNKc+fDWwR9CSpL1AmvTYj26wleMXh4c2TWCoIC+YYpbmPfX1ziTPhBmdoCC4qc41jRD/MMkvoRRTAZfceKy/meDN6myYJZ25OozItSN/SAW8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqPw2orn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqPw2orn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755507456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2Z2NV/NWbWOP0kVy/5ym3JJhAbGWPlFBi1uAM5sl6o=;
	b=iqPw2ornGEcHsfXVG88Ym5J+6dZS+L9TimLyLMa9O++ODbCZ5zO3vRCAcjL1Ri724pNzvJ
	20ZpA8nDfXj7pq12BG+fSJW7FjC7uvHQr+J7+Um9On6Iw7Py8dF5ZpA6Il8jpRLIeXWFrX
	B5pRYzLnjHHL15qyOZLNbIhEnARWThE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-1e-QIgacMlCx5tRx79SBdA-1; Mon,
 18 Aug 2025 04:57:32 -0400
X-MC-Unique: 1e-QIgacMlCx5tRx79SBdA-1
X-Mimecast-MFC-AGG-ID: 1e-QIgacMlCx5tRx79SBdA_1755507451
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F394180045C;
	Mon, 18 Aug 2025 08:57:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6244A180028A;
	Mon, 18 Aug 2025 08:57:27 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC v3 3/7] vdpa: change map_token from void * to an empty struct
Date: Mon, 18 Aug 2025 10:57:07 +0200
Message-ID: <20250818085711.3461758-4-eperezma@redhat.com>
In-Reply-To: <20250818085711.3461758-1-eperezma@redhat.com>
References: <20250818085711.3461758-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Proposal to make it type safe, never casting to void, but allow the
backend to use whatever struct it needs.

Next patches will move the token from a domain to a custom struct.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.h |  1 +
 drivers/vdpa/vdpa_user/vduse_dev.c   | 60 ++++++++++++++++------------
 drivers/virtio/virtio_ring.c         |  6 ++-
 include/linux/virtio.h               |  8 +++-
 include/linux/virtio_config.h        | 34 +++++++++-------
 5 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 1f3c30be272a..c0f97dfaf94f 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -26,6 +26,7 @@ struct vduse_bounce_map {
 };
 
 struct vduse_iova_domain {
+	struct vring_mapping_opaque token;
 	struct iova_domain stream_iovad;
 	struct iova_domain consistent_iovad;
 	struct vduse_bounce_map *bounce_maps;
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e42d14888ca2..e3c8fc1aa446 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -164,6 +164,11 @@ static inline struct vduse_dev *dev_to_vduse(struct device *dev)
 	return vdpa_to_vduse(vdpa);
 }
 
+static struct vduse_iova_domain *vduse_token_to_domain(struct vring_mapping_opaque *token)
+{
+	return container_of(token, struct vduse_iova_domain, token);
+}
+
 static struct vduse_dev_msg *vduse_find_msg(struct list_head *head,
 					    uint32_t request_id)
 {
@@ -854,47 +859,50 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.free			= vduse_vdpa_free,
 };
 
-static void vduse_dev_sync_single_for_device(void *token,
+static void vduse_dev_sync_single_for_device(struct vring_mapping_opaque *token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
 
-static void vduse_dev_sync_single_for_cpu(void *token,
-					     dma_addr_t dma_addr, size_t size,
-					     enum dma_data_direction dir)
+static void vduse_dev_sync_single_for_cpu(struct vring_mapping_opaque *token,
+					  dma_addr_t dma_addr, size_t size,
+					  enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
 
-static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
+static dma_addr_t vduse_dev_map_page(struct vring_mapping_opaque *token,
+				     struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
 
-static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
-				size_t size, enum dma_data_direction dir,
-				unsigned long attrs)
+static void vduse_dev_unmap_page(struct vring_mapping_opaque *token,
+				 dma_addr_t dma_addr, size_t size,
+				 enum dma_data_direction dir,
+				 unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
 
-static void *vduse_dev_alloc_coherent(void *token, size_t size,
-				      dma_addr_t *dma_addr, gfp_t flag)
+static void *vduse_dev_alloc_coherent(struct vring_mapping_opaque *token,
+				      size_t size, dma_addr_t *dma_addr,
+				      gfp_t flag)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 	unsigned long iova;
 	void *addr;
 
@@ -909,32 +917,34 @@ static void *vduse_dev_alloc_coherent(void *token, size_t size,
 	return addr;
 }
 
-static void vduse_dev_free_coherent(void *token, size_t size,
-				    void *vaddr, dma_addr_t dma_addr,
-				    unsigned long attrs)
+static void vduse_dev_free_coherent(struct vring_mapping_opaque *token,
+				    size_t size, void *vaddr,
+				    dma_addr_t dma_addr, unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
-static bool vduse_dev_need_sync(void *token, dma_addr_t dma_addr)
+static bool vduse_dev_need_sync(struct vring_mapping_opaque *token,
+				dma_addr_t dma_addr)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 
 	return dma_addr < domain->bounce_size;
 }
 
-static int vduse_dev_mapping_error(void *token, dma_addr_t dma_addr)
+static int vduse_dev_mapping_error(struct vring_mapping_opaque *token,
+				   dma_addr_t dma_addr)
 {
 	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
 		return -ENOMEM;
 	return 0;
 }
 
-static size_t vduse_dev_max_mapping_size(void *token)
+static size_t vduse_dev_max_mapping_size(struct vring_mapping_opaque *token)
 {
-	struct vduse_iova_domain *domain = token;
+	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
 
 	return domain->bounce_size;
 }
@@ -2103,7 +2113,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return -ENOMEM;
 	}
 
-	dev->vdev->vdpa.mapping_token.token = dev->domain;
+	dev->vdev->vdpa.mapping_token.token = &dev->domain->token;
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fc0f5faa8523..4fc588458b23 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -349,8 +349,12 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
 
 	if (vring_use_map_api(vdev)) {
 		if (vdev->map)
+			/*
+			 * TODO we should be able to get the token here, not
+			 * cast to void
+			 */
 			max_segment_size =
-				vdev->map->max_mapping_size(vdev->dev.parent);
+				vdev->map->max_mapping_size((void *)vdev->dev.parent);
 		else
 			max_segment_size =
 				dma_max_mapping_size(vdev->dev.parent);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ceca93348aed..c446c511b8c1 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -40,11 +40,17 @@ struct virtqueue {
 	void *priv;
 };
 
+/*
+ * Base struct for the transport specific token used for doing map.
+ * It allows to convert between the transport specific type to the mapping
+ * token with a valud type always.
+ */
+struct vring_mapping_opaque {};
 union vring_mapping_token {
 	/* Device that performs DMA */
 	struct device *dma_dev;
 	/* Transport specific token used for doing map */
-	void *token;
+	struct vring_mapping_opaque *token;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4566ac87feb7..02d98fb1309c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -191,24 +191,28 @@ struct virtio_config_ops {
  *      Returns: the maximum buffer size that can be mapped
  */
 struct virtio_map_ops {
-	dma_addr_t (*map_page)(void *token, struct page *page,
-			       unsigned long offset, size_t size,
-			       enum dma_data_direction dir, unsigned long attrs);
-	void (*unmap_page)(void *token, dma_addr_t map_handle,
-			   size_t size, enum dma_data_direction dir,
-			   unsigned long attrs);
-	void (*sync_single_for_cpu)(void *token, dma_addr_t map_handle,
-				    size_t size, enum dma_data_direction dir);
-	void (*sync_single_for_device)(void *token,
+	dma_addr_t (*map_page)(struct vring_mapping_opaque *token,
+			       struct page *page, unsigned long offset,
+			       size_t size, enum dma_data_direction dir,
+			       unsigned long attrs);
+	void (*unmap_page)(struct vring_mapping_opaque *token,
+			   dma_addr_t map_handle, size_t size,
+			   enum dma_data_direction dir, unsigned long attrs);
+	void (*sync_single_for_cpu)(struct vring_mapping_opaque *token,
+				    dma_addr_t map_handle, size_t size,
+				    enum dma_data_direction dir);
+	void (*sync_single_for_device)(struct vring_mapping_opaque *token,
 				       dma_addr_t map_handle, size_t size,
 				       enum dma_data_direction dir);
-	void *(*alloc)(void *token, size_t size,
+	void *(*alloc)(struct vring_mapping_opaque *token, size_t size,
 		       dma_addr_t *map_handle, gfp_t gfp);
-	void (*free)(void *token, size_t size, void *vaddr,
-		     dma_addr_t map_handle, unsigned long attrs);
-	bool (*need_sync)(void *token, dma_addr_t map_handle);
-	int (*mapping_error)(void *token, dma_addr_t map_handle);
-	size_t (*max_mapping_size)(void *token);
+	void (*free)(struct vring_mapping_opaque *token, size_t size,
+		     void *vaddr, dma_addr_t map_handle, unsigned long attrs);
+	bool (*need_sync)(struct vring_mapping_opaque *token,
+			  dma_addr_t map_handle);
+	int (*mapping_error)(struct vring_mapping_opaque *token,
+			     dma_addr_t map_handle);
+	size_t (*max_mapping_size)(struct vring_mapping_opaque *token);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.50.1

