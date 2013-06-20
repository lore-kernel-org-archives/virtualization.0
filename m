From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH 3/3] PCI: mark pci_scan_bus_parented() as __deprecated
Date: Fri, 21 Jun 2013 01:01:05 +0800
Message-ID: <1371747665-12768-4-git-send-email-liuj97@gmail.com>
References: <1371747665-12768-1-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1371747665-12768-1-git-send-email-liuj97@gmail.com>
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

Mark pci_scan_bus_parented() as __deprecated and clean up outdated
comments.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 arch/tile/kernel/pci.c | 3 ---
 include/linux/pci.h    | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f1229c7..b72d275 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -720,8 +720,8 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
-				      struct pci_ops *ops, void *sysdata);
+struct pci_bus * __deprecated pci_scan_bus_parented(struct device *parent,
+			int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
-- 
1.8.1.2
