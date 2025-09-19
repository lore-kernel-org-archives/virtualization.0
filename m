Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6E2D3752
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267201; cv=none; b=j/nzZGHzBkoDyU1mPAxKUNXUvrIDmt31pqp8pcB+hVASsRiK1BOmzLB5RqsF68De5px50gPD8tHtS0Gc0We+em5tkJXwBzQwT+3ti76vWm8qJPSHce4GNfzrkdAAxJy68CfWwc7Ld5bP/RDi4hr6rTM20uNa9q6uqjezUhC2jLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267201; c=relaxed/simple;
	bh=3MKcuH54idOyqRtbKjhs5zfWkgHNYzLchqcZmZg9NjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VElAPZQgb4A9Mjs80rlDEMQ3wrZZAct0BA+/AlZfEeOEPMdV6dbS7AOuN/EY3I9SJlFi6RRhd5AUvBnWb/duNkkCSTsYWLCWg7Kg935FyHag24e6eiJE7YbNSBS/2YwFF1/zRje8qMRZcHrf8UA84MC7qZw0sverENmv89bOR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHpOqbYf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHpOqbYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4ZsZyqXT2g6mrbpOGIJ7RWG7WDvS9RJS8jyzULj2Co=;
	b=WHpOqbYfOi8gijjJDQfFnOEbBp2BAwQkepF8pIfp+i9OvLRxzbhKofTio8qMPDhAYHEmLX
	mg5cm5KfjqhS4LLnac5UCKXiMhfcuGtB1ByFOCwrec5JQ+/zAC8es7OK3ThAd+k4gUi8hJ
	5ZVuq38ZgRDSTTWkUvRSwwf4MxbZmu8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-NBvYgI_rN6qIqxnzKvDvMg-1; Fri,
 19 Sep 2025 03:33:15 -0400
X-MC-Unique: NBvYgI_rN6qIqxnzKvDvMg-1
X-Mimecast-MFC-AGG-ID: NBvYgI_rN6qIqxnzKvDvMg_1758267194
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AA971956087;
	Fri, 19 Sep 2025 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6775519560BB;
	Fri, 19 Sep 2025 07:33:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 18/19] virtio_ring: factor out split detaching logic
Date: Fri, 19 Sep 2025 15:31:53 +0800
Message-ID: <20250919073154.49278-19-jasowang@redhat.com>
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

This patch factors out the split core detaching logic that could be
reused by in order feature into a dedicated function.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5aa0cd785362..b700aa3e56c3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
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
@@ -824,8 +825,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	}
 
 	vring_unmap_one_split(vq, &extra[i]);
-	vq->split.desc_extra[i].next = vq->free_head;
-	vq->free_head = head;
 
 	/* Plus final descriptor */
 	vq->vq.num_free++;
@@ -834,6 +833,17 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
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

