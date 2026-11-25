Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622827;
	b=w3aNzf5aiM9rpsMpmWfiQcNyOndmQ3LEdwkLsXcTNNFchM5wA+MQgbEsCFvNru8WgrPc
	 ivA/8PoRuaBjQFGHKBXqy656e+61d2XFleTpS0QrTXLX1AdT0HTKWXLjYSlh4pbHTQslT
	 5rPqVJUI+ecdsIIgKQ01oVOqOwh5xT+1+bjEL84IunVGzTa3BSMf3+HCcOfgKwZQEd+Oj
	 Y7YbqUuxhlABujGYyt0toT0HOelsUW/PxKARM1qRo6WV7EcZsfw7X7N+xytvGej6FyZBN
	 Wy3IDDcdJO6ZST3SB7T5rbwcN1oRtznjwaftVgwN9g9T+KIfWFiRSg4iW/OiRjs/suw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622827;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PvKsNKTH+N/wo+qc+k6pH61Gkxzo7WgdYLcaOadWIBU=;
	b=VKPa2t9gnH8qDd1zq4lBYnUjHI8OXHdymBffJWTI7kElHQ7vXFoN2M7We4g3HaLWKxZt
	 B9SFRJZmPSwyVqoqf2i0VxkUSlajiIl9tHzOnyWVY6BCuNhh9PfxzO3U29LwYdtZ9NW+T
	 a5NqRLzcftoudBQPuVeKMV3kq7vFQUCb2TZBhsVUg9s0Lt2/BTCwRIJdD7Fp7/1E7aytp
	 RZOfUN6DI6WuI7BMtgSfFfndWPds1z2Szv0FiVsqwby+JJXz+e9k7zz20XWMs367XUg6X
	 gG7vBsr86X3GKWTZILH+WA7IavzHhhB6d6sT7ZhnaE5EitxNVJcaMAxPcj8fCaee6ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6300B606A685
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6300B606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id A394BC936F; Thu, 26 Nov 2026 01:07:05 +0900 (JST)
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
Subject: [PATCH RFC net v8 5/6] net: virtio: compute the outer checksum of non-GSO tunnel packets
Date: Thu, 26 Nov 2026 01:06:46 +0900
Message-ID: <20261126.rfcv8.99797.5.zakinko@snowrabbit.org>
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

A packet may be tagged as UDP tunnel GSO and still be too small to
segment. Then nothing consumes the pseudo-header seed the sender left in
the outer UDP checksum. The GSO layer is not run, and transmit checksum
offload completes only the inner checksum, so the seed goes out as the
outer checksum.

Zeroing it is not an option either: IPv6 receivers drop a zero UDP
checksum unless the tunnel opted in (RFC 6935, RFC 6936).

Compute the outer checksum when VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM asks
for one: with local checksum offload while the inner checksum is still
partial, or by a full sum once the inner one was completed in software
because its metadata did not match the packet. Such packets no longer
need to be dropped.

The addresses come from the outer header in the frame and the length
from the UDP header. udp_set_csum() is not used: it is built with
CONFIG_INET, which virtio_net does not depend on.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 include/linux/virtio_net.h | 105 ++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index e9057767b..5d5049418 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -8,8 +8,10 @@
 #include <linux/netdevice.h>
 #include <linux/udp.h>
 #include <net/ip.h>
+#include <net/ip6_checksum.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <net/udp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
@@ -545,6 +547,64 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
 	return ip_proto == IPPROTO_UDP && outer_th == thoff;
 }
 
