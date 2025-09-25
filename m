Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF92FC02B
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796675; cv=none; b=E6CnX1Dja9m9fceGFxvlQadz0zPvRkkL3q9PMhJFzychgJ77n9eZYkFJbWuUILhrbuiBCcySntdc+STleMtVYhlamqPBp4Nz4vcrNC3+GZ0nCEO3AWQHQeBtaCknPEsOGYr/56ZgWJojCrvF5t3TjDanxHwjBdfP/k3Pa20UhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796675; c=relaxed/simple;
	bh=7qDg5goKB2eLhHZ+Ed9qX3fTW71RZzlughkjBIvkQ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lE5v+pV6mpy4IIiWtTzsHWTqeBRALYnOJOKrj9ejJbr6q//jOMOrFAhPxHsMkMhC/F7HZl+k88Tbp4PUGm/Nv8nWaBcmGXz/iLa/PnbPdXl6X/9yLB7o8/ZyS2mapI7TwfN77lGwX/E3damb+MCP9rBxFBGxiBzxvQidzkEafSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMpuF2s7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMpuF2s7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTDGrU9uhGdFfnzChF1KM1YGBCuNVqCio2exfzbo6VA=;
	b=hMpuF2s7CwRYZmBlS7/aWgV8Vwd2RRVArXFTtc66e7wLEcPiHUc53gdkC8QpV4PuDlM8Ib
	NkS6uTXSNp3evK41wbo6P4YZnaw69gmjfJm/bvffPxI+LvtyRO1IZNwnKJkRmv6+MDh/JI
	YpuOwQOCHGsi7fNsEEhCRhoVpyUIIXA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-Dii1i3dvNiq88WAsXX-IvA-1; Thu,
 25 Sep 2025 06:37:49 -0400
X-MC-Unique: Dii1i3dvNiq88WAsXX-IvA-1
X-Mimecast-MFC-AGG-ID: Dii1i3dvNiq88WAsXX-IvA_1758796669
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBEFA18004D8;
	Thu, 25 Sep 2025 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EEEF19560A2;
	Thu, 25 Sep 2025 10:37:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 07/19] virtio: switch to use vring_virtqueue for virtqueue_get variants
Date: Thu, 25 Sep 2025 18:36:56 +0800
Message-ID: <20250925103708.44589-8-jasowang@redhat.com>
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2c0c677cb6fc..9d084ee9f4d6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -817,11 +817,10 @@ static bool more_used_split(const struct vring_virtqueue *vq)
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
@@ -843,9 +842,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
-	i = virtio32_to_cpu(_vq->vdev,
+	i = virtio32_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->ring[last_used].id);
-	*len = virtio32_to_cpu(_vq->vdev,
+	*len = virtio32_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->ring[last_used].len);
 
 	if (unlikely(i >= vq->split.vring.num)) {
@@ -867,7 +866,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
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
@@ -2525,8 +2523,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
-				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
+				 virtqueue_get_buf_ctx_split(vq, len, ctx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
-- 
2.31.1

