Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371D48C8DE
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084664; cv=none; b=i/Jar/1us5+PApB35J8qCf3HNlrXWY9cSMtkWvco2Td8qkPoyMuaG7ANPh7b6G8RaOWjz2AJ7kym14K4wL3J0U8P37+AVikyjzICbaWxt5l4u/G25vpjUJ2Q/Im2bQ1uiqY+mTgdNF2g3dIJPQoP4oc7dOx8pNnXl1qY+qI97gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084664; c=relaxed/simple;
	bh=IolL4RY97C9MSpLuk3s2ulTCNVbomPxJq0SB6QX/VVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAM/myxgMg+rmBM98UPfiN/zE/tGoHh/pHol/ssj+OJ/mfWZ7pdcKfoUaI6HDREguYN6RWRFHvbEX9wDwGjPgA0qJNZy7rjlYTX3zs4kDAQKujCNvB4aqcLEZP8dhvEplZAk0Q46LEEebOaqZVbV2jbBF+HY3Qcip+fKkZUNdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKQHpC5V; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKQHpC5V"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so3091940b3a.1
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778084662; x=1778689462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLZ6Q/p8ThasrMA2tuzRiOEHpqfxlyjFwiRgvxlFlJI=;
        b=gKQHpC5VARo1WevW9xc6SBY0BrllB6rOv2vw6gJFWEKXhVqDkfYept5wb3WrLh6N9M
         3MyPP9RMX+6nApVDF1mG6hrH+cok+NiNLhAOpKqEQgdh4IfOcwZg0HvAAH1lPIZWI/kP
         mLlvFGQlpTWhFcQ3wO+m5NbzvlSc4CZOeFjU3QY+QEgTs0jz4Qnev5iEfquaPHi/A+3p
         Ia6izjeDG1dGYarS/v3OsrJmBMNf4ECRy0mWaAlCKO+Dc09UIb9FrDzbt8lAxAXaz+wT
         XJ7OShF1ayca6UZDp4ABo6Wd9MGqa53jzdl35iltFkQr8v42eWYml6mmGx4GHjOIvQCa
         LOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084662; x=1778689462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLZ6Q/p8ThasrMA2tuzRiOEHpqfxlyjFwiRgvxlFlJI=;
        b=n4FsAt2ylqEulMSVs0KpvLh6uCbJSDBlwwqG4vTV2dO3TKltcZHydHe6tpaMYivmvB
         thTb6SglzbZ7Zj65tnIYPhEAGEoDL3FOe5ZIcIiqagvyNVvniPjB/qMwEKAOi1LquCl0
         TkmidL0wbVZn5cdMQ8R7xUdWJUOrwqBV3TMKnJUF1ldU9Hw/ryYrAeijFVUKy1M+zO0n
         k59pImpSJxRtuoJ7+ghnpDq63a4i/AT6FwVWnxPeGAreRV3k/2sNHCXJb8srwQc9i+PE
         YTH5tMDICFjtvmKZiamqfDgbWxOmtA27QcGYQ+deLqV+YLhqEZVtgBJLMapzQagdFKRv
         /AoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GxH/SP/v3BjRtiwK0fp9TIelA2XBoXLbaOZfIInzdswdmpB57EuZ/bIHpuLA+nzygcLTMVIa8kPKTQbjhlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoopatGDYl/yREkguc7RDnayT+gFTsSDmp05xlPooAbQ/AUire
	evuHcoZX0LlC4KvbRilR/gz6CoeNQHxnHVdil2mG33H/iiOy9IiMeqx4
X-Gm-Gg: AeBDiet2HN2OMm2kIHN0XJxql6oXsqdV0GjeqvqWPo/nTnzoLfr5gScsm2xczWSa5A6
	QOPZCOSGyZVsRy75o1JXXpmPtrkd4kkN6O7XM5t9TzqbXG8LeFSYY/YeDzXtRhRRrLhbWcFkaUb
	Z2JWv8MwkZCr6trGUpvqujnC9tT3yPUVW/x7z8Ft0Ni1jVizDwQnd/eRBM1IbyGdYZ2QNd5rhAK
	mpoPgMG2VVczNitw/xgKepmk46MSXTlpGPuggCdUZraGlLLzhdQ5RoSPkY7lISgF85UJ8OrcUaj
	RePPSVArlZICMSEtG4iBb3nAZrUo0CEUwaPulSMVPJyosZv2C4WFwhErFiQBWPIMBFdVbYGyxxx
	IRu4x5M/4Pv3rxZNq7YW1SJda94nKkRmXLxcy4Z+XAzyKM1bc7iV1HuK7Jy/qbWhMzPQMnkaX6e
	DsADWD1Wo8T+J4JVV0zq8GLTR2dNTNaV/C/tXRv8iV0U3kPQ+1RiCpfTfp2CqEYHGZB92FCNGGy
	jG7EdlM7+Z28tFdpGjVqcrTlnmCPVQgwoFQ4S8M6XGm6n7f
X-Received: by 2002:a05:6a00:4655:b0:82f:38:a5b2 with SMTP id d2e1a72fcca58-83a5dd5582bmr3835165b3a.40.1778084662312;
        Wed, 06 May 2026 09:24:22 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8629sm5980337b3a.36.2026.05.06.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:24:21 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v8 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Thu,  7 May 2026 01:22:54 +0900
