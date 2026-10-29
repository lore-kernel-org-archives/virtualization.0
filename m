Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300024;
	b=Ru9ohqpePFPiQaZjAQb8uIHV+1UXv7sPdtQYo0Ky1XCTuZ8axbMXIsZoBQVdQlBE0G9J
	 ceeGYQhX5rMe0pfJX4uL9SpJ/St1N/7KYwE2zAa/VlnsDXwukPeiRMJIsP9dLXO7cK2M+
	 3X1uzfRJhKQZe+mUVHRS09T9QRq+s0NFSQg/ZB+a/bcKgm3gPslbXs5zVktbkEI4ZiZa6
	 1tZUpkYUP9Vfziqx7dVUM78Xy4AeCsZvjH4r/EJbvbBB9lak2fWsItbgV8aGXnLlRtr0/
	 rvizcaPjq/WKjsUmkfunH3EpbqdenWcLa1k9R4PPLDUixGycaY0lnVCxfoQQQy7tKvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300024;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=GWHJa30NvpHFcdORWxMkcfi3m9qWOqJ+EwiPEmpjASg=;
	b=iPBPi02vFwikq5YaMyzNNnEgvcfIWs/Cas5nmY5/bdPqDk1RQcsXaNZYKbgeUXsOJyju
	 TpY/uWw/QGcruSItI0EawAsrVWMptHM+OjkyDEIEMw2zhv7GciHDDc+2gy9BtO4GX0GxO
	 kC2lk40zYp5i1PMuijpTCCeIHs7eonNlqiNT3so3vllBTH1rCxaqgdmIUTAOv6MS8a3v6
	 XENVEOWJT6hPchbXAPJbQ65sPfyzC+Dv/jI9yxNT73QPWSSYHoUbJrY28j46DtjhW91bN
	 /uWHPmwzm5/2D7zbFTGxqjjcQsFfTnl/l+uTt1zqdD5p5K9awQ5BBQGyLC69OvukZWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6tFpnQ6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D8606A32F
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 18:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 584D8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6tFpnQ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWHJa30NvpHFcdORWxMkcfi3m9qWOqJ+EwiPEmpjASg=;
	b=B6tFpnQ6n7BidFB2S6m7vLG8Q8xaOt1azCQZP+Xi7ByhVC8M9PnXk1LyCpOszSwl/cTFr0
	TxiZucVZeE9SIdLsT/dpPnTAZFf/lwmfWrHgiKBkqTTsbSjzLOzJmqyf1UJEJqjcgVCEZF
	hwX1YRxfEXXqt5QdL+VqR1gveLGN3Gs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ZXmB4vRmMcOtHzT1QCTeRw-1; Thu, 29 Oct 2026 14:53:40 -0400
X-MC-Unique: ZXmB4vRmMcOtHzT1QCTeRw-1
X-Mimecast-MFC-AGG-ID: ZXmB4vRmMcOtHzT1QCTeRw_1793300020
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df5b058ddso1666514f8f.0
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 11:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300020; x=1793904820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWHJa30NvpHFcdORWxMkcfi3m9qWOqJ+EwiPEmpjASg=;
        b=czznWuZ1nBY1c2c/KG3rRk0sejY1yRhLtYI3DbSMWrJx0VR7IFP39xN3pqc/Z8SJAm
         g1ZbSqRDTSCukTPpqfsIjgzEUved9i7ET1BQvv1T3uEnOG6gcVsaGiSV4turifYlviXR
         75zVCobYJDoUfZzEkArdqbQYKTSgFc+4P3eQ5rUs6Iey9ixfJEOTQphKKQMw/1sex/My
         Yduhd2M25jFrU/ZulOElkAeQZnibzvVntSV8fx05izyNGIOlXRcswocjAwgorE3sYQ/a
         7mdxzMJxEoiXTd+Em9M5rJhwp4NY4oa2/2+OEsdJYXQvNjUVbHgeHS3ySx1/QBknG3yt
         1+oQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdj998X4GbsaAB8QqPIR5pBtcnsMRcEbO5qo3eyoT27Av6Y+Y0umx7cD6oCA6BGLOCvsHP6tcZ50uqzCskYQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKn5LEX6DsQrEAQPL8hv8753uB6VVrNsWpwIbC8dcLz+aiSoCnP
	ThSa01dmq4CPvBQX6cUBGqo+VqtwhAOndQNII/3AtX+iTxgKunoOyxiWBKUxbVddarGqwbSdXME
	5PqcwqSJRLC/JK6J6miTuP8Q8tARORoU2H0ebomWx6Icoj7HRyE8b3RJ3QUrHkib94Ajn
