Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5674329E58
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536458; cv=none; b=Tf9ZZdyhySdze/NKT0PAxdLnQ9Oh0bOfQhs3esq9rGX236ug/1dW2FuvkzZMsxYTMNSPGOyVCi2eqK12zbLiN5n4mStmMiZqRxPXx+h1nxR82qxxBL/v/wZA5c9UebYcdedVd5SbVltt37yHkUgERtG22WmiBWuHwge6pVgBXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536458; c=relaxed/simple;
	bh=Wx+2qzNeKc343CzDtkTZzpaBFSZw3rZNk6WKEivnL3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNcKP2lJF5Jr3LAumzwvya6aDU/ZbQaGfAMZ3Xfcz91SBAnSCFoGxlDiu1Jp2posBquDE4FM1fKdlZQvM16ZpvS+KnBcaycr622Z93IH2VMYJV4IhKKiab0Wa5MDssdNSJ6qa4NPI/paNbpPFgVesjwK+Ipldpl6I55WbFvb64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HASpeyxR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HASpeyxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3VKBAegh1DAGoGVZ8mSzYBi+zKWMLuUYc+aq7Y2Vn4=;
	b=HASpeyxRZXrlxMyJEjZshFkemvOskk/1OsgtRjNJwGvPAdeNg4znr6EHv1/XIZeKeMJSDx
	4DDn4ceXqoJ/OBnBDvHvgEWDaq+xbE44zTACukp4nlYr8yH/DBOSbqcRVird6CU1LDnQmr
	EvqluR78Zkq/MNo6Kc0crWBDYHQQciU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-ZIZEx8U1P6mYx0R60W6Wag-1; Tue,
 23 Dec 2025 19:34:12 -0500
X-MC-Unique: ZIZEx8U1P6mYx0R60W6Wag-1
X-Mimecast-MFC-AGG-ID: ZIZEx8U1P6mYx0R60W6Wag_1766536451
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7E54195DE49;
	Wed, 24 Dec 2025 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B715D19560AB;
	Wed, 24 Dec 2025 00:34:08 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 14/19] virtio_ring: determine descriptor flags at one time
Date: Wed, 24 Dec 2025 08:33:04 +0800
Message-ID: <20251224003309.23432-15-jasowang@redhat.com>
In-Reply-To: <20251224003309.23432-1-jasowang@redhat.com>
References: <20251224003309.23432-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Let's determine the last descriptor by counting the number of sg. This
would be consistent with packed virtqueue implementation and ease the
future in-order implementation.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4e905dc7b6cb..dbcd6f26df7d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -575,7 +575,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, err_idx, sg_count = 0;
 	int head;
 	bool indirect;
 
@@ -635,42 +635,40 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 			u32 len;
+			u16 flags = 0;
+
+			if (++sg_count != total_sg)
+				flags |= VRING_DESC_F_NEXT;
 
 			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
 				goto unmap_release;
 
-			prev = i;
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
-						     VRING_DESC_F_NEXT,
-						     premapped);
+			i = virtqueue_add_desc_split(vq, desc, extra, i, addr,
+						     len, flags ,premapped);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 			u32 len;
+			u16 flags = VRING_DESC_F_WRITE;
+
+			if (++sg_count != total_sg)
+				flags |= VRING_DESC_F_NEXT;
 
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
+			i = virtqueue_add_desc_split(vq, desc, extra, i, addr,
+						     len, flags, premapped);
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
2.31.1

