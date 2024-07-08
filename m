Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AA36B11
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424909; cv=none; b=E203yIsTc+C39Wry7lOgIxqCEbjK8t5+ujYHQythMY0GToTkaGfC1Sgp3q1A01Igc93q7RrVo14Y8oEyfQzoNCjDCqbJgZgwqntW0escixYI2dQ0TfbcSbZX+c5sEGSlSM9IreaC5FMplg8kJtQd/CoZ89DIJfZLRWfcdNqhgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424909; c=relaxed/simple;
	bh=qnPx89TG/6aC10ZrqWJHbmKEkrADVa+4OkDHUutGJ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocXa4zsIUbHgLhW/T64sf67+UuMraGzSrvv6c7/7kZOGoIwqrc1tAqZdvncwoHtuVv9oICIRUTXdhDvCCEsgzDTYIv84Nbp/yfORs7cKF+Rl0e+Bc3k03SRPGT3nNDMhUkYsu43U1A9gclDYUjVqlf8tBP8KOZTxJmt7gyHi3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Lib+I2k/; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Lib+I2k/"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so21311385e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424905; x=1721029705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU9eYVQESXI82TBuvG+ykIBh2e1mk6nYpFyBZh808CQ=;
        b=Lib+I2k/8YMNufNHVRRcjB0tut6EzDcZVJEt6IFTSthlLsjq9VwtUxHwiVLj1g/8Xb
         3z9/XH7u5vgbUY2hGDzRmje5tf9DbMYKS08NSJ5DvbJI2iAdk5ectV0SZ/6O+z75Ezis
         oLpxzTpolTR/JfGPo4mfFBHA/9sv2HSUioQGmnSUHwc7PizVKLdp4KALphML9pHJMX8F
         fvLgLuUPmu2Ys8JSKoNdGXCTxvht+5mfK+uV4LYbfFxLaHnsVKcqoAI/0I4EiD6KXEpb
         +xCzmKlm5a9/jG2NP6PtL00nAB5b6De8pMkHn3l5WJ2LJlyVmrrYgWIeYmp3l8knJ1x1
         Om8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424905; x=1721029705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU9eYVQESXI82TBuvG+ykIBh2e1mk6nYpFyBZh808CQ=;
        b=DBgON4r9oUQfge/u1ApR+lgk2W1IRUxkAxY7uFFfefbjsN/JZQJUAEMLnv6JNLOsmj
         VYjir6bzBgstWqwx8Z5VtSep0la2oLW2lTrwoYwMu2rXj/VPDWgptT9o4sPl0Pcit5ma
         kLyLLb0EStNQclSH9YKkeZsWBDJ9KUV40obXhtA2SP4W02fa2+nJVia9ThJG/ccmzV8G
         K4TG86AL8FaAyPrIh4+uqSgac9um+6PLnqUSYr+FiYNdvl/PoYBQ+8dheeoFcXTeMVJO
         dCoYsXz0WXmjwLI5X3QKhgW7nPRnBCul0Je+VZccENOgD4t+VvjdMlD1wjpISmPb57aW
         IhEQ==
X-Gm-Message-State: AOJu0Yw2uvN5B/SvDqgajiIZgaT8CA7VUqcrheu8SRBwMcpdM6Ep7/EV
	Skvw7jNN/jUb+CXA4En9r94AOCJMFsf7uVpfm59ZyUVPJRsxmmzAAJs3jynGidnhb9+m5/LkPUa
	Sc66PWA==
X-Google-Smtp-Source: AGHT+IHNMf/jUIwWz9AiFg3xcW4j20kTLiJF41//pI5HnuRtuIdS6W/dvw7qwxENiog9kWVtlao+YA==
X-Received: by 2002:a05:600c:3154:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-4264b0cc4d0mr94491955e9.4.1720424905180;
        Mon, 08 Jul 2024 00:48:25 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dd952sm151611955e9.13.2024.07.08.00.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:24 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 05/19] virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:00 +0200
Message-ID: <20240708074814.1739223-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
References: <20240708074814.1739223-1-jiri@resnulli.us>
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
v3->v4:
- moved vqi decralation into loop in vp_find_vqs_intx()
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/virtio/virtio_pci_common.c | 48 ++++++++++++++++--------------
 drivers/virtio/virtio_pci_common.h |  3 +-
 drivers/virtio/virtio_pci_legacy.c |  2 +-
 drivers/virtio/virtio_pci_modern.c |  9 +++---
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6b0b00e4599..7d82facafd75 100644
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
@@ -361,8 +364,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 }
 
 static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], const bool *ctx)
+			    struct virtqueue *vqs[],
+			    struct virtqueue_info vqs_info[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i, err, queue_idx = 0;
@@ -379,12 +382,14 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	vp_dev->intx_enabled = 1;
 	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
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

