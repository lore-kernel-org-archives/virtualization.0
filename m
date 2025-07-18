Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5291E5B78
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830209; cv=none; b=csxMfN1wqgD5g19iHDoJyzg9FKFslC/JV4c20VwtRQvEUlPpP/JRpR6HwW2FrRBxUAWgyhTHmVOJ/YLGaU2AvmAn/0qYzheYu+R2R3drMpUPIoGpBiBE9c0YWfegP88vvK5qRpn6azJTF6SB5fQbFhcg/3wgao/RLPjwcy+hqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830209; c=relaxed/simple;
	bh=mYUh6WP5R5ByJiVuF8MMH2alCw1xLSjFeVihdV3f/oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TYU6FuN9LTkzAGgKjr3ExmD01YeIv9PzR0AU3gxjNYjAmuY8pYx0iVM+6RQ2ECKCbYUDlLNVBRjLMF0nv50RO6yQJiPgdeFLwCB0fg5yGewr2enfvesIFMHozFbfFfFTSFKPRpeKBRVbL9BNDX+VsuZktoEFEsoOZFdECMayPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DG1eNQ4H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG1eNQ4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfmNDb6TZx0amlctE31X/PhrUL17rEw5/ugsdSSBQ8c=;
	b=DG1eNQ4HvqVIrkljjxamDyJ+gpLli8UrgPkA8kqB1fDOIL4/9veMMi0RB0MO8eIMos7txP
	DfTDsszZON9PEaD9CDpIMTZdu9592HwtPSiHD8KQCrWoNZ2Z4GbFvZ2hxlDl6ggyETfaIe
	pU2jjpox1+fn2y31aD27/HHqtLkS5Ng=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-wYv2GNa5NImMZPRfODgHqw-1; Fri,
 18 Jul 2025 05:16:43 -0400
X-MC-Unique: wYv2GNa5NImMZPRfODgHqw-1
X-Mimecast-MFC-AGG-ID: wYv2GNa5NImMZPRfODgHqw_1752830202
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EA50180029E;
	Fri, 18 Jul 2025 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B2E7195608D;
	Fri, 18 Jul 2025 09:16:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 4/9] virtio: rename dma_dev to map_token
Date: Fri, 18 Jul 2025 17:16:11 +0800
Message-ID: <20250718091616.6140-5-jasowang@redhat.com>
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
X-Mimecast-MFC-PROC-ID: nN9BZLa1Rd6nlHfJEG45fjCOAgOlEh7z2ZG-NSYwOso_1752830202
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Following patch will introduce the mapping operations for virtio
device. So this patch rename dma_dev to map_token to match the
rework. The idea is the allow the transport layer to pass device
specific mapping token which will be used as a parameter for the
virtio mapping operations.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c     |   4 +-
 drivers/virtio/virtio_ring.c | 130 +++++++++++++++++------------------
 drivers/virtio/virtio_vdpa.c |   2 +-
 include/linux/virtio.h       |   2 +-
 include/linux/virtio_ring.h  |   6 +-
 5 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 929db41a579b..09d1637e0237 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5908,10 +5908,10 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	 * But vq->dma_dev allows every vq has the respective dma dev. So I
 	 * check the dma dev of vq and sq is the same dev.
 	 */
-	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
+	if (virtqueue_map_token(rq->vq) != virtqueue_map_token(sq->vq))
 		return -EINVAL;
 
