Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E919C540
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332475; cv=none; b=Cg3Lr5RPqRvWGyN4YGjc1VeBkmBXEb6jNXLgoniMKY5HcMcvip37dkJohh9qDslE6x3tMEACrnY8VmccaENnDfQTJzOhPBvMgVtI2PBjRNf6KMn9ard3agAd5pirw2HkQRA1CelhrYDTpmmAKHr4rlGp2//lG+oy1MdtwsNLdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332475; c=relaxed/simple;
	bh=6IcBgKkww0Gtd8wYRB6Zo/1cLdz+spKU1SQlpcQLEr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgmzyMpfcfASc4FPpHgWVB2ToxdEs6q1y2L8UwCN+JseZrc4W/AZGr9Qwn7m4W+plGyb+g//ZGT79teM6+Nr1OV4DT743QTQHG2D0ABB45gJoaTsmAuEbPq+bxHF2EyOqFuZ0odgHf3Gub/+tOIxG1HeVjJ+0KjPbVTd5YBrfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMaXBUy+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMaXBUy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751332472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1YJAWiVeR1Z3d/6uV73THC6e7egT1xA04L6cikCEnw=;
	b=VMaXBUy+SeU4KubB9zka399wcXQ/X56s7a6FrM9ZH7/MTESRvE51PAarrLC+1k9qOgeK8B
	mPsXG6L0ZRSaYKcNpmkZo3Cn6A8vb5D+PKU7s88w+nBZDdWdrieG2cgyLNIjptVY5SYf8O
	2fNh5pmDru6h8Anwxdoj0up5L0HcR+w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-0r5JGp3COEaCrzoYgwK-oA-1; Mon,
 30 Jun 2025 21:14:30 -0400
X-MC-Unique: 0r5JGp3COEaCrzoYgwK-oA-1
X-Mimecast-MFC-AGG-ID: 0r5JGp3COEaCrzoYgwK-oA_1751332469
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16B1F1955EC3;
	Tue,  1 Jul 2025 01:14:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 261B630001B1;
	Tue,  1 Jul 2025 01:14:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	xieyongji@bytedance.com
Subject: [PATCH 3/9] virtio: rename dma helpers
Date: Tue,  1 Jul 2025 09:13:55 +0800
Message-ID: <20250701011401.74851-4-jasowang@redhat.com>
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

Following patch will introduce virtio mapping fucntion to avoid
abusing DMA API for device that doesn't do DMA. To ease the
introduction, this patch rename "dma" to "map" for the current dma
mapping helpers.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c     |  28 ++++-----
 drivers/virtio/virtio_ring.c | 114 +++++++++++++++++------------------
 include/linux/virtio.h       |  12 ++--
 3 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..39bcb85335d5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -913,7 +913,7 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 	if (dma->need_sync && len) {
 		offset = buf - (head + sizeof(*dma));
 
-		virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr,
+		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
 							offset, len,
 							DMA_FROM_DEVICE);
 	}
@@ -921,8 +921,8 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 	if (dma->ref)
 		return;
 
-	virtqueue_dma_unmap_single_attrs(rq->vq, dma->addr, dma->len,
-					 DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
+				     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
 	put_page(page);
 }
 
@@ -989,13 +989,13 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 		dma->len = alloc_frag->size - sizeof(*dma);
 
-		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
-						      dma->len, DMA_FROM_DEVICE, 0);
-		if (virtqueue_dma_mapping_error(rq->vq, addr))
+		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
+						  dma->len, DMA_FROM_DEVICE, 0);
+		if (virtqueue_map_mapping_error(rq->vq, addr))
 			return NULL;
 
 		dma->addr = addr;
