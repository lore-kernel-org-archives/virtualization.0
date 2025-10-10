Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7426CE28
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086745; cv=none; b=YuZ3CCUAga9IM0itPcGfk59sOD+GrwWQ8ZxPXrZnuocM1fEzKzicRaFrPs+eXLWMBnJODpuYvKYM57QEmMlzHQbh2MxtAHsVRXpXRxXY5eERSb2SRaBKb8/PzTW+ZRV18gNmEfNbwXBAttBwcQi0S7FBkBp6RhnjUBulRxeHw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086745; c=relaxed/simple;
	bh=K4ASnwZprwTFcGZE3ZLOBGvFlyTGftRQZSnSLFGOWnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiNphQF9vXMmwoyGJVUY9VEIXrNyYVdlbIwzXXxazyNPT3rb1SyChNSrjGQkkhAiq5ktmHurFafnbYxOsaHk9W/Op/lyMI8SDt/7iE22SxylfASi6n5javGGJonzn/gdj9B+CsL0ZNFKvDWa6zhKq+GNvUKqwXBBdVdD8PmFdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GinMwEPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GinMwEPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760086742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRHRYri8X5KVjX4QxDJz0RoUB2f1AcZ23dBEU2WTFDo=;
	b=GinMwEPAF9sKx6D3kP4DP9QdSj81SWQdVLOp2qVoxtjO4IBvq16JAF3Mu7favnDY7Wn3vj
	5qX9XYg8R1HdQtswmdyXwe0hyNtAyqpvZKQD4c/07NL1Q7ArmMNppF6T9b81ggag8nuhZy
	zr1FRsOmR77GhnjO55rLcCBIoXtXFWI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-bbzYcaJjMDiJzp36N9XFMA-1; Fri,
 10 Oct 2025 04:58:58 -0400
X-MC-Unique: bbzYcaJjMDiJzp36N9XFMA-1
X-Mimecast-MFC-AGG-ID: bbzYcaJjMDiJzp36N9XFMA_1760086737
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 735CF19560BA;
	Fri, 10 Oct 2025 08:58:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B951180047F;
	Fri, 10 Oct 2025 08:58:53 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v7 5/7] vduse: refactor vdpa_dev_add for goto err handling
Date: Fri, 10 Oct 2025 10:58:25 +0200
Message-ID: <20251010085827.116958-6-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-1-eperezma@redhat.com>
References: <20251010085827.116958-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Next patches introduce more error paths in this function.  Refactor it
so they can be accomodated through gotos.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v6: New in v6.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 923330da9bef..0ce7f40b84fa 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2173,21 +2173,27 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 						  dev->bounce_size);
 	write_unlock(&dev->domain_lock);
 	if (!dev->domain) {
-		put_device(&dev->vdev->vdpa.dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto domain_err;
 	}
 
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
-		put_device(&dev->vdev->vdpa.dev);
-		write_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
-		write_unlock(&dev->domain_lock);
-		return ret;
+		goto register_err;
 	}
 
 	return 0;
+
+register_err:
+	write_lock(&dev->domain_lock);
+	vduse_domain_destroy(dev->domain);
+	dev->domain = NULL;
+	write_unlock(&dev->domain_lock);
+
+domain_err:
+	put_device(&dev->vdev->vdpa.dev);
+
+	return ret;
 }
 
 static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
-- 
2.51.0

