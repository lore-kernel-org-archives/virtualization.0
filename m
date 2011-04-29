From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 02/18] Staging: hv: Get rid of
	vmbus_release_unattached_channels() as it is not used
Date: Fri, 29 Apr 2011 13:45:00 -0700
Message-ID: <1304109916-24874-2-git-send-email-kys@microsoft.com>
References: <1304109779-24819-1-git-send-email-kys@microsoft.com>
	<1304109916-24874-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304109916-24874-1-git-send-email-kys@microsoft.com>
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

Since vmbus_release_unattached_channels() is only used in module
unload path and since the vmbus driver cannot be unloaded,
get rid of this "dead" code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c |   33 ---------------------------------
 drivers/staging/hv/channel_mgmt.h |    2 --
 2 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index fe32f7e..1929ab3 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -791,37 +791,4 @@ cleanup:
 	return ret;
 }
 
-/*
- * vmbus_release_unattached_channels - Release channels that are
- * unattached/unconnected ie (no drivers associated)
- */
-void vmbus_release_unattached_channels(void)
-{
-	struct vmbus_channel *channel, *pos;
-	struct vmbus_channel *start = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&vmbus_connection.channel_lock, flags);
-
-	list_for_each_entry_safe(channel, pos, &vmbus_connection.chn_list,
-				 listentry) {
-		if (channel == start)
-			break;
-
-		if (!channel->device_obj->drv) {
-			list_del(&channel->listentry);
-
-			pr_err("Releasing unattached device object\n");
-
-			vmbus_child_device_unregister(channel->device_obj);
-			free_channel(channel);
-		} else {
-			if (!start)
-				start = channel;
-		}
-	}
-
-	spin_unlock_irqrestore(&vmbus_connection.channel_lock, flags);
-}
-
 /* eof */
diff --git a/drivers/staging/hv/channel_mgmt.h b/drivers/staging/hv/channel_mgmt.h
index 96f74e2..3b2c393 100644
--- a/drivers/staging/hv/channel_mgmt.h
+++ b/drivers/staging/hv/channel_mgmt.h
@@ -315,6 +315,4 @@ void vmbus_onmessage(void *context);
 
 int vmbus_request_offers(void);
 
-void vmbus_release_unattached_channels(void);
-
 #endif /* _CHANNEL_MGMT_H_ */
-- 
1.7.4.1
