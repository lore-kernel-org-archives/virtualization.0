From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: SR-IOV: patches are available for Linux kernel [2/4]
Date: Tue, 12 Aug 2008 16:43:43 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110164BC8C__25945.5654457726$1218531115$gmane$org@pdsmsx414.ccr.corp.intel.com>
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
To: "Zhao, Yu" <yu.zhao@intel.com>, kvm@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

[PATCH 2/4] PCI: support ARI capability

Support Alternative Routing-ID Interpretation (ARI), which increases the number of functions that can be supported by a PCIe endpoint. SR-IOV depends on ARI.

PCI-SIG ARI specification can be found at http://www.pcisig.com/specifications/pciexpress/specifications/ECN-alt-rid-interpretation-070604.pdf

Signed-off-by: Yu Zhao <yu.zhao@intel.com>
Signed-off-by:  Eddie Dong <eddie.dong@intel.com>

---
 drivers/pci/Kconfig      |    7 +++++
 drivers/pci/Makefile     |    2 +
 drivers/pci/ari.c        |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c      |    3 ++
 include/linux/pci.h      |   29 +++++++++++++++++++
 include/linux/pci_regs.h |   14 +++++++++
 6 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e1ca425..f43cc46 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -50,3 +50,10 @@ config HT_IRQ
 	   This allows native hypertransport devices to use interrupts.
 
 	   If unsure say Y.
