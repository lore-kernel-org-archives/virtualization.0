Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737886;
	b=tZ34ByL0wLWl0yapF1wPIqSYFBona6dFa1lxkULsL91VqHw8vo+I6LkX7k0W8fYq+vCw
	 hHm3kfze8zhR8S1V46xqy697Glfk61U9GfZNXtxn+LR9dTq7AWGFn2MirUW60WrFRRf0o
	 994vsw/8qizTqqVLcbLUTCJRzeVYy7kqyEfGqhIYUkBcwrpfSX+frV1EStoeqbdt03Enw
	 4rmH6MjdaJiK/1mftZZYn173yIzCTMUiKdkev1tGo1rc1OcwiLr9JYBx8Y1Kuq2T35nar
	 jyfviLU7YIJvfV6zUuG2h9C1kaA41S25hWlAC7i7d7JL7dkIGE6Y2a2xFvqH+fpkXFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737886;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TR0ysl9M6FSnqXDUrFdyPeXKa9ib2fOynereZ60qZ+8=;
	b=iVH1+96aBsNvRZYeqGgGaIZd2CetLPcCXz6NED81AfihDU+lailc3cgYcduFJm+BcyL1
	 CNoJrU0Yk2zl7eytu3GLlRRPkdF+0kZR5Aouye3k8twY/cIhozoU2AgtCrZ+uix3ak0EK
	 4W6n/5aDSQNeSkh5yW/8mvFFRi32k6QK48/c8kTkuhA6qPGDTobyWefFq9P/VTfeezvck
	 t70dfnwhAKui9412j6or1aHyPpbehBY7XLZzI1seFQUiXmOjvWn4O6jhtkA3YGnXx9jnd
	 THDZQ4XOceLv6JTbBlO0O+4pPrrWvgTq3NU7PjtD66fkVuD+yVLmsaw48XmTpHEjaEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="colPCTN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F61606A328;
	Tue,  3 Nov 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=colPCTN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A2E1F000C1;
	Tue,  3 Nov 2026 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737885;
	bh=TR0ysl9M6FSnqXDUrFdyPeXKa9ib2fOynereZ60qZ+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=colPCTN/pemcJJGAx+wtGFz5rezwK1KOJZ8Mcg1xj1dIRumJuaaPdZstYGZ9iPFnC
	 5yCt5xoojC75yQio9S93kK4epxnVtl+/OslzLx7eDVIz0fh0zHmhP9XH0yVwowjIim
	 +GP1X4UbRhZZqdPpsceAbX5kqi2Mo5gUBjXS/apb6Dmn45mWDTmxos3xWp7JjZ6CZw
	 sZvbeZM79IrjYofGweUnBfSOOQUjw/Nf2VyDE6oAYY6o1iZzxjGSnm2DYAHJAjXUis
	 OMutte9H45jrOwLEVvLDvVRxIAaFyvhY8YF4K28v+UJisdQgMFNCW1AevvLeayxGzU
	 RDZSdI1Tpl5jA==
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
Subject: [PATCH net 1/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Tue,  3 Nov 2026 21:31:11 +0100
Message-ID: <20261103203113.550604-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103203113.550604-1-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
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
carries such an outer header. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
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

Require the outer L3 protocol to match the declared tunnel type:
for Ethernet frames, look at the ethertype after optional VLAN tags,
and check that the outer network header fits before outer_th_offset.
For IFF_TUN, skb->protocol is already set by the caller.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Reported-by: Hassan Sultan <hassansultan@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..d3f97d71d81c 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -282,6 +282,31 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
 	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
 }
 
+/* The outer network header of a UDP tunnel GSO packet must match the
+ * tunnel type declared in the virtio header, otherwise the GSO stack
+ * would parse the packet as something else (e.g. NSH).
+ */
+static inline bool virtio_net_tnl_outer_proto_ok(const struct sk_buff *skb,
+						 bool outer_isv6,
+						 unsigned int outer_th)
+{
+	__be16 expected = outer_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	__be16 proto = skb->protocol;
+	int nh_off = ETH_HLEN;
+
+	/* L3 device (IFF_TUN): the caller already set the protocol. */
+	if (proto)
+		return proto == expected;
+
+	/* Ethernet frame, possibly VLAN tagged. */
+	proto = eth_hdr(skb)->h_proto;
+	if (eth_type_vlan(proto))
+		proto = __vlan_get_protocol(skb, proto, &nh_off);
+
+	return proto == expected &&
+	       nh_off + virtio_l3min(outer_isv6) <= outer_th;
+}
+
 static inline int
 virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
@@ -338,6 +363,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	if (ret)
 		return ret;
 
+	if (!virtio_net_tnl_outer_proto_ok(skb, outer_isv6, outer_th))
+		return -EINVAL;
+
 	/* In case of USO, the inner protocol is still unknown and
 	 * `inner_isv6` is just a guess, additional parsing is needed.
 	 * The previous validation ensures that accessing an ipv4 inner
-- 
2.53.0

