Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458237262D
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739376; cv=none; b=H62cDFioF1D4dWbnHqKpluwLw86ytwrBZ4SAGCg78aozyO9Ppvs7KCzlNqZ8vtpNPYtbtj8BPy0RI0ws9OK5epZzveLMdStox9kwRaKX9+b9D7/3uwvcJYtPEdvHuXzCJaNBBF0fXxH/5K5qmj7tMyIu0zgs+mhb6zIMSo9ktU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739376; c=relaxed/simple;
	bh=83HOLtOgpFNrvAAeY762n5jh3w9CQccJEEYu7sP8etc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=c6RZucSedYhBXlStw+CQgoaB3GAQ7pLNcnQn4IO9qk/g+9uS0F4gFg8ZuiQvWgJlMcaohWtevSclIvcsEM8ZS/F7B0WS9hFXzyqkDdovz8+SpCkGKFUDB91g5J6h2t4pz5nzN8sU9G2Gy6Nd7qT10T32fGJUU3r6Rt31+YsGc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9PQYYJ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9PQYYJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752739373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ug8fa1cyHSzTpRH19qWwjC5K164qxQ2OjH3E/BWgnPI=;
	b=A9PQYYJ+glfLhx2PUoDa8tY9KnsMqMLJpUmrH2ZGvD46CB0nKfzxtpco2MHxRWJDusDNLB
	+Fig6bmqadc6+Vq11SfNwl1zJubJC462WTRYPhCDCxGTIT2S9dg3KRTVZ/EJw3ZJjPFhnG
	I23Gz1Qj9t+JlluRFkm7M09TMjvFAAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-qend_aqbNaaUxYSGlrYdkQ-1; Thu,
 17 Jul 2025 04:02:50 -0400
X-MC-Unique: qend_aqbNaaUxYSGlrYdkQ-1
X-Mimecast-MFC-AGG-ID: qend_aqbNaaUxYSGlrYdkQ_1752739369
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAB73180029E;
	Thu, 17 Jul 2025 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64D381956089;
	Thu, 17 Jul 2025 08:02:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org
Subject: [PATCH V2 1/9] virtio_ring: constify virtqueue pointer for DMA helpers
Date: Thu, 17 Jul 2025 16:02:29 +0800
Message-ID: <20250717080237.6518-2-jasowang@redhat.com>
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
X-Mimecast-MFC-PROC-ID: RePhWu-EXPcADloXmbybUehVPlVuuR_R2GAjADQKEiw_1752739369
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch consities virtqueue point for DMA helpers.

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
index dd98cc2b8c18..f2dbd18a2b2e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -264,18 +264,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
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
2.47.3

