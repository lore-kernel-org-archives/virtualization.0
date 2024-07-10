Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6079B87
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593372; cv=none; b=VP5CoyDL650EfUMZRsdqfEJhvXwrgNttDoTKhDw5VePcoGD2UFWZnXyOfH/M2AeSOyrm9rbikh2VIrDmZbYaxGRJvoTyjz4kmJObl5NKOFzgLXoQi4Xf9pR9PjgFpJdo+OdvxF4l6X5/bdzxr7Z/cp8xsDak2t8XB+j6yPuASPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593372; c=relaxed/simple;
	bh=bec4iyc1Sbq8yz22gt4sGJY5B9VhdZtggRzMHArlerw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUboSkfSDdNg0tB/FKzNxfo9gWaFGsy+rrbhuIpI6IN3SRwu+Rfe6ItskqF/xR9BCsSfL0N+dcRu6d/FxzR7L9DiUTBvOTXhOlriGVNnF6OY149VhOD9/Gygo9dPofyfdLK94mheYEq3tZ3XUepqnPc582lXfHVkqDBGcREG4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XmtMGrG4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XmtMGrG4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so15997315e9.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593368; x=1721198168; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnc5ZKFUsODytzmx/tV2yHyZn0mfCK3BqMy05RDjN4k=;
        b=XmtMGrG40HkZY41EDckvnqYymfdJ3CcQ21xwv9hTmGKDkQt3eEJTnDjOiGLXnllKKk
         1IcsW+g7UR1F4abBSI8oV4zD0CVBmhjt8dSHFuCmCuRXaICPPGUUlxJUNEMQJ9QLm30Z
         w/KZKMHWlRbg9X1cffMkqivTMfKBqClBRluXIVdkeQ4PkB6xmXdW0iXHW3rs4XMSs2PI
         fTzOXPJVR12VRuWkE4aiKzxt58vaRB98Vtt1EJimgviYiZTODcU/q/BaXRumHyXeh9JZ
         LlG6suYj5yVwDf79Efb5s5e8+HMObTHepQ20ypj1I6zc72r7TWhAV6pKysvyrd5jlyI7
         1XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593368; x=1721198168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnc5ZKFUsODytzmx/tV2yHyZn0mfCK3BqMy05RDjN4k=;
        b=hmijLoZeSlXmFb4IC7cyfWi3y2wKuDRJbYQQ+4gYj2cBXnatiCw0rnsQDIg8sx/1u/
         1mAo6uuF0DOm8eaWOOLpoxp0MmnjI84Y5M4ZNu39W7UjcL7NKiVAI5HV2HnqKm5GYgpT
         Cqxa+u48Os7EhGbxr3bO+Y6+b9XwOP9GKNGebaGhTOHkN4qzwoAY/4gjOhtFG2GIfNyk
         2KuaKHFYN6uzpD9gyCRwA8h0maWyx0YSQsiDtqTXeWOByM2FYIIkBqFS8lUGOMbG2bha
         7Lcd0uqdDDy/9YrbeI9HXDzEKIZG44W3oZWV4qXkFmf5INuH0iDkxUrNDGGv/0LQCbUj
         Evpg==
X-Gm-Message-State: AOJu0Yz2V6TxQfIkzWw2sFQP8F9xtWMScJsvPGu8dRxbOTxgesuujQ6+
	g1/OgqQqdRdOwKop3nDhK4JP/ZsBr8QVdIG60A4ewrEDrGpTmYron/1ww0eSOGySnTNRzxPYV90
	m
X-Google-Smtp-Source: AGHT+IF5Z2+zMq34Vmysr5qOIjtptRcselipMKozHzoPLkgn7ien/cItyPhJntk2RCvvdUXo5Jys6w==
X-Received: by 2002:a05:600c:1c99:b0:426:6c70:dd9c with SMTP id 5b1f17b1804b1-426707f7a23mr30964845e9.31.1720593368344;
        Tue, 09 Jul 2024 23:36:08 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f10ebsm67933845e9.16.2024.07.09.23.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:07 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 03/13] virtio_pci: pass vector policy enum to vp_find_vqs_msix()
Date: Wed, 10 Jul 2024 08:35:51 +0200
Message-ID: <20240710063601.2000149-4-jiri@resnulli.us>
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

In preparation for another irq allocation fallback,
introduce vector policy enum and pass the values
to vp_find_vqs_msix() instead of bool arg.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top if find_vqs() arg conversion patchset
---
 drivers/virtio/virtio_pci_common.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index cda0d35dd9e1..7fec2258d125 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -287,6 +287,11 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->vqs = NULL;
 }
 
+enum vp_vq_vector_policy {
+	VP_VQ_VECTOR_POLICY_EACH,
+	VP_VQ_VECTOR_POLICY_SHARED,
+};
+
 static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
 					     int queue_idx,
 					     vq_callback_t *callback,
@@ -328,17 +333,20 @@ static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			    struct virtqueue *vqs[],
 			    struct virtqueue_info vqs_info[],
-			    bool per_vq_vectors,
+			    enum vp_vq_vector_policy vector_policy,
 			    struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue_info *vqi;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
+	bool per_vq_vectors;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
+	per_vq_vectors = vector_policy != VP_VQ_VECTOR_POLICY_SHARED;
+
 	if (per_vq_vectors) {
 		/* Best option: one for change interrupt, one per vq. */
 		nvectors = 1;
@@ -427,11 +435,13 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info, true, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info,
+			       VP_VQ_VECTOR_POLICY_EACH, desc);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info, false, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info,
+			       VP_VQ_VECTOR_POLICY_SHARED, desc);
 	if (!err)
 		return 0;
 	/* Is there an interrupt? If not give up. */
-- 
2.45.2

