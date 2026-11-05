Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879861;
	b=Q7YsxITyV0bL4CPYK3z9W9kq8xomiSSDGGJrgYlAeTyagJTfmx0nFcIDUvdW2FglRw+x
	 WLZTX0YtOjivjnwTWCkA4gkv9lbq/zb9qLy0J9jM8rtX4ghwczPwiX2/iUg5Hx42qr8/E
	 TpUVedX5hg1wUs6qJTJay11/7J5LIyyf3cYNU2chPW4jcif6EDrEDAY55UJrFwnh9zoh1
	 hiGbioczU0tNWX64p7ZG2e02+7naEbl9kCymKuD/4CMYe76M5zBDCZb+eM8VQtWpPtWJL
	 8aWhBkvNfjCA9t2HJag/7X675ze+S1DGEZgRCGgGNSi8nth0sBThto5gyLcMwdZxqlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879861;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FrlUYnFS1Z7L+1q5lQqx06nWzKsoICRsNl7leZSERDg=;
	b=3UFj3JzcyX5ozuyfQxbUoCWL/XTnslhlr83OQd6p+HlR+OR00HyhhY3Ur6agQu8LNBph
	 9iIk/fgUKWq8jz8/+Q/i13jJCTc+ZfPGDdXXasGaW1qgZPQBnV5uV4S/dHdfh7IWNi7Mn
	 RPQc46198dlaMPHcbpJvZ/Z3lDEU+cMfrd7L0qkR7/r2Ch1o7uu8OtDA/7LR3foDlnxqZ
	 dzuOPpHdlwDRhsO6qmz2jXVPlhv6XU1/iD/F9myJi/8tmbfOwXpEqBR/i0uz7B7XLGivI
	 UqqNhH6oc+VJOP6J/LaMeYxpeAlAvcredH4Tzgh0yJXqxcVJzAtkf5DDOzveJ/jsZhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dtdi/Sfw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF0606A32C;
	Thu,  5 Nov 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dtdi/Sfw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F9B1F0093A;
	Thu,  5 Nov 2026 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879860;
	bh=FrlUYnFS1Z7L+1q5lQqx06nWzKsoICRsNl7leZSERDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dtdi/SfwZJ0EDyJyO1YuXDHlHml+guaXmoSmve5AvgDVY2pHUToc4tCqn8kFCq9DJ
	 LTJ5ErM+Qkwn5+gWbUMtEOKYxvj1b9+1BecFvzlXI7FqLaNQsrbIYYy0Za+WdkX4Hj
	 8N01I/io265Vb/O8cJLFKqXHHxod2/gGMkJeWmIJV5VDsvP/eYaWClWOxC67oIi9Kb
	 PrzL7pZmJJp/N61aI3M7VigNJlI0aY3NHGIVFHjC4Zo/HkeSOxGtxJLGNoEJ/Kn8mK
	 ceJ2q+ba9AXhNjjJtALbg/hELdV8+g4e90XZ6Tvx6WUS09fxT2FcQ75PgKFMEtHtzt
	 iJLOrK+C0NTvw==
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
Subject: [PATCH net v3 7/8] selftests: net: tun: test more outer header mismatches of UDP tunnel GSO
Date: Thu,  5 Nov 2026 12:57:14 +0100
Message-ID: <20261105115715.1466924-8-edumazet@kernel.org>
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

Add tap tests for the outer header checks of UDP tunnel GSO packets
not covered yet:

- outer_proto_ok_ipv6: a 4in6 frame with an outer IPv6 header is
  accepted.
- outer_proto_bad_family: an IPv4 ethertype on a declared IPv6 tunnel
  is rejected.
- outer_proto_bad_vlan_ipv6: an IPv6 ethertype behind a VLAN tag on a
  declared IPv4 tunnel is rejected.
- outer_proto_bad_vlan_offset: a VLAN tagged frame whose
  outer_th_offset ignores the tag is rejected.
- outer_proto_bad_l4: an outer IPv4 header carrying GRE instead of UDP
  is rejected.

