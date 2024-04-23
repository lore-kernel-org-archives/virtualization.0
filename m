Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA91CFB2
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842669; cv=none; b=JZvhcU6bNLaFy6CLqgsgr3UyctPqePr/wOLIGR31twJdHEpc8i1TE4lPWly2ZcHOZeLfwGuDeg3FF82FUpq5q0PObsGkqgNb5iDGEdas8k6NkFtmaSg0gvSpRhHX22T94jUnLGmhpzj0qSV3/T3ikqlKywOm/qJ/vJbrAPPkw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842669; c=relaxed/simple;
	bh=VXNuueCqLjer3SK5FWiU+oQ2njUy2Ft9Y+uSyol2th0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCC94tFzQAMsaHqJZrhDJs4moJ4P3CAusRSYazUp0pqqJg9fecalB7cngWw2RiXE52Bi/slFcg6vNVnk7duOsue8Rn97PQYeaCzOZ1/XcLtH8vC26aSabYVSK/B5ywP5hAecms5AHheDMH/c5NapXoZyK23VaVkAKwAoOmzpaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4wGOKPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4wGOKPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713842667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxWHZLxO01yGdS6uNhVtl2pRAw0NwEn5kPBcPnzmn/Y=;
	b=d4wGOKPFHK02si6U5Xl3bXsVgTsk196KquXPZG/BXosJ8/5OULQqDFVabiHb3R5A92p1cy
	1ezig/1mzZfejWs5zgCkltUiKrCYi8Cv6AgIh5uBoJLBON1RndMOmVacb4i38kTW3tNoyN
	CN/XBrlFpdyzuD3gZSlLrj/y7lPR5TI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ZXEZtGiTMAOnPUbEzktHhw-1; Mon, 22 Apr 2024 23:24:23 -0400
X-MC-Unique: ZXEZtGiTMAOnPUbEzktHhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BCE68943A5;
	Tue, 23 Apr 2024 03:24:23 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8590B1BDAA;
	Tue, 23 Apr 2024 03:24:21 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 3/4] vhost: Improve vhost_get_avail_head()
Date: Tue, 23 Apr 2024 13:24:06 +1000
Message-ID: <20240423032407.262329-4-gshan@redhat.com>
In-Reply-To: <20240423032407.262329-1-gshan@redhat.com>
References: <20240423032407.262329-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Improve vhost_get_avail_head() so that the head or errno is returned.
With it, the relevant sanity checks are squeezed to vhost_get_avail_head()
and vhost_get_vq_desc() is further simplified.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b3adc0bc9e72..a3de9325175f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1320,11 +1320,27 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 	return 0;
 }
 
-static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
-				       __virtio16 *head, int idx)
+static inline int vhost_get_avail_head(struct vhost_virtqueue *vq)
 {
-	return vhost_get_avail(vq, *head,
-			       &vq->avail->ring[idx & (vq->num - 1)]);
+	__virtio16 head;
+	int r;
+
+	r = vhost_get_avail(vq, head,
+			    &vq->avail->ring[vq->last_avail_idx & (vq->num - 1)]);
+	if (unlikely(r)) {
+		vq_err(vq, "Failed to read head: idx %u address %p\n",
+		       vq->last_avail_idx,
+		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
+		return r;
+	}
+
+	r = vhost16_to_cpu(vq, head);
+	if (unlikely(r >= vq->num)) {
+		vq_err(vq, "Invalid head %d (%u)\n", r, vq->num);
+		return -EINVAL;
+	}
+
+	return r;
 }
 
 static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
@@ -2522,7 +2538,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
-	__virtio16 ring_head;
 	int ret, access;
 
 	if (vq->avail_idx == vq->last_avail_idx) {
@@ -2539,21 +2554,9 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
 	/* Grab the next descriptor number they're advertising, and increment
 	 * the index we've seen. */
-	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
-		vq_err(vq, "Failed to read head: idx %d address %p\n",
-		       vq->last_avail_idx,
-		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
-		return -EFAULT;
-	}
-
-	head = vhost16_to_cpu(vq, ring_head);
-
-	/* If their number is silly, that's an error. */
-	if (unlikely(head >= vq->num)) {
-		vq_err(vq, "Guest says index %u > %u is available",
-		       head, vq->num);
-		return -EINVAL;
-	}
+	head = vhost_get_avail_head(vq);
+	if (unlikely(head < 0))
+		return head;
 
 	/* When we start there are none of either input nor output. */
 	*out_num = *in_num = 0;
-- 
2.44.0

