Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91F26FA50
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062361; cv=none; b=uCwiK02eUfuYedpahpti9tPzXpiptCZz62SBh9YeUn1WthD8i+fPGp6KGDGYau+zvr/8lDUmAgi2pD0RFTlxJ76iyhsN15wogyZKZD14LGd+iDKLkvTotBXoct8uxrsQkaZ8J7C4UE7/jysgaai5cmLWXVSpdwL3XGyRzTEXbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062361; c=relaxed/simple;
	bh=006uCEyOIcGfx7NjBeZmXVBAuYLOY6/grsXDLBpyKNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ649Qu/tfRy1VZHUddciIpW8g/JSsG9Ru3wJdgiekT2UgE9ZoomoLiopfed2cwFRUhbbumVPEkRne59DiAYrwGPF9WNvz31syIYKWSXmlm0HbWvY8rY+Q6wQpbQSDsRiQAxV5xY5zJL2cql8NEPCFLNwRBppDFCvlbHxs7Zd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJlhHrlG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJlhHrlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750062358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzvVr9ECZrNVmwWPiSq/eJF3/msAjqsreZZOmA+V+j8=;
	b=EJlhHrlGLIYxx/r9+6dSAcdf9NjBCheadB1U5tU7YGofRqn/aP6JNyh1Tfz4KA4eAUBV4H
	+0MA7LNFX6lB+pdceTmTmbGgdoT8q9VfVysi3KZk2K4uBIDrSJTnS/tsyQ4/oNcECjyfvZ
	z2F5VTKrAP4vKH62k+0npaW0YXwajl4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-I5YG2QPiOVW1YcR0KpfL6Q-1; Mon,
 16 Jun 2025 04:25:55 -0400
X-MC-Unique: I5YG2QPiOVW1YcR0KpfL6Q-1
X-Mimecast-MFC-AGG-ID: I5YG2QPiOVW1YcR0KpfL6Q_1750062354
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 370C719560B6;
	Mon, 16 Jun 2025 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFD2B180045B;
	Mon, 16 Jun 2025 08:25:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/19] virtio: switch to use vring_virtqueue for virtqueue_add variants
Date: Mon, 16 Jun 2025 16:25:05 +0800
Message-ID: <20250616082518.10411-8-jasowang@redhat.com>
In-Reply-To: <20250616082518.10411-1-jasowang@redhat.com>
References: <20250616082518.10411-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a808792ca86b..4e70b7eb127f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -812,11 +812,10 @@ static bool more_used_split(const struct vring_virtqueue *vq)
 	return virtqueue_poll_split(vq, vq->last_used_idx);
 }
 
-static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
+static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 					 unsigned int *len,
 					 void **ctx)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	void *ret;
 	unsigned int i;
 	u16 last_used;
@@ -838,9 +837,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
-	i = virtio32_to_cpu(_vq->vdev,
+	i = virtio32_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->ring[last_used].id);
-	*len = virtio32_to_cpu(_vq->vdev,
+	*len = virtio32_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->ring[last_used].len);
 
 	if (unlikely(i >= vq->split.vring.num)) {
@@ -862,7 +861,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
 		virtio_store_mb(vq->weak_barriers,
 				&vring_used_event(&vq->split.vring),
-				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
+				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
 
 	LAST_ADD_TIME_INVALID(vq);
 
@@ -1721,11 +1720,10 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
 }
 
-static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
+static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 					  unsigned int *len,
 					  void **ctx)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used, id, last_used_idx;
 	bool used_wrap_counter;
 	void *ret;
@@ -2521,8 +2519,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
-				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
+				 virtqueue_get_buf_ctx_split(vq, len, ctx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
-- 
2.34.1

