Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535595226AA
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068106; cv=none; b=Ei/6VeKSRTWlx4fqPC13e2CkPtoGLV5pMhQpATqKhyRNp4yUF4g33ERXxUIrMgt+tLm9b1l5OMZ3wFG5FSTBY91V0vRldKV1jOcXY8lGHiHHyt1tWvHVIc9n7jw2+n4nVVzDD1XYmyGFECPPoivoeJPs9tlHQpgidNFgX+ySssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068106; c=relaxed/simple;
	bh=Rl5K6qFYr1oz9s3luxB+F/6lIQe8nEjyrP/2SuMzpLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uauM2laKe/2LUtnOLYXeknFdonktC0O+pRiLqxfHJPwgdfkR5oyA56RtNN26eAhDRdvh/fX3dg01uGhDBTffYpqcQF44nIOzSGhNwasf64lES4hpb6mmWN04QYUwF2hFYxI/TyjeU/wpRQOWVdFiuTtryGiobJX9rqbKooyRWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jd/7wPpN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd/7wPpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TyxHHWSvKWWNVzFcy2Pxr+76QrIfMwrq1ET2Rt01QEA=;
	b=Jd/7wPpNIqDnQSBBqEcb9IXOBHNE8aks7GdYvixzuDpRhP3pqyUiyYV6m+0SJOLG5jQTvx
	JICGxoiabMEUEdBoc/sydxsO6aI/RJuhAAhliLbxoG8MQygV+lcZanv8ZWHJWunJ0TcgzE
	+C33aeFtsWLi+4QHmmRnAoM6Bi24/CA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-RETpYdFoNuiXXX82_AgIDQ-1; Thu, 15 Oct 2026 12:41:42 +0000
X-MC-Unique: RETpYdFoNuiXXX82_AgIDQ-1
X-Mimecast-MFC-AGG-ID: RETpYdFoNuiXXX82_AgIDQ_1792068101
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df5b058ddso426040f8f.0
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 05:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068101; x=1792672901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyxHHWSvKWWNVzFcy2Pxr+76QrIfMwrq1ET2Rt01QEA=;
        b=SabbQn6RVtSCW6a80kUW+rO71zJplclBp9xtHTbNlk9Al2zvuvnV/quJdFk5lU6cNO
         y2PWnJ8ycqMAvCUq9AC6ssYMycJ+yzOoDrDGvKPGy/lw0FW2CR4OaE47KeXdOftl28S5
         K1iqjH6KJunDZYEVMQOkvXx3Oqbh+VEtyIfQnL7XoUmEESCTay9bSK+V08DCFjA0t/Tv
         ISKMIjrycdvUPl8Lurc7fUvIWhV5zmNRni7E2+T6GlYq8+/JW7jXuLsE+T5bb0ihaati
         p8Tjjxj2/rjQWZZ9KVWmTGD87/Tfc4j8xIe1GoWYqYQZB0Bw3g7KL2lpBh7v0aise3E3
         jUIw==
X-Forwarded-Encrypted: i=1; AKwUvByZxJqrmkU5JU9mUnrgyymdTSrX1jC2b1KVVJWq7wjyat6IXXiqQKhEGRMWqYjngOvSQu/6mJYH+xgVN36k0Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJP74QzLGJUs8dHnVE8HcfKFL6p/4IN8oyx9UVENuG1TXq0Ho6q
	q+AQ5s3ZF1op+Q0+3+eMaGwiuK8UcSJOU1rGW4lk5lcW1ALaaA5TrDFm3+teB8dJHaai441MEPq
	QDIw3OYPt7Q2iOaOCFB44kncLvNNWL/iWHFZiki8cJiWJy5tzKv4PYzDFHGoGL3p00JAK
X-Gm-Gg: AYBFou1qNOQvmrpV8Zevu7f4Iwc5WO+1+HYQGZbBKYA5C/5tY3UnWx+X6x+7zwlJhlI
	KaJJLOfazFWaE8q5nxlBG+b38fcSqWMn/Yb3VnaVyoCugbhYtBDhg9g81MQf6pYOZhG3xp76KQb
	u5HsC1H9HNKUbxO7zoxiHrPq8DBf4X8j1UflY6KP4n7RbsVIg5TyTeUo3D4j8Bv28sNMxzzvtBk
	04lT9+tNry+nEcqo6lqN61CjD0EswejNn4SnAhz1tlsZnKGU0nc5haO/a+AYFhLqMuGT26hzUx0
	MACPEOjtYTTB31tSCJrwh1YS0U05E1Tw9V0KKuVpyDP16oVnVJ3fXAZL9I9Euzomrfqrzw==
