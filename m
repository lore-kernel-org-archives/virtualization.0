Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879858;
	b=T05+URxyiCL59RCXRJvGolJxAtpr9iVEN5+CmOEodHynq4Vi2NhoJeO2aBa3S1Dtbrmu
	 1BlRtn/o4SclHHdSEv+J8dNdQXsAIGuJNaVKJKnkpIEESBmWXzqGBt8+ooulIjxs8yv67
	 TP/+TqfvyBRgyBQD3ONBD9J8sikRKxNhSR+ft4fCCs28u5MN0CFNrgsGpWqoy/bGUsAQu
	 5ol6+Nz9PpAujkEcS04D2IJB6nrLB0vnqSwct5EA7nzmNAuO19bx/tcu7mb4DW0hGlxL0
	 mpWZYAPLPhETxoyPulilJ1no41IAwUiHKfUKITEnlAa+0qgTFcRfNzCt+Z2ng4JqV7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J6vTkIqgh1lKdbi1/lSNRSlFYK6FYiJ4fRc+ZBCVHHw=;
	b=ZaoskcA2Nis55MI4cr+70fY8kMY198vO9OChXnP7zHyKIsLiOMAyJiVS69P2fTxftkGE
	 k3IqZfhO0+E+vKmj936cFm6EmPyeotbM2QppwxXiVfxjNauKPIa+gdlcWS7NQJTfXvXKN
	 PThNMYLwIVaNZxWA5gGy9z7rudGHkx+L+Ot08BB17JHdqMQW6prxNSb1vkz2/1H4S4Lpw
	 gkV5J3gYruWuXuYts5CiycmPlncqSNOh7ogrSkQyQsk38NsYDsgDOZCApeu4irZ+uxvnk
	 7/xWzW6lydcIEZPafJPeAyv1/F1g1diPFxuEQV3d+URSAxFbR0MZeaD3J6FiYp/dZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIcazapP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E424606D801;
	Thu,  5 Nov 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIcazapP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790291F00919;
	Thu,  5 Nov 2026 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879858;
	bh=J6vTkIqgh1lKdbi1/lSNRSlFYK6FYiJ4fRc+ZBCVHHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIcazapP2YMQUUN6VYmgaCDbZHllC4i4859TkZhnAZed7H7FMR1U80xizzowHL0Ks
	 XTglbRd1FAn3ZhDT7rI1kSdubA3kXmnJMo9sc/lIFwWPssy0X1xCi8rBPsi0QhKsF2
	 WK1WCGHAbSDcOaCRMaZDTSM1NAWvth/1z5RuT1mJPXBv+wMnTLHDv1uisTUsOhjdtf
	 dfTHgbEjlaFRQUi1FzDJEeK8wnPyNbfoi/8Wo1B1gj3oQvV1PvF/2MlPAkeE9s5OGp
	 D/GcKW1AKIc+30hGA+zNa67ged8nV0kbNw+DIbDJYnwYkm1XoCdCABpZL67Y/WdZoE
	 0n0OZRBbMYqvg==
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
Subject: [PATCH net v3 6/8] selftests: net: tun: test UDP tunnel GSO on retyped devices
Date: Thu,  5 Nov 2026 12:57:13 +0100
Message-ID: <20261105115715.1466924-7-edumazet@kernel.org>
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

Use TUNSETLINK to make the device type disagree with the tun/tap
framing, and check that the outer headers of UDP tunnel GSO frames are
still validated according to the framing:

- tun_vnet_udptnl_proto.outer_proto_link_type: tap device set to
  ARPHRD_NONE. Frames with an NSH outer ethertype, with or without a
  VLAN tag, are rejected. A valid outer IPv4 frame is accepted.
- tun_vnet_udptnl_proto_l3.outer_proto_link_type: IFF_TUN device set
  to ARPHRD_ETHER. An Ethernet frame behind the tun_pi header is
  rejected.

Without the patch "net: virtio: do not use dev->type to find the outer
L3 header", the frames expected to be rejected are accepted.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tun.c | 74 +++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 81410afbbcc8..cfeca53863ce 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -816,6 +816,59 @@ TEST_F(tun_vnet_udptnl_proto, outer_proto_bad)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+/* Change the link type of a tun device, which has to be down for it. */
+static int tun_set_link_type(int fd, const char *dev, int type)
+{
+	struct ifreq ifr = { 0 };
+	int sk, ret = -1;
+
+	sk = socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return -1;
+
+	strncpy(ifr.ifr_name, dev, IFNAMSIZ - 1);
+	if (ioctl(sk, SIOCGIFFLAGS, &ifr) < 0)
+		goto out;
+	ifr.ifr_flags &= ~IFF_UP;
+	if (ioctl(sk, SIOCSIFFLAGS, &ifr) < 0)
+		goto out;
+	if (ioctl(fd, TUNSETLINK, type) < 0)
+		goto out;
+	ifr.ifr_flags |= IFF_UP;
+	if (ioctl(sk, SIOCSIFFLAGS, &ifr) < 0)
+		goto out;
+	ret = 0;
+out:
+	close(sk);
+	return ret;
+}
+
+TEST_F(tun_vnet_udptnl_proto, outer_proto_link_type)
+{
+	uint8_t *pkt = self->pkt;
+	int len, ret;
+
+	/* The frames still start with an Ethernet header, but the device
+	 * type no longer says so: the Ethernet header must still be
+	 * checked.
+	 */
+	ASSERT_EQ(tun_set_link_type(self->fd, self->ifname, ARPHRD_NONE), 0);
+
+	len = build_udptnl_frame(pkt, false, ETH_P_NSH, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	len = build_udptnl_frame(pkt, true, ETH_P_NSH, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	len = build_udptnl_frame(pkt, false, ETH_P_IP, 2800);
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, len);
+}
+
 /* IFF_TUN device with a tun_pi header: skb->protocol comes from
  * userspace, and there is no Ethernet header.
  */
@@ -952,6 +1005,27 @@ TEST_F(tun_vnet_udptnl_proto_l3, outer_proto_bad)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+TEST_F(tun_vnet_udptnl_proto_l3, outer_proto_link_type)
+{
+	struct tun_pi *pi = (struct tun_pi *)self->pkt;
+	int len, ret;
+
+	/* The device type now claims an Ethernet header, but IFF_TUN
+	 * frames still start with the L3 header: an Ethernet frame
+	 * behind tun_pi must not pass for a valid tunnel packet.
+	 */
+	ASSERT_EQ(tun_set_link_type(self->fd, self->ifname, ARPHRD_ETHER), 0);
+
+	len = build_udptnl_frame(self->pkt + sizeof(*pi), false, ETH_P_IP,
+				 2800);
+	pi->flags = 0;
+	pi->proto = htons(ETH_P_IP);
+	len += sizeof(*pi);
+	ret = write(self->fd, self->pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 FIXTURE(tun_vnet_udptnl)
 {
 	char ifname[IFNAMSIZ];
-- 
2.53.0

