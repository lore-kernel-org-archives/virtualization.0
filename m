From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 21/29] PCI, xen: Use for_each_pci_resource() with xen pci
Date: Fri, 12 Apr 2013 15:44:35 -0700
Message-ID: <1365806683-26717-22-git-send-email-yinghai__42193.4308288202$1365810929$gmane$org@kernel.org>
References: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: virtualization@lists.linux-foundation.org
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/pci/xen-pcifront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 966abc6..c90835f 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -395,9 +395,7 @@ static int pcifront_claim_resource(struct pci_dev *dev, void *data)
 	int i;
 	struct resource *r;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		r = &dev->resource[i];
-
+	for_each_pci_resource(dev, r, i, PCI_ALL_RES) {
 		if (!r->parent && r->start && r->flags) {
 			dev_info(&pdev->xdev->dev, "claiming resource %s/%d\n",
 				pci_name(dev), i);
-- 
1.8.1.4
