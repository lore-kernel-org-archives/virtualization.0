Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045883A48E4
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669841; cv=none; b=dD7WwBeyMr/KNGECIRUpDSk94pOHtSso4E6u40ffxpiCpXU5CKOLzqEDqJXeJgtUrfRFMm93whYYDOyQTO0c8ijDgRymOqesoxOJcTL9aBK6n6xZczJthF+IFoKmYUoEFkAc2VMWScl9XSnnAC9qOwFJalP0roP+sA37pxpavKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669841; c=relaxed/simple;
	bh=EVj/w6iK3+b4kNl2JDaF+zi/oZ4jg0tk/C1v/bSAc1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1oJxwtc+mGqE1y9xbkZwpo0r0KYZ057fGPv0UysGSu0dj+Kl22kJ4sRJOepXPQ4hMfmyob6UOh2M6/hv2a7NAUQggvN3m8yFKBSTVIUCT/TBjdKXgXYneDC8rauDuJ/UWc5uGojAivhn17qYtO1e0PF8LdyEwL34qLyzDaKYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLCqL1r9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P2L9TZiY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLCqL1r9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P2L9TZiY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65584u9g021770
	for <virtualization@lists.linux.dev>; Fri, 5 Jun 2026 14:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YYr53TWlFvQ9X3G8WUw05dDowvGVXxiHZ6r
	UrNQhMqQ=; b=XLCqL1r9PEVlz/K281DECkdMMmGaJHtmUG9SyD2N+w8KA5Wv4Dl
	kRBCmlw2a6NZuVTT/sbMHfz8qNOQo43ryWwkO/V7vl2N5MDj3yBWe5uSgZKC9FKD
	53P6pMshkpq+updZXJ1KhYi95hzrdVSYoe9GVGmpNi7IXtuRka62vRfzLSl9udID
	nLIUz+I+xZabscPNnwvQx+OzaqtWeVPWNbdpPxkdbuQL9hKg3rtnZt3HYHp8DlDi
	gwVLsHkRhTupqBf9NqVRChl7RSRk6sZ53rEivBKYt/RlXoZPga8Z2168TCcMcI39
	xhd4FXc2zIR+BrXkFdyIJGD15P6wnWBBR3Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ektmf9hn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 14:30:37 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfc719d238so1026855137.1
        for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780669837; x=1781274637; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYr53TWlFvQ9X3G8WUw05dDowvGVXxiHZ6rUrNQhMqQ=;
        b=P2L9TZiYHJ2N//E2i3fDNq6XsY8C/tZIuodGs0fmMWkipOrV+7/4z1ePmwrca4DVSF
         i/w43HO4HXJq4k/kzXOrPAoxFGkoXMOHpt/y1j3B7VvmqH0NRw89Ueo0XqVibA1Xi9Hy
         gfbPxhIwB3prk57+Tfi25VZiU9TYoLv1Ga65wbBRvXtxUb40m3nt9tVifMD8xdolEy2A
         5XtS8SWawsC38YU4HRUKH1SZ4GliqlLCNWTSYZDl4lCm1QoyZ9UJaTEDBfFIYZCKn1eU
         npmLnv1LfdA+7rkbEXApTFARf9I5gZYjnv4zpo3wl5+/6moGL6qFc+zSpNx8z1m0R+uf
         eYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669837; x=1781274637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYr53TWlFvQ9X3G8WUw05dDowvGVXxiHZ6rUrNQhMqQ=;
        b=IwablZ4CT9Hcp+Do0kjC+6s5w6P/Tm8ZCpgN27qUFNjUHd7IH0803t2gxtRDwqzCoI
         +FzqO2rOESej2l+/OP658glo1tHHZigEG+gKl+9U4AMYKtxlJoBXDMlMrkndt1Ma+EMQ
         iNXF8bJFtJAe587AOtfT7AHWM0vNjue4kMSzwhbTwg6pPrvbYo/mkriIdJe7AdSF+5DJ
         cPqadWQnwpDYCqhPAJ1t9uT+zUWHHTN3P6bM/57ZnOoKKFH2fgBzQzwbzfvFEpwK7UAW
         +DCRUxv8E/5sZDIdtsBtGXEQZrouD3C6QnGOKbCOysuoAQEZikwAvWP2d3kUY9AL59d1
         llaw==
X-Forwarded-Encrypted: i=1; AFNElJ+FsyOnV/6oe03S62OH2tAAAq+JKdp5juXD4KHSR7G3ZoQrc6Vlb9sITKMnwhZNPdUT5d1iX0q4EMPYWxq5qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN3ipNnQnKoBJx8dg5M5T0Cn2pWdADzcZlben58VbAgbWX1VNZ
	NTzBASWreea0F8mwqEwAcIqln0AOt8m/OGav2YkZp7nCqzblXTzUvaABN0Fd68pE8JgKyUpf1zS
	KV/QoJfu8GenIFvSVSZ7YvbuWT2ti6HlEyWyMLSqI1M34b6HD/EtyIw82e2DB7d0BNixohQ==