+
+config PCI_ARI
+	bool "PCI ARI support"
+	depends on PCI
+	default n
+	help
+	  This enables PCI Alternative Routing-ID Interpretation.
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 7d63f8c..96f2767 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -53,3 +53,5 @@ obj-$(CONFIG_PCI_SYSCALL) += syscall.o
 ifeq ($(CONFIG_PCI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
+
+obj-$(CONFIG_PCI_ARI) += ari.o
diff --git a/drivers/pci/ari.c b/drivers/pci/ari.c
new file mode 100644
index 0000000..e6dae1d
--- /dev/null
+++ b/drivers/pci/ari.c
@@ -0,0 +1,70 @@
+/*
+ * drivers/pci/ari.c
+ *
+ * Copyright (C) 2008 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
+ *
+ * PCI Express Alternative Routing-ID Interpretation capability support.
+ */
+
+#include <linux/pci.h>
+
+#include "pci.h"
+
+/**
+ * pci_ari_enable_fwd - enable ARI forwarding
+ * @dev: PCI device
+ */
+void pci_ari_enable_fwd(struct pci_dev *dev)
+{
+	int pos;
+	u32 cap;
+	u16 ctrl;
+
+	if (dev->pcie_type != PCI_EXP_TYPE_ROOT_PORT &&
+	    dev->pcie_type != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_EXP_DEVCAP2, &cap);
+
+	if (!(cap & PCI_EXP_DEVCAP2_ARI))
+		return;
+
+	dev->ari_enabled = 1;
+	dev_info(&dev->dev, "ARI forwarding enabled.\n");
+	pci_read_config_word(dev, pos + PCI_EXP_DEVCTL2, &ctrl);
+	if (ctrl & PCI_EXP_DEVCTL2_ARI)
+		return;
+
+	ctrl |= PCI_EXP_DEVCTL2_ARI;
+	pci_write_config_word(dev, pos + PCI_EXP_DEVCTL2, ctrl);
+}
+EXPORT_SYMBOL_GPL(pci_ari_enable_fwd);
+
+/**
+ * pci_ari_next_fn - find next function number
+ * @dev: PCI device
+ *
+ * Returns function number, and 0 if there are no higher numbered
+ * functions; returns negative on failure.
+ */
+int pci_ari_next_fn(struct pci_dev *dev)
+{
+	int pos;
+	u16 cap;
+
+	if (dev->pcie_type != PCI_EXP_TYPE_ENDPOINT)
+		return -EINVAL;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
+	if (!pos)
+		return -EIO;
+
+	pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
+
+	return PCI_ARI_CAP_NFN(cap);
+}
+EXPORT_SYMBOL_GPL(pci_ari_next_fn);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d030996..e8506fe 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1032,6 +1032,9 @@ int pci_scan_slot(struct pci_bus *bus, i
 	int func, nr = 0;
 	int scan_all_fns;
 
+	if (bus->self)
+		pci_ari_enable_fwd(bus->self);
+
 	scan_all_fns = pcibios_scan_all_fns(bus, devfn);
 
 	for (func = 0; func < 8; func++, devfn++) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9ea3a1d..110779a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -214,6 +214,7 @@ #endif
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 	unsigned int 	msi_enabled:1;
 	unsigned int	msix_enabled:1;
+	unsigned int	ari_enabled:1;	/* ARI forwarding on bridge */
 	unsigned int	is_managed:1;
 	unsigned int	is_pcie:1;
 	pci_dev_flags_t dev_flags;
@@ -1125,5 +1126,33 @@ static inline void pci_mmcfg_early_init(
 static inline void pci_mmcfg_late_init(void) { }
 #endif
 
+#ifdef CONFIG_PCI_ARI
+/**
+ * pci_ari_fwd_enabled - query ARI forwarding status
+ * @dev: PCI device
+ *
+ * Returns 1 if ARI forwarding is enabled, and 0 if it's not
+ * enabled; returns negative on failure.
+ */
+static inline int pci_ari_fwd_enabled(struct pci_dev *dev)
+{
+	return dev->ari_enabled;
+}
+extern void pci_ari_enable_fwd(struct pci_dev *dev);
+extern int pci_ari_next_fn(struct pci_dev *dev);
+#else
+static inline int pci_ari_fwd_enabled(struct pci_dev *dev)
+{
+	return -EIO;
+}
+static inline void pci_ari_enable_fwd(struct pci_dev *dev)
+{
+}
+static inline int pci_ari_next_fn(struct pci_dev *dev)
+{
+	return -EIO;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index 450684f..eb6686b 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -419,6 +419,10 @@ #define  PCI_EXP_RTCTL_PMEIE	0x08	/* PME
 #define  PCI_EXP_RTCTL_CRSSVE	0x10	/* CRS Software Visibility Enable */
 #define PCI_EXP_RTCAP		30	/* Root Capabilities */
 #define PCI_EXP_RTSTA		32	/* Root Status */
+#define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
+#define  PCI_EXP_DEVCAP2_ARI	0x20	/* Alternative Routing-ID */
+#define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
+#define  PCI_EXP_DEVCTL2_ARI	0x20	/* Alternative Routing-ID */
 
 /* Extended Capabilities (PCI-X 2.0 and Express) */
 #define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)
@@ -429,6 +433,7 @@ #define PCI_EXT_CAP_ID_ERR	1
 #define PCI_EXT_CAP_ID_VC	2
 #define PCI_EXT_CAP_ID_DSN	3
 #define PCI_EXT_CAP_ID_PWR	4
+#define PCI_EXT_CAP_ID_ARI	14
 
 /* Advanced Error Reporting */
 #define PCI_ERR_UNCOR_STATUS	4	/* Uncorrectable Error Status */
@@ -536,5 +541,14 @@ #define HT_CAPTYPE_ERROR_RETRY	0xC0	/* R
 #define HT_CAPTYPE_GEN3		0xD0	/* Generation 3 hypertransport configuration */
 #define HT_CAPTYPE_PM		0xE0	/* Hypertransport powermanagement configuration */
 
+/* Alternative Routing-ID Interpretation */
+#define PCI_ARI_CAP		0x04	/* ARI Capability Register */
+#define  PCI_ARI_CAP_MFVC	0x0001	/* MFVC Function Groups Capability */
+#define  PCI_ARI_CAP_ACS	0x0002	/* ACS Function Groups Capability */
+#define  PCI_ARI_CAP_NFN(x)	(((x) >> 8) & 0xff) /* Next Function Number */
+#define PCI_ARI_CTRL		0x06	/* ARI Control Register */
+#define  PCI_ARI_CTRL_MFVC	0x0001	/* MFVC Function Groups Enable */
+#define  PCI_ARI_CTRL_ACS	0x0002	/* ACS Function Groups Enable */
+#define  PCI_ARI_CTRL_FG(x)	(((x) >> 4) & 7) /* Function Group */
 
 #endif /* LINUX_PCI_REGS_H */
-- 
1.4.2.1
