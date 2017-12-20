From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH net-next] virtio_net: Add ethtool stats
Date: Wed, 20 Dec 2017 13:40:37 +0900
Message-ID: <1513744837-2672-1-git-send-email-makita.toshiaki__34828.1119521291$1513744879$gmane$org@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "David S . Miller" <davem@davemloft.net>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The main purpose of this patch is adding a way of checking per-queue stats.
It's useful to debug performance problems on multiqueue environment.

$ ethtool -S ens10
NIC statistics:
     rx_packets: 4172939
     tx_packets: 5855538
     rx_bytes: 6317757408
     tx_bytes: 8865151846
     rx_dropped: 0
     rx_length_errors: 0
     rx_frame_errors: 0
     tx_dropped: 0
     tx_fifo_errors: 0
     rx_queue_0_packets: 2090408
     rx_queue_0_bytes: 3164825094
     rx_queue_1_packets: 2082531
     rx_queue_1_bytes: 3152932314
     tx_queue_0_packets: 2770841
     tx_queue_0_bytes: 4194955474
     tx_queue_1_packets: 3084697
     tx_queue_1_bytes: 4670196372

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/virtio_net.c | 187 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 136 insertions(+), 51 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6fb7b65..a0a7bf5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -65,14 +65,31 @@
 	VIRTIO_NET_F_GUEST_UFO
 };
 
-struct virtnet_stats {
-	struct u64_stats_sync tx_syncp;
-	struct u64_stats_sync rx_syncp;
-	u64 tx_bytes;
-	u64 tx_packets;
-
-	u64 rx_bytes;
-	u64 rx_packets;
+struct virtnet_gstats {
+	char stat_string[ETH_GSTRING_LEN];
+	int stat_offset;
+};
+
+#define VIRTNET_NETDEV_STAT(m)	offsetof(struct rtnl_link_stats64, m)
+
+static const struct virtnet_gstats virtnet_gstrings_stats[] = {
+	{ "rx_packets",		VIRTNET_NETDEV_STAT(rx_packets) },
+	{ "tx_packets",		VIRTNET_NETDEV_STAT(tx_packets) },
+	{ "rx_bytes",		VIRTNET_NETDEV_STAT(rx_bytes) },
+	{ "tx_bytes",		VIRTNET_NETDEV_STAT(tx_bytes) },
+	{ "rx_dropped",		VIRTNET_NETDEV_STAT(rx_dropped) },
+	{ "rx_length_errors",	VIRTNET_NETDEV_STAT(rx_length_errors) },
+	{ "rx_frame_errors",	VIRTNET_NETDEV_STAT(rx_frame_errors) },
+	{ "tx_dropped",		VIRTNET_NETDEV_STAT(tx_dropped) },
+	{ "tx_fifo_errors",	VIRTNET_NETDEV_STAT(tx_fifo_errors) },
+};
+
+# define VIRTNET_GSTATS_LEN	ARRAY_SIZE(virtnet_gstrings_stats)
+
+struct virtnet_queue_stats {
+	struct u64_stats_sync syncp;
+	u64 bytes;
+	u64 packets;
 };
 
 /* Internal representation of a send virtqueue */
@@ -86,6 +103,8 @@ struct send_queue {
 	/* Name of the send queue: output.$index */
 	char name[40];
 
+	struct virtnet_queue_stats stats;
+
 	struct napi_struct napi;
 };
 
@@ -98,6 +117,8 @@ struct receive_queue {
 
 	struct bpf_prog __rcu *xdp_prog;
 
+	struct virtnet_queue_stats stats;
+
 	/* Chain pages by the private ptr. */
 	struct page *pages;
 
@@ -149,9 +170,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Active statistics */
-	struct virtnet_stats __percpu *stats;
-
 	/* Work struct for refilling if we run low on memory. */
 	struct delayed_work refill;
 
@@ -1121,7 +1139,6 @@ static int virtnet_receive(struct receive_queue *rq, int budget, bool *xdp_xmit)
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int len, received = 0, bytes = 0;
 	void *buf;
-	struct virtnet_stats *stats = this_cpu_ptr(vi->stats);
 
 	if (!vi->big_packets || vi->mergeable_rx_bufs) {
 		void *ctx;
@@ -1144,10 +1161,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget, bool *xdp_xmit)
 			schedule_delayed_work(&vi->refill, 0);
 	}
 
-	u64_stats_update_begin(&stats->rx_syncp);
-	stats->rx_bytes += bytes;
-	stats->rx_packets += received;
-	u64_stats_update_end(&stats->rx_syncp);
+	u64_stats_update_begin(&rq->stats.syncp);
+	rq->stats.bytes += bytes;
+	rq->stats.packets += received;
+	u64_stats_update_end(&rq->stats.syncp);
 
 	return received;
 }
@@ -1156,8 +1173,6 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 {
 	struct sk_buff *skb;
 	unsigned int len;
-	struct virtnet_info *vi = sq->vq->vdev->priv;
-	struct virtnet_stats *stats = this_cpu_ptr(vi->stats);
 	unsigned int packets = 0;
 	unsigned int bytes = 0;
 
@@ -1176,10 +1191,10 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 	if (!packets)
 		return;
 
-	u64_stats_update_begin(&stats->tx_syncp);
-	stats->tx_bytes += bytes;
-	stats->tx_packets += packets;
-	u64_stats_update_end(&stats->tx_syncp);
+	u64_stats_update_begin(&sq->stats.syncp);
+	sq->stats.bytes += bytes;
+	sq->stats.packets += packets;
+	u64_stats_update_end(&sq->stats.syncp);
 }
 
 static void virtnet_poll_cleantx(struct receive_queue *rq)
