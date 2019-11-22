From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 05/13] ACPI/IORT: Support VIOT virtio-mmio node
Date: Fri, 22 Nov 2019 11:49:52 +0100
Message-ID: <20191122105000.800410-6-jean-philippe__37632.6604093023$1574420316$gmane$org@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, gregkh@linuxfoundation.org, joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net, eric.auger@redhat.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, guohanjun@huawei.com, bhelgaas@google.com, lenb@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add a new type of node to the IORT driver, that describes a virtio-iommu
device based on the virtio-mmio transport. The node is only available
when the IORT is a sub-table of the VIOT.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/iort.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 1d43fbc0001f..adc5953fffa5 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -43,7 +43,8 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
 	switch (category) {
 	case IORT_IOMMU_TYPE:
 		return type == ACPI_IORT_NODE_SMMU ||
-		       type == ACPI_IORT_NODE_SMMU_V3;
+		       type == ACPI_IORT_NODE_SMMU_V3 ||
+		       type == ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU;
 	case IORT_MSI_TYPE:
 		return type == ACPI_IORT_NODE_ITS_GROUP;
 	default:
@@ -868,8 +869,10 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
 	case ACPI_IORT_NODE_SMMU:
 		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
 	default:
-		pr_warn("IORT node type %u does not describe an SMMU\n", type);
+		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
 		return false;
 	}
 }
@@ -1408,6 +1411,46 @@ static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
 	return platform_device_add_data(pdev, &model, sizeof(model));
 }
 
+static int __init viommu_mmio_count_resources(struct acpi_iort_node *node)
+{
+	/* Mem + IRQ */
+	return 2;
+}
+
+static void __init viommu_mmio_init_resources(struct resource *res,
+					   struct acpi_iort_node *node)
+{
+	int hw_irq, trigger;
+	struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+	viommu = (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+	res[0].start = viommu->base_address;
+	res[0].end = viommu->base_address + viommu->span - 1;
+	res[0].flags = IORESOURCE_MEM;
+
+	hw_irq = IORT_IRQ_MASK(viommu->interrupt);
+	trigger = IORT_IRQ_TRIGGER_MASK(viommu->interrupt);
+	acpi_iort_register_irq(hw_irq, "viommu", trigger, res + 1);
+}
+
+static void __init viommu_mmio_dma_configure(struct device *dev,
+					  struct acpi_iort_node *node)
+{
+	enum dev_dma_attr attr;
+	struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+	viommu = (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+	attr = (viommu->flags & ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERENT) ?
+		DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(dev, attr);
+}
+
 struct iort_dev_config {
 	const char *name;
 	int (*dev_init)(struct acpi_iort_node *node);
@@ -1443,6 +1486,14 @@ static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
 	.dev_add_platdata = arm_smmu_v3_pmcg_add_platdata,
 };
 
+static const struct iort_dev_config iort_viommu_mmio_cfg __initconst = {
+	/* Probe with the generic virtio-mmio driver */
+	.name = "virtio-mmio",
+	.dev_dma_configure = viommu_mmio_dma_configure,
+	.dev_count_resources = viommu_mmio_count_resources,
+	.dev_init_resources = viommu_mmio_init_resources,
+};
+
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 			struct acpi_iort_node *node)
 {
@@ -1453,9 +1504,16 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
 		return &iort_arm_smmu_cfg;
 	case ACPI_IORT_NODE_PMCG:
 		return &iort_arm_smmu_v3_pmcg_cfg;
-	default:
-		return NULL;
 	}
+
+	if (iort_table_source == IORT_SOURCE_VIOT) {
+		switch (node->type) {
+		case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+			return &iort_viommu_mmio_cfg;
+		}
+	}
+
+	return NULL;
 }
 
 /**
-- 
2.24.0
