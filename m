Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248933CAE7F
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185114; cv=none; b=Hf/MVKBEHQVrNvhI7meZQJCNGBo7fg6y1VMJVPi7zk7xer4TamShXsyOZ/dmEjL/sKIkVe282EDzYkvBhlJ0i0w+pjlGZe+OhlHMvfY+qduNezlOd2/a9oRmISJA58XYgw2LYywdm5HqFO/86XoN6YDmRJRrWncCnGAxmbl8Cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185114; c=relaxed/simple;
	bh=IIrciUjq44XrzZ1l+LVK9uV7Wk+WApddNBRp2z4ILDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjRreEAhRJRdNwz4snFfJ6khGddAHCLlZgcFpPqculvC3LZ293LNgnA6Ok/y4zLeY/mwWsm/JBa6GoIGhOwiUgRAflJ6ZxnCbkYNzODb0WDnEuKo4GE2xJqtgnmJsvRujxG5dZbrsbmkfBiZtEEP32plkblDFHMdOlOp0SkX2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoC2wTv9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoC2wTv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781185112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvKF1/2+bxeOfnpe0L0pXZv45cHngIniCrmb44J0XOM=;
	b=NoC2wTv9UWs/7ZpVnrD1w2bNd8eeCLW+x8MLAsXsfNciY47bAUv8oTaGLTUStR9CjocC4V
	WhjSQK/KSMutKgWTvTDkrHQIp4WKFRCrvlvO+ewH29JrQiIM/14M4fwpQYpTqaU9F9ZmZH
	4m40RNpQLHIa+DUgYQmXR7xGt0HqfPA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-dA-4qojrP8uj7GCBy_ICbQ-1; Thu,
 11 Jun 2026 09:38:24 -0400
X-MC-Unique: dA-4qojrP8uj7GCBy_ICbQ-1
X-Mimecast-MFC-AGG-ID: dA-4qojrP8uj7GCBy_ICbQ_1781185102
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16725197751F;
	Thu, 11 Jun 2026 13:38:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.50.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D2E3180065F;
	Thu, 11 Jun 2026 13:38:18 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: [PATCH 2/2] vduse: not take the device semaphore while holding vq spinlock
Date: Thu, 11 Jun 2026 15:38:06 +0200
Message-ID: <20260611133806.198402-3-eperezma@redhat.com>
In-Reply-To: <20260611133806.198402-1-eperezma@redhat.com>
References: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: UkFMz6zIvdv42fadpps6Y2Oax654bfKxMWiypgKO91M_1781185102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's an invalid lock pattern, so take them reversely.

This also makes the lock ordering coherent with vduse_dev_reset.

Fixes: e4a249d15eb2 ("vduse: Fix error around jumping over a __cleanup() variable")
Fixes: 6c141c034c1b ("vduse: Add suspend")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 86bd3116eda7..2c1cafea6536 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -561,14 +561,14 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,

 static void vduse_vq_kick(struct vduse_virtqueue *vq)
 {
-	guard(spinlock)(&vq->kick_lock);
-	if (!vq->ready)
-		return;
-
 	guard(rwsem_read)(&vq->dev->rwsem);
 	if (vq->dev->suspended)
 		return;

+	guard(spinlock)(&vq->kick_lock);
+	if (!vq->ready)
+		return;
+
 	if (vq->kickfd)
 		eventfd_signal(vq->kickfd);
 	else
--
2.54.0

