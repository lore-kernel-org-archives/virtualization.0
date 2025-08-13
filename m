Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748C2C08A0
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064133; cv=none; b=OfPg1IUKYCk+0JiwBfX6912x3gzUVfofM+Zg/3bfQEPEtmM13bMGgGcJ164TrORE1r0zDPOB27Ci/alZb/4ko0HM/OBZBCC1FknWtplOC9C07KR/l7qBjd/Nxrc7Ppg3t84413XNlKxeEG861zNYzypJ37DUtwii0Ak3qTwGZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064133; c=relaxed/simple;
	bh=TOSZRHVlqf40RfvoGG/BUBfT3LeE9vJCXaz/GE2hDuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sE38aBZE7/Fbfz8cd65+NTGVJlJz6i1/ReUPqYe/cg+rqmoBwLUGQV19Bin9i5awJsQjlTMUx5BwBbNXnFq6NI5CWGT9CRK1RCBgcsTKfmiGjJbOJACWPXUO2rxdvBeCKDP01FJ3S6aZXeHHRaKKrxDciHtRdY/MXFXU6cQUxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmImFHfF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmImFHfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOy0pv/ZmqnoL+rDHsLjyrQgJtxCVYPj5U64E/LdlAw=;
	b=GmImFHfFx2LUUKRvpBzcFLwyt63y9OdoGAQna0zQkNWX1g7RHJzsIgF0ftAPZYXiWKTCMV
	C77Kw8D9zTGnNIPUEPOd+s++l/QkIlF3CV4PH53K1UEODoYKXgvuk+UOE70vPiVivwTSRW
	8JjAm2yLtyuaQmNFci+vS/1rQxpREJc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-iGNsChy5PRO90SNaf7DV_A-1; Wed,
 13 Aug 2025 01:48:46 -0400
X-MC-Unique: iGNsChy5PRO90SNaf7DV_A-1
X-Mimecast-MFC-AGG-ID: iGNsChy5PRO90SNaf7DV_A_1755064125
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF6CA19560A1;
	Wed, 13 Aug 2025 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 292601800280;
	Wed, 13 Aug 2025 05:48:39 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V5 1/9] virtio_ring: constify virtqueue pointer for DMA helpers
Date: Wed, 13 Aug 2025 13:48:23 +0800
Message-ID: <20250813054831.25865-2-jasowang@redhat.com>
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

This patch consities virtqueue point for DMA helpers.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
 include/linux/virtio.h       | 12 ++++++------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f5062061c408..103bad8cffff 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3149,12 +3149,12 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
  *
  * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
  */
-dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
+dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 					  size_t size,
 					  enum dma_data_direction dir,
 					  unsigned long attrs)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (!vq->use_dma_api) {
 		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
@@ -3176,11 +3176,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
  * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
  *
  */
-void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
+void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
+				      dma_addr_t addr,
 				      size_t size, enum dma_data_direction dir,
 				      unsigned long attrs)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (!vq->use_dma_api)
 		return;
@@ -3196,9 +3197,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
  *
  * Returns 0 means dma valid. Other means invalid dma address.
  */
-int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
+int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (!vq->use_dma_api)
 		return 0;
@@ -3217,9 +3218,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
  *
  * return bool
  */
-bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
+bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (!vq->use_dma_api)
 		return false;
@@ -3240,12 +3241,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
  * the DMA address really needs to be synchronized
  *
  */
-void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
+void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq,
 					     dma_addr_t addr,
 					     unsigned long offset, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 	struct device *dev = vring_dma_dev(vq);
 
 	if (!vq->use_dma_api)
@@ -3266,12 +3267,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
  * Before calling this function, use virtqueue_dma_need_sync() to confirm that
  * the DMA address really needs to be synchronized
  */
-void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
+void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq,
 						dma_addr_t addr,
 						unsigned long offset, size_t size,
 						enum dma_data_direction dir)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 	struct device *dev = vring_dma_dev(vq);
 
 	if (!vq->use_dma_api)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 8b745ce0cf5f..cf8def717dfd 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
 
-dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
+dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
 					  enum dma_data_direction dir, unsigned long attrs);
-void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
+void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
 				      size_t size, enum dma_data_direction dir,
 				      unsigned long attrs);
-int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
+int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
 
-bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
-void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
+bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
+void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
 					     unsigned long offset, size_t size,
 					     enum dma_data_direction dir);
-void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
+void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
 						unsigned long offset, size_t size,
 						enum dma_data_direction dir);
 
-- 
2.31.1

