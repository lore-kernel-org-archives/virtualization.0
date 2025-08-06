Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97B22FF35;
	Wed,  6 Aug 2025 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517352; cv=none; b=hLbgk41oR5RHZaSAGzUy0pYtmuK7e2QuzJT+abVmm3GQQ9IXOyEFH38AXBfgr7HePmyWFU6snTgfwKtdlQEJDXgHW2Ol5qqqC5I+AX56K8GRqGpG0fOTkAB7nAmq+Tr5CMQxQd4VMCGR3t7JDuq/YK45HZ8J1/ClPleejgaa8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517352; c=relaxed/simple;
	bh=+pGZ975IxNxnr1V+i1tGkKgf9TG50k9YbqtnSjkg4/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EgsbVYYN4470XI7AsnWkHkoHSHYhqKTBpbIWhN5Fs0ZuPx49c3ZotWSSwI7xM5MeTcT73oI87GdM1kvP6S0Z5X861jflyEGaIfNKbLqrSYmFipTD0CXx9UgWBt0g2RKJiIaK3iV6kz5DNPh89cQAn74hefkXInVZJj5sj9cndtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nY3Trcvs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nY3Trcvs"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB4B7201BC85;
	Wed,  6 Aug 2025 14:55:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB4B7201BC85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754517350;
	bh=CZfnUWwxdxJN9955pgQFuv1T6J84459tvn2v5OJo7mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nY3Trcvs//X2Tf79PjOTOC2zzQiT48wYcGdOOJR66n9wdprAOc7jUohX6jkfsNMBT
	 u1xaaRzXmn7yO5VRXXvmvJbCkKTh/lOJPgrTpUzcpFg23rm2r6gC5bceLtPHokRw5t
	 3l8aS0kmSExWgR4JviCBxlPhDhWg/tCeYqqcU7qY=
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
	vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: [PATCH v3 3/3] arm-smmu: select suitable MSI IOVA
Date: Wed,  6 Aug 2025 14:55:39 -0700
Message-Id: <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **

Currently ARM SMMU drivers hardcode PCI MSI IOVA address.
Not all the platform have same memory mappings and some platform
could have this address already being mapped for something else.
This can lead to collision and as a consequence the MSI IOVA addr
range is never reserved.

Fix this by reserving faulty IOVA range and selecting alternate MSI_IOVA
suitable for the intended platform.

Example of reserving faulty IOVA range for PCIE device in the DTS:

reserved-memory {
	#address-cells = <2>;
	#size-cells = <2>;
	faulty_iova: resv_faulty {
		iommu-addresses = <&pcieX 0x0 0x8000000 0x0 0x100000>;
	};
};

&pcieX {
	memory-region = <&faulty_iova>;
};

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Link: https://lore.kernel.org/linux-iommu/20250416181759.GF493866@ziepe.ca/
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++++++++++------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 27 +++++++++++++++------
 include/linux/iommu.h                       | 25 +++++++++++++++++++
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5f46140a8f3fa..0dfb522e173f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3642,17 +3642,30 @@ static int arm_smmu_of_xlate(struct device *dev,
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
-	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
-	if (!region)
-		return;
-
-	list_add_tail(&region->list, head);
+	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
 
 	iommu_dma_get_resv_regions(dev, head);
+
+	/*
+	 * Use the first msi_base that does not intersect with a platform
+	 * reserved region. The SW MSI base selection is entirely arbitrary.
+	 */
+	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
+		struct iommu_resv_region *region;
+
+		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
+			continue;
+
+		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
+						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+		return;
+	}
 }
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4a07650911991..84b74b8519386 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1600,17 +1600,30 @@ static int arm_smmu_of_xlate(struct device *dev,
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
-	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
-	if (!region)
-		return;
-
-	list_add_tail(&region->list, head);
+	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
 
 	iommu_dma_get_resv_regions(dev, head);
+
+	/*
+	 * Use the first msi_base that does not intersect with a platform
+	 * reserved region. The SW MSI base selection is entirely arbitrary.
+	 */
+	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
+		struct iommu_resv_region *region;
+
+		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
+			continue;
+
+		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
+						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+		return;
+	}
 }
 
 static int arm_smmu_def_domain_type(struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 517f908296436..6750ecdebaa94 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1509,14 +1509,39 @@ static inline void iommu_debugfs_setup(void) {}
 
 #ifdef CONFIG_IOMMU_DMA
 #define MSI_IOVA_BASE        0x8000000
+#define MSI_IOVA_BASE2       0xA0000000
 #define MSI_IOVA_LENGTH      0x100000
 
+static inline bool resv_region_intersects(phys_addr_t msi_base, size_t length,
+					  struct list_head *resv_region_list)
+{
+	struct iommu_resv_region *region;
+	phys_addr_t start, end, resv_region_end;
+
+	start = msi_base;
+	end = start + length - 1;
+	list_for_each_entry(region, resv_region_list, list) {
+		resv_region_end = region->start + region->length - 1;
+		/* overlap detected */
+		if (!(start > resv_region_end || end < region->start))
+			return true;
+	}
+
+	return false;
+}
+
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	return -ENODEV;
 }
+
+static inline bool resv_region_intersects(phys_addr_t msi_base, size_t length,
+					  struct list_head *resv_region_list)
+{
+	return false;
+}
 #endif	/* CONFIG_IOMMU_DMA */
 
 /*
-- 
2.34.1