-		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
+		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
 
 		/* Add a reference to dma to prevent the entire dma from
 		 * being released during error handling. This reference
@@ -5892,9 +5892,9 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!rq->xsk_buffs)
 		return -ENOMEM;
 
-	hdr_dma = virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
-						 DMA_TO_DEVICE, 0);
-	if (virtqueue_dma_mapping_error(sq->vq, hdr_dma)) {
+	hdr_dma = virtqueue_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
+					     DMA_TO_DEVICE, 0);
+	if (virtqueue_map_mapping_error(sq->vq, hdr_dma)) {
 		err = -ENOMEM;
 		goto err_free_buffs;
 	}
@@ -5923,8 +5923,8 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
-	virtqueue_dma_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
-					 DMA_TO_DEVICE, 0);
+	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
+				     DMA_TO_DEVICE, 0);
 err_free_buffs:
 	kvfree(rq->xsk_buffs);
 	return err;
@@ -5951,8 +5951,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	xsk_pool_dma_unmap(pool, 0);
 
-	virtqueue_dma_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
-					 vi->hdr_len, DMA_TO_DEVICE, 0);
+	virtqueue_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
+				     vi->hdr_len, DMA_TO_DEVICE, 0);
 	kvfree(rq->xsk_buffs);
 
 	return err;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 04d88502a685..5961e77db6dc 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -166,7 +166,7 @@ struct vring_virtqueue {
 	bool packed_ring;
 
 	/* Is DMA API used? */
-	bool use_dma_api;
+	bool use_map_api;
 
 	/* Can we use weak barriers? */
 	bool weak_barriers;
@@ -268,7 +268,7 @@ static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
  * unconditionally on data path.
  */
 
