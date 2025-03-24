Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928E18C903
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795035; cv=none; b=I0tRKXM3BaIchcXE8V8/2sQmef/vjbEcSA5vweJXbNKRYU0qHe/pqpIRlu7EGYlC/R+64nSZ3qt9pKIlgF75PswwwtcN7+5qRHyko4TcSElWYuQnzkcTh1yPKJZxzHIFEGmTvjXOLigzSjoPTgPYNDKc6qxmDI8LPXw1MZj7ssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795035; c=relaxed/simple;
	bh=nKXVFXA0CbcIddtKOEHjsUB0FOH+m26VLfL1JE1MVzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=cFZUZ2RTUpj380k7GJsu+8GnExJ2Lq5sMCg17yHmrULAq4II+a7ZNfESyESvl5fwqFPVpLl5oV3zOYoxTQlIjYUeDgB442TebDB33kmGtVIHM3uDfkacvShoYiMa/7Wyiwn1j5exKey3L5HHqdseM1ic413g9pkBoenj5FHW0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tcpd7SLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tcpd7SLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxs8uX1LGHNzuthCHDwJFtSFLovJ+2YRpIYqKWi3xI0=;
	b=Tcpd7SLRN3eQhBMjjKiJ5Ok6J5B4wijiLGQ8cI9BrfN+d3pCLhKQGdjRj674hqxzaWOupd
	5u2hL0sqpYuJhbQbBIZ9/nVdfJw8cZFoKOcegYf9BI7e2u9y/+uHOvDnXcsjZixOnA2oVZ
	OJw3HSFpr/fvIt8oOIiewlseTxxAjfg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-b3Rzrof3MJC0crJMJMjk7g-1; Mon,
 24 Mar 2025 01:43:47 -0400
X-MC-Unique: b3Rzrof3MJC0crJMJMjk7g-1
X-Mimecast-MFC-AGG-ID: b3Rzrof3MJC0crJMJMjk7g_1742795026
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2EE619560BA;
	Mon, 24 Mar 2025 05:43:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D787C180A801;
	Mon, 24 Mar 2025 05:43:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
Date: Mon, 24 Mar 2025 13:43:15 +0800
Message-ID: <20250324054333.1954-2-jasowang@redhat.com>
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

To be consistent with virtqueue_reset().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fdd2d2b07b5a..1bdfd5d617a7 100644
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
2.42.0

