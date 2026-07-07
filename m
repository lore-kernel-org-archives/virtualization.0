Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9B3FC5AA
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427120; cv=none; b=DJw/AlrTkuCwkUJAv4Z0gSXdiMHE967eXzJpjB39QMIzhjRd0DsLCNyCVak29fYNlQu5gprNdcjDofMKPlXsrjJPFJJeBOrXeUw4gMyB4lE6hxDlWuulCt62qIm/xK53sMFx5Ts+3gckDkcgHjdU3gxjm0SXQTT3fx3sI42UuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427120; c=relaxed/simple;
	bh=B73+NHea5ML68wtgiP1tABlrYJBTUURj7hANl65FVqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbCKfpHnSxlMquGAMeHq8sgl/Qtnbhs+cmu3FB/9Ax3Yc3JQeajuBaoCt/SpJG56cMvbtJ7XoCfIJWGwD9phBsnlVWagH7YbbwuRd6MvF4NOfQ6zGEUngNjX1u0jI1PJPaOVpSG9Yab1kVe3KPA5AGqFwmDT7wCxrkyFk74ArMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gl3Xh2IL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gl3Xh2IL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yui5qR/VC9d1cUwlnXmHfMqSjSjYyQIR+14r27JxzXM=;
	b=Gl3Xh2ILEtHliJNFmKP4VtcXFsYKGqi5xFYl032towXsnHN7gcFPXH/wISUHC+hyN0uAiG
	WV6Jw6LaPgDCriKyCg3IMObYtZgPW0gg4slk8BJ9ceJrJfbjv5cIGdufUI7ElvK9uNrYsp
	bSy5s6kENzjzjmUqlOsaHchnQgPlymU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-483uQekDNZGT_vTVyVBkQw-1; Tue,
 07 Jul 2026 08:25:13 -0400
X-MC-Unique: 483uQekDNZGT_vTVyVBkQw-1
X-Mimecast-MFC-AGG-ID: 483uQekDNZGT_vTVyVBkQw_1783427112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E86E51801318;
	Tue,  7 Jul 2026 12:25:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B80F1800595;
	Tue,  7 Jul 2026 12:25:08 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH v4 1/4] vduse: store control device pointer
Date: Tue,  7 Jul 2026 14:24:59 +0200
Message-ID: <20260707122502.239022-2-eperezma@redhat.com>
In-Reply-To: <20260707122502.239022-1-eperezma@redhat.com>
References: <20260707122502.239022-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: M8wDGDz7PSuEMCbF0jMKf_hnGvOJmFj39wsjUv1xvMw_1783427112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This helps log the errors in next patches.  The alternative is to
perform a linear search for it with class_find_device_by_devt(class, devt),
as device_destroy do for cleaning.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v4: Set control device pointer to NULL at device create error.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index f15ad425e01f..2af5cb5e1ec6 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -164,6 +164,7 @@ static DEFINE_IDR(vduse_idr);
 
 static dev_t vduse_major;
 static struct cdev vduse_ctrl_cdev;
+static const struct device *vduse_ctrl_dev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
 static struct workqueue_struct *vduse_irq_bound_wq;
@@ -2532,7 +2533,6 @@ static void vduse_mgmtdev_exit(void)
 static int vduse_init(void)
 {
 	int ret;
-	struct device *dev;
 
 	ret = class_register(&vduse_class);
 	if (ret)
@@ -2549,9 +2549,10 @@ static int vduse_init(void)
 	if (ret)
 		goto err_ctrl_cdev;
 
-	dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
-	if (IS_ERR(dev)) {
-		ret = PTR_ERR(dev);
+	vduse_ctrl_dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
+	if (IS_ERR(vduse_ctrl_dev)) {
+		ret = PTR_ERR(vduse_ctrl_dev);
+		vduse_ctrl_dev = NULL;
 		goto err_device;
 	}
 
-- 
2.55.0

