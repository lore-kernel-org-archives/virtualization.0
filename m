Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2BB3CD8A2
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863469; cv=none; b=gJCrldspE61u9tdjWupF3UTFUNvjtrIIX49CTZu/7SKObxNhUXSKcZxBHpO1QZYVCcVC/RijMuFE1B3yFshgOfWskDLv99XARTnZgbJeoM8ymGRnkibZxpohvX4UWRjlnvrn6T+/hsKMT/Np3Eg3rYm4P6bwD6vn8X2ST2kAF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863469; c=relaxed/simple;
	bh=bqyZ3zlNX4wq0F4SlMToUsElYMW/0/3HtJhBt5GqWXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QsnmfbO4ny8LcOEScyOxAEPxPCchlfhm4moZ1HHbzYKmy4a43Sz6gOR89FfNhJCCpiYJx6aqdqbB8tfgvYNJGJ9Vf2yO/NA1kG+YsIvUV7s6uIomYgcQfW699q2IGBYrGlZEelnzmjmJ80DY1BL2RrBVNjLaHzGQDAd379tyjmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qn+XkZR7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qn+XkZR7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so3393403a91.0
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863467; x=1777468267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLZtjOym8UhPjw8gAAa2p99YiXwmHn7dLCASrBy1N7Y=;
        b=qn+XkZR7SGQ3No7KHfUuRquPYMJf0+J3FdebIlTnn5A9RaiLcuZcig+8HrfAXdFn/e
         BuBSKfuDxz3WB4bhBggJNDHmsXPG8AFxKKD1zmUvZLBGlU7OXs3G1dFk3RUXFAgXxhh0
         /qQYEnZRegLPQTlnmIu7UivATIaQi2E3KkTCTLYuwTqQ8FVV15rENHBbh4cARV1KwYqw
         /E8iLcRFkCfEMZfxXIrd0c+6E3IBpLBgaUEzuoRMaVU2LOsfbV2GGdAWCyKhm276FiWu
         6cCicaRog/QmXX5kqM8n/RSBuGd820oXEUsv6piyYH73fwGDprAbbhv53B91ZTK6sGWW
         PdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863467; x=1777468267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLZtjOym8UhPjw8gAAa2p99YiXwmHn7dLCASrBy1N7Y=;
        b=jCkTsy0SbumJcCMirhaUVl3E4RaGTLBcTk91vf2Ngwk+r+Bb4yEBYGvOMrr6b+WWAk
         cLzn0YCjPxV+b+1bjJ2dodQiLiEVduD4jJDuK9fyMGJMQ+Jwg+bakqsLaTnKU5vjpfoe
         QZiTlqHuox3jyhnHmTVp5U3h0fPtUUwX5aZUeeI9WiirqL3/kcWfWDq994Ytw28MHIvp
         4C+LpxGqWF8bZjO/5tKVRzdJz7D11DjNtI8kWwLWfPGEpXipcEKel1682gLWSmxQXnrn
         nvGWoyPF6NLS10ztKSlZftdXlxMAOgetTtQ7eXnkBkwk4Yq1aoE51dlME24thOG07mp3
         bHOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uX5piy7U7i1siKHgMIfBQoaVtqEdgtMSE10qslvv5mOeM5wAo3ifLeHMK8DTUcUFQAWzldDRoV189dh927g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb0hZs885rE3g8szlneqE7siE71Ly6hNOkgxBixI0ViRQJbTIL
	bEbn1U30PTe2JAbYHxEs82s2lVqh54PFm9b+XTsSbBVFALseQhWp17YW
X-Gm-Gg: AeBDies867cCtmQPszXV9VGxClhRcBVccPXCrBRtIcp1e/Lakfv0x9Sb6yIDYe+PQpc
	rFhfPGfzlg22qb2w7OHtZq7nfP9IJf5tQZxvlNQtrFh1/9ZuVQdzRkQi3Im98/l+YzyywIPohpD
	Jm8kyWNENdbfCA2o4XkQXS3a0cDj9g6LLSp6eLo6Ok/K+qaUgj9Z8tYrZEw9BoC1oIu4tCIcrfy
	jvNw87lgX3IaZOxO0K4ocD1uE1JvJNZ7zt5QfRfX6K5KpBsN3Oa5FS8gHGbakHXdXxa+sSjjDxd
	CEJ5pvdjFQxZ//ZIuJ+xkKQjGDCsBKqyOG3Y0a9QkLPNo/kTrFq6/tAd6wHp7ZkLzGxyLV7hART
	dO0WZJ55XYpGhFAV/wTOLugaBXzgf9aknX3RUXMIuIL66c1hd/MIqgUVRcaSFtmIg/gTrmqYOPh
	/pmXlljXTnZEzCd4gFAzu0z5MKQfp7k64N8P46yUSEufQzKp/z/6P20nQlWEA81g3dca8FIsELg
	USUg0RQ9rBx3wgthNB+T8y2t5H5gnWtga0jQw==
X-Received: by 2002:a17:903:3905:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2b5f9ffe73amr214991645ad.41.1776863467453;
        Wed, 22 Apr 2026 06:11:07 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b606ce9891sm127892235ad.83.2026.04.22.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:11:07 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v3 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Wed, 22 Apr 2026 22:10:14 +0900
Message-Id: <20260422131014.956-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422131014.956-1-baver.bae@gmail.com>
References: <20260422131014.956-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio_mmio.c | 133 ++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 40 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..583da43013e7 100644
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
 
@@ -528,6 +561,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.reset		= vm_reset,
 	.find_vqs	= vm_find_vqs,
 	.del_vqs	= vm_del_vqs,
+	.reset_vqs	= vm_reset_vqs,
 	.get_features	= vm_get_features,
 	.finalize_features = vm_finalize_features,
 	.bus_name	= vm_bus_name,
@@ -547,14 +581,33 @@ static int virtio_mmio_restore(struct device *dev)
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

