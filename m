From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 110/206] Staging: hv: Rename the variable messageHandler
Date: Mon,  9 May 2011 14:56:32 -0700
Message-ID: <1304978288-22999-110-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 71b79c6..bc6e235 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -35,7 +35,7 @@
 
 struct vmbus_channel_message_table_entry {
 	enum vmbus_channel_message_type messageType;
-	void (*messageHandler)(struct vmbus_channel_message_header *msg);
+	void (*message_handler)(struct vmbus_channel_message_header *msg);
 };
 
 #define MAX_MSG_TYPES                    4
@@ -740,8 +740,8 @@ void vmbus_onmessage(void *context)
 		return;
 	}
 
-	if (gChannelMessageTable[hdr->msgtype].messageHandler)
-		gChannelMessageTable[hdr->msgtype].messageHandler(hdr);
+	if (gChannelMessageTable[hdr->msgtype].message_handler)
+		gChannelMessageTable[hdr->msgtype].message_handler(hdr);
 	else
 		pr_err("Unhandled channel message type %d\n", hdr->msgtype);
 }
-- 
1.7.4.1
