Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178A32BF5B
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536469; cv=none; b=TOaVeqPnu95QdyLO7qIEdeHouE/d2/5WZlexEakHBbPbmineV4xtT0llN5zVWpbvTVD1IUdrpD2uxHoZqsu6ZM5We4zn+wZIkqhKsHIy4gXANVPdy9LstwlgPy2m6OSA0CUwhJbCm1wZjZDP/a6Cfg91CYAicu9oQM/XeTJd1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536469; c=relaxed/simple;
	bh=vT/rnqr6zwC5DmpdLoabK0ZxHctZcBJbpSjNAmLljYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6XcyyuMIqJmzdDcUuLgUpdG7pvyG4IJAhyC/sAtUlztvQz2fyLZkzgFZa3irKG2hY4FNXDCrt9Doeemw1qMR8TjOrQf/qG542oc9v6YBjYcUvsA7DUGGPH7hRroDyQIGv3mYtL44jTLYG7npx7vTFQPM6LvGnc8ieFwwJWX0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1m+HOCY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1m+HOCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDXnjKkesAvTlC09+GI+ZucuKHPHwKIBZ6WVoWyUKNQ=;
	b=c1m+HOCYK9TnTG4UWtB4sdVUKV6JvBlQckcKB+UcWJdHbiNXt+Mzx8HOuWPHY0XbuGmcSk
	Yy9bl40fPj75JypXXX87sjIh7onXgvh3IRN3VieEwMSfwt2HsCX96Tws2Ml1Ku6IVFgFt3
	b0XKBUWsTStVWgK23qmNzsF7hHALK/s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-qxqc1vpxMceDjp-CnYY1lQ-1; Tue,
 23 Dec 2025 19:34:23 -0500
X-MC-Unique: qxqc1vpxMceDjp-CnYY1lQ-1
X-Mimecast-MFC-AGG-ID: qxqc1vpxMceDjp-CnYY1lQ_1766536463
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69531956089;
	Wed, 24 Dec 2025 00:34:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAE351955F43;
	Wed, 24 Dec 2025 00:34:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 17/19] virtio_ring: factor out split indirect detaching logic
Date: Wed, 24 Dec 2025 08:33:07 +0800
Message-ID: <20251224003309.23432-18-jasowang@redhat.com>
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

