Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003366;
	b=10Xr7lw52WCgC+kWwmOzRC6ESKvUZU6FhsE25tacZ/u4IuLsj0n7nokHetyeWGvuG3Ei
	 zkvi/7SKwUWHu8bmG6Rb3xEVmCAgBPQqzDSUXYHNmx9BRn+dKYeXMWOoJSesA1aJQJopL
	 JNabfeu+xH7MZ5M2QDf1serOWwUaRO09JT7eGhiAyQFsWsLRid7OJPHVuOEZ1fVy1pZ8r
	 FmeNJ0y9k6OgjfGs3tWoKqbgxkBza02ge9IMWOqFCQXww9MMrYnPg62oaB55khkNrRWg9
	 krCEMLVjRbdsrnWuuJOfXHtMwWuuLQwg1KfFgxCzLAJewgHqnA4fa/zm4AcU4VbKkIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003366;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1C7uw7HpFUzJjexgNjuIc9QL3Um2RC1V4ElZvVWlQuU=;
	b=gEt+Ha+AhDUHXrBnr8CYoNh+vaJH5cWVALiogmr84KkGqSI99AuTO/xCyn1BdkAnpt7K
	 ZN8s1ZxQ1NJsZS/5/29Wi1JGY8227Kce4x8nwWqgMisL87q1JfvkyIiBcYoOE7PgkHho8
	 Vnedtio+fAcNyE5nhJE6bRFGnHThQkxZZ98X4KjZn/6icjgjq3nCjwdrqXIFgJKjedMXn
	 9RwpUB38sxc8ZuUSAN3ZOjQL2z6XFkZXn1qtOW4JWpi9xXxUR49Fdl4VwjQUGQYLonvEO
	 SMznIFFHNZyZraJd4TV1b9v7OT8nNCHkG6zQ5EGDrJvF2mIL4Y72/ium2V6kXkl10cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gZrPvyEI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8B606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gZrPvyEI
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 49050201955;
	Mon, 26 Oct 2026 09:29:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C7uw7HpFUzJjexgNjuIc9QL3Um2RC1V4ElZvVWlQuU=;
	b=gZrPvyEI8zjKjqvV1o7FDyYrng3Z/X7YWIC5JTnLW8MulydNWXcqwBOPARSoMOK1A1Az6m
	Xhvb6tSyRbciN2rQzBhGBt1UrBvuiVh2MT4yDhgtWAV6oTLLKMH6rgTDocI9tTSF4ioKqh
	LHMh4hB+lbggcE4Uh6IF4Q+oGl/Xrc9UHkQxMKm8LsoCNSnRBWYHBabAAMlZcLSiX29m9z
	lXU+6i3KLnhs6kS0qPyQiM7kOot+7LnYtQnIHIlDImFSydBzJar0TBdLHqyFyABRRzDWct
	ZRok7ambrASl1ntvZuEFnwVN8Rsnx2TWVQ1FWwmHDEryXMH+NWq5Msu/DZfkIw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793003363; a=rsa-sha256;
	cv=none;
	b=VOdXJTj20rhCpxAC9XWJ8Qqn2Pm498Au1i19gNRzybgW4xKKfbOWN5qLatcwkk6b77kFMD
	2f0UYRQo8E0ptPdRBE5JR7SsXU3DypGJX/Gb0deFgDBXb+/b5IDJxMuQW9zA26Qes7sI6b
	b7csMJBCtJAhi69lW655AQlpDaC3D+KbHjcaEmEA7fW9jXa8HtUP2sBRywaC1fn8h4Lrvc
	PTdlTvMrWbAIPf7JqLFpiwsLijMo/VSGDp4wME6emP8Nw4x46uA2eCy7/sH/myS/ypletz
	Xd0J76KdvYqIcIkjgkSQXunzPpngUqbUX/8BjVabt99c+NjTiNDxm/JEY2lNTg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C7uw7HpFUzJjexgNjuIc9QL3Um2RC1V4ElZvVWlQuU=;
	b=R6D9LKsNzBFMiFc4IpbDcIzJaVsWJdyvnh/WkQXvojkIOir5EUq///bxt+ht4FBamiSqBu
	Mi5hX3AQvMsYGbv/eWl7H9Iihs3jnFKnhPpQQ+RT6m274zoW3htxdpbkJZl8lOvALcKYOi
	SaqHTABmuahw58g0/4VW0aI/1GqIgAmpUEnx9nGWsr0ail0A3KkOwDbBEAaCb0QPlw+DFx
	rVKXU2FbK2EPw1dpISx6ETHqxhSwzz0sK5HZFPJszawjtq8+Vf5CyWuDUn3J1GEM5pQyPJ
	zz9q4PuJLqEf2WPMiccYz/ACipzgLs/2EJiwaw+4poA4ZGiQbOHgwFsLzcuJnA==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 26 Oct 2026 09:29:02 +0100
