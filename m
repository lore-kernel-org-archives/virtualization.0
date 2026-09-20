Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023830C164
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887472; cv=none; b=ZffblqcZ+iB4LJOHoiBiX3o/kAyhnieOynjX5v8VtCmaTiDUQ0g4cr89T04f5yeYqf0Oeb/QpYaFR/z06L4rujC64EYxpDgjvKA5L7w8s4H9x2oUmUtYfwxvz6/2LEXI7jdVotMmoj07GLuKzp1yCbm1U/jWG+5x9Trok5Qp2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887472; c=relaxed/simple;
	bh=iHzTDnRxuX38f3Ils2VnsWqAzIPC/1YX9uqKWII4HZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7yUR9I7upJVuB3m2hLhRJd9n8IpGb+T0KcifSniULoLH9F0CP5GkK88Mkcu/c5AC1KzxP0ylO7wG/YLfmyaTW056NNstb77HlQeC4Q7A/HUcXaYtWluhdzXnjVfOD0jAeQz/RqUpS5JCqQfRztOb6Z0HF4UcI0exrGzsAkCfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsV5QoBX; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsV5QoBX"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1545988a91.3
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789887471; x=1790492271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOkE96I9dw+vqjL7GyflMAtl1Zuq0wn/ipALXArRWKw=;
        b=EsV5QoBXyAArdN700eN0pvA7AFyG+InjwcSs7vw2TqQyU0pxbwwEZecO8B7crGdRG6
         gHJicwwni8ISfatOXFvelAZHUQ720+krjXzDH3xYslhc/Mk51iOOdzDT51Ih5n731XfD
         7KQtBkDC/7r7Fi470/QnCRAnePYDK1lNP2gNxVGGeJd5PuL37Mmd1j/QiO0DbQ1BfwDZ
         87W8ce4vv0jSXRn/CFe17vSi7ESp8h3UEJjzYCAmHFwRU0KTBzz6rlfF4+lS3E116pFh
         +hX+xdajDsmtJLmjHH6UGtt52dg1zxWuJlO8gZFO1ecwrYD79ruDz5s5mH/K7i8sBZuk
         nv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789887471; x=1790492271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOkE96I9dw+vqjL7GyflMAtl1Zuq0wn/ipALXArRWKw=;
        b=qmOuNN4Ysr3POAOiwMtl58n1f7dgWDy65MRK+IFydzk9gpkI/fpakooBTNYKOvATCk
         rDThVCC3KnPy3QSNY6oGnKc1y1kxWx+eBySQXL45T5SgR9WWmuwu82xbT6ic+ZLcoM0V
         rloUzz+WhaQ1SYBqoOFKfgPpSpsMmIwWTDjRehYf3BynXMEA9BM7HrGPr7ydGHcIw8Ya
         CoxpEJlWt1Tiwhdo9V9jm4qwejyEyibWkCwRhmkk/rnqhFuqZSYE6p5KkUwhkQxLGrog
         UvC17QNCuWiXpbhbY3ep0xswSZcIfnlkm/NlqehmIXIxFMrgDLkdJ4SQ3bACmjy5bDx0
         UIPg==
X-Gm-Message-State: AFuF++lVIX07PuAHhjflVX9HOVvd1HXT8GMgMSmPas5mQCSctYP60bjX
	lAeVW2t4po78Hj90A+QIZ007IcKUIoQCDGr2rGJ8opUyA22Vhb3TMujcR2a5lITu
