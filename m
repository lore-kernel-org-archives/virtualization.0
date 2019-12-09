From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 1/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Mon,  9 Dec 2019 15:50:03 +0100
Message-ID: <20191209145007.2433144-2-thierry.reding__33419.0161478304$1575903039$gmane$org@gmail.com>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

From: Thierry Reding <treding@nvidia.com>

Implement a generic function for removing reserved regions. This can be
used by drivers that don't do anything fancy with these regions other
than allocating memory for them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index db7bfd4f2d20..a46d3bcafa06 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2229,6 +2229,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 		ops->put_resv_regions(dev, list);
 }
 
+/**
+ * iommu_put_resv_regions_simple - Reserved region driver helper
+ * @dev: device for which to free reserved regions
+ * @list: reserved region list for device
+ *
+ * IOMMU drivers can use this to implement their .put_resv_regions() callback
+ * for simple reservations. Memory allocated for each reserved region will be
+ * freed. If an IOMMU driver allocates additional resources per region, it is
+ * going to have to implement a custom callback.
+ */
+void iommu_put_resv_regions_simple(struct device *dev, struct list_head *list)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, list, list)
+		kfree(entry);
+}
+EXPORT_SYMBOL(iommu_put_resv_regions_simple);
+
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
 						  enum iommu_resv_type type)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1b4fbe703950..a249aa55596b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -477,6 +477,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
+extern void iommu_put_resv_regions_simple(struct device *dev,
+					  struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern void iommu_set_default_passthrough(bool cmd_line);
-- 
2.23.0
