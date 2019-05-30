From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v8 4/7] PCI: OF: Initialize dev->fwnode appropriately
Date: Thu, 30 May 2019 18:09:26 +0100
Message-ID: <20190530170929.19366-5-jean-philippe.brucker__14941.5844281734$1559236442$gmane$org@arm.com>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: joro@8bytes.org, mst@redhat.com
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, Lorenzo.Pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, bhelgaas@google.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

For PCI devices that have an OF node, set the fwnode as well. This way
drivers that rely on fwnode don't need the special case described by
commit f94277af03ea ("of/platform: Initialise dev->fwnode appropriately").

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/of.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 73d5adec0a28..c4f1b5507b40 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -22,12 +22,15 @@ void pci_set_of_node(struct pci_dev *dev)
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
@@ -42,12 +45,15 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 			bus->self->untrusted = true;
 	}
 	bus->dev.of_node = node;
+	if (node)
+		bus->dev.fwnode = &node->fwnode;
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
 {
 	of_node_put(bus->dev.of_node);
 	bus->dev.of_node = NULL;
+	bus->dev.fwnode = NULL;
 }
 
 struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
-- 
2.21.0
