From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 06/13] ACPI/IORT: Support VIOT virtio-pci node
Date: Fri, 22 Nov 2019 11:49:53 +0100
Message-ID: <20191122105000.800410-7-jean-philippe__15042.9187620588$1574419882$gmane$org@linaro.org>
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

When virtio-iommu uses the PCI transport, IORT doesn't instantiate the
device and doesn't create a fwnode. They will be created later by the
PCI subsystem. Store the information needed to identify the IOMMU in
iort_fwnode_list.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/iort.c | 117 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index adc5953fffa5..b517aa4e83ba 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -30,10 +30,17 @@ struct iort_its_msi_chip {
 	u32			translation_id;
 };
 
+struct iort_pci_devid {
+	u16 segment;
+	u8 bus;
+	u8 devfn;
+};
+
 struct iort_fwnode {
 	struct list_head list;
 	struct acpi_iort_node *iort_node;
 	struct fwnode_handle *fwnode;
+	struct iort_pci_devid *pci_devid;
 };
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
@@ -44,7 +51,8 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
 	case IORT_IOMMU_TYPE:
 		return type == ACPI_IORT_NODE_SMMU ||
 		       type == ACPI_IORT_NODE_SMMU_V3 ||
-		       type == ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU;
+		       type == ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU ||
+		       type == ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU;
 	case IORT_MSI_TYPE:
 		return type == ACPI_IORT_NODE_ITS_GROUP;
 	default:
@@ -59,12 +67,14 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
  *
  * @node: IORT table node associated with the IOMMU
  * @fwnode: fwnode associated with the IORT node
+ * @pci_devid: pci device ID associated with the IORT node, may be NULL
  *
  * Returns: 0 on success
  *          <0 on failure
  */
 static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
-				  struct fwnode_handle *fwnode)
+				  struct fwnode_handle *fwnode,
+				  struct iort_pci_devid *pci_devid)
 {
 	struct iort_fwnode *np;
 
@@ -76,6 +86,7 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
 	INIT_LIST_HEAD(&np->list);
 	np->iort_node = iort_node;
 	np->fwnode = fwnode;
+	np->pci_devid = pci_devid;
 
 	spin_lock(&iort_fwnode_lock);
 	list_add_tail(&np->list, &iort_fwnode_list);
@@ -121,6 +132,7 @@ static inline void iort_delete_fwnode(struct acpi_iort_node *node)
 	spin_lock(&iort_fwnode_lock);
 	list_for_each_entry_safe(curr, tmp, &iort_fwnode_list, list) {
 		if (curr->iort_node == node) {
+			kfree(curr->pci_devid);
 			list_del(&curr->list);
 			kfree(curr);
 			break;
@@ -870,6 +882,7 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 	case ACPI_IORT_NODE_SMMU:
 		return IS_BUILTIN(CONFIG_ARM_SMMU);
 	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+	case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
 		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
 	default:
 		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
@@ -1451,6 +1464,28 @@ static void __init viommu_mmio_dma_configure(struct device *dev,
 	acpi_dma_configure(dev, attr);
 }
 
+static __init struct iort_pci_devid *
+viommu_pci_get_devid(struct acpi_iort_node *node)
+{
+	unsigned int val;
+	struct iort_pci_devid *devid;
+	struct acpi_viot_iort_virtio_pci_iommu *viommu;
+
+	viommu = (struct acpi_viot_iort_virtio_pci_iommu *)node->node_data;
+
+	val = le32_to_cpu(viommu->devid);
+
+	devid = kzalloc(sizeof(*devid), GFP_KERNEL);
+	if (!devid)
+		return ERR_PTR(-ENOMEM);
+
+	devid->segment = val >> 16;
+	devid->bus = PCI_BUS_NUM(val);
+	devid->devfn = val & 0xff;
+
+	return devid;
+}
+
 struct iort_dev_config {
 	const char *name;
 	int (*dev_init)(struct acpi_iort_node *node);
@@ -1462,6 +1497,7 @@ struct iort_dev_config {
 	int (*dev_set_proximity)(struct device *dev,
 				    struct acpi_iort_node *node);
 	int (*dev_add_platdata)(struct platform_device *pdev);
+	struct iort_pci_devid *(*dev_get_pci_devid)(struct acpi_iort_node *node);
 };
 
 static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
@@ -1494,6 +1530,10 @@ static const struct iort_dev_config iort_viommu_mmio_cfg __initconst = {
 	.dev_init_resources = viommu_mmio_init_resources,
 };
 
+static const struct iort_dev_config iort_viommu_pci_cfg __initconst = {
+	.dev_get_pci_devid = viommu_pci_get_devid,
+};
+
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 			struct acpi_iort_node *node)
 {
@@ -1510,6 +1550,8 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
 		switch (node->type) {
 		case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
 			return &iort_viommu_mmio_cfg;
+		case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
+			return &iort_viommu_pci_cfg;
 		}
 	}
 
@@ -1641,13 +1683,55 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
 
-static void __init iort_init_platform_devices(void)
+static int __init iort_init_node(struct acpi_iort_node *iort_node)
+{
+	int ret;
+	const struct iort_dev_config *ops;
+	struct fwnode_handle *fwnode;
+
+	iort_enable_acs(iort_node);
+
+	ops = iort_get_dev_cfg(iort_node);
+	if (!ops)
+		return 0;
+
+	if (ops->dev_get_pci_devid) {
+		struct iort_pci_devid *pci_devid =
+			ops->dev_get_pci_devid(iort_node);
+
+		if (IS_ERR(pci_devid))
+			return PTR_ERR(pci_devid);
+		/*
+		 * For a PCI-based IOMMU, set the pci_devid handle now, but
+		 * leave the fwnode empty. It will be completed later when the
+		 * PCI device gets probed.
+		 */
+		iort_set_fwnode(iort_node, NULL, pci_devid);
+
+		return 0;
+	}
+
+	fwnode = acpi_alloc_fwnode_static();
+	if (!fwnode)
+		return -ENOMEM;
+
+	iort_set_fwnode(iort_node, fwnode, NULL);
+
+	ret = iort_add_platform_device(iort_node, ops);
+	if (ret) {
+		iort_delete_fwnode(iort_node);
+		acpi_free_fwnode_static(fwnode);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __init iort_init_devices(void)
 {
 	struct acpi_iort_node *iort_node, *iort_end;
 	struct acpi_table_iort *iort;
-	struct fwnode_handle *fwnode;
-	int i, ret;
-	const struct iort_dev_config *ops;
+	int i;
 
 	/*
 	 * iort_table and iort both point to the start of IORT table, but
@@ -1667,23 +1751,8 @@ static void __init iort_init_platform_devices(void)
 			return;
 		}
 
-		iort_enable_acs(iort_node);
-
-		ops = iort_get_dev_cfg(iort_node);
-		if (ops) {
-			fwnode = acpi_alloc_fwnode_static();
-			if (!fwnode)
-				return;
-
-			iort_set_fwnode(iort_node, fwnode);
-
-			ret = iort_add_platform_device(iort_node, ops);
-			if (ret) {
-				iort_delete_fwnode(iort_node);
-				acpi_free_fwnode_static(fwnode);
-				return;
-			}
-		}
+		if (iort_init_node(iort_node))
+			return;
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
@@ -1703,7 +1772,7 @@ void __init acpi_iort_register_table(struct acpi_table_header *table,
 	iort_table = table;
 	iort_table_source = source;
 
-	iort_init_platform_devices();
+	iort_init_devices();
 }
 
 void __init acpi_iort_init(void)
-- 
2.24.0
