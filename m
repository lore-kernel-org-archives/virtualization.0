From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH] VMCI: Verify PPNs before sending to device
Date: Fri, 11 Jan 2019 08:57:45 -0800
Message-ID: <1547225865-53408-1-git-send-email-jhansen__22743.1749379777$1547693067$gmane$org@vmware.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

The current version of the VMCI device only supports 32 bit PPNs,
so check whether we are truncating PPNs, and fail the operation
if we do. One such check did exist, but was wrong. Another
check was missing.

Testing through code modification: constructed PPN not representable
by 32-bit and observed that failure was reported.

Fixes: 1f166439917b ("VMCI: guest side driver implementation.")
Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")

Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c      | 10 +++++++---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 10 ++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index dad5abee656e..02bb3866cf9e 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -532,10 +532,14 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	if (capabilities & VMCI_CAPS_NOTIFICATIONS) {
 		unsigned long bitmap_ppn =
 			vmci_dev->notification_base >> PAGE_SHIFT;
-		if (!vmci_dbell_register_notification_bitmap(bitmap_ppn)) {
+		u32 bitmap_ppn32 = bitmap_ppn;
+
+		if ((sizeof(bitmap_ppn) > sizeof(bitmap_ppn32)
+		     && bitmap_ppn != bitmap_ppn32) ||
+		    !vmci_dbell_register_notification_bitmap(bitmap_ppn)) {
 			dev_warn(&pdev->dev,
-				 "VMCI device unable to register notification bitmap with PPN 0x%x\n",
-				 (u32) bitmap_ppn);
+				 "VMCI device unable to register notification bitmap with PPN 0x%lx\n",
+				 bitmap_ppn);
 			error = -ENXIO;
 			goto err_remove_vmci_dev_g;
 		}
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 264f4ed8eef2..1da4f6cb01b2 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -465,9 +465,8 @@ static int qp_alloc_ppn_set(void *prod_q,
 	for (i = 0; i < num_produce_pages; i++) {
 		unsigned long pfn;
 
-		produce_ppns[i] =
-			produce_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
-		pfn = produce_ppns[i];
+		pfn = produce_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
+		produce_ppns[i] = pfn;
 
 		/* Fail allocation if PFN isn't supported by hypervisor. */
 		if (sizeof(pfn) > sizeof(*produce_ppns)
@@ -478,9 +477,8 @@ static int qp_alloc_ppn_set(void *prod_q,
 	for (i = 0; i < num_consume_pages; i++) {
 		unsigned long pfn;
 
-		consume_ppns[i] =
-			consume_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
-		pfn = consume_ppns[i];
+		pfn = consume_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
+		consume_ppns[i] = pfn;
 
 		/* Fail allocation if PFN isn't supported by hypervisor. */
 		if (sizeof(pfn) > sizeof(*consume_ppns)
-- 
2.17.1
