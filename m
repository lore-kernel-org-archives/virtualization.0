From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 11:28:41 +0300
Message-ID: <20090507082841.GA31751__39108.273437205$1241685263$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

pci_enable_msix currently returns -EINVAL if you ask
for more vectors than supported by the device, which would
typically cause fallback to regular interrupts.

It's better to return the table size, making the driver retry
MSI-X with less vectors.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Hi Jesse,
This came up when I was adding MSI-X support to virtio pci driver,
which does not know the exact table size upfront.
Could you consider this patch for 2.6.31 please?


 drivers/pci/msi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6f2e629..f5bd1c9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -687,8 +687,8 @@ int pci_msix_table_size(struct pci_dev *dev)
  * indicates the successful configuration of MSI-X capability structure
  * with new allocated MSI-X irqs. A return of < 0 indicates a failure.
  * Or a return of > 0 indicates that driver request is exceeding the number
- * of irqs available. Driver should use the returned value to re-send
- * its request.
+ * of irqs or MSI-X vectors available. Driver should use the returned value to
+ * re-send its request.
  **/
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
@@ -704,7 +704,7 @@ int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 
 	nr_entries = pci_msix_table_size(dev);
 	if (nvec > nr_entries)
-		return -EINVAL;
+		return nr_entries;
 
 	/* Check for any invalid entries */
 	for (i = 0; i < nvec; i++) {
-- 
1.6.3.rc3.1.g830204
