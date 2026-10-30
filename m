Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395736;
	b=NQTct2RGl8grQfTSHusrWieSpzYzY2SdNqZtyrGG13XdCAzKLNONHci3R3e8OG7tsErv
	 U+Nv3asMe6V5VBD2UTIFSEO6oWTg4+MxiObgXGa3SmyLHXVGU6LeEvSw6+sEgrBgVOL6M
	 G3EQiomgm3ztQhHMFE1TluJtNOcfXmPaxs0zhPEUfXvberNC34N8uULaZAtKxCFkhZWsR
	 I+AUCNwbTj7IHkhZezMwTrUfObMwwO5G3buvVtmpVIdnQTltMnCCKIu1aBpxaiCmlyo6x
	 WQpx8WV90sEX+zyupSIQJfytWdi5oCiGEXOwlgSqQKp49rpnUvz95XMPUSEJyLKoM3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VAC2gRysazALbkHLgOMIEvbY+EZby3ybWz+RCk1jtS4=;
	b=5NNe26iyrbjClT9ranlLsSUjN0UulCxjWNJpWbvbgP+PrqLs2gZFPxQ9AzMqqQTtycEB
	 QkM2Zf3vjlVCSkeP45RUems3+mO/pblHQKcr5sIWShCg9jPKN0X3vhOWmJOMp/AlynOtd
	 xCTQ4HV33SyOR2DjgLhGXwMT0X57oBYRQvfnncSgBynChqr6F1Oj3aXsbxuB96P+dOjDK
	 +v36J9qirBYgSuQhjJq4hD237Wx+HjAN6yBKbdg3bY/S5tiKXKgR2bFdit/876pCkJIMH
	 meBxCBcI/vLBpuYhAIOiJppCr0lGg5/o7UZjKqLl1qSbOoyWhBlz+gL1yAr4RewXrZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Hb9e3sWT;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE8606A329
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 21:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25AE8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Hb9e3sWT
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-53656465d1dso679784b6e.2
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793395735; x=1794000535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VAC2gRysazALbkHLgOMIEvbY+EZby3ybWz+RCk1jtS4=;
        b=Hb9e3sWTytLy68lvKFM4FdA3beUBDaPKpwbjUN2GuCWvIfEu0sEDhp8qk+3GiQGePf
         JU73bbZQZ2g4wF37T32fhLBiQ2lEaDg2+3IsK4mp2lVRmfzw5nbDpFm7ab0copnDNR4C
         ZO8WBM1/38ITBY4zpSvXZzykGXGmKfMzg9EOu/FBsY5HRzZYLmbU8FLEUXpiCZihNmO6
         U6nuIKY1ac0Xzv3w91VyNV9nBF/+Hne6gyPGgK6MVux0om9qQaUanDQ6Xx+f6aQOLrBu
         DC/ot9Qa+mF4e6PoWwTIw0fJ3qzcDu3Uxd8ZiiQgMNRGdYB8JY3uhuDJNviT4bbZv9k9
         +0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395735; x=1794000535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VAC2gRysazALbkHLgOMIEvbY+EZby3ybWz+RCk1jtS4=;
        b=aPfQca+F7Ap130FcVLU4RKdGULVK1/AYlWtD2zTpiaSCd3e20MoAuSqhloncs4D/ku
         F5LefDMNohiJemVfW19MJItVuEgy12rh5B3oIqQ73hQsZTmybv+0wIZgprRGfnKKGkDt
         Tee8gAX8RbENcQVOpVSQIJRqhPadizo5Z9V3eg7iLfUw0DpDle3OvxgG9Dzulf8MC5uX
         68bVeb89v81D8ST1gnxvGOHQCTRDRibPFKtVT6SbTjKi1VGHSYO6Yw4pgWDoUdoR++s9
         9AXNxsZltPHB3mskCRmaYDvTG/6nvR5r/3sXnbC7DWdsuZ7I0cZt9PYVqbkrtZJnJMxA
         pa5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzpB9IXqZgiYmnlSYVyFH2XvrJ3fqxzp7+8SmtTg7SZ0IUNiwiWb3+/DcOvbMdNZzvZGKVnvAudUUF5avjvZg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIZKHG2HxGcqmWHACAUPaKEDakuvSLhl5xDBBIt+SWezDs4Gmn4
	uYKmZvIu26w5zckK1FeRfixUYRpea40w91wTmiug6Ps8EpUQFFwZMDAhZYVFKyYqjn4=
