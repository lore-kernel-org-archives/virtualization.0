Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C0194C61
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795041; cv=none; b=BDlZuP7lAsBFqZoB3OZ6ElVfnrbE7bsdDRI3cd+S1FwLou2CkfBNIVuyaxbTgfTy5Vo5m/tBCKRVorQniyVSMr3tydb1ZCzsph8ovj4YgQTyGjJuLaUqtFTT/6XkXXyGYqZgsBo37cuN8DTpc+uA8dlZaXgRqENoxWtiwR4h+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795041; c=relaxed/simple;
	bh=qKQwH8lHiS/lPHf2EJf5k8xzwYyUErvrnOOxhrnSTT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=H2LXmCMI1EspJ7wgfo6L4CjaCa+lgPia77zzUNSVLU14W8uG/QYLgY/EnRnJQjPOXdRSTlVuHWBONsMLRrT14CBahH138MwLQIkTyGIDzdV0vbKw9DmOx6EHdaqmfY4Vrqd94ik7Bceyn4Co3PnMsmYMHdL9C5rmTYkokgBW5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPbttlay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPbttlay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKNT69buHP7SlwCQ5P+qu4CXwgaLQ6om6LNmL9rxTkw=;
	b=hPbttlayMB7kMHP+ELtkWJNY3aj1NSAYtYz5PeYtAxiUXOtEARj8olsXwZS8WAaDH6GUEo
	3rueyWGr6XoA5efIyWCgEFqKqWzLCWUYne2lFCn/Zsg4lZWg2HTlA01U76E9GcVlWwWB6z
	J/9dowt9LSSorJJUJ2V2R1m+KpNqfl8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-b1NbBMA6PRWscQ1LqU8ptQ-1; Mon,
 24 Mar 2025 01:43:55 -0400
X-MC-Unique: b1NbBMA6PRWscQ1LqU8ptQ-1
X-Mimecast-MFC-AGG-ID: b1NbBMA6PRWscQ1LqU8ptQ_1742795035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C397F1809CA3;
	Mon, 24 Mar 2025 05:43:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37F7A180A801;
	Mon, 24 Mar 2025 05:43:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] virtio_ring: unify logic of virtqueue_poll() and more_used()
Date: Mon, 24 Mar 2025 13:43:17 +0800
Message-ID: <20250324054333.1954-4-jasowang@redhat.com>
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

This patch unifies the logic of virtqueue_poll() and more_used() for
better code reusing and ease the future in order implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 48 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1c6b63812bf8..9172f3a089a0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -802,12 +802,18 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	}
 }
 
-static bool more_used_split(const struct vring_virtqueue *vq)
+static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
+				 unsigned int last_used_idx)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
+	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
 }
 
+static bool more_used_split(const struct vring_virtqueue *vq)
+{
+	return virtqueue_poll_split(vq, vq->last_used_idx);
+}
+
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 					 unsigned int *len,
 					 void **ctx)
@@ -915,13 +921,6 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 	return last_used_idx;
 }
 
-static bool virtqueue_poll_split(struct vring_virtqueue *vq,
-				 unsigned int last_used_idx)
-{
-	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->idx);
-}
-
 static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1711,16 +1710,20 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static bool more_used_packed(const struct vring_virtqueue *vq)
+static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
 {
-	u16 last_used;
-	u16 last_used_idx;
-	bool used_wrap_counter;
+	bool wrap_counter;
+	u16 used_idx;
 
-	last_used_idx = READ_ONCE(vq->last_used_idx);
-	last_used = packed_last_used(last_used_idx);
-	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
-	return is_used_desc_packed(vq, last_used, used_wrap_counter);
+	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
+	used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+
+	return is_used_desc_packed(vq, used_idx, wrap_counter);
+}
+
+static bool more_used_packed(const struct vring_virtqueue *vq)
+{
+	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
 }
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
@@ -1844,17 +1847,6 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	return vq->last_used_idx;
 }
 
-static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
-{
-	bool wrap_counter;
-	u16 used_idx;
-
-	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
-	used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
-
-	return is_used_desc_packed(vq, used_idx, wrap_counter);
-}
-
 static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.42.0

