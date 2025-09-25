Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067B2BE65C
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767151; cv=none; b=WmUaWIxMG+kUVNH1PsaUM8tHPO4l0R1mMHOJRJCvJ1BBu2dVWLVNiE7rJpSD7foTHSZJjvIP7CGQoHltNCS+UMRnlvvgnVQjyBOg0P/H5aiVWMQaQQXIpeESJQX+qQqS7hdM7Y1kiKJs3I6zLpI4EXwYm/QjyL9Oc3dpO3WbTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767151; c=relaxed/simple;
	bh=tgSEc1HWM2agW5biNxl6fL16hgInhogKEOYYFZfpNZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KDv848o+ssrXVeceFzwtChiv7tzKA7MtYSUPer5iMvPnXtv52hr59KTDO6weqlywHuMmwJ/06BS2PioCu37o5bVHlT7cRILXQjLS8x1DoY3bHx4CwrN/PuQFZIRwEnLdCPXgiodNQPXcieUk9jSmxGglFCr+VGHAgj0yco2RMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EUciYcCY; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EUciYcCY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758767140; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TvbEHsio3yyITRN8SE97bu3O15GrQXTz/5regTBpZEI=;
	b=EUciYcCY4btbAxKxqBz1sDcdbTOtW1arYsvb5lo6Asgzx03/cRDSCZ8hpQ5HJI7ozGWAlrD7LvRh5cmsXAVtRDgjiPrY27M4ZGjYqF/j4dz7V1Aky7Ws+kxAU7Pqy1z9FSCw072X0ZI1RUiEFKy+bruZ51cCsPD61Wrn0Qza5Gs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WolqhBY_1758767138 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 10:25:39 +0800
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
Subject: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Thu, 25 Sep 2025 10:25:37 +0800
Message-Id: <20250925022537.91774-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 833f31d30d57
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
 include/linux/virtio_net.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..4273420a9ff9 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u16 hdr_len;
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
+		hdr_len = skb_transport_offset(skb);
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
-		if (sinfo->gso_type & SKB_GSO_TCPV4)
+		if (sinfo->gso_type & SKB_GSO_TCPV4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
-		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
-		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
-		else
+			hdr_len += sizeof(struct udphdr);
+		} else {
 			return -EINVAL;
+		}
+
+		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
-- 
2.32.0.3.g01195cf9f

