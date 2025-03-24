Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1346130AC8
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796103; cv=none; b=lDvqHvEwhWaDlymJCZIR6I/d4sTP5RhJSK0kFpCn9RdWFl2aISm39IKU3SqwK0NMaUfDKM4JcR9XhWxHWt1PvikLuu8gj2XfVXeHosQ4EGKd8C1zsI/yKMsenVB9TGqsmhOzpvwIl0iyshXt+PpAQdvC/IB6Tmryyn8CapWbsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796103; c=relaxed/simple;
	bh=OuNt9+hDie5r6ArjlBvG5ifTkqcH2+hPugYa99BdGB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=bSDxu3i6MIotbghj3Yy3xV4V47Dc6283QhJR7m7e4n6pNqiu7uMTpMdceqlnzMC9/7GNYBruw0pSHCeJ29IN2PcCXJncNklzF8yc0i0Zs3Oju9BN/C4E2ctVRx0NPUV+CucwdCAjhRu1I2UbACjgpgAPIZ9MIpA65re0JsH1aWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTRGCE8B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTRGCE8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742796099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srWHszPUHBDmYMTgnKpxVCfXF+Z/YXzGNxKbi9mYgtI=;
	b=fTRGCE8BoyOeS6syZ82TaNFcghGgGDuiI+s+hQ/EZiYa0ry20+/CDek0a+beXOFTUz2b+V
	6O/9thwSDf91SteVxCEJkhoHFrvzcU4ADQIRqid68lDuJQ9OdbGkVp2jV30A/6jl/I4IhN
	K0GEQpkKO73sOncU6DzVf+12Skjlsus=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-no_hPh0LMrWwkgQzjlvzPA-1; Mon,
 24 Mar 2025 02:01:35 -0400
X-MC-Unique: no_hPh0LMrWwkgQzjlvzPA-1
X-Mimecast-MFC-AGG-ID: no_hPh0LMrWwkgQzjlvzPA_1742796094
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 772BE18EBE99;
	Mon, 24 Mar 2025 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4E64195609D;
	Mon, 24 Mar 2025 06:01:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] virtio_ring: introduce virtqueue ops
Date: Mon, 24 Mar 2025 14:01:21 +0800
Message-ID: <20250324060127.2358-1-jasowang@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch introduces virtqueue ops which is a set of the callbacks
that will be called for different queue layout or features. This would
help to avoid branches for split/packed and will ease the future
implementation like in order.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 29 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a2884eae14d9..ce1dc90ee89d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
 	size_t event_size_in_bytes;
 };
 
+struct vring_virtqueue;
+
+struct virtqueue_ops {
+	int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
+		   unsigned int total_sg, unsigned int out_sgs,
+		   unsigned int in_sgs,	void *data,
+		   void *ctx, bool premapped, gfp_t gfp);
+	void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
+	bool (*kick_prepare)(struct vring_virtqueue *vq);
+	void (*disable_cb)(struct vring_virtqueue *vq);
+	bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
+	unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
+	bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx);
+	void *(*detach_unused_buf)(struct vring_virtqueue *vq);
+	bool (*more_used)(const struct vring_virtqueue *vq);
+	int (*resize)(struct vring_virtqueue *vq, u32 num);
+	void (*reset)(struct vring_virtqueue *vq);
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
+	struct virtqueue_ops *ops;
+
 	/* Is this a packed ring? */
 	bool packed_ring;
 
@@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	return 0;
 }
 
+struct virtqueue_ops split_ops;
+
 static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 					       struct vring_virtqueue_split *vring_split,
 					       struct virtio_device *vdev,
@@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 		return NULL;
 
 	vq->packed_ring = false;
+	vq->ops = &split_ops;
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
@@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
 	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
 }
 
+struct virtqueue_ops packed_ops;
+
 static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 					       struct vring_virtqueue_packed *vring_packed,
 					       struct virtio_device *vdev,
@@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 	vq->broken = false;
 #endif
 	vq->packed_ring = true;
+	vq->ops = &packed_ops;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 
@@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
 	return -ENOMEM;
 }
 
+struct virtqueue_ops split_ops = {
+	.add = virtqueue_add_split,
+	.get = virtqueue_get_buf_ctx_split,
+	.kick_prepare = virtqueue_kick_prepare_split,
+	.disable_cb = virtqueue_disable_cb_split,
+	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
+	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
+	.poll = virtqueue_poll_split,
+	.detach_unused_buf = virtqueue_detach_unused_buf_split,
+	.more_used = more_used_split,
+	.resize = virtqueue_resize_split,
+	.reset = virtqueue_reset_split,
+};
+
+struct virtqueue_ops packed_ops = {
+	.add = virtqueue_add_packed,
+	.get = virtqueue_get_buf_ctx_packed,
+	.kick_prepare = virtqueue_kick_prepare_packed,
+	.disable_cb = virtqueue_disable_cb_packed,
+	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
+	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
+	.poll = virtqueue_poll_packed,
+	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
+	.more_used = more_used_packed,
+	.resize = virtqueue_resize_packed,
+	.reset = virtqueue_reset_packed,
+};
+
 static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
 					 void (*recycle)(struct virtqueue *vq, void *buf))
 {
@@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, premapped, gfp) :
-				 virtqueue_add_split(vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, premapped, gfp);
+	return vq->ops->add(vq, sgs, total_sg,
+			    out_sgs, in_sgs, data, ctx, premapped, gfp);
 }
 
 /**
@@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
-				 virtqueue_kick_prepare_split(vq);
+	return vq->ops->kick_prepare(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
 
@@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
-				 virtqueue_get_buf_ctx_split(vq, len, ctx);
+	return vq->ops->get(vq, len, ctx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
@@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (vq->packed_ring)
-		virtqueue_disable_cb_packed(vq);
-	else
-		virtqueue_disable_cb_split(vq);
+	return vq->ops->disable_cb(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
@@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
-				 virtqueue_enable_cb_prepare_split(vq);
+	return vq->ops->enable_cb_prepare(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
@@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 		return false;
 
 	virtio_mb(vq->weak_barriers);
-	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
-				 virtqueue_poll_split(vq, last_used_idx);
+	return vq->ops->poll(vq, last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
@@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
-				 virtqueue_enable_cb_delayed_split(vq);
+	return vq->ops->enable_cb_delayed(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
@@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
-				 virtqueue_detach_unused_buf_split(vq);
+	return vq->ops->detach_unused_buf(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
 static inline bool more_used(const struct vring_virtqueue *vq)
 {
-	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
+	return vq->ops->more_used(vq);
 }
 
 /**
@@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	if (recycle_done)
 		recycle_done(_vq);
 
-	if (vq->packed_ring)
-		err = virtqueue_resize_packed(vq, num);
-	else
-		err = virtqueue_resize_split(vq, num);
+	err = vq->ops->resize(vq, num);
 
 	return virtqueue_enable_after_reset(_vq);
 }
@@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
 	if (recycle_done)
 		recycle_done(_vq);
 
-	if (vq->packed_ring)
-		virtqueue_reset_packed(vq);
-	else
-		virtqueue_reset_split(vq);
+	vq->ops->reset(vq);
 
 	return virtqueue_enable_after_reset(_vq);
 }
-- 
2.42.0

