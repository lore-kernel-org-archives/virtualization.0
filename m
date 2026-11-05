Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879864;
	b=EGavoLY95QGkD1TAw9jXi8PU232nj60yHaLu1UItx6pjvPrKrumPymSfcy/eZKsqIHfJ
	 HI/wmU5CleOd9wob8PP3y7k2pqkehW8rIfA/s5B0roinht1z/Mus2mRoKYckeDz8BkG39
	 FyBFiBfWlI0yM/xqYGgURcI2/I+bua3FVYjoZbxdd4vKvlNOL7+amK4KXGE5ZITxEnzev
	 ngHOTzRkwOr3PynE4wk1d70ffdf5RjbR7BMuj3kV/TW5myz5oLuRW5GOWTefvMTAZI44x
	 5QSoX/1HVuymGv3cp7FU0HlwgOv0RW9O02kQQkq4ptbJPNLOJ01teJJvc2BRVRzkqYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ld+Wz8B/hJh48SUwyoUzJTM8MsH+YuxY8fpE45R4jQc=;
	b=FjxIPzuwDjV4fN7HLH0tNi0y5bGaK92lQkoIw09Ik3XNMAQWwjCMjjmRFlEg4qxWxZdJ
	 eONmCHbOIEG/Ahr40MkZozmaQZ4QDSOe8wyAkduWBhDlzztiFeL+q/IArF5trkKMd2Z8x
	 pf/WQ4ltEUQ1uJD0pE5OyzarFn6Z+Fzk8jikOPOVBhWmHwUkW3gyuCSpuxn3/PhTfBACQ
	 RengTM2hZY3wQ9eAFkjBA/BwODcED6IHSf0EhJDNUwlu9vgzbFLegKJC2k72MnTcUSiXE
	 HxfavQVCvkRvgrRVwm5GBWmudr/NoQoytD0D6LOqvnvu/cn0G8SwKmUL75arr7z8uyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVGdW6Ud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F215606A334;
	Thu,  5 Nov 2026 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVGdW6Ud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF901F00919;
	Thu,  5 Nov 2026 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879863;
	bh=ld+Wz8B/hJh48SUwyoUzJTM8MsH+YuxY8fpE45R4jQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BVGdW6UdjOJyM0jkjog7cioSHKW6xzp0ZWcu5+7p5HhXiUaHOBNdC6ZWxn2Jo7teY
	 9VFt5ss/dRBq9DWdBRq+bD9LWVXBPQVfmEo8mtJTfTQ1L0jXZZ4pmYBiRoTa+cb2oM
	 QeLcEfl0+U9Qe9pNUjIuLFpy6yGPA8xqSzCC3MctDUhA06mjER/CG8SbG8mLpcKr6/
	 5RZwOSheIJKyJXdY6i2Hjy+y10Q6gcIVsjAsoKzSZsLkOxoy6xF3QqZ4bCxRHFRwgI
	 Jn8bd9Vh9vfbPWyzRjelFZNjPNavbuCsMvBndOG9IlUvzwD+Ee4XVykWYR3RvRW4hC
	 B2qGQnGo0oDOg==
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
Subject: [PATCH net v3 8/8] selftests: net: tuntap: write UDP tunnel offsets in little endian
Date: Thu,  5 Nov 2026 12:57:15 +0100
Message-ID: <20261105115715.1466924-9-edumazet@kernel.org>
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

outer_th_offset and inner_nh_offset of struct
virtio_net_hdr_v1_hash_tunnel are __le16, and the kernel always reads
them with le16_to_cpu(). build_virtio_net_hdr_v1_hash_tunnel() writes
them in host order, and tun.c adjusts them with native arithmetic, so
all UDP tunnel GSO tests fail on big-endian hosts: the kernel sees
offsets such as 0x2200 and rejects the frames before the checks the
tests target.

Write the offsets with htole16(), and add vnet_tnl_offset_add() to
adjust them. csum_start stays in host order: it follows the tun vnet
header endianness, which the tests do not change.

