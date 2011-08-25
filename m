From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 30/59] Staging: hv: vmbus: Get rid of unnecessary comments in
	channel.c
Date: Thu, 25 Aug 2011 09:48:56 -0700
Message-ID: <1314290965-2698-30-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of unnecessary comments in channel.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/channel.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index ebd7552..e02060e 100644
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
