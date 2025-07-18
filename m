Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE71E5B78
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830213; cv=none; b=a/RCcXKhElQvZmIfmrzJz9ASPjGp4/abAn+0sEdyivbGQa9VDchHUO1IFhbc8W5R48xLOYel3A60ZS81jzSrO5KSHHEuPnUqsQXtAKfB9DgSl/kEHM2xnWKg7FGHYffrIxPO6O8h8hxIx3M2tIbQZ4RBdabw3qCrw/8CfbRFHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830213; c=relaxed/simple;
	bh=tW/AfvfAb4vmV2sDDWhpJvBB+ZnM9gjXPzOEUIhBruk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WC4JNhGf1VjSfc5WIszU5cSor+dRk3JbuWoxzo2yOPKx3byT3eqX+JmPYXwWGOZxcrszO/8b5dBeWe8k1/CETzqHDgS6092WbE1Y/ER8tYLK/Bmdqfe/4CYzMZDCnfA19K0xQG6+oQ1Td0xuXxmmmS4FcgR+B49+uqK9kUXPzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcUEPZ7Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcUEPZ7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcJ1s3q06QzGiOFaI8UOJ9tnYAnqR2Q9zX7JCzox3qk=;
	b=dcUEPZ7ZOLozUvZegyLAkP0G3/UBqOpdiiIdU8su7iP/F+t+8x3RmIyn3ILup5Bj76iTiA
	BsYf8xs2A0kggkkB2qsnIUa+z3Cel4dgJ82kN+oIV5yv1R5ugD51Q+UelZozmNxOqejdTo
	advSQ0s9udhmoW+RM9lUQt3cfXpwr/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-WTstK6PrOJutldjAmOMGjA-1; Fri,
 18 Jul 2025 05:16:47 -0400
X-MC-Unique: WTstK6PrOJutldjAmOMGjA-1
X-Mimecast-MFC-AGG-ID: WTstK6PrOJutldjAmOMGjA_1752830206
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B738F195FD06;
	Fri, 18 Jul 2025 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCC6C195608D;
	Fri, 18 Jul 2025 09:16:42 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 5/9] virtio_ring: rename dma_handle to map_handle
Date: Fri, 18 Jul 2025 17:16:12 +0800
Message-ID: <20250718091616.6140-6-jasowang@redhat.com>
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
X-Mimecast-MFC-PROC-ID: LPBOQVJYZGTO-ZinBWCiEZxLlz1yfQJc32vf1m9QHBI_1752830206
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Following patch will introduce virtio map opreations which means the
address is not necessarily used for DMA. Let's rename the dma_handle
to map_handle first.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