X-Gm-Gg: AYBFou2VVrGYgePSdQjafYl0ai1EWN7ajnSketn1dWbtQiMSYrJmyTUeSo1iAShuST3
	rNEmlfLVZT76IpzabggafbVg1fLmBCrpfopurdjsBnC5ekmwhWw23K0DyYFPRyeXv2l4dqH6ykk
	Sx2cvepR7UGeYCaYRegH5/OxWtQ0yYvpRn/Kakq4M458pg8UevqP/JX0Gs24Y4SJ/kxQ5rVHezP
	B2Efl5Uqh5Ow7yYggMH179bzefVcP9PN7o3CqhGBNx35U/Jc38qlOBNxh/Wd/YYbrnYqHsree0e
	V5nkYOHJ+qRjfC7xJFmvr1RVAz8R+mJBSG4YX2RYU3IumwEFBp4c5/W6RCmAGExYhFr7kpHnbH+
	ODn0Duaboebq8oJvsx66ZJucV8h8hXxEAZd8Tc7r5W+MjsDC9u/N7USsKb4tCizlb7KH/MxmrDX
	HgNvIgfgPm4f744+B+g1yEgojoyB6V8oSD6URDVKLsMXDcyPkQ68U19KS2mofa/jkwlsWA0IQIF
	CMDAclIkk5+ttbb8R4klbsHxwkiqjAUYKp+GRa/UC3DTHLXVm2BWWmqM34Ur0ybn/mi1iu/+ok2
	cW0/QNSV8Dk6
X-Received: by 2002:a05:6808:1494:b0:4d6:90f4:48b1 with SMTP id 5614622812f47-5640de2eed3mr2467493b6e.51.1793395734839;
        Fri, 30 Oct 2026 14:28:54 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:15d7::22d:91])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm2339531b6e.3.2026.10.30.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:28:54 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:28:50 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Max Krasnyansky <maxk@qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH RFC v7 4/5] net: resolve uncommon partial checksums at
 ingress
Message-ID: <auUGy8bhvANg_dYi@20HS2G4>
References: <cover.1793276116.git.mst@redhat.com>
 <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>

