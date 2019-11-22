From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 09/13] iommu/virtio: Create fwnode if necessary
Date: Fri, 22 Nov 2019 11:49:56 +0100
Message-ID: <20191122105000.800410-10-jean-philippe__20748.2088053197$1574420288$gmane$org@linaro.org>
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

The presence of a fwnode on a PCI device depends on the platform. QEMU
q35, for example, creates an ACPI description for each PCI slot, but
QEMU virt (aarch64) doesn't. Since the IOMMU subsystem relies heavily on
fwnode to discover the DMA topology, create a fwnode for the
virtio-iommu if necessary, using the software_node framework.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 56 ++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d7682999..8efa368134c0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -966,6 +966,48 @@ static struct iommu_ops viommu_ops = {
 	.of_xlate		= viommu_of_xlate,
 };
 
+static int viommu_set_fwnode(struct viommu_dev *viommu)
+{
+	/*
+	 * viommu->dev is the virtio device, its parent is the associated
+	 * transport device.
+	 */
+	struct device *dev = viommu->dev->parent;
+
+	/*
+	 * With device tree a fwnode is always present. With ACPI, on some
+	 * platforms a PCI device has a DSDT node describing the slot. On other
+	 * platforms, no fwnode is created and we have to do it ourselves.
+	 */
+	if (!dev->fwnode) {
+		struct fwnode_handle *fwnode;
+
+		fwnode = fwnode_create_software_node(NULL, NULL);
+		if (IS_ERR(fwnode))
+			return PTR_ERR(fwnode);
+
+		set_primary_fwnode(dev, fwnode);
+	}
+
+	iommu_device_set_fwnode(&viommu->iommu, dev->fwnode);
+	return 0;
+}
+
+static void viommu_clear_fwnode(struct viommu_dev *viommu)
+{
+	struct device *dev = viommu->dev->parent;
+
+	if (!dev->fwnode)
+		return;
+
+	if (is_software_node(dev->fwnode)) {
+		struct fwnode_handle *fwnode = dev->fwnode;
+
+		set_primary_fwnode(dev, NULL);
+		fwnode_remove_software_node(fwnode);
+	}
+}
+
 static int viommu_init_vqs(struct viommu_dev *viommu)
 {
 	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
@@ -1004,7 +1046,6 @@ static int viommu_fill_evtq(struct viommu_dev *viommu)
 
 static int viommu_probe(struct virtio_device *vdev)
 {
-	struct device *parent_dev = vdev->dev.parent;
 	struct viommu_dev *viommu = NULL;
 	struct device *dev = &vdev->dev;
 	u64 input_start = 0;
@@ -1084,9 +1125,11 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
-	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
+	ret = viommu_set_fwnode(viommu);
+	if (ret)
+		goto err_sysfs_remove;
 
+	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 	iommu_device_register(&viommu->iommu);
 
 #ifdef CONFIG_PCI
@@ -1119,8 +1162,10 @@ static int viommu_probe(struct virtio_device *vdev)
 	return 0;
 
 err_unregister:
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+	viommu_clear_fwnode(viommu);
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
@@ -1131,8 +1176,9 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
 
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+	viommu_clear_fwnode(viommu);
+	iommu_device_sysfs_remove(&viommu->iommu);
 
 	/* Stop all virtqueues */
 	vdev->config->reset(vdev);
-- 
2.24.0
