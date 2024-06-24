Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B951805E
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219909; cv=none; b=geUdEaSJIB/X66QDFCeuTkhsiLxcW57hJkL8QB224i7mq4nEFZYGNl7c7LI3VwNpwzt7P+1x9hif3PutOdwej7KDPkxgOKdykdxi5hh+lYedr4JXxe28WLxyB5Jrc1tya7pkAo5Vo/MoRG+F/aH/8cTrs8oiVdwVlafyEACryjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219909; c=relaxed/simple;
	bh=fRTvNNjoH6D28ouJEAZwDM8xJVWNE7O8P1N0eHIe8Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5hmGtRPittLVgKe5q2x0xEZrXaGnxvMvGmot2nA/pMABLz9pf758x3lAhiRc/S3DOFsAeQl+gkJ1UaucgpQineXh0rdhsu8MtjGUQr3JIdNqMjQaalgvD1DeObYMSTWQveO0mBpTTx448EeyfXvxg6yiBQRr1Er2W4Cf1dg+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P3+cTvhO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P3+cTvhO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so33989565e9.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219905; x=1719824705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adaw7bxAreHjcUaSD9jXcHmQpUvsmQvzRVD00qlJd6A=;
        b=P3+cTvhO9VSbVUXRCkifb2cgwwiX0Te+IBqrMJAnJDiy0SzY6fJcTYx/61yyn1v9k6
         JKK/K1nswW3G6X+LbOy6w8J8aAwRbObIJb6vTDXaH+w4/jvaffi/pMfd8cSGphcVQjGz
         ngrv5F9L/HIX9xG14StbsnH24Wr1XsjKGwcfG6QShbVxCfac7FsCB68z3lFig4EFdx72
         4YGSs6RNj7Y1M3EJ/biNUB0O8HayU3BIeBGg6tPVAshRBrzyNFxERTuMU3p/gfbrwPWO
         sQib608TejZWLReQjfwLsy9Gthz1Dw8q+vfbOatOvHFYwXndoA2wAyYGvF9RQyDOe6Vh
         jcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219905; x=1719824705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Adaw7bxAreHjcUaSD9jXcHmQpUvsmQvzRVD00qlJd6A=;
        b=UIVD9avGVLBwlowAsI2kuU2GkfEm887cYA7yQ1TiCMoqmDPQRkmUt4ECpShCerYqnW
         tMgUDPkPGKsdg7E7R/z90nxZSVR17OruHlXbcR4raFzL8ZowEPB8Wwexq0VDPWETVYZV
         LPyoY/r+eRog8KufWmnRlGJ1cyaR9tYCi6oYsDH+jrRvd37sqZ4Tub+077mHp7RSTe/e
         WDWS0Ggh/s+YPwt9PW85ZAz5Cb5XGNOuvEwYlPgMImIxNQuaLryyXnyTCdjweOTAc3co
         d4cjR42lJ9nwUBQqSbklZpZulEDQ8z5yMUsInfm4IzyCTI9hbZorlBucF/8yf/Lh52XE
         nO2w==
X-Gm-Message-State: AOJu0YwoUQMxoz9oI0RYkHy0ObXGqFbiKm9HoDVxnucGQZhLFhMJhOAx
	HWx03wZCgNnCRTa9FAN25e2p8AgqHh2HzSULG7SOc+tFr9ZWT3eIAfLFs0kRs3PipstvoF0mqba
	kIPA=
X-Google-Smtp-Source: AGHT+IFZqiOGuOOu2h9ZlyAd7lvkGZXwVa5pvxpMjMT1Tabh98UKWBckAlXTaLOz9htW1EF70JShRQ==
X-Received: by 2002:a05:600c:2d06:b0:423:366:ad3d with SMTP id 5b1f17b1804b1-4248cc2acf7mr29366735e9.13.1719219905320;
        Mon, 24 Jun 2024 02:05:05 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424819224fasm131390985e9.46.2024.06.24.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:04 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 3/8] virtio: push out code to vp_avq_index()
Date: Mon, 24 Jun 2024 11:04:46 +0200
Message-ID: <20240624090451.2683976-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
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
index 925166498e2e..ee8fb7a23d55 100644
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
@@ -730,19 +745,15 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
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
2.45.1

