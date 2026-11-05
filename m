Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879843;
	b=u4BE60e+zloQbsXAxrY4oue5Tfcf5JqPp6nXWuerqIMnUF4u9JlYzCDzLh1bnz5yXkEc
	 vaj9YmLn6YVxwvJooyIHhgQHOntM8ydgbMQG++/fZxgl3m6RJj1w1X4cnIFC5bdacns+i
	 P+xvsyXPDbl7WKepcC8qK/bGVBhegju0F+KccCU2VF7dBG20S1B0xqL4oEky6qnvwCY5F
	 Gu+mgwLiraCwoS6OnK/0K5NNLb+AB83exc1SDdB7JiMwd5PmWIEggbRWz2LYbCEGr0jTJ
	 BjONAh7r5Vvh4H87UkRHCnXrHd7lhHKxhrW9syJn4tmySNy9hWpJ52YRgFJow+lrfhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879843;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n/xz445fsebiiBZl77V421OT19aO3stvkZwOlA0939I=;
	b=N8EP2LO6sH9fNWn7Pg+9BN6rVU0IVhZieoV1TNJYML1FIWYxbAigVRkBQdT+lnbZN8vS
	 SFiC5UFg9qNfNRCefeJbUGBs5QITA7N8BA7EVDyL8F4RryxOggL1rS2lxgLrQyGOIu/+9
	 awzLvSGid/bD8PZ1wFifNUCUtRVvC8x4o/AqF4LFddCzyUkfdkiM5XkBNx8KTnCo8jwEj
	 /u+jbDGNb5HgsrtTGP8DQJ9Ro4KkJaETGDgVVpX5mFYmgFAvYnLXRGnCBnUGY3O1jkSJH
	 xhMwNslBFQAmFu2Om2ra1mNh/aq0XosbR0kID1N7Gn4liHDPd4JC9PJmyYjBkGVYsJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dujUgqvs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDF606D807;
	Thu,  5 Nov 2026 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dujUgqvs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EDB1F00A15;
	Thu,  5 Nov 2026 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879843;
	bh=n/xz445fsebiiBZl77V421OT19aO3stvkZwOlA0939I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dujUgqvsJoBLcc+o8z31QIMapGGU+Ft+rRtUsi5Vp/7YFjs3kiB4iAGchnUuwjx68
	 l7/GFAO7lBu9zuipO9z6qCrAOBYcLlP/rgMI0uMCHfeK+CeFIjq7CA9dS/l+eigApw
	 i7oYWx6/nDI7hv5cqu0mK04RSw1cR8ZoMBFCpgV8O7cBspUUSquR9MY58nPFY6J+7n
	 ZPxMaKVgH6w8Yvb3mXcLKNCga/zNXUWH/qAWd3nup9IPzQ4+BA1rtO9Xv/6r0pNUJc
	 19SZrd1nGUgrm+fBmzXGk/dBGGBE4j+mAb6W92EuKx9/D78fh0Vtv65YZGBObEyx4M
	 BgAOy4x4Zt/jA==
From: Eric Dumazet <edumazet@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v3 1/8] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Thu,  5 Nov 2026 12:57:08 +0100
Message-ID: <20261105115715.1466924-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105115715.1466924-1-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/virtio_net.h | 170 +++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..357116c2a148 100644
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
@@ -48,6 +51,147 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
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
+			 * extension headers. IP6_FH_F_AUTH stops
+			 * the walk at AH, so frames with AH are rejected.
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
@@ -282,6 +426,29 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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
@@ -338,6 +505,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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

