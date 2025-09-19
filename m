Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0ED2EE27D
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267187; cv=none; b=dTf2nBTD+B3ozkpJyPAfgvEJs5UFzUVoO0H1gc49V+vxm2FR14SN06xOaCRQBP5TRn1OjU5PtgPRqwh06hDzIr1BBLIeguIJmgVk+r6ffFRKmGQAxbKJxkR7Za9VHU9ls18PuDtxJB3juaWLeuYWQ717ID40CZ3CM4TIiLA+fKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267187; c=relaxed/simple;
	bh=JVKitmswlq4ZK/WfT8XMVZwz/iP0I5UvB5KjGP8wgvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/UDdB2Aw27G5+EYy/0F4Q2Qw9qBj0wmvhUD1ZMeNCT6WEHAI8jCes+yjfmI6tddEu7eUdPjm/ANmwRb/bZN/gLqnG7SWpOZ9oke5kMiRHrZ9r2lQScHVCrszCWOviImbDk65bDTRChfj+k33pd9B8KEdH52Y5jS+bmHDrn6aZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h60dMbeU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h60dMbeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9YZjEGI6Oy8XJp9Y3nYR0EGZPGfX0eXgaSvK8i8cBc=;
	b=h60dMbeUDo0fxJWNezBRfFUlMyxJE4TxCRK1NOSh/nEgGs0aX4E/DPpsLtCCGmcOrJio0s
	8bTH4KE4+2ErzJVM1Lp/0RA+lP9g29vW1ea0z31ERyTeONRAc4KDyvYa27H1Y5dq0bsc7Q
	UYjWISnvP4ff6CnfCKXwBTy+JxqmjQg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-FfOlTCitN3Sw1oghdoK_Fg-1; Fri,
 19 Sep 2025 03:33:03 -0400
X-MC-Unique: FfOlTCitN3Sw1oghdoK_Fg-1
X-Mimecast-MFC-AGG-ID: FfOlTCitN3Sw1oghdoK_Fg_1758267182
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D50D195608D;
	Fri, 19 Sep 2025 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ED7619560BB;
	Fri, 19 Sep 2025 07:32:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 15/19] virtio_ring: factor out core logic of buffer detaching
Date: Fri, 19 Sep 2025 15:31:50 +0800
Message-ID: <20250919073154.49278-16-jasowang@redhat.com>
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

Factor out core logic of buffer detaching and leave the id population
to the caller so in order can just call the core logic.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0949675a3d12..a83d08070e8a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1662,8 +1662,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
-static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
+				       unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
@@ -1674,8 +1674,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_extra[state->last].next = vq->free_head;
-	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
 	if (unlikely(vq->use_map_api)) {
@@ -1712,6 +1710,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	}
 }
 
+static void detach_buf_packed(struct vring_virtqueue *vq,
+			      unsigned int id, void **ctx)
+{
+	struct vring_desc_state_packed *state = &vq->packed.desc_state[id];
+
+	vq->packed.desc_extra[state->last].next = vq->free_head;
+	vq->free_head = id;
+
+	return detach_buf_packed_in_order(vq, id, ctx);
+}
+
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 				       u16 idx, bool used_wrap_counter)
 {
-- 
2.31.1

