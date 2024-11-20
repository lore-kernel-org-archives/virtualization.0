Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF115D5C4
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086425; cv=none; b=gn74F0nUgtq95Qwz/1sxbTfqngE74M4bT0keBlepzQWM3b9RmG8Ml/rEvJyypLhZDTsjpsUEHQ0AE3db1WjQpCB6KOKC/XKK8ARPxVEbrtfvPUWSLtwfO+P2shzoXdE8+/DnNzBsxcxKf+BvGaGsn1O8CFRaiSb/YSAQIBa7rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086425; c=relaxed/simple;
	bh=EYqbllBTczmbuly7eq2Wh7cO7+VtURTO3vZWQxPU2Ek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olsJnTpXBaZnw9NpNBPZu0CIiM7Kd49/WTU2htF9O/5s0neTBG9fEYnQ0w2yRN8MupF67X7sodu2WUA5pIpgK4I2amUToOjdAhIvjDa8heiznp1AMpAabK8uSo7T9Np4GQe2uGvFQADr1tVcJHU0VTEYL70eoSVxX4gNTBP7mzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ve2jjXv9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ve2jjXv9"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK5ctQ6021598;
	Tue, 19 Nov 2024 23:06:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	Oavwka8Lpk9C907JDJzN+p6c8e5jRlSdr/DInmgAGA=; b=Ve2jjXv9vxzG4Vvw3
	jGNqtU+3nJ/WgT8bJZClRn5SLvi9syHZzwJ1kwTVY6syD29rHGpzTIdU8JGWiIyI
	ynS08+9OhcD/ROMNLtRNs9GUxHQhUIaZLQ5KlZXymkvZkbsBj7oa72nHqJfnt9yv
	y0C3sRJli+3eh7+YR5LuBOkAhy3VYz5WN3KaH7LToz6vPI+rBmtAwmYgst/O0yek
	FBZahnmoZN59BKWUEZNA4arlPGX9PAhtEl312iqF9hTdKdHXSkZn3B9ITtp3/vvE
	Vj1qZ8Pk6sBFJyYjMTGWe5tq6j6XwW+uHfPxRCErfmhizwKo90QS41JQOOAVjMMz
	J9bjg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4307t24ew2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:06:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 19 Nov 2024 23:06:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 19 Nov 2024 23:06:57 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 7E9E73F7060;
	Tue, 19 Nov 2024 23:06:53 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Satha Rao
	<skoteshwar@marvell.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] vdpa/octeon_ep: read vendor-specific PCI capability
Date: Wed, 20 Nov 2024 12:34:52 +0530
Message-ID: <20241120070508.789508-3-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120070508.789508-1-sthotton@marvell.com>
References: <20241120070508.789508-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: m-nvjNbe2LXdo0Cxlh8abJZWiJEGUd_r
X-Proofpoint-ORIG-GUID: m-nvjNbe2LXdo0Cxlh8abJZWiJEGUd_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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
index 6db951c6cb92..6ead42d76415 100644
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