X-Gm-Gg: Acq92OGN6nNN0rgOy46CqtHHaPLuCg+Qf/lYivCwkRdiIdw+lMeeDwpcU1ATx9lFpwU
	MJcAOHDN5JLqk2gOtWCtAUpdT8+5EKZ2dozXN50g/ORncVc+0DPNIhJDy1lq+zhAN/jaRKueitE
	9NV3iMgxLrnuBiNEgZ9/X7ur9Esa+6SxPMA/Iy4/jhiJdUP/atXuMrkHuCGPk+BmVjuCdDvh6hc
	KLbnOrmit6jbQEVnh5ACVeRwxCyxYxXagVihFY/mB1GEzUM5auRSQXGQCJ13/QBYOiruMiQhxP9
	nRJvsZcgJkayEe+GEBD+EnKeVutAmrzONYs/ahY8cuW2+kz7XTVz//mBWUze6N4fRwd1pd26ZRl
	lWTjYDNHR4xCPKBF1oG6iRZ7Jk+EgR0fWNcEUcWB4mgI1YIdPD2gmxFHK8AySqyM=
X-Received: by 2002:a05:6102:5490:b0:6e2:501c:3c93 with SMTP id ada2fe7eead31-6ff0eba884dmr1941960137.14.1780669836926;
        Fri, 05 Jun 2026 07:30:36 -0700 (PDT)
X-Received: by 2002:a05:6102:5490:b0:6e2:501c:3c93 with SMTP id ada2fe7eead31-6ff0eba884dmr1941844137.14.1780669836424;
        Fri, 05 Jun 2026 07:30:36 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm3814609a12.0.2026.06.05.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:30:35 -0700 (PDT)
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Trilok Soni <trilok.soni@oss.qualcomm.com>, virtio-dev@lists.linux.dev,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Hilber <peter.hilber@oss.qualcomm.com>
Subject: [PATCH] virtio-mmio: add support for transport version 3
Date: Fri,  5 Jun 2026 16:29:21 +0200
Message-ID: <20260605142921.2824-1-peter.hilber@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aiLq1G-u2z0hB9_6luk7ERR_DhKhA81M
X-Authority-Analysis: v=2.4 cv=GolyPE1C c=1 sm=1 tr=0 ts=6a22dd8d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=SLj1U74zwwqa45oC7IgA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: aiLq1G-u2z0hB9_6luk7ERR_DhKhA81M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE0MiBTYWx0ZWRfX5ossHVmOaCMt
 7yIFfdauqaMTUQmLTTWc9N29ecTQ/RKaAHMQ+RD8qM9H7iZk7FQEtYiP3HGkUjtvLACb3ExbZ3F
 9jxNDKhh4KSq/FwVvXnrvgAKgdiqGtUICQLUDKeZPwhAdyMZCnVnsOTDUQXODokUa+A7/lmmVJU
 4jM5x/q4kZVf++vTv+9+qAjIn1p0A3uBuylsKtiwpfrIM1dw21Sl5d+50isVaZi4Eh7vQU1DFZM
 Dp9DJSOO1R+ZB0rL8+IkDbhIcT2VrMXMCNsuTEltGhCXtLM9MIzfFo29zwOiNHZRHQZS4S46Din
 Qhtu+GNOC3ThF54/rCYIombM4dk73nJVRokSAgKjXYYtag1OJ8IPyMN4GC6JyrzN/KS2YXw7v58
 4WtCcyfZcSAuvsT70NSWpsTWAAi9neJD1VfwhwXNJk1qFnt3MwqFYWle3JYCPw7PO0VygAJzwNH
 KsRWHvzMsP79ELX0Yhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050142

Virtio MMIO transport version 3 allows device reset to complete
asynchronously. Unlike version 2, where writing zero to Status must
complete the reset before the write returns, version 3 requires the
driver to poll Status until it reads back zero before considering reset
complete.

Update virtio-mmio accordingly: accept transport version 3 and, during
reset, wait for Status to become zero. Keep the polling loop unbounded,
consistent with virtio-pci, since the reset callback does not return an
error code.

Signed-off-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
Link: https://github.com/oasis-tcs/virtio-spec/commit/bb1dd2e1fe89b862f38f15873d835a698b196f89
---
 drivers/virtio/virtio_mmio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 510b7c4efdff..316f03b97356 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -55,6 +55,7 @@
 #define pr_fmt(fmt) "virtio-mmio: " fmt
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
@@ -114,9 +115,9 @@ static int vm_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	/* Make sure there are no mixed devices */
-	if (vm_dev->version == 2 &&
+	if (vm_dev->version >= 2 &&
 			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
-		dev_err(&vdev->dev, "New virtio-mmio devices (version 2) must provide VIRTIO_F_VERSION_1 feature!\n");
+		dev_err(&vdev->dev, "New virtio-mmio devices (version >= 2) must provide VIRTIO_F_VERSION_1 feature!\n");
 		return -EINVAL;
 	}
 
@@ -254,6 +255,12 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+
+	if (vm_dev->version >= 3) {
+		/* Wait for reset to complete. */
+		while (vm_get_status(vdev))
+			fsleep(1000);
+	}
 }
 
 
@@ -600,7 +607,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 
 	/* Check device version */
 	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
-	if (vm_dev->version < 1 || vm_dev->version > 2) {
+	if (vm_dev->version < 1 || vm_dev->version > 3) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
 		rc = -ENXIO;
-- 
2.43.0

