From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 118/206] Staging: hv: Change Cleanup to cleanup
Date: Mon,  9 May 2011 14:56:40 -0700
Message-ID: <1304978288-22999-118-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/connection.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 92add38..3632bcc 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -58,7 +58,7 @@ int vmbus_connect(void)
 	vmbus_connection.work_queue = create_workqueue("hv_vmbus_con");
 	if (!vmbus_connection.work_queue) {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	INIT_LIST_HEAD(&vmbus_connection.chn_msg_list);
@@ -75,7 +75,7 @@ int vmbus_connect(void)
 	(void *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, 0);
 	if (vmbus_connection.int_page == NULL) {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	vmbus_connection.recv_int_page = vmbus_connection.int_page;
@@ -91,7 +91,7 @@ int vmbus_connect(void)
 	(void *)__get_free_pages((GFP_KERNEL|__GFP_ZERO), 1);
 	if (vmbus_connection.monitor_pages == NULL) {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	msginfo = kzalloc(sizeof(*msginfo) +
@@ -99,7 +99,7 @@ int vmbus_connect(void)
 			  GFP_KERNEL);
 	if (msginfo == NULL) {
 		ret = -ENOMEM;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	init_completion(&msginfo->waitevent);
@@ -131,7 +131,7 @@ int vmbus_connect(void)
 		list_del(&msginfo->msglistentry);
 		spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock,
 					flags);
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	/* Wait for the connection response */
@@ -143,7 +143,7 @@ int vmbus_connect(void)
 		spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock,
 					flags);
 		ret = -ETIMEDOUT;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
@@ -158,13 +158,13 @@ int vmbus_connect(void)
 			"Version %d not supported by Hyper-V\n",
 			VMBUS_REVISION_NUMBER);
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	kfree(msginfo);
 	return 0;
 
-Cleanup:
+cleanup:
 	vmbus_connection.conn_state = DISCONNECTED;
 
 	if (vmbus_connection.work_queue)
@@ -207,7 +207,7 @@ int vmbus_disconnect(void)
 	ret = vmbus_post_msg(msg,
 			       sizeof(struct vmbus_channel_message_header));
 	if (ret != 0)
-		goto Cleanup;
+		goto cleanup;
 
 	free_pages((unsigned long)vmbus_connection.int_page, 0);
 	free_pages((unsigned long)vmbus_connection.monitor_pages, 1);
@@ -219,7 +219,7 @@ int vmbus_disconnect(void)
 
 	pr_info("hv_vmbus disconnected\n");
 
-Cleanup:
+cleanup:
 	kfree(msg);
 	return ret;
 }
-- 
1.7.4.1
