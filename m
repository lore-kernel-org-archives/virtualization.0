From: Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 2/2] PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests
Date: Mon, 11 May 2020 15:01:29 -0400
Message-ID: <20200511190129.9313-4-jonathan.derrick@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200511190129.9313-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, Jon Derrick <jonathan.derrick@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

VMD device 28C0 natively assists guest passthrough of the VMD endpoint
through the use of shadow registers that provide Host Physical Addresses
to correctly assign bridge windows. These shadow registers are only
available if VMD config space register 0x70, bit 1 is set.

For existing VMD which don't natively support the shadow register, VMD
config space register 0x70 is reserved and will return 0. Future VMD
will have these registers natively in hardware, but existing VMD can
still use this feature by emulating the config space register and shadow
registers.

QEMU has been modified to emulate this config space register and the
shadow membar registers for VMDs which don't natively support this
feature. This patch updates the supported device list to allow this
feature to be used on these VMDs.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e386d4eac407..ee71d0989875 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -600,6 +600,7 @@ static irqreturn_t vmd_irq(int irq, void *data)
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
+	unsigned long features = id->driver_data;
 	int i, err;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
@@ -652,7 +653,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
+	err = vmd_enable_domain(vmd, features);
 	if (err)
 		return err;
 
@@ -716,16 +717,20 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.18.1
