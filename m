Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBEC2FA0E8
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796661; cv=none; b=QkShxCCSGa3UYJFbgMjr8/UJC3CvXEer/LJ4q4eIpwuLocgWC/tItIP4vQf2dTA6sml16vnsQnqX8VbAXwdxvxVpKe3d4SjVHXKgll27RlakL7bTq+vlllzcbB6InnnYf5dgLjOLoXxjMiKitA6uLIIkwAIGsnLm6YWbkemF7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796661; c=relaxed/simple;
	bh=92dzLgz7GPIFGxrV7u59xZvyZkD4ZOwGTYSuMOriM2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT6zESoTCOPSkgmoOBBVsDtqkNIxQnZj5Kuoy2/V6McD/hwpcLkO+rJA1SQdrdZTn2lYqhb0//qfRK2hw29jfN2ehZJL51K6ZB1clXSqKVhou7uWU4D3kXPEYqH0GeEhstAhaRdYnT4PowkQVJZqVsgLEdYfXgGIK3wx68ByDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehp57YFM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehp57YFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9X+8nJzs108oA3zz8mRtrO71MkKZ7x5Ta9F7UOdDxY=;
	b=ehp57YFM6JQX2g6R8lLT2YqcqbeoOEmLfR7dosViEYdUbqV2cl0csAt4nbcIicTprfEDr9
	xJSw+3x/BdVSMt18/XiB3c5ca/x0YcnpPDo3HLBU8fnwtZVoicgbXfQ3ZQAHCWAn1FLwte
	ZOLLbK79TKFJUe1tln4qTYPkHjPWz6c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-Y14z60JVO7OgH1jLY6LuYg-1; Thu,
 25 Sep 2025 06:37:37 -0400
X-MC-Unique: Y14z60JVO7OgH1jLY6LuYg-1
X-Mimecast-MFC-AGG-ID: Y14z60JVO7OgH1jLY6LuYg_1758796656
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D58419560AD;
	Thu, 25 Sep 2025 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEBF719560A2;
	Thu, 25 Sep 2025 10:37:32 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 04/19] virtio_ring: switch to use vring_virtqueue for virtqueue resize variants
Date: Thu, 25 Sep 2025 18:36:53 +0800
Message-ID: <20250925103708.44589-5-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d8a07e0d9fa8..693671bac841 100644
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

