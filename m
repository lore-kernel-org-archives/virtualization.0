From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 113/206] Staging: hv: Use completion abstraction to
	synchronize in vmbus_channel_msginfo
Date: Mon,  9 May 2011 14:56:35 -0700
Message-ID: <1304978288-22999-113-git-send-email-kys@microsoft.com>
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

Use completion abstraction to synchronize in vmbus_channel_msginfo.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel.c      |   31 ++++++++++++-------------------
 drivers/staging/hv/channel_mgmt.c |   31 ++++++++++++++-----------------
 drivers/staging/hv/channel_mgmt.h |    4 ++--
 drivers/staging/hv/connection.c   |    9 ++++-----
 4 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 5fcf9d3..1b50cb7 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -177,7 +177,7 @@ int vmbus_open(struct vmbus_channel *newchannel, u32 send_ringbuffer_size,
 	struct vmbus_channel_msginfo *openInfo = NULL;
 	void *in, *out;
 	unsigned long flags;
-	int ret, err = 0;
+	int ret, t, err = 0;
 
 	/* Aligned to page size */
 	/* ASSERT(!(SendRingBufferSize & (PAGE_SIZE - 1))); */
@@ -240,7 +240,7 @@ int vmbus_open(struct vmbus_channel *newchannel, u32 send_ringbuffer_size,
 		goto errorout;
 	}
 
-	init_waitqueue_head(&openInfo->waitevent);
+	init_completion(&openInfo->waitevent);
 
 	openMsg = (struct vmbus_channel_open_channel *)openInfo->msg;
 	openMsg->header.msgtype = CHANNELMSG_OPENCHANNEL;
@@ -270,11 +270,8 @@ int vmbus_open(struct vmbus_channel *newchannel, u32 send_ringbuffer_size,
 	if (ret != 0)
 		goto Cleanup;
 
-	openInfo->wait_condition = 0;
-	wait_event_timeout(openInfo->waitevent,
-			openInfo->wait_condition,
-			msecs_to_jiffies(1000));
-	if (openInfo->wait_condition == 0) {
+	t = wait_for_completion_timeout(&openInfo->waitevent, HZ);
+	if (t == 0) {
 		err = -ETIMEDOUT;
 		goto errorout;
 	}
@@ -495,6 +492,7 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 	u32 next_gpadl_handle;
 	unsigned long flags;
 	int ret = 0;
+	int t;
 
 	next_gpadl_handle = atomic_read(&vmbus_connection.next_gpadl_handle);
 	atomic_inc(&vmbus_connection.next_gpadl_handle);
@@ -503,7 +501,7 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 	if (ret)
 		return ret;
 
-	init_waitqueue_head(&msginfo->waitevent);
+	init_completion(&msginfo->waitevent);
 
 	gpadlmsg = (struct vmbus_channel_gpadl_header *)msginfo->msg;
 	gpadlmsg->header.msgtype = CHANNELMSG_GPADL_HEADER;
@@ -518,7 +516,6 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 
-	msginfo->wait_condition = 0;
 	ret = vmbus_post_msg(gpadlmsg, msginfo->msgsize -
 			       sizeof(*msginfo));
 	if (ret != 0)
@@ -546,10 +543,8 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 
 		}
 	}
-	wait_event_timeout(msginfo->waitevent,
-				msginfo->wait_condition,
-				msecs_to_jiffies(1000));
-	BUG_ON(msginfo->wait_condition == 0);
+	t = wait_for_completion_timeout(&msginfo->waitevent, HZ);
+	BUG_ON(t == 0);
 
 
 	/* At this point, we received the gpadl created msg */
@@ -573,7 +568,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	struct vmbus_channel_gpadl_teardown *msg;
 	struct vmbus_channel_msginfo *info;
 	unsigned long flags;
-	int ret;
+	int ret, t;
 
 	/* ASSERT(gpadl_handle != 0); */
 
@@ -582,7 +577,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	if (!info)
 		return -ENOMEM;
 
-	init_waitqueue_head(&info->waitevent);
+	init_completion(&info->waitevent);
 
 	msg = (struct vmbus_channel_gpadl_teardown *)info->msg;
 
@@ -594,14 +589,12 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	list_add_tail(&info->msglistentry,
 		      &vmbus_connection.chn_msg_list);
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
-	info->wait_condition = 0;
 	ret = vmbus_post_msg(msg,
 			       sizeof(struct vmbus_channel_gpadl_teardown));
 
 	BUG_ON(ret != 0);
-	wait_event_timeout(info->waitevent,
-			info->wait_condition, msecs_to_jiffies(1000));
-	BUG_ON(info->wait_condition == 0);
+	t = wait_for_completion_timeout(&info->waitevent, HZ);
+	BUG_ON(t == 0);
 
 	/* Received a torndown response */
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 95eef92..33cb5d5 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -556,9 +556,9 @@ static void vmbus_onopen_result(struct vmbus_channel_message_header *hdr)
 			    openmsg->openid == result->openid) {
 				memcpy(&msginfo->response.open_result,
 				       result,
-				       sizeof(struct vmbus_channel_open_result));
-				msginfo->wait_condition = 1;
-				wake_up(&msginfo->waitevent);
+				       sizeof(
+					struct vmbus_channel_open_result));
+				complete(&msginfo->waitevent);
 				break;
 			}
 		}
