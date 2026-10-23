Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784271;
	b=bF9LKLMswDZnVAZhnbB5J6N1HGl1ek0Teg3oZjMzIanQ3KB8UdAdEQeFhRt8XUl7WgfX
	 vDMJqnMRsXubSDVooXoK3UMgS4qXXNdy8P6320Ih16jaHJj4YeYUMIrxg88kD+G1/tYOy
	 wCQkkGdcDfCsA5JggF4GAb+qtN3fSzwGfTLxd0/bv3VOG2MjZ5s3KupHqtoVykNIitjq+
	 ruu51JHJGwHwM/+VgxWtvDZClW9BhdMo1EueYIjbc5NuroUeiqDUioCeKzQMAhIdYP6cy
	 MRbV46E1FjfHxeJ7wFC5VeUwSBWkbQDkrw4ODrNHP3D+oA3TJV2dBnu6De+/MykYTrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dBqlzpdFcJ3hUDMw92HPVyeVA39vP3B1zf8tX9+k8sk=;
	b=0FYvqEx/nLGFf4zNADsn5Sq+KSFy2eeafVt1kkok1pa6u1UVxmEYmpvxUg0lZ0UvAshw
	 yxBupDX7HZrWqb9NbDORzIfDnh9FV+qIc32I20g/pxHieFD0rkWG28D+DYjDUET8KQfYo
	 uuNpnajKQYd6KsdFAgzVA+MtZB7s2O0/5ll04KBSnuFlUhTnjMUJB8T27nbnp9DSI+duO
	 xc0cWRvLK5dqk6dfJ36+3Yq+zqJMgKmBLrMhbUk29Ut7J3LmxaHLS40tQmPd43m01mFNt
	 fKkfLvCxrDwWw1Jy7UTv2i/LiLXqZdZ3H6fga2yY6yDOczOG7xD5BsVHqtn101C7ZYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kU42WtZ1;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788D606A31D
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 19:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1788D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kU42WtZ1
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc013095d4so378578137.2
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792784270; x=1793389070; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dBqlzpdFcJ3hUDMw92HPVyeVA39vP3B1zf8tX9+k8sk=;
        b=kU42WtZ19w5LC+mYhuUM7WxC1S9bz1WM3yqYaSgngomnVGT/ZQxa2GNMTjIhbmGZ2d
         rrL8V751UzVZ8KjODA5RT2vpjDhMDmXsX79ddGeGI8FWoAutJv6ONE1t3zuCInjVUlqv
         e9nLNmaLmQqN4zfuJwbaDKmZLR8euHiEmNQ93kXCyy5RLi7LoQuSQNsKkpW9HCTPj1Qr
         2eEUlfHvvTELejyYPVH5kJyRwmZ6g4gbeWSUjAPl1gNH42eIlzrIcieO0Tc6zhx6t9L3
         2ri7ZOn5eMxOnpTNBfxlvZdjQm9prrDSpZhCpl4ZONBtIOrt4V+g3xPMgaPMv9MP6uix
         Q2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792784270; x=1793389070;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dBqlzpdFcJ3hUDMw92HPVyeVA39vP3B1zf8tX9+k8sk=;
        b=NhaKbw1wKKyByQqV0ficYGe3HlqSE9785UalqYwU0be3iRpRt3Uv2Fmyz/J66KuAX8
         W0729nxc8qqC10cpXNzi4JLnxfd9y6uCYQFUNoFsCcyCr9h5U1hva5KjwWFNEVm/YFXm
         HR4P/M0zWxhukTSD4/0mqyyC8o1W0EJIPRYaHuQDyaXK0CH8oN4vNYjBcaMbiCMx/NbF
         vdVIq8oiIyRfIS8jurbjlXxkKemQQIgM9OUEmoe4O2MGm4oKjisc3XkxoDEedsfulr+/
         VSJnH8gEpa24TAk+VZNQeBXKi18WIlSoIkCrbJPh7+l3zdExbxodg4Knctets9InRpCO
         YBzg==
X-Forwarded-Encrypted: i=1; AKwUvBxCNA+pEz/hgO80LZ/gi0kf0P66Md//vjjAa8nOD6A7crbG4grGFEUukuKA07XdsQmqNqEXHHTKbDBOHj/dGw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL3IfVY7S+dGn3hBrHBLTV5EhOFrWzIUXopAb5IQKMSPWA0SwnN
	ioRZUK1ujpRnjojmGo4/lTadQ78zyDmT0skjDWp0CTjspIct2re832Ia
