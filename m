Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C0224B1F
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339267; cv=none; b=fs8l67TCaWNMSPsWRd0oRnzDHkfxQ6yC5IxKBqpFyr+I+NhzeZP0JgzrhkBCrsLWBXhXdJlQsm02YUi6F5t0aTrCpbXuWMTF4zDtG00z2T0Pxixe8r8qssu8wcqua1Cu+oDOGrqb++9F7htIBpNe3LNWWzEQIaHT0vCZGUqei5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339267; c=relaxed/simple;
	bh=e9cz4fPspKJlc/1MR/bizpn9l2cVvyFX7vC5ULqOX1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kx7KJ2OdzlrEShZ4EW+LAU044xLQQwdBoVzPPPa3qgasH1L+gXNNOC/JTP/CbL1fQyNIdYjIAZsOfE4FPzMJmqMrzNH/O+H+hYQg+2kqzbE5Sswip5YL4NmVDIBb5nyk63uYB7fJLgQYmk7SNcphSnMTGOO12qlOVITh3Ppa2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjJ4MR7a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjJ4MR7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753339265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66yYxDS1mtYV0qB82OZU4piVLOScJngkEdFnKp8w3HQ=;
	b=WjJ4MR7aJmznv4+fwTkuev6h51Gd/QFiHssmMLdE20eMDerW1VdESuzOJfRkDbidb6Vtwx
	ZWjqxtwJtcEojTOyUDgoDHr7WooGa4kdtT6ftbhWAnhFpIZ+2sYfBqANHCxnPbo6QAflcl
	Syzf2AGKMplSUVeznIS2ptIMn2TpALE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-PNhFN8WmMJOnJf3s2yYWZQ-1; Thu,
 24 Jul 2025 02:41:01 -0400
X-MC-Unique: PNhFN8WmMJOnJf3s2yYWZQ-1
X-Mimecast-MFC-AGG-ID: PNhFN8WmMJOnJf3s2yYWZQ_1753339260
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EEC418002A2;
	Thu, 24 Jul 2025 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20E40180035E;
	Thu, 24 Jul 2025 06:40:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 08/19] virtio_ring: switch to use vring_virtqueue for enable_cb_prepare variants
Date: Thu, 24 Jul 2025 14:40:06 +0800
Message-ID: <20250724064017.26058-9-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f66ba25a50b1..fb0690890a39 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -893,9 +893,8 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used_idx;
 
 	START_USE(vq);
@@ -909,10 +908,10 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
 		if (!vq->event)
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
-	vring_used_event(&vq->split.vring) = cpu_to_virtio16(_vq->vdev,
+	vring_used_event(&vq->split.vring) = cpu_to_virtio16(vq->vq.vdev,
 			last_used_idx = vq->last_used_idx);
 	END_USE(vq);
 	return last_used_idx;
@@ -1807,10 +1806,8 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	START_USE(vq);
 
 	/*
@@ -2572,8 +2569,8 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
-				 virtqueue_enable_cb_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
+				 virtqueue_enable_cb_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
-- 
2.39.5

