Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2A2441B8
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414603; cv=none; b=V16aNTPeM/vMfXYRuFIgWx5o/wxUcBlgEojm4w91CWndkyCjwhBIgTEqn44z+GcXrvUesdV+RpGqUDBapQ6fHs0aTqFTpRARLkN/n6aq3O/X9Q71O+qFiQWjM7le0c9hpoIexFHBNC3ZEmyKb4X7Tagk7NAV/QYRa7xiM3ZEZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414603; c=relaxed/simple;
	bh=5cKMIftcWdlfOib1L9tDa1RESlq+sAyUF9vc5bjfjrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJHwoZF0c+2RqRsevs6SqbBPRPoQa5sN4uLw0yIT5hPDySWPUl4fsDFX0jeywFioeNc4K0v97Jrep1Z8Pif1X24b/PV1YihsInvPQpArDsT1Y0Q5MEaQyA6tlzjE7le5X5uJ+/Zvqu1euk7XM40TxQO7mUBdr/xwmfgXa4AuJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGRTgP3C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGRTgP3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748414599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FaQG3uYyypQlTVLhPm84s++OnF8xfHROHlBC851E4Y=;
	b=MGRTgP3Cp5i6oAbvH4QZrHXoGh8R2d7t0EaE1I7UPRGp4/UsPx3EGwmby28ISlNCfNHIEv
	HeiY9ZL+JC7Z9k6gJaEOAq5heL4QEZ42sO+DWTHyrKqpSrvUWPFMUI2em5D7COirDvCGlZ
	zO1LMGkk6fhxMjF4ugyYsvkdlZOIWuY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-Z3aDR1xnPnqxmkKCerMBYg-1; Wed,
 28 May 2025 02:43:16 -0400
X-MC-Unique: Z3aDR1xnPnqxmkKCerMBYg-1
X-Mimecast-MFC-AGG-ID: Z3aDR1xnPnqxmkKCerMBYg_1748414595
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45C3518002A5;
	Wed, 28 May 2025 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.248])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9633C1956095;
	Wed, 28 May 2025 06:43:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/19] virtio_ring: switch to use vring_virtqueue for enable_cb_prepare variants
Date: Wed, 28 May 2025 14:42:23 +0800
Message-ID: <20250528064234.12228-9-jasowang@redhat.com>
In-Reply-To: <20250528064234.12228-1-jasowang@redhat.com>
References: <20250528064234.12228-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4e70b7eb127f..8c18f3edda00 100644
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
@@ -2568,8 +2565,8 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
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

