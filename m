Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9D31B82C
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536412; cv=none; b=UMDjfe13H1HfJtwTPWJjE1F4gbAPGZzBUGZP8GeBKg5s9lfmhku2nQpRDX95ODvCnmMqvHekt/51kdijfJ/bgPvlBRwnWpY3XzinvFNFO62UGmzxX1TSTDIp72ugla0ZZSeTnpRCYQDqUFb/oxUTiKsCSrXkFoBx3IyjhaLl9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536412; c=relaxed/simple;
	bh=yXYGAEZQ8Iw2OCraZR8+b/6Q0QjT7RWJKnz+9vw/Ed8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQ78Vt9lBOD+pROx43VTcktPoTUZcEM4rpr6P/cAsNdc7Uimtqq4qPuYBMceEMimx02qFKR/sr6GLYcN0pwgVTlzCOTpHDyhe6m4Rre7LjtXuKBaHQZapMvhLw3sZAwHTaNkU+rxv2jD7cym1411/QBfXHRYxEbG/byDIgEyShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1DZV5bq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1DZV5bq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJzLkNizPe0Q11iTpFozDICpZibb0u5PKmXWgxiw+ZE=;
	b=N1DZV5bqdLGeIxDIbcveYHs5juF7f+S428Jer7VchovE88Qiguc0qbL/SSaNc2sNIif/zf
	pYAzM8VuZr4bQAmHc5/N2Np0HU+4aF21viVV6IwjejYYcGtFtQa4PGoJIrUxr04ZJSrByt
	/NGc5U2EEDSEOCE4k02hqLVPPvAcuDk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-4IyO9KdEOh-jFJcBvK1BgQ-1; Tue,
 23 Dec 2025 19:33:26 -0500
X-MC-Unique: 4IyO9KdEOh-jFJcBvK1BgQ-1
X-Mimecast-MFC-AGG-ID: 4IyO9KdEOh-jFJcBvK1BgQ_1766536405
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A533D19560A5;
	Wed, 24 Dec 2025 00:33:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EA4419560AB;
	Wed, 24 Dec 2025 00:33:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 02/19] virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
Date: Wed, 24 Dec 2025 08:32:52 +0800
Message-ID: <20251224003309.23432-3-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cc1b8bbc6774..d5a317cb885f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -919,11 +919,10 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 	return last_used_idx;
 }
 
-static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_idx)
+static bool virtqueue_poll_split(struct vring_virtqueue *vq,
+				 unsigned int last_used_idx)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
+	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
 }
 
@@ -1844,9 +1843,8 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	return vq->last_used_idx;
 }
 
-static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
+static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	bool wrap_counter;
 	u16 used_idx;
 
@@ -2611,8 +2609,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 		return false;
 
 	virtio_mb(vq->weak_barriers);
-	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
-				 virtqueue_poll_split(_vq, last_used_idx);
+	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
+				 virtqueue_poll_split(vq, last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
-- 
2.31.1

