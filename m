Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0162C375E
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064148; cv=none; b=oEKknpblGIJYFmns1Iafxlse5qBCratbzfJP8Hz1D3TkePxVuHoqqxu+buZoki3szoQn2jlxjIwo70KvbPKIe/Xr1xc66XMYfjkASM/yaSI1CdPhkkLUxKYMVzFfwRbE1YGvXAJqmmBasoG29FoJIpq1AuCWBi/Hq+MPexWW86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064148; c=relaxed/simple;
	bh=Z1sWde1p6/Axkl74rKVg/jg3BQkrsPHNaFowlKlbTtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAFJv2t1g2SDBxjHe9iJyvDStKH+nQMUuy8AKcLTxbz6kmnOeIxtLAZfO6AgivNkLYFAeD8iWKUUygw6Uq5pGYrVI2m8ANQqUha7L0czWsy3IOhDdV4o7qqGi2mY2Z4kcCRGDW0mFQaqcG8wC/Uig2ox3PXZ595y/i2JGVQg0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgsaMHSd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgsaMHSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riVQKuwrnPqzh+a3gW/nlAdUFPVlmvC0HCNWRc3mbms=;
	b=CgsaMHSd59ucX+ri2IL/mECydf2LctE9ZXQDD5FeuI4VhhYMTG2xzU919WpMniABgw96RE
	m/x0iWzUlaYdax8dnCIBFbw0sOD+ml3ES3PPOu+WGi1tLQImC+fQU77jcT5pmPU/ATSBgg
	euowrc8B3Sj+4acG3TNJZppbPGTNGvo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-x-1YDzejPi6qu8rDNNv4eg-1; Wed,
 13 Aug 2025 01:49:01 -0400
X-MC-Unique: x-1YDzejPi6qu8rDNNv4eg-1
X-Mimecast-MFC-AGG-ID: x-1YDzejPi6qu8rDNNv4eg_1755064140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A801800291;
	Wed, 13 Aug 2025 05:49:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F4591800446;
	Wed, 13 Aug 2025 05:48:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org
Subject: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Date: Wed, 13 Aug 2025 13:48:26 +0800
Message-ID: <20250813054831.25865-5-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-1-jasowang@redhat.com>
References: <20250813054831.25865-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Following patch will introduce the mapping operations for virtio
device. In order to achieve this, besides the dma device, virtio core
needs to support a transport or device specific mapping token as well.
So this patch introduces a union container of a dma device and opaque
mapping token. The idea is the allow the transport layer to pass
device specific mapping token which will be used as a parameter for
the virtio mapping operations. For the transport or device that is
using DMA, dma device is still being used.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 110 ++++++++++++++++++-----------------
 drivers/virtio/virtio_vdpa.c |   6 +-
 include/linux/virtio.h       |   7 +++
 include/linux/virtio_ring.h  |   7 ++-
 4 files changed, 72 insertions(+), 58 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 482a268af851..fb1d407d5f1b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -210,8 +210,7 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
-	/* Device used for doing DMA */
-	struct device *dma_dev;
+	union vring_mapping_token mapping_token;
 
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
@@ -307,10 +306,10 @@ EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			       dma_addr_t *dma_handle, gfp_t flag,
-			       struct device *dma_dev)
+			       union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev)) {
-		return dma_alloc_coherent(dma_dev, size,
+		return dma_alloc_coherent(mapping_token->dma_dev, size,
 					  dma_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
@@ -341,22 +340,22 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
 			     void *queue, dma_addr_t dma_handle,
-			     struct device *dma_dev)
+			     union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(dma_dev, size, queue, dma_handle);
+		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
 
 /*
- * The DMA ops on various arches are rather gnarly right now, and
- * making all of the arch DMA ops work on the vring device itself
+ * The map ops on various arches are rather gnarly right now, and
+ * making all of the arch map ops work on the vring device itself
  * is a mess.
  */
 static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 {
-	return vq->dma_dev;
+	return vq->mapping_token.dma_dev;
 }
 
 /* Map one sg entry. */
@@ -1056,12 +1055,13 @@ static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_spl
 }
 
 static void vring_free_split(struct vring_virtqueue_split *vring_split,
-			     struct virtio_device *vdev, struct device *dma_dev)
+			     struct virtio_device *vdev,
+			     union vring_mapping_token *mapping_token)
 {
 	vring_free_queue(vdev, vring_split->queue_size_in_bytes,
 			 vring_split->vring.desc,
 			 vring_split->queue_dma_addr,
-			 dma_dev);
+			 mapping_token);
 
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
@@ -1072,7 +1072,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 				   u32 num,
 				   unsigned int vring_align,
 				   bool may_reduce_num,
-				   struct device *dma_dev)
+				   union vring_mapping_token *mapping_token)
 {
 	void *queue = NULL;
 	dma_addr_t dma_addr;
@@ -1088,7 +1088,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
 					  &dma_addr,
 					  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-					  dma_dev);
