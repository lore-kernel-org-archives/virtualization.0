Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8F4A8FE4
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001983; cv=none; b=rdfSHPUT3+ifkypskUZcHe+MMOPHaGlKjglr5WfftgQpCQ5OrUm2PrUdvazjTGpypN8eXwSr4LDT0t+IMJA19jv6FPjgVFZmNQLKTp638EVuBinUeknhheCnr726VnfgR4tWxzUBjTQjwCdUFDYjMfSyq40B1cK5zQeJas/7Ta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001983; c=relaxed/simple;
	bh=9JEOL0jy1qSQHFHqo2htCvwnRH6aK2JI6t7iRw9IZrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQxTXblVwN+3U5dNqO1enFK1AiYaWuayoWNB82tFK1R1ijhmPOeAQg9G/wifKF/NLQPljRqjiG9arjLuznzos1HJZjKOroiJrK5GdjEsIWaNVwysQsCdt+fGLMsj9/PJFTuULTrRJq9vdSDJXaykqSsC4lXaBj5oLjU6Z5wsYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:4b01:1e0e:d42d:4ec8:33b2])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 905E2201F07;
	Mon, 21 Sep 2026 16:46:14 +0200 (CEST)
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 21 Sep 2026 16:46:10 +0200
Subject: [PATCH RFC v3 1/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-v6-7-topic-virtio-net-ptp-v3-1-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8965;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=9JEOL0jy1qSQHFHqo2htCvwnRH6aK2JI6t7iRw9IZrA=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9ZGZ9M5kmtOvjRZxm7wKzNqW7O8tUTuUtmQ/O6f55wup
 lnt0TbsKGVhEONikBVTZFFZWMEn6vHBM3KaCBfMHFYmkCEMXJwCMBGjX4wMswszi8W44uQXm119
 G/N1g9i6aSI5R75reTMcKv1/MeSrAyPDm38LDq0xCS3x+rh4g1P/VWtNy7y7h6NPnfwgtUGr4pc
 KLwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Add optional hardware rx timestamp offload for virtio-net.

Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
virtio-net header is expanded with room for a timestamp.

To get and set the hwtstamp the functions ndo_hwtstamp_set/get are
implemented. This allows filtering the packets and only time stamp
the packets where the filter matches. This way, the timestamping can
be en/disabled at runtime.
Currently, timestamping is handled the same for all supported filters and
therefore handled the same for all received packets.

XDP packets are not supported and timestamping is skipped for the XDP path.

Tested:
  guest: ./timestamping eth0 \
          SOF_TIMESTAMPING_RAW_HARDWARE \
          SOF_TIMESTAMPING_RX_HARDWARE
  host: nc -4 -u 192.168.1.1 319

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

--
  Changes to v2:
  - update filter handling
  - move tstamp into virtio_net_common_hdr
  - remove new struct virtio_net_hdr_v1_hash_tunnel_ts
  Changes to v1:
  - rework series to use flow filters
  - add new struct virtio_net_hdr_v1_hash_tunnel_ts
  - original work done by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c        | 127 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |   1 +
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d39..ef6238cb336b9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -416,6 +416,12 @@ struct virtnet_info {
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
 
+	/* Device passes time stamps to the driver */
+	bool has_tstamp;
+	bool hwts_rx_en;
+
+	struct kernel_hwtstamp_config tstamp_config;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -499,6 +505,8 @@ struct virtio_net_common_hdr {
 		struct virtio_net_hdr_v1_hash hash_v1_hdr;
 		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
 	};
+
+	__le16 tstamp[4];	/* 64-bit timestamp, 2-byte aligned */
 };
 
 static struct virtio_net_common_hdr xsk_hdr;
@@ -2468,6 +2476,15 @@ virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
 		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
 }
 
+static inline u64
+virtio_net_tstamp_value(const struct virtio_net_common_hdr *hdr)
+{
+	return (u64)__le16_to_cpu(hdr->tstamp[0]) |
+	      ((u64)__le16_to_cpu(hdr->tstamp[1]) << 16) |
+	      ((u64)__le16_to_cpu(hdr->tstamp[2]) << 32) |
+	      ((u64)__le16_to_cpu(hdr->tstamp[3]) << 48);
+}
+
 static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 				struct sk_buff *skb)
 {
@@ -2497,6 +2514,18 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type);
 }
 
