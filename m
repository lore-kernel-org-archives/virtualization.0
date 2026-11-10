Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346606;
	b=oukhh0rXGUlZ17OdTgswLVQ7btyN1rwyKUWBH25HyQ23s6iTuv+/jbmuwnno1JG2NuP+
	 hfs3CvtAkK4hmEtxle0fl022bpr3LhfjQ1VSPRy3AfgHErKv3CTbxlJ6tYkstAR4KGUY+
	 KhvyZy6dio6xIrEKqf2RoddcRX5V/+DDmQXlAHK3swxCm8WIk66stwsqzCfI2OijH67HT
	 9+LKr8pad8VNICXxaCFykFtNmRC6jpWNb153Oao1DPWMIwdg2JsCgLCvr23IeFTffVjb1
	 FayRFf0uYKjInrg6rInhcaM9qjU4/sHVH7XIlfnlDCeFgHNMm71i3OUTL8rCGUQj1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kPE7LaGpZmsacpF2cYEGbQ8N2UjKTVKEJe6MjNtB514=;
	b=PklQvWwrhdiSJBgJ8jy9gR49D0F9jk0toyC5Lhph6IAZYUShQiigt7zQfBR6oMANwJlQ
	 9slNmx2b3obDKAf2d3DYVt83AUmmJbBJayYR0oIPnz/JzzmONNQIgMBjNMgwpwCThmluP
	 ik6CHUNHkPYlHAhDVeocA9wzgULbKT8EHY0QFvDRwYS1h7Z629EnTB4lS5uGoCsASzy4D
	 aDY1D/hNhu4vZ/QtJjTxhYgMgRNQ6x7H7nNb4rD/BX0jzLQe+vvRJPLBpsgEflF4mgANV
	 8ny118598+8AKyYITmxptW8xiIe6jchoKjvshsigiXfMeT1liFLcZM4HBZ0HlIyecZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMubKNGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53616606A320;
	Tue, 10 Nov 2026 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMubKNGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FC71F0089F;
	Tue, 10 Nov 2026 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346605;
	bh=kPE7LaGpZmsacpF2cYEGbQ8N2UjKTVKEJe6MjNtB514=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMubKNGDdlM55vUK1QM/jkOFsn5ATcNEbvmxDD+o/9IJJe2W+zWmjBxU6JIvasQ5g
	 gkzNzOs1wPFsbx20BBzRi4+G4fZQfk/yfbD8/d4I7rxevesmgYf141SiFlGH0vAI8s
	 jg9nBZig/rxh9QoG4h7lFSDaUv2brAkH4ubvo+1/NX3CIxoOmp17n7JsnIazEUh40E
	 OhUJ3sePzc7Tvs9laPLZmWU9WaXTTcRFFWsSNn5Srwgwcov1MPLLwHd/RvYyjDtvvc
	 y2dCG0egvZkfZJR9YMYHg93Lht12Uq1WWNILB0qvZww9TDj6rsYsLi3T15m4aBkNN0
	 RzhGN+plT6Nvw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	edumazet@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v6 3/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Tue, 10 Nov 2026 22:36:28 +0100
Message-ID: <20261110213628.3476051-4-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110213628.3476051-1-edumazet@kernel.org>
References: <20261110213628.3476051-1-edumazet@kernel.org>
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

- locate the L3 header: Ethernet with optional VLAN tags, or the
  network header set by the caller. skb->protocol is not trusted when
  it disagrees with the frame.
- require the outer L3 protocol to match the declared tunnel type.
- require the outer UDP header exactly at outer_th_offset, after IPv4
  options or IPv6 extension headers, and reject fragments.

Unlike the original helpers:

- the callers tell whether the frame starts with an Ethernet header,
  with a new has_eth argument of virtio_net_hdr_tnl_to_skb(), instead
  of using the device type. tun frames packets from its IFF_TAP and
  IFF_TUN flags, and TUNSETLINK can set the device type to any value.
  virtio_net and tun_xdp_one() always pass true, tun_get_user() passes
  whether the device is IFF_TAP.
- ipv6_find_hdr() stops at an AH header, as Willem suggested in the
  review of that series.

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
 drivers/net/tun.c          |   9 +-
 drivers/net/tun_vnet.h     |   5 +-
 drivers/net/virtio_net.c   |   2 +-
 include/linux/virtio_net.h | 169 +++++++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d1fcb25ab026..ced5a1596e60 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1950,7 +1950,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
+				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2627,7 +2628,11 @@ static int tun_xdp_one(struct tun_struct *tun,
 	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
 	skb->dev = tun->dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
+	/* Frames always start with an Ethernet header here, as the
+	 * eth_type_trans() call below expects.
+	 */
+	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr,
+				    true)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index f4c652b1fa44..3364e08dd6e0 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -197,9 +197,10 @@ static inline netdev_features_t tun_vnet_hdr_guest_features(int vnet_hdr_sz)
 static inline int
 tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
 			struct sk_buff *skb,
-			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
+			const struct virtio_net_hdr_v1_hash_tunnel *hdr,
+			bool has_eth)
 {
-	return virtio_net_hdr_tnl_to_skb(skb, hdr,
+	return virtio_net_hdr_tnl_to_skb(skb, hdr, has_eth,
 				features & NETIF_F_GSO_UDP_TUNNEL,
 				features & NETIF_F_GSO_UDP_TUNNEL_CSUM,
 				tun_vnet_is_little_endian(flags));
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..ed20e76fbc4c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2533,7 +2533,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 
 	skb->dev = dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
+	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, true, vi->rx_tnl,
 				      vi->rx_tnl_csum,
 				      virtio_is_little_endian(vi->vdev))) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 83f801ff5700..fc9667176f23 100644
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
@@ -48,6 +51,145 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
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
+ * With @has_eth, the frame starts with an Ethernet header, possibly
+ * followed by VLAN tags. Otherwise the L3 header starts at the network
+ * header offset the caller set up.
+ *
+ * The caller knows how the frame will be parsed later: the device
+ * type does not tell, as tun can change it with TUNSETLINK.
+ */
+static inline bool
+virtio_net_l3_start(struct sk_buff *skb, bool has_eth, int *nhoff,
+		    __be16 *proto)
+{
+	if (has_eth) {
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
@@ -282,9 +424,33 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
 	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
 }
 
+/* Do the tunnel offsets match the outer headers in the frame?
+ * The L3 header the tunnel claims must be the one the frame
+ * carries, with UDP following it at @outer_th.
+ */
+static inline bool
+virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
+			  unsigned int outer_th)
+{
+	int nhoff;
+	__be16 proto;
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
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
+			  bool has_eth,
 			  bool tnl_hdr_negotiated,
 			  bool tnl_csum_negotiated,
 			  bool little_endian)
@@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	if (ret)
 		return ret;
 
+	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
+		return -EINVAL;
+
 	/* In case of USO, the inner protocol is still unknown and
 	 * `inner_isv6` is just a guess, additional parsing is needed.
 	 * The previous validation ensures that accessing an ipv4 inner
-- 
2.53.0

