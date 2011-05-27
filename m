From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/2] staging: hv: convert DPRINT_DBG() to netdev_dbg() in
	dump_rndis_message()
Date: Fri, 27 May 2011 06:21:54 -0700
Message-ID: <1306502515-18961-1-git-send-email-haiyangz__44365.1999500164$1306502014$gmane$org@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>

---
 drivers/staging/hv/rndis_filter.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index 5a5bf64..5674a13 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -139,14 +139,17 @@ static void put_rndis_request(struct rndis_device *dev,
 	kfree(req);
 }
 
-static void dump_rndis_message(struct rndis_message *rndis_msg)
+static void dump_rndis_message(struct hv_device *hv_dev,
+			struct rndis_message *rndis_msg)
 {
+	struct net_device *netdev = dev_get_drvdata(&hv_dev->device);
+
 	switch (rndis_msg->ndis_msg_type) {
 	case REMOTE_NDIS_PACKET_MSG:
-		DPRINT_DBG(NETVSC, "REMOTE_NDIS_PACKET_MSG (len %u, "
+		netdev_dbg(netdev, "REMOTE_NDIS_PACKET_MSG (len %u, "
 			   "data offset %u data len %u, # oob %u, "
 			   "oob offset %u, oob len %u, pkt offset %u, "
-			   "pkt len %u",
+			   "pkt len %u\n",
 			   rndis_msg->msg_len,
 			   rndis_msg->msg.pkt.data_offset,
 			   rndis_msg->msg.pkt.data_len,
@@ -158,10 +161,10 @@ static void dump_rndis_message(struct rndis_message *rndis_msg)
 		break;
 
 	case REMOTE_NDIS_INITIALIZE_CMPLT:
-		DPRINT_DBG(NETVSC, "REMOTE_NDIS_INITIALIZE_CMPLT "
+		netdev_dbg(netdev, "REMOTE_NDIS_INITIALIZE_CMPLT "
 			"(len %u, id 0x%x, status 0x%x, major %d, minor %d, "
 			"device flags %d, max xfer size 0x%x, max pkts %u, "
-			"pkt aligned %u)",
+			"pkt aligned %u)\n",
 			rndis_msg->msg_len,
 			rndis_msg->msg.init_complete.req_id,
 			rndis_msg->msg.init_complete.status,
@@ -176,9 +179,9 @@ static void dump_rndis_message(struct rndis_message *rndis_msg)
 		break;
 
 	case REMOTE_NDIS_QUERY_CMPLT:
-		DPRINT_DBG(NETVSC, "REMOTE_NDIS_QUERY_CMPLT "
+		netdev_dbg(netdev, "REMOTE_NDIS_QUERY_CMPLT "
 			"(len %u, id 0x%x, status 0x%x, buf len %u, "
-			"buf offset %u)",
+			"buf offset %u)\n",
 			rndis_msg->msg_len,
 			rndis_msg->msg.query_complete.req_id,
 			rndis_msg->msg.query_complete.status,
@@ -189,16 +192,16 @@ static void dump_rndis_message(struct rndis_message *rndis_msg)
 		break;
 
 	case REMOTE_NDIS_SET_CMPLT:
-		DPRINT_DBG(NETVSC,
-			"REMOTE_NDIS_SET_CMPLT (len %u, id 0x%x, status 0x%x)",
+		netdev_dbg(netdev,
+			"REMOTE_NDIS_SET_CMPLT (len %u, id 0x%x, status 0x%x)\n",
 			rndis_msg->msg_len,
 			rndis_msg->msg.set_complete.req_id,
 			rndis_msg->msg.set_complete.status);
 		break;
 
 	case REMOTE_NDIS_INDICATE_STATUS_MSG:
-		DPRINT_DBG(NETVSC, "REMOTE_NDIS_INDICATE_STATUS_MSG "
-			"(len %u, status 0x%x, buf len %u, buf offset %u)",
+		netdev_dbg(netdev, "REMOTE_NDIS_INDICATE_STATUS_MSG "
+			"(len %u, status 0x%x, buf len %u, buf offset %u)\n",
 			rndis_msg->msg_len,
 			rndis_msg->msg.indicate_status.status,
 			rndis_msg->msg.indicate_status.status_buflen,
@@ -206,7 +209,7 @@ static void dump_rndis_message(struct rndis_message *rndis_msg)
 		break;
 
 	default:
-		DPRINT_DBG(NETVSC, "0x%x (len %u)",
+		netdev_dbg(netdev, "0x%x (len %u)\n",
 			rndis_msg->ndis_msg_type,
 			rndis_msg->msg_len);
 		break;
@@ -387,7 +390,7 @@ int rndis_filter_receive(struct hv_device *dev,
 
 	kunmap_atomic(rndis_hdr - pkt->page_buf[0].offset, KM_IRQ0);
 
-	dump_rndis_message(&rndis_msg);
+	dump_rndis_message(dev, &rndis_msg);
 
 	switch (rndis_msg.ndis_msg_type) {
 	case REMOTE_NDIS_PACKET_MSG:
-- 
1.6.3.2