+					  mapping_token);
 		if (queue)
 			break;
 		if (!may_reduce_num)
@@ -1102,7 +1102,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 		/* Try to get a single page. You are my only hope! */
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
 					  &dma_addr, GFP_KERNEL | __GFP_ZERO,
-					  dma_dev);
+					  mapping_token);
 	}
 	if (!queue)
 		return -ENOMEM;
@@ -1126,7 +1126,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
 					       const char *name,
-					       struct device *dma_dev)
+					       union vring_mapping_token *mapping_token)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -1149,7 +1149,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 #else
 	vq->broken = false;
 #endif
-	vq->dma_dev = dma_dev;
+	vq->mapping_token = *mapping_token;
 	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -1187,21 +1187,21 @@ static struct virtqueue *vring_create_virtqueue_split(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	union vring_mapping_token *mapping_token)
 {
 	struct vring_virtqueue_split vring_split = {};
 	struct virtqueue *vq;
 	int err;
 
 	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
-				      may_reduce_num, dma_dev);
+				      may_reduce_num, mapping_token);
 	if (err)
 		return NULL;
 
 	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
-				   context, notify, callback, name, dma_dev);
+				   context, notify, callback, name, mapping_token);
 	if (!vq) {
-		vring_free_split(&vring_split, vdev, dma_dev);
+		vring_free_split(&vring_split, vdev, mapping_token);
 		return NULL;
 	}
 
@@ -1220,7 +1220,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	err = vring_alloc_queue_split(&vring_split, vdev, num,
 				      vq->split.vring_align,
 				      vq->split.may_reduce_num,
-				      vring_dma_dev(vq));
+				      &vq->mapping_token);
 	if (err)
 		goto err;
 
@@ -1238,7 +1238,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
+	vring_free_split(&vring_split, vdev, &vq->mapping_token);
 err:
 	virtqueue_reinit_split(vq);
 	return -ENOMEM;
@@ -1947,25 +1947,25 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 
 static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 			      struct virtio_device *vdev,
-			      struct device *dma_dev)
+			      union vring_mapping_token *mapping_token)
 {
 	if (vring_packed->vring.desc)
 		vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
 				 vring_packed->vring.desc,
 				 vring_packed->ring_dma_addr,
-				 dma_dev);
+				 mapping_token);
 
 	if (vring_packed->vring.driver)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.driver,
 				 vring_packed->driver_event_dma_addr,
-				 dma_dev);
+				 mapping_token);
 
 	if (vring_packed->vring.device)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.device,
 				 vring_packed->device_event_dma_addr,
-				 dma_dev);
+				 mapping_token);
 
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
@@ -1973,7 +1973,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 
 static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 				    struct virtio_device *vdev,
-				    u32 num, struct device *dma_dev)
+				    u32 num, union vring_mapping_token *mapping_token)
 {
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
@@ -1985,7 +1985,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
 				 &ring_dma_addr,
 				 GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				 dma_dev);
+				 mapping_token);
 	if (!ring)
 		goto err;
 
@@ -1998,7 +1998,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	driver = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &driver_event_dma_addr,
 				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				   dma_dev);
+				   mapping_token);
 	if (!driver)
 		goto err;
 
@@ -2009,7 +2009,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
 				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				   dma_dev);
+				   mapping_token);
 	if (!device)
 		goto err;
 
@@ -2021,7 +2021,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	return 0;
 
 err:
-	vring_free_packed(vring_packed, vdev, dma_dev);
+	vring_free_packed(vring_packed, vdev, mapping_token);
 	return -ENOMEM;
 }
 
@@ -2097,7 +2097,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
 					       const char *name,
-					       struct device *dma_dev)
+					       union vring_mapping_token *mapping_token)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -2120,7 +2120,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 	vq->broken = false;
 #endif
 	vq->packed_ring = true;
-	vq->dma_dev = dma_dev;
+	vq->mapping_token = *mapping_token;
 	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -2158,18 +2158,18 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	union vring_mapping_token *mapping_token)
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct virtqueue *vq;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, mapping_token))
 		return NULL;
 
 	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
-					context, notify, callback, name, dma_dev);
+					context, notify, callback, name, mapping_token);
 	if (!vq) {
-		vring_free_packed(&vring_packed, vdev, dma_dev);
+		vring_free_packed(&vring_packed, vdev, mapping_token);
 		return NULL;
 	}
 
@@ -2185,7 +2185,8 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	struct virtio_device *vdev = _vq->vdev;
 	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_dev(vq)))
+	if (vring_alloc_queue_packed(&vring_packed, vdev,
+				     num, &vq->mapping_token))
 		goto err_ring;
 
 	err = vring_alloc_state_extra_packed(&vring_packed);