@@ -1463,24 +1478,24 @@ static void virtnet_stats(struct net_device *dev,
 			  struct rtnl_link_stats64 *tot)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int cpu;
 	unsigned int start;
+	int i;
 
-	for_each_possible_cpu(cpu) {
-		struct virtnet_stats *stats = per_cpu_ptr(vi->stats, cpu);
+	for (i = 0; i < vi->max_queue_pairs; i++) {
 		u64 tpackets, tbytes, rpackets, rbytes;
+		struct receive_queue *rq = &vi->rq[i];
+		struct send_queue *sq = &vi->sq[i];
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->tx_syncp);
-			tpackets = stats->tx_packets;
-			tbytes   = stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->tx_syncp, start));
-
+			start = u64_stats_fetch_begin_irq(&sq->stats.syncp);
+			tpackets = sq->stats.packets;
+			tbytes   = sq->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&sq->stats.syncp, start));
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->rx_syncp);
-			rpackets = stats->rx_packets;
-			rbytes   = stats->rx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->rx_syncp, start));
+			start = u64_stats_fetch_begin_irq(&rq->stats.syncp);
+			rpackets = rq->stats.packets;
+			rbytes   = rq->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&rq->stats.syncp, start));
 
 		tot->rx_packets += rpackets;
 		tot->tx_packets += tpackets;
@@ -1817,6 +1832,84 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
+static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	char *p = (char *)data;
+	unsigned int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < VIRTNET_GSTATS_LEN; i++) {
+			memcpy(p, virtnet_gstrings_stats[i].stat_string,
+			       ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
+		for (i = 0; i < vi->curr_queue_pairs; i++) {
+			sprintf(p, "rx_queue_%u_packets", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "rx_queue_%u_bytes", i);
+			p += ETH_GSTRING_LEN;
+		}
+		for (i = 0; i < vi->curr_queue_pairs; i++) {
+			sprintf(p, "tx_queue_%u_packets", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "tx_queue_%u_bytes", i);
+			p += ETH_GSTRING_LEN;
+		}
+		break;
+	}
+}
+
+static int virtnet_get_sset_count(struct net_device *dev, int sset)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		return VIRTNET_GSTATS_LEN + vi->curr_queue_pairs * 4;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void virtnet_get_ethtool_stats(struct net_device *dev,
+				      struct ethtool_stats *stats, u64 *data)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct rtnl_link_stats64 storage;
+	unsigned int idx = 0, start, i;
+	const u8 *stats_base;
+
+	stats_base = (u8 *)dev_get_stats(dev, &storage);
+	for (i = 0; i < VIRTNET_GSTATS_LEN; i++) {
+		data[idx++] = *(u64 *)(stats_base +
+				       virtnet_gstrings_stats[i].stat_offset);
+	}
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+
+		do {
+			start = u64_stats_fetch_begin_irq(&rq->stats.syncp);
+			data[idx] = rq->stats.packets;
+			data[idx + 1] = rq->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&rq->stats.syncp, start));
+		idx += 2;
+	}
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct send_queue *sq = &vi->sq[i];
+
+		do {
+			start = u64_stats_fetch_begin_irq(&sq->stats.syncp);
+			data[idx] = sq->stats.packets;
+			data[idx + 1] = sq->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&sq->stats.syncp, start));
+		idx += 2;
+	}
+}
+
 static void virtnet_get_channels(struct net_device *dev,
 				 struct ethtool_channels *channels)
 {
@@ -1898,6 +1991,9 @@ static void virtnet_init_settings(struct net_device *dev)
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
+	.get_strings = virtnet_get_strings,
+	.get_sset_count = virtnet_get_sset_count,
+	.get_ethtool_stats = virtnet_get_ethtool_stats,
 	.set_channels = virtnet_set_channels,
 	.get_channels = virtnet_get_channels,
 	.get_ts_info = ethtool_op_get_ts_info,
@@ -2389,6 +2485,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
+
+		u64_stats_init(&vi->rq[i].stats.syncp);
+		u64_stats_init(&vi->sq[i].stats.syncp);
 	}
 
 	return 0;
@@ -2513,7 +2612,7 @@ static int virtnet_validate(struct virtio_device *vdev)
 
 static int virtnet_probe(struct virtio_device *vdev)
 {
-	int i, err;
+	int i, err = -ENOMEM;
 	struct net_device *dev;
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
@@ -2590,17 +2689,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vi->dev = dev;
 	vi->vdev = vdev;
 	vdev->priv = vi;
-	vi->stats = alloc_percpu(struct virtnet_stats);
-	err = -ENOMEM;
-	if (vi->stats == NULL)
-		goto free;
-
-	for_each_possible_cpu(i) {
-		struct virtnet_stats *virtnet_stats;
-		virtnet_stats = per_cpu_ptr(vi->stats, i);
-		u64_stats_init(&virtnet_stats->tx_syncp);
-		u64_stats_init(&virtnet_stats->rx_syncp);
-	}
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 
@@ -2637,7 +2725,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			 */
 			dev_err(&vdev->dev, "device MTU appears to have changed "
 				"it is now %d < %d", mtu, dev->min_mtu);
-			goto free_stats;
+			goto free;
 		}
 
 		dev->mtu = mtu;
@@ -2661,7 +2749,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
 	err = init_vqs(vi);
 	if (err)
-		goto free_stats;
+		goto free;
 
 #ifdef CONFIG_SYSFS
 	if (vi->mergeable_rx_bufs)
@@ -2715,8 +2803,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
-free_stats:
-	free_percpu(vi->stats);
 free:
 	free_netdev(dev);
 	return err;
@@ -2749,7 +2835,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	free_percpu(vi->stats);
 	free_netdev(vi->dev);
 }
 
-- 
1.8.3.1
