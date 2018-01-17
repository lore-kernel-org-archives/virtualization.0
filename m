From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net-next] virtio_net: Add ethtool stats
Date: Wed, 17 Jan 2018 15:38:25 +0900
Message-ID: <1516171105-2483-1-git-send-email-makita.toshiaki__45785.6531757445$1516171172$gmane$org@lab.ntt.co.jp>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Florian Fainelli <f.fainelli@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

The main purpose of this patch is adding a way of checking per-queue stats.
It's useful to debug performance problems on multiqueue environment.

$ ethtool -S ens10
NIC statistics:
     rx_queue_0_packets: 2090408
     rx_queue_0_bytes: 3164825094
     rx_queue_1_packets: 2082531
     rx_queue_1_bytes: 3152932314
     tx_queue_0_packets: 2770841
     tx_queue_0_bytes: 4194955474
     tx_queue_1_packets: 3084697
     tx_queue_1_bytes: 4670196372

This change converts existing per-cpu stats structure into per-queue one.
This should not impact on performance since each queue counter is not
updated concurrently by multiple cpus.

Performance numbers:
 - Guest has 2 vcpus and 2 queues
 - Guest runs netserver
 - Host runs 100-flow super_netperf

                     Before      After       Diff
UDP_STREAM 18byte        86.22       87.00   +0.90%
UDP_STREAM 1472byte    4055.27     4042.18   -0.32%
TCP_STREAM            16956.32    16890.63   -0.39%
UDP_RR               178667.11   185862.70   +4.03%
TCP_RR               128473.04   124985.81   -2.71%

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
v2:
- Removed redundant counters which can be obtained from dev_get_stats.
- Made queue counter structure different for tx and rx so they can be
  easily extended separately, as some additional counters are expected
  like XDP related ones and VM-Exit event.
- Added performance numbers in commitlog.

 drivers/net/virtio_net.c | 191 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 141 insertions(+), 50 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 12dfc5f..626c273 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -66,16 +66,39 @@
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
+struct virtnet_stat_desc {
+	char desc[ETH_GSTRING_LEN];
+	size_t offset;
 };
 
