Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622830;
	b=5aoIpfFe/OpFOY3l96cAFq8AqIvitSRKhiAxjv2zMGCfsvSqKQ9ljUQhKj9+oiEVf/Tu
	 mHpLAA2zHQj4r3j/Ug7+qgCDH67mS527UAKziPGf/3o08EBJBfceCHYM5QrXn3P/QeyDV
	 sjbb757FRloZyRFsZZVxc95q/rdOaRDTINzv/7vdu34TnlW1uS6MSJGY4uMe6vhsBUuZH
	 AyLzvT6Gj1wEpc2Aajpjk81snLAtdxXKc2A2zVsp/flF8fRaocjP3Oz2M5AgfX7PSjnhx
	 PBXaUpOOljpqPVsd55l2JKcPaV4Ve+sQuDS4PqKvofd1p2grDwKb3vej/pUTStHabRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622830;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7YB7UL0sucy3/7oJUhtDU4Mp/84PzZO7y1sht4zAS4U=;
	b=BzynCLmIajTwirsX/FVnuR4jLD/bZw3k+73QlP7tAI8cnqc/puPkTh/9uxXQIwMP1ByS
	 gbX/iH4bzvCnScdr4Z5YxDBzs0LecZtq0eSOv4toPrxmjoSNyrIFdqmWh0yOGtfJOFkbO
	 Y061LDqKVgfK5OT/Hefk4k1gN5Dx/xubui8cUHzMfvhL5hhhzMs+As3+MygyuuQFYIh0T
	 ZJOmHB1DgLIdQX9I3leAnNtVobHWy4ptOKLmFV33w1O844iAE3K1vIKHAvhrEIDzuWtpL
	 aHxYL8tNziSpZjIMa2B96zLr2szF9tu0p4TnxXyI+VeEVvrJR2otXgEZQkE8f2StTzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FDD606A33E
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3FDD606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 86332C936A; Thu, 26 Nov 2026 01:07:03 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chris Arges <carges@cloudflare.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	=?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	virtualization@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH RFC net v8 4/6] net: resolve uncommon partial checksums at ingress
Date: Thu, 26 Nov 2026 01:06:45 +0900
Message-ID: <20261126.rfcv8.99797.4.zakinko@snowrabbit.org>
In-Reply-To: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
References: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: "Michael S. Tsirkin" <mst@redhat.com>

As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
others, credited below, found more ways the bug can affect users) a
virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
If that state is retained, later checksum completion can modify the
packet after protocol processing has made decisions from it.

Let's fix that: let's validate csum_start and csum_offset and only keep
CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
headers.  Complete other non-GSO checksums immediately, before any
protocol processing runs.

We can't easily "complete the checksum" for GSO we don't recognize - GSO
assumes knowledge of the protocol. We could segment ignoring the
checksum then do whatever csum_start and csum_offset say, but that
seems like an overkill for something that shouldn't happen.

There's some risk here:
- non-gso packets which can't be parsed get checksum calculated in
  software, adding performance overhead
- gso packets which can't be parsed get dropped

Note that for zero copy, userspace can change the data after the
checksum has been calculated.  This is fundamental to zero copy by
design, and the only outcome is a bad checksum and a packet drop.

To mitigate the risks, a later patch will add a sysctl knob to
bypass the resolution. This is reasonable if the setup is such that
there is no protocol processing at all.

UDP tunnel headers get the same handling on the inner header.

Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.

Note a fundamental limitation of this approach: an nf/BPF program
that tweaks the payload of a packet in flight may rely on the
checksum being fixed up later, assuming the packet carries
CHECKSUM_PARTIAL.

For metadata that fails validation the checksum
is now completed at input, so such edits leave a stale checksum
and the packet is dropped at the receiver.  Protocols whose
transport header we cannot parse (anything but TCP and UDP) are
affected even when the metadata is self-consistent.

