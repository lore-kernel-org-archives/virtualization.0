Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5A32D0F5
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536473; cv=none; b=AIRIQ2fqFoie9FJHvNVRsXQUFF7Vr8//mC38WDlSE1AkasIUCWXtcyqW8Lo9nanzun+VVZGNAiWtMJYXxDMD9dsY2H1TBNqVO90J1gh/xenNHQkO0e6KbkwQhJLisUI7HGnD6qys7GFK3jxTWczqoVR6nQ2Dos43/G8N46zK20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536473; c=relaxed/simple;
	bh=IidT4HZDDvs6ZEb5kVSZWqtC1LWZBEM8NC7SIUve8E0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0DWipGNORQQcIMhQZneEl2wgsEwAifyTXvoTeYIoN136l/sMrC859e5rnQ5AdnT+dzBvn22ie6DORarN13RrRtX6SmO+xTyL4VVRQ+eDykBWPSNlOkFzL+RZabb18ZNI3uV4Nz9Jut0OWh986ISxN4mQ9XWpbBBz2J3SrGpDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKFAO0hf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKFAO0hf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcIwy8OI9pAJA1Qm3y/8ZKj5VUk++bUm82Rcjzz2tlw=;
	b=UKFAO0hfyGltxXkamPhaXkWcO7ir4WeO7mMFVJia/ojuMX9MhiDZuYRRx0kwHWTDQxZwmB
	QgqQDI2QAqGeNR5uAZ4QSjVz9wHQ4l4GciJuvYbNS83VLg1W9+pnxD/k4+jDpJri3BsF02
	dWizRUtbeDcoxAexdHLkBj5KNCaVdMo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-xXUvfFokM96ulVKLBjZrog-1; Tue,
 23 Dec 2025 19:34:27 -0500
X-MC-Unique: xXUvfFokM96ulVKLBjZrog-1
X-Mimecast-MFC-AGG-ID: xXUvfFokM96ulVKLBjZrog_1766536466
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE7831956050;
	Wed, 24 Dec 2025 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF39719560AB;
	Wed, 24 Dec 2025 00:34:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 18/19] virtio_ring: factor out split detaching logic
Date: Wed, 24 Dec 2025 08:33:08 +0800
Message-ID: <20251224003309.23432-19-jasowang@redhat.com>
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

This patch factors out the split core detaching logic that could be
reused by in order feature into a dedicated function.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5bb9797c6524..61884e031b94 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -806,8 +806,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
 	vq->split.desc_state[head].indir_desc = NULL;
 }
 
-static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
+					  unsigned int head,
+					  void **ctx)
 {
 	struct vring_desc_extra *extra;
 	unsigned int i;
@@ -828,8 +829,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	}
 
 	vring_unmap_one_split(vq, &extra[i]);
-	vq->split.desc_extra[i].next = vq->free_head;
-	vq->free_head = head;
 
 	/* Plus final descriptor */
 	vq->vq.num_free++;
@@ -838,6 +837,17 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		detach_indirect_split(vq, head);
 	else if (ctx)
 		*ctx = vq->split.desc_state[head].indir_desc;
+
+	return i;
+}
+
+static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
+			     void **ctx)
+{
+	unsigned int i = detach_buf_split_in_order(vq, head, ctx);
+
+	vq->split.desc_extra[i].next = vq->free_head;
+	vq->free_head = head;
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-- 
2.31.1

