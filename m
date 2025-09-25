Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B182FC02B
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796688; cv=none; b=t9P218esYwd4DFCH7BSv9sHxEIML0rKKYeeZwHnaJYcoe8Oz3FSSDcnpMc3lslP/zPCCg537K0tQVP8WAJY7sntebVhiT426+iNxUJh5lYQuCode8b4jIIRFn0TLk6ykipaaoDb9Le/m1irrBsDFIenUQiL3r8NG0Xk4ZGVBrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796688; c=relaxed/simple;
	bh=B5xA+ac81zYIhYc/+K2WNv21b+y7giMM4O33HDQSuh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ+JEaRArbGpFz3KFX8s+5n3m901gX2WQ4m6fYx9s0ghqNsaPpS5bdzLeTJUEZ5VNdV3Nts06sNQo1RnmwfqJ/ExX4dJUhtOUnvJRW3QEQI1Be2B36K9J1xcJC8nNWXyyvtXO8372cmJe1geN7C0sKNwvWm9cynqd3K7m+uWZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLlh3OoG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLlh3OoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNJ+gQqwInDlOP5Vb/dsZyS5rNI1v31bs1pRaNUkug8=;
	b=fLlh3OoG1W+H5KUjZUn0IZZROon6gFVMYPbakAv9tPl5Ebzs3nDHPFBXPeEEMqIwrS+syH
	81fQ2h3hRk0RSYRzWohF2scyZHL+El5l8Fe53LCnG8w+SQCSaSZvyEt3bJfLG+LEpvlv5x
	WiSdqBaud7hAr7DowEsxbyvGPAsBy58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-twEyC0GsOwG8HsxoVhTsEA-1; Thu,
 25 Sep 2025 06:37:58 -0400
X-MC-Unique: twEyC0GsOwG8HsxoVhTsEA-1
X-Mimecast-MFC-AGG-ID: twEyC0GsOwG8HsxoVhTsEA_1758796677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C0161944F01;
	Thu, 25 Sep 2025 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B58B519560B4;
	Thu, 25 Sep 2025 10:37:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 09/19] virtio_ring: use vring_virtqueue for enable_cb_delayed variants
Date: Thu, 25 Sep 2025 18:36:58 +0800
Message-ID: <20250925103708.44589-10-jasowang@redhat.com>
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
index f46ebc60f911..61ce9645c3a6 100644
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

