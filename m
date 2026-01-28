Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E333CE92
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604346; cv=none; b=SmuoxhYGFRQBvtsk+I41arFDivjBChKtXGzmMtPnvn9pc5rJ9LwW7szxCxpVdFZVJA7krfvhfqMbaAQFbEyM1UDdQKhobSbMniQ4kXiF4Jbpu9lkb4AHLhBSxuIVtQacZyJJrpLC37MBw8bQhNUBhp9LYPz+uih6pKMmIUMRgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604346; c=relaxed/simple;
	bh=EfCQmhYSIDHocEJRMzpUejK2Cok2tj0jxu49geXWjfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uY+R9WeQhLBeQrM+0YMSCEkXJSPeyBIcyhqnzLUWnRoEnl/pTlTrTwD/VY6/1wz0TWNVL+x/ULWdLIwhOUk2SYrn2PjrLwtHcbOgk7KsSTdToaHjkFetR3A3sW5j0FCf0HpgtxxB4TUZgVrSOyyZgNNH2V7gBtENC2UjvdIhhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmmMdlSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmmMdlSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769604344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KubtyHhITHWdcwOjvGJzBrvZM5flQAY+/c3XSEbmS+U=;
	b=SmmMdlSczfGz9/iW57OU7rEuj+geI1M07ZZoHXqnd6M+K+mG5VIZvYpGgH7kqrJV8vZMCa
	GPtdreW6lPZZ7O7N8y0qg0TCJaSvf/pUHaPKA+Htcq8odeOYFl6GskcPzJjjupCnFVthlQ
	fkWpbesZmAjQlcwJMEq5NGpvigrUwHE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-uZsdqd5ONySuTRqibEfNLg-1; Wed,
 28 Jan 2026 07:45:41 -0500
X-MC-Unique: uZsdqd5ONySuTRqibEfNLg-1
X-Mimecast-MFC-AGG-ID: uZsdqd5ONySuTRqibEfNLg_1769604340
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A00D819775A7;
	Wed, 28 Jan 2026 12:45:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA92C30001A2;
	Wed, 28 Jan 2026 12:45:35 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 2/6] vduse: store control device pointer
Date: Wed, 28 Jan 2026 13:45:20 +0100
Message-ID: <20260128124524.875271-3-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-1-eperezma@redhat.com>
References: <20260128124524.875271-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This helps log the errors in next patches.  The alternative is to
perform a linear search for it with class_find_device_by_devt(class, devt),
as device_destroy do for cleaning.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index a4963aaf9332..551ccde0b856 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -164,6 +164,7 @@ static DEFINE_IDR(vduse_idr);
 
 static dev_t vduse_major;
 static struct cdev vduse_ctrl_cdev;
+static const struct device *vduse_ctrl_dev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
 static struct workqueue_struct *vduse_irq_bound_wq;
@@ -2426,7 +2427,6 @@ static void vduse_mgmtdev_exit(void)
 static int vduse_init(void)
 {
 	int ret;
-	struct device *dev;
 
 	ret = class_register(&vduse_class);
 	if (ret)
@@ -2443,9 +2443,9 @@ static int vduse_init(void)
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
2.52.0

