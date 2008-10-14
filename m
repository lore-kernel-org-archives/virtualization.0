From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 4/8 v4] PCI: add a wrapper for resource_alignment
Date: Tue, 14 Oct 2008 18:55:08 +0800
Message-ID: <20081014105508.GD1734__42938.4456402206$1223985612$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081014103424.GA1704@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081014103424.GA1704@yzhao12-linux.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "greg@kroah.com" <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Add a wrap of resource_alignment so it can handle device specific resource
alignment.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/pci.c       |   25 +++++++++++++++++++++++++
 drivers/pci/pci.h       |    1 +
 drivers/pci/setup-bus.c |    4 ++--
 drivers/pci/setup-res.c |    7 ++++---
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a9c64b0..381e958 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1884,6 +1884,31 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags)
 	return bars;
 }
 
+/**
+ * pci_resource_alignment - get a PCI BAR resource alignment
+ * @dev: the PCI device
+ * @resno: the resource number
+ *
+ * Returns alignment size on success, or 0 on error.
+ */
+int pci_resource_alignment(struct pci_dev *dev, int resno)
+{
+	resource_size_t align;
+	struct resource *res = dev->resource + resno;
+
+	align = resource_alignment(res);
+	if (align)
+		return align;
+
+	if (resno <= PCI_ROM_RESOURCE)
+		return resource_size(res);
+	else if (resno <= PCI_BRIDGE_RES_END)
+		return res->start;
+
+	dev_err(&dev->dev, "alignment: invalid resource #%d\n", resno);
+	return 0;
+}
+
 static void __devinit pci_no_domains(void)
 {
 #ifdef CONFIG_PCI_DOMAINS
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c6fa8ab..720b7d6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -161,6 +161,7 @@ extern int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 				struct resource *res, unsigned int reg);
 extern struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 				struct pci_dev *bridge, int busnr);
+extern int pci_resource_alignment(struct pci_dev *dev, int resno);
 extern void pci_enable_ari(struct pci_dev *dev);
 /**
  * pci_ari_enabled - query ARI forwarding status
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6c78cf8..d454ec3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -25,6 +25,7 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/slab.h>
+#include "pci.h"
 
 
 static void pbus_assign_resources_sorted(struct pci_bus *bus)
@@ -351,8 +352,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long
 			if (r->parent || (r->flags & mask) != type)
 				continue;
 			r_size = resource_size(r);
-			/* For bridges size != alignment */
-			align = resource_alignment(r);
+			align = pci_resource_alignment(dev, i);
 			order = __ffs(align) - 20;
 			if (order > 11) {
 				dev_warn(&dev->dev, "BAR %d bad alignment %llx: "
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index a81caac..ecff483 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -137,7 +137,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	size = resource_size(res);
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
-	align = resource_alignment(res);
+	align = pci_resource_alignment(dev, resno);
 	if (!align) {
 		dev_err(&dev->dev, "BAR %d: can't allocate resource (bogus "
 			"alignment) [%#llx-%#llx] flags %#lx\n",
@@ -235,7 +235,7 @@ void pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
 		if (!(r->flags) || r->parent)
 			continue;
 
-		r_align = resource_alignment(r);
+		r_align = pci_resource_alignment(dev, i);
 		if (!r_align) {
 			dev_warn(&dev->dev, "BAR %d: bogus alignment "
 				"[%#llx-%#llx] flags %#lx\n",
@@ -248,7 +248,8 @@ void pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
 			struct resource_list *ln = list->next;
 
 			if (ln)
-				align = resource_alignment(ln->res);
+				align = pci_resource_alignment(ln->dev,
+						ln->res - ln->dev->resource);
 
 			if (r_align > align) {
 				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
-- 
1.5.6.4
