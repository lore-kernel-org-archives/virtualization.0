Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879855;
	b=ZeK1IW0MAQGwdB5GTcbA0NcbYyvfn4BRBIWVX5wq3fXOJ8PZFO3LRG+yZ4H2q2zv6oB5
	 NGpt5HSqh8YedQNAGMKPObqHuQWQvrJXwOmI4AA2BPA6giPvrh+WfvaJq5+u+H+5y6x9r
	 5eukiDQXZT6LIY3tAKs/2UJcfHEaDoywTvDYN+L9WyZgt9SjxU+slMnaHWLWM9uqXO/T9
	 WEwCN6k7PQxjXDIOF/OijIEC5khQUHgbPwQb+2eTZQr5jnfgwy+a72H0+uVchU3HPllA9
	 jbXqa0hQ2r7xePf2W5MJz04ShSgKZ3JDL4c2AEGYCiikb4FaqxSkJVPyVgZjBA3Bp2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hjw8DiUQNkrtiCrrm5P0NEnsgV+5sYoiiW+A0BLmhA8=;
	b=1+yL8GSlL/o7qqtihkU3PAT4sx+/BD5TBkEFQrIAe5NXcTr2UscHFrA5kel7e4MoZpP7
	 fKHsspOTmkE50bjL2o99HfBwJH9gTchrV09Us9huvpCN+1liNVOe/6qjtrGpinBUe7M2v
	 4knI23OY8kkcCXzhEeQROCbpyqRiXR2n8pYCfMjSLs1oaqKX9pC5sEVaIDd4YC/LCRMcg
	 qGFuoMux0IQophL9Fl48lNSBnKu06e6fOuZOBunQtGenXS+jYQtSWQITfOGC0ce7AJTi/
	 WykzmY7yBAcy+l4h8Bn+X0LNOpA9GOIQMuJ93IWMH/MxnZcpOfG4c+FBtohokIqG9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCRmAlr5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2F606D803;
	Thu,  5 Nov 2026 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCRmAlr5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869D51F000C1;
	Thu,  5 Nov 2026 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879855;
	bh=Hjw8DiUQNkrtiCrrm5P0NEnsgV+5sYoiiW+A0BLmhA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCRmAlr5SU9Hv3wqG8aOdnyoGIwuVMaEimCnqg7m/0rRic1uTrKcq6abQ3LVCpBiV
	 C1PVY08ZkgvQEaSZd8tk88M8TqMeCyLLBRRtpe9fxih+cfpqFhGA6tCYiM48ANXAag
	 g+AXC/e32qtDrR4lwHgP8MhKGMr/HIsbuhbjwQ+R9F9kA3qX8hk413+F+YgISmOdpL
	 AMzYoVCC3MeX9Rw4moUVBTaN7lh/Pu+VdGSVFWsnaYN5G0WogjmqJW5lxivZONbBeW
	 E1J31Q6YCjdSU7cXv46lp9z95g8ROkHAbDuxyCCAwcJOfF5kna/lD1vnNcfXqn0rBL
	 E3o4raD6jGsYg==
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
Subject: [PATCH net v3 5/8] selftests: net: tun: test outer protocol of UDP tunnel GSO packets
Date: Thu,  5 Nov 2026 12:57:12 +0100
Message-ID: <20261105115715.1466924-6-edumazet@kernel.org>
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

Add tests writing single 4in4 Geneve GSO frames to tun devices with
UDP tunnel offloads enabled.

tun_vnet_udptnl_proto uses a tap device:

- outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
  is accepted.
- outer_proto_bad: an outer ethertype that does not match the declared
  tunnel type (IPv6 on an IPv4 tunnel, or NSH with or without a VLAN
  tag) is rejected with EINVAL.

tun_vnet_udptnl_proto_l3 uses an IFF_TUN device with a tun_pi header,
so skb->protocol comes from userspace and there is no Ethernet header.
The outer IPv4 header carries options, as virtio_net_hdr_tnl_to_skb()
expects room for an Ethernet header before the outer transport header.

- outer_proto_ok: tun_pi and the frame agree on IPv4, accepted.
- outer_proto_bad: tun_pi claims IPv6, or the IP version of the frame
  is not 4 while tun_pi claims IPv4: rejected with EINVAL.

Without the first patch of this series, both outer_proto_bad tests fail
because the kernel accepts the frames.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tun.c | 269 ++++++++++++++++++++++++++++++
 1 file changed, 269 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 34de2580e32e..81410afbbcc8 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -683,6 +683,275 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
 	ASSERT_EQ(ret, len);
 }
 
