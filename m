Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66EF2701BD
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062377; cv=none; b=CmNYbJtI9gDbEntDT4o4HGW5PFmTyXpxG9Xt23YfNUy4kvEpIrg0KFpTCw9QnxF0oGx6hCoXG+AeQZPWhdStjWPXBvWFuOSdFPgVXp6SJETtUdMR0BfjhWMT0PKfZoJ4+U82tOa7W0t2jlRak0UE9R5fcGmatoXN3QinppIdK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062377; c=relaxed/simple;
	bh=pwqlNXqiThwXkwZ8WdEDyRZWZBWmhdcncW6BgL9BrcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4qRoZGSKgow925QnOr1HlL7ig5OjIL5QfLxnbWSejtA1w91tapd1doCyXIZV+OxHVqJEW99z+L8mcQWV7GDjUbDO0ye2M9fz1KGYFqroJ45C/5pbDIuYPoOak/rBkmb78jTM29LfDWOxL3Mbr3FjQFc2HXEHt1z1cs8k6J1t+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M94ZoSKo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M94ZoSKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750062374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIjPOYFvozYojOMPnuFJOvuLP8xgwC21YPpzEJOgj1Y=;
	b=M94ZoSKoSbrxyFJHO8KcJqpqqYzM089nLwLVffNgioJAJ6RxK8mgNDb1bSrqOiDUUVaBfZ
	f2QHOEVnhAqmckle0hdNG71GSLLCWyF2P3fYeV6392KBqQFpmho0EJc8ZIMnQTFBsTOf0E
	S0dTazcY3IdindoXGK3yyQDKMoqXmrA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-GNC6ExIaNXCAsj2VrGTR0w-1; Mon,
 16 Jun 2025 04:26:11 -0400
X-MC-Unique: GNC6ExIaNXCAsj2VrGTR0w-1
X-Mimecast-MFC-AGG-ID: GNC6ExIaNXCAsj2VrGTR0w_1750062370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ED1318001C6;
	Mon, 16 Jun 2025 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C522618002B6;
	Mon, 16 Jun 2025 08:26:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 11/19] virtio_ring: switch to use vring_virtqueue for detach_unused_buf variants
Date: Mon, 16 Jun 2025 16:25:09 +0800
Message-ID: <20250616082518.10411-12-jasowang@redhat.com>
In-Reply-To: <20250616082518.10411-1-jasowang@redhat.com>
References: <20250616082518.10411-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4af29a6e15e8..03b17bc275dd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -950,9 +950,8 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
 	void *buf;
 
@@ -965,7 +964,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 		buf = vq->split.desc_state[i].data;
 		detach_buf_split(vq, i, NULL);
 		vq->split.avail_idx_shadow--;
-		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
 				vq->split.avail_idx_shadow);
 		END_USE(vq);
 		return buf;
@@ -1892,9 +1891,8 @@ static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
 	void *buf;
 
@@ -2642,8 +2640,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
-				 virtqueue_detach_unused_buf_split(_vq);
+	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
+				 virtqueue_detach_unused_buf_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
-- 
2.34.1

