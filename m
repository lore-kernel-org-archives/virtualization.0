Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794482419;
	b=C5NB27gWCFUmG+dm+DUyUzmB/w0+mbnEyzxZUVh/r8FmcOpxb/Mn6x6bJpD+/+jAW00U
	 VZ01kqQ+5djJ97a92tq3DJ71+lkepyqVP8O0XMHT26T+ojW1tz+8eNwu5BsEjGqMbvWFh
	 YwlCPbV1xx8dV4nl3h4/nJ3yfPfCt01BuU1d4/l1UPWMUmXZuPlUpFZuehdRyJOprh7FU
	 rM2TYUko215vWLssA3SOA16zaTcLMSa0k0LZI+x9RBuXWgtS3iwhr7KpsvZ3x9hEUefS4
	 cjFJknKmRnI7caVwWSKUs2RfN3EXYv2YyzvdQV4d59X6p57VNVtZHf6iFouSP8kx/Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482419;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OydsdcQ0lBU8caAFUIuul0fQc20tWhEfNqcNpy0fjA8=;
	b=h8SuzzavpZ5s5gpQwY11WrnKb7llnitdOw3+sUDwpnvWZXv13Jwkrg5XMRYsbkrr3VzU
	 ZbmhLekmEKUAq93sHXJiXepTv2EFOttZhHiNeoetL234ymExpzpCRBn6qUppgNyQ5i1f2
	 JqWtAuW9nDsUxMhrNNyxW4OwtTlFp31kBQPBWj/R+8HUDiBqAUBcyiQY8yobM1TIIzjRJ
	 R3r4J2T6yLOvQTn+neiMjRcfWe6tIBkrBgFT6pKYYHLbucrjNCtZl4YwaB999OaRjRYha
	 kKrXm9nFSVenqP/rsJXRXI8o9lYNfLpFq1F+MW6jSoiQziYzDu3UwGiCrUdNGjscepw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P9BHn5iX;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B060A5BFE
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE9B060A5BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P9BHn5iX
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 41F5C20581F;
	Thu, 12 Nov 2026 12:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OydsdcQ0lBU8caAFUIuul0fQc20tWhEfNqcNpy0fjA8=;
	b=P9BHn5iX6aJqw6hSgDJsZ0m/CI0ws3XyLEeU3CBX7IfNjtSCVs+M3wF+viEdm46+0F1xD+
	wsZ6xMcoBnuVAdYVY1m/ENonDjuD9oVdiU4RQk05o9eMwjQs5eaOtQN7LLHwni8aE612cI
	1K5qTF4HekLNPOR6Ui99WLXUJtOUEH0srF2c1ZTq4QiWPho8rSkXaNez2uSrGT4eaWLUyC
	LTDlHYfj9izWAS7QtBXJ+3A324F4I1QLbUlymqxa9CZniIyYrAKlFgU+t7jWilsGFE3OhD
	EjcEJF+Ad2r1J4T+kARCaIDJtLhsCkmMiBy3pjXR500IDEcA2oIXHDPrOt1Bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OydsdcQ0lBU8caAFUIuul0fQc20tWhEfNqcNpy0fjA8=;
	b=d1L/oYkIzDdswOtBYPR5FbnHHgK7NNOrdxKNOYRYV9raiGnxxGI52CjbsZtisJpmNynEQp
	Y0ekpr0PQxDSt4p4Q0iph47SOVZNOS8ccVps9RKXSx8yE4mP9jIRJCFclDPR0cFug2C1zy
	UMv81Vc0uuZhfsLHXutZCYrnyq+BKm1RRDttf5o9/vMV2MrRWRfuQCGq1HcJ+sue6kKr7g
	Ri1dnDaDLXR4qKqpK+DLWP8gxBEvSEzB2rsZ6CNqMsPyhL4Y13sBnr7aR+H+DclhDBDUWc
	xETzQ/SShAWFKdH772Q0fwJETum2Rp5qz80X3k5jgDPXztM3yI0uRIJPqW8DEA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482416; a=rsa-sha256;
	cv=none;
	b=PbRKPadPwU/V0apFmtlNMYydp0PprrOL4qOCaFUOuylRw95Rg7x9bLGYv4/Gm8zm83AqG5
	2/lUBWo+YBPxpopfZGppuWD/ITpX7lNhPl4kZrjCyLfGhR34CEmRY74zi21pUs9maoiqsg
	bOsx/kLB5oAm26lCXVX03pRHLZPYXWpx/zQQ5GWM6HPUhMcUlVDfB2tYfrAuT2G2ZyZm/e
	s6O9dWiNowNt0K7UOI4b2INwsHWYTbfHiW7saFHmW/hRe+L86IG215vyARx9k/f7yj0+T3
	r1yXZPXk0tuW9pObQgWJUV58+ND3d70uPxpmkCsp4w94vxFnRk5PoLM2NcFArw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:37 +0100
