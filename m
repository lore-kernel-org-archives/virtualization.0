Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139A3C6A44
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230066; cv=none; b=M5JsCZXfTEcSv2+7aE498jZu5KkFyG/0ItyFQsSAM6LNcrq8WW0baYL93mfkeaaPmWfV0CualTNAyVu6DDFPppR9EtthoqdvFxGIMlNt1H994Tzw3mlFBWLf+TkZbuUhmptZAImTAHb7rRmon3ulWE/ef0XJwWUrA3VHd2bngu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230066; c=relaxed/simple;
	bh=t5Cj9Hjao+ATei27nDWwiyDKCHRpoeswz0HbhQvSCjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhi3MIQwDbikEzybeo2N6XpLKUSu9EXGdsxnvKatRY5murgkeIzqpdvTlP2MiceG5WYsfBj92AdYqZqVZ6/43wmOB+3UQFBvPxzZ2KGJCUKgyBZn0BcDFl6QzUfgM3aviZVZ0ZVTJYWLmp1r80clTeR9EKsmrfQ3/bgxX8vhhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z7+ITTn+; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z7+ITTn+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773230056; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eTaVkesOnz00TagXXUlebaD5E34dJ6Qyn5C7uPARsVA=;
	b=Z7+ITTn+w8VIgH5bVOEzsq9SuH6ss1AoeRxJ9aoGNuDcJI0d9ryef+TiE6bubYyj7YRPdHAaYFFdvVFflg/+g4zUnVjehpbdCGfny8+Gyog/ko2UUVS3X2JhFrVozYXuiePYyEgkXWgOZMUIW9wLODSLd+X38fLSVVXQY/qA49M=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-jzDbv_1773230055 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 19:54:15 +0800
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
Subject: [PATCH net v9 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 11 Mar 2026 19:54:13 +0800
Message-Id: <20260311115414.31243-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260311115414.31243-1-xuanzhuo@linux.alibaba.com>
References: <20260311115414.31243-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: e88adc2e5a2a
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
 drivers/net/virtio_net.c   |  6 +++++-
 include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 6 deletions(-)

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
index 75dabb763c65..48de4a16a96a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
 }
 
+static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
+					 struct virtio_net_hdr *hdr,
+					 bool little_endian)
+{
+	u16 hdr_len;
+
+	hdr_len = skb_transport_offset(skb);
+
+	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+		hdr_len += sizeof(struct udphdr);
+	else
+		hdr_len += tcp_hdrlen(skb);
+
+	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
 			    int vlan_hlen,
-			    bool has_data_valid)
+			    bool has_data_valid,
+			    bool feature_hdrlen)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
-	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
-					       has_data_valid, vlan_hlen);
+	if (!tnl_gso_type) {
+		ret = virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					      has_data_valid, vlan_hlen);
+		if (ret)
+			return ret;
+
+		if (feature_hdrlen && hdr->hdr_len)
+			virtio_net_set_hdrlen(skb, hdr, little_endian);
+
+		return ret;
+	}
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
-- 
2.32.0.3.g01195cf9f

