Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7DB3126A9
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531732; cv=none; b=mzmqxch7UM2dxLgXfIof7+aMa6iFw7Ll50my3d7CsCrJGb+WKDhqC7WrKgw3jtr3+vme/76brwtlIo/yWpd9K+NaNWhW4U7/ZA4ts4LI3B+AtjYc5rztGQyuTHPWJ+Pd6XdXwi14ThSW8VL9/NHnlEfM+0CwL104hLJ5vWYOd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531732; c=relaxed/simple;
	bh=WLztPeOLolgIGfDbx84hymuhQEh1OvW5jJ52VwzECnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+zR/l8YjQkmzy2ibDU617mAREeZoTzYHiSGMgLG4VIsaIIZxZCMt1unxVeBFLpD5dCsMHi4wDINOAeZMzyNSyQHFRiTRPpSqkSJU362AHlBkfF3vkVTylzcUl9JgqrTWEuxizQ58B3C12fV1CGmRwxedCfP7GJsAiboSqRMbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=obwC8QdO; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="obwC8QdO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763531725; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=P6v623OsL+lyL92L48k5yauqviCIGVfoOcx6mqhYeaY=;
	b=obwC8QdOvhy7su+iqCg+J5JKK28Eg+lNZ2hAv/PEvaxn695R17Osy78UH2dQi+0Qr+bD7aQ5kSCmYMa0Eir8PV7eHBR/4UDmmevu+CLIeSrnWnkLPnCs2qQPO897nJ5pM/oZz2akfNBcndoKuTdpgSWxVMUvdSRRMDhKeqU5gSU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsnPfhi_1763531724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 13:55:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v6 2/2] virtio-net: correct hdr_len handling for tunnel gso
Date: Wed, 19 Nov 2025 13:55:22 +0800
Message-Id: <20251119055522.617-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
References: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 2ab728bd57df
Content-Transfer-Encoding: 8bit

The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
GSO tunneling.") introduces support for the UDP GSO tunnel feature in
virtio-net.

The virtio spec says:

    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
    all the headers up to and including the inner transport.

The commit did not update the hdr_len to include the inner transport.

I observed that the "hdr_len" is 116 for this packet:

    17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
        192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
    fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
        192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796

116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)

Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index ee960ec9a35e..ee8231eb759b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -215,12 +215,22 @@ static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
 	u16 hdr_len;
 
 	if (guest_hdrlen) {
-		hdr_len = skb_transport_offset(skb);
-
-		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
-			hdr_len += sizeof(struct udphdr);
-		else
-			hdr_len += tcp_hdrlen(skb);
+		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+				       SKB_GSO_UDP_TUNNEL_CSUM)) {
+			hdr_len = skb_inner_transport_offset(skb);
+
+			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+				hdr_len += sizeof(struct udphdr);
+			else
+				hdr_len += inner_tcp_hdrlen(skb);
+		} else {
+			hdr_len = skb_transport_offset(skb);
+
+			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+				hdr_len += sizeof(struct udphdr);
+			else
+				hdr_len += tcp_hdrlen(skb);
+		}
 	} else {
 		/* This is a hint as to how much should be linear. */
 		hdr_len = skb_headlen(skb);
@@ -441,11 +451,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
         vhdr->hash_hdr.hash_report = 0;
         vhdr->hash_hdr.padding = 0;
 
-	/* Let the basic parsing deal with plain GSO features. */
-	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = __virtio_net_hdr_from_skb(skb, hdr, true, false,
 					guest_hdrlen, vlan_hlen);
-	skb_shinfo(skb)->gso_type |= tnl_gso_type;
 	if (ret)
 		return ret;
 
-- 
2.32.0.3.g01195cf9f

