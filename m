Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242117;
	b=U6yHk5X61lSc3LC0UDrQOrCGweMQu7AVNhgy3098V0l4Q5eZSJbY+9iFhFf/UhZVADW3
	 SQ/CSYLihHYNhYhQsChFn97dPSD2HRzu25F7YuBcVzOPEDjIujKBEHHaHj0LA/TijW3HW
	 2svLLpWDb9Ovx7Blo1Aq0MFISoo/cGIM7RDwvUerUU0Q4stUBA3IWYAQFJDIslmB2WPSI
	 yXVz30rk08IgOf+gjh2OtW+/cyBIt7wr3m0zHIxokO4Gn1VJCBJw15elDRnyu23Rtjg6Q
	 88lYTDPKi8+kTcKz3cCaKVf7TjHXHGY7ScgMN2ts6lPAB7NbdqrmrobulpKMJmAud9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ze/VmDBOz+DDDwmzIw+36I8dhYEiqJZDITl1x1O2gXA=;
	b=Z4mf2tgiUfehuGZ12RMDGC9QUqWlklHmn9FI3OyjDAp42sXG83HI8geP2mSFoUOrD/tr
	 PrMGkhli+DvBsbplTd857SGCsqKkeRWvZ6nDmWsv/DqBsDKM9gmlLwsL4cWuJnPP3UPB1
	 OCAtn6LGIG+tnM/zzapkeHf8j404D1OLTg+OpXkFt0wXPsxBnkf6HvU+U8rsSpSWxWwyU
	 DlB66tfuOEvhXc3zQgoCZ7ValdUfHJl/DjpkxtbSRd7Tk69MZKPy4o1/jlIxaodcua7zD
	 d4s0F395dWjYCWPYM+RthHL36Q1U0MfPLeeg9yEi1d8VNMBK+YDelFgIG3BwHJeg00A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYTwJ08s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4C606A332;
	Mon,  9 Nov 2026 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYTwJ08s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F08C1F008A1;
	Mon,  9 Nov 2026 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242117;
	bh=ze/VmDBOz+DDDwmzIw+36I8dhYEiqJZDITl1x1O2gXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZYTwJ08sjNdKFi1Dq1CXJrzIIBsga9QsnY1OCLsu+186sV3bHCdGkiV2gRr/Ts18z
	 g4FIvx4YjKlVMCpx6NkPksbtcfA/BWJRVBLYgymC+KN11NlUtAjeOE/dY5/x8zjMGK
	 XzBo+xuqVokAOcipe2C98KFK3q51YTpzimi35ZNDjpytTQ4So4VhvPfzjH0Rb568YT
	 d2xz+CNy8HpYVTt2JtX892X+d5NWEWpxNzDSJM8Zj8r6qGRARK04xUSdSXvLtu+Ini
	 Y6vs2PirBay0TjmGJyf2vXr/FzrqsizklM61s+zOPhkSQlFZtcsp1c25cY9bJk8Gfh
	 d+1T2c7MgN0sg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v5 1/3] net: virtio: account for the VLAN tag in UDP tunnel GSO offsets
Date: Mon,  9 Nov 2026 17:35:05 +0100
Message-ID: <20261109163507.3102091-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109163507.3102091-1-edumazet@kernel.org>
References: <20261109163507.3102091-1-edumazet@kernel.org>
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

When the skb carries a hwaccel VLAN tag, tun_put_user() inserts the
802.1Q header in the frame it copies to user space or vhost-net, and
passes vlan_hlen = VLAN_HLEN to virtio_net_hdr_tnl_from_skb().

virtio_net_hdr_from_skb() adds vlan_hlen to csum_start, but
virtio_net_hdr_tnl_from_skb() does not add it to inner_nh_offset and
outer_th_offset. Both offsets are then 4 bytes short of the real inner
L3 and outer UDP headers in the emitted frame.

The receiver sets inner_network_header and transport_header from these
wrong offsets. This goes unnoticed for local delivery, but a forwarded
packet that gets segmented again uses the wrong inner headers. A
receiver that checks the outer headers against outer_th_offset drops
the packet instead.

tun advertises NETIF_F_HW_VLAN_CTAG_TX and NETIF_F_HW_VLAN_STAG_TX in
hw_enc_features, and its vlan_features keep the UDP tunnel GSO
features, so this happens with VLAN tagged UDP tunnel GSO traffic, for
example from a VLAN filtering bridge with a tagged port, or from a vlan
device on top of a tap.

Add vlan_hlen to both offsets, like csum_start.

virtio_net passes vlan_hlen = 0 and is not affected.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179421814766.994134.3669228181251158303@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/virtio_net.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..ab44342cf09f 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -461,8 +461,11 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
 		hdr->flags |= VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;
 
-	inner_nh = skb->inner_network_header - skb_headroom(skb);
-	outer_th = skb->transport_header - skb_headroom(skb);
+	/* Like csum_start, the offsets must account for a VLAN tag
+	 * the caller inserts in the frame.
+	 */
+	inner_nh = skb->inner_network_header - skb_headroom(skb) + vlan_hlen;
+	outer_th = skb->transport_header - skb_headroom(skb) + vlan_hlen;
 	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
 	vhdr->outer_th_offset = cpu_to_le16(outer_th);
 	return 0;
-- 
2.53.0

