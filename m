From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 10/14] vmbus: add direct isr callback mode
Date: Wed,  1 Feb 2017 08:28:57 -0800
Message-ID: <20170201162901.3894-11-sthemmin__15364.5133869306$1485966707$gmane$org@microsoft.com>
References: <20170201162901.3894-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170201162901.3894-1-sthemmin@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kys@microsoft.com, gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org, Stephen Hemminger <sthemmin@microsoft.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Change the simple boolean batched_reading into a tri-value.
For future NAPI support in netvsc driver, the callback needs to
occur directly in interrupt handler.

Batched mode is also changed to disable host interrupts immediately
in interrupt routine (to avoid unnecessary host signals), and the
tasklet is rescheduled if more data is detected.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/hv/channel_mgmt.c    |  7 -------
 drivers/hv/connection.c      | 27 ++++++++++++---------------
 drivers/hv/hv_util.c         |  3 +--
 drivers/hv/vmbus_drv.c       | 26 ++++++++++++++++++++++++--
 drivers/uio/uio_hv_generic.c |  2 +-
 include/linux/hyperv.h       | 31 +++++++++++++++++--------------
 6 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 2f6270d76b79..b2bb5aafaa2f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -820,13 +820,6 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 	}
 
 	/*
-	 * By default we setup state to enable batched
-	 * reading. A specific service can choose to
-	 * disable this prior to opening the channel.
-	 */
-	newchannel->batched_reading = true;
-
-	/*
 	 * Setup state for signalling the host.
 	 */
 	newchannel->sig_event = (struct hv_input_signal_event *)
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 27e72dc07e12..a8366fec1458 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -300,9 +300,7 @@ struct vmbus_channel *relid2channel(u32 relid)
 void vmbus_on_event(unsigned long data)
 {
 	struct vmbus_channel *channel = (void *) data;
-	void *arg;
-	bool read_state;
-	u32 bytes_to_read;
+	void (*callback_fn)(void *);
 
 	/*
 	 * A channel once created is persistent even when there
@@ -312,9 +310,13 @@ void vmbus_on_event(unsigned long data)
 	 * Thus, checking and invoking the driver specific callback takes
 	 * care of orderly unloading of the driver.
 	 */
-	if (channel->onchannel_callback != NULL) {
-		arg = channel->channel_callback_context;
-		read_state = channel->batched_reading;
+	callback_fn = READ_ONCE(channel->onchannel_callback);
+	if (unlikely(callback_fn == NULL))
+		return;
+
+	(*callback_fn)(channel->channel_callback_context);
+
+	if (channel->callback_mode == HV_CALL_BATCHED) {
 		/*
 		 * This callback reads the messages sent by the host.
 		 * We can optimize host to guest signaling by ensuring:
@@ -326,16 +328,11 @@ void vmbus_on_event(unsigned long data)
 		 *    state is set we check to see if additional packets are
 		 *    available to read. In this case we repeat the process.
 		 */
+		if (hv_end_read(&channel->inbound) != 0) {
+			hv_begin_read(&channel->inbound);
 
-		do {
-			if (read_state)
-				hv_begin_read(&channel->inbound);
-			channel->onchannel_callback(arg);
-			if (read_state)
-				bytes_to_read = hv_end_read(&channel->inbound);
-			else
-				bytes_to_read = 0;
-		} while (read_state && (bytes_to_read != 0));
+			tasklet_schedule(&channel->callback_event);
+		}
 	}
 }
 
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index d42ede78a9dd..8410191b4992 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -409,8 +409,7 @@ static int util_probe(struct hv_device *dev,
 	 * Turn off batched reading for all util drivers before we open the
 	 * channel.
 	 */
-
-	set_channel_read_state(dev->channel, false);
+	set_channel_read_mode(dev->channel, HV_CALL_DIRECT);
 
 	hv_set_drvdata(dev, srv);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index eaf1a10b0245..f7f6b9144b07 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -887,6 +887,18 @@ void vmbus_on_msg_dpc(unsigned long data)
 
 
 /*
+ * Direct callback for channels using other deferred processing
+ */
+static void vmbus_channel_isr(struct vmbus_channel *channel)
+{
+	void (*callback_fn)(void *);
+
+	callback_fn = READ_ONCE(channel->onchannel_callback);
+	if (likely(callback_fn != NULL))
+		(*callback_fn)(channel->channel_callback_context);
+}
+
+/*
  * Schedule all channels with events pending
  */
 static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
@@ -927,9 +939,19 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 
 		/* Find channel based on relid */
 		list_for_each_entry(channel, &hv_cpu->chan_list, percpu_list) {
-			if (channel->offermsg.child_relid == relid) {
-				tasklet_schedule(&channel->callback_event);
+			if (channel->offermsg.child_relid != relid)
+				continue;
+
+			switch (channel->callback_mode) {
+			case HV_CALL_ISR:
+				vmbus_channel_isr(channel);
 				break;
+
+			case HV_CALL_BATCHED:
+				hv_begin_read(&channel->inbound);
+				/* fallthrough */
+			case HV_CALL_DIRECT:
+				tasklet_schedule(&channel->callback_event);
 			}
 		}
 	}
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 50958f167305..48d5327d38d4 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -125,7 +125,7 @@ hv_uio_probe(struct hv_device *dev,
 		goto fail;
 
 	dev->channel->inbound.ring_buffer->interrupt_mask = 1;
-	dev->channel->batched_reading = false;
+	set_channel_read_mode(dev->channel, HV_CALL_DIRECT);
 
 	/* Fill general uio info */
 	pdata->info.name = "uio_hv_generic";
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dce5aa6751b4..936e6b9d1fe4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -734,19 +734,21 @@ struct vmbus_channel {
 	void *channel_callback_context;
 
 	/*
-	 * A channel can be marked for efficient (batched)
-	 * reading:
-	 * If batched_reading is set to "true", we read until the
-	 * channel is empty and hold off interrupts from the host
-	 * during the entire read process.
-	 * If batched_reading is set to "false", the client is not
-	 * going to perform batched reading.
-	 *
-	 * By default we will enable batched reading; specific
-	 * drivers that don't want this behavior can turn it off.
+	 * A channel can be marked for one of three modes of reading:
+	 *   BUFFERED - callback called from taslket and should read
+	 *            channel until empty. Interrupts from the host
+	 *            are masked while read is in process (default).
+	 *   DIRECT - callback called from tasklet (softirq).
+	 *   ISR - callback called in interrupt context and must
+	 *         invoke its own deferred processing.
+	 *         Host interrupts are disabled and must be re-enabled
+	 *         when ring is empty.
 	 */
-
-	bool batched_reading;
+	enum hv_callback_mode {
+		HV_CALL_BATCHED,
+		HV_CALL_DIRECT,
+		HV_CALL_ISR
+	} callback_mode;
 
 	bool is_dedicated_interrupt;
 	struct hv_input_signal_event_buffer sig_buf;
@@ -892,9 +894,10 @@ static inline void set_channel_affinity_state(struct vmbus_channel *c,
 	c->affinity_policy = policy;
 }
 
-static inline void set_channel_read_state(struct vmbus_channel *c, bool state)
+static inline void set_channel_read_mode(struct vmbus_channel *c,
+					 enum hv_callback_mode mode)
 {
-	c->batched_reading = state;
+	c->callback_mode = mode;
 }
 
 static inline void set_channel_pending_send_size(struct vmbus_channel *c,
-- 
2.11.0
