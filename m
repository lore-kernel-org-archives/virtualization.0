From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 6/8] staging: hv: move netvsc_device_add() to clean up forward
	declaration
Date: Thu, 21 Apr 2011 12:30:45 -0700
Message-ID: <1303414247-22118-7-git-send-email-haiyangz@microsoft.com>
References: <1303414247-22118-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1303414247-22118-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc.c |  176 +++++++++++++++++++++----------------------
 1 files changed, 87 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 75640ea..1c3bdda 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -45,8 +45,6 @@ static const struct hv_guid netvsc_device_type = {
 	}
 };
 
-static void netvsc_channel_cb(void *context);
-
 static int netvsc_init_send_buf(struct hv_device *device);
 
 static int netvsc_init_recv_buf(struct hv_device *device);
@@ -592,93 +590,6 @@ static void NetVscDisconnectFromVsp(struct netvsc_device *net_device)
 }
 
 /*
- * netvsc_device_add - Callback when the device belonging to this
- * driver is added
- */
-static int netvsc_device_add(struct hv_device *device, void *additional_info)
-{
-	int ret = 0;
-	int i;
-	struct netvsc_device *net_device;
-	struct hv_netvsc_packet *packet, *pos;
-	struct netvsc_driver *net_driver =
-				(struct netvsc_driver *)device->drv;
-
-	net_device = alloc_net_device(device);
-	if (!net_device) {
-		ret = -1;
-		goto cleanup;
-	}
-
-	/* Initialize the NetVSC channel extension */
-	net_device->recv_buf_size = NETVSC_RECEIVE_BUFFER_SIZE;
-	spin_lock_init(&net_device->recv_pkt_list_lock);
-
-	net_device->send_buf_size = NETVSC_SEND_BUFFER_SIZE;
-
-	INIT_LIST_HEAD(&net_device->recv_pkt_list);
-
-	for (i = 0; i < NETVSC_RECEIVE_PACKETLIST_COUNT; i++) {
-		packet = kzalloc(sizeof(struct hv_netvsc_packet) +
-				 (NETVSC_RECEIVE_SG_COUNT *
-				  sizeof(struct hv_page_buffer)), GFP_KERNEL);
-		if (!packet)
-			break;
-
-		list_add_tail(&packet->list_ent,
-			      &net_device->recv_pkt_list);
-	}
-	init_waitqueue_head(&net_device->channel_init_wait);
-
-	/* Open the channel */
-	ret = vmbus_open(device->channel, net_driver->ring_buf_size,
-			 net_driver->ring_buf_size, NULL, 0,
-			 netvsc_channel_cb, device);
-
-	if (ret != 0) {
-		dev_err(&device->device, "unable to open channel: %d", ret);
-		ret = -1;
-		goto cleanup;
-	}
-
-	/* Channel is opened */
-	pr_info("hv_netvsc channel opened successfully");
-
-	/* Connect with the NetVsp */
-	ret = netvsc_connect_vsp(device);
-	if (ret != 0) {
-		dev_err(&device->device,
-			"unable to connect to NetVSP - %d", ret);
-		ret = -1;
-		goto close;
-	}
-
-	return ret;
-
-close:
-	/* Now, we can close the channel safely */
-	vmbus_close(device->channel);
-
-cleanup:
-
-	if (net_device) {
-		list_for_each_entry_safe(packet, pos,
-					 &net_device->recv_pkt_list,
-					 list_ent) {
-			list_del(&packet->list_ent);
-			kfree(packet);
-		}
-
-		release_outbound_net_device(device);
-		release_inbound_net_device(device);
-
-		free_net_device(net_device);
-	}
-
-	return ret;
-}
-
-/*
  * netvsc_device_remove - Callback when the root bus device is removed
  */
 static int netvsc_device_remove(struct hv_device *device)
@@ -1193,6 +1104,93 @@ out:
 }
 
 /*
+ * netvsc_device_add - Callback when the device belonging to this
+ * driver is added
+ */
+static int netvsc_device_add(struct hv_device *device, void *additional_info)
+{
+	int ret = 0;
+	int i;
+	struct netvsc_device *net_device;
+	struct hv_netvsc_packet *packet, *pos;
+	struct netvsc_driver *net_driver =
+				(struct netvsc_driver *)device->drv;
+
+	net_device = alloc_net_device(device);
+	if (!net_device) {
+		ret = -1;
+		goto cleanup;
+	}
+
+	/* Initialize the NetVSC channel extension */
+	net_device->recv_buf_size = NETVSC_RECEIVE_BUFFER_SIZE;
+	spin_lock_init(&net_device->recv_pkt_list_lock);
+
+	net_device->send_buf_size = NETVSC_SEND_BUFFER_SIZE;
+
+	INIT_LIST_HEAD(&net_device->recv_pkt_list);
+
+	for (i = 0; i < NETVSC_RECEIVE_PACKETLIST_COUNT; i++) {
+		packet = kzalloc(sizeof(struct hv_netvsc_packet) +
+				 (NETVSC_RECEIVE_SG_COUNT *
+				  sizeof(struct hv_page_buffer)), GFP_KERNEL);
+		if (!packet)
+			break;
+
+		list_add_tail(&packet->list_ent,
+			      &net_device->recv_pkt_list);
+	}
+	init_waitqueue_head(&net_device->channel_init_wait);
+
+	/* Open the channel */
+	ret = vmbus_open(device->channel, net_driver->ring_buf_size,
+			 net_driver->ring_buf_size, NULL, 0,
+			 netvsc_channel_cb, device);
+
+	if (ret != 0) {
+		dev_err(&device->device, "unable to open channel: %d", ret);
+		ret = -1;
+		goto cleanup;
+	}
+
+	/* Channel is opened */
+	pr_info("hv_netvsc channel opened successfully");
+
+	/* Connect with the NetVsp */
+	ret = netvsc_connect_vsp(device);
+	if (ret != 0) {
+		dev_err(&device->device,
+			"unable to connect to NetVSP - %d", ret);
+		ret = -1;
+		goto close;
+	}
+
+	return ret;
+
+close:
+	/* Now, we can close the channel safely */
+	vmbus_close(device->channel);
+
+cleanup:
+
+	if (net_device) {
+		list_for_each_entry_safe(packet, pos,
+					 &net_device->recv_pkt_list,
+					 list_ent) {
+			list_del(&packet->list_ent);
+			kfree(packet);
+		}
+
+		release_outbound_net_device(device);
+		release_inbound_net_device(device);
+
+		free_net_device(net_device);
+	}
+
+	return ret;
+}
+
+/*
  * netvsc_initialize - Main entry point
  */
 int netvsc_initialize(struct hv_driver *drv)
-- 
1.6.3.2
