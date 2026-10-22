Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680749;
	b=esmIHZH1tQpz1hipJM/np/E0wOl5uCdI5+8Q82+LGn6jFv0NCAnGPdMasfsiDyp92BNZ
	 51uzhpgqt1oR/Z2kCxBWWeOtpfA3dc4d3KSuL0McMgPH4yLf1mqLncYEqhCZqeTIYkOOG
	 /P28macG6TG1yWSidL+d2Isc1VRmnoHZHbSImV62EhkYKeyDCrEfqYMkOR2xxfKsPmKzc
	 jpM+ZFSMvU+w5U9OzT5CuuHLaEUE+7zdpsC+jkYv3pNHxucn/jCUYqxGaxcVS3F7O0nun
	 0jSvypiPsq9a8GBY59tcyM1KHnBjv47szIErUVkgwG1NxguMVmG3xhJLs3IOnC9Lpqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zz3vJ+tdljdortEYQn2RoJm5sKkXNeTDkPHmzvrfEm4=;
	b=DSiQ205ro/Lrk1VBibqqoCsgVbH67OOjT8DTgnaVrES+a401Saw4nmnReNZK0wTRM1SG
	 U7wzcLoLVXArUwS1HGnChz8Pn1gAuyRodFU2k3ivSGzzxARnwp3umHL6nNHnS8gPo1qk3
	 be2cdZ6oSefmX5PLyI1uWDNfI+3NZufBLNsRpEN33dYibyVGHI+GV4bhyp9sa8e7gd2tU
	 1veEhAtKAMpmcPYywth8mF2oPaJeR5qE5NdfXpcLfqXAnUXXaReNmDtI41aKI+kJ7PNbZ
	 KjnQPFh/L437uWgaXNC+38obM1AxUxuSj7kIIUyXyQ/jKFOd4NZ/gafF8WJPQtRFNWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D50gnIlw;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3F606A31B
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 14:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC3F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D50gnIlw
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1469882e0c.0
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680747; x=1793285547; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zz3vJ+tdljdortEYQn2RoJm5sKkXNeTDkPHmzvrfEm4=;
        b=D50gnIlwGu9mXIQgl4rERgL+cinG2wh1tJ5JlWdKddDgkA4OGC2HrI0qJha0vn2hWN
         J6yM0TaoXP7Cyxleiq7hjqdXqOLYuX9rV/hS5VDdc63K36d/zWDNp0bD/WfrYforFrz8
         gshcx+KSEmlhG5iIOcL5i3VWvmrSgvR4DkIbz5QgwFRFMGCF2PqOBCeU2m/egIh4HwdQ
         zlA/Xi4DlaM4OyGYpxPVglIFYU39EQ9uaaIXEwioWm9yFyhYz7FYO35PQUkKPB0AwQbf
         YBaT/PLfBQ1RAyRcS6drHte/bi+98BWC0vP2UGuBniBJRZMlKqb8sCE1DzUCjQ94Ry4e
         TBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680747; x=1793285547;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zz3vJ+tdljdortEYQn2RoJm5sKkXNeTDkPHmzvrfEm4=;
        b=TkZ1ULFpoLVT78ea2DxF4b+ORaNUdHzxt6soSVH32+qc66x0aK8J62xEwADh9s09Mw
         VaE5/AubW4SDHvKbVuenktO90kOaQTqa1glwr7VAxdHjgCTnHm+H46KcBtm+TztyGJgY
         bj1LTcPnbF4HQFhJu/yiX2aCfgEr2bYdJdY47ECkBgoEPEBwDJ1r6GshWSX4BfEAJjup
         o0zH3tRIa1urlJN/4jyBaYdsVIXQNbRyFNhEcfhy4oJ0RdYSmyM6wmfb3f3TBh4T+5bn
         MMFGmYTz6EbAA+YhQyf2lcDs3A3LS5FpldV8ABZwtOoSTGjOQ8zjppARO/50SsLg3Rb8
         CK5w==
