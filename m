Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7A2D3737
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267195; cv=none; b=r1ldaIVLFJcZ9pZ7R3GoaEZ2v23kHfBFcC3zYbWl/2mDWpqboDmkKG1afoLJAHNWeoOUkw5ifR7Hhscp0ikJqNoNCvxmZSlrrT/e7GcOsMuwLds4iRJ2Um7LP2WQs1TNZjoEx7NNCI7jFkwkz+lrstfEePuTZ1MWo3ya652ahaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267195; c=relaxed/simple;
	bh=FqYnqYtU8O+wC82H2JjbzckwHeqMY/a4PgAq00ynxJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHq+IYuedA6JlKamIK1zm79+EIV8QggvOPZ+Y2PDR75XXA/DURF6Arvl7SmCV36vQHnLmPCD0sHkws9B8GSmooWC3DtZbGHazTkfDW3j5Ap1n+vU4HR4kw2muwcGzf0SelyzpbEDrhFoZOYvPlubfDdP8BXsS04rV/LHjpbfOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaselMN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaselMN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ptrr4BTPt5ya8hfXz4kLOZPYwSv02w1Hgkd7CHw9yg=;
	b=TaselMN/UHiPGET/FZVrMxCsH80ZUwxQgY+6pc5QXigJfMjYRb/ID20ANxx+cupaq5YZCl
	np2coXVeUlqRPXnk68a8ntfBKjZMLA1F0j5sTmdOVwoWjTqqXL9mo5fBQNrWRK0xYW2Csh
	4iBeUuZBNffr7Z21aCj4RsANZELcNyE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-19uLT56POC-QNCDjjc2Wpg-1; Fri,
 19 Sep 2025 03:33:07 -0400
X-MC-Unique: 19uLT56POC-QNCDjjc2Wpg-1
X-Mimecast-MFC-AGG-ID: 19uLT56POC-QNCDjjc2Wpg_1758267186
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB4BA1956086;
	Fri, 19 Sep 2025 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C68E1956045;
	Fri, 19 Sep 2025 07:33:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 16/19] virtio_ring: factor out core logic for updating last_used_idx
Date: Fri, 19 Sep 2025 15:31:51 +0800
Message-ID: <20250919073154.49278-17-jasowang@redhat.com>
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

Factor out the core logic for updating last_used_idx to be reused by
the packed in order implementation.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 43 +++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a83d08070e8a..f376f717c8e4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1750,6 +1750,30 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
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
@@ -1793,24 +1817,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
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

