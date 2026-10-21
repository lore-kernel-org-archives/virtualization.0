Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569018;
	b=spv70x+Gx90wou78jH+mhytLtBw+ZC1Bs9XsyCpGO2N6yiqimlEoR49Rll7st2ix/xkn
	 hgnqFpRa1/N4q3+i8Ok2xs9UhFU5x+z7vlmBXjiAZxGfkIHpi/7xwrnjag1HYg196kI4K
	 G7s1UngUEuiAXQjGAQxWnt918uFIg547bVa0Mj/wWNAIdEfgHxTu1LBTOKOd3tfcfrpQa
	 moceesb7E8sIo/jTvdJAbTLVlJpNuZIsjK3mOg9MNBZ6Wtahkonv1EkDD0jJ3QJdzZx/7
	 C7OcPcxU8txnHT+MYRK1RqJn0jAgCzGkMqonczcUCszvSs5K5J0LSQMXM2VrTdCMxOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569018;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=S1Ljpx3K0TsunXTQsBg1qLfEDbRJPKA2AvrXipDaWMA=;
	b=5NJrFB9jCnEYrZNEsUAaxe1/IJn0SdksWgCsVKP5EZfdcdX1NL3aVaYtax28nxaOk5WP
	 JYLTvssSZbCcZWMGFBd54qmY6mQW2/Z+3t0RkyEnq1U6GBFY+QEr+ue7qkyHJpDNwn1lU
	 IgW1EnScnMjFMHl6CNZzqf9I0rOLx9AQX9KFNlhFI9/bF0mHwOxR1jSqxC2X3WEvf3GHE
	 l8tQGcQseRsNJPqRZT+QMz9FfYoSxjiUXfMiEp2lRzuXNnxszjUrE5NC/Aiv43NhkZYng
	 TTYTEVuDpm72+m+EYHXhTR5CQfHyWUcPK1SuA9IKUQ0DELTayzIyx7yBWx3GVF5pMVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBBChtOl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D9606A320
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F5D9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBBChtOl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1Ljpx3K0TsunXTQsBg1qLfEDbRJPKA2AvrXipDaWMA=;
	b=IBBChtOlP2ulrvpK6dfs8ODxDYhf+wthcP/N3/+B41IWrXBueBiJU2viGBBppgS65MpIVg
	h9/pViDIpjK7pJGaeUPcgY8LtZroDC4VlPYOfItOSSlUm7H8BZG+1tRCqhUurh/TITHD5P
	EV+1njJvWdVpHK3h3L8aqwlRNttMu+o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-ElWw9f5mN7yhWtAGVW8WiQ-1; Wed, 21 Oct 2026 03:50:10 -0400
X-MC-Unique: ElWw9f5mN7yhWtAGVW8WiQ-1
X-Mimecast-MFC-AGG-ID: ElWw9f5mN7yhWtAGVW8WiQ_1792569007
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a2001e85c8so1030385e9.1
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569006; x=1793173806;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1Ljpx3K0TsunXTQsBg1qLfEDbRJPKA2AvrXipDaWMA=;
        b=QULhSw7JKlWhOc9wM0yEAx9dvEHF/J+ZxS0jck/wUgxEahaQ8s549kIm318ehockTv
         EXBzrg8nxOIq7rnZGi4O0gzGiP5+68oKeFFa1KjixbQUEd9Zu/zDeylJOWMiGzNMot6l
         q3fnox4ydxrroDTKg21B+ICy2j7ZUeS5trPW10RADhD80n7gxcojPJfKtyqsZ/kKP2SL
         DZZe5BsoQeZwqmeSiHbywuvKbuZlZM9E5eIRM4u4tSAsMIUVLNiVTaZANU9pJ+pfzivu
         2UACpEP3ZnER6p3+/Owx9JnMyOlCVQKpUgia2H4Z4Vp+tyoVT9+/ZIUSZDzidRO7N7bC
         9O2A==
X-Forwarded-Encrypted: i=1; AKwUvByIlKfJoAFZzo2lgGSFIg/mIpjQhSy4Z54/9J3A1QoRTDRNP/NfwGRznf19qvkJmUMtdIoEKe9erSxQmgobvw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLb1NaHRt19jypnGODnXFfM35Gw8fsiOkIbmepU2YOtWPwGRkHt
	LVlrpst+rW9pYeuAzNfjTvEx81SQWew47TLEs/cHfV8JcF95m5E8i7nyhQGsN7ci1eYGblV4wAq
	bvnOzPEouaYQ/N9bSbJUc1mO9g7C+ABBXws2Nuc2oMFdrsb+RMnUObVxGbAaSvGG0tfUg
X-Gm-Gg: AYBFou1+IsasjALZdjTO3PFph3HkNOh9ujCIHOUdCibtwrDJ/2sMLlofgbLT58kpGMv
	VF/i4WenkcbJrCA4X9h4R19nM9gY6oANRfw74I8RUNnfSPxv18uAZPp8W0Pp+icZs7CKznsU0dq
	5GkVLA+9xa3+U9KARKymppIKXp6ZAeKMdZ63QU+soR27Gisv79qjSxEhn9w4dWxf0V0kGKRLbOh
	9v7fZtKXezFVg1fKZEwDOMAzSaP9NRnGg6gOWVUgm925suFrubGAkYYOZWhkZ7Y1qgVHaRt5c7q
	fvWBDFbORVOVsXtQl2XdlXv2xSUsKg3Deh0pqxu9zPlr/x+yf+gX+FqXRFfeq5QSWkPQ8g==
