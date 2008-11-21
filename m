From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 1/13 v7] PCI: enhance pci_ari_enabled()
Date: Sat, 22 Nov 2008 02:38:21 +0800
Message-ID: <20081121183821.GB7810__38029.8608834439$1227296387$gmane$org@yzhao12-linux.sh.intel.com>
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

Change parameter of pci_ari_enabled() from 'pci_dev' to 'pci_bus'.

ARI forwarding on the bridge mostly concerns the subordinate devices
rather than the bridge itself. So this change will make the function
easier to use.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/pci.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9de87e9..1449884 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -162,13 +162,13 @@ struct pci_slot_attribute {
 extern void pci_enable_ari(struct pci_dev *dev);
 /**
  * pci_ari_enabled - query ARI forwarding status
- * @dev: the PCI device
+ * @bus: the PCI bus
  *
  * Returns 1 if ARI forwarding is enabled, or 0 if not enabled;
  */
-static inline int pci_ari_enabled(struct pci_dev *dev)
+static inline int pci_ari_enabled(struct pci_bus *bus)
 {
-	return dev->ari_enabled;
+	return bus->self && bus->self->ari_enabled;
 }
 
 #endif /* DRIVERS_PCI_H */
-- 
1.5.6.4
