Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09B2BB17
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767077239; cv=none; b=tifJizGozHa9BiZyDNLQKYb1VJZijIVyZNKVnuhH1WGc8rA5b9dA9AIx9NYC3KTb4bLiJiSCOHNsHXVRIK+ZFGTcSjkICwxCd1J0kVMHi90VvdwFUF9w1q/H4boOAUbY+bpKj90tMx4529krD9RdXdThBBrefvC44/VkI+/rbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767077239; c=relaxed/simple;
	bh=aQYA6vyQ9HWcS/gGRHGCU43TQQaCLHZPZJmr5ol0iIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2wrQo4OSruFFCzKHVnSnGD7abENt3goK7wHhJcibF6JKC9Ta41ZLhx6fOaBJ5IRHS94cBFJW3EspB1HghoKE04XHpP1M6JXD/jDM6AhHoK9sRwJ7ZFwC0dCJMWru88zlq+DRG2RfL8UK0W9vqd3j6Rn/rp2RjI3t6Zmj5veXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Citn+8Q0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Citn+8Q0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767077235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGYNGtV0a+1q20vKU+i0OW5XBJofD4LOIx8feJsdmD8=;
	b=Citn+8Q0ojVyBaxIwLauwD0jnzKITRrtMsdW4GOWlfBK3fqFCnc45Dnh/nhri5RPIk+K3o
	KNj3HQ8hXgsSfBiLJNisazTNPdLcWNUix9vz/+ok2o/MO4A65l/KcMqeSowvbWw8YHthFc
	1tgE+cWYenRbu/QJe+hiAZa9sZecJ/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-i-BAEVugOxqWJUo3rIPLkg-1; Tue,
 30 Dec 2025 01:47:12 -0500
X-MC-Unique: i-BAEVugOxqWJUo3rIPLkg-1
X-Mimecast-MFC-AGG-ID: i-BAEVugOxqWJUo3rIPLkg_1767077231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC0C419560B2;
	Tue, 30 Dec 2025 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C98119560AB;
	Tue, 30 Dec 2025 06:47:08 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 04/19] virtio_ring: switch to use vring_virtqueue for virtqueue resize variants
Date: Tue, 30 Dec 2025 14:46:34 +0800
Message-ID: <20251230064649.55597-5-jasowang@redhat.com>
In-Reply-To: <20251230064649.55597-1-jasowang@redhat.com>
References: <20251230064649.55597-1-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a32050e1aa47..3fe4c2f63dfa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1221,11 +1221,10 @@ static struct virtqueue *vring_create_virtqueue_split(
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
@@ -2182,11 +2181,10 @@ static struct virtqueue *vring_create_virtqueue_packed(
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
 
 	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vq->map))
@@ -2809,9 +2807,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		recycle_done(_vq);
 
 	if (vq->packed_ring)
-		err = virtqueue_resize_packed(_vq, num);
+		err = virtqueue_resize_packed(vq, num);
 	else
-		err = virtqueue_resize_split(_vq, num);
+		err = virtqueue_resize_split(vq, num);
 
 	err_reset = virtqueue_enable_after_reset(_vq);
 	if (err_reset)
-- 
2.31.1

