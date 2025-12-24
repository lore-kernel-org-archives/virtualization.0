Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6207329C4C
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536451; cv=none; b=HQnOpYfpuz7E7eduRL/jnLBlvBEe0XJZcsRaK6rL6jlDBDJbDZhLBIt0JbjV0VK6n943AIccR1c26Lot8hJW1frndeMXCwEMj/QwXAsB1C04zIgGbhusSRUUKJTgcLVQwnKsd9mRhMf3TfJZHdo5vZD4SQQzHPbJJcn9+J1Q3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536451; c=relaxed/simple;
	bh=7+M6FY0CrnWAV+hhAExp3CegwI0pm5qlnSpU5bH5yfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcoosD71vUmaJGXdD06sSX/cGDIhfNotmtdhyt+UzmTFwGMEkwgws+ZO3Acy84g4pttR8lFYohHIVsFo7xuw+a9wFCRPa4l4+B5DlWj0higXvYwtm/VKTr5nvp5VjUTSsdse4YO5GqZ9fXJnRnlMqYs1w+3qQ68toQiWGr7jWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSBaNnhJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSBaNnhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7SW6y3BaocdVTeTcaXd7PTcuFbJm5a3JDZdYiqSd8E=;
	b=VSBaNnhJ5H1xTMv9G2FOEzFBu1qHIfaASVDKTgq6cOwKZq53/hjfL3YY9fTFcoDa6qz2LS
	+xQMNmEYksV3XE+HypUo59qOkRXFBCPIjMayZwYOtOC/u94BhVxjRbZDQFhsmCMmhLCb4F
	2fnNzXvjEJw3Sij7CAc507rzoqSfvoQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-syumuEU8M9eJGhZEW-cLAQ-1; Tue,
 23 Dec 2025 19:34:05 -0500
X-MC-Unique: syumuEU8M9eJGhZEW-cLAQ-1
X-Mimecast-MFC-AGG-ID: syumuEU8M9eJGhZEW-cLAQ_1766536444
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B6041956094;
	Wed, 24 Dec 2025 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CCB719560AB;
	Wed, 24 Dec 2025 00:34:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 12/19] virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
Date: Wed, 24 Dec 2025 08:33:02 +0800
Message-ID: <20251224003309.23432-13-jasowang@redhat.com>
In-Reply-To: <20251224003309.23432-1-jasowang@redhat.com>
References: <20251224003309.23432-1-jasowang@redhat.com>
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

