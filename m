From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 30/49] Staging: hv: vmbus: Get rid of the unused function
	vmbus_ontimer()
Date: Mon,  6 Jun 2011 15:49:54 -0700
Message-ID: <1307400613-13234-30-git-send-email-kys@microsoft.com>
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

Now, get rid of the unused function vmbus_ontimer().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/channel.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index b91b369..3e4422b 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -874,15 +874,3 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vmbus_recvpacket_raw);
-
-/*
- * vmbus_ontimer - Timer event callback
- */
-void vmbus_ontimer(unsigned long data)
-{
-	struct vmbus_channel *channel = (struct vmbus_channel *)data;
-
-	if (channel->onchannel_callback)
-		channel->onchannel_callback(channel->channel_callback_context);
-}
-
-- 
1.7.4.1