+struct virtnet_sq_stats {
+	struct u64_stats_sync syncp;
+	u64 packets;
+	u64 bytes;
+};
+
+struct virtnet_rq_stats {
+	struct u64_stats_sync syncp;
+	u64 packets;
+	u64 bytes;
+};
+
+#define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
+#define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
+
+static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
+	{ "packets",	VIRTNET_SQ_STAT(packets) },
+	{ "bytes",	VIRTNET_SQ_STAT(bytes) },
+};
+
+static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
+	{ "packets",	VIRTNET_RQ_STAT(packets) },
+	{ "bytes",	VIRTNET_RQ_STAT(bytes) },
+};
+
+#define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
+#define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
+
 /* Internal representation of a send virtqueue */
 struct send_queue {
 	/* Virtqueue associated with this send _queue */
@@ -87,6 +110,8 @@ struct send_queue {
 	/* Name of the send queue: output.$index */
 	char name[40];
 
+	struct virtnet_sq_stats stats;
+
 	struct napi_struct napi;
 };
 
@@ -99,6 +124,8 @@ struct receive_queue {
 
 	struct bpf_prog __rcu *xdp_prog;
 
+	struct virtnet_rq_stats stats;
+
 	/* Chain pages by the private ptr. */
 	struct page *pages;
 
@@ -152,9 +179,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Active statistics */
-	struct virtnet_stats __percpu *stats;
-
 	/* Work struct for refilling if we run low on memory. */
 	struct delayed_work refill;
 
@@ -1127,7 +1151,6 @@ static int virtnet_receive(struct receive_queue *rq, int budget, bool *xdp_xmit)
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int len, received = 0, bytes = 0;
 	void *buf;
-	struct virtnet_stats *stats = this_cpu_ptr(vi->stats);
 
 	if (!vi->big_packets || vi->mergeable_rx_bufs) {
 		void *ctx;
@@ -1150,10 +1173,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget, bool *xdp_xmit)
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
@@ -1162,8 +1185,6 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 {
 	struct sk_buff *skb;
 	unsigned int len;
-	struct virtnet_info *vi = sq->vq->vdev->priv;
-	struct virtnet_stats *stats = this_cpu_ptr(vi->stats);
 	unsigned int packets = 0;
 	unsigned int bytes = 0;
 
@@ -1182,10 +1203,10 @@ static void free_old_xmit_skbs(struct send_queue *sq)
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
@@ -1474,24 +1495,25 @@ static void virtnet_stats(struct net_device *dev,
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
@@ -1829,6 +1851,83 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
+static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	char *p = (char *)data;
+	unsigned int i, j;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < vi->curr_queue_pairs; i++) {
+			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
+				snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
+					 i, virtnet_rq_stats_desc[j].desc);
+				p += ETH_GSTRING_LEN;
+			}
+		}
+
+		for (i = 0; i < vi->curr_queue_pairs; i++) {
+			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
+				snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_%s",
+					 i, virtnet_sq_stats_desc[j].desc);
+				p += ETH_GSTRING_LEN;
+			}
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
+		return vi->curr_queue_pairs * (VIRTNET_RQ_STATS_LEN +
+					       VIRTNET_SQ_STATS_LEN);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void virtnet_get_ethtool_stats(struct net_device *dev,
+				      struct ethtool_stats *stats, u64 *data)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	unsigned int idx = 0, start, i, j;
+	const u8 *stats_base;
+	size_t offset;
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+
+		stats_base = (u8 *)&rq->stats;
+		do {
+			start = u64_stats_fetch_begin_irq(&rq->stats.syncp);
+			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
+				offset = virtnet_rq_stats_desc[j].offset;
+				data[idx + j] = *(u64 *)(stats_base + offset);
+			}
+		} while (u64_stats_fetch_retry_irq(&rq->stats.syncp, start));
+		idx += VIRTNET_RQ_STATS_LEN;
+	}
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct send_queue *sq = &vi->sq[i];
+
+		stats_base = (u8 *)&sq->stats;
+		do {
+			start = u64_stats_fetch_begin_irq(&sq->stats.syncp);
+			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
+				offset = virtnet_sq_stats_desc[j].offset;
+				data[idx + j] = *(u64 *)(stats_base + offset);
+			}
+		} while (u64_stats_fetch_retry_irq(&sq->stats.syncp, start));
+		idx += VIRTNET_SQ_STATS_LEN;
+	}
+}
+
 static void virtnet_get_channels(struct net_device *dev,
 				 struct ethtool_channels *channels)
 {
@@ -1928,6 +2027,9 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
+	.get_strings = virtnet_get_strings,
+	.get_sset_count = virtnet_get_sset_count,
+	.get_ethtool_stats = virtnet_get_ethtool_stats,
 	.set_channels = virtnet_set_channels,
 	.get_channels = virtnet_get_channels,
 	.get_ts_info = ethtool_op_get_ts_info,
@@ -2420,6 +2522,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
+
+		u64_stats_init(&vi->rq[i].stats.syncp);
+		u64_stats_init(&vi->sq[i].stats.syncp);
 	}
 
 	return 0;
@@ -2544,7 +2649,7 @@ static int virtnet_validate(struct virtio_device *vdev)
 
 static int virtnet_probe(struct virtio_device *vdev)
 {
-	int i, err;
+	int i, err = -ENOMEM;
 	struct net_device *dev;
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
@@ -2621,17 +2726,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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
 
@@ -2668,7 +2762,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			 */
 			dev_err(&vdev->dev, "device MTU appears to have changed "
 				"it is now %d < %d", mtu, dev->min_mtu);
-			goto free_stats;
+			goto free;
 		}
 
 		dev->mtu = mtu;
@@ -2692,7 +2786,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
 	err = init_vqs(vi);
 	if (err)
-		goto free_stats;
+		goto free;
 
 #ifdef CONFIG_SYSFS
 	if (vi->mergeable_rx_bufs)
@@ -2747,8 +2841,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
-free_stats:
-	free_percpu(vi->stats);
 free:
 	free_netdev(dev);
 	return err;
@@ -2781,7 +2873,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	free_percpu(vi->stats);
 	free_netdev(vi->dev);
 }
 
-- 
1.8.3.1
