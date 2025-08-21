Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB336CE1E
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758843; cv=none; b=I0RhaIPhO6GuXkWTzjMYll9SEzRNGZ1QdjY10MQJCz4wQQHT7DjffutY45Qffwu+o9zgWsYdSdw41ZYJzqiX3YwU7j9H2W6BKCcc4pi0LKulqhOhU2UZ94w1ulYzswi2iYB+KV/FqAghuhJKqkR5sQGoNZYO61w42XoEETXUEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758843; c=relaxed/simple;
	bh=osTEWNooM3LHYVFFMQrqAAYF/ilHCOiJdUqB9UrBLDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBmdrVQY7Rt4ieDh+rNYWqYn9blwTeJgyK+VSYVEsy2hySLs4Df24ieGLS+iQDpikoby6lyZsHDQBxm+q9ezAdXRrAjS25hAbBdQdtoq2mSUbXq7i6b5vfYwJQrWKQTaXn3zfAtFGE92xlocCr0V5nk04arPRnZiPGP3M2eQqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJe4NJkK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJe4NJkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755758840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsHcJSI8EEe1GTnqCVZIZVl5ADyzn6rm199FA0pp0zM=;
	b=MJe4NJkKduZ9OhcbDixLVeXZ9QGdi+NzIWudBNxgK3u9rcU9iZ27p0qitrwtpQgXlWVa78
	TSI68e3fleTgpuMZMDsDGKJjbYbqicz+KxKKCxcYsjTl3VC9LttDBjHZ2oxC7o5ET8pwHf
	DlSI3qJY7Sluw700JSZye9525pddyJ4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-ifK89PhUNuyErcUEmhO56Q-1; Thu,
 21 Aug 2025 02:47:19 -0400
X-MC-Unique: ifK89PhUNuyErcUEmhO56Q-1
X-Mimecast-MFC-AGG-ID: ifK89PhUNuyErcUEmhO56Q_1755758838
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28B071956086;
	Thu, 21 Aug 2025 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9160C19560B0;
	Thu, 21 Aug 2025 06:47:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: [PATCH V6 4/9] virtio: introduce virtio_map container union
Date: Thu, 21 Aug 2025 14:46:36 +0800
Message-ID: <20250821064641.5025-5-jasowang@redhat.com>
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>
References: <20250821064641.5025-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Following patch will introduce the mapping operations for virtio
device. In order to achieve this, besides the dma device, virtio core
needs to support a transport or device specific mapping metadata as well.
So this patch introduces a union container of a dma device. The idea
is the allow the transport layer to pass device specific mapping
metadata which will be used as a parameter for the virtio mapping
operations. For the transport or device that is using DMA, dma device
is still being used.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 104 ++++++++++++++++++-----------------
 drivers/virtio/virtio_vdpa.c |   6 +-
 include/linux/virtio.h       |   5 ++
 include/linux/virtio_ring.h  |   7 ++-
 4 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 482a268af851..cda9bc2121bf 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -210,8 +210,7 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
-	/* Device used for doing DMA */
-	struct device *dma_dev;
+	union virtio_map map;
 
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
@@ -307,10 +306,10 @@ EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			       dma_addr_t *dma_handle, gfp_t flag,
-			       struct device *dma_dev)
+			       union virtio_map map)
 {
 	if (vring_use_map_api(vdev)) {
-		return dma_alloc_coherent(dma_dev, size,
+		return dma_alloc_coherent(map.dma_dev, size,
 					  dma_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
@@ -341,10 +340,10 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
 			     void *queue, dma_addr_t dma_handle,
-			     struct device *dma_dev)
+			     union virtio_map map)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(dma_dev, size, queue, dma_handle);
+		dma_free_coherent(map.dma_dev, size, queue, dma_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
@@ -356,7 +355,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
  */
 static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 {
-	return vq->dma_dev;
+	return vq->map.dma_dev;
 }
 
 /* Map one sg entry. */
@@ -1056,12 +1055,13 @@ static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_spl
 }
 
 static void vring_free_split(struct vring_virtqueue_split *vring_split,
-			     struct virtio_device *vdev, struct device *dma_dev)
+			     struct virtio_device *vdev,
+			     union virtio_map map)
 {
 	vring_free_queue(vdev, vring_split->queue_size_in_bytes,
 			 vring_split->vring.desc,
 			 vring_split->queue_dma_addr,
-			 dma_dev);
+			 map);
 
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
@@ -1072,7 +1072,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 				   u32 num,
 				   unsigned int vring_align,
 				   bool may_reduce_num,
-				   struct device *dma_dev)
+				   union virtio_map map)
 {
 	void *queue = NULL;
 	dma_addr_t dma_addr;
@@ -1088,7 +1088,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
 					  &dma_addr,
 					  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-					  dma_dev);
