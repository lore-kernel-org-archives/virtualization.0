Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190830F818
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773457598; cv=none; b=tHVqAnp0jb45O67r8+MYABHC2CGl6ELE5tiY9+HX4fV5wYlWKPfN44zLBDhEqPq54XqPtSzi4On0WNyJONcRpfQdZWdDnD7q93H7d/QrMsHKqHKmz3h2OPs0pNhUwSrojirLad0YPu0h/PJCx7u17joXKqhrmXnvmDFVeFgBFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773457598; c=relaxed/simple;
	bh=ZCWJCyW6WD5vSFHgmTB0ZOIU1gR4DOLFSnoLv4aien0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SscX5QFjq3cC30GEISZOVaQiMlvmFa/UOjkty2+n9sSxBwORgCXbnhzXSu6jFAdyklP5f774fvLtMz3kGykvm88mnhwuJwntq54NgyAugOahJSN0eU0Rpth0A8W+97RxLUEcLxRHAyfP7wwMtOxBIYIx6hGhwR+j5bkVj107298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=bX6F3k8H; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="bX6F3k8H"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82748257f5fso2240201b3a.1
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 20:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1773457596; x=1774062396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUxqj+VyJFyV6/4cZL41qfYeQvqWY65y8qLHAn3DJeo=;
        b=bX6F3k8HRDYQ6kcpHfBgS+Kklk09FP+I2dU9LK0NB+Esn52LfcWrINgBGubzHUt7/C
         Nudtpc7nTOrmvPvAHsB+gFfQy0AWay9rfeRcP9tdFuKM0fAVu4Tp4MA1qOcu6LCfgzkQ
         OReeIjd7xU6afLxC5iwJveNtheoGpurS5ex6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773457596; x=1774062396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUxqj+VyJFyV6/4cZL41qfYeQvqWY65y8qLHAn3DJeo=;
        b=kXwqpPAx0YVEFCxO6AGZVcH136D9RXIaoJlbNs4f3XRYrj3UbRvOwA4vGgRrjoQotj
         ZoGO20shumW2RxplKhBVt/6Olq2sx13IswEnGTXZKHAjEpQULvLGabPjaqRg+Zifvqkw
         QQWk0oKYzl76AUfgp401v2+yDBBzF6UXNWA/LE/uDVjdt3xF/hpMg1JHjfKPEolQbIuB
         oyDBD22ZgCYGHH7TBOlm1KO3J2hyVA2E4NBbUEsHvneZnsaqo5mqxlKPahT/Q9xUainu
         HEBuIV4Z1hnMMO8hg0+8AELfkmwzBDWoBzIhmIKzIZVrNiblTghTW7g7uiqy8nDPvFpj
         dY6Q==
X-Gm-Message-State: AOJu0YxKGEuOdUjYQdaz/nj/8dVcIx8Wckp4LKU18tnEGuGWXHuSH0lj
	R6Rx1lQHX0dIC8eSI5PXFBPoRh62wV1BWUk+PiGEbQleok2gk7A94UAi3QyuGhP5maE=
X-Gm-Gg: ATEYQzwHb9SJkQw0wpBL9Qysr6TqQYk1GOdrmBZ0ISKWcsuMIFNlKDiCl+TwIMSyRes
	p9zLkaFM2nQnJtA7Ey6P0XFUMYneDtGqbqrhKJ/owhY0+XzGpK3QVXB7iDaAt1X34tikMys2cdM
	Omv9OZVGpfYopx+FTl15S1A0gzDDb5T71xaMVAQAD8yJFtr3RqH6HER9dLzHXbrHVd2NLzrUvpb
	QNdvqws3RSJEaBMaZ1UvvHuJo4MCt7LHdOjsRswWX6Hm9uVmZBzuZ/Jfu2+Z2C3Xxkc3VD2/KoT
	0aDSjOcGRZHvhwoFpOHJOz5sR9DqB6s8l64WVh2LBvbiGErLq+SL+0rw3Z9CiHG9yKf4SIIarUs
	9Nck3m5EXgbe09YxkkZUDcut2JChI1IjjuNRsCAGrQArZasOTGf9m9iK/ZMEpq1fVM5UjeMpFe/
	3k3JwAoroMnqpUYj+x/F8m6LBzJLcKoSmbe0f1y65xyqLoSm2M97bxfpQCVOtKZ6IZ8UipmmzxF
	4BDQ0FO8LSX/ERS
X-Received: by 2002:a05:6a00:99b:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-82a07285f11mr7610311b3a.19.1773457596235;
        Fri, 13 Mar 2026 20:06:36 -0700 (PDT)
Received: from kinako.work.home.arpa (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.167.218.150])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a13a2f2d6sm8630734b3a.9.2026.03.13.20.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:06:35 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	arnd@kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH 2/2] virtio-mmio: Use raw io accessors to avoid arch issues
Date: Sat, 14 Mar 2026 12:06:11 +0900
Message-ID: <20260314030612.1949420-3-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260314030612.1949420-1-daniel@thingy.jp>
References: <20260314030612.1949420-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio-mmio registers are always little endian even on machines
where peripheral registers are normally big endian.

