Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B960221736
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339275; cv=none; b=Ox3+4IQ0Md6XkeYPp3JAtBs/vg5TVOeY42JuKruWD6z66ezEvJXa2lw/CpRkMhlvv9iFJTFwcpBRiuoz8NjvHIoqLNTLyFjbeH5XZK0i55/9k4UbBS6Kt1QZwMioJ8F22A8hlVTcDwAL0o9Ks69c0HyG0TSyGDm8hE/vtt0yQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339275; c=relaxed/simple;
	bh=1fcgHBUgA2IgC4Nm3niU78UzHiBHsDnHvPI7e4JEyUY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhS7EWJd61wLhfmbmYtfiXROCSuAd5vLsK4CEhfYvuImgHZiFe5MKd0Q5NeWQO5QSkVIR+4kFQtg9J2/dalk7pmqURBOEIMKpDIxHMribaIPTMmmf1R9fvVByPU9WMr7baxHM/jlyunX5iZVtcyUP9E2UDfjF5K2n5B6dckaQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHBv7Cij; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHBv7Cij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753339272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u22cjOh4T7psPxv5YQPhWhYBdZ5P+0VH1zRwbXsZph8=;
	b=OHBv7Cij9ketcUD0Cw0sa4201ZUdCVd19DVW6vW2beVSg2AUK7ijzCMgVuSSmJBtz/kYvu
	FdsZzFXGHRLhvzeaXpsMp+XUe0EEqmCM638AYgGqBhJtl7/IddRPPMpIFBPwr0S3cdnjM7
	VqZQYXAIHNTRy7bBbo7XO+1y5uNoWl0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-WtIxvwpBNCmjZ75gC02mbw-1; Thu,
 24 Jul 2025 02:41:09 -0400
X-MC-Unique: WtIxvwpBNCmjZ75gC02mbw-1
X-Mimecast-MFC-AGG-ID: WtIxvwpBNCmjZ75gC02mbw_1753339268
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3395219560A3;
	Thu, 24 Jul 2025 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02F5A180035E;
	Thu, 24 Jul 2025 06:41:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 10/19] virtio_ring: switch to use vring_virtqueue for disable_cb variants
Date: Thu, 24 Jul 2025 14:40:08 +0800
Message-ID: <20250724064017.26058-11-jasowang@redhat.com>
In-Reply-To: <20250724064017.26058-1-jasowang@redhat.com>
References: <20250724064017.26058-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 08c74337f704..76375fa3379d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -869,10 +869,8 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	return ret;
 }
 
-static void virtqueue_disable_cb_split(struct virtqueue *_vq)
+static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
 
@@ -888,7 +886,7 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 			vring_used_event(&vq->split.vring) = 0x0;
 		else
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
 }
@@ -1786,10 +1784,8 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	return ret;
 }
 
-static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
+static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
 
@@ -2542,9 +2538,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->packed_ring)
-		virtqueue_disable_cb_packed(_vq);
+		virtqueue_disable_cb_packed(vq);
 	else
-		virtqueue_disable_cb_split(_vq);
+		virtqueue_disable_cb_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
-- 
2.39.5