-static bool vring_use_dma_api(const struct virtio_device *vdev)
+static bool vring_use_map_api(const struct virtio_device *vdev)
 {
 	if (!virtio_has_dma_quirk(vdev))
 		return true;
@@ -291,14 +291,14 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring,
 				    const struct vring_desc_extra *extra)
 {
-	return vring->use_dma_api && (extra->addr != DMA_MAPPING_ERROR);
+	return vring->use_map_api && (extra->addr != DMA_MAPPING_ERROR);
 }
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev)
 {
 	size_t max_segment_size = SIZE_MAX;
 
-	if (vring_use_dma_api(vdev))
+	if (vring_use_map_api(vdev))
 		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
 
 	return max_segment_size;
@@ -309,7 +309,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			       dma_addr_t *dma_handle, gfp_t flag,
 			       struct device *dma_dev)
 {
-	if (vring_use_dma_api(vdev)) {
+	if (vring_use_map_api(vdev)) {
 		return dma_alloc_coherent(dma_dev, size,
 					  dma_handle, flag);
 	} else {
@@ -343,7 +343,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
 			     void *queue, dma_addr_t dma_handle,
 			     struct device *dma_dev)
 {
-	if (vring_use_dma_api(vdev))
+	if (vring_use_map_api(vdev))
 		dma_free_coherent(dma_dev, size, queue, dma_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
@@ -372,7 +372,7 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 
 	*len = sg->length;
 
-	if (!vq->use_dma_api) {
+	if (!vq->use_map_api) {
 		/*
 		 * If DMA is not used, KMSAN doesn't know that the scatterlist
 		 * is initialized by the hardware. Explicitly check/unpoison it
@@ -402,17 +402,17 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 				   void *cpu_addr, size_t size,
 				   enum dma_data_direction direction)
 {
-	if (!vq->use_dma_api)
+	if (!vq->use_map_api)
 		return (dma_addr_t)virt_to_phys(cpu_addr);
 
-	return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
-					      size, direction, 0);
+	return virtqueue_map_single_attrs(&vq->vq, cpu_addr,
+					  size, direction, 0);
 }
 
 static int vring_mapping_error(const struct vring_virtqueue *vq,
 			       dma_addr_t addr)
 {
-	if (!vq->use_dma_api)
+	if (!vq->use_map_api)
 		return 0;
 
 	return dma_mapping_error(vring_dma_dev(vq), addr);
@@ -449,7 +449,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	flags = extra->flags;
 
 	if (flags & VRING_DESC_F_INDIRECT) {
-		if (!vq->use_dma_api)
+		if (!vq->use_map_api)
 			goto out;
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		goto out;
@@ -782,7 +782,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		extra = (struct vring_desc_extra *)&indir_desc[num];
 
-		if (vq->use_dma_api) {
+		if (vq->use_map_api) {
 			for (j = 0; j < num; j++)
 				vring_unmap_one_split(vq, &extra[j]);
 		}
@@ -1150,7 +1150,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 	vq->broken = false;
 #endif
 	vq->dma_dev = dma_dev;
-	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -1266,7 +1266,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	flags = extra->flags;
 
 	if (flags & VRING_DESC_F_INDIRECT) {
-		if (!vq->use_dma_api)
+		if (!vq->use_map_api)
 			return;
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		return;
@@ -1351,7 +1351,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(len);
 
-			if (unlikely(vq->use_dma_api)) {
+			if (unlikely(vq->use_map_api)) {
 				extra[i].addr = premapped ? DMA_MAPPING_ERROR : addr;
 				extra[i].len = len;
 				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
@@ -1373,7 +1373,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				sizeof(struct vring_packed_desc));
 	vq->packed.vring.desc[head].id = cpu_to_le16(id);
 
-	if (vq->use_dma_api) {
+	if (vq->use_map_api) {
 		vq->packed.desc_extra[id].addr = addr;
 		vq->packed.desc_extra[id].len = total_sg *
 				sizeof(struct vring_packed_desc);
@@ -1515,7 +1515,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].len = cpu_to_le32(len);
 			desc[i].id = cpu_to_le16(id);
 
-			if (unlikely(vq->use_dma_api)) {
+			if (unlikely(vq->use_map_api)) {
 				vq->packed.desc_extra[curr].addr = premapped ?
 					DMA_MAPPING_ERROR : addr;
 				vq->packed.desc_extra[curr].len = len;
@@ -1650,7 +1650,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
-	if (unlikely(vq->use_dma_api)) {
+	if (unlikely(vq->use_map_api)) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
@@ -1668,7 +1668,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_map_api) {
 			len = vq->packed.desc_extra[id].len;
 			num = len / sizeof(struct vring_packed_desc);
 
@@ -2121,7 +2121,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 #endif
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
-	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->use_map_api = vring_use_map_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2429,7 +2429,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (vq->use_dma_api)
+	if (vq->use_map_api)
 		return vring_dma_dev(vq);
 	else
 		return NULL;
@@ -3114,7 +3114,7 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
 /**
- * virtqueue_dma_map_single_attrs - map DMA for _vq
+ * virtqueue_map_single_attrs - map DMA for _vq
  * @_vq: the struct virtqueue we're talking about.
  * @ptr: the pointer of the buffer to do dma
  * @size: the size of the buffer to do dma
@@ -3124,16 +3124,16 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
  * The caller calls this to do dma mapping in advance. The DMA address can be
  * passed to this _vq when it is in pre-mapped mode.
  *
- * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
+ * return DMA address. Caller should check that by virtqueue_mapping_error().
  */
-dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr,
-					  size_t size,
-					  enum dma_data_direction dir,
-					  unsigned long attrs)
+dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
+				      size_t size,
+				      enum dma_data_direction dir,
+				      unsigned long attrs)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!vq->use_dma_api) {
+	if (!vq->use_map_api) {
 		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
 		return (dma_addr_t)virt_to_phys(ptr);
 	}
@@ -3146,85 +3146,85 @@ dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr
 	return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
 				  offset_in_page(ptr), size, dir, attrs);
 }
-EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
+EXPORT_SYMBOL_GPL(virtqueue_map_single_attrs);
 
 /**
- * virtqueue_dma_unmap_single_attrs - unmap DMA for _vq
+ * virtqueue_unmap_single_attrs - unmap map for _vq
  * @_vq: the struct virtqueue we're talking about.
  * @addr: the dma address to unmap
  * @size: the size of the buffer
  * @dir: DMA direction
  * @attrs: DMA Attrs
  *
- * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
+ * Unmap the address that is mapped by the virtqueue_map_* APIs.
  *
  */
-void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
-				      dma_addr_t addr,
-				      size_t size, enum dma_data_direction dir,
-				      unsigned long attrs)
+void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
+				  dma_addr_t addr,
+				  size_t size, enum dma_data_direction dir,
+				  unsigned long attrs)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!vq->use_dma_api)
+	if (!vq->use_map_api)
 		return;
 
 	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
 }
-EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
+EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
 /**
- * virtqueue_dma_mapping_error - check dma address
+ * virtqueue_map_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
  * Returns 0 means dma valid. Other means invalid dma address.
  */
-int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
+int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!vq->use_dma_api)
+	if (!vq->use_map_api)
 		return 0;
 
 	return dma_mapping_error(vring_dma_dev(vq), addr);
 }
-EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
+EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
 
 /**
- * virtqueue_dma_need_sync - check a dma address needs sync
+ * virtqueue_map_need_sync - check a dma address needs sync
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
- * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs to be
+ * Check if the dma address mapped by the virtqueue_map_* APIs needs to be
  * synchronized
  *
  * return bool
  */
-bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
+bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!vq->use_dma_api)
+	if (!vq->use_map_api)
 		return false;
 
 	return dma_need_sync(vring_dma_dev(vq), addr);
 }
-EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
+EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
 
 /**
- * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
+ * virtqueue_map_sync_single_range_for_cpu - map sync for cpu
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  * @offset: DMA address offset
  * @size: buf size for sync
  * @dir: DMA direction
  *
- * Before calling this function, use virtqueue_dma_need_sync() to confirm that
+ * Before calling this function, use virtqueue_map_need_sync() to confirm that
  * the DMA address really needs to be synchronized
  *
  */
-void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq,
+void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
 					     dma_addr_t addr,
 					     unsigned long offset, size_t size,
 					     enum dma_data_direction dir)
@@ -3232,25 +3232,25 @@ void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq,
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 	struct device *dev = vring_dma_dev(vq);
 
-	if (!vq->use_dma_api)
+	if (!vq->use_map_api)
 		return;
 
 	dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
 }
-EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
+EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_cpu);
 
 /**
- * virtqueue_dma_sync_single_range_for_device - dma sync for device
+ * virtqueue_map_sync_single_range_for_device - map sync for device
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  * @offset: DMA address offset
  * @size: buf size for sync
  * @dir: DMA direction
  *
- * Before calling this function, use virtqueue_dma_need_sync() to confirm that
+ * Before calling this function, use virtqueue_map_need_sync() to confirm that
  * the DMA address really needs to be synchronized
  */
-void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq,
+void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 						dma_addr_t addr,
 						unsigned long offset, size_t size,
 						enum dma_data_direction dir)
@@ -3258,12 +3258,12 @@ void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq,
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 	struct device *dev = vring_dma_dev(vq);
 
-	if (!vq->use_dma_api)
+	if (!vq->use_map_api)
 		return;
 
 	dma_sync_single_range_for_device(dev, addr, offset, size, dir);
 }
-EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
+EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
 
 MODULE_DESCRIPTION("Virtio ring implementation");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 8c0a3165e754..0371b500ed19 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
 
-dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
+dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
 					  enum dma_data_direction dir, unsigned long attrs);
-void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
+void virtqueue_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
 				      size_t size, enum dma_data_direction dir,
 				      unsigned long attrs);
-int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
+int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
 
-bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
-void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
+bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
+void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
 					     unsigned long offset, size_t size,
 					     enum dma_data_direction dir);
-void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
+void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
 						unsigned long offset, size_t size,
 						enum dma_data_direction dir);
 
-- 
2.34.1