At least on nommu, non-coldfire, m68k (see: arch/m68k/include/asm/io_no.h)
readl() and friends are defined to the raw versions. So the value from
the bus is returned as is.

Since virtio-mmio is a bit special and will always be little endian
even if that is different to the machine's convention use the raw
accessors and do the endian swap, where needed, in house.

There are some places in the code where the little endian values are
actually wanted and we currently swap those back again. If we don't
swap them in the first place maybe that saves some unneeded swapping?

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/virtio/virtio_mmio.c | 120 +++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 56 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index dda915b2ac9f..4050533cc976 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -70,7 +70,14 @@
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
 
-
+/*
+ * The virtio registers are always little endian, even on machines
+ * where everything else is big endian. readl()/write() could use the
+ * value from the bus as-is or endian swap it from little endian.
+ * To avoid confusion use the raw accessors and do the swap here.
+ */
+#define virtio_mmio_readl(addr)		le32_to_cpu(__raw_readl(addr))
+#define virtio_mmio_writel(value, addr)	__raw_writel(cpu_to_le32(value), addr)
 
 /* The alignment to use between consumer and producer parts of vring.
  * Currently hardcoded to the page size. */
@@ -96,12 +103,12 @@ static u64 vm_get_features(struct virtio_device *vdev)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	u64 features;
 
-	writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
-	features = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
+	virtio_mmio_writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
+	features = virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
 	features <<= 32;
 
