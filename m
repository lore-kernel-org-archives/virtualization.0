Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E52E8B8A
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291698; cv=none; b=SkliMIamNWBHEFdkqkLshO1BFJlbd0vni7U+I+noAkRhJUgX9lKXP4dM/h/pHkoqtVKh0Me3LWvLK1rEsEWKmanYRVsr80ECuj5PpPkaK2Y09ePjnCixU0kWpt2lC1e6wOj90IUZDwPzPYBJDLxA27jldBj52uhxZJq+Vm845Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291698; c=relaxed/simple;
	bh=21Bjl16k+IjeoCFYv6/Z1r8rWVvkmmP74ubmajepbqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1V3XIlPZ8jFNmTDwSVIzsT4omPQhLptDtV3+zx2Ub0vZ2hz+ezRPMSZ2mqMc3hVWtlxsU1I36gTXbEObWAidxQfAAX6mDSedSBfuRmaEb1YCARcxZnglP+j3YsM98QNzRDOcLlBeo9DCsDbDm5OmnqvYLgQ6KFaWwV39ampteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g2jYH3p4; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g2jYH3p4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761291693; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Et9rwRl9la/gKnHaIVGGaGFEMypCBNUiginq1wtXkGo=;
	b=g2jYH3p4a/lr9VJQmoy3gBxvFbnEoZvW9xZ2PE5kErUyphgbJU8YFREai8YjD/HDUQBt0o7HihpKWixi8lbK6EpmN/r0auXuTfLnjvse5TdP7gPdo7pEL417xsMkbu+1HltNidzwpO9BKlHv+r3d2XA5aQ9snIFMcBtdI68Bk3U=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wqtb4BX_1761291691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 15:41:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v3 2/3] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Fri, 24 Oct 2025 15:41:29 +0800
Message-Id: <20251024074130.65580-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
References: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: deaf684dfaeb
Content-Transfer-Encoding: 8bit

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This commit fixes that issue.

Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 4d1780848d0e..a2ade702b369 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -217,20 +217,34 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u16 hdr_len = 0;
+
+		/* In certain code paths (such as the af_packet.c receive path),
+		 * this function may be called without a transport header.
+		 */
+		if (skb_transport_header_was_set(skb))
+			hdr_len = skb_transport_offset(skb);
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
-		if (sinfo->gso_type & SKB_GSO_TCPV4)
+		if (sinfo->gso_type & SKB_GSO_TCPV4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
-		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			if (hdr_len)
+				hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
-		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			if (hdr_len)
+				hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
-		else
+			if (hdr_len)
+				hdr_len += sizeof(struct udphdr);
+		} else {
 			return -EINVAL;
+		}
+
+		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
-- 
2.32.0.3.g01195cf9f

