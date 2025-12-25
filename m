Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F32D3A96
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636839; cv=none; b=Pr1uWusicZUgsGnGE55TE+JelQHakZPoFpBje57NOvbAL5Osj9vOFMPUFVmdopYHVEQLAVfjGoK6/ZmxUMqDrt8ro36mq8cerqrQ+kRe6b/H14EmTYVVWXdxBaK6r80HbWNblrjFD7W14tHTL0v0bG/M4iRq5e4vUOYZ+dplVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636839; c=relaxed/simple;
	bh=Wx+2qzNeKc343CzDtkTZzpaBFSZw3rZNk6WKEivnL3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxUXrmGG17zkNvqyWembzDU+I/Ix4EQ4bfmafJjzmiOHq+/VypftdxOgC0e4lu3a4NIbNonIrhupVo8op/+1Y56egrf0tnOhwlbApzIh5awEbLFFhzkDEt9t07kJuIyqx4oSDQdUeDyb0jp9MdBN3+OnNMOGTMYD5/Pah1UrJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHy+HhTM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHy+HhTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766636837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3VKBAegh1DAGoGVZ8mSzYBi+zKWMLuUYc+aq7Y2Vn4=;
	b=bHy+HhTMZCy4WbpYsC9cHrYxGKcLtnyRPmnw8Mwioocvbxh+qoKedxDK8EDllvma1FZ2lR
	MT5BPKNoWZiHqbkno3/Dt7ZsyJNYFYWR/eQx9VZmA54orbp37kYFhErZADFsa1XOE0kfBB
	okhbXNnkH/OHtbHWFLE/O8KyehW/298=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-7HjA3AWTOZmthMFPOwIlqg-1; Wed,
 24 Dec 2025 23:27:14 -0500
X-MC-Unique: 7HjA3AWTOZmthMFPOwIlqg-1
X-Mimecast-MFC-AGG-ID: 7HjA3AWTOZmthMFPOwIlqg_1766636833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82238180065F;
	Thu, 25 Dec 2025 04:27:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 642E1180045B;
	Thu, 25 Dec 2025 04:27:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 14/19] virtio_ring: determine descriptor flags at one time
Date: Thu, 25 Dec 2025 12:26:03 +0800
Message-ID: <20251225042608.32350-15-jasowang@redhat.com>
In-Reply-To: <20251225042608.32350-1-jasowang@redhat.com>
References: <20251225042608.32350-1-jasowang@redhat.com>
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

