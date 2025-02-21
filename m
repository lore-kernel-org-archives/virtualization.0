Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11924C661
	for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157607; cv=none; b=bZcJyXfrfr2z3xG16ES8cdzSAUag1R7gmtj7ndO5UPIsF7BYqNfNGW2PXTZWsAS6JHp9nlQ1oAsK7a/jfkrNLIstuL/Eg00xBeh29ZMG1N8a4+JqjeSyAZMCZZwgWlqzyTfDubKvnuB9D8HIu/AuCUnBsl5KGRQihZqKDQ2IV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157607; c=relaxed/simple;
	bh=Vv1NbWzviFFjkYgnApafB6eSlQ9qebhWbyappYi4ZZ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWEjnSkZUCxHoOXR5G8SNEXgp0fXY5zgyog+vI8dzDr4+1soVkae74LGw+pVUgXxE2r2vi9M3vQGxPPeoYchzblQGwZ6kQdSqMzIWbLxuswoUgHQAgU6elB35+7DZf9n5Js8SWcnkPh0WweXRPyGdupiEHEiJ3rwqpkCF0SDVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORYGxAQw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORYGxAQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740157605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4qurRJRnurJ/JqIrxC646pXKHyUVnPnjlMlPbACT6o=;
	b=ORYGxAQwL8H3xoEXT4mrI1VgHvdLQzePk38rscJVELASb5QvRSeFnc31bPBV5tsi2sM0iH
	Lq3uUNi1wle15BtVxOKn9+4fdOQZACaKP4q3gqklaIA2jZtbLVf+RoHS7DmyNcKxokAvee
	m4Kfd0bkXb5cc8bwKehb4zjJeccToVk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-_Rt6RXfyPg6UTI3PrSKIAQ-1; Fri,
 21 Feb 2025 12:06:42 -0500
X-MC-Unique: _Rt6RXfyPg6UTI3PrSKIAQ-1
X-Mimecast-MFC-AGG-ID: _Rt6RXfyPg6UTI3PrSKIAQ_1740157601
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13B5C1800570;
	Fri, 21 Feb 2025 17:06:41 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0814180087E;
	Fri, 21 Feb 2025 17:06:35 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	yama@redhat.com,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>
Subject: [RFC v2 1/5] vduse: add virtio_fs to allowed dev id
Date: Fri, 21 Feb 2025 18:06:22 +0100
Message-ID: <20250221170626.261687-2-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-1-eperezma@redhat.com>
References: <20250221170626.261687-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

A VDUSE device that implements virtiofs device works fine just by
adding the device id to the whitelist.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7ae99691efdf..6a9a37351310 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
 	VIRTIO_ID_NET,
+	VIRTIO_ID_FS,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
-- 
2.48.1

