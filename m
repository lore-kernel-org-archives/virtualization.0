Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E33EC2FF
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274850; cv=none; b=jz/6tHfycTpx4OHgqIitmsQWXxdYa+qOlU0qZEslMM8qW63bJA2sDF7lYFPOdAspmgMy6KKI8B3OK7o3m9pL7fu6V5HqCZJ5L7yDtoAfhnmbWUmu6Kz1VELIUZK/SJeWaR7V6JUNEwM42wJ0opHAVipdlHuKHh4mQ5C8pit+gAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274850; c=relaxed/simple;
	bh=wM41XmBBS8TtNKAIUom+SJe3wlh1BXsYctp8oV5NbHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDuuHVibsms9Bn1U0IEs1cMOS/UXT4gFzD5hHan7a36ZwhmphUw5c95xONiHDziAj7BkucUYsLqkHtQ2voVzrijTJQul2GHLFQLYyk/LdxYtquyAIxslwAbWaTl9pv+J/yOaLKUO+5zlbYRVbstxYZYGwZRu7kpam9Yb2q5U62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlP5FVil; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlP5FVil"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso5243771a91.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274848; x=1776879648; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM7k7U3YOg606LvkeNC0T6FE9JAmhA/+H8CjM9x4H8o=;
        b=TlP5FVilFF7up2cm6tA8GcGdNNHKQ7NMcS/g0OeSN44730VTLyO9XvbFe6fPUNWh1t
         qPcfHsG/xL18OfDBWPSnIgo4MmBmYnmuDNGpCHzMXfThA9cdhXcY7mjFb3qugkiml8Lq
         o+Sw7stYW5fKNtHIjCVRHOkewrL93zy9AMDE4pN8bpx6mXpxf+yFJUnDf5X03WqfqjSS
         6C4K/wSihE4sLTrxl9F7PJ9TRxFvMNk5miaWWQ06UAyDRN4mGJr3yZKr0l6vQnee+X5v
         YmXDM3zdTIvrtsMV5T0ZzpFMyzcXUIN7vMY7HRwojYJ2kBLRMGgDYn4BlYa3mN+FXFri
         JSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274848; x=1776879648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wM7k7U3YOg606LvkeNC0T6FE9JAmhA/+H8CjM9x4H8o=;
        b=IQ4otWT93YpRdOAYwHzZMyckJiYvHZCnbDIHPrl87s4IcbXTlOzlB446hS6HbwzK6Q
         moeOf+BDT3mZ9YL3kglCkKqleg2577U5nP9nD9snEiCySn0K31Hopl3biAORf4YXzLdr
         /RGjnm4LaVLVbnMpilZvWoORDtdDFv33SNaZZuXA3LwG1DRsiWF7xBBGqxjVjBafijEL
         RxRVTkp/UHPuc/ZlzErGeQd/4cZX2HuK05b6/7Jvt5UiuRd4XZ8vVHvX2CgMA1Wef3Hv
         v4c9kCj4gHYzviCTsQkE1lCaHe1aVdrl6e8W1QV/92djuQvNlox5VmzHN0+ttIjnQrEY
         EYgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PSxKTV8dCXHXAXUslet1zfDeRNnt1NXFkivYiieorzyzxCs5MS3HWtJUPrKMn2bbaEYa0nEsTfOrShE2HWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnwLqpe/qEqbAg3+3bqQGOa3ofKkPYMUh8mkF3HlmAcXpCsDCz
	0mQ38seN4TgeF62mdtifSTM05d8eR8hOPcVk2tO6u/mMftGr3Cj7o+iF
X-Gm-Gg: AeBDievq45WY7AybxJryxyTmur/e8fNd3htESAJe1E+oiM6ANdX4Jtm9LiCNq4cHVYi
	A9EMfANucAJrnLlwu8Sr4FpYdq1ZzhwBtpUPDnLZNTE/P187nMitanapp7Axr8tRvxAf4GNqdGz
	Hj3q6rYf5T3w0rT3XEpfuH+HyXbnBgOP5rr2qYdKEuuLiOQu7mbUvY9ik9QVWo7KpZtPYhpD2QT
	MZsxIYW8FedVQxnJmbjqCVCJJMu0KO1LmHPGYkHIQn9WLPA6wHZHxVhbhNi5ajnuitff9uHVu/F
	WcliezxCav3tRRHWfYX3EiBVoZK3BRB1RZZ+kL6ddaZKZYCJ9R2U0GDgQ3w6ff6CQ/4KYdroopN
	Tjr7ubszYppLNpjrME6GosRd4jFov5IrHFjiTun7Fl/rjalsXCm7cGcoroQcZxD6nhPLGsRh597
	CkJ/DyeaTW/Tcoi+WzM25TCDp9T4SJT0C+36IksHmbkVdWJqZBbURVea9ntz6yMm1MftUsR0HGs
	jlW9sCvHcGx43P4+uVLnoiGeknN+1Ua8GtGcw==
X-Received: by 2002:a17:90a:d407:b0:35e:594a:5b75 with SMTP id 98e67ed59e1d1-35e594a62e8mr14176643a91.25.1776274848384;
        Wed, 15 Apr 2026 10:40:48 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd1fe9b50sm2891026a91.3.2026.04.15.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:40:48 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v1 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Thu, 16 Apr 2026 02:38:33 +0900
Message-Id: <20260415173833.6319-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415173833.6319-1-baver.bae@gmail.com>
References: <20260415173833.6319-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio_mmio.c | 79 ++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..7bf193ba4173 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -336,6 +336,65 @@ static void vm_del_vqs(struct virtio_device *vdev)
 	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
 }
 
+static int vm_reset_vqs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	struct virtqueue *vq;
+
+	virtio_device_for_each_vq(vdev, vq) {
+		unsigned int num = virtqueue_get_vring_size(vq);
+
+		virtqueue_reinit_vring(vq);
+
+		writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
+		writel(num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
+
+		if (vm_dev->version == 1) {
+			u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
+
+			/*
+			 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have
+			 * something that doesn't fit in 32bit, fail the setup
+			 * rather than pretending to be successful.
+			 */
+			if (q_pfn >> 32) {
+				dev_err(&vdev->dev,
+					"platform bug: legacy virtio-mmio must not be used with RAM above 0x%llxGB\n",
+					0x1ULL << (32 + PAGE_SHIFT - 30));
+				return -E2BIG;
+			}
+
+			writel(PAGE_SIZE,
+			       vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
+			writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		} else {
+			u64 addr;
+
+			addr = virtqueue_get_desc_addr(vq);
+			writel((u32)addr,
+			       vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
+			writel((u32)(addr >> 32),
+			       vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
+
+			addr = virtqueue_get_avail_addr(vq);
+			writel((u32)addr,
+			       vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
+			writel((u32)(addr >> 32),
+			       vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
+
+			addr = virtqueue_get_used_addr(vq);
+			writel((u32)addr,
+			       vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
+			writel((u32)(addr >> 32),
+			       vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
+
+			writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+		}
+	}
+
+	return 0;
+}
+
 static void vm_synchronize_cbs(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
@@ -528,6 +587,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.reset		= vm_reset,
 	.find_vqs	= vm_find_vqs,
 	.del_vqs	= vm_del_vqs,
+	.reset_vqs	= vm_reset_vqs,
 	.get_features	= vm_get_features,
 	.finalize_features = vm_finalize_features,
 	.bus_name	= vm_bus_name,
@@ -553,8 +613,27 @@ static int virtio_mmio_restore(struct device *dev)
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
2.34.1

