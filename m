Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709F27F16C
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321514; cv=none; b=Ifm/DXoXol2qfrV/Is3wnBLA5u1NWE0VKAGaGQRBUXCIDn/ScJ3UJPfpRU36m6lOT5JzsKnM8xmm2/DXfXCZgJnjR/g78jDZHxs4h60SAR1GtUu9U5QhwT+GtndiKJ+wwGNb6FmFKv0dsHjqe0hl5wXoPrNDclWhww4PXvrWUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321514; c=relaxed/simple;
	bh=copfItzbQRl+LB1/PUbOAcdAvk1CS5I9MQeqTNbKqXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jypUbLe9GbjfzKDeyZa6GYYmkJMkByRkEHmQNbru8ChNA+77We7Fan9797HXchUFDSZLgEy3UCTZKccQkq0Fk3ovmhiZRhrD/oLwNA4YSI0gy9xpKPu1OKbeY0prVkloIjq/OhBb9w09szpGLKxSS7+T/HoXLnGv5T/CL+mRvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XOLvmzE0; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XOLvmzE0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760321510; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TKKlad8ZOJRTk7a95rnaDVFwiiHJsm1/cvNbYBEJQyU=;
	b=XOLvmzE0XubmVpB83fdXyuq8O7N7+bXD+R5oGsvMHwMgDf1Ov8FCMErRXH/uIEOe2S6r0Kaa9LXOgtGd8cUtZN6srjL//25Zm5+z//hCzTZQSPk489y9QFLoLrnlp07/qBr9ukCHdklrBrs0o021E1J3gT/XUNiCtrHO18Kq3Mc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpztGSc_1760321192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 10:06:32 +0800
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
Subject: [PATCH net v2 3/3] virtio-net: correct hdr_len handling for tunnel gso
Date: Mon, 13 Oct 2025 10:06:29 +0800
Message-Id: <20251013020629.73902-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 06377f1ca66f
Content-Transfer-Encoding: 8bit

The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
GSO tunneling.") introduces support for the UDP GSO tunnel feature in
virtio-net.

The virtio spec says:

    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
    all the headers up to and including the inner transport.

The commit did not update the hdr_len to include the inner transport.

Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index e059e9c57937..765fd5f471a4 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -403,6 +403,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
 	int tnl_gso_type;
+	u16 hdr_len;
 	int ret;
 
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
@@ -434,6 +435,23 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	outer_th = skb->transport_header - skb_headroom(skb);
 	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
 	vhdr->outer_th_offset = cpu_to_le16(outer_th);
+
+	switch (skb->inner_ipproto) {
+	case IPPROTO_TCP:
+		hdr_len = inner_tcp_hdrlen(skb);
+		break;
+
+	case IPPROTO_UDP:
+		hdr_len = sizeof(struct udphdr);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	hdr_len += skb_inner_transport_offset(skb);
+	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+
 	return 0;
 }
 
-- 
2.32.0.3.g01195cf9f

