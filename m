Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A22BE65D
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432613; cv=none; b=JBWiAMPBKh8ZgWPzbyw9HJw7GEVc0X+EMnaHeFglluHv7gA8nKHhIrMuY3YaH8gQRETKlVZwN2u/9+m0/zQp/e/p8uQH11vqMqzqWY/u9KnZj8kKeYJiF8WgWmO1dlcE8dm6J+jGy9ZKTMwT1xRRgnjMbOrQQjXIezbfxccG3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432613; c=relaxed/simple;
	bh=vFfUSmYWrTVGwWRCiU7a9BtMS6E9jCIRZblFwJdbPTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUOu+0IsZLZk8I+lr0rsyW4i5El/Fcb8kCPJ90dslpjeKQSklnPbJLqRG2m11tqAFjxolgN8s2gsx+eI2rMwgZ6mHIwEAg9aaAMrusSJyO6zE9KHiP7XhG6GRSQfqi4K6M8Mn7uQGr4dKL1v0XEXJW8WBxC8rshyjaAI/SOEj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGTtJEBz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGTtJEBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753432610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Zt+rornE3BIrIKHV3inNVDZI6A4VLsKm8/mKLnWE00=;
	b=eGTtJEBzB7GNsvvruFuvRWTWUuwA7f9CiUAtu3POyzDti21FwckH7PNQ+QVcVntXNN47OS
	F3xBbRsTXzzttl6eY7A2L1Gteu/dxZEVbnYV5Zw6y9dMvAOZ2z/LT7fuoLG4P9/2ROgQD2
	IRbvrwI66Knao2aQoaa93lfn+3jnq68=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-gs09vKMZNlWtH32J_me4rg-1; Fri,
 25 Jul 2025 04:36:46 -0400
X-MC-Unique: gs09vKMZNlWtH32J_me4rg-1
X-Mimecast-MFC-AGG-ID: gs09vKMZNlWtH32J_me4rg_1753432605
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFAE41800446;
	Fri, 25 Jul 2025 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DC0618001D8;
	Fri, 25 Jul 2025 08:36:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"kernelci . org bot" <bot@kernelci.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] virtio_ring: fix uninitialized used value
Date: Fri, 25 Jul 2025 16:36:35 +0800
Message-ID: <20250725083635.73355-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Buildbot reports uninitialized used:

drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is
uninitialized when used here [-Werror,-Wuninitialized]
 2113 |                 BAD_RING(vq, "id %u out of range\n", id);
      |                                                      ^~
drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable
'id' to silence this warning
 2077 |         u16 last_used, id, last_used_idx;
      |                          ^
      |                           = 0
1 error generated.

Fixing this by use last_used instead and drop the complete unused
variable id.

Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8f9413acd4e2..7b960ce9a034 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2074,7 +2074,7 @@ static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
 						   void **ctx)
 {
 	unsigned int num = vq->packed.vring.num;
-	u16 last_used, id, last_used_idx;
+	u16 last_used, last_used_idx;
 	bool used_wrap_counter;
 	void *ret;
 
@@ -2110,11 +2110,11 @@ static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
 		*len = vq->packed.desc_state[last_used].total_len;
 
 	if (unlikely(last_used >= num)) {
-		BAD_RING(vq, "id %u out of range\n", id);
+		BAD_RING(vq, "id %u out of range\n", last_used);
 		return NULL;
 	}
 	if (unlikely(!vq->packed.desc_state[last_used].data)) {
-		BAD_RING(vq, "id %u is not a head!\n", id);
+		BAD_RING(vq, "id %u is not a head!\n", last_used);
 		return NULL;
 	}
 
-- 
2.39.5