+#ifndef ETH_P_NSH
+#define ETH_P_NSH 0x894F
+#endif
+
+FIXTURE(tun_vnet_udptnl_proto)
+{
+	char ifname[IFNAMSIZ];
+	uint8_t *pkt;
+	int fd;
+};
+
+FIXTURE_SETUP(tun_vnet_udptnl_proto)
+{
+	int flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+	int features = TUN_F_CSUM | TUN_F_UDP_TUNNEL_GSO |
+		       TUN_F_UDP_TUNNEL_GSO_CSUM | TUN_F_USO4 | TUN_F_USO6;
+
+	self->fd = -1;
+	if (unshare(CLONE_NEWNET))
+		SKIP(return, "Cannot create network namespace: %s",
+		     strerror(errno));
+
+	self->pkt = calloc(1, MAX_VNET_TUNNEL_PACKET_SZ);
+	ASSERT_NE(self->pkt, NULL);
+
+	memset(self->ifname, 0, sizeof(self->ifname));
+	self->fd = tun_open(self->ifname, flags, TUN_VNET_TNL_SIZE, features,
+			    param_hwaddr_outer_src);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_udptnl_proto)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+	free(self->pkt);
+}
+
+/* Build a 4in4 Geneve GSO frame whose outer ethertype is @l3proto,
+ * optionally behind an 802.1Q tag.
+ */
+static int build_udptnl_frame(uint8_t *buf, bool vlan, uint16_t l3proto,
+			      int payload_len)
+{
+	struct virtio_net_hdr_v1_hash_tunnel *vh = (void *)buf;
+	int vlan_len = vlan ? 4 : 0;
+	int hlen = ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
+	uint8_t *outer_udph, *cur = buf;
+	int pktlen;
+
+	/* The buffer is reused: do not leave bytes from a previous frame. */
+	memset(buf, 0, TUN_VNET_TNL_SIZE + hlen + payload_len);
+
+	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
+						   AF_INET, AF_INET);
+	vh->outer_th_offset += vlan_len;
+	vh->inner_nh_offset += vlan_len;
+	vh->hash_hdr.hdr.csum_start += vlan_len;
+
+	if (vlan) {
+		uint16_t vlan_tag[2] = { htons(100), htons(l3proto) };
+
+		cur += build_eth(cur, ETH_P_8021Q, param_hwaddr_outer_dst,
+				 param_hwaddr_outer_src);
+		memcpy(cur, vlan_tag, sizeof(vlan_tag));
+		cur += sizeof(vlan_tag);
+	} else {
+		cur += build_eth(cur, l3proto, param_hwaddr_outer_dst,
+				 param_hwaddr_outer_src);
+	}
+
+	pktlen = UDP_TUNNEL_GENEVE_4IN4_HDRLEN - sizeof(struct iphdr) +
+		 payload_len;
+	cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen,
+				 &param_ipaddr4_outer_dst,
+				 &param_ipaddr4_outer_src);
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
+	build_udp_packet_csum(outer_udph, AF_INET, false);
+
+	return cur - buf;
+}
+
+TEST_F(tun_vnet_udptnl_proto, outer_proto_ok)
+{
+	uint8_t *pkt = self->pkt;
+	int len, ret;
+
+	len = build_udptnl_frame(pkt, false, ETH_P_IP, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, len);
+
+	/* The outer IPv4 header can follow a VLAN tag. */
+	len = build_udptnl_frame(pkt, true, ETH_P_IP, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, len);
+}
+
+TEST_F(tun_vnet_udptnl_proto, outer_proto_bad)
+{
+	uint8_t *pkt = self->pkt;
+	int len, ret;
+
+	/* Outer ethertype does not match the declared IPv4 tunnel. */
+	len = build_udptnl_frame(pkt, false, ETH_P_IPV6, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Outer header is not IP at all. */
+	len = build_udptnl_frame(pkt, false, ETH_P_NSH, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Same, behind a VLAN tag. */
+	len = build_udptnl_frame(pkt, true, ETH_P_NSH, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/* IFF_TUN device with a tun_pi header: skb->protocol comes from
+ * userspace, and there is no Ethernet header.
+ */
+FIXTURE(tun_vnet_udptnl_proto_l3)
+{
+	char ifname[IFNAMSIZ];
+	uint8_t *pkt;
+	int fd;
+};
+
+FIXTURE_SETUP(tun_vnet_udptnl_proto_l3)
+{
+	int flags = IFF_TUN | IFF_VNET_HDR;
+	int features = TUN_F_CSUM | TUN_F_UDP_TUNNEL_GSO |
+		       TUN_F_UDP_TUNNEL_GSO_CSUM | TUN_F_USO4 | TUN_F_USO6;
+
+	self->fd = -1;
+	if (unshare(CLONE_NEWNET))
+		SKIP(return, "Cannot create network namespace: %s",
+		     strerror(errno));
+
+	self->pkt = calloc(1, MAX_VNET_TUNNEL_PACKET_SZ);
+	ASSERT_NE(self->pkt, NULL);
+
+	memset(self->ifname, 0, sizeof(self->ifname));
+	self->fd = tun_open(self->ifname, flags, TUN_VNET_TNL_SIZE, features,
+			    NULL);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_udptnl_proto_l3)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+	free(self->pkt);
+}
+
+#define IPV4_OPT_NOP 1
+#define IPV4_OPT_LEN 16
+
+/* Build a tun_pi header carrying @pi_proto, followed by a 4in4 Geneve
+ * GSO frame whose outer IP header claims version @ip_version.
+ *
+ * virtio_net_hdr_tnl_to_skb() wants room for an Ethernet header before
+ * the outer transport header, even without one: pad the outer IPv4
+ * header with NOP options.
+ */
+static int build_udptnl_l3_frame(uint8_t *buf, uint16_t pi_proto,
+				 int ip_version, int payload_len)
+{
+	struct tun_pi *pi = (struct tun_pi *)buf;
+	uint8_t *vnet = buf + sizeof(*pi);
+	struct virtio_net_hdr_v1_hash_tunnel *vh = (void *)vnet;
+	int hlen = UDP_TUNNEL_GENEVE_4IN4_HDRLEN + IPV4_OPT_LEN;
+	uint8_t *cur, *outer_iph, *outer_udph;
+	struct iphdr *iph;
+	int pktlen;
+
+	/* The buffer is reused: do not leave bytes from a previous frame. */
+	memset(buf, 0, sizeof(*pi) + TUN_VNET_TNL_SIZE + hlen + payload_len);
+	pi->proto = htons(pi_proto);
+
+	cur = vnet + build_virtio_net_hdr_v1_hash_tunnel(vnet, false, hlen,
+							 1400, AF_INET,
+							 AF_INET);
+	vh->outer_th_offset += IPV4_OPT_LEN;
+	vh->inner_nh_offset += IPV4_OPT_LEN;
+	vh->hash_hdr.hdr.csum_start += IPV4_OPT_LEN;
+
+	/* Build the frame without options first: build_udp_packet_csum()
+	 * expects the IP addresses right before the UDP header.
+	 */
+	outer_iph = cur;
+	pktlen = UDP_TUNNEL_GENEVE_4IN4_HDRLEN - sizeof(struct iphdr) +
+		 payload_len;
+	cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen,
+				 &param_ipaddr4_outer_dst,
+				 &param_ipaddr4_outer_src);
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
+	build_udp_packet_csum(outer_udph, AF_INET, false);
+
+	/* Then insert the options after the fixed outer IPv4 header. */
+	memmove(outer_udph + IPV4_OPT_LEN, outer_udph, cur - outer_udph);
+	memset(outer_udph, IPV4_OPT_NOP, IPV4_OPT_LEN);
+	cur += IPV4_OPT_LEN;
+
+	iph = (struct iphdr *)outer_iph;
+	iph->version = ip_version;
+	iph->ihl += IPV4_OPT_LEN / 4;
+	iph->tot_len = htons(ntohs(iph->tot_len) + IPV4_OPT_LEN);
+	iph->check = 0;
+	iph->check = build_ip_csum(outer_iph, iph->ihl << 2, 0);
+
+	return cur - buf;
+}
+
+TEST_F(tun_vnet_udptnl_proto_l3, outer_proto_ok)
+{
+	uint8_t *pkt = self->pkt;
+	int len, ret;
+
+	len = build_udptnl_l3_frame(pkt, ETH_P_IP, 4, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, len);
+}
+
+TEST_F(tun_vnet_udptnl_proto_l3, outer_proto_bad)
+{
+	uint8_t *pkt = self->pkt;
+	int len, ret;
+
+	/* tun_pi protocol does not match the declared IPv4 tunnel. */
+	len = build_udptnl_l3_frame(pkt, ETH_P_IPV6, 4, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* tun_pi claims IPv4, but the frame says otherwise. */
+	len = build_udptnl_l3_frame(pkt, ETH_P_IP, 6, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 FIXTURE(tun_vnet_udptnl)
 {
 	char ifname[IFNAMSIZ];
-- 
2.53.0