X-Forwarded-Encrypted: i=1; AKwUvBy4qWUVXo5rkiXU0qe8rwc3sRyY7XBQwWVDnGI1w7Fzk++4fWOqfyhluNeZjcRjtaMfXjWdS0aPx9kV+FeyOA==@lists.linux.dev
X-Gm-Message-State: AFq9FYK3tcqmhk/W4RFpAX6xY7zvLyrvRVORk7wlMZzZHQcNAhfN9+yZ
	gAKFi7zM6g8KnnQu3YmBsOXmLR/Y/XbdhwThZlRBBiim4MxuE+MhWWGD
X-Gm-Gg: AYBFou2U4EKL4OzcgONjHGht6eyYvQQOS1s9dHuY0AMB7CJXE/3/sbwgr+FVaKuy5q3
	2FKC28AV4ONGod9tt6e3/PZHklPTbodKtH21buQzf0VAbU8PdPP58SgF3DU3NsAYSERkAaWQpms
	cf5XMu/ijuMsLS7auEOtpvYixBXjkuShV5tnoyOva/Pjwlb1D83xg07pZ4FrcQtT7Hde8vDSbEt
	3TAGOtDOTaFgh9muOlAM3m68/phFh8KGJq7KK9ad2rmf+e6GRGWJao39ix4pqqUZRMeRUCIqmcH
	woeTwalzodH15UwHlK6uekwQqhMAK42LIqfeEqorw/hXUiYoE87ZNVdQ1UT8bEkiIGHByvQ0tmd
	8EEDp4rxSWQMuMQaE/El5GKBxm8SjJERD7Pqtp1Y7yo3lSDfe/q65TOLLvA4UsoXtOkVNQ9cYxu
	SSrM3XKXiC1R6gWblHRfZIhLP5pG1uXL1PlhTFnYLox8zHlwdUwXDpYuWAsJrxe/Fa2wOHIUKEh
	T04gQV1CeT7hFiigrs4OJPqrlqK2aR6uxxJ0BS+MRV39uuISxBR7soQRdlFMGhxIrZtVz+imF3K
	Kpf7MRLjdJoIaHgGx024jgB1ttk8vJMS0AcWjJbu8/Ec39EsNdd25TxomFEmvGsIQLt0xq+KAhr
	I+rE7icmyyiNmk5iIkfc=
X-Received: by 2002:a05:6122:488f:b0:5e9:731b:850a with SMTP id 71dfb90a1353d-5eaebe17275mr2877249e0c.11.1792680746890;
        Thu, 22 Oct 2026 07:52:26 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97be404sm7084683e0c.7.2026.10.22.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:52:26 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:52:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Paulos Yibelo <habte.yibelo@gmail.com>
