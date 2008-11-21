From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 4/13 v7] PCI: remove unnecessary condition check in
	pci_restore_bars()
Date: Sat, 22 Nov 2008 02:40:00 +0800
Message-ID: <20081121184000.GE7810__39515.4336271391$1227296416$gmane$org@yzhao12-linux.sh.intel.com>
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

Remove the unnecessary number of resources condition checks because
the pci_update_resource() will check availability of the resources.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/pci.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c408be8..9d3f793 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -360,24 +360,9 @@ pci_find_parent_resource(const struct pci_dev *dev, struct resource *res)
 static void
 pci_restore_bars(struct pci_dev *dev)
 {
-	int i, numres;
-
-	switch (dev->hdr_type) {
-	case PCI_HEADER_TYPE_NORMAL:
-		numres = 6;
-		break;
-	case PCI_HEADER_TYPE_BRIDGE:
-		numres = 2;
-		break;
-	case PCI_HEADER_TYPE_CARDBUS:
-		numres = 1;
-		break;
-	default:
-		/* Should never get here, but just in case... */
-		return;
-	}
+	int i;
 
-	for (i = 0; i < numres; i++)
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
 		pci_update_resource(dev, i);
 }
 
-- 
1.5.6.4