+static inline void virtnet_record_rx_tstamp(const struct virtnet_info *vi,
+					    struct sk_buff *skb)
+{
+	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+	const struct virtio_net_common_hdr *h = skb_vnet_common_hdr(skb);
+	u64 ts;
+
+	ts = virtio_net_tstamp_value(h);
+	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+	shhwtstamps->hwtstamp = ns_to_ktime(ts);
+}
+
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
 				 struct sk_buff *skb, u8 flags)
 {
@@ -2590,6 +2619,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!skb))
 		return;
 
+	if (likely(skb) && likely(!vi->xdp_enabled) && READ_ONCE(vi->hwts_rx_en))
+		virtnet_record_rx_tstamp(vi, skb);
+
 	virtnet_receive_done(vi, rq, skb, flags);
 }
 
@@ -5518,6 +5550,30 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_get_ts_info(struct net_device *dev,
+			       struct kernel_ethtool_ts_info *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	/* setup default software timestamp */
+	ethtool_op_get_ts_info(dev, info);
+
+	if (vi->has_tstamp) {
+		info->so_timestamping |=
+			SOF_TIMESTAMPING_RX_HARDWARE |
+			SOF_TIMESTAMPING_RAW_HARDWARE;
+
+		info->rx_filters = (BIT(HWTSTAMP_FILTER_NONE) |
+				    BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
+				    BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
+				    BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
+				    BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+				    BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ));
+	}
+
+	return 0;
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5613,7 +5669,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_ethtool_stats = virtnet_get_ethtool_stats,
 	.set_channels = virtnet_set_channels,
 	.get_channels = virtnet_get_channels,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = virtnet_get_ts_info,
 	.get_link_ksettings = virtnet_get_link_ksettings,
 	.set_link_ksettings = virtnet_set_link_ksettings,
 	.set_coalesce = virtnet_set_coalesce,
@@ -6212,6 +6268,61 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
 }
 
+static int virtnet_hwtstamp_get(struct net_device *dev,
+				struct kernel_hwtstamp_config *config)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	if (!vi->has_tstamp)
+		return -EOPNOTSUPP;
+
+	*config = vi->tstamp_config;
+
+	return 0;
+}
+
+static int virtnet_hwtstamp_set(struct net_device *dev,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	if (!vi->has_tstamp)
+		return -EOPNOTSUPP;
+
+	config->tx_type = HWTSTAMP_TX_OFF;
+
+	if (unlikely(vi->xdp_enabled))
+		return -EOPNOTSUPP;
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		WRITE_ONCE(vi->hwts_rx_en, false);
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		WRITE_ONCE(vi->hwts_rx_en, true);
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	default:
+		config->rx_filter = HWTSTAMP_FILTER_NONE;
+		return -ERANGE;
+	}
+
+	vi->tstamp_config = *config;
+
+	return 0;
+}
+
 static int virtnet_init_irq_moder(struct virtnet_info *vi)
 {
 	u8 profile_flags = 0, coal_flags = 0;
@@ -6272,6 +6383,8 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
 	.ndo_tx_timeout		= virtnet_tx_timeout,
+	.ndo_hwtstamp_set	= virtnet_hwtstamp_set,
+	.ndo_hwtstamp_get	= virtnet_hwtstamp_get,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -6878,6 +6991,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_TSTAMP))
+		vi->has_tstamp = true;
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
@@ -6922,6 +7038,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 	else
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
 
+	if (vi->has_tstamp)
+		vi->hdr_len = offsetof(struct virtio_net_common_hdr, tstamp) +
+			      sizeof_field(struct virtio_net_common_hdr, tstamp);
+
+	vi->hwts_rx_en = false;
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
 		vi->rx_tnl_csum = true;
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO))
@@ -7248,7 +7370,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
-	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
+	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
+	VIRTIO_NET_F_TSTAMP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b5..39977765b72aa 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_TSTAMP	  49	/* Device sends TAI receive time */
 #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */

-- 
2.52.0

