Received: from mail-pj2-f19.google.com (mail-pj2-f19.google.com [74.125.227.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27032EEE61
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598902; cv=none; b=UodMwBZ/lgUGiJcn70DguE2D9kthVVcImmqJA75A3lKYuvoS86gibO+ykPxWQmOIRP2VVPDv4yjI6Zny7DMsnYetwFqUJH9YGNeOVkYmS0lHZTINhag/VqeVdvrYoALCLKzf5PqbWANBSoLCvtlTZwyA6EcasiIzY9L729QwpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598902; c=relaxed/simple;
	bh=l8o0E6eZA+HbYfciaj1MMVO+r3oJ8uoV2GSkjNnZkFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSomOretfIr/9rqqhVKZg9yBMlBJs/ndJ6F8hQ0fAk3BqYWZf042mpn7oAkx+sJxcBlCe2eILTRG04145w45rJTz2jiDjxTf1Ui8GbqFuYy0iWEIHoBXTEksfza5Zl6Duc658x83/iXsyhgG9Vuv0enPDSCRppnOgtm9FCfQVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lncv0w6w; arc=none smtp.client-ip=74.125.227.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lncv0w6w"
Received: by mail-pj2-f19.google.com with SMTP id d9443c01a7336-2db18fe433fso12247735ad.2
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790598900; x=1791203700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1F775RSHM+vaSTLyjPdAF399IJckotTdZzdfE7Jr3XQ=;
        b=Lncv0w6wwkG4vIGhR7BpWGqv2YWSR5Y/qvb2Y0skbXysrgMjWKY6QixEiSOdvNeN8S
         4Rj2jBOTDWldJeUKWFn7i4sqTdZ6FThxaifVFkD3+0ydEZpJXzt4XrJZ65TpjZPxO2YI
         XeVHAQ0LfI6G0wOXgkr6d6h7cPws88qVESQl2voKa4ItDChdK/AxAdSLwFlz8BTdFndo
         A33v0t5wnaYyI7FiZx3CcUuOjYOh5Jquu19uneJ0TRjzjZIsw103wgx1GpMQXf2snegE
         RXaWDb2ou4StXeaBDUSNGq0dm8VQi2u5RikkdERNRQsPh6eK0KxouFUmlpGT6pq+9w4G
         Mk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598900; x=1791203700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1F775RSHM+vaSTLyjPdAF399IJckotTdZzdfE7Jr3XQ=;
        b=VewfMcra4hvDxRaKfbmW2aOzw0NOfiN5EV8tZu7LXSZMPnnY05I5I8U8M1XC1i5qxY
         cX5hRd4JUdaybRHMJGPV6iGJ5o5rX+xovj+GEh+fowARBW/eLGhIS/xRGuGmkURn9KYI
         b52GWuaeAM30sEBDsqMOH3FJyEAlP7w9+fCenV4eQp+hdyvtek5ApD9QFS2V3NgAuVw3
         W1n1NoNDXB5pgSrJA+B02wbs3BeyQq8dvGDE52WAOLAfi9Bmcd6YLqERIhv6L6efV3Hy
         x1t0qXrQJm6Q9YN5XPWZx7HKK+Sb6XcCBHQAiVNe/Q6T7lcu0e8+kGuScsI9xu9Moj9h
         fOnA==
X-Gm-Message-State: AFq9FYLg/Lr/VflZiQSQdN7p5tKzopTFgLz7nq7y4mpo0IaRBwRZZniT
	b1S74vAWHTxPqgjWSzbxCEtd9QgRFDI5OBwtFyhdPiTZfQ1XA6LY8OmK
X-Gm-Gg: AYBFou2v8MfQhuWuRIJEYBBQB1J+nnTXvM/1oT9NMfk3kuhuxphw8e0GJTEZcPwKhBP
	WmqJnm5Cpy0myyVFsNuc24QoHRe64VNWJJfXKrKqVDtZo1+Upj4mxdjE8Lqhnwh96UyOaKnZMMA
	iP40bU23jCgNdcWCYV4nAjxLmXEQwvFNRIQeRxTDySxl3lQFRNf2U4TuF4/8iCF6/lUA2UZz5VK
	DrIMOdNr0lMnW/UX9thgtLZ7KFXYuVksa2gFTxxUS6zBEIJnTU9IJwko9juUolCqKtS+U+1e4Tc
	J6u112NsEgPtQm1UQD/ASsWfx3Ucn91iTqEEMzbXoefkaCP+HlfD1SORnpuwFR3AIrg7jpPhaXw
	IqUnxnfrkWMf0vcEZVH6pDiWX4NM1Uva7NSTpFrW6CtCVlQrJuDx0Lym8GI7ypBEfDpGenDfUuW
	tMfEN9jRfgYe7OXXzcuwkjD2sGngXEWcqwfHHxz3q4OThzmjLApO/zKW8u69ZIHHsksYetRhfNE
	lZbigT4xmzRJwX75gU8GqFyC0I5YRVYgT+aMQnqGQ==
X-Received: by 2002:a17:903:3c4d:b0:2dd:c100:b2c6 with SMTP id d9443c01a7336-2df7dc506e7mr109108145ad.49.1790598899706;
        Mon, 28 Sep 2026 05:34:59 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9143a3aasm40343605ad.53.2026.09.28.05.34.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 05:34:59 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: virtualization@lists.linux.dev
Subject: [PATCH v3] virtio_pci_modern: skip unused driver feature registers
Date: Mon, 28 Sep 2026 20:34:55 +0800
Message-ID: <20260928123455.49982-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_modern_set_extended_features() currently writes all four 32-bit
driver feature registers.  Selecting and writing each register requires
two MMIO accesses, and each access may cause a VM exit when Linux runs as
a guest.

The virtio core resets a device before feature negotiation.  Resetting
clears all driver feature registers, so the initial finalization only
needs to write through the highest nonzero register.  A typical modern
device uses bits 0..63 and therefore saves four MMIO accesses, or up to
four VM exits, during each feature negotiation.  Devices using a feature
in bits 64..95 save two.

A driver's validate callback may remove features and cause a second
finalization without another reset.  Track how many registers the
previous finalization wrote and cover at least that range on the next
call, writing zero where needed to clear a removed feature.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 38 ++++++++++++++++++++++++--
 include/linux/virtio_pci_modern.h      |  3 ++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c3..631b60f 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -437,6 +437,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
 
+static u32 vp_modern_features_dword(const u64 *features, unsigned int index)
+{
+	return features[index / 2] >> (32 * (index % 2));
+}
+
 /*
  * vp_modern_set_extended_features - set features to device
  * @mdev: the modern virtio-pci device
@@ -446,14 +451,38 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 				     const u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	u8 required_features_dwords = VIRTIO_FEATURES_BITS / 32;
+	u8 features_dwords_to_write;
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
-		u32 cur = features[i >> 1] >> (32 * (i & 1));
+	/*
+	 * Find the highest 32-bit feature register containing a negotiated
+	 * feature.  Register 0 is always written, even when no device-specific
+	 * feature was negotiated.
+	 */
+	while (required_features_dwords > 1 &&
+	       !vp_modern_features_dword(features,
+					 required_features_dwords - 1))
+		required_features_dwords--;
 
+	/*
+	 * vp_modern_set_status(mdev, 0) clears every driver feature register
+	 * and sets driver_features_dwords to 0.  The first finalization
+	 * therefore only needs to write required_features_dwords.  If
+	 * finalization is repeated without a reset, also rewrite every register
+	 * touched by the previous call so that features removed by validation
+	 * are cleared.
+	 */
+	features_dwords_to_write = max(required_features_dwords,
+				       mdev->driver_features_dwords);
+
+	for (i = 0; i < features_dwords_to_write; i++) {
 		vp_iowrite32(i, &cfg->guest_feature_select);
-		vp_iowrite32(cur, &cfg->guest_feature);
+		vp_iowrite32(vp_modern_features_dword(features, i),
+			     &cfg->guest_feature);
 	}
+
+	mdev->driver_features_dwords = required_features_dwords;
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
 
@@ -495,6 +524,9 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
+	if (!status)
+		mdev->driver_features_dwords = 0;
+
 	/*
 	 * Per memory-barriers.txt, wmb() is not needed to guarantee
 	 * that the cache coherent memory writes have completed
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 9a3f2fc..7a5b200 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -27,6 +27,8 @@
  *		    Returns the found device id or ERRNO
  * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
  *		    for vendor devices with DMA space address limitations
+ * @driver_features_dwords: Number of 32-bit driver feature registers written
+ *		    by the most recent feature finalization, or 0 after reset
  */
 struct virtio_pci_modern_device {
 	struct pci_dev *pci_dev;
@@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
 
 	int (*device_id_check)(struct pci_dev *pdev);
 	u64 dma_mask;
+	u8 driver_features_dwords;
 };
 
 /*
