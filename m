Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D03CA4B4
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169695; cv=none; b=lTFf0q5aZ+G9VJa8e9MYIA2Ylq9Br7rVonf9zuyg8KI0ivBbRwZ7p1jy2zbniybLkFtI3TDBmrwgq/hB9MlehKm04Pr4L3sv+yJ1x0n2d46450CT8c8rgkNAuFoho3m3IuJFfUYVY5vifIMKv/YnN/84riaVWGSsg1x15ew7f+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169695; c=relaxed/simple;
	bh=3mS3+X9vmE7OTqs95H53lzU4UWMzZeS/2AcTH4YfG/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqAbE9rmUUscbssFEccAlewsDrvyJaq3byZhGbYBTv8JvEAa4JG0sMxbDeamU+5sBEmvdCt47cvKVMxjjaaE6YdWftQrQneTU9SxxgsBqk/U86EEhyph5ncJ4HESF50l8EN5TROhEsW34aSgZMIVOqziCEEeL3DcL1nuTXqAbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxuxU/ib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxuxU/ib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773169693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+OGNrV7q92SEw+n+ligigLv3apRvr4chwlhOB9DrX4=;
	b=dxuxU/ib0101D18yklSO0Jf6DyHNt7Q6QhY70AVk47U8ItcStjCbFf1e2gO38UUbDBS51h
	4pgk9UfmIFvqqpuq+jDOAi10/EdvDzobRhOneqUdzBStJJGrdxdjO+4zK2HwzSIWq/BsPU
	9zeLPTkRdu9YHBcwfXPD3aJrDsKM/NE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-vFe0Z5kDMuusEFhdDMHAVQ-1; Tue,
 10 Mar 2026 15:08:10 -0400
X-MC-Unique: vFe0Z5kDMuusEFhdDMHAVQ-1
X-Mimecast-MFC-AGG-ID: vFe0Z5kDMuusEFhdDMHAVQ_1773169689
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 212851956059;
	Tue, 10 Mar 2026 19:08:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EA623000223;
	Tue, 10 Mar 2026 19:08:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 1/3] vduse: store control device pointer
Date: Tue, 10 Mar 2026 20:07:57 +0100
Message-ID: <20260310190759.1097506-2-eperezma@redhat.com>
In-Reply-To: <20260310190759.1097506-1-eperezma@redhat.com>
References: <20260310190759.1097506-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 7q6ubBNiSI5RNOD0OHOwoaBVlpuPn_ZiZ0gdZ0SuQus_1773169689
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