-	dma_dev = virtqueue_dma_dev(rq->vq);
+	dma_dev = virtqueue_map_token(rq->vq);
 	if (!dma_dev)
 		return -EINVAL;
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 482a268af851..55dd68e71509 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -210,8 +210,8 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
-	/* Device used for doing DMA */
-	struct device *dma_dev;
+	/* Transport specific token used for doing map */
+	void *map_token;
 
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
@@ -307,10 +307,10 @@ EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			       dma_addr_t *dma_handle, gfp_t flag,
-			       struct device *dma_dev)
+			       void *map_token)
 {
 	if (vring_use_map_api(vdev)) {
-		return dma_alloc_coherent(dma_dev, size,
+		return dma_alloc_coherent(map_token, size,
 					  dma_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
@@ -341,22 +341,22 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
 			     void *queue, dma_addr_t dma_handle,
-			     struct device *dma_dev)
+			     void *map_token)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(dma_dev, size, queue, dma_handle);
+		dma_free_coherent(map_token, size, queue, dma_handle);
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
-static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
+static void *vring_map_token(const struct vring_virtqueue *vq)
 {
-	return vq->dma_dev;
+	return vq->map_token;
 }
 
 /* Map one sg entry. */
@@ -388,11 +388,11 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 	 * the way it expects (we don't guarantee that the scatterlist
 	 * will exist for the lifetime of the mapping).
 	 */
-	*addr = dma_map_page(vring_dma_dev(vq),
+	*addr = dma_map_page(vring_map_token(vq),
 			    sg_page(sg), sg->offset, sg->length,
 			    direction);
 
-	if (dma_mapping_error(vring_dma_dev(vq), *addr))
+	if (dma_mapping_error(vring_map_token(vq), *addr))
 		return -ENOMEM;
 
 	return 0;
@@ -415,7 +415,7 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
 	if (!vq->use_map_api)
 		return 0;
 
-	return dma_mapping_error(vring_dma_dev(vq), addr);
+	return dma_mapping_error(vring_map_token(vq), addr);
 }
 
 static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
@@ -454,7 +454,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		goto out;
 
-	dma_unmap_page(vring_dma_dev(vq),
+	dma_unmap_page(vring_map_token(vq),
 		       extra->addr,
 		       extra->len,
 		       (flags & VRING_DESC_F_WRITE) ?
@@ -1056,12 +1056,12 @@ static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_spl
 }
 
 static void vring_free_split(struct vring_virtqueue_split *vring_split,
-			     struct virtio_device *vdev, struct device *dma_dev)
+			     struct virtio_device *vdev, void *map_token)
 {
 	vring_free_queue(vdev, vring_split->queue_size_in_bytes,
 			 vring_split->vring.desc,
 			 vring_split->queue_dma_addr,
-			 dma_dev);
+			 map_token);
 
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
@@ -1072,7 +1072,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 				   u32 num,
 				   unsigned int vring_align,
 				   bool may_reduce_num,
-				   struct device *dma_dev)
+				   void *map_token)
 {
 	void *queue = NULL;
 	dma_addr_t dma_addr;
@@ -1088,7 +1088,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
 					  &dma_addr,
 					  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-					  dma_dev);
+					  map_token);
 		if (queue)
 			break;
 		if (!may_reduce_num)
@@ -1102,7 +1102,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 		/* Try to get a single page. You are my only hope! */
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
 					  &dma_addr, GFP_KERNEL | __GFP_ZERO,
-					  dma_dev);
+					  map_token);
 	}
 	if (!queue)
 		return -ENOMEM;
@@ -1126,7 +1126,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
 					       const char *name,
-					       struct device *dma_dev)
+					       void *map_token)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -1149,7 +1149,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 #else
 	vq->broken = false;
 #endif
-	vq->dma_dev = dma_dev;
+	vq->map_token = map_token;
 	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -1187,21 +1187,21 @@ static struct virtqueue *vring_create_virtqueue_split(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	void *map_token)
 {
 	struct vring_virtqueue_split vring_split = {};
 	struct virtqueue *vq;
 	int err;
 
 	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
-				      may_reduce_num, dma_dev);
+				      may_reduce_num, map_token);
 	if (err)
 		return NULL;
 
 	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
-				   context, notify, callback, name, dma_dev);
+				   context, notify, callback, name, map_token);
 	if (!vq) {
-		vring_free_split(&vring_split, vdev, dma_dev);
+		vring_free_split(&vring_split, vdev, map_token);
 		return NULL;
 	}
 
@@ -1220,7 +1220,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	err = vring_alloc_queue_split(&vring_split, vdev, num,
 				      vq->split.vring_align,
 				      vq->split.may_reduce_num,
-				      vring_dma_dev(vq));
+				      vring_map_token(vq));
 	if (err)
 		goto err;
 
