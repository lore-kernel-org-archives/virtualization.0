Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6516451069
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179122; cv=none; b=IuWvph+z0tmBv4PPdY0Iy7zZqe7oMJVPq1KjWpVxRR/sXtejgFa4Ug6+Ae0owKQtQcIVCvk8QI+MHfV2XrdUVAd4+0JpnrRp2tO56o3nkArSlaWkKdAubtSgvf8et1vDb4oF9XoG3e0BLaCu58LvYqhBugLydKaAuDFfQ/67/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179122; c=relaxed/simple;
	bh=4GrsCCPahhxyGz9IfFdXG4lPM39+qQCAQa6kwwfmcoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XR4ioZ152QvpjOlUAQaMRwXjNipJ9FINJH+1hKdoThlVuJEdeea1b5SzheavwObe4ndWQV16rlt/6//QOdcYKuE/8k50eNc26CCM6o4jsjxijgduexnpXrcmtcNqI4+Jo9jf1EYTdnOOLrHdFL6ds1yeZVqOkuw9DHrvFmIcWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luOQYtze; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luOQYtze"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-837cd669be0so866545b3a.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179120; x=1778783920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csDUDl+objecmrzJgOYyRiiDYmfFHBJwcWFBOaJXMVM=;
        b=luOQYtzebP/D6RzO+6X4RWVdGXjUGm2g7nbRlnj3FOT0PhsMTgy9j+Q0NqRkVcf64U
         tx6D12dYOdzEEm1U/u9Mc0LckW5qYI+0A3L6uuoexjgBLBEJzJZEWbs8in1lLiuuymkB
         dVr0hfE83ifTJPz8SIk9wIkiqJ4HvhR1UJfTXUPoV73HfGF4JNKqzXwjwg2U+aOk5nlg
         J4zDg8Md1ezcZ/6oJs/Z5yRItSSARmtyzqwuhKAyUtehBPvs7Qread8tuTIC/eryti+5
         v9P7fgL1wm6v7pak1SooslwyHaD0PKGt5OTFvyNf/w1x/i+8hW1ALW/pA/6d4U4ol9d6
         Y3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179120; x=1778783920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csDUDl+objecmrzJgOYyRiiDYmfFHBJwcWFBOaJXMVM=;
        b=pa3RL7SqSgyEjyLvV90Mld9LgMoYWPuX4TT5p7YgL3M21WRgbIJFEa1QYxz52QwlAm
         uRG++JVBrQFWGOd6B9jKxN18/MasjEOPfT55MDpC4AUkz+Fbaz9Ak/Dre9uMJSKWfHTc
         1St8O64r5RRUvRx1pahcsN9n9T2CB4LW8CGPagY7Qhr5dJudWtdZq80mUytPnBD2ubzj
         PeXRqugoDwOUbWRzo2RvBGASRM8Dqx5gTujl0cry6i5Tf+aH+7pmYrosQ+PgFqUK/aC2
         obfGDNfNRRdH5I7VI4wPdhDLk8/Jh1u3W7rTAvLnqXOFJGBjJODfLFSqDTaLIrbGe2jS
         6x/g==
X-Forwarded-Encrypted: i=1; AFNElJ+URvxJQX8E1Uvji64D23ILMSoWf9Rk9ITJeOBzjep5WHeqmMnRjIAlGE/o9mhun5dZ7LhFPsjRLGtQofKggA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZn1xQBDc8QyDtfVs3Jk9vvvS6gNb5iE+25Of4SODZHJM4HmTo
	VkXv20MupZXkGXu1mcKN43R4UEuQ4BU+VnEPwLOl5Vg/k8pBS/+77Nr9
X-Gm-Gg: AeBDiev0A94wyOqyg+mtBUzwHAdi2if1qK/aSmpD74XY5BxmnT6KlPKhsLPVUx9HEQV
	1fo7BEPsLl7qI00Vodz+1tD9Z4P+vjiRISMTsBfYY/Nlx9nobm+Z8RPfvib8VZx9z8hZAM+DRPm
	OLYIKfj0eG5QZ1lYXEHxdCwhedOnhOL4A92UUsnCaYgQle8jtTE3JtqDSZnS2OJ2yKLQd2Ln1om
	3HcEcwyZNU/IiCC424uyGo1Bo0gmeeZoswtCyBtvptP0YrlQ74rbFGlUK3xQJ2x30wBZWxDo2iQ
	7uUXxv9NLYHg5CxbWXOa6pWoAZYF63VlsxCYcJmTlnhNqxRx4VuJN19UOBZ0JBVpI7GKOuKnvvs
	0+/lu5QYzh+y+yvhn/LlDk+f4WvUm1D5OVm2uB51JQJzNkR5XvlI+RVvipgYkR1Wnz7rZsOEGkJ
	t5BvF08LtrchN0J5Rgln1zLlPtKKFL74tjwvyCgDitAWEpIkXUnHJJEbPxqhEh8SJbsnqDU2DPo
	SVCQtRp8I6qssyZV8hQNL+YvYg=
X-Received: by 2002:a05:6a00:2e87:b0:82f:5034:77a4 with SMTP id d2e1a72fcca58-83a5c4be2eemr9265031b3a.21.1778179119797;
        Thu, 07 May 2026 11:38:39 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm11272744b3a.40.2026.05.07.11.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:38:39 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stephan.gerhold@kernkonzept.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [PATCH] virtio-mmio: move guest page size setting into vm_reset()
Date: Fri,  8 May 2026 03:38:07 +0900
Message-Id: <20260507183807.22007-1-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

The virtio-mmio legacy spec (Section 4.2.4) requires the driver to
write the guest page size "during initialization, before any queues
are used". Reset is step 1 of the initialization sequence
(Section 3.1), so setting GuestPageSize immediately after the status
register reset in vm_reset() is more proper.

Currently the GuestPageSize write lives in two separate call sites:

 - virtio_mmio_probe(), before register_virtio_device()
 - virtio_mmio_restore(), before virtio_device_restore()

Both of these write the value *before* the reset that happens inside
register_virtio_device()/virtio_device_restore(), so a device
implementation that clears GuestPageSize on reset would lose the
value. QEMU's virtio_mmio_reset() for example zeroes guest_page_shift
on a full device reset.

The current code happens to work because the Linux driver triggers
only a "soft reset" (STATUS register write of 0), and QEMU's
soft-reset path does not clear guest_page_shift. But relying on
this is fragile and not guaranteed by the spec.

Move the GuestPageSize write into vm_reset(), right after the status
reset. This ensures the value is set:

 - at the correct point in the initialization sequence per spec,
 - after every reset (probe, restore, or any future path), and
 - exactly once, removing the duplication.

Fixes: e0c2ce821795 ("virtio_mmio: Restore guest page size on resume")
Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio_mmio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..daa65b269a36 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -254,6 +254,16 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+
+	/*
+	 * The virtio-mmio legacy spec requires the driver to write the
+	 * guest page size during initialization, before any queues are
+	 * used.  Since reset is step 1 of initialization (Section 3.1),
+	 * set it here so it is always in place for subsequent queue setup
+	 * in every code path (probe, restore, etc.).
+	 */
+	if (vm_dev->version == 1)
+		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 }
 
 
@@ -547,9 +557,6 @@ static int virtio_mmio_restore(struct device *dev)
 {
 	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
 
-	if (vm_dev->version == 1)
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
-
 	return virtio_device_restore(&vm_dev->vdev);
 }
 
@@ -619,8 +626,6 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
 	if (vm_dev->version == 1) {
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
-
 		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 		/*
 		 * In the legacy case, ensure our coherently-allocated virtio
-- 
2.43.0

