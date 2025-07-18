Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C0221DB0
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830218; cv=none; b=ez67+/YALRRtIdrQW7o8Ael0RXgASJDUiUfjTcakKRbIqf9TKoyyX+J6SvJ4jxdu+6xn2wx3FryMXxRHFW0gI8VaNS0DxmPJw3P1WlWogLZll+MNjl2DuuOa9+U9rePDwUrNBnKWDiGTRZxKNvshGkCH8NPv1RT23RXu9A2x6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830218; c=relaxed/simple;
	bh=adOQd6shhFJUgYgB0xgyLkzDphEyab+t8P8otEUd698=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KQxY4J40CZOyA2JUjEZ92sEUP0ZJKqDryuMpHqth564K3qOb2IY6L5/KE1V9vEXEVZ9db+YG0ojnh5JT6YwcSUTqiuhVjKsNUmbgN+dbOtXIIUqLZe4cY095jXwjY0Xz94osb4GE12iOLkBApTLVlmbPNjAiJjm+NBBGAI6sv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFzUAdJb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFzUAdJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nra8k6zWz2INvoKWUmXPUhiah0RLGqpRCAwwqe6DjPo=;
	b=ZFzUAdJblAjnoK2nnqPoR8dBVKxK+6hwGxLIzknlTrIqkwpbaKgjSurYwLqLQvq/p5mWY/
	9wyw+gyybbZzMsP7dej7fMFttYCyecbzoF+oyYtbE4cAfcSBejx7OVLyGrjkx3HC1Wy/6m
	uL1YrlYBv6nbmN5ODRhcDyUxMS9lM+4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-wg7UlHhzPCOp6IxJWT73ug-1; Fri,
 18 Jul 2025 05:16:52 -0400
X-MC-Unique: wg7UlHhzPCOp6IxJWT73ug-1
X-Mimecast-MFC-AGG-ID: wg7UlHhzPCOp6IxJWT73ug_1752830211
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CF1E19560A5;
	Fri, 18 Jul 2025 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7575C195608D;
	Fri, 18 Jul 2025 09:16:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 6/9] virtio: introduce map ops in virtio core
Date: Fri, 18 Jul 2025 17:16:13 +0800
Message-ID: <20250718091616.6140-7-jasowang@redhat.com>
In-Reply-To: <20250718091616.6140-1-jasowang@redhat.com>
References: <20250718091616.6140-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pb1nFCtzVSU3e4xbM4_MTIS_HbPem9U2zSj9tHIq84k_1752830211
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch introduces map operations for virtio device. Virtio use to
use DMA API which is not necessarily the case since some devices
doesn't do DMA. Instead of using tricks and abusing DMA API, let's
simply abstract the current mapping logic into a virtio specific
mapping operations. For the device or transport that doesn't do DMA,
they can implement their own mapping logic without the need to trick
DMA core. In this case the map_token is opaque to the virtio core that
will be passed back to the transport or device specific map
operations. For other devices, DMA API will still be used, so map
token will still be the dma device to minimize the changeset and
performance impact.

The mapping operations are abstract as a independent structure instead
of reusing virtio_config_ops. This allows the transport can simply
reuse the structure for lower layers.

A set of new mapping helpers were introduced for the device that want
to do mapping by themselves.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c  | 174 +++++++++++++++++++++++++++++-----
 include/linux/virtio.h        |  22 +++++
 include/linux/virtio_config.h |  68 +++++++++++++
 3 files changed, 238 insertions(+), 26 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 26ce8a3d6927..3f86e74dd79f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -298,8 +298,14 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
 {
 	size_t max_segment_size = SIZE_MAX;
 
-	if (vring_use_map_api(vdev))
-		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
+	if (vring_use_map_api(vdev)) {
+		if (vdev->map)
+			max_segment_size =
+				vdev->map->max_mapping_size(vdev->dev.parent);
+		else
+			max_segment_size =
+				dma_max_mapping_size(vdev->dev.parent);
+	}
 
 	return max_segment_size;
 }
