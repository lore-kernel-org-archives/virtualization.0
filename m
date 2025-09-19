Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF62D24A5
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267183; cv=none; b=YnKgyQZsjR02v07rdE7FvW733wzFkbp3ENEeoRHEaSFwk3DSaXRRdgmsOhhdN0TQ4CLDIwCa3nOk+fFpn10m2+yt0rLet0nMXPTdnjcs5yEK1z44Qda+p0zsfk+7VTnCzhmptrKkEK+4OmzVp7ITjp+APOuZdBpC3y/j8t1EVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267183; c=relaxed/simple;
	bh=t6B+ZbY/VMcwKcfhAYHqTcwHa/Xiu7FndQUCge126B8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAa3tS9VRYI0YyoyNH44+EqHxE1yuE/xWq416x/JHC8E9jzeRwq/eC88/yocPWtinoF0yEkSz+o2VKQCrmAg4D/kTsoVPGwVB5e/SJMzyXke4JVkD+U6Kc7KHbfNoZvlYI0Y7N+14AySffMVqOdfBMBUqvVEsoTKJ/+0rsLY0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGW/oO3G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGW/oO3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZwWaRgTPeERiAS+TPU75pItPhxCQoG0D3EUtPVk6C4=;
	b=TGW/oO3GpqlHa8EGJMyaIWoLTZHwr05uuyRc5YkLtRuDy9T3SL1iBcqck/ywAbdyLMNrv0
	IO8drDvuIKvN4RBtIJGaMNFvHeTSsCK1TiN6socxCYxDzSDo20gWjXFVELlz64I+SeJRvR
	qMJ9BeamfQeg5pr07bIPqj3f9QzUsaw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-UOnkIUgfNEuul44xeW7F_w-1; Fri,
 19 Sep 2025 03:32:59 -0400
X-MC-Unique: UOnkIUgfNEuul44xeW7F_w-1
X-Mimecast-MFC-AGG-ID: UOnkIUgfNEuul44xeW7F_w_1758267178
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E2A11800451;
	Fri, 19 Sep 2025 07:32:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 771E119560BB;
	Fri, 19 Sep 2025 07:32:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one time
Date: Fri, 19 Sep 2025 15:31:49 +0800
Message-ID: <20250919073154.49278-15-jasowang@redhat.com>
In-Reply-To: <20250919073154.49278-1-jasowang@redhat.com>
References: <20250919073154.49278-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index 1045c553ee65..0949675a3d12 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -574,7 +574,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, err_idx, c = 0;
 	int head;
 	bool indirect;
 
@@ -631,6 +631,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	}
 
 	for (n = 0; n < out_sgs; n++) {
+		sg = sgs[n];
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 			u32 len;
@@ -638,12 +639,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
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
@@ -655,21 +656,15 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
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
2.31.1

