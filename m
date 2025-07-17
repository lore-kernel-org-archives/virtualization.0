Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A216277CBD
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739392; cv=none; b=iSJM3rH7Mv8xY+goN2yFXd8Xg0FbK8cZgdM7PYQbM30hgqBlOvQSuDiel6vLpWiDR5Sau0Tmt+hkZ+Or8tko/hxql0b8HSxCy9Q4+DN/JvJroFe0Y+aRO0K6f5ShbAZP0emgpWWGV6kiWO+qm4hFSwXx3+KScN3dQ3Pz5QgLNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739392; c=relaxed/simple;
	bh=2Jk9eJjA0EnkoyXpZO20HgeF2UUuxnDZmqz31LHntWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YbQYWhL0joiScvVSUFsxMoqP6hIfUaCs7iH3+q/WyVeOQI6IC4j/g2BwdLAL6j+7D1XRQioEdap8uWlPWN0EktGPm0f3SygQLdp/Zsi3say3AHAVGCMcbuW2jiS5UvKMFnezKEZPOGvxhnUATmkhyu19SlFPA3eYW+4hwwkTHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpp360ur; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpp360ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752739390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMrEQP+LZ2oVeqU3mH1C9QWTXKgBu0l9ej0a6DqSleY=;
	b=Jpp360urDMGsrK6L6wkNbhOrml456VxS2Y3weM97UmBypMR30IL5h+BAAaGmx2QF5Eek5V
	kSSUAPOQlpqfOXqj+FHnjsmPuJ/jCbtP5oErmTJfxumXDKSvYzB3tuaEfwBxsJQuHkDtC3
	ecXi4iNYLVgTzioxg+GrWeJpFpob22w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-nMFu7b0ZMQytmXU6qBJ23w-1; Thu,
 17 Jul 2025 04:03:06 -0400
X-MC-Unique: nMFu7b0ZMQytmXU6qBJ23w-1
X-Mimecast-MFC-AGG-ID: nMFu7b0ZMQytmXU6qBJ23w_1752739385
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76A6A1800C3D;
	Thu, 17 Jul 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D88C19560AA;
	Thu, 17 Jul 2025 08:03:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org
Subject: [PATCH V2 5/9] virtio_ring: rename dma_handle to map_handle
Date: Thu, 17 Jul 2025 16:02:33 +0800
Message-ID: <20250717080237.6518-6-jasowang@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fcm4Lk0VYAI_NtPloRQ6Ts_U-qv84BbmHc-f4nBgllc_1752739385
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Following patch will introduce virtio map opreations which means the
address is not necessarily used for DMA. Let's rename the dma_handle
to map_handle first.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 55dd68e71509..26ce8a3d6927 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -306,18 +306,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
 EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
-			       dma_addr_t *dma_handle, gfp_t flag,
+			       dma_addr_t *map_handle, gfp_t flag,
 			       void *map_token)
 {
 	if (vring_use_map_api(vdev)) {
 		return dma_alloc_coherent(map_token, size,
-					  dma_handle, flag);
+					  map_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
 
 		if (queue) {
 			phys_addr_t phys_addr = virt_to_phys(queue);
-			*dma_handle = (dma_addr_t)phys_addr;
+			*map_handle = (dma_addr_t)phys_addr;
 
 			/*
 			 * Sanity check: make sure we dind't truncate
@@ -330,7 +330,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			 * warning and abort if we end up with an
 			 * unrepresentable address.
 			 */
-			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
+			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
 				free_pages_exact(queue, PAGE_ALIGN(size));
 				return NULL;
 			}
@@ -340,11 +340,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 }
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
-			     void *queue, dma_addr_t dma_handle,
+			     void *queue, dma_addr_t map_handle,
 			     void *map_token)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(map_token, size, queue, dma_handle);
+		dma_free_coherent(map_token, size, queue, map_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
-- 
2.47.3

