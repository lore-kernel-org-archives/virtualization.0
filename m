Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03AB32CF95;
	Tue,  9 Sep 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432779; cv=none; b=OpVQJiQXrdA1ca2peGi8NSzP43PzwJ95aO3WTWSy3HRIaH9W02LjifuXR5yiuX/z0nNgJi6WNhWhZd9ljWTxx6zegkr8dU2EMk+9j8jO+JAqrsjW0736vKMudErrCLY+q8ndESQZFU7vvDrCpXtCG9UR+2yKe8nNmhXot/IJf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432779; c=relaxed/simple;
	bh=zUy6jdsdD5eSUkvYKqI1Ab9G4bt7JG4FtZru4nWKqiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhHJGmMc4N5s1xXcRQ29bnpVa/WdABbX/t06cbri2yZRCb5Qv3YGNwLOT38/9vI8GnYuLH3FsqMeyHR+LZvQm972AiNiVtnZTTT7NygcIoTEmpTngi1dytBpjqln/1tf9r5a62FimUQJJjeZgr/hoLz2GEaCmM1Ge+d6Hd+CNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=riPcMkGm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="riPcMkGm"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id BCCED211AA16;
	Tue,  9 Sep 2025 08:46:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCCED211AA16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757432777;
	bh=UdoRsdyMOTc78Cd0P0GNhrsNzfijvHUwfMWwZIaDyhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=riPcMkGm7Y+xm/7Zw0tmJOhg8wD9aaspyoNh0mYXzJjK/REhS5AujSJzTaJzpkehj
	 scTYvMEzxaGeuYGPYrjlEMa3MtONhhgRSB5qVnI/yWton0n4S6yMn3EMOzWk7AuQVX
	 UJDIv29/71y7WSs9lEMabiGfF+UBYiLH979bYW5A=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: thierry.reding@gmail.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	joro@8bytes.org,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com,
	saravanak@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lizhi.hou@amd.com,
	clement.leger@bootlin.com
Subject: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
Date: Tue,  9 Sep 2025 08:45:59 -0700
Message-Id: <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
}

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 27 ++++++++++++-----
 include/linux/iommu.h                       | 33 +++++++++++++++++++++
 3 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f05..748a5513c5dbb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3642,17 +3642,32 @@ static int arm_smmu_of_xlate(struct device *dev,
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
+		if (!region) {
+			pr_warn("IOMMU: Failed to reserve MSI IOVA: No suitable MSI IOVA range available");
+			return;
+		}
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
index 09a35af5a545d..ce9d008b91ab5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1555,14 +1555,47 @@ static inline void iommu_debugfs_setup(void) {}
 
 #ifdef CONFIG_IOMMU_DMA
 #define MSI_IOVA_BASE        0x8000000
+#define MSI_IOVA_BASE2       0xA0000000
 #define MSI_IOVA_LENGTH      0x100000
 
+/**
+ * resv_region_intersects - Check if address range overlaps with reserved regions
+ * @msi_base: Start address of the range to check
+ * @length: Length of the range to check
+ * @resv_region_list: List of reserved regions to check against
+ *
+ * Returns true if the specified address range overlaps with any reserved region
+ * in the list, false otherwise.
+ */
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
+		if (!(start > resv_region_end || end < region->start))
+			return true; /* overlap detected */
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

