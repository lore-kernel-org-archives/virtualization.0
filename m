Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768501;
	b=HD3JBzMGZXHN28XOK53U8mZH8hVH3xU5uAt2TACtK0mKcmY2Aug4eUyB9TGZESJ4qORZ
	 G738pF4/6I1+6G9AjzKBkLZCNLHPFY/CXPVTHv1elXfTrjItP5ejU1mcNQRsWBCwuFFw1
	 njKDigJcz+qpyMaSruA9pgf/tF2rwNvkKYFovrZhj0n8RRzZaZJrQodvbb1p86nbaqs/J
	 iLGbDJoKc1+NC8M9PO6RuTfQfNzqd5toj2ZxzVTkliqTOKjTQZ2Y9j6ikdaXT5z2Yvf4P
	 Hfpw0u8TXKXiCcCdciOUrfTnfMgiW3ZtCrsMucspfM0wTbVTvESM8sDS08k2F0vpYGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CXckMZSVsSQihDDHrJ526g9yrVCGlB0MSwXSr5zZQg8=;
	b=tTuHwhZO26KszZmT2gqEAGmDy/MB82Gj0mRK73XPRXaGio2g1GMDjSlC9l700Bxhbo7c
	 OU3l0pmqjPxZqwFU34aKiPrEmR3QbNdzI9Nz37YiPkH9ZSF38zst4LXFir0DmXl3EkTDd
	 S9Z5cvxpUmCCDJQEx44ysiKOoWp1ur1gGJRu38u2JvrjZdeAzV97aAgl2uTT7JgXGNNIN
	 NG+RsPZ+axJd9KpfyxnIOeTTwZpvj9LlF1Iaz1iwTAve6+maCYH6UeBOG5aXGFDfm9xfT
	 phlkyoc7h4AtUCm3cNjV0Vw1VlpFkw533PDASxIGu4lookxdJcJonBOGBdNHJQudPvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GT1xjbUx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF31606A328;
	Wed,  4 Nov 2026 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GT1xjbUx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582921F000C1;
	Wed,  4 Nov 2026 05:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793768500;
	bh=CXckMZSVsSQihDDHrJ526g9yrVCGlB0MSwXSr5zZQg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GT1xjbUx2VMWAwj7Ngrfz/NH4oWopvDQWcIHFCe69GaUsJEeY85fJrXXjYUVVlIHi
	 vzg/iPUMlr53AIuI5ZuxpNGqpYI6hH6owXR58vPwQNPczQPJHutVBDLLaMAEp4RnqO
	 U1RHxL9Yl4udcmlfWAuSI4JC5sVaoA733V32XwAamoaT2Wu7aYxzB24MTC4Eb0bQuS
	 zT2cezejmDA0106hB8enrPjTmo4a0FD7qxwX9afMY4J7q43juK7APy0qKuV/HD0dHB
	 sI2fDr4QnKRGlEuW0+vfMPAvb/8DtVQ/sor0kIWL8rxXCM248NWjB7IcqHL8XkizOD
	 yoRpVJcV7+sWg==
From: Eric Dumazet <edumazet@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Wed,  4 Nov 2026 06:01:29 +0100
Message-ID: <20261104050131.629967-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104050131.629967-1-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
carries such outer headers. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
dissector, so virtio_net_hdr_match_proto() is never applied either.

A guest (or a tap writer) can then inject a frame with an arbitrary
outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
segmentation, which assumes a different header layout. The result is
segments with skb->data before skb->head, and a host crash in
skb_under_panic() as soon as a later layer pushes a header:

  skbuff: skb_under_panic: ... put:4 ... dev:gretap1
  kernel BUG at net/core/skbuff.c:215!
   skb_push
   __gre_xmit
   gre_tap_xmit
   ...
   tun_get_user

Validate the outer headers with the parsing helpers from Michael's
series "net: resolve uncommon partial checksums at ingress":

- locate the L3 header from the device type: Ethernet with optional
  VLAN tags, or the network header set by the caller. skb->protocol is
  not trusted when it disagrees with the frame.
- require the outer L3 protocol to match the declared tunnel type.
- require the outer UDP header exactly at outer_th_offset, after IPv4
  options or IPv6 extension headers, and reject fragments.

Unlike the original helpers, ipv6_find_hdr() stops at an AH header,
as Willem suggested in the review of that series.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Reported-by: Hassan Sultan <hassansultan@google.com>
Suggested-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/
Cc: Willem de Bruijn <willemb@google.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Co-developed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/virtio_net.h | 169 +++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..b9c8babb1fd7 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -5,7 +5,10 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/netdevice.h>
 #include <linux/udp.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/tcp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
