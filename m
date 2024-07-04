Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725E1A08C4
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075447; cv=none; b=XHxJ2H4OU3hI31ajQsyNd7fBbj3+rOkFq2o+kOlG8K2VSOBSjMUWvsl0svyI5GyqVmgbUvR2E0+RuWnCm1ICQYunb9kIBU5/875hRUlTwHj0JlEtIkcqVuQJL48XbVOyJEnLB62LfATkzb4bEFZjvEYFycYF6QGfNob5YtYZ+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075447; c=relaxed/simple;
	bh=Q/AWOVhKJ0z0WshdqHNAIqpD6hVD4f4AOWvmO7khcrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa2bV9hH00toql4PSQLswKNGbaXeNI8me+s4jQj/ovdq1vZWB8Bw1dVJEXfHOdd0B0TTmxDN2o1EGtxX4Oqm4FYJIjdW+//+Cmu9IkF4UqyJagziybfj2gVZZWCtsPKDOKrx/WEHE7DNpGv1s3iAZvI0Zr9l7vi3Kv+hADIvePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mq/R96ZV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mq/R96ZV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367895d9991so166113f8f.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075444; x=1720680244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y95FnX2p3ZDOS2kiv7rNcYSRGtikHPM0bu6WdzNAs+g=;
        b=mq/R96ZVK9mFrfJfvzE/ZSWz78qrBqjBhb6QlrVmXdOQgH5c++ca3TTZDpz/k5HeIO
         f0WYhDoD4Pxrx3Ippo4Y4gKwDm6Kym0nk2JbQIQlKvK40phMgtuW3os4uqgLwKKMkSYa
         6fO7iIZTsV6TeatHWiKo3u4n7KzW1TEZtqoAwLCZ6tf8qfZD9KaORqYwG2mt85o7XSsD
         iRH92/KpH0aamLN/qEtrcezqvMbUbw4LJPh0pugd0FhEljptm6yxHojHfUHoIbp5w+wc
         QV3cTkJZgEbJFit58CtSOFWncC6auTUGbFlCXCWBunRV8fvOB6WKQ1yq3Wrg+TWqjIwO
         DRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075444; x=1720680244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y95FnX2p3ZDOS2kiv7rNcYSRGtikHPM0bu6WdzNAs+g=;
        b=bgy5ICASyUTzuiqV5vPi734FSl5R4uxPLPBeybZay8W6hO+XjqK7qPSG2uELcIeVrA
         7yjzqJqMmAUZ3fAfb0Re4KChLQshRsYdIJL2zJmRAqh9b9Buj6dMsW+ahY7FirTQAF8C
         ui7g0vU3FjveoQdnJbxCkQqOMJWIeWePnMI2NjWlAadFeVbwuXR3P4x8mkWsMWt2+8Ok
         ZjcYbsRdvGZvpy1qwrqFXFnXg6nvdOBMkxB4Y4au77f4yBK49dx0uwRihjEUX5QlqwoW
         bVftkZdCB4koWr+BiBrN7pGxOXautd8VQkIwQJ8o9hbpm3IqQPy2ZuNfyrhB9HR2hm0J
         gl8Q==
X-Gm-Message-State: AOJu0YxbOQYRPHPseI5++SNzvb6tb4VwnMOk0wrM6MM2hH4oqrqGu5Kt
	M/EZay30gtB+lKaVHxmU1LEIJqHm5/YUmWUM4bfQFJPXZGg4ZtA+CC04EraqbLx7rW61n7cj2d1
	P
X-Google-Smtp-Source: AGHT+IFfFYABCm2ytqO5RrVyvba8os4hepc0N33SGUB18giMlwB5KQ6w9nHBYm+bgxW1uxOBYBCSyQ==
X-Received: by 2002:a05:6000:105:b0:367:9988:7300 with SMTP id ffacd0b85a97d-3679dd66b94mr466887f8f.45.1720075444447;
        Wed, 03 Jul 2024 23:44:04 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a13b61f7sm125251f8f.13.2024.07.03.23.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:03 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 05/19] virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:36 +0200