X-Gm-Gg: AYBFou36Ffp+lsDEEG9Hux69lDMoyxhUeRwb8Wbu1YS/TMx9tCBHKNhSMZAj4KwntEz
	7WBr+y7q3KhGueY0FpIjTxcq5JGYsV9ccpBKXgqDxYwumJGvepOG/sp9oiyo/X3+GWSJJXL7tUB
	Sm7neoik72eOc9p8FmZ5zOcgPnYOySIumsThhwW2hnq9mdQimyLNnppwSTyQZ2ym8TWdZWHuYiW
	IE57IpS2Td+gDnKxCKEowC99QyMBaqMrbdAbRk+zXn0Frh8El+xgpbNTYUXccj3P9D+Zd2fuVvE
	JOczcSOYsbv74NfcNri5TNnEPX9ZvPhdBZJIMcYs7NqkCyG9yDrkDkuV0fPJuqpzeJH2BPN2XqC
	qUnH5KmAhYchAeECghzLP68U/ytInhJtE/XuVkoJtJWFs
X-Received: by 2002:a05:6000:2893:b0:48e:bf0:352 with SMTP id ffacd0b85a97d-48e6e2bf319mr790399f8f.5.1793300019274;
        Thu, 29 Oct 2026 11:53:39 -0700 (PDT)
X-Received: by 2002:a05:6000:2893:b0:48e:bf0:352 with SMTP id ffacd0b85a97d-48e6e2bf319mr790348f8f.5.1793300018696;
        Thu, 29 Oct 2026 11:53:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb73848sm203491f8f.17.2026.10.29.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:36 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:34 -0400
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
Subject: [PATCH RFC v7 4/5] net: resolve uncommon partial checksums at ingress
Message-ID: <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1793276116.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8_JQzJP5Rsxa4sP4LugosDsVNxwVPNGgjq7Uq377dOM_1793300020
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

Note that for zero copy, userspace can change the data after the
checksum has been calculated.  This is fundamental to zero copy by
design, and the only outcome is a bad checksum and a packet drop.

To mitigate the risks, the following patch will add a sysctl knob to
bypass the resolution. This is reasonable if the setup is such that
there is no protocol processing at all.

UDP tunnel headers get the same handling on the inner header.

Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.

Note a fundamental limitation of this approach: an nf/BPF program
that tweaks the payload of a packet in flight may rely on the
checksum being fixed up later, assuming the packet carries
CHECKSUM_PARTIAL.

For metadata that fails validation the checksum
is now completed at input, so such edits leave a stale checksum
and the packet is dropped at the receiver.  Protocols whose
transport header we cannot parse (anything but TCP and UDP) are
affected even when the metadata is self-consistent.

