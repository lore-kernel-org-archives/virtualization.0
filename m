Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FE302CDE
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033827; cv=none; b=vEe93TlelZ+BLp+1esJqcvd47dSd1q1jjBfLZYLUrypVX3RZoRrtXLPUSlkXOItkSlKYZnvF2AKH+mkJSKiSi+FqtYxtcPv30Tzhx5KMahCBirl6T53QuWWF/Z52duA45AJ1dwn3kToB4TXjZ0LdNAtsqsigWxQBSp8btzK8TRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033827; c=relaxed/simple;
	bh=wLKpK3tMbIqIN8Ol6qX8hkN7d3LwE17kRaqy9JLPUw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvC6QjoqnYLl3ITtg3PedZiGri7QNsJbhHzgwG3P1CVsqG3eEBRAkOfE1HLLu0yF01qBA2xkZR1+fQ8uJt6SYpkUs/uAfFLmX+MhsvQvDq8RSZFjQzFE45L+52+Uz4ScpoW35pBRNBcDWgmhLROCkR04FzAOIevPvKsV/cqFxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDUJbfhr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDUJbfhr"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e2355739dso3161606a12.2
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777033826; x=1777638626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhejpkHi44NTY/EhjfX/VPO4q3I84QLwQ+oZB4nOOiw=;
        b=RDUJbfhryLqokLva8HIGYAmE+gtUPvnYjMC4TrTCORG7V4grLnTRuhJLKIM4mecRwQ
         QgrE4ET90XSQbdSXWAl9ICBoUqH7MSuo4Igaxsk5bTqgixd8RSD6DnD7dYya5cPBhwz1
         beGKtDXMCQYhGszZAGJdHjkqvjCByBoMP7dXyfoNCJ7OdDIjQhW0WC799ukTKEFGz8hb
         u1dgBS3EvAukCMMbn2bDg26A0vK7pCH0oE7pMmgPQZxF8AH8sMZhFQq+gM6oRvH9kuP+
         m2rQ1hQLAVVNxe9PQX+mpvF4xZwgm2zO23Figpf7zhDq2J/jppSOlUt6szau7A3suDHr
         uRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033826; x=1777638626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jhejpkHi44NTY/EhjfX/VPO4q3I84QLwQ+oZB4nOOiw=;
        b=f9C8Tk5AVRtDSWNu6tN7a7AV/ipHxaymUiU4xRrlHYC/x+ZVgIF4/panLAkZ0KB+5G
         KIDb5LJq1PsXHft0Bao4iL09++PgnFiqDR7nCkkKNvgSaVb0mPJGvK25vm6EHw85SFE6
         sZVeSroSrHGAUyZtZVfRpQwuMg9Por9VP1ZKj8rDfps6K+hjOkAAA2XRhdiboGWAfanF
         4CcIrsaid4ItIFgvBgE5Gad/iULN/QqFxBqjUR6KQBJolNpTWIksR9tqiRgZg9mryE4U
         DVEUfEqx3uLbG8RojxDYrakav2BRQaHdycwifS9mzJ2s2IhXuiq6xI5sTGELszUWoWOE
         pNGw==
X-Forwarded-Encrypted: i=1; AFNElJ8jePU3rA/VpygVSN+3+eIEChPcFsC5K0BG97e36VkdAumXLj1VpBS7Eb1LCbuvfDCWXv+F10EpQ5aLWEJNAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEiBcRNzXFWrBHLUfQlBwmYgv8tOKhvNB1eABrp1kAYcNQUxr7
	QeSGR6Lx1OhvrnIs/FI5vbIufc9eJaa3iKJMalptG6dH40npKSSyfgPm
X-Gm-Gg: AeBDieu5GvYAALUrJyT5SkE9ElbqzwCJdWMXqWrolrsQ+PN9R00HMAptyzH/UdtjCt+
	Iu41i2YbRi1pMPxZEC5M2Bk/erd6EKiik+pV53k2LSADTlbImcqP0P2r8fzRz00EtoMfLzEtvXL
	H5SnqDf4eYh98CuKbtvrj4JYT470qcenNmvEyX3hgrrzlFCHt0H4J2VTLpXPVexeUi7j10DCXye
	cT7sKrUhNNfgSCrOYOp9F2u5EZx/gjlqMY/n7dKWk8iwm/0QO6WeN/U0xLUBE3adBXhBl+L5fpM
	lQIAGqlXF3bd51AnTuo62Yf7gnYWthC9qKsgxMv5wwJwlpKhxh5qd7sYOWxAHoGUbqKLBnTyd1N
	TvKikXQpjgs0E3c11C/f22fALoFKJ/N33wfGtmHiz2nFJxC3hx6FJo0n/G4P2Pf5VY7JQTQlZB5
	aHv8l11/Hos4OkCGhWu9N8jelnmjHo5YafXa1nsbcOKqetwNHqtCDafWg6V+iQAsmyFeQ5zQpxm
	IIoXFK6WHmQ19+kEXhwPiMW4NvWrVYD5kSv/A==
X-Received: by 2002:a17:903:28f:b0:2b4:5309:2c14 with SMTP id d9443c01a7336-2b5f9f3ad64mr348042135ad.31.1777033825376;
        Fri, 24 Apr 2026 05:30:25 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff734sm218006415ad.10.2026.04.24.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:30:24 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v5 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Fri, 24 Apr 2026 21:29:54 +0900
Message-Id: <20260424122954.273-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424122954.273-1-baver.bae@gmail.com>
References: <20260424122954.273-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio_mmio.c | 134 ++++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..1cd262f9f8b6 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -336,6 +336,75 @@ static void vm_del_vqs(struct virtio_device *vdev)
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
+		virtqueue_reinit_vring(vq);
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
@@ -388,45 +457,9 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
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
 
@@ -528,11 +561,13 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
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
@@ -547,14 +582,33 @@ static int virtio_mmio_restore(struct device *dev)
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

