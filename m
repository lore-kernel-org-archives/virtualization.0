From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 37/49] Staging: hv: vmbus: Get rid of an unused function in
	connection.c
Date: Mon,  6 Jun 2011 15:50:01 -0700
Message-ID: <1307400613-13234-37-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of an unused function in connection.c

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/connection.c   |   38 -------------------------------------
 drivers/staging/hv/hyperv_vmbus.h |    2 -
 2 files changed, 0 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index fc93bdf..7d7f1d5 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -185,44 +185,6 @@ cleanup:
 	return ret;
 }
 
-/*
- * vmbus_disconnect -
- * Sends a disconnect request on the partition service connection
- */
-int vmbus_disconnect(void)
-{
-	int ret = 0;
-	struct vmbus_channel_message_header *msg;
-
-	/* Make sure we are connected */
-	if (vmbus_connection.conn_state != CONNECTED)
-		return -1;
-
-	msg = kzalloc(sizeof(struct vmbus_channel_message_header), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->msgtype = CHANNELMSG_UNLOAD;
-
-	ret = vmbus_post_msg(msg,
-			       sizeof(struct vmbus_channel_message_header));
-	if (ret != 0)
-		goto cleanup;
-
-	free_pages((unsigned long)vmbus_connection.int_page, 0);
-	free_pages((unsigned long)vmbus_connection.monitor_pages, 1);
-
-	/* TODO: iterate thru the msg list and free up */
-	destroy_workqueue(vmbus_connection.work_queue);
-
-	vmbus_connection.conn_state = DISCONNECTED;
-
-	pr_info("hv_vmbus disconnected\n");
-
-cleanup:
-	kfree(msg);
-	return ret;
-}
 
 /*
  * relid2channel - Get the channel object given its
diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/staging/hv/hyperv_vmbus.h
index bf30a42..349ad80 100644
--- a/drivers/staging/hv/hyperv_vmbus.h
+++ b/drivers/staging/hv/hyperv_vmbus.h
@@ -619,8 +619,6 @@ struct vmbus_channel *relid2channel(u32 relid);
 
 int vmbus_connect(void);
 
-int vmbus_disconnect(void);
-
 int vmbus_post_msg(void *buffer, size_t buflen);
 
 int vmbus_set_event(u32 child_relid);
-- 
1.7.4.1
