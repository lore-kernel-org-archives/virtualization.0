From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 10/13] iommu/virtio: Update IORT fwnode
Date: Fri, 22 Nov 2019 11:49:57 +0100
Message-ID: <20191122105000.800410-11-jean-philippe__23643.652447366$1574420351$gmane$org@linaro.org>
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

When the virtio-iommu uses the PCI transport and the topology is
described with IORT, register the PCI fwnode with IORT.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 8efa368134c0..9847552faecc 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi_iort.h>
 #include <linux/amba/bus.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
@@ -989,6 +990,8 @@ static int viommu_set_fwnode(struct viommu_dev *viommu)
 		set_primary_fwnode(dev, fwnode);
 	}
 
+	/* Tell IORT about a PCI device's fwnode */
+	iort_iommu_update_fwnode(dev, dev->fwnode);
 	iommu_device_set_fwnode(&viommu->iommu, dev->fwnode);
 	return 0;
 }
@@ -1000,6 +1003,8 @@ static void viommu_clear_fwnode(struct viommu_dev *viommu)
 	if (!dev->fwnode)
 		return;
 
+	iort_iommu_update_fwnode(dev, NULL);
+
 	if (is_software_node(dev->fwnode)) {
 		struct fwnode_handle *fwnode = dev->fwnode;
 
-- 
2.24.0