Subject: [PATCH net-next v5 5/9] virtio-net: support receive timestamp
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-5-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Liang Chen <liangchen.linux@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13728;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=HYsIsVWc87i3J9U5yTaQkRwcFwTd+B0b/Ldf497M/mQ=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBW9arYSFrnf+XbZ9f0eb4cIpLjzcn0vextduUeRjC
 p5VqDulo5SFQYyLQVZMkUVlYQWfqMcHz8hpIlwwc1iZQIYwcHEKwERM7jAyTHf48sIhxKTg9qb2
 brbvcWqlix5sOGYqrPls0wW/pq36xgz/dJ2mhrR/55pZVRm4YUVHm8yP+qCkOZKvIvIO/+3acHk
 HPwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Add optional hardware rx timestamp offload for virtio-net.

Introduce the virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
virtio-net header grows by room for a 64 bit TAI timestamp (header
size 40 bytes), stored in struct virtio_net_common_hdr. The layout is
cumulative: the field is at the same offset whether or not the
features before it were negotiated. The fixed layout needs
VIRTIO_F_VERSION_1, so the feature is cleared without it.

Implement ndo_hwtstamp_get/set so the timestamping can be enabled
and disabled at runtime with SIOCSHWTSTAMP. The driver cannot filter
what the device timestamps, so any rx filter other than NONE becomes
ALL. The timestamp is read before the packet is handed to the XDP
program or the stack, and attached to the skb with skb_hwtstamps().
It is a raw TAI value; there is no PHC.

The header size is negotiated per device and also applies to
transmitted packets. xmit_skb() clears the whole header, so the device
sees a zero tstamp.

On receive in big packet mode, the header is placed in front of the
data in the first page. Grow padded_vnet_hdr to 48 bytes so the
40 byte header still fits there.

Tested in a guest with a patched QEMU:
  guest: ./timestamping eth0 \
          SOF_TIMESTAMPING_RAW_HARDWARE \
          SOF_TIMESTAMPING_RX_HARDWARE
  host:  nc -4 -u 192.168.1.1 319

Based on work by Willem de Bruijn.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c        | 131 +++++++++++++++++++++++++++++++++++-----
 include/linux/virtio_net.h      |  10 +++
 include/uapi/linux/virtio_net.h |   1 +
 3 files changed, 127 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 23e7f62a6ff64..57b7c32625dfb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -20,6 +20,7 @@
 #include <linux/filter.h>
 #include <linux/kernel.h>
 #include <linux/dim.h>
+#include <linux/unaligned.h>
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
@@ -418,6 +419,12 @@ struct virtnet_info {
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
 
+	/* Device passes time stamps to the driver */
+	bool rx_tstamp_supported;
+	bool rx_tstamp_enabled;
+
+	struct kernel_hwtstamp_config tstamp_config;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -482,15 +489,17 @@ static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
 	      offsetof(struct virtnet_info, rss_hash_key_data));
 
 struct padded_vnet_hdr {
-	struct virtio_net_hdr_v1_hash hdr;
+	struct virtio_net_common_hdr hdr;
 	/*
 	 * hdr is in a separate sg buffer, and data sg buffer shares same page
 	 * with this header sg. This padding makes next sg 16 byte aligned
 	 * after the header.
 	 */
-	char padding[12];
+	char padding[8];
 };
 