The sysctl added in the next patch is the escape hatch for these setups,
but it is a very blunt tool.

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Chris Arges <carges@cloudflare.com>
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v4->v5:
        caller changes moved to "account for ingress-resolved
        virtio net hdr state" (Willem de Bruijn)
        a packet too small to be GSO: ignore the tunnel GSO request,
        complete wild metadata in place (sashiko)
        document the zero copy interaction (sashiko)
        honor a preset skb->protocol on ethernet: the stack uses it,
        except on loopback which re-parses the frame (sashiko)
    v5->v6:
        read both skb->protocol and the frame ethertype: do not
        validate when they disagree, instead of preferring the
        preset protocol; same check after the IP version inference
        where there is no L2 header (Willem de Bruijn)
        pull the IPv4 options in the helper as introduced, with the
        transport header offset computed before the pull
        (Willem de Bruijn)
        fold the trivial protocol calculation cleanup, formerly a
        separate patch, in (Willem de Bruijn)

 include/linux/virtio_net.h | 315 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 311 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 013c6c7e2dea..54048759cc6e 100644
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
@@ -48,6 +52,216 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
+/* TODO: nothing virtio specific here, move to ip.h */
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  The whole header,
+ * options included, is guaranteed linear on return.
+ */
+static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
+						  unsigned int nhoff,
+						  unsigned int *thoff)
+{
+	unsigned int ihl;
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
+	ihl = iph->ihl * sizeof(u32);
+	*thoff = nhoff + ihl;
+	/* Pull the options as well: the transport header offset
+	 * returned above must be within the linear data.  iph goes
+	 * stale across the pull.
+	 */
+	if (!pskb_may_pull(skb, nhoff + ihl))
+		return NULL;
+
+	return (struct iphdr *)(skb->data + nhoff);
+}
+
+/* Where does the L3 header start, and what protocol is it?
+ * Handles Ethernet and VLAN headers; other devices use the
+ * network header offset the caller set up.
+ */
+static inline bool
+virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
+{
+	/* skb->dev should always be set here already,
+	 * but let's not crash when it is not.
+	 */
+	if (WARN_ON_ONCE(!skb->dev))
+		return false;
+
+	if (skb->dev->type == ARPHRD_ETHER ||
+	    skb->dev->type == ARPHRD_LOOPBACK) {
+		__be16 h_proto;
+
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return false;
+		h_proto = eth_hdr(skb)->h_proto;
+		/* skb->protocol is a sender claim, and parts of the
+		 * stack parse the packet per it: when it disagrees with
+		 * the frame we do not know which view the packet will
+		 * be parsed as, so do not validate.
+		 */
+		if (skb->protocol && skb->protocol != h_proto)
+			return false;
+		*nhoff = ETH_HLEN;
+		*proto = h_proto;
+		if (eth_type_vlan(*proto)) {
+			*proto = __vlan_get_protocol(skb, *proto, nhoff);
+			if (!*proto)
+				return false;
+		}
+	} else {
+		const struct iphdr *iph;
+
+		*nhoff = skb_network_offset(skb);
+		/* An unset network header shows up as an offset
+		 * outside of the packet.
+		 */
+		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
+			return false;
+		/* No L2 header to cross-check with: take the protocol
+		 * from the IP version at the network header.
+		 */
+		if (!pskb_may_pull(skb, *nhoff + 1))
+			return false;
+		iph = (const struct iphdr *)(skb->data + *nhoff);
+		if (iph->version == 4)
+			*proto = htons(ETH_P_IP);
+		else if (iph->version == 6)
+			*proto = htons(ETH_P_IPV6);
+		else
+			return false;
+		if (skb->protocol && skb->protocol != *proto)
+			return false;
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
@@ -194,11 +408,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
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
+	if (likely(skb->ip_summed != CHECKSUM_PARTIAL ||
+		   virtio_net_csum_partial_ok(skb, hdr->gso_type)))
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
@@ -282,6 +520,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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
@@ -290,9 +557,11 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  bool little_endian)
 {
 	const struct virtio_net_hdr *hdr = (const struct virtio_net_hdr *)vhdr;
+	typeof(skb->transport_header) old_transport = skb->transport_header;
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
@@ -335,9 +604,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
@@ -352,9 +624,29 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+
+	/*
+	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
+	 * set CHECKSUM_PARTIAL.
+	 */
+	if (unlikely(!virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type,
+							  inner_nh,
+							  inner_proto))) {
+		/* __virtio_net_hdr_to_skb set the transport header to
+		 * csum_start, restore it to a known good value.
+		 */
+		skb->transport_header = old_transport;
+
+		return __virtio_net_resolve_csum_partial_mismatch(skb);
+	}
+
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
+		/* Checked here, after the validation: a packet completed
+		 * in software never uses the feature, so an unnegotiated
+		 * request only matters for metadata good enough to act on.
+		 */
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
 
@@ -368,6 +660,21 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	skb->inner_mac_header = inner_nh + skb_headroom(skb);
 	skb->transport_header = outer_th + skb_headroom(skb);
 	skb->encapsulation = 1;
+
+	if (!skb_is_gso(skb)) {
+		/* Too small to segment: complete the checksum in place
+		 * instead of dropping - senders do tag small packets
+		 * with GSO headers, e.g. packetdrill sets gso_type and
+		 * gso_size with --mss, whatever the packet size.
+		 * The outer UDP checksum is not calculated, but a zero
+		 * one is fine: UDP over IPv4 allows a disabled
+		 * checksum, and so do tunnels over IPv6 where the
+		 * receiver opts in (RFC 6935, RFC 6936).
+		 */
+		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
+					       SKB_GSO_UDP_TUNNEL);
+	}
+
 	return 0;
 }
 
-- 
MST