@@ -2202,7 +2203,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
+	vring_free_packed(&vring_packed, vdev, &vq->mapping_token);
 err_ring:
 	virtqueue_reinit_packed(vq);
 	return -ENOMEM;
@@ -2423,6 +2424,7 @@ int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
 
+
 /**
  * virtqueue_dma_dev - get the dma dev
  * @_vq: the struct virtqueue we're talking about.
@@ -2434,7 +2436,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->use_map_api)
-		return vring_dma_dev(vq);
+		return vq->mapping_token.dma_dev;
 	else
 		return NULL;
 }
@@ -2719,19 +2721,20 @@ struct virtqueue *vring_create_virtqueue(
 	void (*callback)(struct virtqueue *),
 	const char *name)
 {
+	union vring_mapping_token mapping_token = {.dma_dev = vdev->dev.parent};
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
 				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, vdev->dev.parent);
+				context, notify, callback, name, &mapping_token);
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, vdev->dev.parent);
+			context, notify, callback, name, &mapping_token);
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
-struct virtqueue *vring_create_virtqueue_dma(
+struct virtqueue *vring_create_virtqueue_map(
 	unsigned int index,
 	unsigned int num,
 	unsigned int vring_align,
@@ -2742,19 +2745,19 @@ struct virtqueue *vring_create_virtqueue_dma(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	union vring_mapping_token *mapping_token)
 {
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
 				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, dma_dev);
+				context, notify, callback, name, mapping_token);
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, dma_dev);
+			context, notify, callback, name, mapping_token);
 }
-EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
+EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
 
 /**
  * virtqueue_resize - resize the vring of vq
@@ -2865,6 +2868,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      const char *name)
 {
 	struct vring_virtqueue_split vring_split = {};
+	union vring_mapping_token mapping_token = {.dma_dev = vdev->dev.parent};
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
 		struct vring_virtqueue_packed vring_packed = {};
@@ -2874,13 +2878,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 		return __vring_new_virtqueue_packed(index, &vring_packed,
 						    vdev, weak_barriers,
 						    context, notify, callback,
-						    name, vdev->dev.parent);
+						    name, &mapping_token);
 	}
 
 	vring_init(&vring_split.vring, num, pages, vring_align);
 	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				     context, notify, callback, name,
-				     vdev->dev.parent);
+				     &mapping_token);
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
@@ -2894,19 +2898,19 @@ static void vring_free(struct virtqueue *_vq)
 					 vq->packed.ring_size_in_bytes,
 					 vq->packed.vring.desc,
 					 vq->packed.ring_dma_addr,
-					 vring_dma_dev(vq));
+					 &vq->mapping_token);
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.driver,
 					 vq->packed.driver_event_dma_addr,
-					 vring_dma_dev(vq));
+					 &vq->mapping_token);
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.device,
 					 vq->packed.device_event_dma_addr,
-					 vring_dma_dev(vq));
+					 &vq->mapping_token);
 
 			kfree(vq->packed.desc_state);
 			kfree(vq->packed.desc_extra);
@@ -2915,7 +2919,7 @@ static void vring_free(struct virtqueue *_vq)
 					 vq->split.queue_size_in_bytes,
 					 vq->split.vring.desc,
 					 vq->split.queue_dma_addr,
-					 vring_dma_dev(vq));
+					 &vq->mapping_token);
 		}
 	}
 	if (!vq->packed_ring) {
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e25610e3393a..acea98ab08ee 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -139,6 +139,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	struct vdpa_callback cb;
 	struct virtqueue *vq;
 	u64 desc_addr, driver_addr, device_addr;
+	union vring_mapping_token mapping_token = {0};
 	/* Assume split virtqueue, switch to packed if necessary */
 	struct vdpa_vq_state state = {0};
 	u32 align, max_num, min_num = 1;
@@ -185,9 +186,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		dma_dev = ops->get_vq_dma_dev(vdpa, index);
 	else
 		dma_dev = vdpa_get_dma_dev(vdpa);
-	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
+	mapping_token.dma_dev = dma_dev;
+	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
-					notify, callback, name, dma_dev);
+					notify, callback, name, &mapping_token);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index addbc209275a..37029df94aaf 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -40,6 +40,13 @@ struct virtqueue {
 	void *priv;
 };
 
+union vring_mapping_token {
+	/* Device that performs DMA */
+	struct device *dma_dev;
+	/* Transport specific token used for doing map */
+	void *opaque;
+};
+
 int virtqueue_add_outbuf(struct virtqueue *vq,
 			 struct scatterlist sg[], unsigned int num,
 			 void *data,
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 9b33df741b63..fd997178da2a 100644
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
+					     union vring_mapping_token *mapping_token);
 
 /*
  * Creates a virtqueue with a standard layout but a caller-allocated
-- 
2.31.1

