Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB8281370
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970688; cv=none; b=u4EhgeRFX9yFbR7s+K6kR1BMwXmYAexPKJN15jm4prSIph/oOPQga8mOnKjWfIdUdksHByvgVyckQCWfqvUyMX2AO/1hqEnQx6M9XXg1HIOT10EWOfUJ1Br3B02taQ5I4YT9hBYSwQG8bJCyji3WI251+usNWnRbCOPliYwAwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970688; c=relaxed/simple;
	bh=X1M6J9+dIKSIzDc+fVLR0WvDyVHOGc8KzXnSDOE50Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY18+Dp3w+zbhsyQhxGpBuunVmhXnHINaagj/RbqtwN0d3DApsOrzb1R2dN5mDsTASVle8Lb9OeMsZXfm4SBWfJhl8WP1eNqxm48dZ/yRwVb8IHxninsREofJJ68M4Fn2sRpVRo6lMVNhwGA9BcIsXI4gQMKQXzw1x0kEYYtIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnfAp98b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnfAp98b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765970682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjuJlhdDNznWR9Xj3wMK1yvwzZv5UKds5cBizS2xYxg=;
	b=NnfAp98bLXV4pJayvgpUcV3nfLoh2KnsKugWxhryao2dlOQq9qhu0bLDsqXp/HJATTTpwM
	aR/WCFnHpD80dFkyzqAPs3Nr8HCn9fJnpaYIvr1tXMGojMLSP8SKkwe1aNOlsoxZPoNSV0
	qyEquYTDX64O/B8YfckzARY03gnk56U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-1jmfh5rDOj60WFXmR1qSEw-1; Wed,
 17 Dec 2025 06:24:38 -0500
X-MC-Unique: 1jmfh5rDOj60WFXmR1qSEw-1
X-Mimecast-MFC-AGG-ID: 1jmfh5rDOj60WFXmR1qSEw_1765970677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 770351956080;
	Wed, 17 Dec 2025 11:24:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AECF180044F;
	Wed, 17 Dec 2025 11:24:33 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v10 4/8] vduse: refactor vdpa_dev_add for goto err handling
Date: Wed, 17 Dec 2025 12:24:10 +0100
Message-ID: <20251217112414.2374672-5-eperezma@redhat.com>
In-Reply-To: <20251217112414.2374672-1-eperezma@redhat.com>
References: <20251217112414.2374672-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Next patches introduce more error paths in this function.  Refactor it
so they can be accomodated through gotos.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v6: New in v6.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d64bcd9ce76e..0390e012c584 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2172,21 +2172,27 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 						  dev->bounce_size);
 	mutex_unlock(&dev->domain_lock);
 	if (!dev->domain) {
-		put_device(&dev->vdev->vdpa.dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto domain_err;
 	}
 
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
-		put_device(&dev->vdev->vdpa.dev);
-		mutex_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
-		mutex_unlock(&dev->domain_lock);
-		return ret;
+		goto register_err;
 	}
 
 	return 0;
+
+register_err:
+	mutex_lock(&dev->domain_lock);
+	vduse_domain_destroy(dev->domain);
+	dev->domain = NULL;
+	mutex_unlock(&dev->domain_lock);
+
+domain_err:
+	put_device(&dev->vdev->vdpa.dev);
+
+	return ret;
 }
 
 static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
-- 
2.52.0

