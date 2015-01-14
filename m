From: jhansen@vmware.com
Subject: [PATCH] VMCI: Fix two UVA mapping bugs
Date: Wed, 14 Jan 2015 11:10:19 -0800
Message-ID: <1421262619-9243-1-git-send-email-jhansen__47510.2117205553$1421291958$gmane$org@vmware.com>
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

From: Jorgen Hansen <jhansen@vmware.com>

(this is a resend of this patch. Originally sent last year, but post
 appears to have been lost)

This change fixes two bugs in the VMCI host driver related to mapping
the notify boolean from user space into kernel space:
- the actual UVA was rounded up to the next page boundary - resulting
  in memory corruption in the calling process whenever notifications
  would be signalled. This has been fixed by just removing the
  PAGE_ALIGN part, since get_user_pages_fast can figure this out on
  its own
- the mapped page wasn't stored anywhere, so it wasn't unmapped and
  put back when a VMCI context was destroyed. Fixed this by
  remembering the page.

Acked-by: Andy King <acking@vmware.com>
Acked-by: Darius Davis <darius@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_driver.c |    2 +-
 drivers/misc/vmw_vmci/vmci_host.c   |   13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index 3dee7ae..032d35c 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.0.0-k");
+MODULE_VERSION("1.1.1.0-k");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 1723a6e..66fc992 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -218,13 +218,12 @@ static int drv_cp_harray_to_user(void __user *user_buf_uva,
 }
 
 /*
- * Sets up a given context for notify to work.  Calls drv_map_bool_ptr()
- * which maps the notify boolean in user VA in kernel space.
+ * Sets up a given context for notify to work. Maps the notify
+ * boolean in user VA into kernel space.
  */
 static int vmci_host_setup_notify(struct vmci_ctx *context,
 				  unsigned long uva)
 {
-	struct page *page;
 	int retval;
 
 	if (context->notify_page) {
@@ -243,14 +242,16 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
 	/*
 	 * Lock physical page backing a given user VA.
 	 */
-	retval = get_user_pages_fast(PAGE_ALIGN(uva), 1, 1, &page);
-	if (retval != 1)
+	retval = get_user_pages_fast(uva, 1, 1, &context->notify_page);
+	if (retval != 1) {
+		context->notify_page = NULL;
 		return VMCI_ERROR_GENERIC;
+	}
 
 	/*
 	 * Map the locked page and set up notify pointer.
 	 */
-	context->notify = kmap(page) + (uva & (PAGE_SIZE - 1));
+	context->notify = kmap(context->notify_page) + (uva & (PAGE_SIZE - 1));
 	vmci_ctx_check_signal_notify(context);
 
 	return VMCI_SUCCESS;
-- 
1.7.0
