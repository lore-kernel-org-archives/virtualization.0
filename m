Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E82D1F61
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267134; cv=none; b=LYW4rqrdt6Y8cQyp+GymYXEpZ3DeJ6GbYafBcyqToHrHra9tuoxScJGZCUwhz2/pS54PT012Xq4us9pOFUd+NsRJ/iTWVWzXuoJqNJmy4KNVHnL54LWt/dlzEGefgFkGEJCZQfB1B97TDgPP68bXY9LXm6Du5kPLPqVUhNMAnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267134; c=relaxed/simple;
	bh=Prhd+LkqoYp0VJ2YSuQDc0m2lgDkGgYa2aWwnVG/VQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No5qqg15acpJgYa5uS7ebRN5f38TzjqOFTMw0/dyLVoa5MxXRRQe6I4/lzXjTPZuBuil659QaMA3HcCj60ZIzLO/ZC7MiUaGJn3IbCh1BGYY4czsx66mVE8Ea0ZseK1hYJ6K19m6AJFCwPiSgk45LdrhDw0QwtykTNA7ICYdgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csqUvBu3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csqUvBu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HvYkyijRiL6uD+3Th5PyNitUXfDZOQ8r0roTL8rtAQ=;
	b=csqUvBu32Kxlta5NHGU/KfgdGEnnjEw5qcQLtf6Dp4QlwJ0Q9kuiFPt9uoXLyhpis/BC8K
	eA435wPEqK6WRY819a39mrhsoxnxNdbyL7FuPvrOIPkjrVsQSr0Alw5j9xJ4xtvvjiOdPE
	un2SC/scfy2Y/uFgN6c5SFzSEJPZkrw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-LGPLmJFWPKWtApI-EQLuCw-1; Fri,
 19 Sep 2025 03:32:07 -0400
X-MC-Unique: LGPLmJFWPKWtApI-EQLuCw-1
X-Mimecast-MFC-AGG-ID: LGPLmJFWPKWtApI-EQLuCw_1758267126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3992C18002D6;
	Fri, 19 Sep 2025 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D325F19560BB;
	Fri, 19 Sep 2025 07:32:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 01/19] virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
Date: Fri, 19 Sep 2025 15:31:36 +0800
Message-ID: <20250919073154.49278-2-jasowang@redhat.com>
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

To be consistent with virtqueue_reset().

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f91a432b3e53..73790593523a 100644
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