The sysctl added later in the series is the escape hatch for these setups,
but it is a very blunt tool.

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[showta: rebased, the parsing helpers are in the tree already; has_eth
 passed to virtio_net_hdr_to_skb() instead of using the device type;
 the tnl_csum_negotiated check kept ahead of the validation; a tunnel
 packet with bad inner metadata is dropped here, the next patch handles
 the ones too small to segment]
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 arch/um/drivers/vector_transports.c |   2 +-
 drivers/net/tun_vnet.h              |   4 +-
 include/linux/virtio_net.h          | 132 ++++++++++++++++++++++++++--
 net/packet/af_packet.c              |  14 ++-
 4 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index 8b7548458..2dc4cf992 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -210,7 +210,7 @@ static int raw_verify_header(
 		return 1;
 
 	skb_set_network_header(skb, ETH_HLEN);
-	if (virtio_net_hdr_to_skb(skb, vheader,
+	if (virtio_net_hdr_to_skb(skb, vheader, true,
 			virtio_legacy_is_little_endian()) < 0)
 		return -1;
 	return 0;
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 3364e08dd..5411258ee 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -180,7 +180,9 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 				      const struct virtio_net_hdr *hdr)
 {
-	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
+	/* Only tap.c, where a frame always starts with an Ethernet header. */
+	return virtio_net_hdr_to_skb(skb, hdr, true,
+				     tun_vnet_is_little_endian(flags));
 }
 
 /*
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 3135dae03..e9057767b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -190,6 +190,77 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
 	return false;
 }
 
+/* Does checksum metadata match a known TCP or UDP header? */
+static inline bool
+virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
+				     unsigned int nhoff, __be16 proto)
+{
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return false;
+
+	if (skb_checksum_start_offset(skb) != thoff)
+		return false;
+
+	switch (ip_proto) {
+	case IPPROTO_TCP:
+		if (skb->csum_offset != offsetof(struct tcphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct tcphdr)))
+			return false;
+		break;
+	case IPPROTO_UDP:
+		if (skb->csum_offset != offsetof(struct udphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct udphdr)))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	case VIRTIO_NET_HDR_GSO_NONE:
+		return true;
+	case VIRTIO_NET_HDR_GSO_TCPV4:
+		return proto == htons(ETH_P_IP) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_TCPV6:
+		return proto == htons(ETH_P_IPV6) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_UDP:
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
+		return ip_proto == IPPROTO_UDP;
+	default:
+		return false;
+	}
+}
+
+static inline bool
+virtio_net_csum_partial_ok(struct sk_buff *skb, bool has_eth,
+			   u8 hdr_gso_type)
+{
+	int nhoff;
+	__be16 proto;
+
+	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
+		return false;
+
+	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
+						   proto);
+}
+
+/*
+ * Handle a packet whose checksum metadata does not match the packet:
+ * GSO packets are dropped, as segmentation needs one checksum per
+ * segment; others are completed in software.
+ */
+static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
+{
+	if (skb_is_gso(skb))
+		return -EINVAL;
+
+	return skb_checksum_help(skb) ?: 1;
+}
+
 static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
@@ -336,11 +407,38 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return 0;
 }
 
+/*
+ * @has_eth: the frame starts with an Ethernet header, see
+ * virtio_net_l3_start().
+ *
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
-					bool little_endian)
+					bool has_eth, bool little_endian)
 {
-	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
+	typeof(skb->transport_header) old_transport = skb->transport_header;
+	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
+					  hdr->gso_type);
+
+	if (ret < 0)
+		return ret;
+
+	if (likely(skb->ip_summed != CHECKSUM_PARTIAL ||
+		   virtio_net_csum_partial_ok(skb, has_eth, hdr->gso_type)))
+		return 0;
+
+	/*
+	 * Here we do not trust the checksum metadata.
+	 * __virtio_net_hdr_to_skb set the transport header to csum_start
+	 * from virtio hdr, restore it to a known good value.
+	 */
+	skb->transport_header = old_transport;
+
+	return __virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* This function must be called after virtio_net_hdr_from_skb(). */
@@ -447,6 +545,12 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
 	return ip_proto == IPPROTO_UDP && outer_th == thoff;
 }
 
+/*
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int
 virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
@@ -459,16 +563,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
 	gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
 	if (!gso_tunnel_type)
-		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
+		return virtio_net_hdr_to_skb(skb, hdr, has_eth, little_endian);
 
 	/* Tunnel not supported/negotiated, but the hdr asks for it. */
 	if (!tnl_hdr_negotiated)
 		return -EINVAL;
+	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM &&
+	    !tnl_csum_negotiated)
+		return -EINVAL;
 
 	/* Either ipv4 or ipv6. */
 	if (gso_tunnel_type == VIRTIO_NET_HDR_GSO_UDP_TUNNEL)
@@ -521,12 +629,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
-	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
-		if (!tnl_csum_negotiated)
-			return -EINVAL;
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 
+	/* NEEDS_CSUM is set, so this is CHECKSUM_PARTIAL.  A packet whose
+	 * inner metadata does not match cannot be segmented, and completing
+	 * the inner checksum alone would leave the outer one to the seed
+	 * the sender put there.
+	 */
+	if (unlikely(!virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type,
+							   inner_nh,
+							   inner_proto)))
+		return -EINVAL;
+
+	skb_set_inner_protocol(skb, inner_proto);
+	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
 	} else {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 930e85e4b..c07a01969 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2778,6 +2778,16 @@ static int tpacket_parse_header(struct packet_sock *po, void *frame,
 	return tp_len;
 }
 
+/* The device says how its frames start. */
+static int packet_vnet_hdr_to_skb(struct sk_buff *skb,
+				  const struct virtio_net_hdr *vnet_hdr)
+{
+	bool has_eth = skb->dev->type == ARPHRD_ETHER ||
+		       skb->dev->type == ARPHRD_LOOPBACK;
+
+	return virtio_net_hdr_to_skb(skb, vnet_hdr, has_eth, vio_le());
+}
+
 static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
@@ -2941,7 +2951,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 
 		if (has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
+			if (packet_vnet_hdr_to_skb(skb, &vnet_hdr) < 0) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
@@ -3163,7 +3173,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		skb->no_fcs = 1;
 
 	if (vnet_hdr_sz) {
-		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
+		err = packet_vnet_hdr_to_skb(skb, &vnet_hdr);
 		if (err < 0)
 			goto out_free;
 		len += vnet_hdr_sz;
-- 
2.54.0 (Apple Git-157)

