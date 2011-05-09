From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 112/206] Staging: hv: Rename the variable gChannelMessageTable
Date: Mon,  9 May 2011 14:56:34 -0700
Message-ID: <1304978288-22999-112-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/channel_mgmt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index a8be565..95eef92 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -698,7 +698,7 @@ static void vmbus_onversion_response(
 
 /* Channel message dispatch table */
 static struct vmbus_channel_message_table_entry
-	gChannelMessageTable[CHANNELMSG_COUNT] = {
+	channel_message_table[CHANNELMSG_COUNT] = {
 	{CHANNELMSG_INVALID,			NULL},
 	{CHANNELMSG_OFFERCHANNEL,		vmbus_onoffer},
 	{CHANNELMSG_RESCIND_CHANNELOFFER,	vmbus_onoffer_rescind},
@@ -740,8 +740,8 @@ void vmbus_onmessage(void *context)
 		return;
 	}
 
-	if (gChannelMessageTable[hdr->msgtype].message_handler)
-		gChannelMessageTable[hdr->msgtype].message_handler(hdr);
+	if (channel_message_table[hdr->msgtype].message_handler)
+		channel_message_table[hdr->msgtype].message_handler(hdr);
 	else
 		pr_err("Unhandled channel message type %d\n", hdr->msgtype);
 }
-- 
1.7.4.1
