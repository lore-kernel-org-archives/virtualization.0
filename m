Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7CD273D92;
	Tue,  9 Sep 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432781; cv=none; b=ZiIh8blibOede6o0jvrT/vfp4SJFXMwvvTEHTWB3c9jBy8igGgsW8LdvBgSFo/TDKUQt6Pwa4CvhkiJ4GNJsbw4u0MdnCQMVKxyCsqVVlLbf1OCose9bAGwPKNb2lN99ZvNpZPYl8EEwCHzqDMYd76O0r5UnDl2RuflNfFUDtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432781; c=relaxed/simple;
	bh=bdxw98t8oWpFd9prYxn1eWJ4Ed4X4WhIvs+Pd5uljuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+KH5XbvaB61o8ZAuzLkAai1qtvgF9jypTuoN4InGlyuCzNn0yD3mv5Ph6CJMTgH1X2Dxdgxzk5jI36Fxy9RX/+5sWgYwz2XuMQngoWsVK8Tuqz5qa1NvtTRzx1JcMpU5zWdAtUQSCmwcAyURybDuD6zmiyw/kVMzl3zJfEsGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OKK1LSgW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OKK1LSgW"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id A707D2119CBC;
	Tue,  9 Sep 2025 08:46:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A707D2119CBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757432778;
	bh=ckUfogdIclM2WQwjKynu7mv8vRkxU0BIhhkSowxmhaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKK1LSgWFaVygev6FbU6d0p18Wl/ud7NHFrMezh++SvHZm/3InEIAss5iN9X7E73A
	 yhjVpilgqv2Fb68XoChMjnjBLxy5QuMG8vzYprrup/ICJieWXL3oS33Y8p7wgX90Nm
	 1E3frWsDXhATmv4Lng16iKu/56C4lmh6FCcvubms=
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
Subject: [PATCH v4 4/4] drivers: iommu: refactor arm_smmu_get_resv_regions
Date: Tue,  9 Sep 2025 08:46:00 -0700
Message-Id: <20250909154600.910110-5-shyamsaini@linux.microsoft.com>
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

Both ARM SMMU v2/v3 drivers have common set operations for
arm_smmu_get_resv_regions(), except iommu_dma_get_resv_regions()
call all other operations can be clubed into common code block.
So to avoid code duplication put common operations in a new helper
function iommu_set_sw_msi() and call this helper function from
arm_smmu_get_resv_regions() instead.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++-------------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 24 ++-----------
 drivers/iommu/iommu.c                       | 37 +++++++++++++++++++++
 include/linux/iommu.h                       |  6 ++++
 4 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 748a5513c5dbb..f4bcd2a8133b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3642,32 +3642,10 @@ static int arm_smmu_of_xlate(struct device *dev,
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-
-	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
-
+	/* Consider reserved regions before setting MSI IOVA */
 	iommu_dma_get_resv_regions(dev, head);
 
-	/*
-	 * Use the first msi_base that does not intersect with a platform
-	 * reserved region. The SW MSI base selection is entirely arbitrary.
-	 */
-	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
-		struct iommu_resv_region *region;
-
-		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
-			continue;
-
-		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
-						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
-		if (!region) {
-			pr_warn("IOMMU: Failed to reserve MSI IOVA: No suitable MSI IOVA range available");
-			return;
-		}
-
-		list_add_tail(&region->list, head);
-		return;
-	}
+	iommu_set_sw_msi(head);
 }
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 84b74b8519386..2ede5d7d89a93 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1600,30 +1600,10 @@ static int arm_smmu_of_xlate(struct device *dev,
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-
-	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
-
+	/* Consider reserved regions before setting MSI IOVA */
 	iommu_dma_get_resv_regions(dev, head);
 
-	/*
-	 * Use the first msi_base that does not intersect with a platform
-	 * reserved region. The SW MSI base selection is entirely arbitrary.
-	 */
-	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
-		struct iommu_resv_region *region;
-
-		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
-			continue;
-
-		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
-						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
-		if (!region)
-			return;
-
-		list_add_tail(&region->list, head);
-		return;
-	}
+	iommu_set_sw_msi(head);
 }
 
 static int arm_smmu_def_domain_type(struct device *dev)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee16..4fff01616cb5e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3829,3 +3829,40 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	return ret;
 }
 #endif /* CONFIG_IRQ_MSI_IOMMU */
+
+#if IS_ENABLED(CONFIG_IOMMU_DMA)
+/*
+ * iommu_set_sw_msi - Set up software managed MSI IOVA region
+ * @head: List of reserved IOVA regions for a device
+ *
+ * This creates a software MSI region by selecting a non-conflicting
+ * MSI_IOVA base address.
+ */
+void iommu_set_sw_msi(struct list_head *head)
+{
+	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+
+	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
+
+	/*
+	 * Use the first msi_base that does not intersect with a platform
+	 * reserved region. The SW MSI base selection is entirely arbitrary.
+	 */
+	for (int i = 0; i < ARRAY_SIZE(msi_bases); i++) {
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
+}
+#endif /* CONFIG_IOMMU_DMA */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ce9d008b91ab5..ac1708fc20ba9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1558,6 +1558,8 @@ static inline void iommu_debugfs_setup(void) {}
 #define MSI_IOVA_BASE2       0xA0000000
 #define MSI_IOVA_LENGTH      0x100000
 
+void iommu_set_sw_msi(struct list_head *head);
+
 /**
  * resv_region_intersects - Check if address range overlaps with reserved regions
  * @msi_base: Start address of the range to check
@@ -1596,6 +1598,10 @@ static inline bool resv_region_intersects(phys_addr_t msi_base, size_t length,
 {
 	return false;
 }
+
+static inline void iommu_set_sw_msi(struct list_head *head)
+{
+}
 #endif	/* CONFIG_IOMMU_DMA */
 
 /*
-- 
2.34.1

