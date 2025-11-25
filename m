Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723902FD1D9
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054598; cv=none; b=MP9hN0awdTToqTfkD1hmQBGwYSLPc6PwcBrBxbg0oN60i2YGsuvaIOrbH2oB7+lCaqHOAvXuojhdqCvkRCQHyosMnQWyWLBpTAKzOMwYtGTcO535RIodftWkjXVkJPMngOGl2eCYf6JCU2d0xL5E2KApHSEJhQ7XMwlUu/9L7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054598; c=relaxed/simple;
	bh=Wx+2qzNeKc343CzDtkTZzpaBFSZw3rZNk6WKEivnL3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcVRagg3i/cHpdSqNhOxhYXs3v06Xnmg62D3Owx7XAr9nLyukqOUxuxrLTzOTSVnaeR7ohkqswN4Chzb13rK1UhodveO3/mzIOES9pxQ6agorktbwpqXpKiM+qU/PwRIvx/QL9s28n2Lqe83Zuna0N/JWO2nXk6bHAuBehw7VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIlbo0Xr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIlbo0Xr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764054595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3VKBAegh1DAGoGVZ8mSzYBi+zKWMLuUYc+aq7Y2Vn4=;
	b=MIlbo0XrLrE22T7xjA6QUVabO2bvFTt4rqu5sNZSM1q+9oTApNc0/Zt625ytyA6/6cSzVz
	pLmEnVsC9/PxxwsZTksd19Hrk5CAdsAqUYARHwO+x0T5j/itRur9ieFpZiXi/SDqeNqqC6
	qVo/MtrmZqNmfkrNItm5vt9NE2nT6OU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-7kQv1jI9PXeBSVcgIV4jdw-1; Tue,
 25 Nov 2025 02:09:51 -0500
X-MC-Unique: 7kQv1jI9PXeBSVcgIV4jdw-1
X-Mimecast-MFC-AGG-ID: 7kQv1jI9PXeBSVcgIV4jdw_1764054590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B822180035F;
	Tue, 25 Nov 2025 07:09:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A02C195608E;
	Tue, 25 Nov 2025 07:09:46 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 14/19] virtio_ring: determine descriptor flags at one time
Date: Tue, 25 Nov 2025 15:08:33 +0800
Message-ID: <20251125070838.70736-15-jasowang@redhat.com>
In-Reply-To: <20251125070838.70736-1-jasowang@redhat.com>
References: <20251125070838.70736-1-jasowang@redhat.com>
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

