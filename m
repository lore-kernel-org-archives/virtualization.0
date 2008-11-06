From: Simon Horman <horms@verge.net.au>
Subject: Re: git repository for SR-IOV development?
Date: Fri, 7 Nov 2008 09:56:54 +1100
Message-ID: <20081106225654.GA2012__14818.2306126275$1226012356$gmane$org@verge.net.au>
References: <20081106165914.GA13476@kroah.com>
	<104014.9320.qm@web45110.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <104014.9320.qm@web45110.mail.sp1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: H L <swdevyid@yahoo.com>
Cc: randy.dunlap@oracle.com, Xen-devel List <xen-devel@lists.xensource.com>, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, Greg KH <greg@kroah.com>, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 06, 2008 at 11:58:25AM -0800, H L wrote:
> --- On Thu, 11/6/08, Greg KH <greg@kroah.com> wrote:
> 
> > On Thu, Nov 06, 2008 at 08:51:09AM -0800, H L wrote:
> > > 
> > > Has anyone initiated or given consideration to the
> > creation of a git
> > > repository (say, on kernel.org) for SR-IOV
> > development?
> > 
> > Why?  It's only a few patches, right?  Why would it
> > need a whole new git
> > tree?
> 
> 
> So as to minimize the time and effort patching a kernel, especially if
> the tree (and/or hash level) against which the patches were created fails
> to be specified on a mailing-list.  Plus, there appears to be questions
> raised on how, precisely, the implementation should ultimately be modeled
> and especially given that, who knows at this point what number of patches
> will ultimately be submitted?  I know I've built the "7-patch" one
> (painfully, by the way), and I'm aware there's another 15-patch set out
> there which I've not yet examined.

FWIW, the v6 patch series (this thread) applied to both 2.6.28-rc3
and the current Linus tree after a minor tweak to the first patch, as below.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en

From: Yu Zhao <yu.zhao@intel.com>

[PATCH 1/16 v6] PCI: remove unnecessary arg of pci_update_resource()

This cleanup removes unnecessary argument 'struct resource *res' in
pci_update_resource(), so it takes same arguments as other companion
functions (pci_assign_resource(), etc.).

Cc: Alex Chiang <achiang@hp.com>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <greg@kroah.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Roland Dreier <rdreier@cisco.com>
Signed-off-by: Yu Zhao <yu.zhao@intel.com>
Upported-by: Simon Horman <horms@verge.net.au>

---
 drivers/pci/pci.c       |    4 ++--
 drivers/pci/setup-res.c |    7 ++++---
 include/linux/pci.h     |    2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

* Fri, 07 Nov 2008 09:05:18 +1100, Simon Horman
  - Minor rediff of include/linux/pci.h section to apply to 2.6.28-rc3

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4db261e..ae62f01 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -376,8 +376,8 @@ pci_restore_bars(struct pci_dev *dev)
 		return;
 	}
 
-	for (i = 0; i < numres; i ++)
-		pci_update_resource(dev, &dev->resource[i], i);
+	for (i = 0; i < numres; i++)
+		pci_update_resource(dev, i);
 }
 
 static struct pci_platform_pm_ops *pci_platform_pm;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 2dbd96c..b7ca679 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -26,11 +26,12 @@
 #include "pci.h"
 
 
-void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
+void pci_update_resource(struct pci_dev *dev, int resno)
 {
 	struct pci_bus_region region;
 	u32 new, check, mask;
 	int reg;
+	struct resource *res = dev->resource + resno;
 
 	/*
 	 * Ignore resources for unimplemented BARs and unused resource slots
@@ -162,7 +163,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	} else {
 		res->flags &= ~IORESOURCE_STARTALIGN;
 		if (resno < PCI_BRIDGE_RESOURCES)
-			pci_update_resource(dev, res, resno);
+			pci_update_resource(dev, resno);
 	}
 
 	return ret;
@@ -197,7 +198,7 @@ int pci_assign_resource_fixed(struct pci_dev *dev, int resno)
 		dev_err(&dev->dev, "BAR %d: can't allocate %s resource %pR\n",
 			resno, res->flags & IORESOURCE_IO ? "I/O" : "mem", res);
 	} else if (resno < PCI_BRIDGE_RESOURCES) {
-		pci_update_resource(dev, res, resno);
+		pci_update_resource(dev, resno);
 	}
 
 	return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 085187b..43e1fc1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -626,7 +626,7 @@ int pcix_get_mmrbc(struct pci_dev *dev);
 int pcie_set_readrq(struct pci_dev *dev, int rq);
 int pci_reset_function(struct pci_dev *dev);
 int pci_execute_reset_function(struct pci_dev *dev);
-void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
+void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 
-- 
1.5.6.4