@@ -310,8 +316,8 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			       void *map_token)
 {
 	if (vring_use_map_api(vdev)) {
-		return dma_alloc_coherent(map_token, size,
-					  map_handle, flag);
+		return virtqueue_map_alloc_coherent(vdev, map_token, size,
+						    map_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
 
@@ -344,7 +350,8 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
 			     void *map_token)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(map_token, size, queue, map_handle);
+		virtqueue_map_free_coherent(vdev, map_token, size,
+					    queue, map_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
@@ -388,9 +395,9 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 	 * the way it expects (we don't guarantee that the scatterlist
 	 * will exist for the lifetime of the mapping).
 	 */
-	*addr = dma_map_page(vring_map_token(vq),
-			    sg_page(sg), sg->offset, sg->length,
-			    direction);
+	*addr = virtqueue_map_page_attrs(&vq->vq, sg_page(sg),
+					 sg->offset, sg->length,
+					 direction, 0);
 
 	if (dma_mapping_error(vring_map_token(vq), *addr))
 		return -ENOMEM;
@@ -454,11 +461,12 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		goto out;
 
-	dma_unmap_page(vring_map_token(vq),
-		       extra->addr,
-		       extra->len,
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	virtqueue_unmap_page_attrs(&vq->vq,
+				   extra->addr,
+				   extra->len,
+				   (flags & VRING_DESC_F_WRITE) ?
+				   DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				   0);
 
 out:
 	return extra->next;
@@ -1271,10 +1279,11 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		return;
 
-	dma_unmap_page(vring_map_token(vq),
-		       extra->addr, extra->len,
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	virtqueue_unmap_page_attrs(&vq->vq,
+				   extra->addr, extra->len,
+				   (flags & VRING_DESC_F_WRITE) ?
+				   DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				   0);
 }
 
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
@@ -3121,6 +3130,105 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/**
+ * virtqueue_map_alloc_coherent - alloc coherent mapping
+ * @vdev: the virtio device we are talking to
+ * @token: device specific mapping token
+ * @size: the size of the buffer
+ * @map_handle: the pointer to the mapped adress
+ * @gfp: allocation flag (GFP_XXX)
+ *
+ * return virtual address or NULL on error
+ */
+void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
+				   void *map_token, size_t size,
+				   dma_addr_t *map_handle, gfp_t gfp)
+{
+	if (vdev->map)
+		return vdev->map->alloc(map_token, size, map_handle, gfp);
+	else
+		return dma_alloc_coherent(map_token, size,
+					  map_handle, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
+
+/**
+ * virtqueue_map_free_coherent - free coherent mapping
+ * @vdev: the virtio device we are talking to
+ * @token: device specific mapping token
+ * @size: the size of the buffer
+ * @map_handle: the mapped address that needs to be freed
+ *
+ */
+void virtqueue_map_free_coherent(struct virtio_device *vdev,
+				 void *map_token, size_t size, void *vaddr,
+				 dma_addr_t map_handle)
+{
+	if (vdev->map)
+		vdev->map->free(map_token, size, vaddr, map_handle, 0);
+	else
+		dma_free_coherent(map_token, size, vaddr, map_handle);
+}
+EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
+
+/**
+ * virtqueue_map_page_attrs - map a page to the device
+ * @_vq: the virtqueue we are talking to
+ * @page: the page that will be mapped by the device
+ * @offset: the offset in the page for a buffer
+ * @size: the buffer size
+ * @dir: mapping direction
+ * @attrs: mapping attributes
+ *
+ * Returns mapped address. Caller should check that by virtqueue_mapping_error().
+ */
+dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
+				    struct page *page,
+				    unsigned long offset,
+				    size_t size,
+				    enum dma_data_direction dir,
+				    unsigned long attrs)
+{
+	const struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	void *map_token = vring_map_token(vq);
+
+	if (vdev->map)
+		return vdev->map->map_page(map_token,
+					   page, offset, size,
+					   dir, attrs);
+
+	return dma_map_page_attrs(map_token,
+				  page, offset, size,
+				  dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_map_page_attrs);
+
+/**
+ * virtqueue_unmap_page_attrs - map a page to the device
+ * @_vq: the virtqueue we are talking to
+ * @map_handle: the mapped address
+ * @size: the buffer size
+ * @dir: mapping direction
+ * @attrs: unmapping attributes
+ */
+void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
+				dma_addr_t map_handle,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	const struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	void *map_token = vring_map_token(vq);
+
+	if (vdev->map)
+		vdev->map->unmap_page(map_token, map_handle,
+				      size, dir, attrs);
+	else
+		dma_unmap_page_attrs(map_token, map_handle, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);
+
 /**
  * virtqueue_map_single_attrs - map DMA for _vq
  * @_vq: the struct virtqueue we're talking about.
@@ -3132,7 +3240,7 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
  * The caller calls this to do dma mapping in advance. The DMA address can be
  * passed to this _vq when it is in pre-mapped mode.
  *
- * return DMA address. Caller should check that by virtqueue_mapping_error().
+ * return mapped address. Caller should check that by virtqueue_mapping_error().
  */
 dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 				      size_t size,
@@ -3151,8 +3259,8 @@ dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 			  "rejecting DMA map of vmalloc memory\n"))
 		return DMA_MAPPING_ERROR;
 
-	return dma_map_page_attrs(vring_map_token(vq), virt_to_page(ptr),
-				  offset_in_page(ptr), size, dir, attrs);
+	return virtqueue_map_page_attrs(&vq->vq, virt_to_page(ptr),
+					offset_in_page(ptr), size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_single_attrs);
 
@@ -3177,7 +3285,7 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
 	if (!vq->use_map_api)
 		return;
 
-	dma_unmap_page_attrs(vring_map_token(vq), addr, size, dir, attrs);
+	virtqueue_unmap_page_attrs(_vq, addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
@@ -3212,11 +3320,16 @@ EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
 bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	void *token = vring_map_token(vq);
 
 	if (!vq->use_map_api)
 		return false;
 
-	return dma_need_sync(vring_map_token(vq), addr);
+	if (vdev->map)
+		return vdev->map->need_sync(token, addr);
+	else
+		return dma_need_sync(token, addr);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
 
@@ -3238,12 +3351,16 @@ void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
 					     enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct device *dev = vring_map_token(vq);
+	struct virtio_device *vdev = _vq->vdev;
+	void *token = vring_map_token(vq);
 
 	if (!vq->use_map_api)
 		return;
 
-	dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
+	if (vdev->map)
+		vdev->map->sync_single_for_cpu(token, addr + offset, size, dir);
+	else
+		dma_sync_single_range_for_cpu(token, addr, offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_cpu);
 
@@ -3264,12 +3381,17 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 						enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct device *dev = vring_map_token(vq);
+	struct virtio_device *vdev = _vq->vdev;
+	void *token = vring_map_token(vq);
 
 	if (!vq->use_map_api)
 		return;
 
-	dma_sync_single_range_for_device(dev, addr, offset, size, dir);
+	if (vdev->map)
+		vdev->map->sync_single_for_device(token, addr + offset,
+						  size, dir);
+	else
+		dma_sync_single_range_for_device(token, addr, offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 88de0e368e01..d252939d83dc 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -159,6 +159,7 @@ struct virtio_device {
 	struct virtio_device_id id;
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
+	const struct virtio_map_ops *map;
 	struct list_head vqs;
 	u64 features;
 	void *priv;
@@ -264,6 +265,27 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
 
+
+void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
+				   void *map_token, size_t size,
+				   dma_addr_t *dma_handle, gfp_t gfp);
+
+void virtqueue_map_free_coherent(struct virtio_device *vdev,
+				 void *map_token, size_t size, void *vaddr,
+				 dma_addr_t dma_handle);
+
+dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
+				    struct page *page,
+				    unsigned long offset,
+				    size_t size,
+				    enum dma_data_direction dir,
+				    unsigned long attrs);
+
+void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
+				dma_addr_t dma_handle,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs);
+
 dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
 					  enum dma_data_direction dir, unsigned long attrs);
 void virtqueue_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 861198a74be2..b4f31afa0726 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -139,6 +139,74 @@ struct virtio_config_ops {
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
 };
 
+/**
+ * struct virtio_map_ops - operations for mapping buffer for a virtio device
+ * Note: For transport that has its own mapping logic it must
+ * implements all of the operations
+ * @map_page: map a buffer to the device
+ *      token: device specific mapping token
+ *      page: the page that will be mapped by the device
+ *      offset: the offset in the page for a buffer
+ *      size: the buffer size
+ *      dir: mapping direction
+ *      attrs: mapping attributes
+ *      Returns: the mapped address
+ * @unmap_page: unmap a buffer from the device
+ *      token: device specific mapping token
+ *      map_handle: the mapped address
+ *      size: the buffer size
+ *      dir: mapping direction
+ *      attrs: unmapping attributes
+ * @sync_single_for_cpu: sync a single buffer from device to cpu
+ *      token: device specific mapping token
+ *      map_handle: the mapping adress to sync
+ *      size: the size of the buffer
+ *      dir: synchronization direction
+ * @sync_single_for_device: sync a single buffer from cpu to device
+ *      token: device specific mapping token
+ *      map_handle: the mapping adress to sync
+ *      size: the size of the buffer
+ *      dir: synchronization direction
+ * @alloc: alloc a coherent buffer mapping
+ *      token: device specific mapping token
+ *      size: the size of the buffer
+ *      map_handle: the mapping adress to sync
+ *      gfp: allocation flag (GFP_XXX)
+ *      Returns: virtual address of the allocated buffer
+ * @free: free a coherent buffer mapping
+ *      token: device specific mapping token
+ *      size: the size of the buffer
+ *      vaddr: virtual address of the buffer
+ *      map_handle: the mapping adress to sync
+ *      attrs: unmapping attributes
+ * @need_sync: if the buffer needs synchronization
+ *      token: device specific mapping token
+ *      map_handle: the mapped address
+ *      Returns: whether the buffer needs synchronization
+ * @max_mapping_size: get the maximum buffer size that can be mapped
+ *      token: device specific mapping token
+ *      Returns: the maximum buffer size that can be mapped
+ */
+struct virtio_map_ops {
+	dma_addr_t (*map_page)(void *token, struct page *page,
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_page)(void *token, dma_addr_t map_handle,
+			   size_t size, enum dma_data_direction dir,
+			   unsigned long attrs);
+	void (*sync_single_for_cpu)(void *token, dma_addr_t map_handle,
+				    size_t size, enum dma_data_direction dir);
+	void (*sync_single_for_device)(void *token,
+				       dma_addr_t map_handle, size_t size,
+				       enum dma_data_direction dir);
+	void *(*alloc)(void *token, size_t size,
+		       dma_addr_t *map_handle, gfp_t gfp);
+	void (*free)(void *token, size_t size, void *vaddr,
+		     dma_addr_t map_handle, unsigned long attrs);
+	bool (*need_sync)(void *token, dma_addr_t map_handle);
+	size_t (*max_mapping_size)(void *token);
+};
+
 /* If driver didn't advertise the feature, it will never appear. */
 void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
 					 unsigned int fbit);
-- 
2.47.3

