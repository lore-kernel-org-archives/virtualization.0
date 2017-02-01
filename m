From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 04/14] vmbus: remove unused kickq argument to sendpacket
Date: Wed,  1 Feb 2017 08:28:51 -0800
Message-ID: <20170201162901.3894-5-sthemmin__18257.9259424985$1485966596$gmane$org@microsoft.com>
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

Since sendpacket no longer uses kickq argument remove it.
Remove it no longer used xmit_more in sendpacket in netvsc as well.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/hv/channel.c        | 19 +++++++++----------
 drivers/net/hyperv/netvsc.c | 21 +++------------------
 include/linux/hyperv.h      |  6 ++----
 3 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index e26285cde8e0..789c75f6df26 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -643,8 +643,8 @@ void vmbus_close(struct vmbus_channel *channel)
 EXPORT_SYMBOL_GPL(vmbus_close);
 
 int vmbus_sendpacket_ctl(struct vmbus_channel *channel, void *buffer,
-			   u32 bufferlen, u64 requestid,
-			   enum vmbus_packet_type type, u32 flags, bool kick_q)
+			 u32 bufferlen, u64 requestid,
+			 enum vmbus_packet_type type, u32 flags)
 {
 	struct vmpacket_descriptor desc;
 	u32 packetlen = sizeof(struct vmpacket_descriptor) + bufferlen;
@@ -693,7 +693,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 			   enum vmbus_packet_type type, u32 flags)
 {
 	return vmbus_sendpacket_ctl(channel, buffer, bufferlen, requestid,
-				    type, flags, true);
+				    type, flags);
 }
 EXPORT_SYMBOL(vmbus_sendpacket);
 
@@ -705,11 +705,9 @@ EXPORT_SYMBOL(vmbus_sendpacket);
  * explicitly.
  */
 int vmbus_sendpacket_pagebuffer_ctl(struct vmbus_channel *channel,
-				     struct hv_page_buffer pagebuffers[],
-				     u32 pagecount, void *buffer, u32 bufferlen,
-				     u64 requestid,
-				     u32 flags,
-				     bool kick_q)
+				    struct hv_page_buffer pagebuffers[],
+				    u32 pagecount, void *buffer, u32 bufferlen,
+				    u64 requestid, u32 flags)
 {
 	int i;
 	struct vmbus_channel_packet_page_buffer desc;
@@ -769,9 +767,10 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 				     u64 requestid)
 {
 	u32 flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
+
 	return vmbus_sendpacket_pagebuffer_ctl(channel, pagebuffers, pagecount,
-					       buffer, bufferlen, requestid,
-					       flags, true);
+					       buffer, bufferlen,
+					       requestid, flags);
 
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 5a1cc089acb7..e326e68f9f6d 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -723,8 +723,6 @@ static u32 netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	char *dest = start + (section_index * net_device->send_section_size)
 		     + pend_size;
 	int i;
-	bool is_data_pkt = (skb != NULL) ? true : false;
-	bool xmit_more = (skb != NULL) ? skb->xmit_more : false;
 	u32 msg_size = 0;
 	u32 padding = 0;
 	u32 remain = packet->total_data_buflen % net_device->pkt_align;
@@ -732,7 +730,7 @@ static u32 netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 		packet->page_buf_cnt;
 
 	/* Add padding */
-	if (is_data_pkt && xmit_more && remain &&
+	if (skb && skb->xmit_more && remain &&
 	    !packet->cp_partial) {
 		padding = net_device->pkt_align - remain;
 		rndis_msg->msg_len += padding;
@@ -772,7 +770,6 @@ static inline int netvsc_send_pkt(
 	int ret;
 	struct hv_page_buffer *pgbuf;
 	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
-	bool xmit_more = (skb != NULL) ? skb->xmit_more : false;
 
 	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
 	if (skb != NULL) {
@@ -796,16 +793,6 @@ static inline int netvsc_send_pkt(
 	if (out_channel->rescind)
 		return -ENODEV;
 
-	/*
-	 * It is possible that once we successfully place this packet
-	 * on the ringbuffer, we may stop the queue. In that case, we want
-	 * to notify the host independent of the xmit_more flag. We don't
-	 * need to be precise here; in the worst case we may signal the host
-	 * unnecessarily.
-	 */
-	if (ring_avail < (RING_AVAIL_PERCENT_LOWATER + 1))
-		xmit_more = false;
-
 	if (packet->page_buf_cnt) {
 		pgbuf = packet->cp_partial ? (*pb) +
 			packet->rmsg_pgcnt : (*pb);
@@ -815,15 +802,13 @@ static inline int netvsc_send_pkt(
 						      &nvmsg,
 						      sizeof(struct nvsp_message),
 						      req_id,
-						      VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED,
-						      !xmit_more);
+						      VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	} else {
 		ret = vmbus_sendpacket_ctl(out_channel, &nvmsg,
 					   sizeof(struct nvsp_message),
 					   req_id,
 					   VM_PKT_DATA_INBAND,
-					   VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED,
-					   !xmit_more);
+					   VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	}
 
 	if (ret == 0) {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 423fc96cc26a..8c6a1505b876 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1023,8 +1023,7 @@ extern int vmbus_sendpacket_ctl(struct vmbus_channel *channel,
 				  u32 bufferLen,
 				  u64 requestid,
 				  enum vmbus_packet_type type,
-				  u32 flags,
-				  bool kick_q);
+				  u32 flags);
 
 extern int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 					    struct hv_page_buffer pagebuffers[],
@@ -1039,8 +1038,7 @@ extern int vmbus_sendpacket_pagebuffer_ctl(struct vmbus_channel *channel,
 					   void *buffer,
 					   u32 bufferlen,
 					   u64 requestid,
-					   u32 flags,
-					   bool kick_q);
+					   u32 flags);
 
 extern int vmbus_sendpacket_multipagebuffer(struct vmbus_channel *channel,
 					struct hv_multipage_buffer *mpb,
-- 
2.11.0
