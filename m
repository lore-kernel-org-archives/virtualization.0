Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046DF176FA0
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010382; cv=none; b=QrDCkpibXsDJVcfdfH7DqcbvkHLsGHlXFZJfn0L45a7lLQXmpLpgqwxsU2OLijjnbDcvAPwzSMEJtbqaY9QxiVpGfiQSv8HtXaxax9msGWjhp7jkM77pG1fzS7zrGMXmlIE1C2R61ULHwGHAbyNeu8+c89CuLs83UTAGS6vUjJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010382; c=relaxed/simple;
	bh=wjS09m//K7vN8v/ezi9oLsNEc1PAlH4aJBGOJNAznz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etct7RiowLi3HhvNjadADVG7DGeD2KA89Y/kse3cDe96z6NWCWZ2l7XSXVoyeL5lgJg5P6FSPwoQ6nzxX0587YOLPuS/OeLeJT+R9I9rdnilYHFFrbOKJCAldab+/1bQhq7jpgUFd1/KiSB/IQ1r8LczjvJErV/g+juE2KQancc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aIqZx97Z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aIqZx97Z"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e8037f8a5so5367430e87.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010378; x=1720615178; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzR84wmLkcmcIanDmXRRLBPhQF4vJUua2BJUpREC/2U=;
        b=aIqZx97Z84JBOewDdcBbFgt8UlU+HIUmxE0XIHRKZzktIcIguurDLxMoq7h620RAFP
         HG1J12HDy9wSx0xrDbPx7mlsLQmi9i9KjQVuNKhNvz8cLCM/BIjYUBrPf2TGjtohOZcF
         JfgwlZ4ONOYTARyG55p0CpWutJTZYhWrFgqRGZe1Kte3bt5wpMXSSC2lV0kxLUy3FJ0w
         0QHaEJX33cxn5HhTfiG+gcaxCmVXHX/J/VwgKMezqXlFuYgr4eibsuWpxaBdC6ji+WGk
         OERAHTsCoylOwAk9nFMzbCMIG9tIp3mF1Y4mJAeOD7kMUIqE+P1UcxWgIiaXTrSxEr5R
         4NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010378; x=1720615178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzR84wmLkcmcIanDmXRRLBPhQF4vJUua2BJUpREC/2U=;
        b=ZY7ql+/t2xzmgQxv7AlTAswHHHxTn37b7ntnQkTN5/LIvqId5qHIsHCszpTLiEpiGn
         HqLGSWfbpzNDG0cjkxqausfCFugthnF1GCyQEfJ6+dN0OEAefQ2RmPziBrZl+RUytET/
         YQk1L2gXPPSF2wy2MsQF4VLPxjgLrKuxdzFvNrIxad1OV8/XDc+BeEurHq0kZzldkjp8
         SzeLu5cf/g4C5bnNtGzHSkoEoSBYvaU7Ejbxi9CjezzFWmXA/KfiYf8jKnz/0wb37pmR
         NG6XuVI/Gxr3zu6Nflu2KSZ+WGjklfh1kwyOxCRsDLEH/vfxhBTYZ+gzC8Qv6Ah3c5aJ
         dGNQ==
X-Gm-Message-State: AOJu0YyqretOA3T31eDB6mHhbDETTq2UtXVUDf+OjP/Qtq9R9FYaUu+f
	mv0FzuSmnAoc8pIfkT8PxRPdEzVGkmGT+wHLPjtStrWc/+W1XRm9tW4uFbujyRiKpKwmXzzQhUx
	2
X-Google-Smtp-Source: AGHT+IFn4hI/ch7bm+4+dFIB5yvQI4cBf94PtRJ3R3SGW2wecmVBs466OlQf7QHhtYjXwRf58H+X5A==
X-Received: by 2002:a05:6512:39c3:b0:52c:ec68:6165 with SMTP id 2adb3069b0e04-52e8268b62fmr9407832e87.33.1720010376865;
        Wed, 03 Jul 2024 05:39:36 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b068e93sm237869645e9.24.2024.07.03.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:36 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 05/19] virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
Date: Wed,  3 Jul 2024 14:38:59 +0200
Message-ID: <20240703123913.969202-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
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
 drivers/virtio/virtio_pci_common.c | 49 ++++++++++++++++--------------
 drivers/virtio/virtio_pci_common.h |  4 +--
 drivers/virtio/virtio_pci_legacy.c |  2 +-
 drivers/virtio/virtio_pci_modern.c |  9 +++---
 4 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6b0b00e4599..ce9cce6f6a08 100644
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
+			    struct virtio_queue_info vqs_info[],
+			    bool per_vq_vectors,
+			    struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_queue_info *vqi;
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
+			    struct virtio_queue_info vqs_info[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_queue_info *vqi;
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
@@ -400,25 +405,25 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], const bool *ctx,
+		struct virtqueue *vqs[],
+		struct virtio_queue_info vqs_info[],
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
index 7fef52bee455..d7e65631b5f6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -127,8 +127,8 @@ bool vp_notify(struct virtqueue *vq);
 void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], const bool *ctx,
+		struct virtqueue *vqs[],
+		struct virtio_queue_info vqs_info[],
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
index f62b530aa3b5..20933b9f2568 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -595,13 +595,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char * const names[], const bool *ctx,
+			      struct virtio_queue_info vqs_info[],
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

