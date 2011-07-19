From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/8] Staging: hv: vmbus: Fix checkpatch warnings in connection.c
Date: Tue, 19 Jul 2011 11:44:19 -0700
Message-ID: <1311101065-23417-2-git-send-email-kys@microsoft.com>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
 <1311101065-23417-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311101065-23417-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix bunch of  checkpatch warnings in connection.c


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/connection.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 6aab802..66b7c4b 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -224,11 +224,11 @@ static void process_chn_event(u32 relid)
 	channel = relid2channel(relid);
 
 	spin_lock_irqsave(&channel->inbound_lock, flags);
-	if (channel && (channel->onchannel_callback != NULL)) {
+	if (channel && (channel->onchannel_callback != NULL))
 		channel->onchannel_callback(channel->channel_callback_context);
-	} else {
+	else
 		pr_err("channel not found for relid - %u\n", relid);
-	}
+
 	spin_unlock_irqrestore(&channel->inbound_lock, flags);
 }
 
@@ -250,16 +250,17 @@ void vmbus_on_event(unsigned long data)
 		if (!recv_int_page[dword])
 			continue;
 		for (bit = 0; bit < 32; bit++) {
-			if (sync_test_and_clear_bit(bit, (unsigned long *)&recv_int_page[dword])) {
+			if (sync_test_and_clear_bit(bit,
+				(unsigned long *)&recv_int_page[dword])) {
 				relid = (dword << 5) + bit;
 
-				if (relid == 0) {
+				if (relid == 0)
 					/*
 					 * Special case - vmbus
 					 * channel protocol msg
 					 */
 					continue;
-				}
+
 				process_chn_event(relid);
 			}
 		}
-- 
1.7.4.1
