Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0184A5B
	for <virtualization@lists.linux.dev>; Sat, 14 Dec 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734160359; cv=none; b=qzykvjHJeguEEu/oAtRGusGIQyxZ/MeP6bWbTX37pkkAKNAx8YOshj/rDEeyKDe8O5VGCwibQ8aKy3o5s5zubHrOX0om/TZce1yY5zDFYF3WRshNOPGE69zLv+tl1ZbSCIJ1UoTDhUSz8GNlTur3nZe9lMaxXXghZXr/NcSS4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734160359; c=relaxed/simple;
	bh=xeje1zIesVYbhea+1Gk9yPATo52S7S/74fCyQZoQGQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDdjkpuZjljPmy/3bpDJYy65zVF5h4vvy1VHVzeAVQJJb9Rs+t2SJXNr9TlzmdVxIXc0hHcNiO9OQYW6rxpELZXQ662IY3ivBvvWSCvaruc1t6M09Z547l6WyJKuMFgx8upOX6+KdJweIXnneEhcugMnTzoyiINqJXUrMKrWUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ME4DHo67; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ME4DHo67"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE7AFls004905;
	Fri, 13 Dec 2024 23:12:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	AZ+rawhvQ5DFCA3TlQmYMJ6HgyHkUNSWCFpvGQekME=; b=ME4DHo67WOxIBr6nF
	+emyPp5Mh8yFfv2eEZPZu816lOL1xHsluFrogYcQqLecnanCbxovKa+SSOrz62ox
	3wCf/nZ7J8wtUBc/Jcp8uyrzVK/gQ2uYrPlt05FvIzS/5vdwktDjfgUELmqYk1AA
	uVcWEQe8IsXKZbWBklLXa1XcvRzi1mIvbH1ci0w7iMIUAYedPrH9eY5M4ef1aYOB
	homNrPr8e40tcgtJ2f4la5ZbrQ/FqVU4eQEJr8Q3LppplomXuft6FzM0p9uqhy+z
	bTpY/2mkuDPUUCweZQz5+S/zx8yLLTd7C1Jjr+OBn0iSnm+/uDe5owzr15wILqrZ
	oKODA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43h5d3805s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 23:12:32 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 13 Dec 2024 23:12:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Dec 2024 23:12:26 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 594F63F704C;
	Fri, 13 Dec 2024 23:12:23 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
        <dan.carpenter@linaro.org>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Satha Rao <skoteshwar@marvell.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/4] vdpa/octeon_ep: read vendor-specific PCI capability
Date: Sat, 14 Dec 2024 12:36:07 +0530
Message-ID: <20241214070835.568818-4-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241214070835.568818-1-sthotton@marvell.com>
References: <20241214070835.568818-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -QgUS3gtoAiVdrsLesfd1kfjAfQ4G6b0
X-Proofpoint-GUID: -QgUS3gtoAiVdrsLesfd1kfjAfQ4G6b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Added support to read the vendor-specific PCI capability to identify the
type of device being emulated.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa.h      | 20 +++++++++++++
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 36 +++++++++++++++++++++++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep/octep_vdpa.h
index 2cadb878e679..53b020b019f7 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa.h
+++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
@@ -8,6 +8,7 @@
 #include <linux/pci_regs.h>
 #include <linux/vdpa.h>
 #include <linux/virtio_pci_modern.h>
+#include <uapi/linux/virtio_crypto.h>
 #include <uapi/linux/virtio_net.h>
 #include <uapi/linux/virtio_blk.h>
 #include <uapi/linux/virtio_config.h>
@@ -52,6 +53,24 @@ struct octep_vring_info {
 	phys_addr_t notify_pa;
 };
 
+enum octep_pci_vndr_cfg_type {
+	OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
+	OCTEP_PCI_VNDR_CFG_TYPE_MAX,
+};
+
+struct octep_pci_vndr_data {
+	struct virtio_pci_vndr_data hdr;
+	u8 id;
+	u8 bar;
+	union {
+		u64 data;
+		struct {
+			u32 offset;
+			u32 length;
+		};
+	};
+};
+
 struct octep_hw {
 	struct pci_dev *pdev;
 	u8 __iomem *base[PCI_STD_NUM_BARS];
@@ -69,6 +88,7 @@ struct octep_hw {
 	u32 config_size;
 	int nb_irqs;
 	int *irqs;
+	u8 dev_id;
 };
 
 u8 octep_hw_get_status(struct octep_hw *oct_hw);
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index d5a599f87e18..74240101c505 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2024 Marvell. */
 
 #include <linux/iopoll.h>
+#include <linux/build_bug.h>
 
 #include "octep_vdpa.h"
 
@@ -358,7 +359,14 @@ u16 octep_get_vq_size(struct octep_hw *oct_hw)
 
 static u32 octep_get_config_size(struct octep_hw *oct_hw)
 {
-	return sizeof(struct virtio_net_config);
+	switch (oct_hw->dev_id) {
+	case VIRTIO_ID_NET:
+		return sizeof(struct virtio_net_config);
+	case VIRTIO_ID_CRYPTO:
+		return sizeof(struct virtio_crypto_config);
+	default:
+		return 0;
+	}
 }
 
 static void __iomem *octep_get_cap_addr(struct octep_hw *oct_hw, struct virtio_pci_cap *cap)
@@ -416,8 +424,25 @@ static int octep_pci_signature_verify(struct octep_hw *oct_hw)
 	return 0;
 }
 
+static void octep_vndr_data_process(struct octep_hw *oct_hw,
+				    struct octep_pci_vndr_data *vndr_data)
+{
+	BUILD_BUG_ON(sizeof(struct octep_pci_vndr_data) % 4 != 0);
+
+	switch (vndr_data->id) {
+	case OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID:
+		oct_hw->dev_id = (u8)vndr_data->data;
+		break;
+	default:
+		dev_err(&oct_hw->pdev->dev, "Invalid vendor data id %u\n",
+			vndr_data->id);
+		break;
+	}
+}
+
 int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 {
+	struct octep_pci_vndr_data vndr_data;
 	struct octep_mbox __iomem *mbox;
 	struct device *dev = &pdev->dev;
 	struct virtio_pci_cap cap;
@@ -466,6 +491,15 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 		case VIRTIO_PCI_CAP_ISR_CFG:
 			oct_hw->isr = octep_get_cap_addr(oct_hw, &cap);
 			break;
+		case VIRTIO_PCI_CAP_VENDOR_CFG:
+			octep_pci_caps_read(oct_hw, &vndr_data, sizeof(vndr_data), pos);
+			if (vndr_data.hdr.vendor_id != PCI_VENDOR_ID_CAVIUM) {
+				dev_err(dev, "Invalid vendor data\n");
+				return -EINVAL;
+			}
+
+			octep_vndr_data_process(oct_hw, &vndr_data);
+			break;
 		}
 
 		pos = cap.cap_next;
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 4d56be64ae56..f3d4dda4e04c 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -302,7 +302,9 @@ static u32 octep_vdpa_get_generation(struct vdpa_device *vdpa_dev)
 
 static u32 octep_vdpa_get_device_id(struct vdpa_device *vdpa_dev)
 {
-	return VIRTIO_ID_NET;
+	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
+
+	return oct_hw->dev_id;
 }
 
 static u32 octep_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
-- 
2.25.1

