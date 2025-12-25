Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A782D3EE5
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636853; cv=none; b=s4iVrBSU1fQ+Ulw6FGpmU45VRqWyHQ5yequ8rEtcVay70XByL/iHsCMs+q/Qj8f3ErzXN6jfJV7s3GjjLewe9AvrzRdMxA7TzxLLI/GkkjSFe3PRl4kAqDQAyBCGGbknjqIzIdsj3Wd74BtO0OoerNLx+kGZ6CvEx2cIz3bASC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636853; c=relaxed/simple;
	bh=vT/rnqr6zwC5DmpdLoabK0ZxHctZcBJbpSjNAmLljYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3qnMNaOz8lDZnYU9W4eSmoSUeE8rFux5bVr9M1+fhj1eAFhFRXlu4a/8/LY6WLU8Q+fw6iQfP9Yuv/faBe2X1H2U79e7AT7zRF21pMESj7rvERQXffY6tuOdlrTei/HgaY4DXN1r8WRI3/ioK9jtoADUgjH/ODULk4k1IRaK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpxHld8i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpxHld8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766636851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDXnjKkesAvTlC09+GI+ZucuKHPHwKIBZ6WVoWyUKNQ=;
	b=LpxHld8iMI1c2gQLR4xHkJNpwN7C1OqHosl0qSN+lmeRqdkDbWk2vy7UrP1IVftFakfbnK
	ERYWo6IXqeZgHlM2W7xVZT3iSOesd9wZVWrDxLipxXWu+eLNaqsYYkMmT20J4w0GMqBYHJ
	sAyj1jEDEldReikNvlCIq4HIlF4JPZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-ucbe6lrvM9iUDEnkDWwcVA-1; Wed,
 24 Dec 2025 23:27:27 -0500
X-MC-Unique: ucbe6lrvM9iUDEnkDWwcVA-1
X-Mimecast-MFC-AGG-ID: ucbe6lrvM9iUDEnkDWwcVA_1766636846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF90B19560B2;
	Thu, 25 Dec 2025 04:27:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F805180044F;
	Thu, 25 Dec 2025 04:27:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 17/19] virtio_ring: factor out split indirect detaching logic
Date: Thu, 25 Dec 2025 12:26:06 +0800
Message-ID: <20251225042608.32350-18-jasowang@redhat.com>
In-Reply-To: <20251225042608.32350-1-jasowang@redhat.com>
References: <20251225042608.32350-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Factor out the split indirect descriptor detaching logic in order to
allow it to be reused by the in order support.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 62 ++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9e3213f6083d..5bb9797c6524 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -776,11 +776,41 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
+static void detach_indirect_split(struct vring_virtqueue *vq,
+				  unsigned int head)
+{
+	struct vring_desc_extra *extra = vq->split.desc_extra;
+	struct vring_desc *indir_desc = vq->split.desc_state[head].indir_desc;
+	unsigned int j;
+	u32 len, num;
+
+	/* Free the indirect table, if any, now that it's unmapped. */
+	if (!indir_desc)
+		return;
+	len = vq->split.desc_extra[head].len;
+
+	BUG_ON(!(vq->split.desc_extra[head].flags &
+			VRING_DESC_F_INDIRECT));
+	BUG_ON(len == 0 || len % sizeof(struct vring_desc));
+
+	num = len / sizeof(struct vring_desc);
+
+	extra = (struct vring_desc_extra *)&indir_desc[num];
+
+	if (vq->use_map_api) {
+		for (j = 0; j < num; j++)
+			vring_unmap_one_split(vq, &extra[j]);
+	}
+
+	kfree(indir_desc);
+	vq->split.desc_state[head].indir_desc = NULL;
+}
+
 static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 			     void **ctx)
 {
 	struct vring_desc_extra *extra;
-	unsigned int i, j;
+	unsigned int i;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
@@ -804,34 +834,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	/* Plus final descriptor */
 	vq->vq.num_free++;
 
-	if (vq->indirect) {
-		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
-		u32 len, num;
-
-		/* Free the indirect table, if any, now that it's unmapped. */
-		if (!indir_desc)
-			return;
-		len = vq->split.desc_extra[head].len;
-
-		BUG_ON(!(vq->split.desc_extra[head].flags &
-				VRING_DESC_F_INDIRECT));
-		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
-
-		num = len / sizeof(struct vring_desc);
-
-		extra = (struct vring_desc_extra *)&indir_desc[num];
-
-		if (vq->use_map_api) {
-			for (j = 0; j < num; j++)
-				vring_unmap_one_split(vq, &extra[j]);
-		}
-
-		kfree(indir_desc);
-		vq->split.desc_state[head].indir_desc = NULL;
-	} else if (ctx) {
+	if (vq->indirect)
+		detach_indirect_split(vq, head);
+	else if (ctx)
 		*ctx = vq->split.desc_state[head].indir_desc;
-	}
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-- 
2.31.1

