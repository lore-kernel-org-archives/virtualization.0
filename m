Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B09397680
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432953; cv=none; b=TSbEU5v/32DjscaM2rMT/qafbDlUdu0Rka88mTw+zwB8q1qc3Zx40U4vBH4a2eNULVbJVsB/rLJpu7mbLMr+8Z+QP+mOGIMgzVi7rfhqmZ+zTYjGNuqsLR3NtBJRa2Ttt7nkZwz4UOnkbWHx1pzFyZoenFltT8x02TIK4w1CYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432953; c=relaxed/simple;
	bh=tJQmTWfO326kdUEX0KHUrK6HcbNOKPA2N0r/07lyJRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BF2fyftnd94g0UhQDWqD1ldjmjswM00/8TGTY9TxFKPxOx5ctFpI1jRmruBZ0uD1+9alfDiJusctXFAQJsbhlfhK5UWUjQpNp7rw1+ZF+64W9ZqzAaYDDKNxQDfqX5fAu6sj2g6rLL5KjbmerDQhGxZZplZs0uWk3QUg404fKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnYj9E4R; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnYj9E4R"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c76b9efc299so292368a12.0
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776432951; x=1777037751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXcUGIfcha85KeTtKQKluvJ7CZSCtoU5lC4yHHMNuyE=;
        b=BnYj9E4R/iH/VgzvHHzKHfJInF00ZUGbGTI3kHCtoBBoCRhN9bRWY049sCUj/+KyC7
         pxccFhpXc5m9VWYJw7+t1N00xMbk80zqmky9vfb2+6jNPPchaGrvjbwK/S9N0Bu6TCNS
         5VKbXroVhqUdyFOnQK5Z1Er1XbxvDwUFR3fiOSR2ch9FzPajsQVhWxK3L1kdtkInxw6g
         giU11WkvR6a9rdza3GM6EcFOjv9ysDfKnCutSOWzhF+z87WKYyaAPu5ygVBkwt2b193q
         pOjHAkFprHOZapxOfzhXU7ntrLoWAOFMlEw6Dq7mQF2VAdlNeA8AH4sizCWjCdC+otv+
         S6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432951; x=1777037751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXcUGIfcha85KeTtKQKluvJ7CZSCtoU5lC4yHHMNuyE=;
        b=U1anKPwbo50bFPlXiDGRgETF34+dMmd0Qic7Dk60MgQKBFE5MeCAM1OEOlITcdvChy
         0UBQrFDnPVhn0IPh2H8UIIrJt5bfFGbq1+NIwYBFnOF4RLum0fOOLzwd4+ZJVi2sZkmH
         KIEVBvELqWWb7FCURJX0UpCKC6IBrU02PGJB3ACGvcOnqD038mfCkPSEtlMSSaCZl/QR
         Zj/7PWgMf7yJVfZNgs0kO1c8dUMndrpmrul3madsnEdQ3HMU/+btwsBLuzk9dHW7CVJi
         eXq2/XFM2DJrilwczIZnCkGGC4niuQCIb8tPmYftPw1kYR0dy0PTbffNgMOeHMsU5kFx
         c9rw==
X-Forwarded-Encrypted: i=1; AFNElJ+01brSeV+qHQuA/9Wfa0A9DVGZ5FbLok9Kr/O+ZmUz9h+FmtP+2VM0Xe7G0c+ED0RG5+McHRkoKLnVBsqycA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk5YGDjb5KO7hsr8Eslz6AuoFbKf4PpDi54U20DyDpYHEEqStT
	oP5dhAgFXV1yC3EE3Dg1L1q8NfmG1tz28pPCkWgVIthke8EoZqTjRayS
X-Gm-Gg: AeBDievz0Xt5XnSkt/BNrE/glDb2Jei4pygEgzcwPnyXpbLQmkDtjGAyai3s5ls1pmy
	NfM1bVIt32c5VcL7tCtVi8NsIJo5K+I3aEE/iEk4De2t7vEb/QAz0lS+uRuyxL8w9VXTqP5JHq1
	iub0sz1xprc8Rgy+csx52bYZ798SmKHiz4hp1HAvFziHs0RhRvmpeb4szeOL6zH6LS994Tp3hzt
	EVu2uWpqsYjiHKAOpd2E+EaEcvd443uEfZc2HlxcjezfoQ0XrZsFQpfh8Tvh5eckDPB+5KqBw05
	+jZbmD+07qlRmnjREk2JJ7TIbgcQuirBTzngCt6POn5YYcLzi1NS3tY2WVQcgmHP57ZQ3bSvkQt
	hlmCot05ok69PbGusr1iLT53wL1pl62SeaWD2IpIspcf0xf9LD7thSW2LLyv0Uj1+Yj/nr9oq2K
	GK8cySqYlS+f9yGifQJT/5KuK6JOhscFuTCqSqFJijmIw8BgguZlQyvQJbyNA2TTpxVh5LMiDV7
	iaufUtFeJECn2hQPLFpBKtkY6OT5sJ6zYKltw==
X-Received: by 2002:a05:6a20:4306:b0:389:8f3f:50ce with SMTP id adf61e73a8af0-3a08d939437mr3218253637.56.1776432951186;
        Fri, 17 Apr 2026 06:35:51 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm1421272a12.14.2026.04.17.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:35:50 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v2 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Fri, 17 Apr 2026 22:34:30 +0900
Message-Id: <20260417133430.507-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417133430.507-1-baver.bae@gmail.com>
References: <20260417133430.507-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

Implement the transport side of noirq system-sleep PM for virtio-mmio:

 - vm_reset_vqs(): iterate all virtqueues, call virtqueue_reinit_vring()
   to reset the vring state in place, then reprogram the MMIO queue
   registers (QUEUE_SEL, QUEUE_NUM, descriptor/avail/used addresses,
   QUEUE_READY) so the device can use the same rings immediately after
   restore.  No memory is allocated or freed.

 - virtio_mmio_freeze_noirq() / virtio_mmio_restore_noirq(): thin
   wrappers that forward to the virtio core noirq helpers.  The
   restore_noirq path also writes GUEST_PAGE_SIZE for legacy (v1)
   devices, matching the existing restore callback.

 - Wire vm_reset_vqs into virtio_mmio_config_ops and register the
   noirq callbacks via SET_NOIRQ_SYSTEM_SLEEP_PM_OPS().

With this in place, a virtio-mmio driver can implement freeze_noirq /
restore_noirq to participate in the noirq PM phase, enabling use cases
such as virtio-clock or virtio-regulator that must be operational
before other devices are restored.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..7cde042e15ac 100644
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
+		/* Re-init vring */
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
 
@@ -528,6 +561,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.reset		= vm_reset,
 	.find_vqs	= vm_find_vqs,
 	.del_vqs	= vm_del_vqs,
+	.reset_vqs	= vm_reset_vqs,
 	.get_features	= vm_get_features,
 	.finalize_features = vm_finalize_features,
 	.bus_name	= vm_bus_name,
@@ -553,8 +587,27 @@ static int virtio_mmio_restore(struct device *dev)
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

