Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2CC746E
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795070; cv=none; b=SDs+Y/wUDYyca2WHrXYG/guDi3cg+08ofIVIwRozy3U7GppMkmy5Fnw32l03BEeupC+GzODnn2NwAmpi6wKna6dFetjH02E62HhebAGdNjX2k2w/Fh9koFcDW5gxUiWj/wPHXV9DbrGUMwt42QZ3Lt5ZnnHWJWPrNNc1GZl/LVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795070; c=relaxed/simple;
	bh=/mdnvf2o0Oc7vqmZ7YASNU/iprKu8l2eNjO6WyrtRLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=jrOWw9cOrWJclTugyzDqs/jpos73Haud+Dny4tEg2yVobFvIJ+Z1Kdkjzi2NGfdcfoIvvTdqkfqiu+wCdaHpNps8GdS9iBvGBa6g9iyzHQdkMzj2H2eCQQzBOPR+SdNJMwaG9NU6erRfepk9u/z37gqcE6V9qmRIpOTnvCXQU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfqqR1uk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfqqR1uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6KM7mIr9N85DsMvBDFsXdyfNR91I72EO89NZ7hsAMw=;
	b=AfqqR1ukOQa/PkKAd47+wu5V4MegihtM0xYTZEhHXILhBDLGS6FQQWLAIe2eO0KGFm2DfC
	XFCrRL1RzWjcebq/OikPFTmKHrkQZWRK/F8PQ0DwjEKdfavWFRo9ZvDvZ0ohtiixzBeDbB
	r8W+F+4WC98yr5hetZf1pM+8RB01C9w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-QiuYCowdPYa-BO7jDxd4kQ-1; Mon,
 24 Mar 2025 01:44:24 -0400
X-MC-Unique: QiuYCowdPYa-BO7jDxd4kQ-1
X-Mimecast-MFC-AGG-ID: QiuYCowdPYa-BO7jDxd4kQ_1742795063
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EEA3180AB19;
	Mon, 24 Mar 2025 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEB78180A801;
	Mon, 24 Mar 2025 05:44:18 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] virtio_ring: use vring_virtqueue for enable_cb_delayed variants
Date: Mon, 24 Mar 2025 13:43:23 +0800
Message-ID: <20250324054333.1954-10-jasowang@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a414e66915d9..af8ce6e9d892 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -917,9 +917,8 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq
 	return last_used_idx;
 }
 
-static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
+static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 bufs;
 
 	START_USE(vq);
@@ -933,7 +932,7 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
 		if (!vq->event)
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
 	/* TODO: tune this threshold */
@@ -941,9 +940,9 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 
 	virtio_store_mb(vq->weak_barriers,
 			&vring_used_event(&vq->split.vring),
-			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
+			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
 
-	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->split.vring.used->idx)
+	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
 					- vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
@@ -1837,9 +1836,8 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *v
 	return vq->last_used_idx;
 }
 
-static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
+static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 used_idx, wrap_counter, last_used_idx;
 	u16 bufs;
 
@@ -2631,8 +2629,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
-				 virtqueue_enable_cb_delayed_split(_vq);
+	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
+				 virtqueue_enable_cb_delayed_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
-- 
2.42.0

