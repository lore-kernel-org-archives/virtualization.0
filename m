Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D41A31
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414573; cv=none; b=eiEY8gwYX5Hj5DGmzwHpO8i2QbgKA8VGPuYzr9MwRdH6xN7ipXMYaPshYrDaBNE+cw1BGV9jILTRm5422uGgV6MJ6DBoiBh0Uuq5NcQ+KC9WPntVeIH9vPUR1wMbruMozQ8HmTuSyzTRe7nFze1UhmrmYoscXJbA4A4tulsCFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414573; c=relaxed/simple;
	bh=IJ/KOAmytt4wOhbFyhzo8KUmp6ypWMM3586tJjCc00A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2M3f6tBW44MWYBhL83+jWadvqwyI6u9CtIdRe4UmdiOTxSCsFubm0BBtGpQwCDzClVGlnCYYDHxIoSec6HB5TeY3mTs9R6UTJ/NudMYCrdJj6vXyAV6qunHqns+425DnQ15LAvyVHeH/nq4P/FAndvPgM3RPIE61YCb/gqRaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGrCAVR7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGrCAVR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748414570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TJYb7o6j2PzeSQH7x2/LCAQKNZXhlFC/F/8uf2zzO0=;
	b=eGrCAVR7RAYYhRLal1dIn9nRSwPJSfWiph78XJ+81NrMq9760utN6cxEhnntlM27QtymCu
	EceHU2XceXNTMjxxX6dexPlINGjbFmZmpUCO+TI7pv2s0/5ojUHb3OTeiKnnB6ql1c7uFf
	T7X8QJ11CLs/fa3zY6yyIriNxECsrvE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-Aw3R2HX_PgmWZBkSS1sb1w-1; Wed,
 28 May 2025 02:42:47 -0400
X-MC-Unique: Aw3R2HX_PgmWZBkSS1sb1w-1
X-Mimecast-MFC-AGG-ID: Aw3R2HX_PgmWZBkSS1sb1w_1748414566
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AD1B1800370;
	Wed, 28 May 2025 06:42:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.248])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB04C19560AB;
	Wed, 28 May 2025 06:42:42 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/19] virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
Date: Wed, 28 May 2025 14:42:16 +0800
Message-ID: <20250528064234.12228-2-jasowang@redhat.com>
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

To be consistent with virtqueue_reset().

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b784aab66867..afdd51fc3c9c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1005,7 +1005,7 @@ static void virtqueue_vring_init_split(struct vring_virtqueue_split *vring_split
 	}
 }
 
-static void virtqueue_reinit_split(struct vring_virtqueue *vq)
+static void virtqueue_reset_split(struct vring_virtqueue *vq)
 {
 	int num;
 
@@ -1248,7 +1248,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 err_state_extra:
 	vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
 err:
-	virtqueue_reinit_split(vq);
+	virtqueue_reset_split(vq);
 	return -ENOMEM;
 }
 
@@ -2092,7 +2092,7 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
 	vq->free_head = 0;
 }
 
-static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
+static void virtqueue_reset_packed(struct vring_virtqueue *vq)
 {
 	memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes);
 	memset(vq->packed.vring.driver, 0, vq->packed.event_size_in_bytes);
@@ -2219,7 +2219,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 err_state_extra:
 	vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
 err_ring:
-	virtqueue_reinit_packed(vq);
+	virtqueue_reset_packed(vq);
 	return -ENOMEM;
 }
 
@@ -2852,9 +2852,9 @@ int virtqueue_reset(struct virtqueue *_vq,
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

