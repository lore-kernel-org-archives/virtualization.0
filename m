Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737893;
	b=ojDAv0Mi1FwwrTdM0cZHcJoy4ZJ0SD8Wy+DR+CIoJqJOvNEuen8fut+WCKrSYASmLLH4
	 0rJRcD3svfWn4YTpAt2LJElnneXo1TRMe/Xxitl82OM9lJBBkv9YsCX2XyOLaqqcHkNQF
	 gO7Lwn0RrIIisqtmiGGiNZPtuTvoB0J8eO0Mk/FsZBeoAFokkneb3Vd2fyQPEiqy77nM9
	 Iq7CODT3EwbdgCLG5izGGMDauSTEoIBMxmywsLA48nhfZWT1kYa3+crHI3huUNPM+xcbK
	 TTlaR+5rp/ZyQW6M3vnSwTYdiSIvsq+DH6HxW3H4NbfzAMuE0M7LDXdfu2BkWlrbIWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tAuteYskstdeBpCYH9CcsGKkJ76cGxAdPzEGscpfTvM=;
	b=UoDnGTZXIMIbSOk6hIuaDu6s7qjG3itIVBKX1AV6ja1AirdAk9tUQw+Zo+N1qRE7JKJ/
	 ACTJ08Sx3LUmo3wKKHvXy3DnLHkCdF5bmjNEWLqsNjACYf6dBkb9vIzcBkT2PhfJzsV7s
	 +AsTnaLwW3ReLfiGRXs4xBNKVGq8RAnA5Fx1pQphIZ5NrLKbQCUCjwTQ3oDPLG1NH8lOr
	 Tq57OnS7edM1z6a+qpKakhx35xvZKbDgwDDZ+iIaqrBTAamoxlQfMAHRPOhCfWsYG+IA8
	 hJriFOJTUSm3zqAtj+P21VgDzKzJQA76kDfysZwUYzuIXBZFs89Yc8o3yZZTI0O200A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GeYJtY/C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CFF606A331;
	Tue,  3 Nov 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GeYJtY/C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD2F1F000C1;
	Tue,  3 Nov 2026 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737892;
	bh=tAuteYskstdeBpCYH9CcsGKkJ76cGxAdPzEGscpfTvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GeYJtY/C6ti6m79Gf7a1ihXUA6vPheWq6Xj3tkMSbteES91jzl0CX4+8nGCkFxJs/
	 gr4wnCZEnvyCP2FnXkMlPF2qgdDTeHtFkn6tlP9PvquiMYwVMwONkSmvqsvK3p1tpu
	 dhQtepYqYBgQvI/BhdL0OSj49MDn9W6nLgxRSgGhxiQEBbUYynaowrZ2QlvSow5UX2
	 JUJhmOBNQGSyc1R7xybMk+nLn3ielMCO/SGR/PWte7Qxgy3s0q7Hjai5v5RixwZCnX
	 PimQKSierhtJCcs84+TGW/DcHlo31pM4HMDMBRE2KhVpG2jVO2SOQu001YOdXjeMFs
	 b98UGeBxLuMhA==
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
Subject: [PATCH net 3/3] selftests: net: tun: test outer protocol of UDP tunnel GSO packets
Date: Tue,  3 Nov 2026 21:31:13 +0100
Message-ID: <20261103203113.550604-4-edumazet@kernel.org>
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

Add a tun_vnet_udptnl_proto fixture writing single 4in4 Geneve GSO
frames to a tap device with UDP tunnel offloads enabled:

- outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
  is accepted.
- outer_proto_bad: an outer ethertype that does not match the declared
  tunnel type (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN
  tag) is rejected with EINVAL.

Without the previous virtio_net patch, outer_proto_bad fails because
the kernel accepts the frames.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tun.c | 130 ++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 34de2580e32e..47a24b9c477b 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -683,6 +683,136 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
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
 FIXTURE(tun_vnet_udptnl)
 {
 	char ifname[IFNAMSIZ];
-- 
2.53.0