+					  map);
 		if (queue)
 			break;
 		if (!may_reduce_num)
@@ -1102,7 +1102,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 		/* Try to get a single page. You are my only hope! */
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
 					  &dma_addr, GFP_KERNEL | __GFP_ZERO,
-					  dma_dev);
+					  map);
 	}
 	if (!queue)
 		return -ENOMEM;
@@ -1126,7 +1126,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
 					       const char *name,
-					       struct device *dma_dev)
+					       union virtio_map map)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -1149,7 +1149,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 #else
 	vq->broken = false;
 #endif
-	vq->dma_dev = dma_dev;
+	vq->map = map;
 	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -1187,21 +1187,21 @@ static struct virtqueue *vring_create_virtqueue_split(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	union virtio_map map)
 {
 	struct vring_virtqueue_split vring_split = {};
 	struct virtqueue *vq;
 	int err;
 
 	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
-				      may_reduce_num, dma_dev);
+				      may_reduce_num, map);
 	if (err)
 		return NULL;
 
 	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
-				   context, notify, callback, name, dma_dev);
+				   context, notify, callback, name, map);
 	if (!vq) {
-		vring_free_split(&vring_split, vdev, dma_dev);
+		vring_free_split(&vring_split, vdev, map);
 		return NULL;
 	}
 
@@ -1220,7 +1220,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	err = vring_alloc_queue_split(&vring_split, vdev, num,
 				      vq->split.vring_align,
 				      vq->split.may_reduce_num,
-				      vring_dma_dev(vq));
+				      vq->map);
 	if (err)
 		goto err;
 
@@ -1238,7 +1238,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
+	vring_free_split(&vring_split, vdev, vq->map);
 err:
 	virtqueue_reinit_split(vq);
 	return -ENOMEM;
@@ -1947,25 +1947,25 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 
 static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 			      struct virtio_device *vdev,
-			      struct device *dma_dev)
+			      union virtio_map map)
 {
 	if (vring_packed->vring.desc)
 		vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
 				 vring_packed->vring.desc,
 				 vring_packed->ring_dma_addr,
-				 dma_dev);
+				 map);
 
 	if (vring_packed->vring.driver)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.driver,
 				 vring_packed->driver_event_dma_addr,
-				 dma_dev);
+				 map);
 
 	if (vring_packed->vring.device)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.device,
 				 vring_packed->device_event_dma_addr,
-				 dma_dev);
+				 map);
 
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
@@ -1973,7 +1973,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 
 static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 				    struct virtio_device *vdev,
-				    u32 num, struct device *dma_dev)
+				    u32 num, union virtio_map map)
 {
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
@@ -1985,7 +1985,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
 				 &ring_dma_addr,
 				 GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				 dma_dev);
+				 map);
 	if (!ring)
 		goto err;
 
@@ -1998,7 +1998,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	driver = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &driver_event_dma_addr,
 				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				   dma_dev);
+				   map);
 	if (!driver)
 		goto err;
 
@@ -2009,7 +2009,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
 				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				   dma_dev);
+				   map);
 	if (!device)
 		goto err;
 
@@ -2021,7 +2021,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	return 0;
 
 err:
-	vring_free_packed(vring_packed, vdev, dma_dev);
+	vring_free_packed(vring_packed, vdev, map);
 	return -ENOMEM;
 }
 
@@ -2097,7 +2097,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
 					       const char *name,
-					       struct device *dma_dev)
+					       union virtio_map map)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -2120,7 +2120,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 	vq->broken = false;
 #endif
 	vq->packed_ring = true;
-	vq->dma_dev = dma_dev;
+	vq->map = map;
 	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -2158,18 +2158,18 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	union virtio_map map)
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct virtqueue *vq;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, map))
 		return NULL;
 
 	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
-					context, notify, callback, name, dma_dev);
+					context, notify, callback, name, map);
 	if (!vq) {
-		vring_free_packed(&vring_packed, vdev, dma_dev);
+		vring_free_packed(&vring_packed, vdev, map);
 		return NULL;
 	}
 
@@ -2185,7 +2185,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	struct virtio_device *vdev = _vq->vdev;
 	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_dev(vq)))
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vq->map))
 		goto err_ring;
 
 	err = vring_alloc_state_extra_packed(&vring_packed);
@@ -2202,7 +2202,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
+	vring_free_packed(&vring_packed, vdev, vq->map);
 err_ring:
 	virtqueue_reinit_packed(vq);
 	return -ENOMEM;
@@ -2434,7 +2434,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->use_map_api)
-		return vring_dma_dev(vq);
+		return vq->map.dma_dev;
 	else
 		return NULL;
 }
