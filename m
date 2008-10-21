From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 13/15 v5] PCI: reserve bus range for the SR-IOV device
Date: Tue, 21 Oct 2008 19:53:32 +0800
Message-ID: <20081021115332.GN3185__3435.04561246863$1224595491$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081021114056.GA3185@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081021114056.GA3185@yzhao12-linux.sh.intel.com>
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
 drivers/pci/pci.h   |    5 +++++
 drivers/pci/probe.c |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7735d92..5206ae7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -204,6 +204,7 @@ void pci_iov_remove_sysfs(struct pci_dev *dev);
 extern int pci_iov_resource_align(struct pci_dev *dev, int resno);
 extern int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 				enum pci_bar_type *type);
+extern int pci_iov_bus_range(struct pci_bus *bus);
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
 {
@@ -227,6 +228,10 @@ static inline int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 {
 	return 0;
 }
+extern inline int pci_iov_bus_range(struct pci_bus *bus)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_IOV */
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 18ce9c0..50a1380 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1068,6 +1068,9 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
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