X-Received: by 2002:a05:6000:2209:b0:487:1575:ebef with SMTP id ffacd0b85a97d-48dbacf70c3mr35894037f8f.47.1792068100593;
        Thu, 15 Oct 2026 05:41:40 -0700 (PDT)
X-Received: by 2002:a05:6000:2209:b0:487:1575:ebef with SMTP id ffacd0b85a97d-48dbacf70c3mr35893947f8f.47.1792068099775;
        Thu, 15 Oct 2026 05:41:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df0f99f0bsm6536691f8f.21.2026.10.15.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:37 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums at
 ingress
Message-ID: <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sh6jjLJTevJGqesPYnoDEcnvgU6H9SJ0-U1oDZil3zY_1792068101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
others, credited below, found more ways the bug can affect users) a
virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
If that state is retained, later checksum completion can modify the
packet after protocol processing has made decisions from it.

Let's fix that: let's validate csum_start and csum_offset and only keep
CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
headers.  Complete other non-GSO checksums immediately, before any
protocol processing runs.

We can't easily "complete the checksum" for GSO we don't recognize - GSO
assumes knowledge of the protocol. We could segment ignoring the
checksum then do whatever csum_start and csum_offset say, but that
seems like an overkill for something that shouldn't happen.

There's some risk here:
- non-gso packets which can't be parsed get checksum calculated in
  software, adding performance overhead
- gso packets which can't be parsed get dropped

To mitigate the risks, the following patch will add a sysctl knob to
bypass the resolution. This is reasonable if the setup is such that
there is no protocol processing at all.

UDP tunnel headers get the same handling on the inner header.

Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.

Assisted-by: LLM
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Chris Arges <carges@cloudflare.com>
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 251 +++++++++++++++++++++++++++++++++++--
 1 file changed, 241 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..357115ff0ec2 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -5,7 +5,11 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/netdevice.h>
 #include <linux/udp.h>
+#include <net/gso.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/tcp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
@@ -48,6 +52,171 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
+/* TODO: nothing virtio specific here, move to ip.h */
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  Only the fixed header
+ * is guaranteed linear; callers that need the options or the
+ * transport header must pull further.
+ */
+static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
+						  unsigned int nhoff,
+						  unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 ||
+	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	return iph;
+}
+
+/* Where does the L3 header start, and what protocol is it?
+ * Handles Ethernet and VLAN headers; other devices use the
+ * network header offset the caller set up.
+ */
+static inline bool
+virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
+{
+	if (skb->dev->type == ARPHRD_ETHER) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return false;
+		*nhoff = ETH_HLEN;
+		*proto = eth_hdr(skb)->h_proto;
+		if (eth_type_vlan(*proto)) {
+			*proto = __vlan_get_protocol(skb, *proto, nhoff);
+			if (!*proto)
+				return false;
+		}
+	} else {
+		*nhoff = skb_network_offset(skb);
+		*proto = skb->protocol;
+	}
+	return true;
+}
+
+/* Walk the L3 header at @nhoff: where does its transport header
+ * start, and which protocol is it?  Returns false if the header
+ * is truncated, malformed or fragmented.
+ */
+static inline bool
+virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
+		    unsigned int *thoff, int *ip_proto)
+{
+	if (proto == htons(ETH_P_IP)) {
+		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
+
+		if (!iph || ip_is_fragment(iph))
+			return false;
+		*ip_proto = iph->protocol;
+		return true;
+	}
+
+	if (proto == htons(ETH_P_IPV6)) {
+		const struct ipv6hdr *iph;
+		int flags = 0;
+
+		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
+			return false;
+		iph = (const void *)(skb->data + nhoff);
+		if (iph->version != 6)
+			return false;
+		*thoff = nhoff + sizeof(*iph);
+		*ip_proto = iph->nexthdr;
+		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
+			*thoff = nhoff;
+			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
+						  &flags);
+			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
+				return false;
+		}
+		return true;
+	}
+
+	return false;
+}
+
+/* Does checksum metadata match a known TCP or UDP header? */
+static inline bool
+virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
+				     unsigned int nhoff, __be16 proto)
+{
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return false;
+
+	if (skb_checksum_start_offset(skb) != thoff)
+		return false;
+
+	switch (ip_proto) {
+	case IPPROTO_TCP:
+		if (skb->csum_offset != offsetof(struct tcphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct tcphdr)))
+			return false;
+		break;
+	case IPPROTO_UDP:
+		if (skb->csum_offset != offsetof(struct udphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct udphdr)))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	case VIRTIO_NET_HDR_GSO_NONE:
+		return true;
+	case VIRTIO_NET_HDR_GSO_TCPV4:
+		return proto == htons(ETH_P_IP) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_TCPV6:
+		return proto == htons(ETH_P_IPV6) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_UDP:
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
+		return ip_proto == IPPROTO_UDP;
+	default:
+		return false;
+	}
+}
+
+static inline bool
+virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
+{
+	int nhoff;
+	__be16 proto;
+
+	if (!virtio_net_l3_start(skb, &nhoff, &proto))
+		return false;
+
+	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
+						   proto);
+}
+
+/*
+ * Handle a packet whose checksum metadata does not match the packet:
+ * GSO packets are dropped, as segmentation needs one checksum per
+ * segment; others are completed in software.
+ *
+ * Return 1 if the checksum was completed in software, else a negative
+ * errno.
+ */
+static inline int virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
+{
+	if (skb_is_gso(skb))
+		return -EINVAL;
+
+	return skb_checksum_help(skb) ?: 1;
+}
+
 static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
