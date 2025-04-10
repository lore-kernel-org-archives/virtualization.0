Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9683B20E003;
	Thu, 10 Apr 2025 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325438; cv=none; b=a1XFK9ttBm0Jvvbuo7yqmyJslewmZ+zISFlCmRT1zEyq9Dxjz+tyqh2D1f+wTR9SZOZnlokn7UG5Tru2tjdjkEKxKlVesohgr+YHjk7advitEHorZ384NDxm3MVzxIEX9wNQ0RhQ3WB1iS/bc5YdmUQcHDIF8mrjHmvpZskcC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325438; c=relaxed/simple;
	bh=eSBlGwPbxQvzEQ0qxyvz9CCsszI2g7B7f9NKVWogNSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TUXZs80UbGwlOhwgkg+pCSs3ZqxRSS1voBEfNCjbtaxt6BArBYpSuFQAnJt86ImOcyI6Tn/eYoNlJXLUClwLCnUqg5Ti57xs0cvDgZoGAH1VKyxSCrGjuYhV+Sb+9HjhPY2q/YJQsgPN0qarkB54aL9xhLwSuJ1rTSfDqncpaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ar5iCyWv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ar5iCyWv"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 05FEA2114DAE;
	Thu, 10 Apr 2025 15:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05FEA2114DAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744325436;
	bh=7gtu6nH7srNfvTtxxwiTNF8qbQE3fc+/uSVqmjie7Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ar5iCyWv/QVBsLCCJFSqIY3ZHBZI2x61i2WxVHZ+lvnVMCy4vq9FKsvvgBAk1HT+w
	 +1lEETI/HuA8bD6AKBf336epHfsi/fLw4wlM4JmFUPXenfHseNInTSdc2qXD8jtqWu
	 oQvtuf6RkBkC45BRU/ZEVTKkKllPMqYn0zbkRTSA=
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
Subject: [PATCH v2 3/3] arm-smmu: select suitable MSI IOVA
Date: Thu, 10 Apr 2025 15:50:30 -0700
Message-Id: <20250410225030.2528385-4-shyamsaini@linux.microsoft.com>
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

Currently ARM SMMU drivers hardcode PCI MSI IOVA address.
Not all the platform have same memory mappings and some platform
could have this address already being mapped for something else.
This can lead to collision and as a consequence the MSI IOVA addr
range is never reserved.

Fix this by adding one more MSI_IOVA base address, so that if the
platforms can select suitable PCI MSI IOVA address if SMMU dts node
has "arm,smmu-faulty-msi-iova".

If this property is not found in the dtb for the given platform then
the driver falls back on the default MSI IOVA address.

Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  9 +++-
 include/linux/iommu.h                       | 49 +++++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..d6ea82ed4530 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -33,6 +33,8 @@
 #include "arm-smmu-v3.h"
 #include "../../dma-iommu.h"
 
+u32 msi_iova_base;
+
 static bool disable_msipolling;
 module_param(disable_msipolling, bool, 0444);
 MODULE_PARM_DESC(disable_msipolling,
@@ -3541,8 +3543,8 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH, prot,
+					 IOMMU_RESV_SW_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 
@@ -4570,6 +4572,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	u32 cells;
 	int ret = -EINVAL;
+	u32 msi_iova_ptr;
+
+	iommu_configure_msi_iova(dev, "arm,smmu-faulty-msi-iova", msi_iova_ptr);
 
 	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
 		dev_err(dev, "missing #iommu-cells property\n");
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index a54dc4608c62..cd8bf2278057 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -50,6 +50,8 @@
  */
 #define QCOM_DUMMY_VAL -1
 
+u32 msi_iova_base;
+
 static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
@@ -1594,8 +1596,8 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH, prot,
+					 IOMMU_RESV_SW_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 
@@ -2030,6 +2032,9 @@ static int arm_smmu_device_dt_probe(struct arm_smmu_device *smmu,
 	const struct arm_smmu_match_data *data;
 	struct device *dev = smmu->dev;
 	bool legacy_binding;
+	u32 *msi_iova_ptr = &msi_iova_base;
+
+	iommu_configure_msi_iova(dev, "arm,smmu-faulty-msi-iova", msi_iova_ptr);
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts", global_irqs))
 		return dev_err_probe(dev, -ENODEV,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8d38d85f23f1..cfd047fdf225 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1531,10 +1531,59 @@ static inline void iommu_debugfs_setup(void) {}
 
 #ifdef CONFIG_IOMMU_DMA
 #define MSI_IOVA_BASE        0x8000000
+#define MSI_IOVA_BASE2       0xa0000000
 #define MSI_IOVA_LENGTH      0x100000
 
+static inline u32 select_msi_iova_base(u32 erratic_iova_addr)
+{
+	phys_addr_t start, end, msi_iova_end;
+
+	if (!erratic_iova_addr)
+		return MSI_IOVA_BASE;
+
+	start = erratic_iova_addr;
+	end = start + MSI_IOVA_LENGTH - 1;
+	msi_iova_end = MSI_IOVA_BASE + MSI_IOVA_LENGTH - 1;
+
+	/* return non-overlapping address */
+	return (start > MSI_IOVA_BASE ||
+			end < msi_iova_end) ? MSI_IOVA_BASE : MSI_IOVA_BASE2;
+}
+
+static inline void iommu_configure_msi_iova(struct device *iommu_dev,
+					    const char *faulty_msi_iova_prop,
+					    u32 *msi_iova)
+{
+	static bool is_msi_iova_selected;
+	u32 faulty_msi_iova_from_dt;
+	int rc;
+
+	rc = of_property_read_u32(iommu_dev->of_node, faulty_msi_iova_prop,
+				  &faulty_msi_iova_from_dt);
+	if (!is_msi_iova_selected) {
+		*msi_iova = select_msi_iova_base(rc ? 0 : faulty_msi_iova_from_dt);
+		dev_dbg(iommu_dev, "setting custom MSI IOVA base to 0x%x\n", *msi_iova);
+		is_msi_iova_selected = true;
+		return;
+	}
+
+	dev_dbg(iommu_dev, "custom MSI IOVA base already set to 0x%x\n", *msi_iova);
+}
+
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 #else /* CONFIG_IOMMU_DMA */
+
+static inline u32 select_msi_iova_base(u32 erratic_iova_addr)
+{
+}
+
+static inline void iommu_configure_msi_iova(struct device *iommu_dev,
+					    const char *faulty_msi_iova_prop,
+					    u32 *msi_iova)
+{
+}
+
+
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	return -ENODEV;
-- 
2.34.1