-	writel(0, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
-	features |= readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
+	virtio_mmio_writel(0, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
+	features |= virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
 
 	return features;
 }
@@ -120,12 +127,12 @@ static int vm_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	writel(1, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
-	writel((u32)(vdev->features >> 32),
+	virtio_mmio_writel(1, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
+	virtio_mmio_writel((u32)(vdev->features >> 32),
 			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
 
-	writel(0, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
-	writel((u32)vdev->features,
+	virtio_mmio_writel(0, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
+	virtio_mmio_writel((u32)vdev->features,
 			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
 
 	return 0;
@@ -155,17 +162,17 @@ static void vm_get(struct virtio_device *vdev, unsigned int offset,
 		memcpy(buf, &b, sizeof(b));
 		break;
 	case 2:
-		w = cpu_to_le16(readw(base + offset));
+		w = __raw_readw(base + offset);
 		memcpy(buf, &w, sizeof(w));
 		break;
 	case 4:
-		l = cpu_to_le32(readl(base + offset));
+		l = __raw_readl(base + offset);
 		memcpy(buf, &l, sizeof(l));
 		break;
 	case 8:
-		l = cpu_to_le32(readl(base + offset));
+		l = __raw_readl(base + offset);
 		memcpy(buf, &l, sizeof(l));
-		l = cpu_to_le32(ioread32(base + offset + sizeof(l)));
+		l = __raw_readl(base + offset + sizeof(l));
 		memcpy(buf + sizeof(l), &l, sizeof(l));
 		break;
 	default:
@@ -199,17 +206,17 @@ static void vm_set(struct virtio_device *vdev, unsigned int offset,
 		break;
 	case 2:
 		memcpy(&w, buf, sizeof(w));
-		writew(le16_to_cpu(w), base + offset);
+		__raw_writew(w, base + offset);
 		break;
 	case 4:
 		memcpy(&l, buf, sizeof(l));
-		writel(le32_to_cpu(l), base + offset);
+		__raw_writel(l, base + offset);
 		break;
 	case 8:
 		memcpy(&l, buf, sizeof(l));
-		writel(le32_to_cpu(l), base + offset);
+		__raw_writel(l, base + offset);
 		memcpy(&l, buf + sizeof(l), sizeof(l));
-		writel(le32_to_cpu(l), base + offset + sizeof(l));
+		__raw_writel(l, base + offset + sizeof(l));
 		break;
 	default:
 		BUG();
@@ -223,14 +230,14 @@ static u32 vm_generation(struct virtio_device *vdev)
 	if (vm_dev->version == 1)
 		return 0;
 	else
-		return readl(vm_dev->base + VIRTIO_MMIO_CONFIG_GENERATION);
+		return virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_CONFIG_GENERATION);
 }
 
 static u8 vm_get_status(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 
-	return readl(vm_dev->base + VIRTIO_MMIO_STATUS) & 0xff;
+	return virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_STATUS) & 0xff;
 }
 
 static void vm_set_status(struct virtio_device *vdev, u8 status)
@@ -245,7 +252,7 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
 	 * that the cache coherent memory writes have completed
 	 * before writing to the MMIO region.
 	 */
-	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
+	virtio_mmio_writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
 }
 
 static void vm_reset(struct virtio_device *vdev)
@@ -253,7 +260,7 @@ static void vm_reset(struct virtio_device *vdev)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 
 	/* 0 status means a reset. */
-	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+	virtio_mmio_writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
 }
 
 
@@ -267,7 +274,7 @@ static bool vm_notify(struct virtqueue *vq)
 
 	/* We write the queue's selector into the notification register to
 	 * signal the other end */
-	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	virtio_mmio_writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
 	return true;
 }
 
@@ -276,7 +283,7 @@ static bool vm_notify_with_data(struct virtqueue *vq)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
 	u32 data = vring_notification_data(vq);
 
-	writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	virtio_mmio_writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
 
 	return true;
 }
@@ -290,8 +297,8 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	irqreturn_t ret = IRQ_NONE;
 
 	/* Read and acknowledge interrupts */
-	status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
-	writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
+	status = virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
+	virtio_mmio_writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
 
 	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
 		virtio_config_changed(&vm_dev->vdev);
@@ -314,12 +321,12 @@ static void vm_del_vq(struct virtqueue *vq)
 	unsigned int index = vq->index;
 
 	/* Select and deactivate the queue */
-	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
+	virtio_mmio_writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 	if (vm_dev->version == 1) {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_mmio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
-		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
+		virtio_mmio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+		WARN_ON(virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
 
 	vring_del_virtqueue(vq);
@@ -362,16 +369,17 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		return NULL;
 
 	/* Select the queue we're interested in */
-	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
+	virtio_mmio_writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 
 	/* Queue shouldn't already be set up. */
-	if (readl(vm_dev->base + (vm_dev->version == 1 ?
+	if (virtio_mmio_readl(vm_dev->base + (vm_dev->version == 1 ?
 			VIRTIO_MMIO_QUEUE_PFN : VIRTIO_MMIO_QUEUE_READY))) {
 		err = -ENOENT;
 		goto error_available;
 	}
 
-	num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
+	num = virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
+
 	if (num == 0) {
 		err = -ENOENT;
 		goto error_new_virtqueue;
@@ -388,7 +396,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	vq->num_max = num;
 
 	/* Activate the queue */
-	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
+	virtio_mmio_writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (vm_dev->version == 1) {
 		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
 
@@ -405,27 +413,27 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 			goto error_bad_pfn;
 		}
 
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
-		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_mmio_writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
+		virtio_mmio_writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
 		u64 addr;
 
 		addr = virtqueue_get_desc_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
-		writel((u32)(addr >> 32),
+		virtio_mmio_writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
+		virtio_mmio_writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
 
 		addr = virtqueue_get_avail_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
-		writel((u32)(addr >> 32),
+		virtio_mmio_writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
+		virtio_mmio_writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
 
 		addr = virtqueue_get_used_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
-		writel((u32)(addr >> 32),
+		virtio_mmio_writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
+		virtio_mmio_writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
 
-		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+		virtio_mmio_writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
 	}
 
 	return vq;
@@ -434,10 +442,10 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	vring_del_virtqueue(vq);
 error_new_virtqueue:
 	if (vm_dev->version == 1) {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_mmio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
-		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
+		virtio_mmio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+		WARN_ON(virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
 error_available:
 	return ERR_PTR(err);
@@ -496,11 +504,11 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 	u64 len, addr;
 
 	/* Select the region we're interested in */
-	writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
+	virtio_mmio_writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
 
 	/* Read the region size */
-	len = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
-	len |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
+	len = (u64) virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
+	len |= (u64) virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
 
 	region->len = len;
 
@@ -511,8 +519,8 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 		return false;
 
 	/* Read the region base address */
-	addr = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
-	addr |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
+	addr = (u64) virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
+	addr |= (u64) virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
 
 	region->addr = addr;
 
@@ -548,7 +556,7 @@ static int virtio_mmio_restore(struct device *dev)
 	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
 
 	if (vm_dev->version == 1)
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+		virtio_mmio_writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 
 	return virtio_device_restore(&vm_dev->vdev);
 }
@@ -591,7 +599,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	}
 
 	/* Check magic value */
-	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
+	magic = virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
 		rc = -ENODEV;
@@ -599,7 +607,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	}
 
 	/* Check device version */
-	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
+	vm_dev->version = virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_VERSION);
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
@@ -607,7 +615,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		goto free_vm_dev;
 	}
 
-	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
+	vm_dev->vdev.id.device = virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
 	if (vm_dev->vdev.id.device == 0) {
 		/*
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
@@ -616,10 +624,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		rc = -ENODEV;
 		goto free_vm_dev;
 	}
-	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
+	vm_dev->vdev.id.vendor = virtio_mmio_readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
 	if (vm_dev->version == 1) {
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+		virtio_mmio_writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 
 		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 		/*
-- 
2.51.0

