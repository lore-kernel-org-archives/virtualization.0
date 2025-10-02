Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456473002CB
	for <virtualization@lists.linux.dev>; Thu,  2 Oct 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401361; cv=none; b=PynOPugDbPL7dh7RUZnKcl3jUqUwAJVG2vCLLxZynIS0DdukwpO4nIHkmJ+eNH/aUPcNRal1u+thz6StLCwhehw5sJu278ZYOevuE6og0TsR1oyAIj/g6KWsBXb7AiPyigihjZ67PTfVoKGPWM/0YXg2/wiyBtBKhkQvmk6chlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401361; c=relaxed/simple;
	bh=7+ztxRKxAfTPyADGja6l4vqIG/Vh6uhOBdwDSsoFRzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SziIvNdXjGxcTcohFsnIWYipLlr1g7kx68DpskeoyYksPZPKVMQjCsKTvr7VZmImAigps1IOVLpRlT0NfrU9c27QEty0ivIzWfg6rZvY7TqCHWVmXZJe4HyE8b8MF5yUeAl+5zofyFgkJeRVoltW5wirJ/ZKW0GUn8wkfYLYlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABXx8kVL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABXx8kVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759401357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9AeJgoJorYjJ5/QVKVbM47WJUmzhAen8815b/MXP28=;
	b=ABXx8kVLujuJWuqkCzChe2xFvO/ysIyYD9rOescqx4dUYqA7T6m/tDiLJVKgP6RPKoYdKg
	0Yd/j9Jy8hwT1s+SF5JciewLQ6sDf+BzlY20RcNhLmzg9JJyhCL/v7bWOURyajWvQbdv0G
	KdVl5kohDMB5em6597NzSb4M3ayLJh0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-kpqWOQIlPgurbQBmK7d8GQ-1; Thu,
 02 Oct 2025 06:35:54 -0400
X-MC-Unique: kpqWOQIlPgurbQBmK7d8GQ-1
X-Mimecast-MFC-AGG-ID: kpqWOQIlPgurbQBmK7d8GQ_1759401352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79FE319560AE;
	Thu,  2 Oct 2025 10:35:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.208])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B87E30001B5;
	Thu,  2 Oct 2025 10:35:46 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>,
	Cindy Lu <lulu@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Jonah Palmer <jonah.palmer@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Be=C3=B1at=20Gartzia=20Arruabarrena?= <bgartzia@redhat.com>
Subject: [RFC 1/2] vduse: support feature provisioning
Date: Thu,  2 Oct 2025 12:35:36 +0200
Message-ID: <20251002103537.308717-2-eperezma@redhat.com>
In-Reply-To: <20251002103537.308717-1-eperezma@redhat.com>
References: <20251002103537.308717-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch implements features provisioning for vduse devices.  This
allows the device provisioner to clear the features exposed by the
userland device, so the driver never see them.  The intended use case is
to provision more than one different device with the same feature set,
allowing live migration between them.

The device addition validates the provisioned features to be a subset of
the parent features, as the rest of the backends.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6c74282d5721..ef8fc795cfeb 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -121,6 +121,7 @@ struct vduse_dev {
 	bool connected;
 	u64 api_version;
 	u64 device_features;
+	u64 supported_features;
 	u64 driver_features;
 	u32 device_id;
 	u32 vendor_id;
@@ -698,7 +699,7 @@ static u64 vduse_vdpa_get_device_features(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 
-	return dev->device_features;
+	return dev->supported_features;
 }
 
 static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
@@ -2256,13 +2257,22 @@ struct vduse_mgmt_dev {
 
 static struct vduse_mgmt_dev *vduse_mgmt;
 
-static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
+static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name,
+			       const struct vdpa_dev_set_config *config)
 {
 	struct vduse_vdpa *vdev;
 
 	if (dev->vdev)
 		return -EEXIST;
 
+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (config->device_features & ~dev->device_features)
+			return -EINVAL;
+		dev->supported_features = config->device_features;
+	} else {
+		dev->supported_features = dev->device_features;
+	}
+
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
 				 dev->ngroups, dev->nas, name, true);
@@ -2289,7 +2299,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		mutex_unlock(&vduse_lock);
 		return -EINVAL;
 	}
-	ret = vduse_dev_init_vdpa(dev, name);
+	ret = vduse_dev_init_vdpa(dev, name, config);
 	mutex_unlock(&vduse_lock);
 	if (ret)
 		return ret;
@@ -2376,6 +2386,7 @@ static int vduse_mgmtdev_init(void)
 	vduse_mgmt->mgmt_dev.id_table = id_table;
 	vduse_mgmt->mgmt_dev.ops = &vdpa_dev_mgmtdev_ops;
 	vduse_mgmt->mgmt_dev.device = &vduse_mgmt->dev;
+	vduse_mgmt->mgmt_dev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_FEATURES);
 	ret = vdpa_mgmtdev_register(&vduse_mgmt->mgmt_dev);
 	if (ret)
 		device_unregister(&vduse_mgmt->dev);
-- 
2.51.0

