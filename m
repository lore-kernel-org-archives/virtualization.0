Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506E2FA0C7
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767077242; cv=none; b=IVH5PAsw34P5mVSyFLnwkakao+Jd9tnxNiOr4Tv5k6krlcpYVK/AjCmocRL9V51gbMA3etz47S2pOZFteCPRWBtF8x6BCVS/3bV6Xv+zxKZwCG6Xz98tNkIcWXX7bXN99MTOgz1lT3M1g2OwGB4rvzJqR8Rbc/WTmsCyH3rBQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767077242; c=relaxed/simple;
	bh=9TmMfh6J1dBFzf8Y14rOmfF2Tf60V9zWrJCA38+KOZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CU9nlOcNkZ3N61oZqwkbEGT0OySvneK2FGMxmeAerWYmN75Ho9l2hGSXRr5RLd8uroZxN2S45KuocXwr0fg+bKQ7nRSZX3NeedODh9fs6s6Jjx/BOZitvISh885QicyII31gKMWXhNxBNNneAM8IWkydC9CZb/XJpUOqRc5UNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMxAPvi2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMxAPvi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767077238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zltCyISUNNfpBUMsatwG0H9x3I9DfSVw5ou8yvT8XVU=;
	b=UMxAPvi2W2sDKcwpQDhQQq2DStP+YIbFyOMc/13aKG94h7Kh1JZCoQw+bYKE748+IXHqZg
	JcN8Hh8h1S7RkrZGTTOUZMZxJFmToZxlhR5rJcaG2lKTwP2G3UnRjssYQw1wKzITa4lqAv
	MdJA6EAV92ZjJaN9I772cs0nFo+KKEA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-MYDqiOvlO0eZp-Ucy5FEzA-1; Tue,
 30 Dec 2025 01:47:16 -0500
X-MC-Unique: MYDqiOvlO0eZp-Ucy5FEzA-1
X-Mimecast-MFC-AGG-ID: MYDqiOvlO0eZp-Ucy5FEzA_1767077235
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A24B01955F3F;
	Tue, 30 Dec 2025 06:47:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C72019560AB;
	Tue, 30 Dec 2025 06:47:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 05/19] virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare variants
Date: Tue, 30 Dec 2025 14:46:35 +0800
Message-ID: <20251230064649.55597-6-jasowang@redhat.com>
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
index 3fe4c2f63dfa..d61d71b12776 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -717,9 +717,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return -ENOMEM;
 }
 
-static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
+static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old;
 	bool needs_kick;
 
@@ -736,12 +735,12 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	LAST_ADD_TIME_INVALID(vq);
 
 	if (vq->event) {
-		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
+		needs_kick = vring_need_event(virtio16_to_cpu(vq->vq.vdev,
 					vring_avail_event(&vq->split.vring)),
 					      new, old);
 	} else {
 		needs_kick = !(vq->split.vring.used->flags &
-					cpu_to_virtio16(_vq->vdev,
+					cpu_to_virtio16(vq->vq.vdev,
 						VRING_USED_F_NO_NOTIFY));
 	}
 	END_USE(vq);
@@ -1596,9 +1595,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return -EIO;
 }
 
-static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
+static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
 	bool needs_kick;
 	union {
@@ -2457,8 +2455,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
-				 virtqueue_kick_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
+				 virtqueue_kick_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
 
-- 
2.31.1

