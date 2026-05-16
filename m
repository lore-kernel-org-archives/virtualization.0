Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC627A916
	for <virtualization@lists.linux.dev>; Sat, 16 May 2026 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896747; cv=none; b=Xw2MwPNzLpeCSznxMMFV7cljyh44mr319Tb6wdAQYmYbqs8dyuudWl4gk42al4BawGfDqyl9bnLzTaLfJgv0RZKEHJiRkOHimkhOvD8fWT950sl/MWskb+oVYNLE/NUanT33uTzy7aehg6apahaRnvfnJ0joFck9iTfb4uYOBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896747; c=relaxed/simple;
	bh=+mP6J0GmpPt2dHq9MQGkUGMiaPx2jIw8pRw/8IFhHsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qs2eTrwKn0TbcghQNvLCMS8Ct1cAKpZ+oWNbLdd8IAy6lYWVOb+aMAfgWM06mdyx8hjriNrkBKz35dHIWoJY3sG9p2+yW5AppJhQTReakOWwn8wh6W/3mt/afX9gZwQ+xeXLnawKdfHrQDf4IqgDcvIn1T4oM5r21VcnS4+2kmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4Nrk26p; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Nrk26p"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so170021a12.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 18:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778896745; x=1779501545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnydI41OQ3430HCEfE0IbCU2csloNYwU26T/5pTPuPE=;
        b=Q4Nrk26pxwdoWi79TsgRvtAbdCaIhHzX1mXvKnc0846WA+vPp66sxvlv1x4tlqk1P6
         mO6l6vmvqa4sMzaySTiLhU1+S43dBI+C30XqKVYqULAwNrSrqNdmc3hCkeF4AR0xlPBZ
         yELpXZ9dvf/4iaoEMZnbbyd09FAy5geGEBDA5Zwf0vK12iHAi2rDk9UWuqFaIRCmKp0e
         y7LFznsTDIoi30FYKvaHY0d72BDhGU9m6btBjAaEDeXbKjzpsFhGauXMt9b0xQ7BNqX9
         e44yi4SYFUe/Pdt4bJ79NBo+AvAL2xp0YoVzSbbYkpJqMqn5jfZ65b3A64+9S9KBw4/Z
         LM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778896745; x=1779501545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dnydI41OQ3430HCEfE0IbCU2csloNYwU26T/5pTPuPE=;
        b=I+HpChSMJRIdcfw8OTGeDG2T5VbyfVLvtX11b6AUlbDEmYJ5a69uje66WAQXx20plQ
         2bEFJSq2G/sAd+5vo8tO2yDAPwMhIYeNoxlX8uZbadKTgfDeXd+a2seF6Vf4dnOfnczY
         5pGe+NnxbR6aCnlU4bhEI2yc09IwsqWtEwkt+lEvsQwWHyyonye03vEWXIhOta3z5yPu
         aU7ZAwnpwzBx8IO1HhCT3p7tLcLbdGQhdCBLWGkzwlDLUvvUy/PlowT0G4L3s0edDLqi
         n/ukEzjsmH65R1SGGP4WjyD2IYMajlSRk1Ulp+g4EdIzwV6u7rcaXen2CUTgdzbou0kU
         NLfg==
X-Forwarded-Encrypted: i=1; AFNElJ8DEQuKuHJeWe/xcZTE3VC9flmZtRxokcjOyqA8u4amr6fpIHaMIU/TMx8AWG1Xth1jAmqpo39tvm6NQuRVmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdIDdIzYTrUglkh4+L+QUxziBIzJZMoOux/rTlLIHm7beUP+vf
	fkBQj6fOHunPxwcktk/Z0d62tIe33w/oFcSVM6apotqS8mTN6CPjcQl0
X-Gm-Gg: Acq92OEaMf+BGVZcUeVko73cCYx8Laxb2t0b5ryr7bkrpRXKzI+vjMJgKmmotZHI/K9
	rP1U3Y9B72bl2uG+3H8dnwTarHaq8iqp7Zq1vhkT7h1E34wxcUJizLfcYj8Dk5pfsX1I49ukghT
	NFn9MNFT+EcorzrR2mI1xmmtiGS7bmQ+z0upF5fuS78JIO4OO1HqyelVagc7NH59XzeH9q3pqrj
	v7NmunnQsc3lgNTf5LzanzCbPu7m/XNFbzjOcDACgrMR6VVPDwALVP6+jX9v28vjxpLa1KxXyrO
	VDSJVEapSgytE/5b9TnnRcfI3xLB2gNyFN/xMtftOTFJoClaAoIciDxdWiX0IMLbpylWpNmuLll
	gcdq9/spNb+hilNVZMc/3k5tNT5TlO0bKplUx1GD+/qPxtOR9D8j2+vHfYFtdb9sV6gsVKcmn2G
	Tk9Eqc3F7ZV/H3wUFWXiRPnr1NOW7w8qpxx5hLn0vl57RFjZFFCDoI9WKT/PA3thuglsiNj2FD8
	Vsn3jcK/5vRBY9X6PvnVP9bjKiZbG1X9bV97A==
X-Received: by 2002:a05:6a20:7294:b0:3a2:f7bd:a9a5 with SMTP id adf61e73a8af0-3b22ec73c64mr7355013637.38.1778896745059;
        Fri, 15 May 2026 18:59:05 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm6605080a12.11.2026.05.15.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 18:59:04 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stephan.gerhold@kernkonzept.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v9 1/5] virtio-mmio: move guest page size setting into vm_reset()
Date: Sat, 16 May 2026 10:57:52 +0900
Message-Id: <20260516015756.20948-2-baver.bae@gmail.com>
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
2.34.1

