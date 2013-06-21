From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v2 3/3] PCI: kill pci_scan_bus_parented()
Date: Sat, 22 Jun 2013 00:12:48 +0800
Message-ID: <1371831169-17291-4-git-send-email-liuj97@gmail.com>
References: <1371831169-17291-1-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1371831169-17291-1-git-send-email-liuj97@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bhelgaas@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, virtualization@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yijing Wang <wangyijing@huawei.com>, liuj97@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jiang Liu <jiang.liu@huawei.com>

Now there's no caller of pci_scan_bus_parented(), so kill it.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 arch/tile/kernel/pci.c |  3 ---
 drivers/pci/probe.c    | 19 -------------------
 include/linux/pci.h    |  2 --
 3 files changed, 24 deletions(-)

diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index 67237d3..936e087 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -309,9 +309,6 @@ int __init pcibios_init(void)
 			 *
 			 * It reads the PCI tree for this bus into the Linux
 			 * data structures.
-			 *
-			 * This is inlined in linux/pci.h and calls into
-			 * pci_scan_bus_parented() in probe.c.
 			 */
 			pci_add_resource(&resources, &ioport_resource);
 			pci_add_resource(&resources, &iomem_resource);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed768d8..af30772 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1901,25 +1901,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-/* Deprecated; use pci_scan_root_bus() instead */
-struct pci_bus *pci_scan_bus_parented(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata)
-{
-	LIST_HEAD(resources);
-	struct pci_bus *b;
-
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
-	if (b)
-		pci_scan_child_bus(b);
-	else
-		pci_free_resource_list(&resources);
-	return b;
-}
-EXPORT_SYMBOL(pci_scan_bus_parented);
-
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 					void *sysdata)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f1229c7..41ec0a5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -720,8 +720,6 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
-				      struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
-- 
1.8.1.2
