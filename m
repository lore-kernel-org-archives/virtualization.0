Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9BA423EAE
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114300; cv=none; b=fcGNnaqfGgdZOBwWS2DfIVLo+EughOjYnQGgg7Ebz8iYVsOkpyQtaA7hPWrCwznhPNvRrU4zdCQomXcJSB1LxYQOeEQLvCK1xZOmj6fidL/5RnUec1gTpLUKiyu1WtdaxnNAiCHeGDefgywbLNytJSCESIDZK77ExIwdhNlJFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114300; c=relaxed/simple;
	bh=PSNB45Q85nSJ8EfsYtGVD0US+rdpPqX13AjaNSXE2vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZw+raMe4Mnrxr3wcmC5TjmSIQ/4XideJi4wIbpjhtE+t47vS2Vkh2r2kIp5q7uAbFFrA000UzgUw6f+W58MiFSKsXRfe+Oz+af9qezNJn5AHdj8dBOun9MSnBsbwth90NhHAwFEeA3MwR5BYoJbO9xVK79otLLcK/DBgq+v14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHdnWYf2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHdnWYf2"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-86265451beeso407348b3a.0
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789114298; x=1789719098; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E6qIlKP4WBPCXnKgoYUM4/BV7Qkg9XE90X6+jpMGHM0=;
        b=WHdnWYf2LKH6MJ8qbrKsk6l5UFvSX6v4c88+4JrfDCwjLnu9+1Pbh8GoYNY+4+vt9z
         gYuhlC8HnlSYKYgxn+S5b3TemK6VUdmrBHsS+P4mt/rt3RHvWGhxewYy7o8TgViUfLuC
         2NyZ0B9JKwQjjk+dUhkt+zYw4xnb307t7R6y+xiXv4QOdbJsNR8pJw/2hiYiRLbFmLT5
         j9M4kZlxvVmawlvcW/NRYZFARTHL0cJZsyxstSBtrByWQXOvX5FNfV2mT7TeDIe3ZHYs
         c3sbZLjUlnX9uKkK1jvi81jXQ04ydTA2CGbK2lCaXhmD49qMZPtGujpiG9emG003uWTb
         U3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789114298; x=1789719098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6qIlKP4WBPCXnKgoYUM4/BV7Qkg9XE90X6+jpMGHM0=;
        b=naP4X2n/7R3d3mJrYJnCvlkk5Ui2Hj6WxfvFJHCJeu1LUz6pXysnkxUrmnPavJYRkX
         OgGPH3uZBsL8mWr2Vgkn0N6xJwK7uuWdee/1UVAUbbB0QbsDiJ7KWSkalomnbqctFTxS
         b+oryMJiCCQJK1DskPtt/PjptXUSAW48FmxlsA1BBAczXgMYZin9Pe2iCbbcEI048owI
         oQHuNlQKv9n+kg4Su3pzRmGqMiL2ADIh45sPB/vOpWNbYArryzSeutB8GGcg5FATy0jm
         oPJj3oBSxv+hGrVFLPXTL6aczMicz1pe5BnaCtumBRuHmVEVFIsR13T6L5WDYDGJsa6V
         J6IQ==
X-Gm-Message-State: AFuF++mksXkbVUeuy2hBgfi1s4y+SearLYuhjCdxDWG66mPzUdoFk+iJ
	CAF+OtFHqBzTgfEO9Io2MLZxSsg+nSVIdjce7TlfVNphBZH7GuPCXEA3
X-Gm-Gg: AYBFou3AIKQR9iQpUn61yLxGizpFML1j+EVZSswPVJkKgv9roHdEF9LC220h/Eougfq
	qfijfXdNetO3LddDQ+oJ4Vlvq/ppLLLtfsnnVR3Wg17V7Yi1LV72plotNeJjPF2HoRd1PnokWfU
	eO6zmuKtyRNDKGs9yazYpZ9DGMK/KyU0Ey0W3jb5Nksejj35CVO5oOEDDcrPAZ1oi+l9xZuiXQp
	frhXrVOUiivgLwIXy0v8Ed5OmnOLU41PBDXXCFa+Dhca5Q0DZu8jb+o68SiJDA3ruroqORCbktI
	ntXgQc+m/OnPFcvNPvpV3o6vFDPS8teAI7zzatoswB3FjJDXhVb8Sx8W0g5V4MT9dnGqXtxUkHA
	Ta6+Fop5uPiO1P3oU9gxaNTAJpcQtIrmV6OVfc3JBVxRqoPYtFlE889bkAQMIlIeUeh1Kb1/7Y8
	OXgMT75OaeJ/lJ1vyI1Y0M5N0xr3liPjzJ+wCQnXTsf2PlWMkQkIFCF/2gF1upnicTNKxi/b3mW
	Ll+Ruy6x6mlGpkkQzkZo0NW0+Kfx5hn48L2Pe/Egvo=
X-Received: by 2002:a05:6a00:a90e:b0:85d:84a5:b7bb with SMTP id d2e1a72fcca58-86b3071ac4bmr5030138b3a.18.1789114297616;
        Fri, 11 Sep 2026 01:11:37 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b250c019dsm759229b3a.7.2026.09.11.01.11.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 01:11:37 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: virtualization@lists.linux.dev,
	Peng Hao <flyingingpeng@tencent.com>
