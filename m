Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249782;
	b=SGsVCm14SjfC2Y7AIx95+aAW7/d7jKdN0MXbaiXwAwpzLYqu+dFcW+RByqAdmHwOiEuj
	 2/dGb8MfhMNCquCNujjVN4AVHR0eyUA89fV/Ksk/mYfyoOOFNF2ecNyXEwLYkkZpI8t6Q
	 BBxCMyuPdVK6fVEQezvjPJgRiLbZmfwFKxv6uIzltx1ANGXNXe0cM0rPheY/fSZwlxSn/
	 EuvZW1/yQgvn2q03BJxutFjvLKnFxoAJ2JNx/UoyjOpX9iVhS9u9FyqmK/a93bASNo4ls
	 dlVeZCl88ygSwGl1u6ogYzBg7QO71a4RhrjVh+3t7mcEiPuPeC0IahTYS8bJWRYLt+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hCv4A4/fOHsrQBoTCNAexOwPwKPV45Fgld4XHthQZuI=;
	b=la56yWzrl5Ltpb2DxJEQq4nIQ49l6bCqZhRVbeKlX7/Y7XHbnFJFWYehQ4hblx1Bxics
	 2ZsOyN3IpHT09b62rMm88OMIpz5kO4o2EYh59IBLLL4ByrXmTiCFVfGcKuQyXrzxPGvvD
	 bEMFndzcyuVfaQiC4ogIoYCQV2CxAipKDQS90eDLWa/AiwbuE0LFDHr1Fy2h8uePAOxKG
	 27P4PXoEyVcUhHeHp2rrQRmW6KjwPc33ZQ5l/AWxYuUDfxdQw0MTwN0t2uIew76fBJWPQ
	 xv0irjnZdU3ALY5KtdfRH2mR1xB6e9WXtf8ZsFHbbbrJUFPvTzXey9VJiWkW8fgrLyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pkZ8F7N+;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62A606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 18:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC62A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pkZ8F7N+
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b305d38bafso9031367b3.3
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 10:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794249781; x=1794854581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hCv4A4/fOHsrQBoTCNAexOwPwKPV45Fgld4XHthQZuI=;
        b=pkZ8F7N+pSjpzNPZjBS1oIvwq3F0Uk3sVTG7+NL9IDiE0b1hfQlpCMBkyVEoTqBEs+
         4NCVEqXfgbaS8VCv3+aHUBJIuzHpswalrSJaT89Iw1oprz4NAZnF5PAwq1kJ6G+7hVtA
         jZGBLkRTVVwc/KdK6DfuNbGgWCP37MczOFPDxZyWs1wUX+iSxdgM52m0AwY+gaGrujVn
         2PfpJytwRhIYK4SrtVYGQ7pBqZLZZZBh8ZuRBDEaWARpv13sLl2K58/SsgaP9iViPjF6
         H8YNoflB/R/4kerOwv+IpYVzWpaDZtQw/YBNZA1EDofJlCf9JGwYejdUd5f619JY3Rkn
         h75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794249781; x=1794854581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hCv4A4/fOHsrQBoTCNAexOwPwKPV45Fgld4XHthQZuI=;
        b=uvhXTCFxgPSKr7QXumWICXEPZS1EF8aeVqwUxEBXX55b2CYGBgsO0r76/tTSkYc8wE
         Lq9rrQBsVGn9NcEw42uD58nM0NWRVuJASc9WpaGUIKsr4D39KOagk1DHwJK+n2LBqZmS
         9h5LHsXQkqfngSqNSVo8Wk9LjjWB+6w7FnVbYUj/vw/acqc9gTznFhtaTxfa5N6SHqOD
         7yNMjy1kSIfubjRXLPhPzMp/hHX2GsUsg7qym8zAtJsjPnVbHsEsVc6s0PkiPn1c1rEI
         NQfJvwUU34x5kCy7wVU9OLUmYUGUAlhCnITVqDCN3e70ODf4MnxNFV9oFc4gYW37N6ZI
         vgOA==
X-Forwarded-Encrypted: i=1; AL+hErFO5mU4CHmgdFMSROt7Ary/pIZvis/PfpZHydT/QAYZAQKuruEVGHVyqpLFUuofa+FvMgjb7O+zCvT+bJpX6g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GxhoPSg7lxDczWk55WxJIEoX9BjN9/58rdHJHbVluT2j8/WUh
	Jf+sxayHN/g5MwWA55X9LxmKl2QqX0YKdwwDfQ/niu7KpMVnPkuXDMkC