Message-Id: <20260506162254.25576-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506162254.25576-1-baver.bae@gmail.com>
References: <20260506162254.25576-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

Add noirq system-sleep PM support to the virtio-mmio transport.

This change wires noirq freeze/restore callbacks into virtio-mmio and
hooks queue reset/reactivation into the transport config ops so virtqueues
can be reinitialized and reused across suspend/resume.

For legacy (v1) devices, keep GUEST_PAGE_SIZE programming aligned with the
noirq restore path while avoiding duplicate programming in normal restore.

This enables virtio-mmio based devices to participate safely in the noirq
PM phase, which is required for early-restore users.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio_mmio.c | 137 +++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 40 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..4f4836103b88 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -336,6 +336,77 @@ static void vm_del_vqs(struct virtio_device *vdev)
 	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
 }
 
+static int vm_active_vq(struct virtio_device *vdev, struct virtqueue *vq)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	int q_num = virtqueue_get_vring_size(vq);
+
+	writel(q_num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
+	if (vm_dev->version == 1) {
+		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
+
+		/*
+		 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have something
+		 * that doesn't fit in 32bit, fail the setup rather than
+		 * pretending to be successful.
+		 */
+		if (q_pfn >> 32) {
+			dev_err(&vdev->dev,
+				"platform bug: legacy virtio-mmio must not be used with RAM above 0x%llxGB\n",
+				0x1ULL << (32 + PAGE_SHIFT - 30));
+			return -E2BIG;
+		}
+
+		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
+		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+	} else {
+		u64 addr;
+
+		addr = virtqueue_get_desc_addr(vq);
+		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
+		writel((u32)(addr >> 32),
+				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
+
+		addr = virtqueue_get_avail_addr(vq);
+		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
+		writel((u32)(addr >> 32),
+				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
+
+		addr = virtqueue_get_used_addr(vq);
+		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
+		writel((u32)(addr >> 32),
+				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
+
+		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+	}
+
+	return 0;
+}
+
+static int vm_reset_vqs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	struct virtqueue *vq;
+	int err;
+
+	virtio_device_for_each_vq(vdev, vq) {
+		/* Re-initialize vring state */
+		err = virtqueue_reinit_vring(vq);
+		if (err < 0)
+			return err;
+
+		/* Select the queue we're interested in */
+		writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
+
+		/* Activate the queue */
+		err = vm_active_vq(vdev, vq);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static void vm_synchronize_cbs(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
@@ -388,45 +459,9 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	vq->num_max = num;
 
 	/* Activate the queue */
-	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
-	if (vm_dev->version == 1) {
-		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
-
-		/*
-		 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have something
-		 * that doesn't fit in 32bit, fail the setup rather than
-		 * pretending to be successful.
-		 */
-		if (q_pfn >> 32) {
-			dev_err(&vdev->dev,
-				"platform bug: legacy virtio-mmio must not be used with RAM above 0x%llxGB\n",
-				0x1ULL << (32 + PAGE_SHIFT - 30));
-			err = -E2BIG;
-			goto error_bad_pfn;
-		}
-
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
-		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
-	} else {
-		u64 addr;
-
-		addr = virtqueue_get_desc_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
-		writel((u32)(addr >> 32),
-				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
-
-		addr = virtqueue_get_avail_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
-		writel((u32)(addr >> 32),
-				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
-
-		addr = virtqueue_get_used_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
-		writel((u32)(addr >> 32),
-				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
-
-		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
-	}
+	err = vm_active_vq(vdev, vq);
+	if (err < 0)
+		goto error_bad_pfn;
 
 	return vq;
 
@@ -528,11 +563,13 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.reset		= vm_reset,
 	.find_vqs	= vm_find_vqs,
 	.del_vqs	= vm_del_vqs,
+	.reset_vqs	= vm_reset_vqs,
 	.get_features	= vm_get_features,
 	.finalize_features = vm_finalize_features,
 	.bus_name	= vm_bus_name,
 	.get_shm_region = vm_get_shm_region,
 	.synchronize_cbs = vm_synchronize_cbs,
+	.noirq_safe	= true,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -546,15 +583,35 @@ static int virtio_mmio_freeze(struct device *dev)
 static int virtio_mmio_restore(struct device *dev)
 {
 	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+	struct virtio_driver *drv = drv_to_virtio(vm_dev->vdev.dev.driver);
 
-	if (vm_dev->version == 1)
+	if (vm_dev->version == 1 && (!drv || !drv->restore_noirq))
 		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 
 	return virtio_device_restore(&vm_dev->vdev);
 }
 
+static int virtio_mmio_freeze_noirq(struct device *dev)
+{
+	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+	return virtio_device_freeze_noirq(&vm_dev->vdev);
+}
+
+static int virtio_mmio_restore_noirq(struct device *dev)
+{
+	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+	if (vm_dev->version == 1)
+		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+
+	return virtio_device_restore_noirq(&vm_dev->vdev);
+}
+
 static const struct dev_pm_ops virtio_mmio_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze_noirq,
+				      virtio_mmio_restore_noirq)
 };
 #endif
 
-- 
2.43.0

