From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 33/46] Staging: hv: vmbus: Check before invoking the channel callback
Date: Sat, 27 Aug 2011 11:31:32 -0700
Message-ID: <1314469905-7058-33-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

When we close a channel, we set the corresponding callback function to NULL.
Check before invoking the channel callback.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/connection.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index a88ad70..7a3ec75 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -222,7 +222,7 @@ static void process_chn_event(u32 relid)
 	 */
 	channel = relid2channel(relid);
 
-	if (channel) {
+	if (channel && (channel->onchannel_callback != NULL)) {
 		channel->onchannel_callback(channel->channel_callback_context);
 	} else {
 		pr_err("channel not found for relid - %u\n", relid);
-- 
1.7.4.1
