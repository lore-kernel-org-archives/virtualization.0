Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22753093D3
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692473; cv=none; b=IkFvcQ2ota747zL+wQy0j5GKrOIbJkiaop1AAzzuNWRmCZj4oCNXg+gvxLJG8rZfL5PBi34kxyLoNr6muz4y616LqA0U8EG3nYGymrw/hRTW60gjvTnFnf/jFNerxlhldzD9EIRrVHi/BUELxu5eV7YRpDrwa2FAosT/pggeoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692473; c=relaxed/simple;
	bh=3OhirNyMf54WSFzJShiX8eOgeTq9nhO3PqfEs+vn6oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGFe3KnCLBpUS7nuXatzVO5D1Z7d4UzrkxUtz0O1I9iFVPvfHSk2ZeCxpDvLOFvk5RqsyFh8RmTJbLMbJKytoH1ergh18B0iriZMSXe25ER4lWBJRWx24EYlvq3sWq9xsyxaAfPpTG3H3gIim5hFmF5y2eVDQa7F+dQLSKuLeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T857qQY+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T857qQY+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1325635f8f.0
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785692470; x=1786297270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNTSo9k4OEOZmjLMcV0fOaIKqB7Gshw/tjsufsKjn48=;
        b=T857qQY+hZC3S7pBua5PbBy6UkjdxFOV+k/LoF+ArjzwTWuh8hb5Ym3dr8MktPypID
         rFSaGnGSzYcb2MXPVTZNMcJkUbvtKxf6rzRek/gVsU303Jj8k27BFiOvwHJTgqrql/o9
         xYZIsXhrnfHGmRf0+k4jIPcA98o1/Jtx/pzxXSggoisRA+a9qso4ay/jFJeARYYqstic
         afgUFS51vyKVAE8XrPxVWVFuPl37RnQiITxr/RZP6/5LGDDJ9KTtVJvskHnBn2e7Vduo
         r3aMzFHLw39iCx3cUXcLbOa0sc1W44BGVvSnWM+Skvzx/QMlqHmVr2D9lstBwtyEhuEJ
         Tp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785692470; x=1786297270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNTSo9k4OEOZmjLMcV0fOaIKqB7Gshw/tjsufsKjn48=;
        b=NDMNpCjpirc8eEPazvPFRx5MAiap/+zfmFgg3OM+N+zAcSpO9NKv1mDkYFAgKarZ2N
         V0Hk+dPkx7qtb+9oOu3x3FRx+J2HX72K/DD+fpUm2I59EXhnodWE3v4OTyn12pQiPEND
         uoLUms6NthMeNq9TEcuXQ1pVKXFLqD0voa3voQZ6PbitaolTo2a0wk4WWPy0g040bP9X
         yI/vYn9QPE+Meo6/G9HrP4sdMwtgXcFZE4Yx2+djATgR2y7WbeaaBbv1G8hRMhPXfRBk
         xcqfLzNtJy8NZVQCKYCz2P1WkCRjdBToxjtdrdV83NFt1Kn5lcSlPoP+ONv8UAvbla1d
         sXsA==
X-Gm-Message-State: AOJu0YxSgaVgPbUH5rIlfCWa8HY/NdW/xVi+gQySYMgMMyCAV31XLb7E
	0LZ1ip678NVLGLuKBPpQLDr6kJevBCnMkRVTY06th2iEkRWHu2CuHmtQ
X-Gm-Gg: AR+sD100gliNsJws75/zqiW744/dlguXXZzrk1BoP4os60TChnNxek4jdSle2JnEsx+
	4rrj0zbkNCZ+TVcnFw5DnUbJyRP6luayt+ss4wQNmJAJd93etGxBa3GgU/oPmct6OtSevF8iIRC
	QiGLtg65SmOabpszS7qlUgoyoVMOsmtvPo89EuXrUZePK/Awa1YJhezxi8HxzYm4lvUr2n4N742
	X2AhI7YTp01jXicnHAs0do4UYXQ3R1DlSYOcTRnLf1rkYT3v2gvaxcUD4v8s1sAhXs7D0FvbUr6
	pFFOKDgxqSEhnsgQqtA9xqTjE1sTFDk3IiiI+OoAgQtQxCP/jREcYFRmDC+Fbszme1narxk0P9H
	/JYt+5cRq2HwmedeQJ5Yx9iNiJ6JoRoXJ5IZZMUNTHz6iehPgNH2NUYbXK+2Ngk6uYYx+v0tkWc
	td/b4kIiiOQoD3wPfA0csPUxRtt63JlREVxGm8Va+1u2QL4MgsAhkq30XSdc2pfhm0weffOPYlf
	4OmyYIVTVe/Xzm494YF/hM2wdigzQYmyxZW4V/eBjRwF1+mgr3yjsjkFTpeZdB5x5Y=
