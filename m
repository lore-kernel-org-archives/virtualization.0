Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACA2F49E3
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796714; cv=none; b=Rf7UtfAxXfnA6zPzlDhSpR5r+uYC7Jtvn54ruRVAYu2U2+HJTb8r0MARb3i3MHkwdaPO70lH4juNPCfOFW9gm2mYafJeYU9SRUM52FxNqNSXyxp4YuV3X7Y25spyKe6gfibmGjSCouE03+QeVwZ+dDsbrJnEHaiG+8v3GHW7qjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796714; c=relaxed/simple;
	bh=BnR8Ey0phOJNrmR4YcgGln5l8dkqCejJWdm4pnQBujY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5RbfqkPTxvGu25R1Kws8IjR8aOhpEQBwRJ3shtUM2QLrMkPQ0b3WpjiSRVv9rKcEWXpn1C4sExy+LsFxdk7HDKoMwi8u0y116befHyRcn+GLnZj8AsrDvM8n81xvCPVMsnsf1srsd7fuPlZdv3kR2es9uMd8WvgiUmEkqvdCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+NdqA6K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+NdqA6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9p2u1Tm0farIC5ATwh8kdmF4lIMx8Aq1o5jXY1OIiGk=;
	b=C+NdqA6KDs+QCgB2J90mxRrrrd4NT9SmxQFYAfqP/OAA8q03CWXjNZ3P4wdivSqj2s1QNu
	1zqyyjXgt4V7R2X7wifPMGEs0qeEMUeu1MMuraVRNLxQQUhyl2k5NHGbuAgh9XAh8PT2zV
	0dKrk9/6AIzXnD3+amMdiP7PO43cvPw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-yS8roVQnPIKb_mLlW6vHrA-1; Thu,
 25 Sep 2025 06:38:26 -0400
X-MC-Unique: yS8roVQnPIKb_mLlW6vHrA-1
X-Mimecast-MFC-AGG-ID: yS8roVQnPIKb_mLlW6vHrA_1758796705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB8701800296;
	Thu, 25 Sep 2025 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69EB519560A2;
	Thu, 25 Sep 2025 10:38:21 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 16/19] virtio_ring: factor out core logic for updating last_used_idx
Date: Thu, 25 Sep 2025 18:37:05 +0800
Message-ID: <20250925103708.44589-17-jasowang@redhat.com>
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Factor out the core logic for updating last_used_idx to be reused by
the packed in order implementation.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 43 +++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4b01c26f83b9..cfc90a332644 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1749,6 +1749,30 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
 }
 
+static void update_last_used_idx_packed(struct vring_virtqueue *vq,
+					u16 id, u16 last_used,
+					u16 used_wrap_counter)
+{
+	last_used += vq->packed.desc_state[id].num;
+	if (unlikely(last_used >= vq->packed.vring.num)) {
+		last_used -= vq->packed.vring.num;
+		used_wrap_counter ^= 1;
+	}
+
+	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
+	WRITE_ONCE(vq->last_used_idx, last_used);
+
+	/*
+	 * If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call.
+	 */
+	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
+		virtio_store_mb(vq->weak_barriers,
+				&vq->packed.vring.driver->off_wrap,
+				cpu_to_le16(vq->last_used_idx));
+}
+
 static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 					  unsigned int *len,
 					  void **ctx)
@@ -1792,24 +1816,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	ret = vq->packed.desc_state[id].data;
 	detach_buf_packed(vq, id, ctx);
 
-	last_used += vq->packed.desc_state[id].num;
-	if (unlikely(last_used >= vq->packed.vring.num)) {
-		last_used -= vq->packed.vring.num;
-		used_wrap_counter ^= 1;
-	}
-
-	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
-	WRITE_ONCE(vq->last_used_idx, last_used);
-
-	/*
-	 * If we expect an interrupt for the next entry, tell host
-	 * by writing event index and flush out the write before
-	 * the read in the next get_buf call.
-	 */
-	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
-		virtio_store_mb(vq->weak_barriers,
-				&vq->packed.vring.driver->off_wrap,
-				cpu_to_le16(vq->last_used_idx));
+	update_last_used_idx_packed(vq, id, last_used, used_wrap_counter);
 
 	LAST_ADD_TIME_INVALID(vq);
 
-- 
2.31.1

