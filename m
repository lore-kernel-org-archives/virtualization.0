From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 11/13 v7] PCI: reserve bus range for SR-IOV device
Date: Sat, 22 Nov 2008 02:43:39 +0800
Message-ID: <20081121184339.GL7810__29262.2598041364$1227296899$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "greg@kroah.com" <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

Reserve bus range for SR-IOV at device scanning stage when the kernel
boot parameter 'pci=assign-busses' is used .

Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/iov.c   |   24 ++++++++++++++++++++++++
 drivers/pci/pci.h   |    6 ++++++
 drivers/pci/probe.c |    3 +++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 03f62ca..c1a3cea 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -489,3 +489,27 @@ void pci_iov_unregister(struct pci_dev *dev)
 	iov_disable(dev);
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
 }
+
+/**
+ * pci_iov_bus_range - find bus range used by the Virtual Function
+ * @bus: the PCI bus
+ *
+ * Returns max number of buses (exclude current one) used by Virtual
+ * Functions.
+ */
+int pci_iov_bus_range(struct pci_bus *bus)
+{
+	int max = 0;
+	u8 busnr, devfn;
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!dev->iov)
+			continue;
+		virtfn_bdf(dev, dev->iov->total - 1, &busnr, &devfn);
+		if (busnr > max)
+			max = busnr;
+	}
+
+	return max ? max - bus->number : 0;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3113d11..574bbc7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -205,6 +205,7 @@ extern int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 extern int pci_iov_register(struct pci_dev* dev);
 extern void pci_iov_unregister(struct pci_dev* dev);
 extern void pci_restore_iov_state(struct pci_dev *dev);
+extern int pci_iov_bus_range(struct pci_bus *bus);
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
 {
@@ -232,6 +233,11 @@ static inline void pci_iov_unregister(struct pci_dev* dev)
 static inline void pci_restore_iov_state(struct pci_dev *dev)
 {
 }
+
+static inline int pci_iov_bus_range(struct pci_bus *bus)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_IOV */
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cb26e64..7b591e5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1074,6 +1074,9 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
 	for (devfn = 0; devfn < 0x100; devfn += 8)
 		pci_scan_slot(bus, devfn);
 
+	/* Reserve buses for SR-IOV capability. */
+	max += pci_iov_bus_range(bus);
+
 	/*
 	 * After performing arch-dependent fixup of the bus, look behind
 	 * all PCI-to-PCI bridges on this bus.
-- 
1.5.6.4
