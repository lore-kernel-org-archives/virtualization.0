From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 05/14] netvsc: remove no longer needed receive staging buffers
Date: Wed,  1 Feb 2017 08:28:52 -0800
Message-ID: <20170201162901.3894-6-sthemmin@microsoft.com>
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

Since commit aed8c164ca5199 ("Drivers: hv: ring_buffer: count on wrap
around mappings") it is no longer necessary to handle ring wrapping
by having a special receive buffer.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h   |  5 ---
 drivers/net/hyperv/netvsc.c       | 83 ++++++---------------------------------
 drivers/net/hyperv/rndis_filter.c | 11 ------
 3 files changed, 11 insertions(+), 88 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 3958adade7eb..cce70ceba6d5 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -748,11 +748,6 @@ struct netvsc_device {
 
 	int ring_size;
 
-	/* The primary channel callback buffer */
-	unsigned char *cb_buffer;
-	/* The sub channel callback buffer */
-	unsigned char *sub_cb_buf;
-
 	struct multi_send_data msd[VRSS_CHANNEL_MAX];
 	u32 max_pkt; /* max number of pkt in one send, e.g. 8 */
 	u32 pkt_align; /* alignment bytes, e.g. 8 */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index e326e68f9f6d..7487498b663c 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -67,12 +67,6 @@ static struct netvsc_device *alloc_net_device(void)
 	if (!net_device)
 		return NULL;
 
-	net_device->cb_buffer = kzalloc(NETVSC_PACKET_SIZE, GFP_KERNEL);
-	if (!net_device->cb_buffer) {
-		kfree(net_device);
-		return NULL;
-	}
-
 	net_device->mrc[0].buf = vzalloc(NETVSC_RECVSLOT_MAX *
 					 sizeof(struct recv_comp_data));
 
@@ -93,7 +87,6 @@ static void free_netvsc_device(struct netvsc_device *nvdev)
 	for (i = 0; i < VRSS_CHANNEL_MAX; i++)
 		vfree(nvdev->mrc[i].buf);
 
-	kfree(nvdev->cb_buffer);
 	kfree(nvdev);
 }
 
@@ -584,7 +577,6 @@ void netvsc_device_remove(struct hv_device *device)
 	vmbus_close(device->channel);
 
 	/* Release all resources */
-	vfree(net_device->sub_cb_buf);
 	free_netvsc_device(net_device);
 }
 
@@ -1256,16 +1248,11 @@ static void netvsc_process_raw_pkt(struct hv_device *device,
 
 void netvsc_channel_cb(void *context)
 {
-	int ret;
-	struct vmbus_channel *channel = (struct vmbus_channel *)context;
+	struct vmbus_channel *channel = context;
 	u16 q_idx = channel->offermsg.offer.sub_channel_index;
 	struct hv_device *device;
 	struct netvsc_device *net_device;
-	u32 bytes_recvd;
-	u64 request_id;
 	struct vmpacket_descriptor *desc;
-	unsigned char *buffer;
-	int bufferlen = NETVSC_PACKET_SIZE;
 	struct net_device *ndev;
 	bool need_to_commit = false;
 
@@ -1277,65 +1264,19 @@ void netvsc_channel_cb(void *context)
 	net_device = get_inbound_net_device(device);
 	if (!net_device)
 		return;
+
 	ndev = hv_get_drvdata(device);
-	buffer = get_per_channel_state(channel);
-
-	do {
-		desc = get_next_pkt_raw(channel);
-		if (desc != NULL) {
-			netvsc_process_raw_pkt(device,
-					       channel,
-					       net_device,
-					       ndev,
-					       desc->trans_id,
-					       desc);
-
-			put_pkt_raw(channel, desc);
-			need_to_commit = true;
-			continue;
-		}
-		if (need_to_commit) {
-			need_to_commit = false;
-			commit_rd_index(channel);
-		}
 
-		ret = vmbus_recvpacket_raw(channel, buffer, bufferlen,
-					   &bytes_recvd, &request_id);
-		if (ret == 0) {
-			if (bytes_recvd > 0) {
-				desc = (struct vmpacket_descriptor *)buffer;
-				netvsc_process_raw_pkt(device,
-						       channel,
-						       net_device,
-						       ndev,
-						       request_id,
-						       desc);
-			} else {
-				/*
-				 * We are done for this pass.
-				 */
-				break;
-			}
-
-		} else if (ret == -ENOBUFS) {
-			if (bufferlen > NETVSC_PACKET_SIZE)
-				kfree(buffer);
-			/* Handle large packet */
-			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
-			if (buffer == NULL) {
-				/* Try again next time around */
-				netdev_err(ndev,
-					   "unable to allocate buffer of size "
-					   "(%d)!!\n", bytes_recvd);
-				break;
-			}
-
-			bufferlen = bytes_recvd;
-		}
-	} while (1);
+	while ((desc = get_next_pkt_raw(channel)) != NULL) {
+		netvsc_process_raw_pkt(device, channel, net_device,
+				       ndev, desc->trans_id, desc);
 
-	if (bufferlen > NETVSC_PACKET_SIZE)
-		kfree(buffer);
+		put_pkt_raw(channel, desc);
+		need_to_commit = true;
+	}
+
+	if (need_to_commit)
+		commit_rd_index(channel);
 
 	netvsc_chk_recv_comp(net_device, channel, q_idx);
 }
@@ -1359,8 +1300,6 @@ int netvsc_device_add(struct hv_device *device, void *additional_info)
 
 	net_device->ring_size = ring_size;
 
-	set_per_channel_state(device->channel, net_device->cb_buffer);
-
 	/* Open the channel */
 	ret = vmbus_open(device->channel, ring_size * PAGE_SIZE,
 			 ring_size * PAGE_SIZE, NULL, 0,
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 8d90904e0e49..113c7f4d1590 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -948,9 +948,6 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 	if (chn_index >= nvscdev->num_chn)
 		return;
 
-	set_per_channel_state(new_sc, nvscdev->sub_cb_buf + (chn_index - 1) *
-			      NETVSC_PACKET_SIZE);
-
 	nvscdev->mrc[chn_index].buf = vzalloc(NETVSC_RECVSLOT_MAX *
 					      sizeof(struct recv_comp_data));
 
@@ -1099,14 +1096,6 @@ int rndis_filter_device_add(struct hv_device *dev,
 	if (net_device->num_chn == 1)
 		goto out;
 
-	net_device->sub_cb_buf = vzalloc((net_device->num_chn - 1) *
-					 NETVSC_PACKET_SIZE);
-	if (!net_device->sub_cb_buf) {
-		net_device->num_chn = 1;
-		dev_info(&dev->device, "No memory for subchannels.\n");
-		goto out;
-	}
-
 	vmbus_set_sc_create_callback(dev->channel, netvsc_sc_open);
 
 	init_packet = &net_device->channel_init_pkt;
-- 
2.11.0
