Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97B274B23
	for <virtualization@lists.linux.dev>; Sat, 16 May 2026 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896759; cv=none; b=FtEAgsneGHg1wgMhLgQQDsWcNMuwzS91XozW/DSDBe9MkrdPxxSirWjwAZRJJ9XTFGWzr51wAC43g/w6KY2+sNF4fGZijzWX4hXYCV2k5LJEbWctW4Ai81y9dmwNORzC5l8UIyXT9kfkHUaMSkwRumzeQ4wt3yf+84oedU2IFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896759; c=relaxed/simple;
	bh=10Pv4wCRLRsYVFcl2tTr/I+ll5JXYgM6y1NwK70LFG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiIibLCxUINSw5SzmuLTMU2oPaQEupoN/ECia4WPDfXK+bKd8CeCdQysXW03q5K04N5IFy2lcWiZMsm0/yKlFMKZNGshoHkQuC5f19nXB07BgWaqGL2Nn6UHc01XLyeHufku3t204TEpJ846oP/mXeJ/2pirjM339bqh7wJ3tbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwe4AVNo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwe4AVNo"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c80170db7d6so148986a12.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778896757; x=1779501557; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrmjFxK/MuxHR0Xepi3mNFkJ9BfGyVR/W7w3N4yVTKs=;
        b=Vwe4AVNomBxZwdxd1wNsH9aN1WzvsGf2ErSd5imgfZ2kqSQnAnoAd7G1atGA+XnyUY
         Aipn7XluJNsbGVWrGBEbpEfF2RATnRiCiwP93ZeyeqYlkzSWRUL3rAsYGIYGHymH+QIC
         jCG5HdH/LHqHY62PK+1QPgftlp5cTOEKQ8NbvJ0UIvQQxI9V4YmqyDYyarkkumLz0rfe
         DUT5NBNxINxMmPw3zFJg1MaMxdfY7qJiZyfdfTOWwxwFtenTOJ3VoG4AucrZ/k/21zjg
         itL4p1zt+5zKnBwZcWXSuQGvldL6fWDvR1OOAP78kkU2yWWQKKp9G4v/LnSjs7+DhsJX
         iT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778896757; x=1779501557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hrmjFxK/MuxHR0Xepi3mNFkJ9BfGyVR/W7w3N4yVTKs=;
        b=QPFXrOuo0wD9DVeduspXkvDdjl3yBgiO4t9+hr+EMnohnk8j/ZXJZEtPcll+m+YMAk
         uoefue4+1phDAQiz0ir8WlMpk047FduVDBNIYE05CfApH+mm8HGXhNawvaTEd6gqgo+r
         dolXHgjSS5jl/+Pw5fb1hPNJvQmnL+7brf3QQBiiYWHFwZ2Z1AxEtvjXnpcInu3YfYHm
         2dRRvKWSr53oghQlzWOkovl8xTx7OJMxYpgct+p2AslBNbBz5t3vVpiR9seeaZhAfGPt
         SJODTA76aq1eU3WY3E5c+Ja4H9Thvlk+rrLXBvJHVRMAHx3TgEiQlPhPbgkbQ+BH2eL8
         Ax9A==
X-Forwarded-Encrypted: i=1; AFNElJ/BA3GJp7AfAdCAX6WSuuYyc1L61hU1WOsbIZAdsNKjrjfJ3JGmUrhK9HUS4Jc+2SBxt1Nq3ZZsVptneZWUtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzSan4ff4WzyVaHDJGl1oGkf5z9v25NtwTbHF9EaAjv7OItAfo
	UiuGd7W6cou3qrGL+nDi/71u0wB6OMEy1EfM4aJvsr8zAhO846lreoKe
X-Gm-Gg: Acq92OFxx3xdcFp3ePzE7PM9NBfbaBDtiWfoTq3UhjBZb9Cx7aCTFDeSbaZuhPpXagp
	+23yfIqhPJbiY09pY9qRJxBCeTZVf1UkoVsUZLch2s0h6JV6V4d0IVfxP8sUCkupvdyi3s2xYv2
	ZV4RMT73rs8DkGrVKY09SDRaeWMcF6bgd8VnWdqnkMBsXaDIcO+/Zg0mMfNzrQwVSbs3cBfhp42
	vEY6yC0EW5EmLuZ/Z+tlNM+vZzQdBhOPadUHbp9D2lUxM/85pOAK6oVjiWv3V7KC/94iLrh/qMg
	S7j6d3zgBu7aSc3dgVChfvp+ILd3GeUSa1WhaZbGfNXwWqMZih5kgJaZT0ECCXSGej24bm0HjRF
	qAvxeHfzH2yo7qxeS+ie+qb7doLZQbwEBlaSkue6x/vqRRfAQyKmBpH9bGfr4xleAIwUrMSQBPG
	QJPegZ1MOCxdhCcFUvwT+FlJpF8oSd66W7mxxCKkuUyGJrGhQST8YwcRIqlp3BYAfOQoKZSKtmY
	q4B9ELod5OJ8vJZv30ZavGERuwlfYKBoLNXCA==
X-Received: by 2002:a05:6a20:e212:b0:3a3:a5cd:5621 with SMTP id adf61e73a8af0-3b22ecf84f9mr7273028637.51.1778896756599;
        Fri, 15 May 2026 18:59:16 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm6605080a12.11.2026.05.15.18.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 18:59:16 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stephan.gerhold@kernkonzept.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v9 5/5] virtio-mmio: wire up noirq system sleep PM callbacks
Date: Sat, 16 May 2026 10:57:56 +0900
Message-Id: <20260516015756.20948-6-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516015756.20948-1-baver.bae@gmail.com>
References: <20260516015756.20948-1-baver.bae@gmail.com>
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

This enables virtio-mmio based devices to participate safely in the noirq
PM phase, which is required for early-restore users.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index daa65b269a36..fbad0ee8312f 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -346,6 +346,77 @@ static void vm_del_vqs(struct virtio_device *vdev)
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
@@ -398,45 +469,9 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
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
 
@@ -538,11 +573,13 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
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
@@ -560,8 +597,24 @@ static int virtio_mmio_restore(struct device *dev)
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