Without the first patch of this series, the four outer_proto_bad
tests fail because the kernel accepts the frames.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179386753718.488856.13433005125725728519@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tun.c | 97 +++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index cfeca53863ce..a135d3aa10d1 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -869,6 +869,103 @@ TEST_F(tun_vnet_udptnl_proto, outer_proto_link_type)
 	ASSERT_EQ(ret, len);
 }
 
+/* Build a 4in6 Geneve GSO frame whose outer ethertype is @l3proto. */
+static int build_udptnl6_frame(uint8_t *buf, uint16_t l3proto,
+			       int payload_len)
+{
+	int hlen = UDP_TUNNEL_GENEVE_4IN6_HDRLEN;
+	uint8_t *outer_udph, *cur = buf;
+	int pktlen;
+
+	memset(buf, 0, TUN_VNET_TNL_SIZE + hlen + payload_len);
+
+	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
+						   AF_INET6, AF_INET);
+	cur += build_eth(cur, l3proto, param_hwaddr_outer_dst,
+			 param_hwaddr_outer_src);
+
+	pktlen = UDP_TUNNEL_GENEVE_4IN6_HDRLEN - ETH_HLEN -
+		 sizeof(struct ipv6hdr) + payload_len;
+	cur += build_ipv6_header(cur, IPPROTO_UDP, 0, pktlen,
+				 &param_ipaddr6_outer_dst,
+				 &param_ipaddr6_outer_src);
+
+	outer_udph = cur;
+	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT,
+				pktlen - sizeof(struct udphdr));
+	cur += build_geneve_header(cur, VN_ID);
+	cur += build_eth(cur, ETH_P_IP, param_hwaddr_inner_dst,
+			 param_hwaddr_inner_src);
+	cur += build_ipv4_header(cur, IPPROTO_UDP,
+				 sizeof(struct udphdr) + payload_len,
+				 &param_ipaddr4_inner_dst,
+				 &param_ipaddr4_inner_src);
+	cur += build_udp_packet(cur, UDP_DST_PORT, UDP_SRC_PORT, payload_len,
+				AF_INET, false);
+	build_udp_packet_csum(outer_udph, AF_INET6, false);
+
+	return cur - buf;
+}
+
+TEST_F(tun_vnet_udptnl_proto, outer_proto_ok_ipv6)
+{
+	int len, ret;
+
+	len = build_udptnl6_frame(self->pkt, ETH_P_IPV6, 2800);
+	ret = write(self->fd, self->pkt, len);
+	ASSERT_EQ(ret, len);
+}
+
+/* An IPv4 ethertype on a declared IPv6 tunnel. */
+TEST_F(tun_vnet_udptnl_proto, outer_proto_bad_family)
+{
+	int len, ret;
+
+	len = build_udptnl6_frame(self->pkt, ETH_P_IP, 2800);
+	ret = write(self->fd, self->pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+TEST_F(tun_vnet_udptnl_proto, outer_proto_bad_vlan_ipv6)
+{
+	int len, ret;
+
+	len = build_udptnl_frame(self->pkt, true, ETH_P_IPV6, 2800);
+	ret = write(self->fd, self->pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/* outer_th_offset does not account for the VLAN tag. */
+TEST_F(tun_vnet_udptnl_proto, outer_proto_bad_vlan_offset)
+{
+	struct virtio_net_hdr_v1_hash_tunnel *vh = (void *)self->pkt;
+	int len, ret;
+
+	len = build_udptnl_frame(self->pkt, true, ETH_P_IP, 2800);
+	vh->outer_th_offset -= 4;
+	ret = write(self->fd, self->pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/* The outer IPv4 header does not carry UDP. */
+TEST_F(tun_vnet_udptnl_proto, outer_proto_bad_l4)
+{
+	struct iphdr *iph;
+	int len, ret;
+
+	len = build_udptnl_frame(self->pkt, false, ETH_P_IP, 2800);
+	iph = (struct iphdr *)(self->pkt + TUN_VNET_TNL_SIZE + ETH_HLEN);
+	iph->protocol = IPPROTO_GRE;
+	iph->check = 0;
+	iph->check = build_ip_csum((uint8_t *)iph, iph->ihl << 2, 0);
+	ret = write(self->fd, self->pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 /* IFF_TUN device with a tun_pi header: skb->protocol comes from
  * userspace, and there is no Ethernet header.
  */
-- 
2.53.0

