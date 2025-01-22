Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA63215048
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563542; cv=none; b=X1PAscR8JBT5HjaynHs9UddbENk5j1oedpD5LrvqSug1deA0nmP/b4J9teEwFn1RY4c/GUqwbW2mTG8UtUR8l+Hp3JL2XDgxdfG8sCt1U8TMI5fa81JyUX/Bldc9CM3EGG143Yiaday76C1dtmXkOA/VzvxB8Lu+XLoEqixZbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563542; c=relaxed/simple;
	bh=w7mapuEB8L5kgEcM1z6DdY1adRe7cbli+5X2a2V+Vbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNou3nkZbL+qyyxCrpjtMANHwa9fVJqdsJ1/foz9WB+AhSmwyr5ffcXaserTObbg5kJ3yk03dBSRVqIl5spGZl9ISaFLX+0uodjwBhcFjlAHiXb2FQsJREuQTit1A7YGGtT5IolKUSPCb2vhIRuAhiX58q1zrVc6mpJPTVJ8M+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dg+zAe8C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg+zAe8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737563539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b78ZFdU+eXu8rnBrWAquEYDVF6p1t/YKYlcrFNlsnjU=;
	b=dg+zAe8CH2CaUoxOzbgmDOZuGd31UNxIal6iL/HW2S+sFRyvU+5ghDw+XnHMRBwIHs2vlV
	G9L8KFmj+RNWUn/kWwUhOXk5ohkJTfHZPpIve7OeKjQEkcBx9/q6Czsjgith89fqcfmDb+
	/nUx8oc1dNN1ubo5U0D4+ANPAw3klBY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-IYG8j0ihMtqBKnTYrJm3Dg-1; Wed,
 22 Jan 2025 11:32:11 -0500
X-MC-Unique: IYG8j0ihMtqBKnTYrJm3Dg-1
X-Mimecast-MFC-AGG-ID: IYG8j0ihMtqBKnTYrJm3Dg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D25A1945CB4;
	Wed, 22 Jan 2025 16:32:10 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54221195608A;
	Wed, 22 Jan 2025 16:32:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	Hanna Reitz <hreitz@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev
Subject: [RFC 2/5] virtio_ring: introduce virtqueue_map/unmap_sgs()
Date: Wed, 22 Jan 2025 17:31:51 +0100
Message-ID: <20250122163154.1225353-3-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-1-eperezma@redhat.com>
References: <20250122163154.1225353-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Jason Wang <jasowang@redhat.com>

Introduce new virtqueue DMA operations which allows the drivers that
want to make use of the premapping API but operate at the sg level.

Note that we still follow the assumtions if virtqueue_add() so
dma_map_sg() is not used. This could be optimized in the future.
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
--
Eugenio's changes: Remove blank
TODO: Should we call directly dma_map instead of this? XDP do the direct
call.
---
 drivers/virtio/virtio_ring.c | 128 +++++++++++++++++++++++++++++++----
 include/linux/virtio.h       |  10 +++
 2 files changed, 125 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fdd2d2b07b5a..05729bc5cbb1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -359,6 +359,26 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 	return vq->dma_dev;
 }
 
+static int __vring_map_one_sg(const struct vring_virtqueue *vq,
+			      struct scatterlist *sg,
+			      enum dma_data_direction direction,
+			      dma_addr_t *addr)
+{
+	/*
+	 * We can't use dma_map_sg, because we don't use scatterlists in
+	 * the way it expects (we don't guarantee that the scatterlist
+	 * will exist for the lifetime of the mapping).
+	 */
+	*addr = dma_map_page(vring_dma_dev(vq),
+			    sg_page(sg), sg->offset, sg->length,
+			    direction);
+
+	if (dma_mapping_error(vring_dma_dev(vq), *addr))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr,
@@ -383,19 +403,7 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 		return 0;
 	}
 
-	/*
-	 * We can't use dma_map_sg, because we don't use scatterlists in
-	 * the way it expects (we don't guarantee that the scatterlist
-	 * will exist for the lifetime of the mapping).
-	 */
-	*addr = dma_map_page(vring_dma_dev(vq),
-			    sg_page(sg), sg->offset, sg->length,
-			    direction);
-
-	if (dma_mapping_error(vring_dma_dev(vq), *addr))
-		return -ENOMEM;
-
-	return 0;
+	return __vring_map_one_sg(vq, sg, direction, addr);
 }
 
 static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
@@ -526,6 +534,100 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	return next;
 }
 
+void virtqueue_unmap_sgs(struct virtqueue *_vq,
+			 struct scatterlist *sgs[],
+			 unsigned int out_sgs,
+			 unsigned int in_sgs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct scatterlist *sg;
+	int n;
+
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_unmap_page(vring_dma_dev(vq),
+				       sg_dma_address(sg),
+				       sg->length,
+				       DMA_TO_DEVICE);
+		}
+	}
+
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_unmap_page(vring_dma_dev(vq),
+				       sg_dma_address(sg),
+				       sg->length,
+				       DMA_FROM_DEVICE);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(virtqueue_unmap_sgs);
+
+int virtqueue_map_sgs(struct virtqueue *_vq,
+		      struct scatterlist *sgs[],
+		      unsigned int out_sgs,
+		      unsigned int in_sgs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	int i, n, mapped_sg = 0;
+	struct scatterlist *sg;
+
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr;
+
+			if (__vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr))
+				goto unmap_release;
+
+			sg_dma_address(sg) = addr;
+			mapped_sg++;
+		}
+	}
+
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr;
+
+			if (__vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr))
+				goto unmap_release;
+
+			sg_dma_address(sg) = addr;
+			mapped_sg++;
+		}
+	}
+
+	return 0;
+
+unmap_release:
+	i = 0;
+
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			if (i++ == mapped_sg)
+				goto out;
+			dma_unmap_page(vring_dma_dev(vq),
+				       sg_dma_address(sg),
+				       sg->length,
+				       DMA_TO_DEVICE);
+		}
+	}
+
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+
+			if (i++ == mapped_sg)
+				goto out;
+			dma_unmap_page(vring_dma_dev(vq),
+				       sg_dma_address(sg),
+				       sg->length,
+				       DMA_FROM_DEVICE);
+		}
+	}
+out:
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(virtqueue_map_sgs);
+
 static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      struct scatterlist *sgs[],
 				      unsigned int total_sg,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dd88682e27e3..28db998d691e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -67,6 +67,16 @@ int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
 				   void *data,
 				   gfp_t gfp);
 
+int virtqueue_map_sgs(struct virtqueue *_vq,
+		      struct scatterlist *sgs[],
+		      unsigned int out_sgs,
+		      unsigned int in_sgs);
+
+void virtqueue_unmap_sgs(struct virtqueue *_vq,
+			 struct scatterlist *sgs[],
+			 unsigned int out_sgs,
+			 unsigned int in_sgs);
+
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
 		      unsigned int out_sgs,
-- 
2.48.1

