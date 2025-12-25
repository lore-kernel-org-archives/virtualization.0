Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF312D46D9
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636787; cv=none; b=VsCGhobmIXPpzJZMDurbP/LR8NYm7r7RXrPhIGa9K7bTOrZEdkqaQo+lriBOreD6Dyr/W9GAO5mtLTEeqUcFzqcZs3KYtriIePHZ29w8Q9agXzefdBUzVUtF+io7fy1Jjt0GaQxzOLAWQMIVZBXLmPdUFMe6HYJjOcOayODc6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636787; c=relaxed/simple;
	bh=3mJIVRuiBRr1DGrHmxdE+1bQyeQNd0+hbYY6OL8YR1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A70bBqZ4uCMGBc6NKt9nj4Rk81ZLokzkyTGNwFmDRL8dN7p1tqxB4UxASsB1sH2ELSejlbuwdu6CxGpV4BWKbd+2p+IDGIAMBkU6zhbdQdh4M7kKtHNm3mkNybsZrC6Jz91yjcJ8DTK48/1mVtTr4tK4yw3p7G48rvbVEG/F34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ie8Q0jj8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie8Q0jj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766636784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wc3TM+0azwY6MCNmOZiraFDZZINoIrGASd58ariBiQM=;
	b=ie8Q0jj8ZFBcqIb+995jJFLmKiWlX9F0qwxoLBCnzDiN1XFXdZp5vKRsHud5hN06Ylkw3o
	uleDcoCEznXoV+3928R6ay85FNvRroiZGqJRHdLNj2Zw9Y9uoO5y7gP3ZigCt0OL0qQrDJ
	BvKOcGtytgiJPMIzA6e6xc0TpQ/SNuc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-tPw47f_fPfaWyrsOXfNgmw-1; Wed,
 24 Dec 2025 23:26:20 -0500
X-MC-Unique: tPw47f_fPfaWyrsOXfNgmw-1
X-Mimecast-MFC-AGG-ID: tPw47f_fPfaWyrsOXfNgmw_1766636779
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7461A195DE48;
	Thu, 25 Dec 2025 04:26:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E10B0180045B;
	Thu, 25 Dec 2025 04:26:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 01/19] virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
Date: Thu, 25 Dec 2025 12:25:50 +0800
Message-ID: <20251225042608.32350-2-jasowang@redhat.com>
In-Reply-To: <20251225042608.32350-1-jasowang@redhat.com>
References: <20251225042608.32350-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

To be consistent with virtqueue_reset().

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ddab68959671..cc1b8bbc6774 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1009,7 +1009,7 @@ static void virtqueue_vring_init_split(struct vring_virtqueue_split *vring_split
 	}
 }
 
-static void virtqueue_reinit_split(struct vring_virtqueue *vq)
+static void virtqueue_reset_split(struct vring_virtqueue *vq)
 {
 	int num;
 
@@ -1253,7 +1253,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 err_state_extra:
 	vring_free_split(&vring_split, vdev, vq->map);
 err:
-	virtqueue_reinit_split(vq);
+	virtqueue_reset_split(vq);
 	return -ENOMEM;
 }
 
@@ -2091,7 +2091,7 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
 	vq->free_head = 0;
 }
 
-static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
+static void virtqueue_reset_packed(struct vring_virtqueue *vq)
 {
 	memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes);
 	memset(vq->packed.vring.driver, 0, vq->packed.event_size_in_bytes);
@@ -2218,7 +2218,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 err_state_extra:
 	vring_free_packed(&vring_packed, vdev, vq->map);
 err_ring:
-	virtqueue_reinit_packed(vq);
+	virtqueue_reset_packed(vq);
 	return -ENOMEM;
 }
 
@@ -2860,9 +2860,9 @@ int virtqueue_reset(struct virtqueue *_vq,
 		recycle_done(_vq);
 
 	if (vq->packed_ring)
-		virtqueue_reinit_packed(vq);
+		virtqueue_reset_packed(vq);
 	else
-		virtqueue_reinit_split(vq);
+		virtqueue_reset_split(vq);
 
 	return virtqueue_enable_after_reset(_vq);
 }
-- 
2.31.1