@@ -158,8 +327,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		case SKB_GSO_UDP_L4:
 			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
 				return -EINVAL;
-			if (skb->csum_offset != offsetof(struct udphdr, check))
-				return -EINVAL;
 			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
 				return -EINVAL;
 			if (gso_type != SKB_GSO_UDP_L4)
@@ -167,10 +334,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 			break;
 		case SKB_GSO_TCPV4:
 		case SKB_GSO_TCPV6:
-			if (skb->ip_summed == CHECKSUM_PARTIAL &&
-			    skb->csum_offset != offsetof(struct tcphdr, check))
-				return -EINVAL;
-
 			BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GSO_MAX_SIZE);
 			gso_size = max(gso_size, TCP_MIN_GSO_SIZE);
 			break;
@@ -194,11 +357,36 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return 0;
 }
 
+/*
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
 					bool little_endian)
 {
-	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
+	typeof(skb->transport_header) old_transport = skb->transport_header;
+	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
+					  hdr->gso_type);
+
+	if (ret < 0)
+		return ret;
+
+	if (skb->ip_summed != CHECKSUM_PARTIAL ||
+	    virtio_net_csum_partial_ok(skb, hdr->gso_type))
+		return 0;
+
+	/*
+	 * Here we do not trust the checksum metadata.
+	 * __virtio_net_hdr_to_skb set the transport header to csum_start
+	 * from virtio hdr, restore it to a known good value.
+	 */
+	skb->transport_header = old_transport;
+	ret = virtio_net_resolve_csum_partial_mismatch(skb);
+
+	return ret;
 }
 
 /* This function must be called after virtio_net_hdr_from_skb(). */
@@ -282,6 +470,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
 	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
 }
 
+/* Do the tunnel offsets match the outer headers in the frame?
+ * The L3 header the tunnel claims must be the one the frame
+ * carries, with UDP following it at @outer_th.
+ */
+static inline bool
+virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
+			  unsigned int outer_th)
+{
+	int nhoff;
+	__be16 proto;
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l3_start(skb, &nhoff, &proto))
+		return false;
+	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
+		return false;
+	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return false;
+
+	return ip_proto == IPPROTO_UDP && outer_th == thoff;
+}
+
+/*
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int
 virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
@@ -293,6 +510,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
@@ -332,10 +550,13 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	    inner_th < inner_nh + inner_l3min)
 		return -EINVAL;
 
+	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
+		return -EINVAL;
+
 	/* Let the basic parsing deal with plain GSO features. */
 	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
 				      hdr->gso_type & ~gso_tunnel_type);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* In case of USO, the inner protocol is still unknown and
@@ -353,7 +574,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	}
 
 	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
+			    htons(ETH_P_IP));
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -368,7 +589,17 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	skb->inner_mac_header = inner_nh + skb_headroom(skb);
 	skb->transport_header = outer_th + skb_headroom(skb);
 	skb->encapsulation = 1;
-	return 0;
+
+	/*
+	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
+	 * set CHECKSUM_PARTIAL.
+	 */
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
+						 inner_proto))
+		return 0;
+
+	return virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* Checksum-related fields validation for the driver */
-- 
MST

