From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 3/8 v4] PCI: export pci_alloc_child_bus
Date: Tue, 14 Oct 2008 18:53:23 +0800
Message-ID: <20081014105323.GC1734__20939.8053041243$1223985400$gmane$org@yzhao12-linux.sh.intel.com>
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

Export pci_alloc_child_bus(), and make it be able to handle buses without
bridge devices. Some devices such as SR-IOV devices use more than one bus
number while there is no explicit bridge devices since they have internal
routing mechanism.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/pci.h   |    2 ++
 drivers/pci/probe.c |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 922b742..c6fa8ab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -159,6 +159,8 @@ enum pci_bar_type {
 
 extern int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 				struct resource *res, unsigned int reg);
+extern struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
+				struct pci_dev *bridge, int busnr);
 extern void pci_enable_ari(struct pci_dev *dev);
 /**
  * pci_ari_enabled - query ARI forwarding status
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2326609..9c680b8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -454,7 +454,7 @@ static struct pci_bus * pci_alloc_bus(void)
 	return b;
 }
 
-static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
+struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
 {
 	struct pci_bus *child;
@@ -467,12 +467,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	if (!child)
 		return NULL;
 
-	child->self = bridge;
 	child->parent = parent;
 	child->ops = parent->ops;
 	child->sysdata = parent->sysdata;
 	child->bus_flags = parent->bus_flags;
-	child->bridge = get_device(&bridge->dev);
 
 	/* initialize some portions of the bus device, but don't register it
 	 * now as the parent is not properly set up yet.  This device will get
@@ -489,6 +487,11 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->primary = parent->secondary;
 	child->subordinate = 0xff;
 
+	if (!bridge)
+		return child;
+
+	child->self = bridge;
+	child->bridge = get_device(&bridge->dev);
 	/* Set up default resource pointers and names.. */
 	for (i = 0; i < PCI_BRIDGE_RES_NUM; i++) {
 		child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
-- 
1.5.6.4
