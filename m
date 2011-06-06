From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 26/49] Staging: hv: vmbus: Get rid of the poll timer in the
	channel state
Date: Mon,  6 Jun 2011 15:49:50 -0700
Message-ID: <1307400613-13234-26-git-send-email-kys@microsoft.com>
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

Since tis is not used anymore,  get rid of the poll timer in the channel state.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/channel.c      |    1 -
 drivers/staging/hv/channel_mgmt.c |    5 -----
 drivers/staging/hv/hyperv.h       |    1 -
 3 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index b6f8674..b91b369 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -555,7 +555,6 @@ void vmbus_close(struct vmbus_channel *channel)
 
 	/* Stop callback and cancel the timer asap */
 	channel->onchannel_callback = NULL;
-	del_timer_sync(&channel->poll_timer);
 
 	/* Send a closing message */
 	info = kmalloc(sizeof(*info) +
diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 957d61e..178e1c4 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -283,10 +283,6 @@ static struct vmbus_channel *alloc_channel(void)
 
 	spin_lock_init(&channel->inbound_lock);
 
-	init_timer(&channel->poll_timer);
-	channel->poll_timer.data = (unsigned long)channel;
-	channel->poll_timer.function = vmbus_ontimer;
-
 	channel->controlwq = create_workqueue("hv_vmbus_ctl");
 	if (!channel->controlwq) {
 		kfree(channel);
@@ -315,7 +311,6 @@ static void release_channel(struct work_struct *work)
  */
 void free_channel(struct vmbus_channel *channel)
 {
-	del_timer_sync(&channel->poll_timer);
 
 	/*
 	 * We have to release the channel's workqueue/thread in the vmbus's
diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index e881cfe..73c251e 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -528,7 +528,6 @@ struct vmbus_channel {
 
 	struct hv_device *device_obj;
 
-	struct timer_list poll_timer; /* SA-111 workaround */
 	struct work_struct work;
 
 	enum vmbus_channel_state state;
-- 
1.7.4.1
