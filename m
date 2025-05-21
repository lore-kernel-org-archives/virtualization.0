Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EE2627EC
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827252; cv=none; b=d9tl35aPCqPKpKjz3hA5tKk9nudCZ6HHtWEP4JZ/0RP/3/XtINA8NQzJcTTK7e8Gj+nF5zSgT6vBNg/Unut1t3Fgfzlhv0RsyfsPZsH2L/478sZqyKT7xYJVtYxxfxhCBEYwKOG8EYommZ98CevF6gom4smscgt2gFf8JWC9ouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827252; c=relaxed/simple;
	bh=YmK9jUVMjyM4XGpiOToRK6zoyZKLYlRbYzUIMY0DNzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nahzfekbNIC8710cbP9cA+gLg2tsxz+sw03US7faqsdavr/8rtZDvXWh6bsHyVfN5bjK0hWfhvbuUU9efEzTuSMZvw2SSDEZ7Iw1o+tT1ButjelG4s9/DXEPOBnUCw1EmYTyCkDMAc12vflrb39pRV3B6CdwNZe3zLHnMuULinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SYHColW6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYHColW6"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30e93626065so4399982a91.1
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747827249; x=1748432049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+4xzIECcnulitki27nkBn5Q23UYHsSRhtXD1c9rOoA=;
        b=SYHColW6FK4o84IStHH0egmFuKcI7IWcs1bbuFltMeZsfpGpAwbXFuV0+bH/jZcqD1
         oP8BfyMhZ2buT6yHHY0Ltm+5gMvzh2Iadd0FixtPwlwlOrRxr3auiknG71rm6r3JNVB8
         1w3kAE/kE6FihUgRblpBVIEnOEFrxmhSSRLu4cEKLWDLCi6mtqkeDywVtI+PST3xwQ2y
         0JjJkfcxdsz4fMuniD/oopdMCnBK5XzhVVSsKoxdw3AswAP0NLdx2V/Kblz2WHyOOr7e
         d4l4akLsozQ/x1xidYQe+gEr0PhJybOAISjsSuz8sQ/rJX6fzzcB5J2TN4nYaGQZG4pT
         RC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747827249; x=1748432049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+4xzIECcnulitki27nkBn5Q23UYHsSRhtXD1c9rOoA=;
        b=sX1+ZtyBpXt/O0zs4p7Q9AlKmHiiamM9MnfFZXvA9UAyJJPS7EgNiTHodBe1/4PDCc
         4quQ7DWEKXCMtN1qeZHzH0JLleTa/soVRqhnLwRsQxK7cKQt55R8BG0u82cpngQJoLcs
         G+JI+6YoeJ03VGZoxZj+/Ztoukxdv3NAcYb3llAMSwHGh9LRFNLmMkQAtnGWEfBGpqWa
         vWoFmlYlFZqy+SNBiASGuj8CieV+UCfHh/Pmy0GivF3D9l+0Y56dZW0AGXLjZa/mNwFU
         f71376ACMkyEeNG2JYkG5KxFXKEYTft34HO1znDMGV5COniLQb54bpvXupZCSVNwxepb
         VheA==
X-Forwarded-Encrypted: i=1; AJvYcCU+xP5fWHvmzTxuj3aYapGkookoG0+V9XmJJ6aBI3CfGIerkLns9+6I8U6MywabWc8YYyMlcQlekmxxrmPT6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdBC4/6uTYGaBno61kT5FYJFmii7Q9hO92ASeE4jpZoqYo5PgJ
	Mh13PYxE+3LQt+vXyX2qh3YUC8IuatRorOsa1FjqFR193eDObDpbwSZfoTl6XhvCMJ8=
X-Gm-Gg: ASbGncsIICuJLj5vgXUSklZuJK8wt5hZCDR/d/suGM63cLFDl7LGzq2CDzlhHXomgR+
	WF+VEo/3LWyGCTFdfKw8Tx8U7CkWJ7KL1lqg+Bwfnw1nl1JRyzXgknX02I4p8gTTkHP3m8e3cY3
	8L2d7DfuKtj5VHYlT8XlewG4KE8FxyL7AcKJ0SPN+qH7LynTWeI6sS6c4Op69mFZbPMingE+WH1
	Zs+JPn8zJZwrIhFaLyJKL70Dbtj0vI3B+siLubPqEeOWt/yJhWuAB59tiwiXdqFxFUKbBLwcNnJ
	mAWJ6E5PHEup9mpFoC5z/JkWrCGcQqr4M+06VVz0M7bKNTQFkNNt
X-Google-Smtp-Source: AGHT+IHEP4cY4L10ow0JzAIxRCHqZRLKI4tTfPyWgXFzxw0d78MaqKPCU0DzphedaKmdHEozMC86Eg==
X-Received: by 2002:a17:90b:55cc:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-30e830ebe05mr35629396a91.11.1747827249017;
        Wed, 21 May 2025 04:34:09 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385b68sm3437381a91.11.2025.05.21.04.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 04:34:08 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-mmio: Remove virtqueue list from mmio device
