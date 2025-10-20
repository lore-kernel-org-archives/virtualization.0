Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260E2DF719
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944288; cv=none; b=Rm8U6AMvTY30F99go2Z1Vsjjj6HkCnU26tmT3sGqQtmYOSPuHt9hP/6uvf8bq2U/1qEoDgixjik+Wtp/Dl+Izpit28HoheXemGRSwAIOkNHWGmbiLbmnYmxlEWiSyrsyntiGS1i/99UDyZ9AGy1fo8zcV987BntI8gGE9BC6oOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944288; c=relaxed/simple;
	bh=rHrGNT24xmrdhC5F+YR1TnjDpsX+U6XDSXhyVRYmpsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lywLWE4vRKz0OypuBc9ZE8fkfwlk4zqEnRXe1+qTIoRuio4biib90PWf164+t5SmGhwIOfLt5AQ8tI6bT/3VYtNfYjLqZkHlTrrxakm7/VvDpViyYI0LQeN2HYukUaTL0Q+UKcBtm405IeYBsCWIb26k1CSquk67lqp1cXxKN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JB+hAc2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB+hAc2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDhYYb5/vqjcZ2X9K8PW960PeOO9CL79kbWB0k4US8U=;
	b=JB+hAc2fT5b6HvRx5hy6Bj7m2NFYlBb/DcBd/nhbIRFk26iU1hqpnCvCFHebVDIRpyL/Yx
	sTzKEVait4c6SjsYIn0jxZ9+LbXCA7NmQ/5AkCn3dnrNJvX6o4CH357Wl34ErHZVlzIoUQ
	VE8vZGmWkYipHRgwXWMAfv6XPKKmulU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-OS_9lLAhPsCBZ0L2HPOwrA-1; Mon,
 20 Oct 2025 03:11:21 -0400
X-MC-Unique: OS_9lLAhPsCBZ0L2HPOwrA-1
X-Mimecast-MFC-AGG-ID: OS_9lLAhPsCBZ0L2HPOwrA_1760944280
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AD9E1954213;
	Mon, 20 Oct 2025 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4277B300019F;
	Mon, 20 Oct 2025 07:11:16 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
Date: Mon, 20 Oct 2025 15:10:02 +0800
Message-ID: <20251020071003.28834-19-jasowang@redhat.com>
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

This patch factors out the split core detaching logic that could be
reused by in order feature into a dedicated function.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0f07a6637acb..96d7f165ec88 100644
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

