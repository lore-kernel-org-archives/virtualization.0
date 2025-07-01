Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE25197A6C
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332470; cv=none; b=XvDgTeFGM2DW8OCk1GsetKNTaQTpEzU0d8XQ+tTrbw1FmR+6pBqwfSO+smvGkLTzc7qUgT56JCdwaD1GpZjexBjqKpyVncEzYEuWcRTZUqD/4aTfwgH7fsS1iMLUwAumMUZZy8zPJqUCO857Pm+6f96LLZYKi2QwtJH1/GLGZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332470; c=relaxed/simple;
	bh=rjcmnDhxSJw+MvMwFg+91jmRX4tBaB+vRVTeQNiXTcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV6ZDvTSXXnWyy7vsYqvkDpytljCPMeqoYLSyb4OhoNiiaHtaRxuLlVjFg4z9xAGdtgZriYa0Hg7HWrJMfB9wHVo0viIqLub0zMP3/dQXdqC647OdMuO0a6C031MUIefh379wD9Z1dg3Dqn0/2e2gtLRg3eL7VIsnt43w84L1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1eUL+Ym; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1eUL+Ym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751332467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kbR3eYQb0FlsO0demrZEJQtyuEYA1enmKkQtGgvdec=;
	b=c1eUL+Yml5hgw1M/B3EK/799TgeJoCzrnWE5PWSMKPQWcE20oOJT5TEQOb7qsWl5gpRa9y
	sl/hXL4eCoYFYeIqzTD9ISfWdRDpiTjfXcT90SnBgsHBUQJvjVj0/R7XRVOL16S0fBlZY6
	xGGzCvGIE1zzc59+LGZDB48sqFuxdcM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-AHLyKEmNNNC1Zmk4pD38KA-1; Mon,
 30 Jun 2025 21:14:24 -0400
X-MC-Unique: AHLyKEmNNNC1Zmk4pD38KA-1
X-Mimecast-MFC-AGG-ID: AHLyKEmNNNC1Zmk4pD38KA_1751332463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3DA41956086;
	Tue,  1 Jul 2025 01:14:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8190E30001B5;
	Tue,  1 Jul 2025 01:14:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	xieyongji@bytedance.com
Subject: [PATCH 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
Date: Tue,  1 Jul 2025 09:13:54 +0800
Message-ID: <20250701011401.74851-3-jasowang@redhat.com>
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

This patch switches to use dma_{map|unmap}_page() to reduce the
coverage of DMA operations. This would help for the following rework
on the virtio map operations.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 55 +++++++++++++++---------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 291d93d4a613..04d88502a685 100644
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
@@ -3153,7 +3138,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr
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
 
@@ -3178,7 +3169,7 @@ void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
 	if (!vq->use_dma_api)
 		return;
 
-	dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
 
-- 
2.34.1