X-Gm-Gg: AYBFou1fHNYI9B4XVHce4uZDOPmF/INoa/nsHpihX0gU+oOZILCCXG9M6SBvNSeNBHf
	k86SpRC/CUWRQRLNMDh3SY7UeHCP61JV18UMKUviLRVekvd0AuAdYlCtTgqgqxkNLMsE2jzBVuu
	hJQwSwevVctJdMzGGXPHK8oNoZ1T7gyZYMyUsRt6nYpazcGgiXP3w4lWwlocDzbiuwXNoUXD7Gp
	gflydoBxwF3Ic+TXaXcdg3PMDbhU4do2p3RmLY0/xH25X734WQq5rlsBvnmV4bjExA1/ouxh1gq
	Y6GJyC3if85hBDankEPVT3sliixfkSz8B2VGMJ1ubZi25AffEQHuKzPowAy2SiXhUrzE8LjW74R
	8soYQSLKpX7Gdy9QF7pa60xtC5ss4KXXT0eTDzuGwhWvI1ezQ4gNAcejxeK9pdGtF3Oxa4PjgqF
	zQqux2jUweguIE6JtilHjY1kKOssDU+sJB/RMFUjQ1mXqX0OTQLYH644S7F9HGEoOelgvpfFdPq
	dGTqRxyMeL5CbWC5tDnAzus04vNRzhiA1A9APX034i76ek6AH+SQgq17PvOMl7+5wDHFGD+4hX6
	ZGreVOWjYi0q5JT3sNKE2yQ=
X-Received: by 2002:a05:690c:e204:10b0:8ae:a9c6:2740 with SMTP id 00721157ae682-8b392b6884dmr1303547b3.48.1794249780855;
        Mon, 09 Nov 2026 10:43:00 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:10::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324bbf5sm961007b3.1.2026.11.09.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:43:00 -0800 (PST)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Kyle McMartin <jkkm@meta.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit DMA
Date: Mon,  9 Nov 2026 10:42:52 -0800
Message-ID: <20261109184253.531677-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio-net function of the AMD Pensando DSC2-200 (Elba) DPU, as
shipped by Oracle (1af4:1041, subsystem 108e:1200), cannot DMA to
arbitrary 64-bit bus addresses, and Oracle advises limiting it to 48
bits. virtio_pci gives it a 64-bit mask, so its virtqueues stop
completing requests once the IOMMU starts handing it IOVAs above 2^48.
The card is used in OCI bare-metal shapes such as BM.Standard.E6.288.

On those AMD EPYC 9005 hosts the AMD IOMMU supports a 6-level v1 page
table (EFR[HATS] = 2), so the aperture spans all 64 bits and the IOVA
allocator, which works down from min(mask, aperture), returns addresses
just below 2^64:

 - With iommu.forcedac=1, the first control virtqueue command never
   completes and virtio_net hangs in probe.

 - Without it, iommu_dma_alloc_iova() prefers 32-bit IOVAs until that
   space runs out once, logs "Using 64-bit DMA addresses", and stops
   preferring them for the device. Across several thousand of these
   hosts, 21 logged that for the virtio-net function within 0.2 to 7.3
   days of boot. On 14 of them, TX queues then stopped completing
   descriptors within hours ("NETDEV WATCHDOG: ... transmit queue N
   timed out"). No host without the fallback reported a TX timeout.

virtio gives a device no way to advertise a DMA address limit, and the
platform describes none for this device, so the driver has to apply
one. Cap the device at 48 bits through the dma_mask override that
vp_modern_probe() already provides for devices with address limits.
The device still gets 32-bit IOVAs first, and then IOVAs below 2^48
instead of 2^64. pds_vdpa uses 52 bits for the same ASIC; this uses
Oracle's narrower 48-bit limit, which still leaves 256 TiB of IOVA
space.

Only the virtio-net function is matched, since it is the one that was
tested. force_legacy does not bypass the quirk: the legacy probe
refuses device IDs above 0x103f, so the device always goes through the
modern probe.

Tested on a BM.Standard.E6.288 with 6-hour iperf3 --bidir soaks, at up
to 57 Gbit/s each way with iommu.forcedac=1 and at about 26 Gbit/s each
way without it. Neither run saw a TX timeout or an AMD-Vi
IO_PAGE_FAULT. With forcedac, every traced IOVA for the device fell
between 2^32 and 2^48; without it, every IOVA stayed below 2^32, as
before.

Cc: stable@vger.kernel.org # 6.5+
Co-developed-by: Kyle McMartin <jkkm@meta.com>
Signed-off-by: Kyle McMartin <jkkm@meta.com>
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 drivers/virtio/virtio_pci_common.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 79d3395f37050..0a7c97cd80509 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -667,8 +667,18 @@ static const struct dev_pm_ops virtio_pci_pm_ops = {
 #endif
 
 
+/*
+ * The virtio-net function of the AMD Pensando DSC2-200 (Elba) DPU, as
+ * shipped by Oracle (subsystem 108e:1200), cannot DMA to arbitrary 64-bit
+ * bus addresses. Oracle advises limiting it to 48 bits.
+ */
+#define VIRTIO_PCI_QUIRK_DMA_48BIT	BIT(0)
+
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
 static const struct pci_device_id virtio_pci_id_table[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1041,
+			 PCI_VENDOR_ID_SUN, 0x1200),
+	  .driver_data = VIRTIO_PCI_QUIRK_DMA_48BIT },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
 	{ 0 }
 };
@@ -710,6 +720,9 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto err_enable_device;
 
+	if (id->driver_data & VIRTIO_PCI_QUIRK_DMA_48BIT)
+		vp_dev->mdev.dma_mask = DMA_BIT_MASK(48);
+
 	if (force_legacy) {
 		rc = virtio_pci_legacy_probe(vp_dev);
 		/* Also try modern mode if we can't map BAR0 (no IO space). */
-- 
2.53.0-Meta

