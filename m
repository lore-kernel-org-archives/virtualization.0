Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBE4D8CE
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291700; cv=none; b=EiZxua0rWXQPLn8LSbRU2emKQ012Wh3OWYk08787gnI5BH2Rtw671vQGsiyRAeRWx4QYq69FsIZpcVtUzvhujQukXIOsRLKLzT8Hzd1bedC1PYlhSXEpVVCqkRJTsRztKLRMfE3Isrz8+FF2rmmiY/1rWEI7cWli5UhtuKGy5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291700; c=relaxed/simple;
	bh=ly/m+/EpIdsgFGYRxTQnqaiQYC1jp0N2nQI2+W/5S0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdOL7yVHlfuWqlBJbPSGAWfa5dbMmllXD1+W+rt5ejrQu4fMqxJSdYq7ZyU4bfpgVFsWDCgQRe38PzKUYr3hLD56JZZdcMDbEAQcwCplqnV7wWUL1y8DwOERf5RYVNMeWzlpjxkKVzcWEJ0JJnHz8N4FYb/rHEgXL8CJvv6mM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BowJd4TA; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BowJd4TA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761291694; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WM9DTHdBfzgWZ38Bf1NDNauL/QpcXbOARPaZPxThJwQ=;
	b=BowJd4TAc6GyWPo44n6bIoY62GmkcJg1bRsIifNCmIldqmQQjbWZGuKEtzCNishzCTFxJgNmXWRscAHlN3tERjoPstb9uCCZTnmMW00nVesOZkeV6guCkk5l95jgenclJeGlXin+4mJkYUZ3xebWX53rHpF2EI/qF/1rZiyMcwM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wqtai5f_1761291692 cluster:ay36)
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
Subject: [PATCH net v3 3/3] virtio-net: correct hdr_len handling for tunnel gso
Date: Fri, 24 Oct 2025 15:41:30 +0800
Message-Id: <20251024074130.65580-4-xuanzhuo@linux.alibaba.com>
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
 include/linux/virtio_net.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a2ade702b369..2b6012bcc57d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -207,6 +207,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
 }
 
+static inline int virtio_net_tcp_hdrlen(const struct sk_buff *skb, bool tnl)
+{
+	if (tnl)
+		return inner_tcp_hdrlen(skb);
+
+	return tcp_hdrlen(skb);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -217,24 +225,32 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		bool tnl = false;
 		u16 hdr_len = 0;
 
-		/* In certain code paths (such as the af_packet.c receive path),
-		 * this function may be called without a transport header.
-		 */
-		if (skb_transport_header_was_set(skb))
-			hdr_len = skb_transport_offset(skb);
+		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+				       SKB_GSO_UDP_TUNNEL_CSUM)) {
+			tnl = true;
+			hdr_len = skb_inner_transport_offset(skb);
+
+		} else {
+			/* In certain code paths (such as the af_packet.c receive path),
+			 * this function may be called without a transport header.
+			 */
+			if (skb_transport_header_was_set(skb))
+				hdr_len = skb_transport_offset(skb);
+		}
 
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
 		if (sinfo->gso_type & SKB_GSO_TCPV4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
 			if (hdr_len)
-				hdr_len += tcp_hdrlen(skb);
+				hdr_len += virtio_net_tcp_hdrlen(skb, tnl);
 		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
 			if (hdr_len)
-				hdr_len += tcp_hdrlen(skb);
+				hdr_len += virtio_net_tcp_hdrlen(skb, tnl);
 		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 			if (hdr_len)
@@ -419,10 +435,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
         vhdr->hash_hdr.hash_report = 0;
         vhdr->hash_hdr.padding = 0;
 
-	/* Let the basic parsing deal with plain GSO features. */
-	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
-	skb_shinfo(skb)->gso_type |= tnl_gso_type;
 	if (ret)
 		return ret;
 
-- 
2.32.0.3.g01195cf9f

