Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7522E03F2
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707361; cv=none; b=O74BGNxKcjVMfE2XwEFpuATy0aQeXZTQDIoy2Id9dYJE4dnYo9hJYtpksrrKTCNDiouJ82fSQK1MWjuRCx7WdnzTHlv3g1ovHG2/JYbPrK1QK5yllH4dl50okGHpL9oCoBV2LRU9NC2krLTO2bVR7+bSb42HPVWDCiNlphOW+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707361; c=relaxed/simple;
	bh=aP9qakPpaiVOSdB+uHYjLY9V9RVOWJVKdskFxOy1jHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0bkxxLNAVkuT/ssQx4jO6HawFht0DfEnUMu74+W6vEbYBknKz7m0Zr2RzB14LEsJ7NcdSlGkMgMwqBs0Dv2spDFuijQ+nmxYS6inVoEyz+C8ITIapNzgfcjZdo3Z881nluTrv6Iu4vqpYOrjJGRj3FNmY1z4M0ZTCe/fAnGarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xHZq/F9y; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xHZq/F9y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761707357; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MxotkOrTHpJZdolHx2dEGWPUrZYdrvHR3vVjWbi4U7Q=;
	b=xHZq/F9yssdafK0TAih3QASuxJ4NFa7uIvu2hkVuxSfwObzQu/rlr8sHas6ja7C0lPmgUT061KSFa962QWlUT7LIbeUyIOBu06JehS86MhIVitZ7PGj/8YnUVrXUXBJfotZ1BER9hIugWqlgwwAoQtbBtexaN4OK9bSjIUCjGcQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrEEDN2_1761707355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 11:09:16 +0800
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
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 29 Oct 2025 11:09:12 +0800
Message-Id: <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: eb1fbe1c38ee
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
 include/linux/virtio_net.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 710ae0d2d336..6ef0b737d548 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u16 hdr_len = 0;
 
 		/* In certain code paths (such as the af_packet.c receive path),
 		 * this function may be called without a transport header.
 		 * In this case, we do not need to set the hdr_len.
 		 */
 		if (skb_transport_header_was_set(skb))
-			hdr->hdr_len = __cpu_to_virtio16(little_endian,
-							 skb_headlen(skb));
+			hdr_len = skb_transport_offset(skb);
 
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