X-Received: by 2002:a05:600c:e557:20b0:49e:74b6:740f with SMTP id 5b1f17b1804b1-4a1fdd20e2bmr13155775e9.17.1792569006284;
        Wed, 21 Oct 2026 00:50:06 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:20b0:49e:74b6:740f with SMTP id 5b1f17b1804b1-4a1fdd20e2bmr13155225e9.17.1792569005712;
        Wed, 21 Oct 2026 00:50:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm106175985e9.7.2026.10.21.00.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:50:04 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:50:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: [PATCH net v4 4/7] net: resolve uncommon partial checksums at ingress
Message-ID: <5de86f1afe1165a1a13ac4ef0615b19f4a10cb7a.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: --pS8uk-m3ujwUT0lxy21RBskmaOW_6QTg8B1qq8stU_1792569007
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

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Chris Arges <carges@cloudflare.com>
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/tap.c          |   8 +-
 drivers/net/tun.c          |   8 +-
 drivers/net/virtio_net.c   |   3 +-
 include/linux/virtio_net.h | 276 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 281 insertions(+), 14 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d7520622e809..f2a9bb443980 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -653,9 +653,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
 			goto err_kfree;
-		}
-		if (err > 0)
+		} else if (err > 0) {
 			atomic64_inc(&tap->rx_csum_sw);
+		}
 	}
 
 	skb_probe_transport_header(skb);
@@ -1089,9 +1089,9 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 		if (err < 0) {
 			rcu_read_unlock();
 			goto err_kfree;
-		}
-		if (err > 0)
+		} else if (err > 0) {
 			atomic64_inc(&tap->rx_csum_sw);
+		}
 	}
 
 	skb_probe_transport_header(skb);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 19cb443c89b0..197fb8726f8d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1941,8 +1941,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
-	}
-	if (err > 0) {
+	} else if (err > 0) {
 		atomic64_inc(&tun->rx_csum_sw);
 		err = 0;
 	}
@@ -2617,9 +2616,10 @@ static int tun_xdp_one(struct tun_struct *tun,
 		kfree_skb(skb);
 		ret = -EINVAL;
 		goto out;
-	}
-	if (ret > 0)
+	} else if (ret > 0) {
 		atomic64_inc(&tun->rx_csum_sw);
+		ret = 0;
+	}
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
 	skb_reset_network_header(skb);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b0441bf8e875..5821ddabde80 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2529,8 +2529,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 				     hdr->hdr.gso_size, hdr->hdr.flags,
 				     vi->rx_tnl, vi->rx_tnl_csum);
 		goto frame_err;
-	}
-	if (ret > 0) {
+	} else if (ret > 0) {
 		u64_stats_update_begin(&rq->stats.syncp);
 		u64_stats_inc(&rq->stats.rx_csum_sw);
 		u64_stats_update_end(&rq->stats.syncp);
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 013c6c7e2dea..ec6f47ce1c97 100644
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
@@ -48,6 +52,202 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
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
+	/* skb->dev is only guaranteed to be set since 44378d02c5aa
+	 * ("net: always dissect GSO packets in
+	 * __virtio_net_hdr_to_skb()"), do not crash when it is not.
+	 */
+	if (WARN_ON_ONCE(!skb->dev))
+		return false;
+
+	/* Loopback carries ethernet frames, too:
+	 * loopback_xmit() calls eth_type_trans() on them.
+	 */
+	if (skb->dev->type == ARPHRD_ETHER ||
+	    skb->dev->type == ARPHRD_LOOPBACK) {
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
+		/* An unset network header shows up as an offset
+		 * outside of the packet.
+		 */
+		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
+			return false;
+		*proto = skb->protocol;
+		if (!*proto) {
+			const struct iphdr *iph;
+
+			/* A packet socket bound to ETH_P_ALL leaves the
+			 * protocol unset: infer it from the IP version
+			 * at the network header.
+			 */
+			if (!pskb_may_pull(skb, *nhoff + 1))
+				return false;
+			iph = (const struct iphdr *)(skb->data + *nhoff);
+			if (iph->version == 4)
+				*proto = htons(ETH_P_IP);
+			else if (iph->version == 6)
+				*proto = htons(ETH_P_IPV6);
+		}
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
+			/* Find the transport header behind any
+			 * extension headers, AH included.
+			 */
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
+ */
+static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
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
@@ -194,11 +394,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
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
+
+	return __virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* This function must be called after virtio_net_hdr_from_skb(). */
@@ -282,6 +506,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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
@@ -293,6 +546,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
@@ -335,9 +589,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	/* Let the basic parsing deal with plain GSO features. */
 	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
 				      hdr->gso_type & ~gso_tunnel_type);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
+	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
+		return -EINVAL;
+
 	/* In case of USO, the inner protocol is still unknown and
 	 * `inner_isv6` is just a guess, additional parsing is needed.
 	 * The previous validation ensures that accessing an ipv4 inner
@@ -353,7 +610,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	}
 
 	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
+			    htons(ETH_P_IP));
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -368,7 +625,18 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
+	/* A tunnel header implies GSO, so drop. */
+	return -EINVAL;
 }
 
 /* Checksum-related fields validation for the driver */
-- 
MST

