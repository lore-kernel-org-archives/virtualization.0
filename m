Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9656152171
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606789; cv=none; b=ZGmy5FZrK/HcjXEd7xU9X3ICaiHbf0TAdJKbH7lT8SCWUCGNWaeffM2ZK6IjUxchafwfMC37SFTPg4kFuMrC/Q0/50GAm3ISgmzCDdZS823qvx+bO7NQEOaf2kHMYItAnrLxdDkLLpqla825CByTDQI1gdaCkdmNOe4RW7ZV3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606789; c=relaxed/simple;
	bh=+V92uRa8MSZRcHoBERJEONX9WxT0+AQXbOzyxhSMK/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCXr4H40gLP6lJ8Tkq96vFCAPV3xmNV/FKplWql2qonL+td19scbndj3A5GPIPl7tFefEpxK0ZFe72aXNLnPtr5o99v4EGrtJqPJmRc8oaWxbuFtEEdEhYqRLyVgNNic8np1h5GXO8idhXAwx84MCDfVk695KxGP2Q9Q5ehA1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ueey5W1v; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ueey5W1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715606787; x=1747142787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+V92uRa8MSZRcHoBERJEONX9WxT0+AQXbOzyxhSMK/4=;
  b=Ueey5W1vJNC0xzZuwlYhl2gfRytQdPHGyycSRUNcq4xc5FKIKAyDsVkw
   iz9JFl0ekSqZJ5DCoKSK/HpUgtPbT/VoquyThFZKqWFWne3NsvX1V5ZE2
   QQFMfiwh/8fSlKlN7jkqt1mhRaEa8BZtAyJdls37WmwGd+5TWFA3lmzgs
   4rtQkmdfdNkBHWCkNELGtkuCMZ9ZG7uyL8byCO5Gozk47azKQFGn2tMLB
   mCXIBptGzbYJ4tnXBQR2QnwJW7I4O7IhWnzAxff61T68LGnKAG8QTHMYx
   xgkEgWbcZyZFZtxN6aO4Emug2HLrgq4w1OLUrjgqbTSddxmX9J02TyUQi
   Q==;
X-CSE-ConnectionGUID: 2n5693bnS52jQAXpM7WEFw==
X-CSE-MsgGUID: W6DIm0z5TB6OCr/QVzceEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="29059203"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29059203"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:26:26 -0700
X-CSE-ConnectionGUID: orH42i0ATs6qs03oF7tcig==
X-CSE-MsgGUID: pG8vxveaQPSLNNv/VZBnsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30362710"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:26:24 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
Date: Tue, 14 May 2024 05:27:07 +0800
Message-ID: <20240513212707.9894-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of ifcvf code work for standard virtio pci,
except for bar4. This commit makes bar4 only effective
for Intel products, thereby turning ifcvf into
a standard virtio pci driver.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/Kconfig            |  2 +-
 drivers/vdpa/ifcvf/ifcvf_base.c | 17 ++++++++++++-----
 drivers/vdpa/ifcvf/ifcvf_main.c |  5 ++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 656c1cb541de..dbf09f35bcef 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -44,7 +44,7 @@ config VDPA_USER
 	  in a userspace program.
 
 config IFCVF
-	tristate "Intel IFC VF vDPA driver"
+	tristate "Intel IFC VF and standard virtio-pci vDPA driver"
 	depends on PCI_MSI
 	help
 	  This kernel module can drive Intel IFC VF NIC to offload
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 472daa588a9d..47bc9b11c678 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -178,7 +178,8 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
 		hw->vring[i].irq = -EINVAL;
 	}
 
-	hw->lm_cfg = hw->base[IFCVF_LM_BAR];
+	if (hw->pdev->subsystem_vendor == PCI_VENDOR_ID_INTEL)
+		hw->lm_cfg = hw->base[IFCVF_LM_BAR];
 
 	IFCVF_DBG(pdev,
 		  "PCI capability mapping: common cfg: %p, notify base: %p\n, isr cfg: %p, device cfg: %p, multiplier: %u\n",
@@ -330,18 +331,24 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
 	u16 last_avail_idx;
 
-	last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
+	if (lm_cfg) {
+		last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
+		return last_avail_idx;
+	}
 
-	return last_avail_idx;
+	return -EOPNOTSUPP;
 }
 
 int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
 {
 	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
 
-	vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
+	if (lm_cfg) {
+		vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
+		return 0;
+	}
 
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num)
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 80d0a0460885..e89fd4d96ff1 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Intel IFC VF NIC driver for virtio dataplane offloading
+ * This driver also drives standard virtio-pci hardwares
  *
  * Copyright (C) 2020 Intel Corporation.
  *
@@ -880,7 +881,9 @@ static struct pci_device_id ifcvf_pci_ids[] = {
 			 VIRTIO_TRANS_ID_BLOCK,
 			 PCI_VENDOR_ID_INTEL,
 			 VIRTIO_ID_BLOCK) },
-
+	/* standard virtio pci devices */
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET,
+		     PCI_ANY_ID) },
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, ifcvf_pci_ids);
-- 
2.43.0

