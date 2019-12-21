From: Tom Murphy <murphyt7@tcd.ie>
Subject: [PATCH 1/8] iommu/vt-d: clean up 32bit si_domain assignment
Date: Sat, 21 Dec 2019 15:03:53 +0000
Message-ID: <20191221150402.13868-2-murphyt7__34342.9381422297$1576941153$gmane$org@tcd.ie>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191221150402.13868-1-murphyt7@tcd.ie>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Eric
List-Id: virtualization@lists.linuxfoundation.org

In the intel iommu driver devices which only support 32bit DMA can't be
direct mapped. The implementation of this is weird. Currently we assign
it a direct mapped domain and then remove the domain later and replace
it with a domain of type IOMMU_DOMAIN_IDENTITY. We should just assign it
a domain of type IOMMU_DOMAIN_IDENTITY from the begging rather than
needlessly swapping domains.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/intel-iommu.c | 88 +++++++++++++------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..c1ea66467918 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3462,46 +3462,9 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 }
 
 /* Check if the dev needs to go through non-identity map and unmap process.*/
-static bool iommu_need_mapping(struct device *dev)
+static bool iommu_no_mapping(struct device *dev)
 {
-	int ret;
-
-	if (iommu_dummy(dev))
-		return false;
-
-	ret = identity_mapping(dev);
-	if (ret) {
-		u64 dma_mask = *dev->dma_mask;
-
-		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
-			dma_mask = dev->coherent_dma_mask;
-
-		if (dma_mask >= dma_direct_get_required_mask(dev))
-			return false;
-
-		/*
-		 * 32 bit DMA is removed from si_domain and fall back to
-		 * non-identity mapping.
-		 */
-		dmar_remove_one_dev_info(dev);
-		ret = iommu_request_dma_domain_for_dev(dev);
-		if (ret) {
-			struct iommu_domain *domain;
-			struct dmar_domain *dmar_domain;
-
-			domain = iommu_get_domain_for_dev(dev);
-			if (domain) {
-				dmar_domain = to_dmar_domain(domain);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-			}
-			dmar_remove_one_dev_info(dev);
-			get_private_domain_for_dev(dev);
-		}
-
-		dev_info(dev, "32bit DMA uses non-identity mapping\n");
-	}
-
-	return true;
+	return iommu_dummy(dev) || identity_mapping(dev);
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
@@ -3568,20 +3531,22 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, page_to_phys(page) + offset,
-				size, dir, *dev->dma_mask);
-	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	if (iommu_no_mapping(dev))
+		return dma_direct_map_page(dev, page, offset, size, dir, attrs);
+
+	return __intel_map_single(dev, page_to_phys(page) + offset, size, dir,
+			*dev->dma_mask);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, phys_addr, size, dir,
-				*dev->dma_mask);
-	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
+	if (iommu_no_mapping(dev))
+		return dma_direct_map_resource(dev, phys_addr, size, dir,
+				attrs);
+
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3632,16 +3597,16 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
-	else
+	if (iommu_no_mapping(dev))
 		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
+	else
+		intel_unmap(dev, dev_addr, size);
 }
 
 static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
+	if (!iommu_no_mapping(dev))
 		intel_unmap(dev, dev_addr, size);
 }
 
@@ -3652,7 +3617,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
-	if (!iommu_need_mapping(dev))
+	if (iommu_no_mapping(dev))
 		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
 
 	size = PAGE_ALIGN(size);
@@ -3688,7 +3653,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
-	if (!iommu_need_mapping(dev))
+	if (iommu_no_mapping(dev))
 		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
 
 	size = PAGE_ALIGN(size);
@@ -3708,7 +3673,7 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 	int i;
 
-	if (!iommu_need_mapping(dev))
+	if (iommu_no_mapping(dev))
 		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
 
 	for_each_sg(sglist, sg, nelems, i) {
@@ -3734,7 +3699,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (!iommu_need_mapping(dev))
+	if (iommu_no_mapping(dev))
 		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
 	domain = deferred_attach_domain(dev);
@@ -3782,7 +3747,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 static u64 intel_get_required_mask(struct device *dev)
 {
-	if (!iommu_need_mapping(dev))
+	if (iommu_no_mapping(dev))
 		return dma_direct_get_required_mask(dev);
 	return DMA_BIT_MASK(32);
 }
@@ -5618,9 +5583,13 @@ static int intel_iommu_add_device(struct device *dev)
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
+	u64 dma_mask = *dev->dma_mask;
 	u8 bus, devfn;
 	int ret;
 
+	if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
+		dma_mask = dev->coherent_dma_mask;
+
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
@@ -5640,7 +5609,12 @@ static int intel_iommu_add_device(struct device *dev)
 	domain = iommu_get_domain_for_dev(dev);
 	dmar_domain = to_dmar_domain(domain);
 	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
+		/*
+		 * We check dma_mask >= dma_get_required_mask(dev) because
+		 * 32 bit DMA falls back to non-identity mapping.
+		 */
+		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY &&
+				dma_mask >= dma_get_required_mask(dev)) {
 			ret = iommu_request_dm_for_dev(dev);
 			if (ret) {
 				dmar_remove_one_dev_info(dev);
-- 
2.20.1