Subject: [PATCH] virtio_pci_modern: fall back to 64 bits features for devices without an extended features space
Date: Fri, 11 Sep 2026 16:11:33 +0800
Message-ID: <20260911081133.16434-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingingpeng@tencent.com>

Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
extended features") the modern virtio-pci driver unconditionally
accesses the whole 128 bits features space, i.e. it drives
device_feature_select / guest_feature_select with the values 0..3.

Devices predating the extended features space only implement the
legacy 64 bits one, and what they report for the selectors above it is
not a valid features space.  Negotiating it makes the driver and the
device end up with different features sets: on a smart NIC exposing a
virtio_net device the link comes up but carries no traffic, while the
same device works with a kernel that only accesses the low 64 bits.

Reading the features space has no side effect, so keep reading all of
it and use the extended part to tell whether the device implements it:
report the legacy 64 bits only when the extended words read back as
all-ones or as an alias of the low words, and latch the device down for
good.  As the features negotiation ANDs the device and driver features,
no feature above bit 63 can be negotiated afterwards.

Writing a selector the device does not implement cannot be relied upon
the same way, so never drive one above the highest word that actually
carries a bit.  The reset preceding the features negotiation zeroes the
device side features, hence the words left unwritten stay cleared.

Also dump the raw device_feature dwords, and add a max_features_u64s
module parameter to force the legacy 64 bits space on devices whose
quirk the detection does not catch.

Conforming devices are unaffected: their extended words are neither
all-ones nor an alias of the low ones, so the detection does not
trigger.

Signed-off-by: Peng Hao <flyingingpeng@tencent.com>
---
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c353463..cfb10c9f32dd 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -5,6 +5,21 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 
+static int max_features_u64s = -1;
+module_param(max_features_u64s, int, 0444);
+MODULE_PARM_DESC(max_features_u64s,
+		 "Max number of 64 bit words of the virtio features space to access (1 = legacy 64 bits only, -1 = auto-detect)");
+
+static u8 vp_modern_features_u64s(const struct virtio_pci_modern_device *mdev)
+{
+	u8 u64s = mdev->features_u64s ?: VIRTIO_FEATURES_U64S;
+
+	if (max_features_u64s > 0 && u64s > max_features_u64s)
+		u64s = max_features_u64s;
+
+	return u64s;
+}
+
 /*
  * vp_modern_map_capability - map a part of virtio pci capability
  * @mdev: the modern virtio-pci device
@@ -230,6 +245,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 
 	check_offsets();
 
+	mdev->features_u64s = VIRTIO_FEATURES_U64S;
+
 	if (mdev->device_id_check) {
 		devid = mdev->device_id_check(pci_dev);
 		if (devid < 0)
@@ -398,15 +415,36 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
 				     u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	u32 raw[VIRTIO_FEATURES_BITS / 32];
+	u8 u64s = vp_modern_features_u64s(mdev);
 	int i;
 
-	virtio_features_zero(features);
 	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
-		u64 cur;
-
 		vp_iowrite32(i, &cfg->device_feature_select);
-		cur = vp_ioread32(&cfg->device_feature);
-		features[i >> 1] |= cur << (32 * (i & 1));
+		raw[i] = vp_ioread32(&cfg->device_feature);
+	}
+
+	dev_info(&mdev->pci_dev->dev,
+		 "virtio_pci: device_feature[0..3] = 0x%08x 0x%08x 0x%08x 0x%08x\n",
+		 raw[0], raw[1], raw[2], raw[3]);
+
+	virtio_features_zero(features);
+	for (i = 0; i < u64s * 2; i++)
+		features[i >> 1] |= (u64)raw[i] << (32 * (i & 1));
+
+	for (i = 1; i < u64s; i++) {
+		int j;
+
+		if (features[i] != U64_MAX &&
+		    !(features[0] && features[i] == features[0]))
+			continue;
+
+		dev_info(&mdev->pci_dev->dev,
+			 "virtio_pci: no extended features space, using 64 bits features only\n");
+		mdev->features_u64s = 1;
+		for (j = 1; j < VIRTIO_FEATURES_U64S; j++)
+			features[j] = 0;
+		break;
 	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_extended_features);
@@ -424,10 +462,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 				       u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	u8 u64s = vp_modern_features_u64s(mdev);
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
+	for (i = 0; i < u64s * 2; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
@@ -446,9 +485,19 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 				     const u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	u8 u64s = vp_modern_features_u64s(mdev);
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
+	/*
+	 * Never drive a selector the device may not implement: stop at the
+	 * highest word that carries a bit.  The device side features are
+	 * zeroed by the reset that precedes the features negotiation, so the
+	 * words left unwritten keep the value the driver wants for them.
+	 */
+	while (u64s > 1 && !features[u64s - 1])
+		u64s--;
+
+	for (i = 0; i < u64s * 2; i++) {
 		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 9a3f2fc53bd6..7dc76afa671e 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -27,6 +27,9 @@
  *		    Returns the found device id or ERRNO
  * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
  *		    for vendor devices with DMA space address limitations
+ * @features_u64s:  Number of 64 bit words of the features space that can be
+ *		    accessed on this device; 1 for devices not implementing
+ *		    the extended (128 bits) features space
  */
 struct virtio_pci_modern_device {
 	struct pci_dev *pci_dev;
@@ -49,6 +52,7 @@ struct virtio_pci_modern_device {
 
 	int (*device_id_check)(struct pci_dev *pdev);
 	u64 dma_mask;
+	u8 features_u64s;
 };
 
 /*
-- 
2.43.0
