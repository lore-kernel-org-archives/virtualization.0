From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 044/117] Staging: hv: vmbus: Rename openMsg to open_msg in
	channel.c
Date: Fri, 15 Jul 2011 10:46:32 -0700
Message-ID: <1310752065-27895-44-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Rename openMsg to open_msg in channel.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/channel.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index aa0a150..ebd7552 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -119,7 +119,7 @@ int vmbus_open(struct vmbus_channel *newchannel, u32 send_ringbuffer_size,
 		     u32 recv_ringbuffer_size, void *userdata, u32 userdatalen,
 		     void (*onchannelcallback)(void *context), void *context)
 {
-	struct vmbus_channel_open_channel *openMsg;
+	struct vmbus_channel_open_channel *open_msg;
 	struct vmbus_channel_msginfo *openInfo = NULL;
 	void *in, *out;
 	unsigned long flags;
@@ -183,14 +183,14 @@ int vmbus_open(struct vmbus_channel *newchannel, u32 send_ringbuffer_size,
 
 	init_completion(&openInfo->waitevent);
 
-	openMsg = (struct vmbus_channel_open_channel *)openInfo->msg;
-	openMsg->header.msgtype = CHANNELMSG_OPENCHANNEL;
-	openMsg->openid = newchannel->offermsg.child_relid;
-	openMsg->child_relid = newchannel->offermsg.child_relid;
-	openMsg->ringbuffer_gpadlhandle = newchannel->ringbuffer_gpadlhandle;
-	openMsg->downstream_ringbuffer_pageoffset = send_ringbuffer_size >>
+	open_msg = (struct vmbus_channel_open_channel *)openInfo->msg;
+	open_msg->header.msgtype = CHANNELMSG_OPENCHANNEL;
+	open_msg->openid = newchannel->offermsg.child_relid;
+	open_msg->child_relid = newchannel->offermsg.child_relid;
+	open_msg->ringbuffer_gpadlhandle = newchannel->ringbuffer_gpadlhandle;
+	open_msg->downstream_ringbuffer_pageoffset = send_ringbuffer_size >>
 						  PAGE_SHIFT;
-	openMsg->server_contextarea_gpadlhandle = 0;
+	open_msg->server_contextarea_gpadlhandle = 0;
 
 	if (userdatalen > MAX_USER_DEFINED_BYTES) {
 		err = -EINVAL;
@@ -198,14 +198,14 @@ int vmbus_open(struct vmbus_channel *newchannel, u32 send_ringbuffer_size,
 	}
 
 	if (userdatalen)
-		memcpy(openMsg->userdata, userdata, userdatalen);
+		memcpy(open_msg->userdata, userdata, userdatalen);
 
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_add_tail(&openInfo->msglistentry,
 		      &vmbus_connection.chn_msg_list);
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 
-	ret = vmbus_post_msg(openMsg,
+	ret = vmbus_post_msg(open_msg,
 			       sizeof(struct vmbus_channel_open_channel));
 
 	if (ret != 0)
-- 
1.7.4.1