@@ -2719,19 +2719,20 @@ struct virtqueue *vring_create_virtqueue(
 	void (*callback)(struct virtqueue *),
 	const char *name)
 {
+	union virtio_map map = {.dma_dev = vdev->dev.parent};
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
 				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, vdev->dev.parent);
+				context, notify, callback, name, map);
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, vdev->dev.parent);
+			context, notify, callback, name, map);
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
-struct virtqueue *vring_create_virtqueue_dma(
+struct virtqueue *vring_create_virtqueue_map(
 	unsigned int index,
 	unsigned int num,
 	unsigned int vring_align,
@@ -2742,19 +2743,19 @@ struct virtqueue *vring_create_virtqueue_dma(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	union virtio_map map)
 {
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
 				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, dma_dev);
+				context, notify, callback, name, map);
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, dma_dev);
+			context, notify, callback, name, map);
 }
-EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
+EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
 
 /**
  * virtqueue_resize - resize the vring of vq
@@ -2865,6 +2866,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      const char *name)
 {
 	struct vring_virtqueue_split vring_split = {};
+	union virtio_map map = {.dma_dev = vdev->dev.parent};
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
 		struct vring_virtqueue_packed vring_packed = {};
@@ -2874,13 +2876,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 		return __vring_new_virtqueue_packed(index, &vring_packed,
 						    vdev, weak_barriers,
 						    context, notify, callback,
-						    name, vdev->dev.parent);
+						    name, map);
 	}
 
 	vring_init(&vring_split.vring, num, pages, vring_align);
 	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				     context, notify, callback, name,
-				     vdev->dev.parent);
+				     map);
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
@@ -2894,19 +2896,19 @@ static void vring_free(struct virtqueue *_vq)
 					 vq->packed.ring_size_in_bytes,
 					 vq->packed.vring.desc,
 					 vq->packed.ring_dma_addr,
-					 vring_dma_dev(vq));
+					 vq->map);
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.driver,
 					 vq->packed.driver_event_dma_addr,
-					 vring_dma_dev(vq));
+					 vq->map);
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.device,
 					 vq->packed.device_event_dma_addr,
-					 vring_dma_dev(vq));
+					 vq->map);
 
 			kfree(vq->packed.desc_state);
 			kfree(vq->packed.desc_extra);
@@ -2915,7 +2917,7 @@ static void vring_free(struct virtqueue *_vq)
 					 vq->split.queue_size_in_bytes,
 					 vq->split.vring.desc,
 					 vq->split.queue_dma_addr,
-					 vring_dma_dev(vq));
+					 vq->map);
 		}
 	}
 	if (!vq->packed_ring) {
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 657b07a60788..dc557aa7c825 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -139,6 +139,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	struct vdpa_callback cb;
 	struct virtqueue *vq;
 	u64 desc_addr, driver_addr, device_addr;
+	union virtio_map map = {0};
 	/* Assume split virtqueue, switch to packed if necessary */
 	struct vdpa_vq_state state = {0};
 	u32 align, max_num, min_num = 1;
@@ -185,9 +186,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		dma_dev = ops->get_vq_dma_dev(vdpa, index);
 	else
 		dma_dev = vdpa_get_dma_dev(vdpa);
-	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
+	map.dma_dev = dma_dev;
+	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
-					notify, callback, name, dma_dev);
+					notify, callback, name, map);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 576e08bd7697..b4ba1a99e5ab 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -41,6 +41,11 @@ struct virtqueue {
 	void *priv;
 };
 
+union virtio_map {
+	/* Device that performs DMA */
+	struct device *dma_dev;
+};
+
 int virtqueue_add_outbuf(struct virtqueue *vq,
 			 struct scatterlist sg[], unsigned int num,
 			 void *data,
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 9b33df741b63..c97a12c1cda3 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -3,6 +3,7 @@
 #define _LINUX_VIRTIO_RING_H
 
 #include <asm/barrier.h>
+#include <linux/virtio.h>
 #include <linux/irqreturn.h>
 #include <uapi/linux/virtio_ring.h>
 
@@ -79,9 +80,9 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 
 /*
  * Creates a virtqueue and allocates the descriptor ring with per
- * virtqueue DMA device.
+ * virtqueue mapping operations.
  */
-struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
+struct virtqueue *vring_create_virtqueue_map(unsigned int index,
 					     unsigned int num,
 					     unsigned int vring_align,
 					     struct virtio_device *vdev,
@@ -91,7 +92,7 @@ struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
 					     bool (*notify)(struct virtqueue *vq),
 					     void (*callback)(struct virtqueue *vq),
 					     const char *name,
-					     struct device *dma_dev);
+					     union virtio_map map);
 
 /*
  * Creates a virtqueue with a standard layout but a caller-allocated
-- 
2.31.1

