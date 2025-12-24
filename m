Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530032A3FF
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536462; cv=none; b=TZBRHyyChKUDus3epoMZLsDCRvsHn/TqGGfRNPbB8iuGu2w9wgo1O4+OntxNuBJvlVf66TzY4CZW1l5+dj/cuqZG+OjpvP2cI+FYR1n9fY3iqIOmpNdq3jU1IkNRA/Cu4oV1CfP8oYVifrHu4+Wk7E9jqo3lXwVOqLw6QRYE/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536462; c=relaxed/simple;
	bh=jT45+gYAZb3lmVZ0lmRdq+HBXPY+MsirmR4IBchEZEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQOQySDPgMk+L07tVxBu2tDMvI0gnjlreiRvM/YmLgCpCxOjLY3MosdxavdI304bX3oFkaywxIRWrjP5JQHr646jHWUZscAFEwHFAXjorOsiwwqqaCpBYCj0miIpQo0c8t1tR+/iBt2a/MxzZgt0SG2o7Bv63mlT9egn0OBajVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8v6OHQR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8v6OHQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgjMqSGgSOscOTaLT7lOFtNx5D/azBRAkOh8QKI/gKQ=;
	b=B8v6OHQRUewumC6MMrzmkizSD/t0fce7HYPlLoflt7bQnKJi1/FCjXWgkVM0t8kQQnfpfq
	MbPg7UWbzkBfT2aFhcAU+6jDH2+H+usECBcmx5s/lQbA0FNoEtxQ5EM/sNWx5+hGS6gbV9
	f/H0Rkd6LR2Sk6HMi4hzU0/I2xmaN5U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-gq8nP330PxuycgSWzJ8lLw-1; Tue,
 23 Dec 2025 19:34:16 -0500
X-MC-Unique: gq8nP330PxuycgSWzJ8lLw-1
X-Mimecast-MFC-AGG-ID: gq8nP330PxuycgSWzJ8lLw_1766536455
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59C301800378;
	Wed, 24 Dec 2025 00:34:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59E8719560AB;
	Wed, 24 Dec 2025 00:34:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 15/19] virtio_ring: factor out core logic of buffer detaching
Date: Wed, 24 Dec 2025 08:33:05 +0800
Message-ID: <20251224003309.23432-16-jasowang@redhat.com>
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

Factor out core logic of buffer detaching and leave the free list
management to the caller so in_order can just call the core logic.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dbcd6f26df7d..ca33af830f65 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1667,8 +1667,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
-static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
+				       unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
@@ -1679,8 +1679,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_extra[state->last].next = vq->free_head;
-	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
 	if (unlikely(vq->use_map_api)) {
@@ -1717,6 +1715,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
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
+	detach_buf_packed_in_order(vq, id, ctx);
+}
+
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 				       u16 idx, bool used_wrap_counter)
 {
-- 
2.31.1