@@ -48,6 +51,146 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
+/* TODO: nothing virtio specific here, move to ip.h */
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  The whole header,
+ * options included, is guaranteed linear on return.
+ */
+static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
+						  unsigned int nhoff,
+						  unsigned int *thoff)
+{
+	unsigned int ihl;
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 ||
+	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	ihl = iph->ihl * sizeof(u32);
+	*thoff = nhoff + ihl;
+	/* Pull the options as well: the transport header offset
+	 * returned above must be within the linear data.  iph goes
+	 * stale across the pull.
+	 */
+	if (!pskb_may_pull(skb, nhoff + ihl))
+		return NULL;
+
+	return (struct iphdr *)(skb->data + nhoff);
+}
+
+/* Where does the L3 header start, and what protocol is it?
+ * Handles Ethernet and VLAN headers; other devices use the
+ * network header offset the caller set up.
+ */
+static inline bool
+virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
+{
+	/* skb->dev should always be set here already,
+	 * but let's not crash when it is not.
+	 */
+	if (WARN_ON_ONCE(!skb->dev))
+		return false;
+
+	if (skb->dev->type == ARPHRD_ETHER ||
+	    skb->dev->type == ARPHRD_LOOPBACK) {
+		__be16 h_proto;
+
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return false;
+		h_proto = eth_hdr(skb)->h_proto;
+		/* skb->protocol is a sender claim, and parts of the
+		 * stack parse the packet per it: when it disagrees with
+		 * the frame we do not know which view the packet will
+		 * be parsed as, so do not validate.
+		 */
+		if (skb->protocol && skb->protocol != h_proto)
+			return false;
+		*nhoff = ETH_HLEN;
+		*proto = h_proto;
+		if (eth_type_vlan(*proto)) {
+			*proto = __vlan_get_protocol(skb, *proto, nhoff);
+			if (!*proto)
+				return false;
+		}
+	} else {
+		const struct iphdr *iph;
+
+		*nhoff = skb_network_offset(skb);
+		/* An unset network header shows up as an offset
+		 * outside of the packet.
+		 */
+		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
+			return false;
+		/* No L2 header to cross-check with: take the protocol
+		 * from the IP version at the network header.
+		 */
+		if (!pskb_may_pull(skb, *nhoff + 1))
+			return false;
+		iph = (const struct iphdr *)(skb->data + *nhoff);
+		if (iph->version == 4)
+			*proto = htons(ETH_P_IP);
+		else if (iph->version == 6)
+			*proto = htons(ETH_P_IPV6);
+		else
+			return false;
+		if (skb->protocol && skb->protocol != *proto)
+			return false;
+	}
+	return true;
+}
+
+/* Walk the L3 header at @nhoff: where does its transport header
+ * start, and which protocol is it?  Returns false if the header
+ * is truncated, malformed or fragmented.
+ */
+static inline bool
+virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
+		    unsigned int *thoff, int *ip_proto)
+{
+	if (proto == htons(ETH_P_IP)) {
+		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
+
+		if (!iph || ip_is_fragment(iph))
+			return false;
+		*ip_proto = iph->protocol;
+		return true;
+	}
+
+	if (proto == htons(ETH_P_IPV6)) {
+		const struct ipv6hdr *iph;
+		int flags = IP6_FH_F_AUTH;
+
+		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
+			return false;
+		iph = (const void *)(skb->data + nhoff);
+		if (iph->version != 6)
+			return false;
+		*thoff = nhoff + sizeof(*iph);
+		*ip_proto = iph->nexthdr;
+		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
+			*thoff = nhoff;
+			/* Find the transport header behind any
+			 * extension headers, AH included.
+			 */
+			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
+						  &flags);
+			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
+				return false;
+		}
+		return true;
+	}
+
+	return false;
+}
+
 static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
@@ -282,6 +425,29 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
 	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
 }
 
+/* Do the tunnel offsets match the outer headers in the frame?
+ * The L3 header the tunnel claims must be the one the frame
+ * carries, with UDP following it at @outer_th.
+ */
+static inline bool
+virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
+			  unsigned int outer_th)
+{
+	int nhoff;
+	__be16 proto;
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l3_start(skb, &nhoff, &proto))
+		return false;
+	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
+		return false;
+	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return false;
+
+	return ip_proto == IPPROTO_UDP && outer_th == thoff;
+}
+
 static inline int
 virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
@@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	if (ret)
 		return ret;
 
+	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
+		return -EINVAL;
+
 	/* In case of USO, the inner protocol is still unknown and
 	 * `inner_isv6` is just a guess, additional parsing is needed.
 	 * The previous validation ensures that accessing an ipv4 inner
-- 
2.53.0

