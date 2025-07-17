Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB47262D
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739380; cv=none; b=RriSbzk5wWCS9I7w6lxWWs9X/pKZice+juQUcZV+JPdhPBBSU2QBuK5jS9mzadoFOV4CR8jMlXU43TUpOU0jukPBjQVuOxegFgYx1RdrU6gcFXlZWnDMRFM4ONBTzwsEkE2xL7FnsysAHOqsG+1UXYBfKckgicrG2M4hg3epyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739380; c=relaxed/simple;
	bh=9PW6KCy+vVL6uDdHBVhgPMMFGKxJMKReEqh+xvOmveM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SKOXNL7b7LLLTBUnZD2LBK1CifHbVyZgMYwD8H3ijffoxTii/0FBIleSI5l7kl2QNhQMqn/diRnZJmnxLULXVZIvUfucurr5g5MUjiMK2Uv7cn4kwhy6xu+YrKlEqxniepkVI+1292O7ocsObDNHsmWZtM7D1Vt8DrMacfqJbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScYSmyGn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScYSmyGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752739377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UGmQoJ8SNXaRA+qymkpmuPdZLXBZzifgXNRnwj2w98=;
	b=ScYSmyGnUH1+jP9Zo7llpF4B1fZIs4Q9hZQzKD6xv2qZudknp00xy1I/D/cdbzOESUOPUx
	Dv5R+GJWv9Z7cJ5JHcLRe+zie9ckhUw0Tr3EZrYeZs1G6kQw8lZUk4+611t8NFzAMAmSSj
	W0OYlpYngKP1mRZMDMSHN6WFMR3MyYc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-qMU3FmmCMyWyznG4mhsNrA-1; Thu,
 17 Jul 2025 04:02:53 -0400
X-MC-Unique: qMU3FmmCMyWyznG4mhsNrA-1
X-Mimecast-MFC-AGG-ID: qMU3FmmCMyWyznG4mhsNrA_1752739373
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C84951800C3F;
	Thu, 17 Jul 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 938081956089;
	Thu, 17 Jul 2025 08:02:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org
Subject: [PATCH V2 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
Date: Thu, 17 Jul 2025 16:02:30 +0800
Message-ID: <20250717080237.6518-3-jasowang@redhat.com>
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
X-Mimecast-MFC-PROC-ID: PH-z8icD98XsYmwsttqE7wu9YIeIUuWc6Rx5X1t4rqo_1752739373
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch switches to use dma_{map|unmap}_page() to reduce the
coverage of DMA operations. This would help for the following rework
on the virtio map operations.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 55 +++++++++++++++---------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 103bad8cffff..75e5f6336c8d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -405,8 +405,8 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 	if (!vq->use_dma_api)
 		return (dma_addr_t)virt_to_phys(cpu_addr);
 
-	return dma_map_single(vring_dma_dev(vq),
-			      cpu_addr, size, direction);
+	return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
+					      size, direction, 0);
 }
 
 static int vring_mapping_error(const struct vring_virtqueue *vq,
@@ -451,22 +451,14 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	if (flags & VRING_DESC_F_INDIRECT) {
 		if (!vq->use_dma_api)
 			goto out;
+	} else if (!vring_need_unmap_buffer(vq, extra))
+		goto out;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra->addr,
-				 extra->len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vring_need_unmap_buffer(vq, extra))
-			goto out;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr,
-			       extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       extra->addr,
+		       extra->len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 
 out:
 	return extra->next;
@@ -1276,20 +1268,13 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	if (flags & VRING_DESC_F_INDIRECT) {
 		if (!vq->use_dma_api)
 			return;
+	} else if (!vring_need_unmap_buffer(vq, extra))
+		return;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra->addr, extra->len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vring_need_unmap_buffer(vq, extra))
-			return;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr, extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       extra->addr, extra->len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
@@ -3161,7 +3146,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr
 		return (dma_addr_t)virt_to_phys(ptr);
 	}
 
-	return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
+	/* DMA must never operate on areas that might be remapped. */
+	if (dev_WARN_ONCE(&_vq->vdev->dev, is_vmalloc_addr(ptr),
+			  "rejecting DMA map of vmalloc memory\n"))
+		return DMA_MAPPING_ERROR;
+
+	return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
+				  offset_in_page(ptr), size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
 
@@ -3186,7 +3177,7 @@ void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
 	if (!vq->use_dma_api)
 		return;
 
-	dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
 
-- 
2.47.3

