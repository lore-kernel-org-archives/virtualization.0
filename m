From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 6/6] Staging: hv: connection.c Removed DPRINT replaced with pr_XX
Date: Tue, 22 Feb 2011 15:32:45 -0800
Message-ID: <1298417565-12356-6-git-send-email-hjanssen@microsoft.com>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
 <1298417565-12356-2-git-send-email-hjanssen@microsoft.com>
 <1298417565-12356-3-git-send-email-hjanssen@microsoft.com>
 <1298417565-12356-4-git-send-email-hjanssen@microsoft.com>
 <1298417565-12356-5-git-send-email-hjanssen@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1298417565-12356-5-git-send-email-hjanssen@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hjanssen@microsoft.com, haiyangz@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

This group of patches removes all DPRINT from hv_vmbus.ko.
It is divided in several patches due to size.

All DPRINT calls have been removed, and where needed have been
replaced with pr_XX native calls. Many debug DPRINT calls have
been removed outright.

The amount of clutter this driver prints has been
significantly reduced.

Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

---
 drivers/staging/hv/connection.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index f7df479..2e9c0b7 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -121,11 +121,6 @@ int vmbus_connect(void)
 
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 
-	DPRINT_DBG(VMBUS, "Vmbus connection - interrupt pfn %llx, "
-		   "monitor1 pfn %llx,, monitor2 pfn %llx",
-		   msg->interrupt_page, msg->monitor_page1, msg->monitor_page2);
-
-	DPRINT_DBG(VMBUS, "Sending channel initiate msg...");
 	ret = vmbus_post_msg(msg,
 			       sizeof(struct vmbus_channel_initiate_contact));
 	if (ret != 0) {
@@ -156,13 +151,12 @@ int vmbus_connect(void)
 
 	/* Check if successful */
 	if (msginfo->response.version_response.version_supported) {
-		DPRINT_INFO(VMBUS, "Vmbus connected!!");
+		pr_info("%s: Connected to Hyper-V.", VMBUS_MOD);
 		vmbus_connection.conn_state = CONNECTED;
-
 	} else {
-		DPRINT_ERR(VMBUS, "Vmbus connection failed!!..."
-			   "current version (%d) not supported",
-			   VMBUS_REVISION_NUMBER);
+		pr_err("%s: %s Unable to connect, "
+		       "Version %d not supported by Hyper-V ",
+		       VMBUS_MOD, __func__, VMBUS_REVISION_NUMBER);
 		ret = -1;
 		goto Cleanup;
 	}
@@ -225,7 +219,7 @@ int vmbus_disconnect(void)
 
 	vmbus_connection.conn_state = DISCONNECTED;
 
-	DPRINT_INFO(VMBUS, "Vmbus disconnected!!");
+	pr_info("%s: Vmbus disconnected.", VMBUS_MOD);
 
 Cleanup:
 	kfree(msg);
@@ -278,7 +272,8 @@ static void process_chn_event(void *context)
 		 *			  (void*)channel);
 		 */
 	} else {
-		DPRINT_ERR(VMBUS, "channel not found for relid - %d.", relid);
+		pr_err("%s: %s channel not found for relid - %d.",
+		       VMBUS_MOD, __func__, relid);
 	}
 }
 
@@ -302,11 +297,13 @@ void vmbus_on_event(void)
 						(unsigned long *)
 						&recv_int_page[dword])) {
 						relid = (dword << 5) + bit;
-						DPRINT_DBG(VMBUS, "event detected for relid - %d", relid);
 
 						if (relid == 0) {
-							/* special case - vmbus channel protocol msg */
-							DPRINT_DBG(VMBUS, "invalid relid - %d", relid);
+							/*
+							 * special case -
+							 * vmbus channel
+							 * protocol msg
+							 */
 							continue;
 						} else {
 							/* QueueWorkItem(VmbusProcessEvent, (void*)relid); */
-- 
1.6.0.2
