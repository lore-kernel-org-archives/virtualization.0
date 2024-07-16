Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2915491
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129786; cv=none; b=qzscalbQqQIDUitMEILQLWrgfLDQaGTyGllbRUGjBCvpg+8Jv9NueKGLMVKmCtb0xVE0GBjSMbPFvbwcWGWGraOsgVxSqVcbS/DfVp05CGPb5X9/KVy6qRzMAjo01b06z85exQJIw8KAvMjD8swsE1TNciLurYCt7YYu9uOCndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129786; c=relaxed/simple;
	bh=e6RBBWKSJnPSjZrR379oQbLozavarmDyGbGZ/PhXlls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrEsAhTvPV8ORTLbTjJX/4cePuhS90Do03LspgUFHMYqu76V7AOdOAsty6A26Q0fJVAam34vGa8LH6n+NVCZv4fpDkiTGiGfOoDJXf4uxrk3xU2FlsAd/1DABvHm82aElyd8S3MJ8eoxDqcqMQqTqBPYwUeRbQNo9T7bMAC2NiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vMpm5HPg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vMpm5HPg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4279ca8af51so33008045e9.3
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129783; x=1721734583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIk5fgJ7RD8PhzNLK1dlDTI2NEOLZ8452S9H8jNMDjk=;
        b=vMpm5HPg9SHqA/2rEDznupS2BoWwGv++d3p7rSlbtNkdInu3NYRFMODJ8OR/OFBvfZ
         cuKmudE6Th+tDls89wHXY4hrW7RbyEpt2u3Nsx9qNZfDqZ7S4boHWdW3RCYghigY1pKu
         2fn5ZlnXJpzzz7+KSK3TnCVMDTJHD7zjrL5yuP4eUsWb60RBuubmSxO9pAO/jF4rlPWf
         3vXfW3R70BCtVJzN93yDiJ82R5s2P0EPd4RwTI+tW3WH4V1GGFdEng3bBrBT8MUzqDQ8
         xf/IcMwTvaVfM80qsUB0WlyxBAeUM6IPfHJzGZ/0C7tDglc+lM4ncASSXin9pRE+eBeB
         6rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129783; x=1721734583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIk5fgJ7RD8PhzNLK1dlDTI2NEOLZ8452S9H8jNMDjk=;
        b=LQAN3fwgyYCbySOzFAhv6rcfXfEufwVXaHb/GECRsrXyCl17JCLPwKgB9/goJiQX9L
         RE5d/Ch/k3M8bzivi10Cyt6oL00IlesSf33wd90ka6aLrFIquUF0yNtPwv9y4pIVyqBR
         I4rF9HZRZ7hXd33Kue5DkihsWARJoSXd3WNIpI45zr3B+oNHsTPU4O62P4Zawz6j52Lg
         /CRxMKOFQ3PC5Ry/EnUNefWkSQgDSvYPpdgE2YSQJ44WmwOptRt34LVztXi7N/GeSJqU
         QDtAYDeB81hb425x5bjERhV1JG7NC06I67XNfO0ob+YOY0eXyQhYdKFE/uVebYV8YWpb
         w3BQ==
X-Gm-Message-State: AOJu0YzQJazItO6w0CfIF3Pdy3mCjZiGMZWNkAWy9hSYPkgkE99kIBE2
	FVs3xDWrCVHQsIT7jjqjN2378ZsWfU4Q5rrjKpAFAul+vUpRaTJUbPqAEOL1+n7YL2TWoCLiifS
	rUkM=
X-Google-Smtp-Source: AGHT+IHXgb3LdVASjyp1vKJUJXvCuOvAJySf7khhcbNZ6iH8He39mfupHbqDt98QFWIxEPg0KjUnfQ==
X-Received: by 2002:a05:600c:468e:b0:426:67f0:b4fa with SMTP id 5b1f17b1804b1-427ba655261mr14408845e9.1.1721129783082;
        Tue, 16 Jul 2024 04:36:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25b946sm154891485e9.19.2024.07.16.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 07/13] virtio: push out code to vp_avq_index()
Date: Tue, 16 Jul 2024 13:35:46 +0200
Message-ID: <20240716113552.80599-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716113552.80599-1-jiri@resnulli.us>
References: <20240716113552.80599-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

To prepare for the follow-up patch to use the code as an op, push out
the code that gets admin virtqueue base index and count to a separate
helper.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 31 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d653bea9a87..d704947b1aec 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -28,6 +28,21 @@ static u64 vp_get_features(struct virtio_device *vdev)
 	return vp_modern_get_features(&vp_dev->mdev);
 }
 
+static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	*num = 0;
+	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
+		return 0;
+
+	*num = vp_modern_avq_num(&vp_dev->mdev);
+	if (!(*num))
+		return -EINVAL;
+	*index = vp_modern_avq_index(&vp_dev->mdev);
+	return 0;
+}
+
 static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -729,19 +744,15 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 static int vp_modern_create_avq(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_admin_vq *avq;
+	struct virtio_pci_admin_vq *avq = &vp_dev->admin_vq;
 	struct virtqueue *vq;
-	u16 admin_q_num;
-
-	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
-		return 0;
+	u16 num;
+	int err;
 
-	admin_q_num = vp_modern_avq_num(&vp_dev->mdev);
-	if (!admin_q_num)
-		return -EINVAL;
+	err = vp_avq_index(vdev, &avq->vq_index, &num);
+	if (err || !num)
+		return err;
 
-	avq = &vp_dev->admin_vq;
-	avq->vq_index = vp_modern_avq_index(&vp_dev->mdev);
 	sprintf(avq->name, "avq.%u", avq->vq_index);
 	vq = vp_dev->setup_vq(vp_dev, &vp_dev->admin_vq.info, avq->vq_index, NULL,
 			      avq->name, NULL, VIRTIO_MSI_NO_VECTOR);
-- 
2.45.2