Subject: [PATCH RFC v4 2/6] virtio-net: support receive timestamp
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
Message-Id: <20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
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
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14258;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=c3uZbyehDFOtaT+FLG5cDw8Iq9XGIITywBOpj0kYC38=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9Z9/sTNEpZ92+XEXL8kzyh4Inn7p4NbVMKL447up6sPf
 8laUsDaUcrCIMbFICumyKKysIJP1OODZ+Q0ES6YOaxMIEMYuDgFYCKzTBgZOsMt105RX5IXs8Lg
 Q3Ulh/2z/pq0Ekshjl8uW/XPyz2yZvjJuGSB4aOwZfMZFWXt1D4J7VkxZeFTuU08u/ieX3Q5Pe0
 MIwA=
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
transmitted packets. On transmit, zero the header behind the fields
the driver fills in, so the device sees a zero tstamp and no stale
skb->cb or headroom bytes.

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
Assisted-by: Claude:claude-opus-5-5
---
 drivers/net/virtio_net.c        | 136 +++++++++++++++++++++++++++++++++++-----
 include/linux/virtio_net.h      |  10 +++
 include/uapi/linux/virtio_net.h |   1 +
 3 files changed, 131 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 17d3e32eed9d6..23af10c613b48 100644
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
@@ -416,6 +417,12 @@ struct virtnet_info {
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
 
+	/* Device passes time stamps to the driver */
+	bool has_rx_tstamp;
+	bool hwts_rx_en;
+
+	struct kernel_hwtstamp_config tstamp_config;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -483,14 +490,15 @@ static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
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
 
 static struct virtio_net_common_hdr xsk_hdr;
 
@@ -501,7 +509,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       unsigned int *xdp_xmit,
 			       struct virtnet_rq_stats *stats);
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
-				 struct sk_buff *skb, u8 flags);
+				 struct sk_buff *skb, u8 flags, ktime_t tstamp);
 static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
 					       struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
@@ -1274,14 +1282,25 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	return NULL;
 }
 
+static inline ktime_t virtnet_record_rx_tstamp(const struct virtnet_info *vi,
+					       const struct virtio_net_common_hdr *hdr)
+{
+	if (!READ_ONCE(vi->hwts_rx_en))
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
@@ -1299,7 +1318,9 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 		return;
 	}
 
-	flags = ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len))->hdr.flags;
+	hdr = (struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len);
+	flags = hdr->hdr.flags;
+	tstamp = virtnet_record_rx_tstamp(vi, hdr);
 
 	if (!vi->mergeable_rx_bufs)
 		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
@@ -1307,7 +1328,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
 
 	if (skb)
-		virtnet_receive_done(vi, rq, skb, flags);
+		virtnet_receive_done(vi, rq, skb, flags, tstamp);
 }
 
 static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
@@ -2489,7 +2510,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 }
 
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
-				 struct sk_buff *skb, u8 flags)
+				 struct sk_buff *skb, u8 flags, ktime_t tstamp)
 {
 	struct virtio_net_common_hdr *hdr;
 	struct net_device *dev = vi->dev;
@@ -2498,6 +2519,9 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
 		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
 
+	if (tstamp)
+		skb_hwtstamps(skb)->hwtstamp = tstamp;
+
 	hdr->hdr.flags = flags;
 	if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csum)) {
 		net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x rx_tnl_csum %d\n",
@@ -2536,8 +2560,10 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			unsigned int *xdp_xmit,
 			struct virtnet_rq_stats *stats)
 {
+	struct virtio_net_common_hdr *hdr;
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
+	ktime_t tstamp;
 	u8 flags;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
@@ -2567,23 +2593,27 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
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
@@ -3303,6 +3333,10 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 					false, feature_hdrlen))
 		return -EPROTO;
 
+	/* Don't leak skb->cb or headroom; the device expects tstamp to be 0 */
+	if (hdr_len > sizeof(*hdr))
+		memset((u8 *)hdr + sizeof(*hdr), 0, hdr_len - sizeof(*hdr));
+
 	if (vi->mergeable_rx_bufs)
 		hdr->hash_hdr.hdr.num_buffers = 0;
 
@@ -5520,6 +5554,27 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
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
+	if (vi->has_rx_tstamp) {
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
@@ -5615,7 +5670,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_ethtool_stats = virtnet_get_ethtool_stats,
 	.set_channels = virtnet_set_channels,
 	.get_channels = virtnet_get_channels,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = virtnet_get_ts_info,
 	.get_link_ksettings = virtnet_get_link_ksettings,
 	.set_link_ksettings = virtnet_set_link_ksettings,
 	.set_coalesce = virtnet_set_coalesce,
@@ -6214,6 +6269,43 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
 }
 
+static int virtnet_hwtstamp_get(struct net_device *dev,
+				struct kernel_hwtstamp_config *config)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	if (!vi->has_rx_tstamp)
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
+	if (!vi->has_rx_tstamp)
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
+	WRITE_ONCE(vi->hwts_rx_en, config->rx_filter == HWTSTAMP_FILTER_ALL);
+	vi->tstamp_config = *config;
+
+	return 0;
+}
+
 static int virtnet_init_irq_moder(struct virtnet_info *vi)
 {
 	u8 profile_flags = 0, coal_flags = 0;
@@ -6274,6 +6366,8 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
 	.ndo_tx_timeout		= virtnet_tx_timeout,
+	.ndo_hwtstamp_set	= virtnet_hwtstamp_set,
+	.ndo_hwtstamp_get	= virtnet_hwtstamp_get,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -6685,6 +6779,10 @@ static int virtnet_validate(struct virtio_device *vdev)
 		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
 	}
 
+	/* The fixed header layout with tstamp at offset 32 needs VERSION_1 */
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		__virtio_clear_bit(vdev, VIRTIO_NET_F_RX_TSTAMP);
+
 	return 0;
 }
 
@@ -6880,6 +6978,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP))
+		vi->has_rx_tstamp = true;
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
@@ -6913,8 +7014,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+	if (vi->has_rx_tstamp)
+		vi->hdr_len = offsetofend(struct virtio_net_common_hdr, tstamp);
+	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
+		 virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
 	else if (vi->has_rss_hash_report)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
@@ -7250,7 +7353,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
-	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
+	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
+	VIRTIO_NET_F_RX_TSTAMP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
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
2.52.0

