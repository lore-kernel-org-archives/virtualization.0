Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1451993B9
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795046; cv=none; b=GKKCnYD+ydAppQuwZFLgUgXOPsH51Yss5RLz2/Gw9ltOV1Ze2YHnN+0bYsScsP84mtA0IRR7UJfgXvDJ1Pm3Sx9Vbwwycc7bsaKCMbZz1E5Ycf9uGg+hGHde+W/ARUIAPiDkr70k6IBEirV0JKKYxmUp9GN3gznFPO6lVapNRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795046; c=relaxed/simple;
	bh=3whpsnhGTwUAfeBzLaxQD80A/SMolrksmi0xjYpWNFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ZZsm5WmUwJyubDjuA+zL2yUQAHD/nIyCe811iIESXHNKQfxWSZAiBLgxEt29l5jx1eL6joSXGAbJNeSc5h5Bk2UO87dp7LreX0I5DqbdBDS3zVQ+dBvtvnk9CU80IWMFO9t8Pl0LA2s/gmhZQHRvhOPhD+gcztXajs3lZu69aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy9On/eF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy9On/eF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IDlKm+rIsBqOy2WrUFEuB1PZBXvJopiIjic+RfUCyE=;
	b=gy9On/eFKiMON4c5SL/n+jgElsawwCUgAi1dB29eMLDRT9hfUPQ+kt2Cz+Bf2nd6B8Z7/r
	JMjBMV72KnVqDb62U02RiM6qIyEhsG4pwq9MHNElE6+I3DCPDPYvqeHlgQwfQTuKwSE9zd
	a5uJFQvT4htr+FpxRmSqwVMBAR8hbOU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-hfVzdyT0Mp-ACI9YUSejTQ-1; Mon,
 24 Mar 2025 01:44:00 -0400
X-MC-Unique: hfVzdyT0Mp-ACI9YUSejTQ-1
X-Mimecast-MFC-AGG-ID: hfVzdyT0Mp-ACI9YUSejTQ_1742795039
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84216196D2D6;
	Mon, 24 Mar 2025 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E281D180B485;
	Mon, 24 Mar 2025 05:43:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] virtio_ring: switch to use vring_virtqueue for virtqueue resize variants
Date: Mon, 24 Mar 2025 13:43:18 +0800
Message-ID: <20250324054333.1954-5-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
References: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9172f3a089a0..94ce711963e6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1216,11 +1216,10 @@ static struct virtqueue *vring_create_virtqueue_split(
 	return vq;
 }
 
-static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_split(struct vring_virtqueue *vq, u32 num)
 {
 	struct vring_virtqueue_split vring_split = {};
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	struct virtio_device *vdev = vq->vq.vdev;
 	int err;
 
 	err = vring_alloc_queue_split(&vring_split, vdev, num,
@@ -2183,11 +2182,10 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	return vq;
 }
 
-static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
 {
 	struct vring_virtqueue_packed vring_packed = {};
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	struct virtio_device *vdev = vq->vq.vdev;
 	int err;
 
 	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_dev(vq)))
@@ -2805,9 +2803,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		recycle_done(_vq);
 
 	if (vq->packed_ring)
-		err = virtqueue_resize_packed(_vq, num);
+		err = virtqueue_resize_packed(vq, num);
 	else
-		err = virtqueue_resize_split(_vq, num);
+		err = virtqueue_resize_split(vq, num);
 
 	return virtqueue_enable_after_reset(_vq);
 }
-- 
2.42.0

