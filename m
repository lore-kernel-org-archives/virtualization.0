Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63714C92
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796108; cv=none; b=l9+gQypGgl0OVpZTFQmI/7Fy1KdZqN7O9LPd+avuW+Rc/zqB4/sqsM0QRsCozsXA8qiRUDoMyh8wNl3CH0L9E4YglsOrV2hOAHPYk0QoyBBgVFyhp1GLHjSNhV0y2UCHGiPYHwZfj1dxRdyTwGhjyB94OrtTcYKxH7q5y8pbyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796108; c=relaxed/simple;
	bh=kSodYy3JKQRyKEg2ZxqWDVyJynIPyVGui5i5JDInqik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=aWQgBhJYF7+dCagKTp280xCnFwXpe1tJB1ccKdGW++K+MOclQbhYvWJtKet6+hNpVrnUg7bYLVNNRL8v/X+BRsL7+ckT3HDMJSGuq4rgwsBel3sK40uYvkvlZ2FPX0Fp+iVFe6QJ/c/eOgxDX98QxSrJ45YwUZ20fFH/bxbp9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwIaRUC6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwIaRUC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742796105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNKuROdsLXChQFpzZsABjXq7GCGBD+Q8wnwck0qEDlM=;
	b=hwIaRUC6T6OxcVSia5PCnMtawx8Q7/Z9wMiesp4NHS/PEP3fuIpZMzskdkBQ4OvCqcOVze
	39AtwOpaFsgKhxAbb5G3SlhNCjsocTBsi+g1NmuTNlxkPA8TJ7dNvSxY66Mp6e5DYRwXST
	dhQ0nQffUchTNRGOfiIHNwy4AenaXDw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639--WOD30MPMfuVjPP8J8DNGQ-1; Mon,
 24 Mar 2025 02:01:44 -0400
X-MC-Unique: -WOD30MPMfuVjPP8J8DNGQ-1
X-Mimecast-MFC-AGG-ID: -WOD30MPMfuVjPP8J8DNGQ_1742796103
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56EE8190308B;
	Mon, 24 Mar 2025 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9E9C195609D;
	Mon, 24 Mar 2025 06:01:39 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] virtio_ring: factor out core logic of buffer detaching
Date: Mon, 24 Mar 2025 14:01:23 +0800
Message-ID: <20250324060127.2358-3-jasowang@redhat.com>
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

Factor out core logic of buffer detaching and leave the id population
to the caller so in order can just call the core logic.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 31aa4a935c27..fe3e6f3d0f96 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1661,8 +1661,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
-static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+static void __detach_buf_packed(struct vring_virtqueue *vq,
+				unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
@@ -1673,8 +1673,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_extra[state->last].next = vq->free_head;
-	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
 	if (unlikely(vq->use_dma_api)) {
@@ -1711,6 +1709,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
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
+	return __detach_buf_packed(vq, id, ctx);
+}
+
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 				       u16 idx, bool used_wrap_counter)
 {
-- 
2.42.0