Message-ID: <willemdebruijn.kernel.2987fc5710162@gmail.com>
In-Reply-To: <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
Subject: Re: [PATCH net v5 4/7] net: resolve uncommon partial checksums at
 ingress
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users) a
> virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> If that state is retained, later checksum completion can modify the
> packet after protocol processing has made decisions from it.
> 
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
> 
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that shouldn't happen.
> 
> There's some risk here:
> - non-gso packets which can't be parsed get checksum calculated in
>   software, adding performance overhead
> - gso packets which can't be parsed get dropped
> 
> Note that for zero copy, userspace can change the data after the
> checksum has been calculated.  This is fundamental to zero copy by
> design, and the only outcome is a bad checksum and a packet drop.
> 
> To mitigate the risks, the following patch will add a sysctl knob to
> bypass the resolution. This is reasonable if the setup is such that
> there is no protocol processing at all.
> 
> UDP tunnel headers get the same handling on the inner header.
> 
> Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> 
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Chris Arges <carges@cloudflare.com>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Notes (changelog):
>     v4->v5:
>         caller changes moved to "account for ingress-resolved
>         virtio net hdr state" (Willem de Bruijn)
>         a packet too small to be GSO: ignore the tunnel GSO request,
>         complete wild metadata in place (sashiko)
>         document the zero copy interaction (sashiko)
>         honor a preset skb->protocol on ethernet: the stack uses it,
>         except on loopback which re-parses the frame (sashiko)
> 
>  include/linux/virtio_net.h | 283 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 279 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea..52852a33a2db 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -5,7 +5,11 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/netdevice.h>
>  #include <linux/udp.h>
> +#include <net/gso.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/tcp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
> @@ -48,6 +52,205 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/* TODO: nothing virtio specific here, move to ip.h */
> +
> +/*
> + * Pull and minimally validate the IPv4 header at @nhoff.
> + * Returns the header and stores the transport header offset in
> + * @thoff, or NULL if truncated or malformed.  Only the fixed header
> + * is guaranteed linear; callers that need the options or the
> + * transport header must pull further.
> + */
> +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> +						  unsigned int nhoff,
> +						  unsigned int *thoff)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph = (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version != 4 ||
> +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> +		return NULL;
> +

Pulling again if ihl != 0 should probably have been here too.

Else we have to verify that all callers safely pull. Note that
iph will become stale after another pull.

> +	*thoff = nhoff + iph->ihl * sizeof(u32);
> +	return iph;
> +}
> +
> +/* Where does the L3 header start, and what protocol is it?
> + * Handles Ethernet and VLAN headers; other devices use the
> + * network header offset the caller set up.
> + */
> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	/* skb->dev is only guaranteed to be set since 44378d02c5aa
> +	 * ("net: always dissect GSO packets in
> +	 * __virtio_net_hdr_to_skb()"), do not crash when it is not.
> +	 */
> +	if (WARN_ON_ONCE(!skb->dev))
> +		return false;
> +
> +	/* A preset protocol is what the stack will use, except on
> +	 * loopback which re-parses the frame: loopback_xmit() calls
> +	 * eth_type_trans() on it.
> +	 */
> +	if (skb->dev->type == ARPHRD_ETHER ||
> +	    skb->dev->type == ARPHRD_LOOPBACK) {
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = skb->protocol;

Why this change now?

skb->protocol cannot be trusted (to be consistent with actual packet
content).

Express goal is to take the actual packet content instead of relying
on this spoofable field.

On top of that there are issues around setting protocol to IP and
inserting VLAN headers. That would skip the eth_type_vlan branch.

IMHO, we should only use skb->protocol if no other source to detect
protocol exist, i.e., if no L2 header exists.

Also, instead of preferring one over the other, we could actually
read both and

    if (skb->protocol &&
        skb->protocol != eth_hdr(skb)->h_proto)
            return false;


> +		if (!*proto || skb->dev->type == ARPHRD_LOOPBACK)
> +			*proto = eth_hdr(skb)->h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		*nhoff = skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
> +			return false;
> +		*proto = skb->protocol;

Same

> +		if (!*proto) {
> +			const struct iphdr *iph;
> +
> +			/* A packet socket bound to ETH_P_ALL leaves the
> +			 * protocol unset: infer it from the IP version
> +			 * at the network header.
> +			 */
> +			if (!pskb_may_pull(skb, *nhoff + 1))
> +				return false;
> +			iph = (const struct iphdr *)(skb->data + *nhoff);
> +			if (iph->version == 4)
> +				*proto = htons(ETH_P_IP);
> +			else if (iph->version == 6)
> +				*proto = htons(ETH_P_IPV6);
> +		}
> +	}
> +	return true;
> +}
> +
> +/* Walk the L3 header at @nhoff: where does its transport header
> + * start, and which protocol is it?  Returns false if the header
> + * is truncated, malformed or fragmented.
> + */
> +static inline bool
> +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> +		    unsigned int *thoff, int *ip_proto)
> +{
> +	if (proto == htons(ETH_P_IP)) {
> +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> +
> +		if (!iph || ip_is_fragment(iph))
> +			return false;
> +		*ip_proto = iph->protocol;
> +		return true;
> +	}
> +
> +	if (proto == htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags = 0;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph = (const void *)(skb->data + nhoff);
> +		if (iph->version != 6)
> +			return false;
> +		*thoff = nhoff + sizeof(*iph);
> +		*ip_proto = iph->nexthdr;
> +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> +			*thoff = nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers, AH included.
> +			 */
> +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);
> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* Does checksum metadata match a known TCP or UDP header? */
> +static inline bool
> +virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
> +				     unsigned int nhoff, __be16 proto)
> +{
> +	unsigned int thoff;
> +	int ip_proto;
> +
> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	if (skb_checksum_start_offset(skb) != thoff)
> +		return false;
> +
> +	switch (ip_proto) {
> +	case IPPROTO_TCP:
> +		if (skb->csum_offset != offsetof(struct tcphdr, check) ||
> +		    !pskb_may_pull(skb, thoff + sizeof(struct tcphdr)))
> +			return false;
> +		break;
> +	case IPPROTO_UDP:
> +		if (skb->csum_offset != offsetof(struct udphdr, check) ||
> +		    !pskb_may_pull(skb, thoff + sizeof(struct udphdr)))
> +			return false;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +	case VIRTIO_NET_HDR_GSO_NONE:
> +		return true;
> +	case VIRTIO_NET_HDR_GSO_TCPV4:
> +		return proto == htons(ETH_P_IP) && ip_proto == IPPROTO_TCP;
> +	case VIRTIO_NET_HDR_GSO_TCPV6:
> +		return proto == htons(ETH_P_IPV6) && ip_proto == IPPROTO_TCP;
> +	case VIRTIO_NET_HDR_GSO_UDP:
> +	case VIRTIO_NET_HDR_GSO_UDP_L4:
> +		return ip_proto == IPPROTO_UDP;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool
> +virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
> +{
> +	int nhoff;
> +	__be16 proto;
> +
> +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> +		return false;
> +
> +	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
> +						   proto);
> +}
> +
> +/*
> + * Handle a packet whose checksum metadata does not match the packet:
> + * GSO packets are dropped, as segmentation needs one checksum per
> + * segment; others are completed in software.
> + */
> +static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
> +{
> +	if (skb_is_gso(skb))
> +		return -EINVAL;
> +
> +	return skb_checksum_help(skb) ?: 1;
> +}
> +
>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
>  					  bool little_endian, u8 hdr_gso_type)
> @@ -194,11 +397,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/*
> + * Return value:
> + * 0 - success
> + * >0 - checksum was completed in software (slow path)
> + * <0 - failure
> + */
>  static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					const struct virtio_net_hdr *hdr,
>  					bool little_endian)
>  {
> -	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> +	typeof(skb->transport_header) old_transport = skb->transport_header;
> +	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> +					  hdr->gso_type);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (skb->ip_summed != CHECKSUM_PARTIAL ||
> +	    virtio_net_csum_partial_ok(skb, hdr->gso_type))
> +		return 0;
> +
> +	/*
> +	 * Here we do not trust the checksum metadata.
> +	 * __virtio_net_hdr_to_skb set the transport header to csum_start
> +	 * from virtio hdr, restore it to a known good value.
> +	 */
> +	skb->transport_header = old_transport;
> +
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }
>  
>  /* This function must be called after virtio_net_hdr_from_skb(). */
> @@ -282,6 +509,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* Do the tunnel offsets match the outer headers in the frame?
> + * The L3 header the tunnel claims must be the one the frame
> + * carries, with UDP following it at @outer_th.
> + */
> +static inline bool
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> +			  unsigned int outer_th)
> +{
> +	int nhoff;
> +	__be16 proto;
> +	unsigned int thoff;
> +	int ip_proto;
> +
> +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> +		return false;
> +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> +		return false;
> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> +}
> +
> +/*
> + * Return value:
> + * 0 - success
> + * >0 - checksum was completed in software (slow path)
> + * <0 - failure
> + */
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -293,6 +549,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	unsigned int inner_nh, outer_th, inner_th;
>  	unsigned int inner_l3min, outer_l3min;
>  	u8 gso_inner_type, gso_tunnel_type;
> +	__be16 inner_proto;
>  	bool outer_isv6, inner_isv6;
>  	int ret;
>  
> @@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
>  				      hdr->gso_type & ~gso_tunnel_type);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> @@ -353,7 +613,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	}
>  
>  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +			    htons(ETH_P_IP));
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
>  	skb->transport_header = outer_th + skb_headroom(skb);
>  	skb->encapsulation = 1;
> -	return 0;
> +
> +	if (!skb_is_gso(skb))
> +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> +					       SKB_GSO_UDP_TUNNEL);
> +
> +	/*
> +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> +	 * set CHECKSUM_PARTIAL.
> +	 */
> +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);

on second thought, if having to respin, might as well fold the trivial
fix in patch 7 in here from the start.

> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +						 inner_proto))
> +		return 0;
> +
> +	/* A tunnel header implies GSO, so drop. */

no longer true for the above !skb_is_gso(skb) case

> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }
>  
>  /* Checksum-related fields validation for the driver */
> -- 
> MST
> 


