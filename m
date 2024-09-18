Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC431CD23
	for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662475; cv=none; b=OAECrIzWqOVlc8GAFy/6P62D9sdZjcdM4F8k2oPGXK2XhT41rqsZhHMdrb97lNQwuEJdUrw0wd7FYgtKegM8pU2nyuXmpkrSbTyNcFOx57PPhsFwLrHRU1ExMo1C/qiORVtClpqBJv2U/oGPa5SajoqsaHoBWFpRrhxSdNoJRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662475; c=relaxed/simple;
	bh=wpwm09Y75NWUu2XBMTuj7m83rpGex0TIuLUGK00DIh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UwlTm/rG/bAn1hdTUI8lP1vlz/+xqhZyTgVIfcosVr8b4V526Dn1Hc3FURyUXv6nvB6KKYfEfbURX853gAF+5irc3lfjQ9fM7WOZcvtCBbPiZBMyOhMzJXqyDwaAUVOrn6puFXDFxvzMlqAW9yQiZralVH0RhT58iRYBBYr0+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aygieNtZ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aygieNtZ"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I5VEOT017863;
	Wed, 18 Sep 2024 05:27:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=tA5DM9GxmXku6bVJXR4b9py
	rAEx82SWk6tSAss9+Q7g=; b=aygieNtZnfq/9LWLf5L/gXw3NmJwN9svKegkocw
	4lLFcIHfEXilwtV+1SPk7W4ED9Ks0fYYfX0hrBKlyBHKgp0WL+gIWksJjALq4GCH
	6Idt9PYo6V5N42Fr3cC/CQj09P0hsQz1jjC06Pui+UgqPAEzw0aeZgopS6FWxrji
	N0DYHGWJ4asLTdhB5CzLhZ0Vque2OcqVQRotvPdZ0Dp3ez92QlsOnmf3hihcdR+D
	KaYPP5UewRXd+5Y7+SFDrPDMZhiD1uD/6ZOtDXgodJ+RwUNuI4j2LpXgCnroYos9
	0jJcl6g5cu3g/+ml9bSdYGQxD1LL8B/9h7RlTGoLew016iw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41qdwgbwvv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 05:27:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Sep 2024 05:27:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Sep 2024 05:27:35 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id E21233F704D;
	Wed, 18 Sep 2024 05:27:31 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <dan.carpenter@linaro.org>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <ndabilpuram@marvell.com>, <vattunuru@marvell.com>,
        <schalla@marvell.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] vdpa/octeon_ep: Fix format specifier for pointers in debug messages
Date: Wed, 18 Sep 2024 17:57:30 +0530
Message-ID: <20240918122730.703319-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BE160Qpihcgpv1jo5WnZXKV43nOQtlt7
X-Proofpoint-ORIG-GUID: BE160Qpihcgpv1jo5WnZXKV43nOQtlt7
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
Closes:https://lore.kernel.org/r/202409160431.bRhZWhiU-lkp@intel.com/
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

