From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: [PATCH 5/6 v3] PCI: reserve bus range for SR-IOV
Date: Sat, 27 Sep 2008 16:28:29 +0800
Message-ID: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F5__45663.2510213696$1222504271$gmane$org@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Alex@smtp1.linux-foundation.org, Grant Grundler <grundler@parisc-linux.org>, Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Reserve bus range for SR-IOV at device scanning stage.

Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Alex Chiang <achiang@hp.com>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/iov.c   |   24 ++++++++++++++++++++++++
 drivers/pci/pci.h   |    5 +++++
 drivers/pci/probe.c |    3 +++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index a2b2de9..17ada58 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -600,6 +600,30 @@ void pci_iov_remove_sysfs(struct pci_dev *dev)
        kfree(iov->ve);
 }

+/**
+ * pci_iov_bus_range - find bus range used by SR-IOV capability
+ * @bus: the PCI bus
+ *
+ * Returns max number of buses (exclude current one) used by Virtual
+ * Functions.
+ */
+int pci_iov_bus_range(struct pci_bus *bus)
+{
+       int max = 0;
+       u8 busnr, devfn;
+       struct pci_dev *dev;
+
+       list_for_each_entry(dev, &bus->devices, bus_list) {
+               if (!dev->iov)
+                       continue;
+               vf_rid(dev, dev->iov->totalvfs - 1, &busnr, &devfn);
+               if (busnr > max)
+                       max = busnr;
+       }
+
+       return max ? max - bus->number : 0;
+}
+
 int pci_iov_resource_align(struct pci_dev *dev, int resno)
 {
        if (resno < PCI_IOV_RESOURCES || resno > PCI_IOV_RESOURCES_END)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 11b1d17..7039243 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -208,6 +208,7 @@ void pci_iov_remove_sysfs(struct pci_dev *dev);
 extern int pci_iov_resource_align(struct pci_dev *dev, int resno);
 extern int pci_iov_resource_bar(struct pci_dev *dev, int resno,
                                enum pci_bar_type *type);
+extern int pci_iov_bus_range(struct pci_bus *bus);
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
 {
@@ -231,6 +232,10 @@ static inline int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 {
        return 0;
 }
+extern inline int pci_iov_bus_range(struct pci_bus *bus)
+{
+       return 0;
+}
 #endif /* CONFIG_PCI_IOV */

 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f18174e..a0abcde 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1128,6 +1128,9 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
        for (devfn = 0; devfn < 0x100; devfn += 8)
                pci_scan_slot(bus, devfn);

+       /* Reserve buses for SR-IOV capability. */
+       max += pci_iov_bus_range(bus);
+
        /*
         * After performing arch-dependent fixup of the bus, look behind
         * all PCI-to-PCI bridges on this bus.
--
1.5.6.4