X-Gm-Gg: AYBFou0pTYejRT65k/XF02KIQP8L4DwUh2TBbZa0T5A86kkEDozFf+O4eVcytWazJRZ
	ATORftUy7LTVBZXRwpcD1mzsUX/ouK271kVRjpEszYC6ioIJ3N5ERcAlGo5dTJ0uOcr3KaUvRAh
	JPMIwXVjM/MnvRkR2TvJI8b6y85MZxc8pNQS49csLPkFCg7UZLqTAo3WkVr0FVRkFJi81U1vLYN
	SlWA8PxmmYlHc24jDocgoJIWff0LxWXAYbECnewX8q9oK5Oy1fYgyu7vsoBpWm9X9gnPdUiUYbS
	Z9GKCRyHCmDunPRpZnZyWFpQBkQaOok2rqNVvrgVb3kOotG5DkX8sxO4ljqtu7roaHTRIkFQCOG
	gDi8M5kqS69IxyUbESjhgr+FY5TWrudyT28rUeRJ7UXCo2r1CB6s5fmOAW6hrqr/xzS/ZfjVsYg
	rzPdeS0KE1AHVItiQ9q64QETF9VQ2BHmErylqAtNhIiANfVPvZYCU8UlE/9lyX3QzIxakekyJAG
	4yjIUEcSRzFr5YXKArELwLpUe8lbLsn9Y6R8waFmqHAv52cfjdGgP7LnZlrfs0+HXt+vUe+8qwB
	5EzRiTpko2tsuUb6zW5Fnl373iM5nXDA55LLTBXS/Wv9VY+m4J4PIr2eAzL3Fgq403XoVnh3QjE
	btktGppCpjo18g7ugQ60=
X-Received: by 2002:a67:e7cb:0:b0:7cb:bc5e:7dab with SMTP id ada2fe7eead31-7ce5cd5c735mr53020137.24.1792784269876;
        Fri, 23 Oct 2026 12:37:49 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e5f0452sm455908241.0.2026.10.23.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:37:49 -0700 (PDT)
Date: Fri, 23 Oct 2026 15:37:48 -0400
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
Message-ID: <willemdebruijn.kernel.3ae6f662e1ed8@gmail.com>
In-Reply-To: <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
 <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
Subject: Re: [PATCH net v6 4/5] net: resolve uncommon partial checksums at
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

A few comments inline. All but one cosmetic. Feel free to ignore
those. Please do review the comment from an LLM about the tunnel.
Aside from that LGTM.

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
> +	*thoff = nhoff + iph->ihl * sizeof(u32);
> +	/* Pull the options as well: the transport header offset
> +	 * returned above must be within the linear data.  iph goes
> +	 * stale across the pull.
> +	 */
> +	if (!pskb_may_pull(skb, *thoff))

perhaps a local var instead of dereference the pointer here.
though the compiler probably optimizes that anyway (?)
> +		return NULL;
> +
> +	return (struct iphdr *)(skb->data + nhoff);
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

Since ipv6_find_hdr is called with target -1, any non extension
header might pass. Do we want to restrict here to IPPROTO_TCP and
IPPROTO_UDP again? No other transport layer requests csum offload.

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

This is the common hotpath, but default branch prediction is to
predict if without else as not-taken. Probably not very important on
modern server CPUs, but optionally add likely. Same below in the
tunnel code.
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

>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -293,6 +558,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	unsigned int inner_nh, outer_th, inner_th;
>  	unsigned int inner_l3min, outer_l3min;
>  	u8 gso_inner_type, gso_tunnel_type;
> +	__be16 inner_proto;
>  	bool outer_isv6, inner_isv6;
>  	int ret;
>  
> @@ -335,9 +601,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> @@ -352,8 +621,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			return -EINVAL;
>  	}
>  
> -	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	skb_set_inner_protocol(skb, inner_proto);
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -368,7 +637,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +						 inner_proto))
> +		return 0;
> +
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);

    Allowing `!skb_is_gso(skb)` packets through `virtio_net_hdr_tnl_to_skb()`
    has a few issues:

    1. When `!skb_is_gso(skb)` and `virtio_net_csum_partial_ok_at_offset()`
       returns false, `__virtio_net_resolve_csum_partial_mismatch()` completes
       the checksum in software and lets the packet pass, but `skb->encapsulation`,
       `skb->inner_protocol`, `skb->inner_transport_header`,
       `skb->inner_network_header`, and `skb->inner_mac_header` have already
       been populated with the unvalidated `inner_th` (`csum_start`) and
       `inner_nh` offsets (unlike `virtio_net_hdr_to_skb()`, which restores
       `skb->transport_header`).
    2. If `!skb_is_gso(skb)` and `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM` is set,
       clearing `SKB_GSO_UDP_TUNNEL_CSUM` drops the outer UDP checksum request,
       since a non-GSO skb can only carry a single `CHECKSUM_PARTIAL` offset
       (at `inner_th`).
    3. On RX, a non-GSO UDP packet with `CHECKSUM_PARTIAL` at `inner_th` causes
       `skb_csum_unnecessary()` (`skb_checksum_start_offset(skb) >= 0`) to treat
       the outer UDP checksum as already validated.

    Unlike plain GSO (commit 7c6d2ecbda83), UDP tunnel offload is modern-only and
    explicitly requires GSO (`/* The UDP tunnel must carry a GSO packet, but no UFO. */`).
    Why not reject `!skb_is_gso(skb)` right after `__virtio_net_hdr_to_skb()`, and
    return `-EINVAL` directly if `!virtio_net_csum_partial_ok_at_offset()`?