+/* Fill in the outer UDP checksum of a tunnel packet that is not GSO.
+ * While the inner checksum is still CHECKSUM_PARTIAL this is local
+ * checksum offload, as udp_set_csum() does for udp_tunnel_xmit_skb(),
+ * and needs the transport header at @outer_th.  Once the inner
+ * checksum has been completed the datagram is summed in full.
+ *
+ * The pseudo-header comes from the frame, not from the seed the sender
+ * put in uh->check: the addresses of the outer IP header and the
+ * length of the UDP header, which skb->len exceeds when the frame is
+ * padded.
+ *
+ * udp_set_csum() itself is not used: it is built with CONFIG_INET,
+ * which virtio_net does not depend on.
+ */
+static inline int
+virtio_net_tnl_set_outer_csum(struct sk_buff *skb, bool has_eth,
+			      bool outer_isv6, unsigned int outer_th)
+{
+	unsigned int thoff;
+	struct udphdr *uh;
+	int ip_proto, nhoff;
+	__be16 proto;
+	__wsum csum;
+	int len, err;
+
+	/* virtio_net_tnl_offsets_ok() has passed; this finds nhoff. */
+	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto) ||
+	    !virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return -EINVAL;
+
+	err = skb_ensure_writable(skb, outer_th + sizeof(*uh));
+	if (err)
+		return err;
+
+	uh = (struct udphdr *)(skb->data + outer_th);
+	len = ntohs(uh->len);
+	uh->check = 0;
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		csum = lco_csum(skb);
+	else
+		csum = skb_checksum(skb, outer_th, skb->len - outer_th, 0);
+
+	if (outer_isv6) {
+		const struct ipv6hdr *ip6h = (void *)(skb->data + nhoff);
+
+		uh->check = udp_v6_check(len, &ip6h->saddr, &ip6h->daddr,
+					 csum);
+	} else {
+		const struct iphdr *iph = (void *)(skb->data + nhoff);
+
+		uh->check = udp_v4_check(len, iph->saddr, iph->daddr, csum);
+	}
+	if (uh->check == 0)
+		uh->check = CSUM_MANGLED_0;
+
+	return 0;
+}
+
 /*
  * Return value:
  * 0 - success
@@ -560,6 +620,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  bool little_endian)
 {
 	const struct virtio_net_hdr *hdr = (const struct virtio_net_hdr *)vhdr;
+	typeof(skb->transport_header) old_transport = skb->transport_header;
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
@@ -631,15 +692,26 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 
 	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 
-	/* NEEDS_CSUM is set, so this is CHECKSUM_PARTIAL.  A packet whose
-	 * inner metadata does not match cannot be segmented, and completing
-	 * the inner checksum alone would leave the outer one to the seed
-	 * the sender put there.
-	 */
+	/* NEEDS_CSUM is set, so this is CHECKSUM_PARTIAL. */
 	if (unlikely(!virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type,
 							   inner_nh,
-							   inner_proto)))
-		return -EINVAL;
+							   inner_proto))) {
+		/* __virtio_net_hdr_to_skb set the transport header to
+		 * csum_start, restore it to a known good value.
+		 */
+		skb->transport_header = old_transport;
+
+		ret = __virtio_net_resolve_csum_partial_mismatch(skb);
+		if (ret > 0 && hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
+			int err = virtio_net_tnl_set_outer_csum(skb, has_eth,
+								outer_isv6,
+								outer_th);
+
+			if (err)
+				return err;
+		}
+		return ret;
+	}
 
 	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
@@ -653,6 +725,25 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	skb->inner_mac_header = inner_nh + skb_headroom(skb);
 	skb->transport_header = outer_th + skb_headroom(skb);
 	skb->encapsulation = 1;
+
+	if (!skb_is_gso(skb)) {
+		/* Too small to segment.  Senders do tag small packets with
+		 * GSO headers, e.g. packetdrill sets gso_type and gso_size
+		 * with --mss, whatever the packet size.  Nothing consumes
+		 * the seed the sender left in the outer uh->check without
+		 * GSO, so compute the outer checksum if one was asked for.
+		 */
+		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
+					       SKB_GSO_UDP_TUNNEL);
+		if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
+			ret = virtio_net_tnl_set_outer_csum(skb, has_eth,
+							    outer_isv6,
+							    outer_th);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.54.0 (Apple Git-157)

