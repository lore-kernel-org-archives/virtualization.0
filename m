Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855433D509
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711970; cv=none; b=dmP2gu84iBoLwYWovNKgULYtlETQr42KUVwksoUTnA/iFLKe5TR1oStrMl6hBGv5oLXa9i2E2aN8UYE0m7jvGKVLv474i0iGmkAM4+WKab17j2CgAUgb3avUYWPS4TYkOeZpRtyqf9AVIvguQHovxwgZaY27Q/ltO8SwbtlzTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711970; c=relaxed/simple;
	bh=3mS3+X9vmE7OTqs95H53lzU4UWMzZeS/2AcTH4YfG/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS3k+5XVvbnaRR9FM1FGjKN0ocnrjHoj/mrvzx7/6GQlx3Rwjf1aTL5076vA5rpuSfDFDlCwAmVVPes1dCtpHilLjSE/kqaJTfLhvvip5ccqE71iCZVTz2rOTIdikoOs+/LHCx7/QwGGuzBB0imz6yuGnn4pnukzjdGbaxWvxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJspShZr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJspShZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770711968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+OGNrV7q92SEw+n+ligigLv3apRvr4chwlhOB9DrX4=;
	b=EJspShZrg1GwYJaRieJMeByo1QbwjAgccEYUndzbV56Y4V+KvHBTgrIU00JmAkhA/MN9wz
	EstyLTjGMjse7dUauV5YxkNkdj5UrZrBl0kICiHWdfF0y6NpslTN3kXmot8v0pq+LCvjCK
	qHaBMZpKJ7bNLLQTqstOEqrCLfpwSRs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-JkV4_cS7MC6xoH4kX6KjtA-1; Tue,
 10 Feb 2026 03:26:06 -0500
X-MC-Unique: JkV4_cS7MC6xoH4kX6KjtA-1
X-Mimecast-MFC-AGG-ID: JkV4_cS7MC6xoH4kX6KjtA_1770711965
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C6A219560AD;
	Tue, 10 Feb 2026 08:26:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B306A1956056;
	Tue, 10 Feb 2026 08:26:01 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 1/5] vduse: store control device pointer
Date: Tue, 10 Feb 2026 09:25:50 +0100
Message-ID: <20260210082554.1582553-2-eperezma@redhat.com>
In-Reply-To: <20260210082554.1582553-1-eperezma@redhat.com>
References: <20260210082554.1582553-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 1KDlN52cS3U8l_HJMlEfeNgi7TlaqTGL9i2x4ZfsNcg_1770711965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This helps log the errors in next patches.  The alternative is to
perform a linear search for it with class_find_device_by_devt(class, devt),
as device_destroy do for cleaning.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 405d59610f76..d1da7c15d98b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -164,6 +164,7 @@ static DEFINE_IDR(vduse_idr);
 
 static dev_t vduse_major;
 static struct cdev vduse_ctrl_cdev;
+static const struct device *vduse_ctrl_dev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
 static struct workqueue_struct *vduse_irq_bound_wq;
@@ -2396,7 +2397,6 @@ static void vduse_mgmtdev_exit(void)
 static int vduse_init(void)
 {
 	int ret;
-	struct device *dev;
 
 	ret = class_register(&vduse_class);
 	if (ret)
@@ -2413,9 +2413,9 @@ static int vduse_init(void)
 	if (ret)
 		goto err_ctrl_cdev;
 
-	dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
-	if (IS_ERR(dev)) {
-		ret = PTR_ERR(dev);
+	vduse_ctrl_dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
+	if (IS_ERR(vduse_ctrl_dev)) {
+		ret = PTR_ERR(vduse_ctrl_dev);
 		goto err_device;
 	}
 
-- 
2.53.0