@@ -1238,7 +1238,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
+	vring_free_split(&vring_split, vdev, vring_map_token(vq));
 err:
 	virtqueue_reinit_split(vq);
 	return -ENOMEM;
@@ -1271,7 +1271,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		return;
 
-	dma_unmap_page(vring_dma_dev(vq),
+	dma_unmap_page(vring_map_token(vq),
 		       extra->addr, extra->len,
 		       (flags & VRING_DESC_F_WRITE) ?
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
@@ -1947,25 +1947,25 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 
 static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 			      struct virtio_device *vdev,
-			      struct device *dma_dev)
+			      void *map_token)
 {
 	if (vring_packed->vring.desc)
 		vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
 				 vring_packed->vring.desc,
 				 vring_packed->ring_dma_addr,
-				 dma_dev);
+				 map_token);
 
 	if (vring_packed->vring.driver)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.driver,
 				 vring_packed->driver_event_dma_addr,
-				 dma_dev);
+				 map_token);
 
 	if (vring_packed->vring.device)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.device,
 				 vring_packed->device_event_dma_addr,
-				 dma_dev);
+				 map_token);
 
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
@@ -1973,7 +1973,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 
 static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 				    struct virtio_device *vdev,
-				    u32 num, struct device *dma_dev)
+				    u32 num, void *map_token)
 {
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
@@ -1985,7 +1985,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
 				 &ring_dma_addr,
 				 GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				 dma_dev);
+				 map_token);
 	if (!ring)
 		goto err;
 
@@ -1998,7 +1998,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	driver = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &driver_event_dma_addr,
 				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				   dma_dev);
+				   map_token);
 	if (!driver)
 		goto err;
 
@@ -2009,7 +2009,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
 				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-				   dma_dev);
+				   map_token);
 	if (!device)
 		goto err;
 
@@ -2021,7 +2021,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	return 0;
 
 err:
-	vring_free_packed(vring_packed, vdev, dma_dev);
+	vring_free_packed(vring_packed, vdev, map_token);
 	return -ENOMEM;
 }
 
@@ -2097,7 +2097,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
 					       const char *name,
-					       struct device *dma_dev)
+					       void *map_token)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -2120,7 +2120,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 	vq->broken = false;
 #endif
 	vq->packed_ring = true;
-	vq->dma_dev = dma_dev;
+	vq->map_token = map_token;
 	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -2158,18 +2158,18 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	void *map_token)
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct virtqueue *vq;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, map_token))
 		return NULL;
 
 	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
-					context, notify, callback, name, dma_dev);
+					context, notify, callback, name, map_token);
 	if (!vq) {
-		vring_free_packed(&vring_packed, vdev, dma_dev);
+		vring_free_packed(&vring_packed, vdev, map_token);
 		return NULL;
 	}
 
@@ -2185,7 +2185,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	struct virtio_device *vdev = _vq->vdev;
 	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_dev(vq)))
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_map_token(vq)))
 		goto err_ring;
 
 	err = vring_alloc_state_extra_packed(&vring_packed);
@@ -2202,7 +2202,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
+	vring_free_packed(&vring_packed, vdev, vring_map_token(vq));
 err_ring:
 	virtqueue_reinit_packed(vq);
 	return -ENOMEM;
@@ -2424,21 +2424,21 @@ int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
 
 /**
- * virtqueue_dma_dev - get the dma dev
+ * virtqueue_map_token - get the transport specific map token
  * @_vq: the struct virtqueue we're talking about.
  *
- * Returns the dma dev. That can been used for dma api.
+ * Returns the map token. That can been used for map api.
  */
-struct device *virtqueue_dma_dev(struct virtqueue *_vq)
+void *virtqueue_map_token(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->use_map_api)
-		return vring_dma_dev(vq);
+		return vring_map_token(vq);
 	else
 		return NULL;
 }
