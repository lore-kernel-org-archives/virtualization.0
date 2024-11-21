Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC91D5CCD
	for <virtualization@lists.linux.dev>; Thu, 21 Nov 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196616; cv=none; b=kYYWTqDrX1GEzBb79c1Qwa5MrLwG8H+fSJeW56siT0vHW1Ir6GSnpesHlD3xy/SsPXF1tuQgKQJYuTa00T3DKgTAIsvSJnntUXSZqHId3p0itc3LgQvSbFeRiFc/dxUk0rnHyaM6hdeXL1z8kFbLSmuCKPiCGRQZEDOkVT1uE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196616; c=relaxed/simple;
	bh=J3MquSgXO3goBTSqef77dAIkb9s9v/qO5+sStyg8YEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZFJUFTxEibzVgSwVqMmqXTMpZMQNcTC2NslwMDIeegHgBQCurek1b73/B9mDcvsAt1WMzxKiEMiuOMaZnMVG4Kv+MFYNwH9/aimBttfNfQM2Ko1vXXhJLbt7kz1EkkpaTsjeXjNPYqFbo6hM/vBxL43clihCBDBdRU9GtN1H5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KaB2rgF7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KaB2rgF7"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7ToYj011643;
	Thu, 21 Nov 2024 05:43:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	EsTuCR9/vJcvdB5Vh6WARS4L/+V6goN6WGi1f/0gwo=; b=KaB2rgF7z1Cff+peR
	cgBxDQydhSPowVD6/QNg1Fjvn4kAc36Vrz2ldWpol2+wYx8n6hnjiii7IsaKENOJ
	bmvk69kLYzeqzoGFk6wxJzusk3t9uKp+Xmu7uDeozFZM3c9QRy9HCnQ3B5atyRtf
	ZUSmCWUgfzf1CrK2gJddL76kvIzK9k5+sbpiD0vewJBED/xK5N50GY2RcAoJAkLW
	u4Yx8muxWV0Xnkqqh2MTUvzjCU45RsYkAE1djcVWjzjz3XGnQJzRvwbcrQA1o3jg
	8/a/71KNq31iYGq+0sjgXyQnTkq2EjNCdVBXtqy7FBf4I3Z0VYfjWuTF4kz6nJMS
	ejigQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4320h5gk46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:43:30 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 21 Nov 2024 05:43:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 21 Nov 2024 05:43:29 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 7E0193F7068;
	Thu, 21 Nov 2024 05:43:25 -0800 (PST)
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
Subject: [PATCH v2 3/4] vdpa/octeon_ep: read vendor-specific PCI capability
Date: Thu, 21 Nov 2024 19:09:45 +0530
Message-ID: <20241121134002.990285-3-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121134002.990285-1-sthotton@marvell.com>
References: <20241121134002.990285-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: J5f19QGnt2FopcTDGrXtYNQVP0bT73on
X-Proofpoint-ORIG-GUID: J5f19QGnt2FopcTDGrXtYNQVP0bT73on
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Added support to read the vendor-specific PCI capability to identify the
type of device being emulated.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa.h      | 24 +++++++++++++++++
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 34 +++++++++++++++++++++++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep/octep_vdpa.h
index 2d4bb07f91b3..0f83a1eca408 100644
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
@@ -52,6 +53,28 @@ struct octep_vring_info {
 	phys_addr_t notify_pa;
 };
 
+enum octep_pci_vndr_cfg_type {
+	OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
+	OCTEP_PCI_VNDR_CFG_TYPE_MAX,
+};
+
+struct octep_pci_vndr_data {
+	u8 cap_vndr;
+	u8 cap_next;
+	u8 cap_len;
+	u8 cfg_type;
+	u16 vendor_id;
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
@@ -69,6 +92,7 @@ struct octep_hw {
 	u32 config_size;
 	int nb_irqs;
 	int *irqs;
+	u8 dev_id;
 };
 
 u8 octep_hw_get_status(struct octep_hw *oct_hw);
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index d5a599f87e18..2f4849e90525 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -358,7 +358,14 @@ u16 octep_get_vq_size(struct octep_hw *oct_hw)
 
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
@@ -416,8 +423,24 @@ static int octep_pci_signature_verify(struct octep_hw *oct_hw)
 	return 0;
 }
 
+static void octep_vndr_data_process(struct octep_hw *oct_hw,
+				    struct octep_pci_vndr_data *vndr_data)
+{
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
+#define VIRTIO_PCI_CAP_VENDOR_CFG	9
 int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 {
+	struct octep_pci_vndr_data vndr_data;
 	struct octep_mbox __iomem *mbox;
 	struct device *dev = &pdev->dev;
 	struct virtio_pci_cap cap;
@@ -466,6 +489,15 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 		case VIRTIO_PCI_CAP_ISR_CFG:
 			oct_hw->isr = octep_get_cap_addr(oct_hw, &cap);
 			break;
+		case VIRTIO_PCI_CAP_VENDOR_CFG:
+			octep_pci_caps_read(oct_hw, &vndr_data, sizeof(vndr_data), pos);
+			if (vndr_data.vendor_id != PCI_VENDOR_ID_CAVIUM) {
+				dev_err(dev, "Invalid vendor data\n");
+				return -EINVAL;
+			}
+
+			octep_vndr_data_process(oct_hw, &vndr_data);
+			break;
 		}
 
 		pos = cap.cap_next;
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index b060df57bb59..d674b9678428 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -305,7 +305,9 @@ static u32 octep_vdpa_get_generation(struct vdpa_device *vdpa_dev)
 
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