+static_assert(sizeof(struct padded_vnet_hdr) % 16 == 0);
+
 /*
  * The vnet header sits in the headroom in front of xdp->data, which the
  * XDP program may overwrite with bpf_xdp_adjust_head() or
@@ -520,7 +529,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       unsigned int *xdp_xmit,
 			       struct virtnet_rq_stats *stats);
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
-				 struct sk_buff *skb, u8 flags);
+				 struct sk_buff *skb, u8 flags, ktime_t tstamp);
 static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
 					       struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
@@ -1299,14 +1308,25 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	return NULL;
 }
 
+static inline ktime_t virtnet_record_rx_tstamp(const struct virtnet_info *vi,
+					       const struct virtio_net_common_hdr *hdr)
+{
+	if (!READ_ONCE(vi->rx_tstamp_enabled))
+		return 0;
+
+	return ns_to_ktime(get_unaligned_le64(hdr->tstamp));
+}
+
 static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
 				    void *buf, u32 len,
 				    unsigned int *xdp_xmit,
 				    struct virtnet_rq_stats *stats)
 {
 	struct net_device *dev = vi->dev;
+	struct virtio_net_common_hdr *hdr;
 	struct sk_buff *skb = NULL;
 	struct xdp_buff *xdp;
+	ktime_t tstamp;
 	u8 flags;
 
 	len -= vi->hdr_len;
@@ -1324,7 +1344,9 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 		return;
 	}
 
-	flags = ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len))->hdr.flags;
+	hdr = (struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len);
+	flags = hdr->hdr.flags;
+	tstamp = virtnet_record_rx_tstamp(vi, hdr);
 
 	if (!vi->mergeable_rx_bufs)
 		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
@@ -1332,7 +1354,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
 
 	if (skb)
-		virtnet_receive_done(vi, rq, skb, flags);
+		virtnet_receive_done(vi, rq, skb, flags, tstamp);
 }
 
 static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
@@ -2540,7 +2562,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 }
 
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
-				 struct sk_buff *skb, u8 flags)
+				 struct sk_buff *skb, u8 flags, ktime_t tstamp)
 {
 	struct virtio_net_common_hdr *hdr;
 	struct net_device *dev = vi->dev;
@@ -2549,6 +2571,9 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
 		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
 
+	if (tstamp)
+		skb_hwtstamps(skb)->hwtstamp = tstamp;
+
 	hdr->hdr.flags = flags;
 	if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csum)) {
 		net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x rx_tnl_csum %d\n",
@@ -2587,8 +2612,10 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			unsigned int *xdp_xmit,
 			struct virtnet_rq_stats *stats)
 {
+	struct virtio_net_common_hdr *hdr;
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
+	ktime_t tstamp;
 	u8 flags;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
@@ -2618,23 +2645,27 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	 */
 
 	if (vi->mergeable_rx_bufs) {
-		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
+		hdr = buf;
+		flags = hdr->hdr.flags;
+		tstamp = virtnet_record_rx_tstamp(vi, hdr);
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
 	} else if (vi->big_packets) {
-		void *p = page_address((struct page *)buf);
-
-		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
+		hdr = page_address((struct page *)buf);
+		flags = hdr->hdr.flags;
+		tstamp = virtnet_record_rx_tstamp(vi, hdr);
 		skb = receive_big(dev, vi, rq, buf, len, stats);
 	} else {
-		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
+		hdr = buf;
+		flags = hdr->hdr.flags;
+		tstamp = virtnet_record_rx_tstamp(vi, hdr);
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
 	}
 
 	if (unlikely(!skb))
 		return;
 
