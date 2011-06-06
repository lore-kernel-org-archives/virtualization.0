From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 33/49] Staging: hv: vmbus: Move the definition of struct
	vmbus_channel
Date: Mon,  6 Jun 2011 15:49:57 -0700
Message-ID: <1307400613-13234-33-git-send-email-kys@microsoft.com>
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

In preparation for embedding the state needed to close the channel, move
the definition of struct vmbus_channel.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/hyperv.h |   77 +++++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 73c251e..93bbeab 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -523,45 +523,6 @@ enum vmbus_channel_state {
 	CHANNEL_OPEN_STATE,
 };
 
-struct vmbus_channel {
-	struct list_head listentry;
-
-	struct hv_device *device_obj;
-
-	struct work_struct work;
-
-	enum vmbus_channel_state state;
-	/*
-	 * For util channels, stash the
-	 * the service index for easy access.
-	 */
-	s8 util_index;
-
-	struct vmbus_channel_offer_channel offermsg;
-	/*
-	 * These are based on the OfferMsg.MonitorId.
-	 * Save it here for easy access.
-	 */
-	u8 monitor_grp;
-	u8 monitor_bit;
-
-	u32 ringbuffer_gpadlhandle;
-
-	/* Allocated memory for ring buffer */
-	void *ringbuffer_pages;
-	u32 ringbuffer_pagecount;
-	struct hv_ring_buffer_info outbound;	/* send to parent */
-	struct hv_ring_buffer_info inbound;	/* receive from parent */
-	spinlock_t inbound_lock;
-	struct workqueue_struct *controlwq;
-
-	/* Channel callback are invoked in this workqueue context */
-	/* HANDLE dataWorkQueue; */
-
-	void (*onchannel_callback)(void *context);
-	void *channel_callback_context;
-};
-
 struct vmbus_channel_debug_info {
 	u32 relid;
 	enum vmbus_channel_state state;
@@ -608,6 +569,44 @@ struct vmbus_channel_msginfo {
 	unsigned char msg[0];
 };
 
+struct vmbus_channel {
+	struct list_head listentry;
+
+	struct hv_device *device_obj;
+
+	struct work_struct work;
+
+	enum vmbus_channel_state state;
+	/*
+	 * For util channels, stash the
+	 * the service index for easy access.
+	 */
+	s8 util_index;
+
+	struct vmbus_channel_offer_channel offermsg;
+	/*
+	 * These are based on the OfferMsg.MonitorId.
+	 * Save it here for easy access.
+	 */
+	u8 monitor_grp;
+	u8 monitor_bit;
+
+	u32 ringbuffer_gpadlhandle;
+
+	/* Allocated memory for ring buffer */
+	void *ringbuffer_pages;
+	u32 ringbuffer_pagecount;
+	struct hv_ring_buffer_info outbound;	/* send to parent */
+	struct hv_ring_buffer_info inbound;	/* receive from parent */
+	spinlock_t inbound_lock;
+	struct workqueue_struct *controlwq;
+
+	/* Channel callback are invoked in this workqueue context */
+	/* HANDLE dataWorkQueue; */
+
+	void (*onchannel_callback)(void *context);
+	void *channel_callback_context;
+};
 
 void free_channel(struct vmbus_channel *channel);
 
-- 
1.7.4.1