Message-ID: <20240704064350.1097716-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
References: <20240704064350.1097716-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Convert existing vp_find_vqs() and vp_modern_find_vqs() implementations
to find_vqs_info() config op.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/virtio/virtio_pci_common.c | 48 ++++++++++++++++--------------
 drivers/virtio/virtio_pci_common.h |  3 +-
 drivers/virtio/virtio_pci_legacy.c |  2 +-
 drivers/virtio/virtio_pci_modern.c |  9 +++---
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6b0b00e4599..3a1b74fb4da4 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -285,12 +285,13 @@ void vp_del_vqs(struct virtio_device *vdev)
 }
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], bool per_vq_vectors,
-		const bool *ctx,
-		struct irq_affinity *desc)
+			    struct virtqueue *vqs[],
+			    struct virtqueue_info vqs_info[],
+			    bool per_vq_vectors,
+			    struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtqueue_info *vqi;
 	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
 
@@ -301,9 +302,11 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	if (per_vq_vectors) {
 		/* Best option: one for change interrupt, one per vq. */
 		nvectors = 1;
-		for (i = 0; i < nvqs; ++i)
-			if (names[i] && callbacks[i])
+		for (i = 0; i < nvqs; ++i) {
+			vqi = &vqs_info[i];
+			if (vqi->name && vqi->callback)
 				++nvectors;
+		}
 	} else {
 		/* Second best: one for change, shared for all vqs. */
 		nvectors = 2;
@@ -317,20 +320,20 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	vp_dev->per_vq_vectors = per_vq_vectors;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
 
-		if (!callbacks[i])
+		if (!vqi->callback)
 			msix_vec = VIRTIO_MSI_NO_VECTOR;
 		else if (vp_dev->per_vq_vectors)
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false,
-				     msix_vec);
+		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
+				     vqi->name, vqi->ctx, msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -343,7 +346,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		snprintf(vp_dev->msix_names[msix_vec],
 			 sizeof *vp_dev->msix_names,
 			 "%s-%s",
-			 dev_name(&vp_dev->vdev.dev), names[i]);
+			 dev_name(&vp_dev->vdev.dev), vqi->name);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
 				  vring_interrupt, 0,
 				  vp_dev->msix_names[msix_vec],
@@ -361,10 +364,11 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 }
 
 static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], const bool *ctx)
+			    struct virtqueue *vqs[],
+			    struct virtqueue_info vqs_info[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtqueue_info *vqi;
 	int i, err, queue_idx = 0;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
@@ -379,12 +383,13 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	vp_dev->intx_enabled = 1;
 	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false,
+		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
+				     vqi->name, vqi->ctx,
 				     VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
@@ -400,25 +405,24 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], const bool *ctx,
+		struct virtqueue *vqs[], struct virtqueue_info vqs_info[],
 		struct irq_affinity *desc)
 {
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info, true, desc);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info, false, desc);
 	if (!err)
 		return 0;
 	/* Is there an interrupt? If not give up. */
 	if (!(to_vp_device(vdev)->pci_dev->irq))
 		return err;
 	/* Finally fall back to regular interrupts. */
-	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
+	return vp_find_vqs_intx(vdev, nvqs, vqs, vqs_info);
 }
 
 const char *vp_bus_name(struct virtio_device *vdev)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 7fef52bee455..3c4bb2d6163a 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -127,8 +127,7 @@ bool vp_notify(struct virtqueue *vq);
 void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], const bool *ctx,
+		struct virtqueue *vqs[], struct virtqueue_info vqs_info[],
 		struct irq_affinity *desc);
 const char *vp_bus_name(struct virtio_device *vdev);
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..a9786e38d763 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -192,7 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
-	.find_vqs	= vp_find_vqs,
+	.find_vqs_info	= vp_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f62b530aa3b5..adba4a29fdf4 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -595,13 +595,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char * const names[], const bool *ctx,
+			      struct virtqueue_info vqs_info[],
 			      struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq;
-	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
+	int rc = vp_find_vqs(vdev, nvqs, vqs, vqs_info, desc);
 
 	if (rc)
 		return rc;
@@ -782,7 +781,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
-	.find_vqs	= vp_modern_find_vqs,
+	.find_vqs_info	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
@@ -804,7 +803,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
-	.find_vqs	= vp_modern_find_vqs,
+	.find_vqs_info	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
-- 
2.45.2

