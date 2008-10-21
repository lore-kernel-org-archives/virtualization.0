From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 7/15 v5] PCI: cleanup pcibios_allocate_resources()
Date: Tue, 21 Oct 2008 19:48:52 +0800
Message-ID: <20081021114852.GH3185__45896.9297273599$1224594245$gmane$org@yzhao12-linux.sh.intel.com>
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

This cleanup makes pcibios_allocate_resources() easier to be read.

Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Alex Chiang <achiang@hp.com>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 arch/x86/pci/i386.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 844df0c..8729bde 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -147,7 +147,7 @@ static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
 static void __init pcibios_allocate_resources(int pass)
 {
 	struct pci_dev *dev = NULL;
-	int idx, disabled;
+	int idx, enabled;
 	u16 command;
 	struct resource *r, *pr;
 
@@ -160,22 +160,22 @@ static void __init pcibios_allocate_resources(int pass)
 			if (!r->start)		/* Address not assigned at all */
 				continue;
 			if (r->flags & IORESOURCE_IO)
-				disabled = !(command & PCI_COMMAND_IO);
+				enabled = command & PCI_COMMAND_IO;
 			else
-				disabled = !(command & PCI_COMMAND_MEMORY);
-			if (pass == disabled) {
-				dev_dbg(&dev->dev, "resource %#08llx-%#08llx (f=%lx, d=%d, p=%d)\n",
+				enabled = command & PCI_COMMAND_MEMORY;
+			if (pass == enabled)
+				continue;
+			dev_dbg(&dev->dev, "resource %#08llx-%#08llx (f=%lx, d=%d, p=%d)\n",
 					(unsigned long long) r->start,
 					(unsigned long long) r->end,
-					r->flags, disabled, pass);
-				pr = pci_find_parent_resource(dev, r);
-				if (!pr || request_resource(pr, r) < 0) {
-					dev_err(&dev->dev, "BAR %d: can't allocate resource\n", idx);
-					/* We'll assign a new address later */
-					r->end -= r->start;
-					r->start = 0;
-				}
-			}
+					r->flags, enabled, pass);
+			pr = pci_find_parent_resource(dev, r);
+			if (pr && !request_resource(pr, r))
+				continue;
+			dev_err(&dev->dev, "BAR %d: can't allocate resource\n", idx);
+			/* We'll assign a new address later */
+			r->end -= r->start;
+			r->start = 0;
 		}
 		if (!pass) {
 			r = &dev->resource[PCI_ROM_RESOURCE];
-- 
1.5.6.4
