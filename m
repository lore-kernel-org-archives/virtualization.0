Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0D3597A
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806319; cv=none; b=DOcOXCw1L/5cnZ2S+pR4PRGy5yos4cEhYJDHzjnIvj0YYUmfG5aYjC9UTSv+mzViJUHi4MXvdB6yjO8hKmaJsIolZsLZM4YodGGyOHqyrkCknbWg8qWCUnhrujkihO7zkqqjxGvqmJ0TAircIMzgiWLQLUw4g10jvNM2wsO7mWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806319; c=relaxed/simple;
	bh=ads7/iEajgP4OfizvtrKRJiBBot05Mq5U9uE3gk65fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=mIVKYLCVV8Y0wP3uEb1X7x5vLbp6ORHkLm5uSqMLYjtCRcs8N71PXK0LIlhu1iptLxLHtm9ZDZk39PqQRgm5HQs8FC9zstn9o434uiBULd5U0gDTZ7uV/V6yJhFQ6gf2er/PoaVM74inUYinfrgqrJMUGLzSSxi5daFbLBUBVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIRjNnlH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIRjNnlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752806316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLQ/ge2FujlqDXTfUIv2x3+p5fDQC5P2uussgXUApWw=;
	b=BIRjNnlHCSwGD6d3EFoVtFUtjkd3zRAkSpYEeqrs9IoSqA5UiQ6Mg5oX84rq5NZHNj32oG
	oQM2PGI/VU4KMJA8LANdI0yO/94HOdYtojZ6rE8dnwB7Kvj+WBzj4ZbTPJbQHu6gILZSBS
	+zsVAce5S0jgL+xNB4odbLgd0JCNwEE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-Hfl7SuRYMsO2wpZgCUmGMg-1; Thu,
 17 Jul 2025 22:38:32 -0400
X-MC-Unique: Hfl7SuRYMsO2wpZgCUmGMg-1
X-Mimecast-MFC-AGG-ID: Hfl7SuRYMsO2wpZgCUmGMg_1752806312
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2B581800C34;
	Fri, 18 Jul 2025 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 624F130001B1;
	Fri, 18 Jul 2025 02:38:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 5/9] virtio_ring: rename dma_handle to map_handle
Date: Fri, 18 Jul 2025 10:37:54 +0800
Message-ID: <20250718023758.36866-6-jasowang@redhat.com>
In-Reply-To: <20250718023758.36866-1-jasowang@redhat.com>
References: <20250718023758.36866-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SrgwZiXrMxH5Pvkz6mj5r7smvO9yUITHJoGkWJvLh5o_1752806312
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

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
2.42.0

