Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9F3CAE7F
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185105; cv=none; b=m2GyH7fBEZy6nDOIHLdTppBDEU9UvtHcI3yEbi/FThHEE/7XqS1bzNHxCf5t1Qm9D+NOB8dTdqZ35fIVZAo33JEVKDa7fu+RKobvHibSu4CQnb8eKcAhS6+8Iml67ECiPW7wFgCT3/w3TEpbw3CdtblbYuSmrQBRvojyv2YwoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185105; c=relaxed/simple;
	bh=cC6+uKTgAoQlecfXkN3xfU2KHO3KQjoBkCWa5P0W9mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlycR0vzYU1kbeZskgZzLW9TGIuCD900eoRoq4ZeUHsek7KQWDqF9sMnoAbwF/4NTwqaqQWvHx2fmeY/tFrFMrHMmc0ybxejAK6Ac4XS8SE4bVUKgDYNueUsGLQwO6CQaAFdCLqsF9nbzHeBOxz+Lp5oIzboAFVkBqASKBXE5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oap8INgI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oap8INgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781185103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSMGj/hCnL6hUwuPAPWzI623YABRQ569PNsoa9BlrgI=;
	b=Oap8INgI/xMUP8gR1f3/PSIA/DBQh19ueD4ThUSo6lIwUj1hrHiG9/17UutXlPAa/kxSbr
	fDjll2gwbTQbV2sb6umBKKil8OS11oI+hYRxk7v/YB2nmlhL2yd2hPU12Ee61dTv3M9uTF
	AXNm6xEwHOIi5XDGKeaMVtbbKJ6HTMQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ZWVEZY3CNPWFy66RHN6EBw-1; Thu,
 11 Jun 2026 09:38:20 -0400
X-MC-Unique: ZWVEZY3CNPWFy66RHN6EBw-1
X-Mimecast-MFC-AGG-ID: ZWVEZY3CNPWFy66RHN6EBw_1781185098
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4EAA195D00D;
	Thu, 11 Jun 2026 13:38:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.50.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF36C180065F;
	Thu, 11 Jun 2026 13:38:13 +0000 (UTC)
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
Subject: [PATCH 1/2] vduse: fix not releasing taken semaphore in vduse_dev_queue_irq_work
Date: Thu, 11 Jun 2026 15:38:05 +0200
Message-ID: <20260611133806.198402-2-eperezma@redhat.com>
In-Reply-To: <20260611133806.198402-1-eperezma@redhat.com>
References: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: GXKrLRjlXRzV9Q0N_ipUCT03ujBf9K0y1_OonIzm43g_1781185098
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If dev->suspended the function returns not relasing the semaphore, so
the only solution to be able to use the device is to reset again from
userspace.  Convert the semaphore functions to the equivalent guard() to
avoid it.

Fixes: 6c141c034c1b ("vduse: Add suspend")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0500da043761..86bd3116eda7 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1281,21 +1281,16 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 {
 	int ret = -EINVAL;
 
-	down_read(&dev->rwsem);
-	if (dev->suspended)
+	guard(rwsem_read)(&dev->rwsem);
+	if (dev->suspended || !(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
 		return ret;
 
-	if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
-		goto unlock;
-
 	ret = 0;
 	if (irq_effective_cpu == IRQ_UNBOUND)
 		queue_work(vduse_irq_wq, irq_work);
 	else
 		queue_work_on(irq_effective_cpu,
 			      vduse_irq_bound_wq, irq_work);
-unlock:
-	up_read(&dev->rwsem);
 
 	return ret;
 }
-- 
2.54.0

