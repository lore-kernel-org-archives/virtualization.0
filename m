Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CE3E556C
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311135; cv=none; b=koS5KRAlW2sxA2djl9ED4Vl6Osxs63v7nlP/pTwfEVbar0UxDnH7il85UM/MX8Cpx8vuTTbygXSrsF5Arp61aHCSa007eCzb12qlQ3zC0wKr5vdoJLinlqH4iH/nQ7A0Iu41RRWF+mbsG+MvtOWUgEjQHotmN6cb+skNAU29odA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311135; c=relaxed/simple;
	bh=NcY3/HYuL0HhUfal/SPd7W7TNW+k4WOElEB6PI8qU9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnsDFBP/4d4Zr1VliFPTg77CrlPcSeBBe/hyGvomRPZzRJ0mXZt+sG22wqG0sSBI1lFmAVw7sU8jb7VkbLVeT32Mjnuu7UO+maM2DNKSSgxvacmraw0g+QFDWcutyrhG+erABSt84ZNYAE7WxKML7AHao1yGbs1B17tAHeglUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq7Q2gAq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq7Q2gAq"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70f91776fcso4096426a12.0
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777311133; x=1777915933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgov5pKPFmVmTdXq6mInFjiLm1BGL5Qb5uWZW3rhPvs=;
        b=Zq7Q2gAqSFFjqbasi9NX74ZEYO2Qwk9jv3CYYmwJORsBR2vYQqgQVbtQ0k7FWEyIVU
         iLYxi4DRj8G2SRYKKaujIMxAU95JKWDbgjr3roLOi5IjxPgQxWSWnsYCcn3SQZwJL2Bn
         ePbQM2m5C0uv6NEmAnLaNZAeIK6cVf29hT/aF5i8GPBS47NUcZPQzwVNtaBZrfUCith0
         30cIvlAC1Aley4IjIA1vDFwxRDypgUbUFiYyJHa4wVyQYIHdngDvI+TnIIOoo4c5sOh+
         WEfTXg2rhhTLV46lATnwVBnMp8afCs1h+QSF7yFpirJdBB8nMCtY1sZZIwrpKv5HwrEr
         0VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311133; x=1777915933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgov5pKPFmVmTdXq6mInFjiLm1BGL5Qb5uWZW3rhPvs=;
        b=LvMN2dhhS/aOLVKuYcUbBr5i6udmd1JoTmltsTHJuYF4ByKB80z5N+EORJKQCP4zCD
         YCWcW2+b/S5G8Ya4lrE2JKnraRqGZz58RULhSdxuUcoZISzBIMiFUMAyWlN2m5rig9yw
         5RghmG93WxGv6WBEPAsKu9pabKQXaIatqPF9EQQc7SxywX+GhE3vpKb4gv5F7t50/JV4
         cwDsRhGzqgSue/p+CdVsrkUkZIFetZYoJZ+bQpSu2oXDXRETk2MJk+6kLIW3UokbjjK6
         X90G8ibjhYpHI7E4I77Ttn77BFLQJLIaRurO2gsyN1GwuqrRnViUoySR0Gn/W3C9au+g
         Qj2g==
X-Forwarded-Encrypted: i=1; AFNElJ+fpbiKUGhRQwwBLQW9x4inFZczNP/oQzChlZBZ5gNpaFOTDG+N8lC343raBj3LRIIx8UVd6dzobEvUra278Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxYxSb1MK4Gl3gToKasBqrpo+ocoKnHS5CONio8Xi9AV4mBsEd
	6Nxwq5zHQzdR7PwzogxmAlOpaj3+FUZdQmjvT/3vhysleMnYzgCMQgea
X-Gm-Gg: AeBDieuhz/wvJqWFeXwpeGBwY7JcF/b2UhNNaTaH8IWMGvRAp6WMTh8hKZAol84nl7Z
	nXOdCtBJL//Q7qozSdBMitiz0YC8U1SEt2Uz4KafyMy75zwBYdnv377Pfj/2Di+go58NWKQHIHG
	H1C/GHE+NaC39N4IQMXTnt3EK51pCLfI/DCIOlWoRo07V414ibCVoC7G4f2/tzjOcJfw6pCrPVl
	rl4x3lC+8U/CRda4cIiVtY0snaTayA0OmgJpWOUU/BAOadoE3wue+P3d0VNM9RxPkxPfOmepmm6
	bRSxM1b3zQSAAsjqV5K6CSP/ALxXGZ5gG+eI/BlWcUw05qmuHpbQtp96kGpzwE4knTq8j5+0o95
	u3wdLsqXHORO4s9Kp9Td6ltBv+ERON8SKbmvTNevDjFjwR+Z3OmrpLhp3ztfEfdpog1L6CB1DVy
	NxHkZk6Il4V++kFEIg6pFk6WPoWERcyhzhY/q3DPOOsWLMHYjLm1tl3DPbOJli0clvxp4geQppv
	McI2bJPuJqHclOFmc4MIxbi4F0Vy3d0eA60Fg==
X-Received: by 2002:a05:6a21:3393:b0:3a2:bd1d:d684 with SMTP id adf61e73a8af0-3a398e05ec1mr359533637.33.1777311132902;
        Mon, 27 Apr 2026 10:32:12 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7977031729sm26246246a12.25.2026.04.27.10.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:32:12 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v6 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Tue, 28 Apr 2026 02:30:45 +0900
Message-Id: <20260427173045.28652-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427173045.28652-1-baver.bae@gmail.com>
References: <20260427173045.28652-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio_mmio.c | 136 ++++++++++++++++++++++++-----------
 1 file changed, 96 insertions(+), 40 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..71d13cb57c43 100644
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
@@ -547,14 +584,33 @@ static int virtio_mmio_restore(struct device *dev)
 {
 	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
 
-	if (vm_dev->version == 1)
+	if (vm_dev->version == 1 && !vm_dev->vdev.noirq_restore_done)
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