@@ -603,9 +603,9 @@ static void vmbus_ongpadl_created(struct vmbus_channel_message_header *hdr)
 			    (gpadlcreated->gpadl == gpadlheader->gpadl)) {
 				memcpy(&msginfo->response.gpadl_created,
 				       gpadlcreated,
-				       sizeof(struct vmbus_channel_gpadl_created));
-				msginfo->wait_condition = 1;
-				wake_up(&msginfo->waitevent);
+				       sizeof(
+					struct vmbus_channel_gpadl_created));
+				complete(&msginfo->waitevent);
 				break;
 			}
 		}
@@ -648,9 +648,9 @@ static void vmbus_ongpadl_torndown(
 			if (gpadl_torndown->gpadl == gpadl_teardown->gpadl) {
 				memcpy(&msginfo->response.gpadl_torndown,
 				       gpadl_torndown,
-				       sizeof(struct vmbus_channel_gpadl_torndown));
-				msginfo->wait_condition = 1;
-				wake_up(&msginfo->waitevent);
+				       sizeof(
+					struct vmbus_channel_gpadl_torndown));
+				complete(&msginfo->waitevent);
 				break;
 			}
 		}
@@ -689,8 +689,7 @@ static void vmbus_onversion_response(
 			memcpy(&msginfo->response.version_response,
 			      version_response,
 			      sizeof(struct vmbus_channel_version_response));
-			msginfo->wait_condition = 1;
-			wake_up(&msginfo->waitevent);
+			complete(&msginfo->waitevent);
 		}
 	}
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
@@ -753,7 +752,7 @@ int vmbus_request_offers(void)
 {
 	struct vmbus_channel_message_header *msg;
 	struct vmbus_channel_msginfo *msginfo;
-	int ret;
+	int ret, t;
 
 	msginfo = kmalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_message_header),
@@ -761,7 +760,7 @@ int vmbus_request_offers(void)
 	if (!msginfo)
 		return -ENOMEM;
 
-	init_waitqueue_head(&msginfo->waitevent);
+	init_completion(&msginfo->waitevent);
 
 	msg = (struct vmbus_channel_message_header *)msginfo->msg;
 
@@ -776,10 +775,8 @@ int vmbus_request_offers(void)
 		goto cleanup;
 	}
 
-	msginfo->wait_condition = 0;
-	wait_event_timeout(msginfo->waitevent, msginfo->wait_condition,
-			msecs_to_jiffies(1000));
-	if (msginfo->wait_condition == 0) {
+	t = wait_for_completion_timeout(&msginfo->waitevent, HZ);
+	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto cleanup;
 	}
diff --git a/drivers/staging/hv/channel_mgmt.h b/drivers/staging/hv/channel_mgmt.h
index 3b2c393..f895d0a 100644
--- a/drivers/staging/hv/channel_mgmt.h
+++ b/drivers/staging/hv/channel_mgmt.h
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <linux/completion.h>
 #include "ring_buffer.h"
 #include "vmbus_channel_interface.h"
 #include "vmbus_packet_format.h"
@@ -290,8 +291,7 @@ struct vmbus_channel_msginfo {
 	struct list_head submsglist;
 
 	/* Synchronize the request/response if needed */
-	int wait_condition;
-	wait_queue_head_t waitevent;
+	struct completion  waitevent;
 	union {
 		struct vmbus_channel_version_supported version_supported;
 		struct vmbus_channel_open_result open_result;
diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 4f411a9..92add38 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -44,6 +44,7 @@ struct vmbus_connection vmbus_connection = {
 int vmbus_connect(void)
 {
 	int ret = 0;
+	int t;
 	struct vmbus_channel_msginfo *msginfo = NULL;
 	struct vmbus_channel_initiate_contact *msg;
 	unsigned long flags;
@@ -101,7 +102,7 @@ int vmbus_connect(void)
 		goto Cleanup;
 	}
 
-	init_waitqueue_head(&msginfo->waitevent);
+	init_completion(&msginfo->waitevent);
 
 	msg = (struct vmbus_channel_initiate_contact *)msginfo->msg;
 
@@ -134,10 +135,8 @@ int vmbus_connect(void)
 	}
 
 	/* Wait for the connection response */
-	msginfo->wait_condition = 0;
-	wait_event_timeout(msginfo->waitevent, msginfo->wait_condition,
-			msecs_to_jiffies(1000));
-	if (msginfo->wait_condition == 0) {
+	t =  wait_for_completion_timeout(&msginfo->waitevent, HZ);
+	if (t == 0) {
 		spin_lock_irqsave(&vmbus_connection.channelmsg_lock,
 				flags);
 		list_del(&msginfo->msglistentry);
-- 
1.7.4.1
