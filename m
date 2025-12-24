Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CC327BF9
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536439; cv=none; b=d36eBsYjyg9bYYTOOkdWyXkVIxdN2COMSd8v1uRycXOymLZABFexBSjBSV7lCv2Gd2f8sRl9/RSb/8QDKJbfYvMETfy7M7uZAH1abqIekH8pRETaA0Ek7ieIO30GXr9GI8Wh5oZlxN8uva++SxOWw8t42pAU7RxXnrH6VoGXwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536439; c=relaxed/simple;
	bh=gBHebrMoKJITwEefOtcmwnB1A793iYd1frO9uIC0rEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJMNiM/vH+FB51k1UhWAZXWQTpfmsvAYdeGIh5bNDDnKt3PttSUTMsK0iLj4gD22DhLEUjzk9CIkN5WQeiMXRH02f5UpOWh14XJRuObtfDIrBdyaZf6QVeDP1k61qHz9oeWIkcC5kNnL9rNjTc82yLWsz3p9VPpP9iXFCG+1Czo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF7dcbbm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF7dcbbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QV3PF5uZrU6S5SJP/dZWzDFLrf6/r2tdzoIeK9vlmU=;
	b=dF7dcbbm9xWsfewL8WxrnLIvM/sahbUPnfxzIiXeq2xtH5p9tF0kRq9JJ2OEt/wgSefTPT
	pbFlS3tyAN5HVLbITBixX1kRgpRvsq9xikMGtmkhQCKJiSp9OrcNcnZR/1zw+bcU87w1Sq
	0af8iF6PyzDA/TYRhbKvILr4K2y38W8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-OUS_jOzuOfGoR1MCFpJdxA-1; Tue,
 23 Dec 2025 19:33:53 -0500
X-MC-Unique: OUS_jOzuOfGoR1MCFpJdxA-1
X-Mimecast-MFC-AGG-ID: OUS_jOzuOfGoR1MCFpJdxA_1766536433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F09741800365;
	Wed, 24 Dec 2025 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E19B81956053;
	Wed, 24 Dec 2025 00:33:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 09/19] virtio_ring: use vring_virtqueue for enable_cb_delayed variants
Date: Wed, 24 Dec 2025 08:32:59 +0800
Message-ID: <20251224003309.23432-10-jasowang@redhat.com>
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
index 8ffe7daa1e5f..00de30862777 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -922,9 +922,8 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq
 	return last_used_idx;
 }
 
-static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
+static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 bufs;
 
 	START_USE(vq);
@@ -938,7 +937,7 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
 		if (!vq->event)
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
 	/* TODO: tune this threshold */
@@ -946,9 +945,9 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 
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
 
@@ -2635,8 +2633,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		data_race(vq->event_triggered = false);
 
-	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
-				 virtqueue_enable_cb_delayed_split(_vq);
+	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
+				 virtqueue_enable_cb_delayed_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
-- 
2.31.1