On 2026-10-29 14:53:34, Michael S. Tsirkin wrote:
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
> Note a fundamental limitation of this approach: an nf/BPF program
> that tweaks the payload of a packet in flight may rely on the
> checksum being fixed up later, assuming the packet carries
> CHECKSUM_PARTIAL.
> 
> For metadata that fails validation the checksum
> is now completed at input, so such edits leave a stale checksum
> and the packet is dropped at the receiver.  Protocols whose
> transport header we cannot parse (anything but TCP and UDP) are
> affected even when the metadata is self-consistent.
> 
> The sysctl added in the next patch is the escape hatch for these setups,
> but it is a very blunt tool.
> 
v7: Tested-by: Chris Arges <carges@cloudflare.com>

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
>     v5->v6:
>         read both skb->protocol and the frame ethertype: do not
>         validate when they disagree, instead of preferring the
>         preset protocol; same check after the IP version inference
>         where there is no L2 header (Willem de Bruijn)
>         pull the IPv4 options in the helper as introduced, with the
>         transport header offset computed before the pull
>         (Willem de Bruijn)
>         fold the trivial protocol calculation cleanup, formerly a
>         separate patch, in (Willem de Bruijn)
> 
>  include/linux/virtio_net.h | 315 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 311 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea..54048759cc6e 100644
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
> @@ -48,6 +52,216 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/* TODO: nothing virtio specific here, move to ip.h */
> +
> +/*
> + * Pull and minimally validate the IPv4 header at @nhoff.
> + * Returns the header and stores the transport header offset in
> + * @thoff, or NULL if truncated or malformed.  The whole header,
> + * options included, is guaranteed linear on return.
> + */
> +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> +						  unsigned int nhoff,
> +						  unsigned int *thoff)
> +{
> +	unsigned int ihl;
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
> +	ihl = iph->ihl * sizeof(u32);
> +	*thoff = nhoff + ihl;
> +	/* Pull the options as well: the transport header offset
> +	 * returned above must be within the linear data.  iph goes
> +	 * stale across the pull.
> +	 */
> +	if (!pskb_may_pull(skb, nhoff + ihl))
> +		return NULL;
> +
> +	return (struct iphdr *)(skb->data + nhoff);
> +}
> +
> +/* Where does the L3 header start, and what protocol is it?
> + * Handles Ethernet and VLAN headers; other devices use the
> + * network header offset the caller set up.
> + */
> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	/* skb->dev should always be set here already,
> +	 * but let's not crash when it is not.
> +	 */
> +	if (WARN_ON_ONCE(!skb->dev))
> +		return false;
> +
> +	if (skb->dev->type == ARPHRD_ETHER ||
> +	    skb->dev->type == ARPHRD_LOOPBACK) {
> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto = eth_hdr(skb)->h_proto;
> +		/* skb->protocol is a sender claim, and parts of the
> +		 * stack parse the packet per it: when it disagrees with
> +		 * the frame we do not know which view the packet will
> +		 * be parsed as, so do not validate.
> +		 */
> +		if (skb->protocol && skb->protocol != h_proto)
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		const struct iphdr *iph;
> +
> +		*nhoff = skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
> +			return false;
> +		/* No L2 header to cross-check with: take the protocol
> +		 * from the IP version at the network header.
> +		 */
> +		if (!pskb_may_pull(skb, *nhoff + 1))
> +			return false;
> +		iph = (const struct iphdr *)(skb->data + *nhoff);
> +		if (iph->version == 4)
> +			*proto = htons(ETH_P_IP);
> +		else if (iph->version == 6)
> +			*proto = htons(ETH_P_IPV6);
> +		else
> +			return false;
> +		if (skb->protocol && skb->protocol != *proto)
> +			return false;
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
> @@ -194,11 +408,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
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
> +	if (likely(skb->ip_summed != CHECKSUM_PARTIAL ||
> +		   virtio_net_csum_partial_ok(skb, hdr->gso_type)))
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
> @@ -282,6 +520,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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
> @@ -290,9 +557,11 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  bool little_endian)
>  {
>  	const struct virtio_net_hdr *hdr = (const struct virtio_net_hdr *)vhdr;
> +	typeof(skb->transport_header) old_transport = skb->transport_header;
>  	unsigned int inner_nh, outer_th, inner_th;
>  	unsigned int inner_l3min, outer_l3min;
>  	u8 gso_inner_type, gso_tunnel_type;
> +	__be16 inner_proto;
>  	bool outer_isv6, inner_isv6;
>  	int ret;
>  
> @@ -335,9 +604,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> @@ -352,9 +624,29 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			return -EINVAL;
>  	}
>  
> -	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +
> +	/*
> +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> +	 * set CHECKSUM_PARTIAL.
> +	 */
> +	if (unlikely(!virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type,
> +							  inner_nh,
> +							  inner_proto))) {
> +		/* __virtio_net_hdr_to_skb set the transport header to
> +		 * csum_start, restore it to a known good value.
> +		 */
> +		skb->transport_header = old_transport;
> +
> +		return __virtio_net_resolve_csum_partial_mismatch(skb);
> +	}
> +
> +	skb_set_inner_protocol(skb, inner_proto);
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> +		/* Checked here, after the validation: a packet completed
> +		 * in software never uses the feature, so an unnegotiated
> +		 * request only matters for metadata good enough to act on.
> +		 */
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
>  
> @@ -368,6 +660,21 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
>  	skb->transport_header = outer_th + skb_headroom(skb);
>  	skb->encapsulation = 1;
> +
> +	if (!skb_is_gso(skb)) {
> +		/* Too small to segment: complete the checksum in place
> +		 * instead of dropping - senders do tag small packets
> +		 * with GSO headers, e.g. packetdrill sets gso_type and
> +		 * gso_size with --mss, whatever the packet size.
> +		 * The outer UDP checksum is not calculated, but a zero
> +		 * one is fine: UDP over IPv4 allows a disabled
> +		 * checksum, and so do tunnels over IPv6 where the
> +		 * receiver opts in (RFC 6935, RFC 6936).
> +		 */
> +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> +					       SKB_GSO_UDP_TUNNEL);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> MST
> 
