From: Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VMCI: Doorbell create and destroy fixes
Date: Thu, 6 Oct 2016 04:43:08 -0700
Message-ID: <1475754188-49351-1-git-send-email-jhansen@vmware.com>
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

This change consists of two changes:

1) If vmci_doorbell_create is called when neither guest nor
   host personality as been initialized, vmci_get_context_id
   will return VMCI_INVALID_ID. In that case, we should fail
   the create call.
2) In doorbell destroy, we assume that vmci_guest_code_active()
   has the same return value on create and destroy. That may not
   be the case, so we may end up with the wrong refcount.
   Instead, destroy should check explicitly whether the doorbell
   is in the index table as an indicator of whether the guest
   code was active at create time.

Reviewed-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_doorbell.c |    8 +++++++-
 drivers/misc/vmw_vmci/vmci_driver.c   |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_doorbell.c b/drivers/misc/vmw_vmci/vmci_doorbell.c
index a8cee33..b3fa738 100644
--- a/drivers/misc/vmw_vmci/vmci_doorbell.c
+++ b/drivers/misc/vmw_vmci/vmci_doorbell.c
@@ -431,6 +431,12 @@ int vmci_doorbell_create(struct vmci_handle *handle,
 	if (vmci_handle_is_invalid(*handle)) {
 		u32 context_id = vmci_get_context_id();
 
+		if (context_id == VMCI_INVALID_ID) {
+			pr_warn("Failed to get context ID\n");
+			result = VMCI_ERROR_NO_RESOURCES;
+			goto free_mem;
+		}
+
 		/* Let resource code allocate a free ID for us */
 		new_handle = vmci_make_handle(context_id, VMCI_INVALID_ID);
 	} else {
@@ -525,7 +531,7 @@ int vmci_doorbell_destroy(struct vmci_handle handle)
 
 	entry = container_of(resource, struct dbell_entry, resource);
 
-	if (vmci_guest_code_active()) {
+	if (!hlist_unhashed(&entry->node)) {
 		int result;
 
 		dbell_index_table_remove(entry);
diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index 896be15..d7eaf1e 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.4.0-k");
+MODULE_VERSION("1.1.5.0-k");
 MODULE_LICENSE("GPL v2");
-- 
1.7.0
