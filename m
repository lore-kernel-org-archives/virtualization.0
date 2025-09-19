Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E82D77E6
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267161; cv=none; b=eiHrAmLkB7VjecGbCly2nTVyjX6yIgv+Qd+YNp3dOsiz802qDdkxoOWOivL8TN4Kii19aFmcG83nHabjC9Lm3I7Uhg5w/8nZpWY89JCjt9Jxv1VpPxOuSMNSXbdQJcPYa46UnBeA1F+Hsxy7nZt1arkkUMIdO5bONm4SETUiN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267161; c=relaxed/simple;
	bh=7zljtCVbcHvjJV3/tYZqzrREfe2J4B4MpPf8LrTkJnY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+rgE4kc2xh1bdprmLcTRfThdEwQUuj55bOdNTykN4opi6uxtfRlTfSbAoDIF7o4NXWdvs6tUEt3JLPFaWNIKC0oau5Lo3uJzTGCE4U37x4rDkw0rWQIrHvQC2ctEM3FjKo3yaWgpfwAYthcwcsdDIZkUlk0vLOuynWHBQKPat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnzAoV5r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnzAoV5r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3a8IWtyWZ8b41J55mepjRKgRGiV+wNXwzgNi9byEBXk=;
	b=YnzAoV5re8ejpEUJGApOscyVrtlM7iJyKzUc6hMREZT31FCC6rX1WUqGuZS7lDadWovdz6
	2heUofyy4egx1fcObpiYDJpWhMRDWmGI09G6T/f728vi+ruCUoOJcnoVIdV7WbcsXLQxGj
	V2dUOJzPxRxJe96nM21mdo38EUMT1cE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-CRV-S9O0OdywLU-1lRvc7w-1; Fri,
 19 Sep 2025 03:32:34 -0400
X-MC-Unique: CRV-S9O0OdywLU-1lRvc7w-1
X-Mimecast-MFC-AGG-ID: CRV-S9O0OdywLU-1lRvc7w_1758267153
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1DB1195609F;
	Fri, 19 Sep 2025 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEAC919560BB;
	Fri, 19 Sep 2025 07:32:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 08/19] virtio_ring: switch to use vring_virtqueue for enable_cb_prepare variants
Date: Fri, 19 Sep 2025 15:31:43 +0800
Message-ID: <20250919073154.49278-9-jasowang@redhat.com>
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
index 3625c7ed2fbb..cb013af446f9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -897,9 +897,8 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used_idx;
 
 	START_USE(vq);
@@ -913,10 +912,10 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
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
@@ -1806,10 +1805,8 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	START_USE(vq);
 
 	/*
@@ -2571,8 +2568,8 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
-				 virtqueue_enable_cb_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
+				 virtqueue_enable_cb_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
-- 
2.31.1

