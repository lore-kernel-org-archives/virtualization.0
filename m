From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 11/49] Staging: hv: vmbus: Don't free the channel when the
	channel is closed
Date: Mon,  6 Jun 2011 15:49:35 -0700
Message-ID: <1307400613-13234-11-git-send-email-kys@microsoft.com>
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

When the driver unloads, the device must persist. A channel represents the 
device and so we should not free the channel when the channel is closed as 
part of the driver unloading.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/channel.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index f655e59..aca9ac8 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -552,7 +552,6 @@ void vmbus_close(struct vmbus_channel *channel)
 {
 	struct vmbus_channel_close_channel *msg;
 	struct vmbus_channel_msginfo *info;
-	unsigned long flags;
 	int ret;
 
 	/* Stop callback and cancel the timer asap */
@@ -591,19 +590,6 @@ void vmbus_close(struct vmbus_channel *channel)
 
 	kfree(info);
 
-	/*
-	 * If we are closing the channel during an error path in
-	 * opening the channel, don't free the channel since the
-	 * caller will free the channel
-	 */
-
-	if (channel->state == CHANNEL_OPEN_STATE) {
-		spin_lock_irqsave(&vmbus_connection.channel_lock, flags);
-		list_del(&channel->listentry);
-		spin_unlock_irqrestore(&vmbus_connection.channel_lock, flags);
-
-		free_channel(channel);
-	}
 }
 EXPORT_SYMBOL_GPL(vmbus_close);
 
-- 
1.7.4.1
