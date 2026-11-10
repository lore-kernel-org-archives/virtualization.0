Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346598;
	b=VjwEISbIhg1mP0SbArIEmgZQBoTz1hKfl0PxwfdxeN/upuIZiIm39aqUxiBNfUGirdKJ
	 1EtptH+GWqMdDXEKgZYNwDsMj7tRC8iF87OlxGUGUHmTU6WfbxeyIF2cI87zg1Xti0gtc
	 nnXbL2ulzYwYJ6TGHfjY4Q/k92MneOfgWE8rZH4HrL1odfNXX6DVGCeaJdR14QHLj35rm
	 JEOTVp1XvWtP4QFcaYrQ+Bw6e4WG/y6I0oKk/KSV8e/3oD2NUADHZyzn6UBmRv1CE86Dt
	 d2n2CrDJkXea/LnsotwTKICgwa2DpTTE75KR0YfiSkFfChezMp3kDrIDBaTQWW8fdSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HTmxr13iXWhhDne07Lv/d84VD/IopfjenubeoJyRVDg=;
	b=t/IuSrqA2f9o3kxM5Og25ZH589N70389EGl4kC505Ebhi6sm17XUeNSahRfgr/ZPfabf
	 4M4KHTArINP+OWCrXYVICfdW0NpQ2oj/KcbFkobqIiSKYgWjgwQUc/NbngazRRu9re0+u
	 uHG5c+VgMwGkQ9pkS+WRtgyy+oqB8CUeLACDHGHnH8V3aFnTJCJuAwLJD/xB80WYXwLk6
	 DqpmNDp6rfRxPZ0acl3BfjBhzOVTnO4t7NmYOMjDSp8Oc3EbNM55VN4/DnL7bs1w92md7
	 vlJ2pgYqn3k537OtMYno3RPcfFWoBEBZhV883e0eohDKvnhx7RQXeSiTnDzipVjSmVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Efec3Ayb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37296606A325;
	Tue, 10 Nov 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Efec3Ayb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5371F0089F;
	Tue, 10 Nov 2026 21:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346597;
	bh=HTmxr13iXWhhDne07Lv/d84VD/IopfjenubeoJyRVDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Efec3AybM5Qt9jhSaZU7KiJWQym9Fi9wY0tLjQOxwQK0rEzyjVPFnaaysZV9KaX23
	 jAMQYwfeytZic+wEIcuioBB3SdBuZnVb9L9eUMM4Ov8SzLtwfqf7re+6/I/qacPNdo
	 G50Yx8b296b2lZnS6mli+h536H6yt6iB9IueE0nF1QduaGNS/DDw/IH0X/TgT8qFR1
	 sHzGQ/tqdeOo7bjYFvVGYE3IYSZ/ykn4M6F3X2Xa2BWFGZ2hTpcEiklGZGnkPLRBBB
	 dxCmh6LswsnyV5BF/Bx7mq/h8/xxmZbzWt4pBBU4xZZ+hZ/bBh1DePLtIi3pExQX9J
	 cOqoF6jXG5lcw==
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
	virtualization@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v6 1/3] net: virtio: fix UDP tunnel GSO header of VLAN tagged packets
Date: Tue, 10 Nov 2026 22:36:26 +0100
Message-ID: <20261110213628.3476051-2-edumazet@kernel.org>
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

virtio_net_hdr_tnl_from_skb() builds a wrong header for VLAN tagged UDP
tunnel GSO packets.

1) When the skb carries a hwaccel VLAN tag, tun_put_user() inserts the
   802.1Q header in the frame it copies to user space or vhost-net, and
   passes vlan_hlen = VLAN_HLEN. virtio_net_hdr_from_skb() adds
   vlan_hlen to csum_start, but inner_nh_offset and outer_th_offset do
   not account for it, and are 4 bytes short of the real inner L3 and
   outer UDP headers in the emitted frame.

   tun advertises NETIF_F_HW_VLAN_CTAG_TX and NETIF_F_HW_VLAN_STAG_TX
   in hw_enc_features, and its vlan_features keep the UDP tunnel GSO
   features, so this happens for example with a VLAN filtering bridge
   with a tagged port, or with a vlan device on top of a tap.

2) The outer family comes from skb->protocol, which is ETH_P_8021Q or
   ETH_P_8021AD when the VLAN tag is in the packet data, so a packet
   with an outer IPv6 header is reported as
   VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4. This happens when
   __vlan_hwaccel_push_inside() inserted the tag because the device does
   not offload it: virtio_net never offloads VLAN insertion but keeps
   UDP tunnel GSO in its vlan_features, and tun does the same with VLAN
   TX offload disabled, or with QinQ (outer tag offloaded, inner tag in
   the data).

The receiver sets inner_network_header and transport_header from these
offsets, and checks them with the wrong outer family. A forwarded
packet that gets segmented again uses the wrong inner headers, and a
receiver checking the outer headers against the virtio header drops
the packet.

Add vlan_hlen to both offsets like csum_start, and take the outer
family from vlan_get_protocol(), which skips VLAN tags in the data.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179421814766.994134.3669228181251158303@kernel.org/
Closes: https://lore.kernel.org/netdev/179433950084.994134.15100186606737698605@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/virtio_net.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..83f801ff5700 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -453,7 +453,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (feature_hdrlen && hdr->hdr_len)
 		__virtio_net_set_tnl_hdrlen(skb, hdr);
 
-	if (skb->protocol == htons(ETH_P_IPV6))
+	/* skb->protocol is the VLAN protocol when the tag is in the
+	 * packet data.
+	 */
+	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6))
 		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
 	else
 		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
@@ -461,8 +464,11 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
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

