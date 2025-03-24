Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315113FEE
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796109; cv=none; b=prStCEccivZx8T5i0ZsnK/WYnB+P8pbGJVyvqTTiEGx9k/dOWqQpLIHPxEkOOdXyoVz1uUUUsdJUJL1ncxPl+JsJ8JsU3kVgNK+SMxufrZciUb7tex/iP0bChrTnkxrd/wgK6tatglYxEoVa3x99Z/B2ZksrT0t9wq8Yp3FWtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796109; c=relaxed/simple;
	bh=tE+c+SXYh2P9sttHPvjMkbIKeC9fFHgwzLbuMpSfVNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=jmFizErukb+uleTfPjBvvD9Pz5iUQ5RhOMnFRVOJoh+T30RWRdSAPpDgC43S8V7qawhOxfA5iH5NasbuqYusUJg5Qlrl6AHhM/Dq/Js4mNHWiQ4XvMmpQ/K5MLe2+N4G5sE8iOdoAjCZ4BsSCp3phIQxHB8YLwHeZkc4Dfi/pAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAHul/Sd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAHul/Sd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742796106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXdS1I2WzJ3SNZt0dpXrs0+Kug2Lj3vwApQMGFIA7F0=;
	b=WAHul/Sd3LTiB90plTRwjiL84w0qCuJFUVna6G90T9PxgEdWn6q+lY+cQqRSxbrfY33yYS
	GNmqDIAzZ4YhDQaqOwT7esbmQGBnqKh9di2nLZJvo6I2YkvCBnAqTauegUn1vQIO7CmNQG
	4fuNFG5f7M2aPJ43SGWeJvkewA1bm4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-5O5Upp09PU2L2SWUreIjIQ-1; Mon,
 24 Mar 2025 02:01:40 -0400
X-MC-Unique: 5O5Upp09PU2L2SWUreIjIQ-1
X-Mimecast-MFC-AGG-ID: 5O5Upp09PU2L2SWUreIjIQ_1742796099
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0DDD180AF72;
	Mon, 24 Mar 2025 06:01:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5495E195609D;
	Mon, 24 Mar 2025 06:01:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] virtio_ring: determine descriptor flags at one time
Date: Mon, 24 Mar 2025 14:01:22 +0800
Message-ID: <20250324060127.2358-2-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
References: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Let's determine the last descriptor by counting the number of sg. This
would be consistent with packed virtqueue implementation and ease the
future in-order implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ce1dc90ee89d..31aa4a935c27 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -561,7 +561,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, c, avail, descs_used, err_idx;
 	int head;
 	bool indirect;
 
@@ -617,46 +617,47 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 		return -ENOSPC;
 	}
 
+	c = 0;
 	for (n = 0; n < out_sgs; n++) {
+		sg = sgs[n];
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 			u32 len;
+			u16 flags = 0;
 
 			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
 				goto unmap_release;
 
-			prev = i;
+			if (++c != total_sg)
+				flags = VRING_DESC_F_NEXT;
+
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
-						     VRING_DESC_F_NEXT,
+						     flags,
 						     premapped);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			u16 flags = VRING_DESC_F_WRITE;
 			dma_addr_t addr;
 			u32 len;
 
 			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
 				goto unmap_release;
 
-			prev = i;
+			if (++c != total_sg)
+				flags |= VRING_DESC_F_NEXT;
+
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
-						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE,
-						     premapped);
+						     flags, premapped);
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
2.42.0

