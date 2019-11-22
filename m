From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 07/13] ACPI/IORT: Defer probe until virtio-iommu-pci has
 registered a fwnode
Date: Fri, 22 Nov 2019 11:49:54 +0100
Message-ID: <20191122105000.800410-8-jean-philippe__11158.3812440344$1574420204$gmane$org@linaro.org>
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

When the IOMMU is PCI-based, IORT doesn't know the fwnode until the
driver has had a chance to register it. In addition to deferring the
probe until the IOMMU ops are set, also defer the probe until the fwspec
is available.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c | 54 ++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index b517aa4e83ba..f08f72d8af78 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -61,6 +61,22 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
 	}
 }
 
+static inline bool iort_iommu_driver_enabled(u8 type)
+{
+	switch (type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+	case ACPI_IORT_NODE_SMMU:
+		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+	case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
+		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
+	default:
+		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
+		return false;
+	}
+}
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -102,9 +118,9 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
  *
  * Returns: fwnode_handle pointer on success, NULL on failure
  */
-static inline struct fwnode_handle *iort_get_fwnode(
-			struct acpi_iort_node *node)
+static inline struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
 {
+	int err = -ENODEV;
 	struct iort_fwnode *curr;
 	struct fwnode_handle *fwnode = NULL;
 
@@ -112,12 +128,20 @@ static inline struct fwnode_handle *iort_get_fwnode(
 	list_for_each_entry(curr, &iort_fwnode_list, list) {
 		if (curr->iort_node == node) {
 			fwnode = curr->fwnode;
+			if (!fwnode && curr->pci_devid) {
+				/*
+				 * Postpone probe until virtio-iommu has
+				 * registered its fwnode.
+				 */
+				err = iort_iommu_driver_enabled(node->type) ?
+					-EPROBE_DEFER : -ENODEV;
+			}
 			break;
 		}
 	}
 	spin_unlock(&iort_fwnode_lock);
 
-	return fwnode;
+	return fwnode ?: ERR_PTR(err);
 }
 
 /**
@@ -874,22 +898,6 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
 
-static inline bool iort_iommu_driver_enabled(u8 type)
-{
-	switch (type) {
-	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
-	case ACPI_IORT_NODE_SMMU:
-		return IS_BUILTIN(CONFIG_ARM_SMMU);
-	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
-	case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
-		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
-	default:
-		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
-		return false;
-	}
-}
-
 static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 			       struct fwnode_handle *fwnode,
 			       const struct iommu_ops *ops)
@@ -920,8 +928,8 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 		return -ENODEV;
 
 	iort_fwnode = iort_get_fwnode(node);
-	if (!iort_fwnode)
-		return -ENODEV;
+	if (IS_ERR(iort_fwnode))
+		return PTR_ERR(iort_fwnode);
 
 	/*
 	 * If the ops look-up fails, this means that either
@@ -1618,8 +1626,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 	fwnode = iort_get_fwnode(node);
 
-	if (!fwnode) {
-		ret = -ENODEV;
+	if (IS_ERR(fwnode)) {
+		ret = PTR_ERR(fwnode);
 		goto dev_put;
 	}
 
-- 
2.24.0
