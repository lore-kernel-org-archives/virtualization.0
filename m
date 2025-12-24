Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8BD328621
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536444; cv=none; b=u0Omoo6fK014FaGTcMVdrPwnX4JrOj1NR4OAGjDoGyO2DTj1VFDNvSXcY7tqQCP3kCtd2/TEyfbfBkS4mh7gM8VqxgNhi+VlWcFEZxeLr0wzB9mrZstPCW/GLhOi9c+NcGxdaPNsCFga8/kCJ7Zy8Rasr9Fxd54WffPITTkDA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536444; c=relaxed/simple;
	bh=4J9oD5erJEAiDzZkvnsGsYSiKWVEmbakyVvZhYirf3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfwyUpVW/1wMO8/f4b2P4M7CS2cnZ2RNGy+ptIqD+gOCgQVyt6Exj9Qq6+xJq5gffyszemBX8/I/MG4KSQL2f3VUTLb0/ICFYbNiRHd2i+2l0ur1KYZJaVx9qlPYrOTeqeZaPJ65Wpl2jTe28RPDs/71nw+eLHZG+X+ybnRhYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9aKPJv4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9aKPJv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/e1enlQjSwfmyQkTZMSi4igBcCel8J22/QnS+o2docE=;
	b=M9aKPJv46u6+46ABA/nGo41xHTU5URwBb1C4+51lt5j3Ahtvm1zkeRmusCRG4K3EoP8mPv
	vpJUDRLKToakH1u5FZmvhFowe1MSM1J86YzbeAUnYRs64rggY99mm0C4gWUO0ypL7FMfhg
	0/Vrtpmru/C49zSNm6bcOaCaOs8VyAQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-hM7FLf9CMX6heTSDKc8tqA-1; Tue,
 23 Dec 2025 19:33:57 -0500
X-MC-Unique: hM7FLf9CMX6heTSDKc8tqA-1
X-Mimecast-MFC-AGG-ID: hM7FLf9CMX6heTSDKc8tqA_1766536436
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3C5318002E4;
	Wed, 24 Dec 2025 00:33:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A740619560AB;
	Wed, 24 Dec 2025 00:33:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 10/19] virtio_ring: switch to use vring_virtqueue for disable_cb variants
Date: Wed, 24 Dec 2025 08:33:00 +0800
Message-ID: <20251224003309.23432-11-jasowang@redhat.com>
In-Reply-To: <20251224003309.23432-1-jasowang@redhat.com>
References: <20251224003309.23432-1-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 00de30862777..a4d084f5ca95 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -874,10 +874,8 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	return ret;
 }
 
-static void virtqueue_disable_cb_split(struct virtqueue *_vq)
+static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
 
@@ -893,7 +891,7 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 			vring_used_event(&vq->split.vring) = 0x0;
 		else
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
 }
@@ -1786,10 +1784,8 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	return ret;
 }
 
-static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
+static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
 
@@ -2542,9 +2538,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->packed_ring)
-		virtqueue_disable_cb_packed(_vq);
+		virtqueue_disable_cb_packed(vq);
 	else
-		virtqueue_disable_cb_split(_vq);
+		virtqueue_disable_cb_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
-- 
2.31.1

