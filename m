Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC6194C61
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796120; cv=none; b=W4OLLg3UnAVk+Rvea471ADKMbVfm+rpAUDfvvNPPx1T4V520aNjMz9Wf7SMys51oV856T0VHh9Io6wFr21gXSXlQ2mau9XYpSOVDr38xGwQlIhrfqRKINUKkIvDVFTxmuuqxtHkgmvppz6xQaLACdKMVGOUSVfJc7M8fqIwYqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796120; c=relaxed/simple;
	bh=xoLQem32KMSkfsoy2FKamec+4aq4FI2AQs4ITLVEXk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Ji4LScH7EwM08YOMSBYSv3/Zs81V0ugEeTonnncra3IUtDvux27flZYTx28hz1YVDZEkApVkQhr5bL9Ug+tnSTnV6Algg1YEZGjXg8KSW+RqClW5nwWh2XYB1t1sk3oYPqg0ryxw03ivX+yHOJ/LsEVfNCi0fyJqoi86q1jINVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuMtzTPj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuMtzTPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742796117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yA8myHOGPKiovA0IjDvvLZnrHq993RMPy+xzEtq4Gvc=;
	b=BuMtzTPjPYZcm8qSFXJMavv4XEuuG9pAU5SH/5nf058mU3Wc5vwO+K2cX5SZD2++mz5PHJ
	EpPCanCJufo+rLXohCjzy1XDmeDyZ8L6tocY7WjlwUTDDX/VgIoYJJmRANPRiX65M4Jws8
	neqVVDxWOGsacH/8tGHdksBmkMWaH9g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-bJM9cgzqNYOaQawHTwe4DA-1; Mon,
 24 Mar 2025 02:01:53 -0400
X-MC-Unique: bJM9cgzqNYOaQawHTwe4DA-1
X-Mimecast-MFC-AGG-ID: bJM9cgzqNYOaQawHTwe4DA_1742796112
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B19B1933B41;
	Mon, 24 Mar 2025 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCFA6195609D;
	Mon, 24 Mar 2025 06:01:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] virtio_ring: move next_avail_idx to vring_virtqueue
Date: Mon, 24 Mar 2025 14:01:25 +0800
Message-ID: <20250324060127.2358-5-jasowang@redhat.com>
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

This variable is used by packed virtqueue now, moving it to
vring_virtqueue to make it possible to be reused by split virtqueue
in-order implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bd4faf04862c..a1a8cd931052 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -138,9 +138,6 @@ struct vring_virtqueue_packed {
 	/* Avail used flags. */
 	u16 avail_used_flags;
 
-	/* Index of the next avail descriptor. */
-	u16 next_avail_idx;
-
 	/*
 	 * Last written value to driver->flags in
 	 * guest byte order.
@@ -214,6 +211,9 @@ struct vring_virtqueue {
 	 */
 	u16 last_used_idx;
 
+	/* Index of the next avail descriptor. */
+	u16 next_avail_idx;
+
 	/* Hint for event idx: already triggered no need to disable. */
 	bool event_triggered;
 
@@ -448,6 +448,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
 	else
 		vq->last_used_idx = 0;
 
+	vq->next_avail_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
 
@@ -1350,7 +1351,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	u16 head, id;
 	dma_addr_t addr;
 
-	head = vq->packed.next_avail_idx;
+	head = vq->next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
 	if (!desc)
 		return -ENOMEM;
@@ -1431,7 +1432,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				1 << VRING_PACKED_DESC_F_AVAIL |
 				1 << VRING_PACKED_DESC_F_USED;
 	}
-	vq->packed.next_avail_idx = n;
+	vq->next_avail_idx = n;
 	vq->free_head = vq->packed.desc_extra[id].next;
 
 	/* Store token and indirect buffer state. */
@@ -1501,7 +1502,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 		/* fall back on direct */
 	}
 
-	head = vq->packed.next_avail_idx;
+	head = vq->next_avail_idx;
 	avail_used_flags = vq->packed.avail_used_flags;
 
 	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
@@ -1569,7 +1570,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 	vq->vq.num_free -= descs_used;
 
 	/* Update free pointer */
-	vq->packed.next_avail_idx = i;
+	vq->next_avail_idx = i;
 	vq->free_head = curr;
 
 	/* Store token. */
@@ -1633,8 +1634,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 	 */
 	virtio_mb(vq->weak_barriers);
 
-	old = vq->packed.next_avail_idx - vq->num_added;
-	new = vq->packed.next_avail_idx;
+	old = vq->next_avail_idx - vq->num_added;
+	new = vq->next_avail_idx;
 	vq->num_added = 0;
 
 	snapshot.u32 = *(u32 *)vq->packed.vring.device;
@@ -2083,7 +2084,6 @@ static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring_p
 static void virtqueue_vring_init_packed(struct vring_virtqueue_packed *vring_packed,
 					bool callback)
 {
-	vring_packed->next_avail_idx = 0;
 	vring_packed->avail_wrap_counter = 1;
 	vring_packed->event_flags_shadow = 0;
 	vring_packed->avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
@@ -2977,7 +2977,7 @@ u32 vring_notification_data(struct virtqueue *_vq)
 	u16 next;
 
 	if (vq->packed_ring)
-		next = (vq->packed.next_avail_idx &
+		next = (vq->next_avail_idx &
 				~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))) |
 			vq->packed.avail_wrap_counter <<
 				VRING_PACKED_EVENT_F_WRAP_CTR;
-- 
2.42.0

