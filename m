Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FA25DD1E
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680791; cv=none; b=Syo+w6hO9H4ZXsQATOFKOrrlFmNRLge5Sud5FSEjyNJ1hyyYc9vpigY8bWRw16ZCyYx9xy/YifxStvXoW3ldrCGvTADCgRdh+ac1up50iKJtpd/VLIV6wUu25DHn9P40/Jj6Ye1pB6cf36VM/HRHtoOBRD/mZv75l2Pzf9nK1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680791; c=relaxed/simple;
	bh=/JrPSXPcSZUb8gIM1FcNF2xYVA6x1l/xjpb8lu281RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ionnzU5mA+uZEmFQiQokPW0rPgHuTWje7cfVeEyHC82Kx8lgp8kci0nb3nwMruFG2g8KFm7A6E7WP4vzkaigZ4QQW2iK8OVsJpQt5ZlX6V78F+08VEa9+ise5rF21hqUGVH/fr5BHKCaFWXV9EfrINiMbYm1kGI07Jqi5hQ/qzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OlH5Ze/w; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OlH5Ze/w"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772680781; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+0QObana9um5BVxG1YFlQ+rya4oET1Hukgii68OKf+8=;
	b=OlH5Ze/wKHnteiwxMiKWiynGggvIwjorvVrTbfdf6Yk56pGNgM/VZmjH0v5VOhXSJ04pWtcdq5n3WG+uqEAS7dn8J3v+mokKlmNONcRJAQv9RdVdmAjUj7zKPkYdbM50WWZzhW67jNiYflr8ojZO5A/cGOdFNM++RS1VmofOruI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-GvkKx_1772680779 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 11:19:39 +0800
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
Subject: [PATCH net v8 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Thu,  5 Mar 2026 11:19:37 +0800
Message-Id: <20260305031938.24518-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: aa36ef004473
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
 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  6 +++-
 include/linux/virtio_net.h | 58 ++++++++++++++++++++++++++++++--------
 3 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index a5f93b6c4482..fa5cab9d3e55 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen, true)) {
+					vlan_hlen, true, false)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..7106333ef904 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	struct virtio_net_hdr_v1_hash_tunnel *hdr;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
+	bool feature_hdrlen;
 	bool can_push;
 
+	feature_hdrlen = virtio_has_feature(vi->vdev,
+					    VIRTIO_NET_F_GUEST_HDRLEN);
+
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
 	/* Make sure it's safe to cast between formats */
@@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
 					virtio_is_little_endian(vi->vdev), 0,
-					false))
+					false, feature_hdrlen))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 75dabb763c65..23f42bb8ece0 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
 }
 
-static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
-					  struct virtio_net_hdr *hdr,
-					  bool little_endian,
-					  bool has_data_valid,
-					  int vlan_hlen)
+static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
+					 struct virtio_net_hdr *hdr,
+					 bool little_endian,
+					 bool feature_hdrlen)
+{
+	u16 hdr_len;
+
+	if (feature_hdrlen) {
+		hdr_len = skb_transport_offset(skb);
+
+		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+			hdr_len += sizeof(struct udphdr);
+		else
+			hdr_len += tcp_hdrlen(skb);
+	} else {
+		/* This is a hint as to how much should be linear. */
+		hdr_len = skb_headlen(skb);
+	}
+
+	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+}
+
+static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
+					    struct virtio_net_hdr *hdr,
+					    bool little_endian,
+					    bool has_data_valid,
+					    bool feature_hdrlen,
+					    int vlan_hlen)
 {
 	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
 		if (sinfo->gso_type & SKB_GSO_TCPV4)
@@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
+
+		virtio_net_set_hdrlen(skb, hdr, little_endian,
+				      feature_hdrlen);
+
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
@@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
+					  struct virtio_net_hdr *hdr,
+					  bool little_endian,
+					  bool has_data_valid,
+					  int vlan_hlen)
+{
+	return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					 has_data_valid, false, vlan_hlen);
+}
+
 static inline unsigned int virtio_l3min(bool is_ipv6)
 {
 	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
@@ -385,7 +419,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
 			    int vlan_hlen,
-			    bool has_data_valid)
+			    bool has_data_valid,
+			    bool feature_hdrlen)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -395,8 +430,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
-					       has_data_valid, vlan_hlen);
+		return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
+						 has_data_valid,
+						 feature_hdrlen, vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
-- 
2.32.0.3.g01195cf9f