-EXPORT_SYMBOL_GPL(virtqueue_dma_dev);
+EXPORT_SYMBOL_GPL(virtqueue_map_token);
 
 /**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
@@ -2731,7 +2731,7 @@ struct virtqueue *vring_create_virtqueue(
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
-struct virtqueue *vring_create_virtqueue_dma(
+struct virtqueue *vring_create_virtqueue_map(
 	unsigned int index,
 	unsigned int num,
 	unsigned int vring_align,
@@ -2742,19 +2742,19 @@ struct virtqueue *vring_create_virtqueue_dma(
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name,
-	struct device *dma_dev)
+	void *map_token)
 {
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
 				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, dma_dev);
+				context, notify, callback, name, map_token);
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, dma_dev);
+			context, notify, callback, name, map_token);
 }
-EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
+EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
 
 /**
  * virtqueue_resize - resize the vring of vq
@@ -2894,19 +2894,19 @@ static void vring_free(struct virtqueue *_vq)
 					 vq->packed.ring_size_in_bytes,
 					 vq->packed.vring.desc,
 					 vq->packed.ring_dma_addr,
-					 vring_dma_dev(vq));
+					 vring_map_token(vq));
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.driver,
 					 vq->packed.driver_event_dma_addr,
-					 vring_dma_dev(vq));
+					 vring_map_token(vq));
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.device,
 					 vq->packed.device_event_dma_addr,
-					 vring_dma_dev(vq));
+					 vring_map_token(vq));
 
 			kfree(vq->packed.desc_state);
 			kfree(vq->packed.desc_extra);
@@ -2915,7 +2915,7 @@ static void vring_free(struct virtqueue *_vq)
 					 vq->split.queue_size_in_bytes,
 					 vq->split.vring.desc,
 					 vq->split.queue_dma_addr,
-					 vring_dma_dev(vq));
+					 vring_map_token(vq));
 		}
 	}
 	if (!vq->packed_ring) {
@@ -3151,7 +3151,7 @@ dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 			  "rejecting DMA map of vmalloc memory\n"))
 		return DMA_MAPPING_ERROR;
 
-	return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
+	return dma_map_page_attrs(vring_map_token(vq), virt_to_page(ptr),
 				  offset_in_page(ptr), size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_single_attrs);
@@ -3177,7 +3177,7 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
 	if (!vq->use_map_api)
 		return;
 
-	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+	dma_unmap_page_attrs(vring_map_token(vq), addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
@@ -3195,7 +3195,7 @@ int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
 	if (!vq->use_map_api)
 		return 0;
 
-	return dma_mapping_error(vring_dma_dev(vq), addr);
+	return dma_mapping_error(vring_map_token(vq), addr);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
 
@@ -3216,7 +3216,7 @@ bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
 	if (!vq->use_map_api)
 		return false;
 
-	return dma_need_sync(vring_dma_dev(vq), addr);
+	return dma_need_sync(vring_map_token(vq), addr);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
 
@@ -3238,7 +3238,7 @@ void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
 					     enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct device *dev = vring_dma_dev(vq);
+	struct device *dev = vring_map_token(vq);
 
 	if (!vq->use_map_api)
 		return;
@@ -3264,7 +3264,7 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 						enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct device *dev = vring_dma_dev(vq);
+	struct device *dev = vring_map_token(vq);
 
 	if (!vq->use_map_api)
 		return;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e25610e3393a..dbf207cd3996 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -185,7 +185,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		dma_dev = ops->get_vq_dma_dev(vdpa, index);
 	else
 		dma_dev = vdpa_get_dma_dev(vdpa);
-	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
+	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
 					notify, callback, name, dma_dev);
 	if (!vq) {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d4a21ec63b34..88de0e368e01 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -74,7 +74,7 @@ int virtqueue_add_sgs(struct virtqueue *vq,
 		      void *data,
 		      gfp_t gfp);
 
-struct device *virtqueue_dma_dev(struct virtqueue *vq);
+void *virtqueue_map_token(struct virtqueue *vq);
 
 bool virtqueue_kick(struct virtqueue *vq);
 
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 9b33df741b63..a995bca6785f 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -79,9 +79,9 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 
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
@@ -91,7 +91,7 @@ struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
 					     bool (*notify)(struct virtqueue *vq),
 					     void (*callback)(struct virtqueue *vq),
 					     const char *name,
-					     struct device *dma_dev);
+					     void *map_token);
 
 /*
  * Creates a virtqueue with a standard layout but a caller-allocated
-- 
2.47.3

