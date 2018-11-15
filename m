From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 4/7] PCI: OF: Initialize dev->fwnode appropriately
Date: Thu, 15 Nov 2018 16:52:31 +0000
Message-ID: <20181115165234.43990-5-jean-philippe.brucker__22152.7087771848$1542301187$gmane$org@arm.com>
References: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com, eric.auger@redhat.com, robh+dt@kernel.org, bhelgaas@google.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

For PCI devices that have an OF node, set the fwnode as well. This way
drivers that rely on fwnode don't need the special case described by
commit f94277af03ea ("of/platform: Initialise dev->fwnode appropriately").

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/of.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4c4217d0c3f1..c272ecfcd038 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -21,12 +21,15 @@ void pci_set_of_node(struct pci_dev *dev)
 		return;
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
 						    dev->devfn);
+	if (dev->dev.of_node)
+		dev->dev.fwnode = &dev->dev.of_node->fwnode;
 }
 
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
 	dev->dev.of_node = NULL;
+	dev->dev.fwnode = NULL;
 }
 
 void pci_set_bus_of_node(struct pci_bus *bus)
@@ -35,12 +38,16 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 		bus->dev.of_node = pcibios_get_phb_of_node(bus);
 	else
 		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
+
+	if (bus->dev.of_node)
+		bus->dev.fwnode = &bus->dev.of_node->fwnode;
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
 {
 	of_node_put(bus->dev.of_node);
 	bus->dev.of_node = NULL;
+	bus->dev.fwnode = NULL;
 }
 
 struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
-- 
2.19.1
