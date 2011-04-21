From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 3/8] staging: hv: move netvsc_send_recv_completion() to clean
	up forward declaration
Date: Thu, 21 Apr 2011 12:30:42 -0700
Message-ID: <1303414247-22118-4-git-send-email-haiyangz__41291.9712289751$1303415723$gmane$org@microsoft.com>
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
 drivers/staging/hv/netvsc.c |   87 +++++++++++++++++++++----------------------
 1 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index edd2f4e..ea3c72e 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -63,9 +63,6 @@ static void netvsc_send_completion(struct hv_device *device,
 static void netvsc_receive(struct hv_device *device,
 			    struct vmpacket_descriptor *packet);
 
-static void netvsc_send_recv_completion(struct hv_device *device,
-					u64 transaction_id);
-
 
 static struct netvsc_device *alloc_net_device(struct hv_device *device)
 {
@@ -835,6 +832,48 @@ static int netvsc_send(struct hv_device *device,
 	return ret;
 }
 
+static void netvsc_send_recv_completion(struct hv_device *device,
+					u64 transaction_id)
+{
+	struct nvsp_message recvcompMessage;
+	int retries = 0;
+	int ret;
+
+	recvcompMessage.hdr.msg_type =
+				NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE;
+
+	/* FIXME: Pass in the status */
+	recvcompMessage.msg.v1_msg.send_rndis_pkt_complete.status =
+		NVSP_STAT_SUCCESS;
+
+retry_send_cmplt:
+	/* Send the completion */
+	ret = vmbus_sendpacket(device->channel, &recvcompMessage,
+			       sizeof(struct nvsp_message), transaction_id,
+			       VM_PKT_COMP, 0);
+	if (ret == 0) {
+		/* success */
+		/* no-op */
+	} else if (ret == -1) {
+		/* no more room...wait a bit and attempt to retry 3 times */
+		retries++;
+		dev_err(&device->device, "unable to send receive completion pkt"
+			" (tid %llx)...retrying %d", transaction_id, retries);
+
+		if (retries < 4) {
+			udelay(100);
+			goto retry_send_cmplt;
+		} else {
+			dev_err(&device->device, "unable to send receive "
+				"completion pkt (tid %llx)...give up retrying",
+				transaction_id);
+		}
+	} else {
+		dev_err(&device->device, "unable to send receive "
+			"completion pkt - %llx", transaction_id);
+	}
+}
+
 /* Send a receive completion packet to RNDIS device (ie NetVsp) */
 static void netvsc_receive_completion(void *context)
 {
@@ -1069,48 +1108,6 @@ static void netvsc_receive(struct hv_device *device,
 	put_net_device(device);
 }
 
-static void netvsc_send_recv_completion(struct hv_device *device,
-					u64 transaction_id)
-{
-	struct nvsp_message recvcompMessage;
-	int retries = 0;
-	int ret;
-
-	recvcompMessage.hdr.msg_type =
-				NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE;
-
-	/* FIXME: Pass in the status */
-	recvcompMessage.msg.v1_msg.send_rndis_pkt_complete.status =
-		NVSP_STAT_SUCCESS;
-
-retry_send_cmplt:
-	/* Send the completion */
-	ret = vmbus_sendpacket(device->channel, &recvcompMessage,
-			       sizeof(struct nvsp_message), transaction_id,
-			       VM_PKT_COMP, 0);
-	if (ret == 0) {
-		/* success */
-		/* no-op */
-	} else if (ret == -1) {
-		/* no more room...wait a bit and attempt to retry 3 times */
-		retries++;
-		dev_err(&device->device, "unable to send receive completion pkt"
-			" (tid %llx)...retrying %d", transaction_id, retries);
-
-		if (retries < 4) {
-			udelay(100);
-			goto retry_send_cmplt;
-		} else {
-			dev_err(&device->device, "unable to send receive "
-				"completion pkt (tid %llx)...give up retrying",
-				transaction_id);
-		}
-	} else {
-		dev_err(&device->device, "unable to send receive "
-			"completion pkt - %llx", transaction_id);
-	}
-}
-
 static void netvsc_channel_cb(void *context)
 {
 	int ret;
-- 
1.6.3.2
