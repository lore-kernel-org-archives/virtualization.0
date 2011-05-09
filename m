From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 119/206] Staging: hv: Get rid of some dead code in connection.c
Date: Mon,  9 May 2011 14:56:41 -0700
Message-ID: <1304978288-22999-119-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid some commented code and dated comments.T

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/connection.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 3632bcc..dd62585 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -263,11 +263,6 @@ static void process_chn_event(u32 relid)
 
 	if (channel) {
 		vmbus_onchannel_event(channel);
-		/*
-		 * WorkQueueQueueWorkItem(channel->dataWorkQueue,
-		 *			  vmbus_onchannel_event,
-		 *			  (void*)channel);
-		 */
 	} else {
 		pr_err("channel not found for relid - %u\n", relid);
 	}
@@ -295,7 +290,10 @@ void vmbus_on_event(unsigned long data)
 				relid = (dword << 5) + bit;
 
 				if (relid == 0) {
-					/* special case - vmbus channel protocol msg */
+					/*
+					 * Special case - vmbus
+					 * channel protocol msg
+					 */
 					continue;
 				}
 				process_chn_event(relid);
-- 
1.7.4.1
