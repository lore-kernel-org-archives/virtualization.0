From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/4] Staging: hv: vmbus: Cleanup the code in process_chn_event()
Date: Wed, 31 Aug 2011 14:35:57 -0700
Message-ID: <1314826557-28755-4-git-send-email-kys@microsoft.com>
References: <1314826529-28716-1-git-send-email-kys@microsoft.com>
 <1314826557-28755-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314826557-28755-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

A channel in Hyper-V is equivalent to a device. Thus, a channel is
persistent once it is presented to the guest, even if the driver
managing this device is unloaded. By checking and invoking the driver
specific callback function under the protection of the channel
inbound_lock, we can properly deal with racing driver unloads since an
unloading driver sets the callback to NULL under the protection of this
inbound_lock.



Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/connection.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 9e99c04..649b91b 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -219,11 +219,25 @@ static void process_chn_event(u32 relid)
 	 */
 	channel = relid2channel(relid);
 
+	if (!channel) {
+		pr_err("channel not found for relid - %u\n", relid);
+		return;
+	}
+
+	/*
+	 * A channel once created is persistent even when there
+	 * is no driver handling the device. An unloading driver
+	 * sets the onchannel_callback to NULL under the
+	 * protection of the channel inbound_lock. Thus, checking
+	 * and invoking the driver specific callback takes care of
+	 * orderly unloading of the driver.
+	 */
+
 	spin_lock_irqsave(&channel->inbound_lock, flags);
-	if (channel && (channel->onchannel_callback != NULL))
+	if (channel->onchannel_callback != NULL)
 		channel->onchannel_callback(channel->channel_callback_context);
 	else
-		pr_err("channel not found for relid - %u\n", relid);
+		pr_err("no channel callback for relid - %u\n", relid);
 
 	spin_unlock_irqrestore(&channel->inbound_lock, flags);
 }
-- 
1.7.4.1
