Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248F401A18
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234067; cv=none; b=DK1OYMb8pjLDKoF+JgH5cZsW/HQ4UVSM0+67uMjwfztYYDZ7Lm+OWaTOsLtZyVQ+rebend/CNPTTXjF2yqRZQYirtAl5pAIDar1OnUxkbX1tAxQV/Bugqa/QhNw1e5aN+8GCvLccmXmwtpY7AutTyQz1vA8yx91vz8laAQEKlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234067; c=relaxed/simple;
	bh=mKC9PDiDEih+Gn5iNc62ND2WrykAfiDZhe8kxfW9XKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHdOTOKS8GQmY//cGFP1k6I9ckKkFO2JfAbUAdHsP/1OuPTEcBt7/YM2fyIBvTJsE5y4bB4gRdHeXpDoGOCcduG2UqEczRZl4bekPQVtgx/8g/VdlLCxpf77yGoI4Pdz+tK/6OPvMheuZRnkTCqPgpWlpefLG6ecFTN1LTFOT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAbJ8Qws; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAbJ8Qws"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so8035055ad.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234058; x=1790838858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U5C/vsssDeoZyPSgVnVKJnG4HktjMOuAHzR1E1b/fzs=;
        b=mAbJ8QwsCERS3ZjQqeQ/qWC46hUQBirT5fYKIBT4U11zsWagjKaR9wB0jmxBGl946D
         2KxhUTecwvhUggZITQFfVHLKC0Z7DzYuKsCifcqcCpyyXF7NJGLJ/YCACRb8bLKj+ROv
         N3Imt4Xyvzps+QkkgD/B5TbJV7mqgmCq/UkXq+64tNvqG7LL2cT0309ko7SU0qIWFkbF
         2ss4QvxJV19eE3abrNJvppazuU82fFBCnkIrCYUrlOQlX8OkIY4AgE9AscNVLi7bjTVK
         yGjA+DGjBcnppSycJlFmXd786qYF87Pri7SetkdTSVGIzfFi9kFFzR5RrIo+y4KNjuV5
         pxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234058; x=1790838858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U5C/vsssDeoZyPSgVnVKJnG4HktjMOuAHzR1E1b/fzs=;
        b=hX8ShKbN0gOHMsrbBLNb+nSE3rYGyBtVURaHPlBZmlD9OCTiHugUjGPhf8iZpRSce6
         GCj8mn13XZ00BBWnEy0gtlJ7xKYiw6x3aKv7hYzrCppxUMOGWdNj1pkZyQMHIBFBCCDu
         trZxcMDhkWRureDhjKaavVCjPOTPml9nwUxrMKzXdKgaTRbF9O9uaUFXdnbtfBICw3yi
         aU5xOio0GCUMfvnIhTmAe6MsLQ39ZhYMsTYoDTwU/5tQK+4eZW8ZpBV/oDnsy95m88is
         JDRbd9M+2X04FJIQzHUVGGx3rUfdsF0WCrne06wISq2AztR1UUKUi7vZzTn0MlJO5sRx
         M2+A==
X-Gm-Message-State: AFuF++nRTNmiuK85+n/zE0R9226el/44HeiST6Uk//r8n4ww2XA5k0IC
	Nt3ula9+EG+Bom2RLGUugxqEtQpdk5hupHRGQ0dSJ+pzvQb8rpyIfZHnx7mOTCylnLA=
X-Gm-Gg: AYBFou1DUg6jgLlvE8LfxFJjpO6/jIedc1A4EcsR2XCnGRTPXg4n+0/j9x9g9Fjp6Co
	QTyMEifGWLY1c+Dy1j4b8ZILTdOZTqbznzGTtvBIYvE6SPCF+588h95Wh+ZGmKUz8IehdgbwWza
	E3k3EvVq2A8eDztRF65ePc3APmxP0xCqwIX/3c1b6Z+iI009lMNr5s/f/MyjTXr2I9QJwDXbcJA
	FFfc4bpKPs+5qf0NKcqG77R7SbBdbYEs+UUpfCZpRCH1jjR5FH1vozyaJTHObRw5qzwG7UueHAz
	Vx8fqfHr+bMTbYoWqmM9BQIkL9j8W4NSQHjJLhE3FXafDoSVeQbsGcXD6ZFrEn5LWtjSxYtTwom
	iCg4GdV1sCbhDIiEmLAFRi1Sidsq1DCOpP8heBViWQvYqb/INgx856fVWw5qYPbyfspY68qqgrn
	sEf3n8LlPdSfvukGeiNg/0ZQ9rFVvhb5z2Slcm9SbIUKwuZDVvoTosKPFqA8M/5GhdM9XLCXhSK
	IIPuZNdq5uFd6V1lWkAclu5j1OYdd7/vlFJLXOp
