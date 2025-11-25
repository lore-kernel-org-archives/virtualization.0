Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E12F5466
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054589; cv=none; b=M/BsuRyKmzpqjZhDdtDDcOpd5j3uhR+RvrFkyv5L/HBb43FrW9KxBPEP0IyAYLsrPpCZ0SDM3X4Jg/aAC0xSv0tfypcrdwbKC6sEIAR1Qa8gF/O2wCh3Mn5VWHzs4eE+d2qfDjIphmUzTFMd/7SbmR3vBmmmNm3m6xGoW7OYBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054589; c=relaxed/simple;
	bh=7+M6FY0CrnWAV+hhAExp3CegwI0pm5qlnSpU5bH5yfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpRF0k+h6w3J3wSiP+tkdLoMEHGA76cfIFq+rmee/mFlEWgNCFXtaW6LzN3Dcmm1jg36lFRG8S+0O+2vkJNPC7cxXOQPl9+6V7ZMzFBoVdSEZONqRyQDj9Fjlz7XMu0P5iUJfGporHOntBBb5v7rPJAzEKOiiHmuIStANcqPC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri85zPpS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri85zPpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764054586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7SW6y3BaocdVTeTcaXd7PTcuFbJm5a3JDZdYiqSd8E=;
	b=Ri85zPpShqDcv7MDwKm2I1GQ1x4lgtBiysyESRw0wyTk23FgZQX96/NgJI6l84M6ncLiFf
	MPHd5fpp7FH+mlkAU8XPlyt5F03eOOuar9jmi172+qH6JgVLgeGBWJIECQvmpXryxLW9z4
	cFVY8+ukyeCmulyfK8K36Nknz4ypQ9s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-YSdR3UdAMO-Rhm6yOr3u9g-1; Tue,
 25 Nov 2025 02:09:42 -0500
X-MC-Unique: YSdR3UdAMO-Rhm6yOr3u9g-1
X-Mimecast-MFC-AGG-ID: YSdR3UdAMO-Rhm6yOr3u9g_1764054581
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E7E519560B0;
	Tue, 25 Nov 2025 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED6A11956056;
	Tue, 25 Nov 2025 07:09:37 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 12/19] virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
Date: Tue, 25 Nov 2025 15:08:31 +0800
Message-ID: <20251125070838.70736-13-jasowang@redhat.com>
In-Reply-To: <20251125070838.70736-1-jasowang@redhat.com>
References: <20251125070838.70736-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Switch to use unsigned int for virtqueue_poll_packed() to match
virtqueue_poll() and virtqueue_poll_split() and to ease the
abstraction of the virtqueue ops.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index db5cdb5fcb20..f804c5c6975a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1699,7 +1699,8 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
+static bool virtqueue_poll_packed(const struct vring_virtqueue *vq,
+				  unsigned int off_wrap)
 {
 	bool wrap_counter;
 	u16 used_idx;
-- 
2.31.1