-	virtnet_receive_done(vi, rq, skb, flags);
+	virtnet_receive_done(vi, rq, skb, flags, tstamp);
 }
 
 static int virtnet_rq_submit(struct receive_queue *rq, char *buf,
@@ -5575,6 +5606,27 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
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
+	if (vi->rx_tstamp_supported) {
+		info->so_timestamping |=
+			SOF_TIMESTAMPING_RX_HARDWARE |
+			SOF_TIMESTAMPING_RAW_HARDWARE;
+
+		info->tx_types = BIT(HWTSTAMP_TX_OFF);
+		info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+				   BIT(HWTSTAMP_FILTER_ALL);
+	}
+
+	return 0;
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5670,7 +5722,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_ethtool_stats = virtnet_get_ethtool_stats,
 	.set_channels = virtnet_set_channels,
 	.get_channels = virtnet_get_channels,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = virtnet_get_ts_info,
 	.get_link_ksettings = virtnet_get_link_ksettings,
 	.set_link_ksettings = virtnet_set_link_ksettings,
 	.set_coalesce = virtnet_set_coalesce,
@@ -6269,6 +6321,43 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
 }
 
+static int virtnet_hwtstamp_get(struct net_device *dev,
+				struct kernel_hwtstamp_config *config)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	if (!vi->rx_tstamp_supported)
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
+	if (!vi->rx_tstamp_supported)
+		return -EOPNOTSUPP;
+
+	if (config->tx_type != HWTSTAMP_TX_OFF) {
+		NL_SET_ERR_MSG_MOD(extack, "TX timestamping is not supported");
+		return -ERANGE;
+	}
+
+	/* The driver cannot filter, any filter becomes ALL */
+	if (config->rx_filter != HWTSTAMP_FILTER_NONE)
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+
+	WRITE_ONCE(vi->rx_tstamp_enabled, config->rx_filter == HWTSTAMP_FILTER_ALL);
+	vi->tstamp_config = *config;
+
+	return 0;
+}
+
 static int virtnet_init_irq_moder(struct virtnet_info *vi)
 {
 	u8 profile_flags = 0, coal_flags = 0;
@@ -6329,6 +6418,8 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
 	.ndo_tx_timeout		= virtnet_tx_timeout,
+	.ndo_hwtstamp_set	= virtnet_hwtstamp_set,
+	.ndo_hwtstamp_get	= virtnet_hwtstamp_get,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -6740,6 +6831,10 @@ static int virtnet_validate(struct virtio_device *vdev)
 		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
 	}
 
+	/* The fixed header layout with tstamp at offset 32 needs VERSION_1 */
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		__virtio_clear_bit(vdev, VIRTIO_NET_F_RX_TSTAMP);
+
 	return 0;
 }
 
@@ -6932,6 +7027,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP))
+		vi->rx_tstamp_supported = true;
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
@@ -6965,8 +7063,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+	if (vi->rx_tstamp_supported)
+		vi->hdr_len = offsetofend(struct virtio_net_common_hdr, tstamp);
+	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
+		 virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
 	else if (vi->has_rss_hash_report)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
@@ -7309,6 +7409,7 @@ static unsigned int features[] = {
 	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
 	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
 	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
+	VIRTIO_NET_F_RX_TSTAMP,
 };
 
 static unsigned int features_legacy[] = {
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a6de308b8f25e..2abd8a614a23f 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -17,6 +17,16 @@ struct virtio_net_common_hdr {
 		struct virtio_net_hdr_v1_hash hash_v1_hdr;
 		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
 	};
+	/*
+	 * The wire layout is fixed and cumulative: a field sits at the same
+	 * offset whether or not the features before it were negotiated; unused
+	 * bytes are padding. tstamp is thus always at offset 32 and only
+	 * present (header size 40) if VIRTIO_NET_F_RX_TSTAMP was negotiated.
+	 * The negotiated header size tells how much of this struct is
+	 * on the wire. Only ever append new fields at the end.
+	 */
+	__u8 reserved[8];	/* outer_nh_offset, ipsec_resource_hdr (not implemented) */
+	__le16 tstamp[4];	/* le64 TAI receive time in ns, 0 if none */
 };
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b5..15e8e408d50fb 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_RX_TSTAMP	  49	/* Device sends TAI receive time */
 #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */

-- 
2.56.0

