Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA12E92B0
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944284; cv=none; b=UcPINOxbxA4PobKaEZC+wRBADTHpRkuOQPG2P5CLdtcekC7jlc3lE9/7LHVUyyLyCzusP8R6gAWVEigzzsJK3TFnksdJbyy1XPseteVzsFPoAUCt0Ak00Gi+zzYtSB4F1GIzvYFUOw9N5cecniFLyDxuUMewpR5ggS+iEg8OYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944284; c=relaxed/simple;
	bh=If4snOkMfLQbL1VYmq7vhi5uBH6a4l2Xi0s8Njt9BtI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVwXMPtorA+e48d5mTSv25b6UWGumhaQFBmiQfKs6cFpVPm4De1jzZlGMQZ6vtAhOSzxJMQDA1o3RL0QJFsP98wPlKcHwtpsYG/dLK7dzk+bM4M84hrlVlD5oWXHZiu6vG0prT9o/GSNE4II6ZIS4mrTCBhxRNbgUpraLDE5iBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=du+m84YV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du+m84YV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkwIkfBggUdJGM3dCT6Zmq2fReJpmpq7neySAXJ1oi4=;
	b=du+m84YVYMnLFENtbrzAP5FSz83HNKLKG1IxHcHeu6UfbfHsISJLnw4bSPoItgMd74QIM5
	2lnaQwio5lvNY62p9w+ig+TBqdwJhn9gzA5E7QaZXPShTaElrcj0XqUV760T2UrVg6LObL
	38qbe6TUxdEtaTzmjImrJv3R3ewFdRc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-OxWlUojMO6m9CBb6Bb7gZA-1; Mon,
 20 Oct 2025 03:11:17 -0400
X-MC-Unique: OxWlUojMO6m9CBb6Bb7gZA-1
X-Mimecast-MFC-AGG-ID: OxWlUojMO6m9CBb6Bb7gZA_1760944276
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73D5418002F9;
	Mon, 20 Oct 2025 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87936300019F;
	Mon, 20 Oct 2025 07:11:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 17/19] virtio_ring: factor out split indirect detaching logic
Date: Mon, 20 Oct 2025 15:10:01 +0800
Message-ID: <20251020071003.28834-18-jasowang@redhat.com>
In-Reply-To: <20251020071003.28834-1-jasowang@redhat.com>
References: <20251020071003.28834-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Factor out the split indirect descriptor detaching logic in order to
allow it to be reused by the in order support.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c59e27e2ad68..0f07a6637acb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
+static void detach_indirect_split(struct vring_virtqueue *vq,
+				  unsigned int head)
+{
+	struct vring_desc_extra *extra = vq->split.desc_extra;
+	struct vring_desc *indir_desc =
+	       vq->split.desc_state[head].indir_desc;
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
@@ -799,34 +830,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
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

