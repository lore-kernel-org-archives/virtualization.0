Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB52FF157
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796688; cv=none; b=to71+y4DPDWgbKzlBdcXSF/7ijZ5FheqfUjEYhbusmJIg6YtXVNieGDLreQhXtB0lrK5uk2yEhPxOFAYHzg/Yh/xDJlERUXjlHJ8nt4Vax2UTZjG2P/8cX7g1U5MkQve+x7+lxjOEv56Mwl8sH6YsW+o8bktobHJ/WUOKKumU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796688; c=relaxed/simple;
	bh=RR0+NM9tP19wOBCCAz+KfyimeAaDE1SQocegbFBadpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZtpSN9IMwccew9g/33h1E4VnyAAUe4VYEW1C0sT+QVfg5238w9d0XxGdf7ipcUlnYoZ5vd3Mjj+MxGgNL9LgNfDjibUJgvTWUh0SrX0/K4uk2u06Egk73xc4iI4ScC2vfi9c0QnHKzm7JwtaMBsDI0ZqKA3FyotZCDkgvStnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HexhY4Ox; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HexhY4Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rt9CavJgBPAgRO3Nlj+9uYFblWnPYDRcaD5WdFy9CE0=;
	b=HexhY4OxdFt+d13siakOSHur7GfH+ZxDyzrKG3CmIBiOX7o/z7a1f98EjMpIOy/RcJzTgh
	+5zwYmzx7kfUIBg1k+oX74ZTUpoycy+flYBQmoZSJCUkrFva7S+3GEqmeoWBBG6oqvgvJl
	khZagJjgZcwTYP9rFQolt31XsQkYF94=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-ESTAQi56N3C_6srNU2E9Kg-1; Thu,
 25 Sep 2025 06:38:01 -0400
X-MC-Unique: ESTAQi56N3C_6srNU2E9Kg-1
X-Mimecast-MFC-AGG-ID: ESTAQi56N3C_6srNU2E9Kg_1758796681
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF9A819560B6;
	Thu, 25 Sep 2025 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D380819560A2;
	Thu, 25 Sep 2025 10:37:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 10/19] virtio_ring: switch to use vring_virtqueue for disable_cb variants
Date: Thu, 25 Sep 2025 18:36:59 +0800
Message-ID: <20250925103708.44589-11-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 61ce9645c3a6..768933daba9a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -874,10 +874,8 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	return ret;
 }
 
-static void virtqueue_disable_cb_split(struct virtqueue *_vq)
+static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
 
@@ -893,7 +891,7 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
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
2.31.1