Fixes: a942fcd72e97 ("selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179387332145.488856.1149073246990672028@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tun.c            | 10 +++++-----
 tools/testing/selftests/net/tuntap_helpers.h | 19 +++++++++++++++----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index a135d3aa10d1..5f797a1bc604 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -738,8 +738,8 @@ static int build_udptnl_frame(uint8_t *buf, bool vlan, uint16_t l3proto,
 
 	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
 						   AF_INET, AF_INET);
-	vh->outer_th_offset += vlan_len;
-	vh->inner_nh_offset += vlan_len;
+	vnet_tnl_offset_add(&vh->outer_th_offset, vlan_len);
+	vnet_tnl_offset_add(&vh->inner_nh_offset, vlan_len);
 	vh->hash_hdr.hdr.csum_start += vlan_len;
 
 	if (vlan) {
@@ -944,7 +944,7 @@ TEST_F(tun_vnet_udptnl_proto, outer_proto_bad_vlan_offset)
 	int len, ret;
 
 	len = build_udptnl_frame(self->pkt, true, ETH_P_IP, 2800);
-	vh->outer_th_offset -= 4;
+	vnet_tnl_offset_add(&vh->outer_th_offset, -4);
 	ret = write(self->fd, self->pkt, len);
 	ASSERT_EQ(ret, -1);
 	ASSERT_EQ(errno, EINVAL);
@@ -1031,8 +1031,8 @@ static int build_udptnl_l3_frame(uint8_t *buf, uint16_t pi_proto,
 	cur = vnet + build_virtio_net_hdr_v1_hash_tunnel(vnet, false, hlen,
 							 1400, AF_INET,
 							 AF_INET);
-	vh->outer_th_offset += IPV4_OPT_LEN;
-	vh->inner_nh_offset += IPV4_OPT_LEN;
+	vnet_tnl_offset_add(&vh->outer_th_offset, IPV4_OPT_LEN);
+	vnet_tnl_offset_add(&vh->inner_nh_offset, IPV4_OPT_LEN);
 	vh->hash_hdr.hdr.csum_start += IPV4_OPT_LEN;
 
 	/* Build the frame without options first: build_udp_packet_csum()
diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing/selftests/net/tuntap_helpers.h
index ecad83fae158..dc85cd9bc0ae 100644
--- a/tools/testing/selftests/net/tuntap_helpers.h
+++ b/tools/testing/selftests/net/tuntap_helpers.h
@@ -3,6 +3,7 @@
 #ifndef _TUNTAP_HELPERS_H
 #define _TUNTAP_HELPERS_H
 
+#include <endian.h>
 #include <errno.h>
 #include <linux/if_packet.h>
 #include <linux/ipv6.h>
@@ -368,6 +369,7 @@ static inline int build_virtio_net_hdr_v1_hash_tunnel(uint8_t *buf, bool is_tap,
 	struct virtio_net_hdr_v1_hash_tunnel *vh_tunnel = (void *)buf;
 	struct virtio_net_hdr_v1 *vh = &vh_tunnel->hash_hdr.hdr;
 	int outer_iphlen, inner_iphlen, eth_hlen, gso_type;
+	int outer_th, inner_nh;
 
 	eth_hlen = is_tap ? ETH_HLEN : 0;
 	outer_iphlen = (outer_family == AF_INET) ? sizeof(struct iphdr) :
@@ -375,11 +377,14 @@ static inline int build_virtio_net_hdr_v1_hash_tunnel(uint8_t *buf, bool is_tap,
 	inner_iphlen = (inner_family == AF_INET) ? sizeof(struct iphdr) :
 						   sizeof(struct ipv6hdr);
 
-	vh_tunnel->outer_th_offset = eth_hlen + outer_iphlen;
-	vh_tunnel->inner_nh_offset = vh_tunnel->outer_th_offset + ETH_HLEN +
-				     GENEVE_HLEN + sizeof(struct udphdr);
+	outer_th = eth_hlen + outer_iphlen;
+	inner_nh = outer_th + ETH_HLEN + GENEVE_HLEN + sizeof(struct udphdr);
 
-	vh->csum_start = vh_tunnel->inner_nh_offset + inner_iphlen;
+	/* The tunnel offsets are always little endian. */
+	vh_tunnel->outer_th_offset = htole16(outer_th);
+	vh_tunnel->inner_nh_offset = htole16(inner_nh);
+
+	vh->csum_start = inner_nh + inner_iphlen;
 	vh->csum_offset = __builtin_offsetof(struct udphdr, check);
 	vh->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
 	vh->hdr_len = hdr_len;
@@ -395,4 +400,10 @@ static inline int build_virtio_net_hdr_v1_hash_tunnel(uint8_t *buf, bool is_tap,
 	return sizeof(struct virtio_net_hdr_v1_hash_tunnel);
 }
 
+/* Add @delta to a little endian tunnel offset of the virtio header. */
+static inline void vnet_tnl_offset_add(__le16 *off, int delta)
+{
+	*off = htole16(le16toh(*off) + delta);
+}
+
 #endif /* _TUNTAP_HELPERS_H */
-- 
2.53.0

