Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC21F37B9
	for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737455641; cv=none; b=fGgPZp9LlhJ37ZorP+m2W0M8wnd4e22LOGjm1aToCH/wxouHl/2SrSLMCtk8tgq3fqP3ikGjQHiPZcmB9BputYTBjkldw7HwqOf0x1RKRdnZRvN6C2UZ0yRBj4uNeHE70urpwVVCcFFhAc1Ss8xoaQ80ZlK/wtbkUgivC2lIzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737455641; c=relaxed/simple;
	bh=klepyEw4oxvbkFAMPC/DUnWvVYKtY3kPp5qEMKLHQIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+XJSIKCcxf4CtxOaFDTM4pEJ77CeNEqaPk1nWaaXqRsbiVrdnwHSWgVVHqr1Yp2MBySZ/DPI5kil0rKrLSd4UN+S7eIpkqHNXrK4Fl34I7PKaqZTQdIJcVpLgJPqrbQH4zVWcnf6IosVyB8alsdC8bRS38QcpcFvbP17/0UHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJz2koAj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJz2koAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737455638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YCSE7ZiubHavoM0WvF5Ce7eiEIiG9FzK+grdd2K915c=;
	b=UJz2koAj/BSJC+MuTbz8QVr7lcQzCQRHEUEWA/Ag7Btycz2R1A33VY7ZQfYyCLW+1gvsQR
	bps76Bbxo1QwSgL6Tey2zIrYOqJOyB3bavcR4k5Yloar4alrRChjTiuSup29I+MRhW2Y4B
	rCIkNjoavJO7Z394YTbuwu6p9gyYkBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-59ILYVu4NFKyLrF2pR3_6A-1; Tue,
 21 Jan 2025 05:33:54 -0500
X-MC-Unique: 59ILYVu4NFKyLrF2pR3_6A-1
X-Mimecast-MFC-AGG-ID: 59ILYVu4NFKyLrF2pR3_6A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5A7C1956055;
	Tue, 21 Jan 2025 10:33:52 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.194.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D4BD3003E7F;
	Tue, 21 Jan 2025 10:33:49 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hanna Reitz <hreitz@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	stefanha@redhat.com
Subject: [PATCH] vduse: add virtio_fs to allowed dev id
Date: Tue, 21 Jan 2025 11:33:46 +0100
Message-ID: <20250121103346.1030165-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A VDUSE device that implements virtiofs device works fine just by
adding the device id to the whitelist.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
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

