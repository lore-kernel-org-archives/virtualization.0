Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881993ACA4B
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966065; cv=none; b=nz8JaKHZw84S09GhBHK5oFF0DjI3vZt/RIiuhAGu76gKNqmjJPIhT2bHelo9XG5ZGprvPGdf9po2lrq/i7bDPr8DvmygC9WOlE9G9LLbpEFM6VH4p4YX6jLOkNj5UmU8qjCJuf1tR4j0QinhWz8f7qTxZd31jFfzUSumy9/bxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966065; c=relaxed/simple;
	bh=wLKpK3tMbIqIN8Ol6qX8hkN7d3LwE17kRaqy9JLPUw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPq1BnDOCs0ERDE8DBKn5nd0EVLdYDHwqtVUUOBxJhIyGm/W2GnZYMgTIUDcFj7wzrdhmOXXgfGisiWPVijz6DI29FCdqJltowPMqsN2jWjZpequ5IgkAZwTajEoMIsgf7cEkiHR/Wz3up6da9rmtuICfO9rlhMkd2tdFPVivUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwOExEZb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwOExEZb"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso4328770b3a.1
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776966062; x=1777570862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhejpkHi44NTY/EhjfX/VPO4q3I84QLwQ+oZB4nOOiw=;
        b=FwOExEZbkBlBILTKVaUvrtugkUf1/5jHCR0HBXDi1b6zRZ+JB/Xn2qrAonWTXOt3Oe
         k2/JaImshDltf+74g+so03lmqAlm8jfF3smN9II0hBfnxf5LzvcXpw/0H9SRTAVQqGHF
         L/sawfl0GfBCanwaxrcb0ie9DJkMaN55sI5VntNll8atqXqFpdAAcDg6Mk3mNS/9aW/5
         XJB/8e6ToryEUijf5+o3ifv7FvI2WrCEbvi8wL5AWaFMcScWbcqFNZWoheOwugf/nf6D
         3ZD87VIPrqnM/kMs779gTnykkO9JKFQozVqbIFpQNIXO5mT/jmY+cfiBo3NK/9urqhRd
         GbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966062; x=1777570862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jhejpkHi44NTY/EhjfX/VPO4q3I84QLwQ+oZB4nOOiw=;
        b=G0Zk03goSqeZKY5MYqkbnuIyLVcdRzGuit0B7ZBkLGBbqUY6DBzfRr2D/CO21cDRej
         b9OXhWqeNrQDM5tYzfemTZu+aF9QDxJJud64xBkHcZRQ1tlPoycn2cKNIftqB4QwSquL
         uwDld8kCydbsdLcXy8HXsXj/Crab+BoOMFbmofaFwQMk52FvHg3Xu3zSgIc8TatY5rzz
         4DLqxkvTEXE9MRlWHyCWFerRs/eRmqVEXy+aK9wLk8Y5r4JixKGgp9VC7BWAZdZ0bvhD
         Mws+9JPmc4M9Y03uGq6/6/n1vx0ofdYTli6gQGMycW48hZAYlfsezlQGt3tdjuBDVaEO
         lxbA==
X-Forwarded-Encrypted: i=1; AFNElJ+uSzLrDQ5fmyzac7jiBmbzlqkm2el9I4KPgZmr2IWhr53+9ZiXUdBs+dIh+CUzsC7mN4pJDRx+wnbrhcbXfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGSUkZzQ/zhacOgg33lZPK9G+DUQY/dxk9Hi+X+7iBnllGRyAm
	Bs1aHn1cq1tNHV/VQCMRpmcNebfAhhEAYHIq7Db7aiOZ8XI/fEX5x1PFhB63+bMw
X-Gm-Gg: AeBDietsICEz7G+mmkA12XHBZvMsa5Ngg7oP3eqw61WMsie6n5HuwWeqps+GR+ZmCaY
	RDbE2RGgLanIeoTiMzhzMof2o30nIPMn7VoeNKoEErxpXEDxtUd3vI7ijPqAVH9t89Y55w+/nPd
	I5bKtbA2VUD/W0iyjwWMC8BcR42x+dDaaByZ24VPWqliY8Lpt8di2bRsTEytkGmtFJ9WLPrlB+c
	dJL15nKoZpFQxUs17zFxaKvSB9hVAmc6uJ+45LIq+I1El8WNMRkYef0FxALT/FQ+zjiQ8po8lYk
	lk2fTiH2ajusWWONKyPEyk5+QotB4QgsSAlP6RYUdMSuG1M3Nf3fmEM50NR+uxjeUdpRCeLTU8v
	vPlRo8v4kSiQPsAqe1L8fzMYfLhMGph6DsCuF4U/tdhqteyRhBoF7sdKVlUvYPbV1gHhuFWKjTj
	7PwQqNlbO3CmHdOLzJm7lXhiBGsrJTJFPa2Vjj/R50Ur6LpHGUlV/V2eDkhixrosXtwtNkfQn8w
	yI73WKWIVxD6TiZUIfRBIADCo/IRcnFNDDywg==
X-Received: by 2002:a05:6a00:2988:b0:82f:66e8:4257 with SMTP id d2e1a72fcca58-82f8b565509mr24255180b3a.32.1776966061864;
        Thu, 23 Apr 2026 10:41:01 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebcc9easm27014498b3a.39.2026.04.23.10.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:41:01 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v4 4/4] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Fri, 24 Apr 2026 02:40:39 +0900
Message-Id: <20260423174039.276-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423174039.276-1-baver.bae@gmail.com>
References: <20260423174039.276-1-baver.bae@gmail.com>
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

