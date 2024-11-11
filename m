Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364C3C3C
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293752; cv=none; b=awrberr+bj0iZaz2omjTmLN80Y7ObAw7ZOrMmaHOLrIKUVqdvg78S6mToUXvvtqXBzZkRvuV91C0aD4Pi56tQVnnCp71YK3Jca6nkl+Z4p+hIqYjk2dlI3IsCgL/wfAgT5xE4uzyn9KG07XNT9qc50pQz3hArfgeH6Zw2UAuUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293752; c=relaxed/simple;
	bh=1ZvxRezxJXANBRFOTe55Jek5Kex2eZTOtcEtydvGZOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f6DF16hq7WEy7WbfAnFcoqRx9zTl8bKWjp8ZixGdKDV013Flf1iae8X8TlgN+cy+4AtjDTBs+YF+t8RtOBW45z+LAdFYca6KlRPlBZxz6wBXogi+PkSzmCQor3q2okBMPbLUdZfL+5M/SjkRHdsNTFi+i8gkOhN8NxEUmkwYdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avQ/vP/Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avQ/vP/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731293748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+y3vCNcj9tlE1RFyrQIwWNkyVgS7ApkQcRy6pVYNX4E=;
	b=avQ/vP/Y/lBeB9IktIXwLV9YowjW24iXYQEzqbOQyFM+Ej/jJJYHtjFo+ra0g0kEszUAa8
	oUFh5gyiHZnX5de4AA/ua7kERZb6NNUZyerPeB1uCUXYxaCpAQXF012PaKIcokfa6IBWNp
	vhZWPrNcjFLL0bVXxkNTBQYo+HOFzPE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-35vZMN0xO-u4pwZIi-lSWw-1; Sun,
 10 Nov 2024 21:55:47 -0500
X-MC-Unique: 35vZMN0xO-u4pwZIi-lSWw-1
X-Mimecast-MFC-AGG-ID: 35vZMN0xO-u4pwZIi-lSWw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C31E195608C;
	Mon, 11 Nov 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 970DA300019E;
	Mon, 11 Nov 2024 02:55:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: skip cpu sync when mapping fails
Date: Mon, 11 Nov 2024 10:55:38 +0800
Message-ID: <20241111025538.2837-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There's no need to sync DMA for CPU on mapping errors. So this patch
skips the CPU sync in the error handling path of DMA mapping.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 98 +++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..b422b5fb22db 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -441,8 +441,10 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
  */
 
 static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   const struct vring_desc *desc)
+					   const struct vring_desc *desc,
+					   bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	u16 flags;
 
 	if (!vq->do_unmap)
@@ -450,16 +452,18 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
-	dma_unmap_page(vring_dma_dev(vq),
-		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
-		       virtio32_to_cpu(vq->vq.vdev, desc->len),
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	dma_unmap_page_attrs(vring_dma_dev(vq),
+			     virtio64_to_cpu(vq->vq.vdev, desc->addr),
+			     virtio32_to_cpu(vq->vq.vdev, desc->len),
+			     (flags & VRING_DESC_F_WRITE) ?
+			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+			     attrs);
 }
 
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  unsigned int i, bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
 
@@ -469,20 +473,22 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 		if (!vq->use_dma_api)
 			goto out;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra[i].addr,
-				 extra[i].len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_single_attrs(vring_dma_dev(vq),
+				       extra[i].addr,
+				       extra[i].len,
+				       (flags & VRING_DESC_F_WRITE) ?
+				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				       attrs);
 	} else {
 		if (!vq->do_unmap)
 			goto out;
 
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_page_attrs(vring_dma_dev(vq),
+				     extra[i].addr,
+				     extra[i].len,
+				     (flags & VRING_DESC_F_WRITE) ?
+				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				     attrs);
 	}
 
 out:
@@ -717,10 +723,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (i == err_idx)
 			break;
 		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
+			vring_unmap_one_split_indirect(vq, &desc[i], true);
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		} else
-			i = vring_unmap_one_split(vq, i);
+			i = vring_unmap_one_split(vq, i, true);
 	}
 
 free_indirect:
@@ -775,12 +781,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, false);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, false);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -804,7 +810,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		if (vq->do_unmap) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+				vring_unmap_one_split_indirect(vq,
+							&indir_desc[j], false);
 		}
 
 		kfree(indir_desc);
@@ -1221,8 +1228,10 @@ static u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     const struct vring_desc_extra *extra)
+				     const struct vring_desc_extra *extra,
+				     bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	u16 flags;
 
 	flags = extra->flags;
@@ -1231,24 +1240,28 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 		if (!vq->use_dma_api)
 			return;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra->addr, extra->len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_single_attrs(vring_dma_dev(vq),
+				       extra->addr, extra->len,
+				       (flags & VRING_DESC_F_WRITE) ?
+				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				       attrs);
 	} else {
 		if (!vq->do_unmap)
 			return;
 
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr, extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_page_attrs(vring_dma_dev(vq),
+				     extra->addr, extra->len,
+				     (flags & VRING_DESC_F_WRITE) ?
+				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				     attrs);
 	}
 }
 
 static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				    const struct vring_packed_desc *desc)
+				    const struct vring_packed_desc *desc,
+				    bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	u16 flags;
 
 	if (!vq->do_unmap)
@@ -1256,11 +1269,12 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 
 	flags = le16_to_cpu(desc->flags);
 
-	dma_unmap_page(vring_dma_dev(vq),
-		       le64_to_cpu(desc->addr),
-		       le32_to_cpu(desc->len),
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	dma_unmap_page_attrs(vring_dma_dev(vq),
+			     le64_to_cpu(desc->addr),
+			     le32_to_cpu(desc->len),
+			     (flags & VRING_DESC_F_WRITE) ?
+			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+			     attrs);
 }
 
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
@@ -1389,7 +1403,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_desc_packed(vq, &desc[i], true);
 
 free_desc:
 	kfree(desc);
@@ -1539,7 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq,
+					 &vq->packed.desc_extra[curr], true);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1619,7 +1634,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 false);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1636,7 +1652,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+				vring_unmap_desc_packed(vq, &desc[i], false);
 		}
 		kfree(desc);
 		state->indir_desc = NULL;
-- 
2.31.1