Date: Wed, 21 May 2025 17:03:46 +0530
Message-Id: <3e56c6f74002987e22f364d883cbad177cd9ad9c.1747827066.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMIO transport implementation creates a list of virtqueues for a
virtio device, while the same is already available in the struct
virtio_device.

Don't create a duplicate list, and use the other one instead.

While at it, fix the virtio_device_for_each_vq() macro to accept an
argument like "&vm_dev->vdev" (which currently fails to build).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I have tested this with a Xen/Qemu based setup to test guest to host virtio-i2c
communication. Works fine, not sure why this code was added in the first place.

 drivers/virtio/virtio_mmio.c | 52 +++---------------------------------
 include/linux/virtio.h       |  2 +-
 2 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 5d78c2d572ab..b152a1eca05a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -65,7 +65,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <uapi/linux/virtio_mmio.h>
@@ -88,22 +87,8 @@ struct virtio_mmio_device {
 
 	void __iomem *base;
 	unsigned long version;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-};
-
-struct virtio_mmio_vq_info {
-	/* the actual virtqueue */
-	struct virtqueue *vq;
-
-	/* the list node for the virtqueues list */
-	struct list_head node;
 };
 
-
-
 /* Configuration interface */
 
 static u64 vm_get_features(struct virtio_device *vdev)
@@ -300,9 +285,8 @@ static bool vm_notify_with_data(struct virtqueue *vq)
 static irqreturn_t vm_interrupt(int irq, void *opaque)
 {
 	struct virtio_mmio_device *vm_dev = opaque;
-	struct virtio_mmio_vq_info *info;
+	struct virtqueue *vq;
 	unsigned long status;
-	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
 	/* Read and acknowledge interrupts */
@@ -315,10 +299,8 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	}
 
 	if (likely(status & VIRTIO_MMIO_INT_VRING)) {
-		spin_lock_irqsave(&vm_dev->lock, flags);
-		list_for_each_entry(info, &vm_dev->virtqueues, node)
-			ret |= vring_interrupt(irq, info->vq);
-		spin_unlock_irqrestore(&vm_dev->lock, flags);
+		virtio_device_for_each_vq(&vm_dev->vdev, vq)
+			ret |= vring_interrupt(irq, vq);
 	}
 
 	return ret;
@@ -329,14 +311,8 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 static void vm_del_vq(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
-	struct virtio_mmio_vq_info *info = vq->priv;
-	unsigned long flags;
 	unsigned int index = vq->index;
 
-	spin_lock_irqsave(&vm_dev->lock, flags);
-	list_del(&info->node);
-	spin_unlock_irqrestore(&vm_dev->lock, flags);
-
 	/* Select and deactivate the queue */
 	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 	if (vm_dev->version == 1) {
@@ -347,8 +323,6 @@ static void vm_del_vq(struct virtqueue *vq)
 	}
 
 	vring_del_virtqueue(vq);
-
-	kfree(info);
 }
 
 static void vm_del_vqs(struct virtio_device *vdev)
@@ -375,9 +349,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	bool (*notify)(struct virtqueue *vq);
-	struct virtio_mmio_vq_info *info;
 	struct virtqueue *vq;
-	unsigned long flags;
 	unsigned int num;
 	int err;
 
@@ -399,13 +371,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto error_available;
 	}
 
-	/* Allocate and fill out our active queue description */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		err = -ENOMEM;
-		goto error_kmalloc;
-	}
-
 	num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
 	if (num == 0) {
 		err = -ENOENT;
@@ -463,13 +428,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
 	}
 
-	vq->priv = info;
-	info->vq = vq;
-
-	spin_lock_irqsave(&vm_dev->lock, flags);
-	list_add(&info->node, &vm_dev->virtqueues);
-	spin_unlock_irqrestore(&vm_dev->lock, flags);
-
 	return vq;
 
 error_bad_pfn:
@@ -481,8 +439,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
 		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
-	kfree(info);
-error_kmalloc:
 error_available:
 	return ERR_PTR(err);
 }
@@ -627,8 +583,6 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	vm_dev->vdev.dev.release = virtio_mmio_release_dev;
 	vm_dev->vdev.config = &virtio_mmio_config_ops;
 	vm_dev->pdev = pdev;
-	INIT_LIST_HEAD(&vm_dev->virtqueues);
-	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vm_dev->base)) {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 64cb4b04be7a..8b745ce0cf5f 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -196,7 +196,7 @@ int virtio_device_reset_done(struct virtio_device *dev);
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
 #define virtio_device_for_each_vq(vdev, vq) \
-	list_for_each_entry(vq, &vdev->vqs, list)
+	list_for_each_entry(vq, &(vdev)->vqs, list)
 
 /**
  * struct virtio_driver - operations for a virtio I/O driver
-- 
2.31.1.272.g89b43f80a514

