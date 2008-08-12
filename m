From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: SR-IOV: patches are available for Linux kernel [1/4]
Date: Tue, 12 Aug 2008 16:42:55 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110164BC89__9356.32798723436$1218530864$gmane$org@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

[PATCH 1/4] PCI: export pci_read_base and add pci_update_base

Export pci_read_base; add pci_update_base to for PCI BAR update.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>
Signed-off-by:  Eddie Dong <eddie.dong@intel.com>

---
 drivers/pci/probe.c     |   25 ++++++++--------
 drivers/pci/setup-res.c |   74 +++++++++++++++++++++++++++--------------------
 include/linux/pci.h     |   12 ++++++++
 3 files changed, 67 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7098dfb..d030996 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -181,13 +181,6 @@ static u64 pci_size(u64 base, u64 maxbas
 	return size;
 }
 
-enum pci_bar_type {
-	pci_bar_unknown,	/* Standard PCI BAR probe */
-	pci_bar_io,		/* An io port BAR */
-	pci_bar_mem32,		/* A 32-bit memory BAR */
-	pci_bar_mem64,		/* A 64-bit memory BAR */
-};
-
 static inline enum pci_bar_type decode_bar(struct resource *res, u32 bar)
 {
 	if ((bar & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
@@ -202,11 +195,18 @@ static inline enum pci_bar_type decode_b
 	return pci_bar_mem32;
 }
 
-/*
- * If the type is not unknown, we assume that the lowest bit is 'enable'.
+/**
+ * pci_read_base - read a PCI BAR
+ * @dev: PCI device
+ * @type: type of BAR
+ * @res: resource buffer to be filled in
+ * @pos: BAR position in config space
+ *
  * Returns 1 if the BAR was 64-bit and 0 if it was 32-bit.
+ *
+ * If the type is not unknown, we assume that the lowest bit is 'enable'.
  */
-static int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
+int pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			struct resource *res, unsigned int pos)
 {
 	u32 l, sz, mask;
@@ -299,6 +299,7 @@ static int __pci_read_base(struct pci_de
 	res->flags = 0;
 	goto out;
 }
+EXPORT_SYMBOL_GPL(pci_read_base);
 
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
@@ -307,7 +308,7 @@ static void pci_read_bases(struct pci_de
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
+		pos += pci_read_base(dev, pci_bar_unknown, res, reg);
 	}
 
 	if (rom) {
@@ -316,7 +317,7 @@ static void pci_read_bases(struct pci_de
 		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				IORESOURCE_READONLY | IORESOURCE_CACHEABLE |
 				IORESOURCE_SIZEALIGN;
-		__pci_read_base(dev, pci_bar_mem32, res, rom);
+		pci_read_base(dev, pci_bar_mem32, res, rom);
 	}
 }
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 1a5fc83..059de16 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -26,11 +26,20 @@ #include <linux/slab.h>
 #include "pci.h"
 
 
-void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
+/**
+ * pci_update_base - update a PCI BAR
+ * @dev: PCI device
+ * @type: type of BAR
+ * @res: resource info used to update BAR
+ * @pos: BAR position in config space
+ *
+ * If the type is not unknown, we assume that the lowest bit is 'enable'.
+ */
+void pci_update_base(struct pci_dev *dev, enum pci_bar_type type,
+			struct resource *res, unsigned int pos)
 {
 	struct pci_bus_region region;
 	u32 new, check, mask;
-	int reg;
 
 	/*
 	 * Ignore resources for unimplemented BARs and unused resource slots
@@ -49,56 +58,57 @@ void pci_update_resource(struct pci_dev 
 
 	pcibios_resource_to_bus(dev, &region, res);
 
-	dev_dbg(&dev->dev, "BAR %d: got res [%#llx-%#llx] bus [%#llx-%#llx] "
-		"flags %#lx\n", resno,
-		 (unsigned long long)res->start,
-		 (unsigned long long)res->end,
-		 (unsigned long long)region.start,
-		 (unsigned long long)region.end,
-		 (unsigned long)res->flags);
+	dev_dbg(&dev->dev, "BAR at %d: got res [%#llx-%#llx] bus [%#llx-%#llx] "
+		"flags %#lx\n", pos, (unsigned long long)res->start,
+		(unsigned long long)res->end, (unsigned long long)region.start,
+		(unsigned long long)region.end, (unsigned long)res->flags);
 
 	new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
+	if (type != pci_bar_unknown)
+		new |= PCI_ROM_ADDRESS_ENABLE;
+
 	if (res->flags & IORESOURCE_IO)
 		mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
 	else
 		mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
 
-	if (resno < 6) {
-		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
-	} else if (resno == PCI_ROM_RESOURCE) {
-		if (!(res->flags & IORESOURCE_ROM_ENABLE))
-			return;
-		new |= PCI_ROM_ADDRESS_ENABLE;
-		reg = dev->rom_base_reg;
-	} else {
-		/* Hmm, non-standard resource. */
-	
-		return;		/* kill uninitialised var warning */
-	}
-
-	pci_write_config_dword(dev, reg, new);
-	pci_read_config_dword(dev, reg, &check);
+	pci_write_config_dword(dev, pos, new);
+	pci_read_config_dword(dev, pos, &check);
 
 	if ((new ^ check) & mask) {
-		dev_err(&dev->dev, "BAR %d: error updating (%#08x != %#08x)\n",
-			resno, new, check);
+		dev_err(&dev->dev, "BAR at %d: error updating "
+			"(%#08x != %#08x)\n", pos, new, check);
 	}
 
 	if ((new & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
 	    (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64)) {
 		new = region.start >> 16 >> 16;
-		pci_write_config_dword(dev, reg + 4, new);
-		pci_read_config_dword(dev, reg + 4, &check);
+		pci_write_config_dword(dev, pos + 4, new);
+		pci_read_config_dword(dev, pos + 4, &check);
 		if (check != new) {
-			dev_err(&dev->dev, "BAR %d: error updating "
-			       "(high %#08x != %#08x)\n", resno, new, check);
+			dev_err(&dev->dev, "BAR at %d: error updating "
+			       "(high %#08x != %#08x)\n", pos, new, check);
 		}
 	}
 	res->flags &= ~IORESOURCE_UNSET;
-	dev_dbg(&dev->dev, "BAR %d: moved to bus [%#llx-%#llx] flags %#lx\n",
-		resno, (unsigned long long)region.start,
+	dev_dbg(&dev->dev, "BAR at %d: moved to bus [%#llx-%#llx] flags %#lx\n",
+		pos, (unsigned long long)region.start,
 		(unsigned long long)region.end, res->flags);
 }
+EXPORT_SYMBOL_GPL(pci_update_base);
+
+void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
+{
+	if (resno < 6) {
+		pci_update_base(dev, pci_bar_unknown, res,
+			       PCI_BASE_ADDRESS_0 + 4 * resno);
+	} else if (resno == PCI_ROM_RESOURCE) {
+		if (!(res->flags & IORESOURCE_ROM_ENABLE))
+			return;
+		pci_update_base(dev, pci_bar_mem32, res, dev->rom_base_reg);
+	} else
+		dev_err(&dev->dev, "Invalid BAR resource #%d\n", resno);
+}
 
 int pci_claim_resource(struct pci_dev *dev, int resource)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 825be38..9ea3a1d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -312,6 +312,18 @@ struct pci_bus {
 #define pci_bus_b(n)	list_entry(n, struct pci_bus, node)
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
 
+enum pci_bar_type {
+	pci_bar_unknown,	/* Standard PCI BAR probe */
+	pci_bar_io,		/* An io port BAR */
+	pci_bar_mem32,		/* A 32-bit memory BAR */
+	pci_bar_mem64,		/* A 64-bit memory BAR */
+};
+
+int pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
+			struct resource *res, unsigned int reg);
+void pci_update_base(struct pci_dev *dev, enum pci_bar_type type,
+			struct resource *res, unsigned int reg);
+
 /*
  * Error values that may be returned by PCI functions.
  */
-- 
1.4.2.1
