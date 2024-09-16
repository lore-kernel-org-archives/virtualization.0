Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6576158A3D
	for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503790; cv=none; b=eppgeJikRCPasNkk5e8D849Ql1uYawWUFIaHvw+ZnWOcprKXV/qKHzhdtW/g6HoKPijBcqcJ9a32vcX4syKNG7k89GGYIGPCtglrdHBxVgs1iAZYJ7X82ErPO7V4o59VFVsG/7G6OiO32SWhmiROhjfhWcmhFgt47GvbjvgiVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503790; c=relaxed/simple;
	bh=tVF1Q5SvVZbPDST8DWieFMbM15Ex+gYnW73EAqVeXIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cgM2NXx+e7fCwJokFQlvuSgBexvijbgnW2JVJUBZ3Lo7Tf7R7KdX6coBZqPfNdCE+UnFCo6xWWWkwM24047F05d8x6G15WZq8nUM/bTPttfH3z9RuLra0NpD4XtR47VB8zYQnzJxe72hUfOIFgAoHPgoTlvtHyM0+iPa7ibBklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WA4KqVp1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WA4KqVp1"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GECk62019832;
	Mon, 16 Sep 2024 09:23:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=lkm1CtUwfTMolZBQbb3jxTt
	d4XNcuSVpEGN+gutGcMc=; b=WA4KqVp1+TOd6nMZKBmKYvBQSyCyfaEAxMhLeyx
	2njB3KiS5J3sCYy4Uc/ebIOo3EkIRBW6aIMMJ+g74HmMKQom4423Ug5s4LyYlKqh
	ikc2RX8TPVmtYS6aQQ7V7wsznZwUFnrUHZ7BUraAvSVa8kEyoZ80u7EBjXP5JsMI
	Oz1M5H/i34AT2C0GNWd/2nE7jjF4BpsJBJyF01GKyGy2YH+HiCOqZe+sWSIB69bg
	b+QcD4wlJR25Ua8BGSpXF69MfWTcnUxC9VO+075g8XuY4geClDqIvSrVmRIby+4D
	+U2wrDu+7TORtGKiS6H5Psvy1j8AD0vzAPVPjOWAfETUcvg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41n7ujpmam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 09:23:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Sep 2024 09:22:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Sep 2024 09:22:59 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 541BE3F7070;
	Mon, 16 Sep 2024 09:22:56 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <dan.carpenter@linaro.org>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <ndabilpuram@marvell.com>, <vattunuru@marvell.com>,
        <schalla@marvell.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] vdpa/octeon_ep: Fix format specifier for pointers in debug messages
Date: Mon, 16 Sep 2024 21:52:55 +0530
Message-ID: <20240916162255.677774-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oAELk7ufluyO9yzXNjy5LHDay1fU0wPb
X-Proofpoint-ORIG-GUID: oAELk7ufluyO9yzXNjy5LHDay1fU0wPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Updates the debug messages in octep_vdpa_hw.c to use the %p format
specifier for pointers instead of casting them to u64.

Fixes smatch warning:
octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast
from pointer

Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes:https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_202409160431.bRhZWhiU-2Dlkp-40intel.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Fj4OoD5hcKFpANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=qyhlWh2lFE3SPFpB_eJ0K1RFMa5f-kcNChFHkCARDCXIkzMk__3sqspP_K7KGxaj&s=fMvS62XMmi5HESJuL9v7FX3c8RSzKCq7JM6Khcof4vM&e=
Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index 11bd76ae18cf..1d4767b33315 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -475,11 +475,11 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 		dev_err(dev, "Incomplete PCI capabilities");
 		return -EIO;
 	}
-	dev_info(dev, "common cfg mapped at: 0x%016llx\n", (u64)(uintptr_t)oct_hw->common_cfg);
-	dev_info(dev, "device cfg mapped at: 0x%016llx\n", (u64)(uintptr_t)oct_hw->dev_cfg);
-	dev_info(dev, "isr cfg mapped at: 0x%016llx\n", (u64)(uintptr_t)oct_hw->isr);
-	dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\n",
-		 (u64)(uintptr_t)oct_hw->notify_base, oct_hw->notify_off_multiplier);
+	dev_info(dev, "common cfg mapped at: %p\n", oct_hw->common_cfg);
+	dev_info(dev, "device cfg mapped at: %p\n", oct_hw->dev_cfg);
+	dev_info(dev, "isr cfg mapped at: %p\n", oct_hw->isr);
+	dev_info(dev, "notify base: %p, notify off multiplier: %u\n",
+		 oct_hw->notify_base, oct_hw->notify_off_multiplier);
 
 	oct_hw->config_size = octep_get_config_size(oct_hw);
 	oct_hw->features = octep_hw_get_dev_features(oct_hw);
@@ -511,7 +511,7 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 	}
 	mbox = octep_get_mbox(oct_hw);
 	octep_mbox_init(mbox);
-	dev_info(dev, "mbox mapped at: 0x%016llx\n", (u64)(uintptr_t)mbox);
+	dev_info(dev, "mbox mapped at: %p\n", mbox);
 
 	return 0;
 }
-- 
2.25.1

