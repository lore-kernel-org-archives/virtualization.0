Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B02472BA
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339291; cv=none; b=pedsEp0100V+xMfUe2kTP9UU4m+nerWP4L7J0Hyt/sZf1czv5Do/98m0OjEKG5Z9i3Ur8HLk+ZUWN5U6in4xBACJIsDyS8rnOBPMUWVZanFVzvU5vFLimXW9Afzgt5Y/tYvIoA23+YwSIvoGwVS/xR/uKle4a0nR0whdwg0x0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339291; c=relaxed/simple;
	bh=CeiTqtpT3BCdJoDDAqMKZFHC7DJJaHTsQtRK8FEcu70=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Blx0kAFcIAB8oqJ8Bb5WApBkVXLeULJo0kQ9XDakOBYchF/BQRVCZ9DbnXNJbPn+wr7Zl8xgZJ+/Hd+C0lJPFSzxs/QZVtw5sKd2dJdV/W0L2ZrEdMFCKObw9mzvYPbJUVmKYEkAMemcOnIf88LI2iy4qL19ghEaNgOYoqVDUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdDXIh+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdDXIh+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753339289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qc6FYNQBKIB+acS4K5VrBDZprHD+upxJfELmeFU0+t4=;
	b=IdDXIh+VvDHsh/vgK7HMg7LaUZsJZF1KtTAdH4KZTjNLiXM+PqVwtrvcJOuzSoCnyaYAHK
	5TmnEIYt7EIbrRrNOGbN6LpdohM0O2dhLqRSriXMlLUCs97VhUiDzf1VP4c/852suw9zsD
	TBLRmeokF9t+1evf6mU7C4+Wada32NM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-pKXsCnHKNHu9qGqTFX86ww-1; Thu,
 24 Jul 2025 02:41:25 -0400
X-MC-Unique: pKXsCnHKNHu9qGqTFX86ww-1
X-Mimecast-MFC-AGG-ID: pKXsCnHKNHu9qGqTFX86ww_1753339284
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ACA91800294;
	Thu, 24 Jul 2025 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 070B5180035E;
	Thu, 24 Jul 2025 06:41:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 14/19] virtio_ring: determine descriptor flags at one time
Date: Thu, 24 Jul 2025 14:40:12 +0800
Message-ID: <20250724064017.26058-15-jasowang@redhat.com>
In-Reply-To: <20250724064017.26058-1-jasowang@redhat.com>
References: <20250724064017.26058-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Let's determine the last descriptor by counting the number of sg. This
would be consistent with packed virtqueue implementation and ease the
future in-order implementation.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2f0b14940e05..01bbbcd65417 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -570,7 +570,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, err_idx, c = 0;
 	int head;
 	bool indirect;
 
@@ -627,6 +627,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	}
 
 	for (n = 0; n < out_sgs; n++) {
+		sg = sgs[n];
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 			u32 len;
@@ -634,12 +635,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
 				goto unmap_release;
 
-			prev = i;
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
-						     VRING_DESC_F_NEXT,
+						     ++c == total_sg ?
+						     0 : VRING_DESC_F_NEXT,
 						     premapped);
 		}
 	}
@@ -651,21 +652,15 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
 				goto unmap_release;
 
-			prev = i;
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
-						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE,
-						     premapped);
+			i = virtqueue_add_desc_split(vq, desc, extra,
+				i, addr, len,
+				(++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
+				VRING_DESC_F_WRITE, premapped);
 		}
 	}
-	/* Last one doesn't continue. */
-	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
-		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
-			~VRING_DESC_F_NEXT;
 
 	if (indirect) {
 		/* Now that the indirect table is filled in, map it. */
-- 
2.39.5

