Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047F1AED57
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103627; cv=none; b=jdsY4YgFTGCTPgj6mLu9suEqw2TQpQFOOpdo35SsTShH2RXKW2n0FRMXz7JoUIG7++XwTxkm4/gaBLZ/2lzb8hSP5lW47Xtd3PxSBHHzbS8wqFPVJQZJc4CDFnCmdu/X5pNFs5FJ52SiUa6w5xOGUXVx6enceK0Xoc/v6fYkJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103627; c=relaxed/simple;
	bh=Q/AWOVhKJ0z0WshdqHNAIqpD6hVD4f4AOWvmO7khcrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umyZYj4koyjXAZlaXYVEFWR57phVA4f8q+YmH7I6GmCepMznrQnpmZRbl8UF55D8Ll/D2kvvZITDA+omNhpQhRGnZLRUPCRThoDwRPMSWZWjBeKklrXZiuQ7JwawOte1OoXZRNBX8xugndCQjqj5DP0i5u8Mv5DrmThaPvwBYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w4CR8T+9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w4CR8T+9"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso6087265e9.1
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103624; x=1720708424; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y95FnX2p3ZDOS2kiv7rNcYSRGtikHPM0bu6WdzNAs+g=;
        b=w4CR8T+9SPdY9Q8nJTtglBvkPkXRPSHzBa6DGLFgZ4x5YTMb/brr/8rLufVe2b2SFN
         1zxpH3rGOeNFvQO5uzBQgCmtFI3UhG/ancAWse5dwde4scZrv2irApFJBl00G3rWCu6M
         l7DgiqNbA1sS7VZo+b66o3UOU3R4LLzYldK2tafDVjYQRgUDjoNZ65IafWjo6EJvUNRS
         avvd6jhqEqcMCiQvTIp5qRwDlWHWLJv+za6ODjdLXykE4zdWZaPjdg8RYSOPSTfLtY1m
         3L1Q/bHK7wepG3RdHGpZgC4Z6pAA3xAHGvChEplGKqprCvrUH8hDhLtXNWj5f9kSns8X
         u2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103624; x=1720708424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y95FnX2p3ZDOS2kiv7rNcYSRGtikHPM0bu6WdzNAs+g=;
        b=ped7Cc0IabFub9IbPgmhAcCLxfgAXLuMJD/v8YFbIi5HMc0sKusaCQ77qnUejXC/IK
         a0R6cq4+GdAYf8PKR/GUC7bZ154l2jXmj0mg2tMrMtNMcmV89fyLIcGI7jpHZgowGqO3
         slEfGnHHE0hZvfNEeTw9PGvehZMQNfJ2AWiEP7QuU4Pu0gGEuuVpd2pczsu2CI3IUdmE
         ASu4bKR6gjxbp4qgHagSBSr8ZunQv1jsou9ETyI3re2ltWede9Is9QzWSKpEYjCv9IOr
         bu6bfKI2H2kDKKNSBlzdTb/OGsssCKl/YZc9sRv+6plBhEUsvGIe7G+cfhoTpbtM+iAL
         xbGQ==
X-Gm-Message-State: AOJu0YyDe7+GeY2MZS62miPwS+ATQzh4YbX9BtTC38skdF0LKKN8fVBv
	J1hCwomJNQKj6yqaa5koM8fEYtjrxdOyCmB0XQJ6MmsOLiiCvq6Xh27RY2je11aKyV3F97VurUN
	+0dc=
X-Google-Smtp-Source: AGHT+IESK+qaPBf+4YCDLMyn2fNN+PFmGtMfkWxqBZJMzjMlj0Zm9DcgC5zTDijLzDIajihr/vtjYA==
X-Received: by 2002:a05:600c:4a9a:b0:424:ad83:ffb3 with SMTP id 5b1f17b1804b1-4264a3bc287mr19081555e9.4.1720103623607;
        Thu, 04 Jul 2024 07:33:43 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fcac1sm27065525e9.48.2024.07.04.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:33:43 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 05/19] virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
Date: Thu,  4 Jul 2024 16:32:53 +0200
Message-ID: <20240704143307.1212454-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704143307.1212454-1-jiri@resnulli.us>
References: <20240704143307.1212454-1-jiri@resnulli.us>
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

