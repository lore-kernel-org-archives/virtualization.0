From: Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 1/2] PCI: vmd: Filter resource type bits from shadow register
Date: Mon, 11 May 2020 15:01:28 -0400
Message-ID: <20200511190129.9313-3-jonathan.derrick@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200511190129.9313-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, Jon Derrick <jonathan.derrick@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Versions of VMD with the Host Physical Address shadow register use this
register to calculate the bus address offset needed to do guest
passthrough of the domain. This register shadows the Host Physical
Address registers including the resource type bits. After calculating
the offset, the extra resource type bits lead to the VMD resources being
over-provisioned at the front and under-provisioned at the back.

Example:
pci 10000:80:02.0: reg 0x10: [mem 0xf801fffc-0xf803fffb 64bit]

Expected:
pci 10000:80:02.0: reg 0x10: [mem 0xf8020000-0xf803ffff 64bit]

If other devices are mapped in the over-provisioned front, it could lead
to resource conflict issues with VMD or those devices.

Fixes: a1a30170138c9 ("PCI: vmd: Fix shadow offsets to reflect spec changes")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index dac91d60701d..e386d4eac407 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -445,9 +445,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			if (!membar2)
 				return -ENOMEM;
 			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
-					readq(membar2 + MB2_SHADOW_OFFSET);
+					(readq(membar2 + MB2_SHADOW_OFFSET) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
 			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
-					readq(membar2 + MB2_SHADOW_OFFSET + 8);
+					(readq(membar2 + MB2_SHADOW_OFFSET + 8) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
 			pci_iounmap(vmd->dev, membar2);
 		}
 	}
-- 
2.18.1