X-Received: by 2002:a17:902:d582:b0:2dd:c100:7cbe with SMTP id d9443c01a7336-2df7dc5b18fmr12805575ad.58.1790234058182;
        Thu, 24 Sep 2026 00:14:18 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a517b8dsm21953825ad.10.2026.09.24.00.14.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 00:14:16 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: virtualization@lists.linux.dev
Subject: [PATCH v2] virtio_pci_modern: skip trailing zero feature dwords
Date: Thu, 24 Sep 2026 15:14:12 +0800
Message-ID: <20260924071412.6765-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
extended features"), vp_modern_set_extended_features() writes all four
feature dwords on every device, even when the upper ones are zero.

Feature negotiation follows a device reset, which clears the device-side
driver features, so trailing zero dwords need not be written at all.
finalize_features() can be called again without an intervening reset,
though, when a driver's validate callback narrows the features, so also
write any dword written since the last reset, to clear what the previous
call had enabled.

Devices negotiating nothing above bit 63 save four MMIO writes; those
using the 64..95 range (e.g. the UDP tunnel GSO features) save two.
Counting dwords rather than 64-bit words is what makes the latter work:
with VIRTIO_F_VERSION_1 at bit 32 the second dword is set on every modern
device, so a qword count never drops below two.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 32 ++++++++++++++++++++++----
 include/linux/virtio_pci_modern.h      |  3 +++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c353463..7b4da37b6ae5 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -230,6 +230,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 
 	check_offsets();
 
+	mdev->driver_features_dwords = 1;
+
 	if (mdev->device_id_check) {
 		devid = mdev->device_id_check(pci_dev);
 		if (devid < 0)
@@ -437,6 +439,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
 
+static u32 vp_modern_features_dword(const u64 *features, int dword)
+{
+	return features[dword / 2] >> (32 * (dword % 2));
+}
+
 /*
  * vp_modern_set_extended_features - set features to device
  * @mdev: the modern virtio-pci device
@@ -446,14 +453,27 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 				     const u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-	int i;
+	int dwords = VIRTIO_FEATURES_BITS / 32;
+	int i, write_dwords;
 
-	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
-		u32 cur = features[i >> 1] >> (32 * (i & 1));
+	/*
+	 * A device reset clears the driver features, so trailing all-zero
+	 * dwords need not be written out.  Include any dword written since
+	 * that reset, though, so that a repeated finalization can clear
+	 * features which were enabled by the previous one.
+	 */
+	while (dwords > 1 && !vp_modern_features_dword(features, dwords - 1))
+		dwords--;
+
+	write_dwords = max_t(int, dwords, mdev->driver_features_dwords);
 
+	for (i = 0; i < write_dwords; i++) {
 		vp_iowrite32(i, &cfg->guest_feature_select);
-		vp_iowrite32(cur, &cfg->guest_feature);
+		vp_iowrite32(vp_modern_features_dword(features, i),
+			     &cfg->guest_feature);
 	}
+
+	mdev->driver_features_dwords = dwords;
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
 
@@ -495,6 +515,10 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
+	/* A reset clears the device's copy of the driver features. */
+	if (!status)
+		mdev->driver_features_dwords = 1;
+
 	/*
 	 * Per memory-barriers.txt, wmb() is not needed to guarantee
 	 * that the cache coherent memory writes have completed
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 9a3f2fc53bd6..b9f4783f0e02 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -27,6 +27,8 @@
  *		    Returns the found device id or ERRNO
  * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
  *		    for vendor devices with DMA space address limitations
+ * @driver_features_dwords: Number of 32-bit driver feature words written
+ *		    to the device since the last reset
  */
 struct virtio_pci_modern_device {
 	struct pci_dev *pci_dev;
@@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
 
 	int (*device_id_check)(struct pci_dev *pdev);
 	u64 dma_mask;
+	u8 driver_features_dwords;
 };
 
 /*
-- 
2.43.7

