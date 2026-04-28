Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2243D4ED
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388900; cv=none; b=tryPoj672Z5a0XsWlGg6qQl+9QyHUjLoJoxxGhrQWbzhm3g7Pt+J7b+OsNqNsdSbTVC4+jSkPlSiOKObL/xDL5DWmLsNuzmfWKc8nIQcd39o+vIuKbM9wPIUIMhDQZyfWmgfSsEGJVKLeSpRcir97vhYawq5vUlwImm2wsI2Htc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388900; c=relaxed/simple;
	bh=IolL4RY97C9MSpLuk3s2ulTCNVbomPxJq0SB6QX/VVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xy7iYTk8Rue7FP8sS5hOG2s3YqVGmjoXJSw8JOMwNfilde1i4h1LqB0M88R+ln8FrQgrWiFO/xMWCSrhKbPuqht7B95UNS5eIYISBb78MxcG1rF6VJe18NBldjt14Ndm3y0QjHh7+LUXHcD9y+P6fwKKBfOiJO04PKLQzBGEgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oprMIVwL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oprMIVwL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so9715537a91.1
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388898; x=1777993698; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLZ6Q/p8ThasrMA2tuzRiOEHpqfxlyjFwiRgvxlFlJI=;
        b=oprMIVwLDO1y+Cn3jS7STa+F7jj3r6NyP3JEa74rBgKo2IzQbfN9Inc5SmXdz0z7MK
         yVFhnDpvnuCbmMupZ9EmkgytfWwvyAXN+ml2ufKLeQNyGCaQlVuU7ur6X/pRKEfXjll/
         uG6yWTuJ6eaHrYAFzm+2HCg9FH1Z7AapvGPhZrPJ+NmRNkPbNpwNkum1+GQTYgyVtClg
         r5TkzckCbAIAxxUM5jRbE7gpAmovtGisaWaWA6cIqXF3qO23p2KIYrujNGN0pX8gse9V
         4doF5UtrXdKP/UyIQmMCAA7IlIkOiPxnDKNtbeYRzos/MAIyRg2M4WoBWul9dBJnZTVl
         ChvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388898; x=1777993698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLZ6Q/p8ThasrMA2tuzRiOEHpqfxlyjFwiRgvxlFlJI=;
        b=BcfxJJidk258FWF183BDy/Kpdv0224TRPaz0wk2gW3FEg7LHT/xoxAVkOnjbrcBiv+
         VWo7D7yTSehCDl12uY+5MXXWU+/KCeRSajcrxoKcT2kPx9VK6NjV83SUYUN4P9zoS94u
         eIUKQuAwmFLmQ7r4iVau++Ag7v1X/zR6wbP73cUq5QsuL/NizzcFVqx+9P9EGRj3yfRK
         Hlop1k3eXFq2b7usBNswWZ2AH4b1pJhyGWGJ3ARSV6Er4x1GHlOI8ubKPjG8iNlvaGVI
         u5Inue+3gf53bdsHqlFz7Ykj51sgRYAbUzhJvdoKt9E+FSxsEQWWPPw4ToMX2U8fHGw8
         H8Ag==
X-Forwarded-Encrypted: i=1; AFNElJ91IeM5IX1QP31qGaEspG6HUlnM7+mHV7qyc5Czx+aocsXTp7EvpIE9bbfl0H4NYuRxzbxtkFQhCu1/T8AHTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywfb6/8i532z9L/a1/0vIKf5AtViudwlDyg5TgSVjdthvcUFBGN
	8hEtN7qCxAKLIwJ0vc16buBrmCVycc32Dww+OFj3XqaF9NnpwcauOMhu
X-Gm-Gg: AeBDievst9zF8itCv8c8v10J+oMZBXNRM7GYpajrZVLm5v2eK1W3IP93V1XSzaj/TgW
	m8Z9nr0V/le4Y7FC3DtSLn8q75sa2/6ckIfyezLoxn/RtXSKlTrs5WtZ5h0iRIbj25i/qx5Sa8x
	OAAq98muCYwHUCftJQXaXvNepsHZXpexa0gIDNNH8pUnqsGxabXqHLGFoagrT16uQ4DL0H0ZjiW
	bOhn4b1Dr3y1WxUpFcrxQ4m9nUtnzAlJJlYwFQVoZQ0K2/F9WRJlu8NCqJMLMcsVcjN31/AmzhQ
	VVkkUC7dah90F4CkOMJ/L7CnBGhMaLUxDUUQIzvPRPEujWm69j9gcRBa2RXLcPDj+YnHSJyI21v
	KPXf7XQSJYXYrUvXwKjMH0d4aSPCLcspakG+hZurYeFKHtq61NI/J1MfL8Vw7QzUT/a5U40YCfz
	88XH2F0N7GlNOvsSAUz8+wTbGP5l4BgxqSh9psU+P3IqhCrjBOiBrWfMxWoav5ydNuWS5rJmTsJ
	MdGaW0eqHYfCubmH1wi7mxHjPbud7T0TilVmA==
X-Received: by 2002:a17:90a:e7cc:b0:35f:9ab2:a5b4 with SMTP id 98e67ed59e1d1-36491f6cacamr3923091a91.6.1777388898478;
        Tue, 28 Apr 2026 08:08:18 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490bd66f6sm1606127a91.3.2026.04.28.08.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:08:18 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v7 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Wed, 29 Apr 2026 00:07:42 +0900
Message-Id: <20260428150742.23999-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428150742.23999-1-baver.bae@gmail.com>
References: <20260428150742.23999-1-baver.bae@gmail.com>
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

