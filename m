Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7E2DEA74
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767077273; cv=none; b=VrmdNJWJpHirpAeUMpCpvWchDP5e2nLZmSDo2ohPsJ+0G/Dsp7oXfSs6b3Ut9lso/X5z2b5ULk0IOeg5EH3u/yjMZU7AFiJk10lhjjUg9by7yfavk7aQmN/O98tXw82l9rY8DtHjzyxqj4HKqJujTuq4c/MNq/WX9DgdToPFURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767077273; c=relaxed/simple;
	bh=7+M6FY0CrnWAV+hhAExp3CegwI0pm5qlnSpU5bH5yfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB+ysNXAPtaN9oO9H170YGOSvhvRLSGTnRqBvBH+o916R/c2nzIXCbI6FDS9YcqBT41vRUKan4vHJ/qecuoi5FnxTcQXztAdnEU3v3ijn28DJvLY4CK8J0w22tvZqqmfp9dTlVrjX+BBX7JtCd3df1phVwHqestY3inS9cT8HtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzP0pQSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzP0pQSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767077269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7SW6y3BaocdVTeTcaXd7PTcuFbJm5a3JDZdYiqSd8E=;
	b=AzP0pQSWjziJeoVWrYNBjJSmDF6utTJXyViFlUdHNuQypkSOhrjGj2WbhQEYo7qIoGhiik
	BTRT3xVr0xIjvZ0UKh2ZOWtsO3U46G9bJPZeQqZIoc/M1VdcPI8zPGzoJQ7ctoyLt6fhdC
	3DoYtOTvd61WG9eTLXAilZtPX++J5U0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-BKmWm6RTNnCMtfC5vIkRfQ-1; Tue,
 30 Dec 2025 01:47:42 -0500
X-MC-Unique: BKmWm6RTNnCMtfC5vIkRfQ-1
X-Mimecast-MFC-AGG-ID: BKmWm6RTNnCMtfC5vIkRfQ_1767077261
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C971F18002ED;
	Tue, 30 Dec 2025 06:47:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB68219560AB;
	Tue, 30 Dec 2025 06:47:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 12/19] virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
Date: Tue, 30 Dec 2025 14:46:42 +0800
Message-ID: <20251230064649.55597-13-jasowang@redhat.com>
In-Reply-To: <20251230064649.55597-1-jasowang@redhat.com>
References: <20251230064649.55597-1-jasowang@redhat.com>
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

