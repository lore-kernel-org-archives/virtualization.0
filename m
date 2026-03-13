Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10526CE2C
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388782; cv=none; b=uB80CZWt0TsgvcmEm7O+Qh3OGC13Gawfu4uE1ilO/G/2xIPEavRpLe4qF6qjsN9YiI9yAnvhKIeM9gDtkMLWZrtfpUw/GBSPQXAf9sZAjMw9UcdQ10dtNeUZ6x/qv4uJagRj9ahBoYpYzRm/YLDUtgCQbNYgNW2W7mIdgvf5CJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388782; c=relaxed/simple;
	bh=bkieq66t1cOxvfsghAc/bDW1S7Yhm6tVAtJ+HXjhD1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfYsJPq/lsKS6XxOJZ3HdNDI5tD+1cKD8hxhDuaWZqEFLU0Pl13LMonI1FrPsLdZ2/UpwtuJPWqrAn1g9F5aGw7908O47WnQgXRzTY3mUQcR4hwSiIy9PvOFLmP1WAekXKqe0L0FfFP1fgIn2Yo5/MmOBpVpDnnFKCL3t1LtkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=haQUtAHY; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="haQUtAHY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773388772; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PYYV+stddHwl92a6td1rwCQPtn58Oou3luMEvqC1LEA=;
	b=haQUtAHY/OKpTVt8aChUq7vqVYdUnalRgBLVYvNztXUQBOXjKghhBrNtFP8DHgqlb0bLmxD/VhT9QdGgSwpiDK7ASkOSKJrU+IXhpYQyLHKMgC6oyTtg16YUzvQmTQpSR4KakbvIdaiyYIuwO/E67P2oYtWECKbfQrqq76BHOD4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X-rejAk_1773388771;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-rejAk_1773388771 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 15:59:32 +0800
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
Subject: [PATCH net v10 2/2] virtio-net: correct hdr_len handling for tunnel gso
Date: Fri, 13 Mar 2026 15:59:30 +0800
Message-Id: <20260313075930.105466-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: ad5d7fbc23b6
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
 include/linux/virtio_net.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 48de4a16a96a..76aa017a65c2 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -223,6 +223,21 @@ static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
 	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
 }
 
+static inline void virtio_net_set_tnl_hdrlen(const struct sk_buff *skb,
+					     struct virtio_net_hdr *hdr)
+{
+	u16 hdr_len;
+
+	hdr_len = skb_inner_transport_offset(skb);
+
+	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+		hdr_len += sizeof(struct udphdr);
+	else
+		hdr_len += inner_tcp_hdrlen(skb);
+
+	hdr->hdr_len = __cpu_to_virtio16(true, hdr_len);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -439,6 +454,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (ret)
 		return ret;
 
+	if (feature_hdrlen && hdr->hdr_len)
+		virtio_net_set_tnl_hdrlen(skb, hdr);
+
 	if (skb->protocol == htons(ETH_P_IPV6))
 		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
 	else
-- 
2.32.0.3.g01195cf9f

