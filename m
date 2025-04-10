Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61F220C48A;
	Thu, 10 Apr 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325437; cv=none; b=tuATAb1ZWAEl8s7K7tJeJ5qiVEiukRbIShMRBQdn1VyskmA4At//EVS+kCWIznG4nBJMqbLxyPMxPVnwds2DELqXX4Dkj3Ym749GfTnaFrhrzsghQXNOBzelKcUtsUea2w86n0raweYiRgC1lvM+xYbamkvRd52Cjot/BJxVEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325437; c=relaxed/simple;
	bh=CBdTJmPBun5OEYVsdZNF2eFfa6jm60LO5DNKx35/6Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSsk93mxhzlX4YquVGi000Nfj8Oqcah4epe6UviJQOd2gmwxYy4nRUJ0JKb5hfqRKW1TIwpiBiWWhugCF0GBY6KUiQ7AJ3Cl61cniq5l5NsNhUClcMPE5OFGUFLrugGGbdAcgqhiWgMQJyJNKsn8ugfmmJHAEhpjkZb/0GCipdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ouD2J1M6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ouD2J1M6"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 470912114DAC;
	Thu, 10 Apr 2025 15:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 470912114DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744325435;
	bh=1L/lBwFs+AoYXX7M34lWjEC0yx+AYdjFCcZZm+bO1mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouD2J1M6Syc04G0BdVTKC6Tw5VlDo00LLQq/BPfc84OcOz77peQdCCw8Zqxt+neSn
	 ABkg8kpYvzqIIkB0YtJe/KN823X2z7FYOJRUkv6fcU6UMSZ509smgkZkpOCGIt66tU
	 ZD4JhUiztiVVO9ZcLBHA74sry1k76aapLHDrwEzQ=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: jgg@ziepe.ca,
	will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH v2 1/3] arm-smmu: move MSI_IOVA macro definitions
Date: Thu, 10 Apr 2025 15:50:28 -0700
Message-Id: <20250410225030.2528385-2-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSI_IOVA* are common among different iommu/smu drivers,
so move them to common iommu.h header file.

Suggested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ---
 drivers/iommu/virtio-iommu.c                | 2 --
 include/linux/iommu.h                       | 3 +++
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..d1713f6bbe6d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -502,9 +502,6 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
 #define ARM_SMMU_POLL_SPIN_COUNT	10
 
-#define MSI_IOVA_BASE			0x8000000
-#define MSI_IOVA_LENGTH			0x100000
-
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8f439c265a23..a54dc4608c62 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -50,9 +50,6 @@
  */
 #define QCOM_DUMMY_VAL -1
 
-#define MSI_IOVA_BASE			0x8000000
-#define MSI_IOVA_LENGTH			0x100000
-
 static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b85ce6310ddb..8c8783c8b31b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -24,8 +24,6 @@
 
 #include "dma-iommu.h"
 
-#define MSI_IOVA_BASE			0x8000000
-#define MSI_IOVA_LENGTH			0x100000
 
 #define VIOMMU_REQUEST_VQ		0
 #define VIOMMU_EVENT_VQ			1
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cf8c16ba04a0..8d38d85f23f1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1530,6 +1530,9 @@ static inline void iommu_debugfs_setup(void) {}
 #endif
 
 #ifdef CONFIG_IOMMU_DMA
+#define MSI_IOVA_BASE        0x8000000
+#define MSI_IOVA_LENGTH      0x100000
+
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
-- 
2.34.1

