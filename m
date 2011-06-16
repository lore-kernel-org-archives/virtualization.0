From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 47/77] Staging: hv: vmbus: Get rid of unnecessary comments in channel.c
Date: Thu, 16 Jun 2011 13:17:20 -0700
Message-ID: <1308255470-3826-47-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of unnecessary comments in channel.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 1d6143a..8065775 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -76,7 +76,6 @@ void vmbus_get_debug_info(struct vmbus_channel *channel,
 	struct hv_monitor_page *monitorpage;
 	u8 monitor_group = (u8)channel->offermsg.monitorid / 32;
 	u8 monitor_offset = (u8)channel->offermsg.monitorid % 32;
-	/* u32 monitorBit	= 1 << monitorOffset; */
 
 	debuginfo->relid = channel->offermsg.child_relid;
 	debuginfo->state = channel->state;
@@ -392,7 +391,6 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 {
 	struct vmbus_channel_gpadl_header *gpadlmsg;
 	struct vmbus_channel_gpadl_body *gpadl_body;
-	/* struct vmbus_channel_gpadl_created *gpadlCreated; */
 	struct vmbus_channel_msginfo *msginfo = NULL;
 	struct vmbus_channel_msginfo *submsginfo;
 	u32 msgcount;
@@ -474,8 +472,6 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	unsigned long flags;
 	int ret, t;
 
-	/* ASSERT(gpadl_handle != 0); */
-
 	info = kmalloc(sizeof(*info) +
 		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
 	if (!info)
-- 
1.7.4.1
