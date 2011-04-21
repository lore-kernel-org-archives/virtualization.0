From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 2/8] staging: hv: move netvsc_receive_completion() to clean up
	forward declaration
Date: Thu, 21 Apr 2011 12:30:41 -0700
Message-ID: <1303414247-22118-3-git-send-email-haiyangz@microsoft.com>
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
 drivers/staging/hv/netvsc.c |  102 +++++++++++++++++++++----------------------
 1 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 6eaecc1..edd2f4e 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -63,8 +63,6 @@ static void netvsc_send_completion(struct hv_device *device,
 static void netvsc_receive(struct hv_device *device,
 			    struct vmpacket_descriptor *packet);
 
-static void netvsc_receive_completion(void *context);
-
 static void netvsc_send_recv_completion(struct hv_device *device,
 					u64 transaction_id);
 
@@ -837,6 +835,56 @@ static int netvsc_send(struct hv_device *device,
 	return ret;
 }
 
+/* Send a receive completion packet to RNDIS device (ie NetVsp) */
+static void netvsc_receive_completion(void *context)
+{
+	struct hv_netvsc_packet *packet = context;
+	struct hv_device *device = (struct hv_device *)packet->device;
+	struct netvsc_device *net_device;
+	u64 transaction_id = 0;
+	bool fsend_receive_comp = false;
+	unsigned long flags;
+
+	/*
+	 * Even though it seems logical to do a GetOutboundNetDevice() here to
+	 * send out receive completion, we are using GetInboundNetDevice()
+	 * since we may have disable outbound traffic already.
+	 */
+	net_device = get_inbound_net_device(device);
+	if (!net_device) {
+		dev_err(&device->device, "unable to get net device..."
+			   "device being destroyed?");
+		return;
+	}
+
+	/* Overloading use of the lock. */
+	spin_lock_irqsave(&net_device->recv_pkt_list_lock, flags);
+
+	packet->xfer_page_pkt->count--;
+
+	/*
+	 * Last one in the line that represent 1 xfer page packet.
+	 * Return the xfer page packet itself to the freelist
+	 */
+	if (packet->xfer_page_pkt->count == 0) {
+		fsend_receive_comp = true;
+		transaction_id = packet->completion.recv.recv_completion_tid;
+		list_add_tail(&packet->xfer_page_pkt->list_ent,
+			      &net_device->recv_pkt_list);
+
+	}
+
+	/* Put the packet back */
+	list_add_tail(&packet->list_ent, &net_device->recv_pkt_list);
+	spin_unlock_irqrestore(&net_device->recv_pkt_list_lock, flags);
+
+	/* Send a receive completion for the xfer page packet */
+	if (fsend_receive_comp)
+		netvsc_send_recv_completion(device, transaction_id);
+
+	put_net_device(device);
+}
+
 static void netvsc_receive(struct hv_device *device,
 			    struct vmpacket_descriptor *packet)
 {
@@ -1063,56 +1111,6 @@ retry_send_cmplt:
 	}
 }
 
-/* Send a receive completion packet to RNDIS device (ie NetVsp) */
-static void netvsc_receive_completion(void *context)
-{
-	struct hv_netvsc_packet *packet = context;
-	struct hv_device *device = (struct hv_device *)packet->device;
-	struct netvsc_device *net_device;
-	u64 transaction_id = 0;
-	bool fsend_receive_comp = false;
-	unsigned long flags;
-
-	/*
-	 * Even though it seems logical to do a GetOutboundNetDevice() here to
-	 * send out receive completion, we are using GetInboundNetDevice()
-	 * since we may have disable outbound traffic already.
-	 */
-	net_device = get_inbound_net_device(device);
-	if (!net_device) {
-		dev_err(&device->device, "unable to get net device..."
-			   "device being destroyed?");
-		return;
-	}
-
-	/* Overloading use of the lock. */
-	spin_lock_irqsave(&net_device->recv_pkt_list_lock, flags);
-
-	packet->xfer_page_pkt->count--;
-
-	/*
-	 * Last one in the line that represent 1 xfer page packet.
-	 * Return the xfer page packet itself to the freelist
-	 */
-	if (packet->xfer_page_pkt->count == 0) {
-		fsend_receive_comp = true;
-		transaction_id = packet->completion.recv.recv_completion_tid;
-		list_add_tail(&packet->xfer_page_pkt->list_ent,
-			      &net_device->recv_pkt_list);
-
-	}
-
-	/* Put the packet back */
-	list_add_tail(&packet->list_ent, &net_device->recv_pkt_list);
-	spin_unlock_irqrestore(&net_device->recv_pkt_list_lock, flags);
-
-	/* Send a receive completion for the xfer page packet */
-	if (fsend_receive_comp)
-		netvsc_send_recv_completion(device, transaction_id);
-
-	put_net_device(device);
-}
-
 static void netvsc_channel_cb(void *context)
 {
 	int ret;
-- 
1.6.3.2
