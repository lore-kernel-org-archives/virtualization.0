Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901A364059
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972312; cv=none; b=dee9slnbsdYxMLYptL4vopmitsnLj4ZvDJXjxQ6rmDdI5qBitrvz5TpLBEaeQJfcrOp3SIZsv9cM1+sfOlXY35w6AnpnUFvolDb3iDSef/AUKq0bs+7PRvc2vjVrPbn7VHIU6f5ohoXfQY9RjtcFqUdn9XjFjggcNaD0Vod7YrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972312; c=relaxed/simple;
	bh=lXH9YuKIC0kP9lVK1mCLrGzYceDZJMMVDd8KWiXj2D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftfQ0+RWglnpPrDksT2Xz7hx8hRRYjI07ASNGJn+BpHBBkBzIv3u/2iedGxM31+LQpRSkP32ynHlGR3+HYXn4Wkmk0k7fJWtWLh/GtUTCBWQR9SeKCorch5EeuqsNze0CLDihPkxzfLt7zxtAB5lZHhlSc/7Q6CEIAsg/rQONcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaxrfT6l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaxrfT6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767972310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkUF0lSj31C4pbTgqluQXiAHtemocjZVur/wgAAKMG0=;
	b=eaxrfT6l895rweUqbhoisfpOxKFkcJMqY+zGBdZTV6BX2LD0P5/q9jVSL+aI8HP4ecbN3o
	TwK55iXDfAPE+zUvr4umPzuKV4yvMrA/JgToHrYqrGNm/+A7xCIvmePDJMBr3CZmNYWgXs
	qBSbIpe06TttZwVobNBaImyrAx1vrjs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-NbbbGiLyMYarBAsUh1Mwvg-1; Fri,
 09 Jan 2026 10:25:08 -0500
X-MC-Unique: NbbbGiLyMYarBAsUh1Mwvg-1
X-Mimecast-MFC-AGG-ID: NbbbGiLyMYarBAsUh1Mwvg_1767972307
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83E8218002CD;
	Fri,  9 Jan 2026 15:25:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 352131954185;
	Fri,  9 Jan 2026 15:25:03 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v11 07/12] vduse: refactor vdpa_dev_add for goto err handling
Date: Fri,  9 Jan 2026 16:24:25 +0100
Message-ID: <20260109152430.512923-8-eperezma@redhat.com>
In-Reply-To: <20260109152430.512923-1-eperezma@redhat.com>
References: <20260109152430.512923-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index 0386434577b5..f7a45f396cf8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2171,21 +2171,27 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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