X-Gm-Gg: AYBFou0gxdIwIXd9UMtrIEXyvKd+0cm8MIW/ieoMGVWCYLgZv9aBhEJNT+MCIwiLjBm
	jDpZWh/omozoUTOe7vPSpztXor7sEI6fE7+G+hyv9DJWxdQiRkJf6odzITL+XSBscX+RtOjUfcG
	+anYLON6SnkqHxURxbJKyc3VXn55JH6jHsE28gEVnfVZCfDWGT7RsXl6LGZFTo3BP4Zn/yWt0PZ
	zj5nnrTMOdilo4Gp5WSEDoyDMVFbM1414Qcv5E3ko8Tvgbhf3I12Vc9fY64E6/N+QGp16QzH17r
	PTZYu1sfn/x/z2bJQsd6PVPDE5fb14x5KtdEhX+REOkObVigRBAvsgFoaYkzdz5fRWJuNMVKLay
	Gq3TPDn3Yh5Kv6Bc9+JiN5moFOSEPR43lnNnmqij48IHwYmyLi+VvNotW6s2m+Rhs2KCYPTcjBB
	KVFnyD57QZHxq1sQb4i7TeJIqOL3mK0MnB5tsFNLOkjSoV5o2jjs3G2xGXCZx5uFQN1gY7HtOmE
	XBWjLodoOzs5JWfPvEX+KDDH3FlbHQYBinPfRsykEY=
X-Received: by 2002:a17:90b:4fcf:b0:39e:6a7e:ee17 with SMTP id 98e67ed59e1d1-39e6a7eef23mr6275456a91.35.1789887470855;
        Sat, 19 Sep 2026 23:57:50 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb427casm7828707a91.17.2026.09.19.23.57.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 23:57:50 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: virtualization@lists.linux.dev
Subject: [PATCH] virtio_pci_modern: skip unused trailing driver feature words
Date: Sun, 20 Sep 2026 14:57:46 +0800
Message-ID: <20260920065746.86415-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
extended features"), vp_modern_set_extended_features() writes all 128
feature bits on every device.  Each 32-bit word requires one write to
guest_feature_select and another to guest_feature, even when the upper
64 feature bits are all zero.

Feature negotiation starts after a device reset, which clears the
device-side driver features.  There is therefore no need to write
trailing zero 64-bit words on the first feature finalization.

finalize_features() can, however, be called again without an intervening
reset when a driver's validate callback changes the negotiated features.
Remember how many words were written since the last reset and include
that range in the next write, so that a repeated finalization can clear
features which were previously enabled.

This avoids four MMIO writes for devices which negotiate no feature
above bit 63, while preserving the full-overwrite behavior when the
negotiated feature range shrinks.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 22 +++++++++++++++++++++-
 include/linux/virtio_pci_modern.h      |  3 +++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c353463..8211e491a17b 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -230,6 +230,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 
 	check_offsets();
 
+	mdev->driver_features_u64s = 1;
+
 	if (mdev->device_id_check) {
 		devid = mdev->device_id_check(pci_dev);
 		if (devid < 0)
@@ -446,14 +448,29 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 				     const u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	u8 u64s = VIRTIO_FEATURES_U64S;
+	u8 write_u64s;
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
+	/*
+	 * A reset clears the device-side driver features, so trailing zero
+	 * words need not be written.  Include words written by the previous
+	 * call, though, so a repeated feature finalization can clear features
+	 * that were previously enabled.
+	 */
+	while (u64s > 1 && !features[u64s - 1])
+		u64s--;
+
+	write_u64s = max(u64s, mdev->driver_features_u64s);
+
+	for (i = 0; i < write_u64s * 2; i++) {
 		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
 		vp_iowrite32(cur, &cfg->guest_feature);
 	}
+
+	mdev->driver_features_u64s = u64s;
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
 
@@ -495,6 +512,9 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
+	if (!status)
+		mdev->driver_features_u64s = 1;
+
 	/*
 	 * Per memory-barriers.txt, wmb() is not needed to guarantee
 	 * that the cache coherent memory writes have completed
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 9a3f2fc53bd6..8df287d545c9 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -27,6 +27,8 @@
  *		    Returns the found device id or ERRNO
  * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
  *		    for vendor devices with DMA space address limitations
+ * @driver_features_u64s: Number of 64-bit driver feature words programmed
+ *		    since the last device reset
  */
 struct virtio_pci_modern_device {
 	struct pci_dev *pci_dev;
@@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
 
 	int (*device_id_check)(struct pci_dev *pdev);
 	u64 dma_mask;
+	u8 driver_features_u64s;
 };
 
 /*
-- 
2.43.7