X-Received: by 2002:a5d:64e1:0:b0:47f:8488:50f0 with SMTP id ffacd0b85a97d-47fd72ba756mr17412763f8f.4.1785692469675;
        Sun, 02 Aug 2026 10:41:09 -0700 (PDT)
Received: from a9d4faf53c34.fritz.box (dynamic-002-214-008-136.2.214.pool.telefonica.de. [2.214.8.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458ab61sm25607861f8f.25.2026.08.02.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 10:41:09 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH 1/2] virtio_pci_modern_dev: warn once on invalid status
Date: Sun,  2 Aug 2026 17:40:58 +0000
Message-ID: <20260802174059.4082-2-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260802174059.4082-1-abhinjoses@gmail.com>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_modern_get_status() returns the raw device_status byte as read
from the common configuration structure (struct virtio_pci_common_cfg,
mapped via the VIRTIO_PCI_CAP_COMMON_CFG capability). That byte should
only ever contain some combination of the status bits defined by the
virtio spec (bits 0-3, 6-7); bits 4 and 5 are reserved and a
spec-compliant device must never set them. A value with any other bit
set means either the device is violating the spec, or the read never
reached real device state at all -- e.g. because a write of 0x0000 to
the PCI_COMMAND register (config space offset 4) clears the Memory
Space Enable bit, causing the device to stop responding to
memory-mapped register accesses -- effectively simulating an
unresponsive/removed device without a real hot-unplug. In that case
the MMIO read returns the bus's synthesized all-ones response instead
of real device state.

Add VIRTIO_STATUS_ERROR() to the uapi header to recognize such values,
and warn once from vp_modern_get_status() when it sees one, so the
bogus status is visible at its source rather than only showing up as
confusing behavior in callers.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
 include/uapi/linux/virtio_config.h     | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c353463..60dd8acf1c28 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -480,8 +480,14 @@ EXPORT_SYMBOL_GPL(vp_modern_generation);
 u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	u8 status = vp_ioread8(&cfg->device_status);
 
-	return vp_ioread8(&cfg->device_status);
+	if (VIRTIO_STATUS_ERROR(status)) {
+		WARN_ONCE(1, "virtio: device returned error status: %#x\n",
+			  status);
+	}
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_status);
 
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2445f365bce7..6f458914c0ba 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -45,6 +45,22 @@
 /* We've given up on this device. */
 #define VIRTIO_CONFIG_S_FAILED		0x80
 
+/*
+ * Check if a status value indicates an error
+ * All device_status bits currently defined by the virtio spec (bits
+ * 0,1,2,3,6,7). Bits 4 and 5 (0x10, 0x20) are reserved/undefined -- a
+ * real device must never set them. A status byte with any bit outside
+ * this mask set cannot be a legitimate value: either the device is
+ * violating the spec, or the read never actually reached it (e.g.
+ * PCI_COMMAND memory decode is disabled and this is a synthesized
+ * all-ones bus response instead of real device state).
+ */
+#define VIRTIO_STATUS_ERROR(val) \
+	(((u8)(val)) & \
+	 ~(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | \
+	   VIRTIO_CONFIG_S_DRIVER_OK | VIRTIO_CONFIG_S_FEATURES_OK | \
+	   VIRTIO_CONFIG_S_NEEDS_RESET | VIRTIO_CONFIG_S_FAILED))
+
 /*
  * Virtio feature bits VIRTIO_TRANSPORT_F_START through
  * VIRTIO_TRANSPORT_F_END are reserved for the transport
-- 
2.51.1

