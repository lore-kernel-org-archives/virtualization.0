Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480F78281
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593378; cv=none; b=ri3NwIOljFoRfWanUFEKo/3tMY2Xn56/SYnQe2At8j7igLL7hsIvP63rrOoD0+QQdGEWS/LrbOsvomo87+5BIjEmjpYf4XSxgkiICbGV1/cFhqtqR+WGLS2ubDnVfZb5Q8M9CHHYpmjaOTvQX4CeIhCM4LZLyT2I995vOiEknww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593378; c=relaxed/simple;
	bh=e6RBBWKSJnPSjZrR379oQbLozavarmDyGbGZ/PhXlls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7hvSAyaFyy/fDGzkbPRCBk5oL/DnKQwBj0UtMmFVF06RM742YKVcqItikPGyZTOMvqPa+GL4FYjphhLQ8CTpQ8h6H+HPWI6/XACsc6D7Mcx3mVljqIjS1bTadSvq8EHv+hHmTAxxyeOXcSH8XyKLE/Pjw4mVt7+2XlCiQEbHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rkiA7YOg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rkiA7YOg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-426685732dcso20192335e9.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593375; x=1721198175; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIk5fgJ7RD8PhzNLK1dlDTI2NEOLZ8452S9H8jNMDjk=;
        b=rkiA7YOgnYJ7Jq0pB/6+Fm9GPFspYT7agXN7qgz0ZvRaJIwFAhTItQiAIMLQAGYalm
         l3u0YEWbCUFo3ZXFKEorFjKywm8qd09CjevsY5QvlgqumCnByiW5q3JP/3zchBxIYv0I
         m52T+9gXkLHqc7G78NLvHd1M9H03kHbhG70CG0bSOWZPy+Oz6akWCvfuAk0jLQKH3yFy
         3buoe4KaOCMIir2xLin8diJUfJBv/0Fbee2VQ5967bw8dVRzZLTuc/8qizCSjN9EzE3v
         jerj4IVH4h619k8iCRP3U+qHYNSUQFAAmgu5GqhibHNOpG9NOHZNURGZ0/j5XRDaJ/tY
         3/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593375; x=1721198175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIk5fgJ7RD8PhzNLK1dlDTI2NEOLZ8452S9H8jNMDjk=;
        b=RkEm7YSr5iEXbiBjl7NaKcojoO/2OLCd4VHcsz5RukyGVDvzpruCZuhmriAR7pyu27
         m3Ia+62hGkr7/nWrXlpGZ7yS1QPlj49BU3U1GkxiEmh+3Kb/Hqc0ERx5Ynz75GDaf7WT
         E1THwFYHBnYwSeOxp2ZtvKSlpL3+LHWILGTke21j3JNyz5kMMBbw96oB5U94+Fgu0Qm+
         HCf3yDM4MSIbTB7ItpqaDeyFlkZVxRD7wMXwhOPLapqkCaQWERhRRAalOO3iuOUvdVE8
         jeS9h+CEWvoU7Bhc6UwbP6IHbjRxdVvStm75tPAkJG2RMMC9GT+CkBhuxnlDv1VmRPJp
         Ndww==
X-Gm-Message-State: AOJu0YzY8EPDMJOCjHlyLDQ2OumiqFnETDTmNQMtzfJ07B3BXd+1Mcei
	rBU/PBRXbNexnC6tAfBX0VyFBRXceWKnlbykl4EfIfrPkzZMk9MJF5tDOpf9V+wETqv61pKSpke
	z
X-Google-Smtp-Source: AGHT+IGzbVB03kbNgoY4uSaSR59ME5p2dXYyKFvCkfgMvrd9lGO16ogAB8sNg5N8wTwXugjJrpfOqg==
X-Received: by 2002:a05:600c:48a7:b0:426:6158:9b54 with SMTP id 5b1f17b1804b1-426707cc018mr28774825e9.6.1720593375399;
        Tue, 09 Jul 2024 23:36:15 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42725eca905sm45325495e9.11.2024.07.09.23.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 07/13] virtio: push out code to vp_avq_index()
Date: Wed, 10 Jul 2024 08:35:55 +0200
Message-ID: <20240710063601.2000149-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710063601.2000149-1-jiri@resnulli.us>
References: <20240710063601.2000149-1-jiri@resnulli.us>
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

