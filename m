Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388120;
	b=bUNJEx6TGdGSUJDOgJmxP5UFAIiJo6ucKNsGHqF2hdWz4J+s6XHtUfAF2zgSnKGKJtC7
	 HnpciObc7rWMf7AR4lLo4lxr7vAWEW4JXuARIZM9FEoqrRzA7MkBaQFLl+TdbDncRTCA8
	 AHjWWrHkRTI5FAciqGTzOfsaFxhApTBtlNOzU0T7+3WcnbsP1JYtXH9dx33BzS/65+XUe
	 0rh6ndbTiJhouAijcw/rU3E+hjtUniK2J7qVOE9OEcQbCDH01Mxc/GI9VbMQRt/ZKBaEF
	 Y3j1Pjooa1y6viP5c7qw0o2TTfcTUnraU4yEjN8qlk/+y7zC8Xy2zxfnD4x1jh7YAHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GReiSolaeJ3iKYS1tEulym/+/oFcv/1Felx7ub1EYtY=;
	b=K0E3o72K5SjdN3j5a9Awd5V5z+jExiNa7xWlMUwOLPpzgYBaE/U7uCdI2EvU5LKFBnGZ
	 6i45d6Oj2h7H2HZnX5fKSFotxa0lamsa+vOMeqqTjs9mTAqk3wxFqLPvU4ZF6dS5k9x/g
	 jGwFfozdr+6R45IlSKaFUUAhgMisiOTouoMYz0+i+l3l8kglqT6pzix76AlRhfprQd6L+
	 tzQ/WkJQV/Hoo60HQBLq5rq6UH7+fcwiKJ1rOailQWuyArWnera5n4fPP/DozF3Zg19Dj
	 cvkDEVdUbrSlTS4zv7c4YE0wo1u1V3GMWPPZ/ykyCBzecCvu3Mje3/x2D60FCkxbS0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WoRjc3l3;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85A606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F85A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WoRjc3l3
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso289229241.2
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388118; x=1793992918; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GReiSolaeJ3iKYS1tEulym/+/oFcv/1Felx7ub1EYtY=;
        b=WoRjc3l3LJB3vJ34poZmxSgMkQz8zZu4a3wXfMXcyHO0W7lskEHlERWpLe6J24DtVz
         nyJj5agOpJJgy8hXAC+m/Hp6h6GShQAOExD1bSF2/JLZd5jQKHdYE+wuicfnkUrqxCDz
         lpdpBcBf2UOF9RroyPXKs5aykVp7GmOblpW/90eMZ7CbUuNO9F00WdzltjYrop3JvJzd
         AkWaUC7knPG1Gwc/llq1aA/ezYVJbIHe6puRyawU+Io0Ozy1uI5FtOnLZJNJVHFq9+8n
         mJd5kD+WYVkyrEmBCu4vn+IvCaL7+edYNCJZ8yFqNslmAxtn+XHY1XoyTrta8oPJYx6/
         uVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388118; x=1793992918;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GReiSolaeJ3iKYS1tEulym/+/oFcv/1Felx7ub1EYtY=;
        b=xzsz6cUP4iQxNRI+0pdOdK7f7Rf0ElYkKJsDqEQBGoqTyY0qxC2XN3MY+VFMrz1RB9
         sZAIxcApCLLQF1Up160p+aeIU3lGlXOjxBY5WjnidpO3ojeIdh8MRM/KxPE6qT0gvN+Q
         SGzc3+q6A9Aw2j9FMECVIbOMfqsYpeDD3V+TF8mLU9gZRqQW3NIJLlW4EPWW5z5UQ7kV
         p2BiGH0jYfEYrckLmElYq8/7iXZGLyn9TqjVXgHy3XWvcBVEMOn3jmpDVJoceOKfhsHd
         eRv/exez/ElJVUv7EbYOj5YwLeL8On4+aeVIslaRSlVfC9Sv8pQ6GH0BtzSDaZfTuWXA
         MS7g==
X-Forwarded-Encrypted: i=1; AKwUvBzEkJi8uj/cBMfeEAAmAYeh2wZYPNQBe9EfiBhoA3+6pd0FnLzrApq934VwCGvXT/ONVMw0uOq0C+v35YNTnA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI6nF/MBypf0HWFs6GccoqHidfStH7QMB7ApWja60JqiglPat6v
	OZMy7ibggcZM+nGqcpQKmBdVSeyFkB1UKS4lVLSAqTAtDvQ93QPmNlzV
X-Gm-Gg: AYBFou0tVptj1MkTSPqHq/lt0H1+seRedJscxY0WDoqsyiuhwtXLrA8GFHJQI1xEILE
	xCNyxDdQhOfIs5C4+kK8dOFBv1epplwpeTrFXDEHfmdNnoW0+t29KQigz6Eq/jpvPt+u2dKCNMN
	BcF7RiWa9DVdOG1PoEFhbiXn16VO9F7W9yOCuF6C5/K588/G/qjUa7F+cG3PZTh/AJUWiYyxqUy
	p0jtFw9UUTyasBe8fqWuZ0CmIJsiPTTwE3sQgBBgwgcNfKxO/WZwYWWvGTWDZbqePfRLl+FYeQA
	icekkQ6DcEw/TEKESPc2vGJrGPkeVCKyQmCObYtLI/7gqHIk6vroTeTdIaRPGlHBsOwWJRrTYdn
	+EUzDFzlmQ3wiB+yzsC9soVKLVaEmR/cZflwUqE9W5Z5rk0RM6datGCyRkqtKqEJX8TPW8G+0Lb
	BS0SjOWJSareUPh3r1jb6gHsMSq0VopJ2TlOIOjNU0R99y9r+5qNNOdJ8tHRNMPLVLUwH2N1pJj
	GBE88S/z+8CCGZ16VhdL+FnQTvw1DOcxK+Bm8Twu2mYZO3bfrqq7QtRwJZ+Nhm8znO6MR5Ue0fy
	LPjPj62GfBsKYtl6JA3eGO8BhsOUBxBhaHhQktskJRTTARRAIJ2iHopEeB3Fj2di/7WBhtd2Mav
	N+z8MNpyG3dh7UfWzXoKbA2sz0HNV4yjIH1VqKYQqcEId2ND6p8BQ6CyvHr/B1iN+JXlIXw==
X-Received: by 2002:a05:6102:3ec5:b0:7c3:8150:83e7 with SMTP id ada2fe7eead31-7d072635dd8mr1556432137.9.1793388118448;
        Fri, 30 Oct 2026 12:21:58 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4e7453sm3608852241.11.2026.10.30.12.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:21:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:21:57 -0400
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
Message-ID: <willemdebruijn.kernel.10a41a35b45f6@gmail.com>
In-Reply-To: <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
 <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
Subject: Re: [PATCH RFC v7 4/5] net: resolve uncommon partial checksums at
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
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Chris Arges <carges@cloudflare.com>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

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

Minor, not cause for respinning on its own.

    `flags` should include `IP6_FH_F_AUTH` so `ipv6_find_hdr()` stops at
    `NEXTHDR_AUTH` instead of skipping it:

    - `CHECKSUM_PARTIAL` and GSO behind IPsec AH are invalid: AH authenticates
      the inner L4 header including its checksum field

> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}
> +

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

Maybe this carve-out for non-gso packet is best moved to its own
patch, as that is where the remaining issues (to merging the rest)
seem to be.

    1. Moving `!tnl_csum_negotiated` below `virtio_net_csum_partial_ok_at_offset()`
       accepts packets with an unnegotiated `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM`
       flag whenever inner validation falls back to
       `__virtio_net_resolve_csum_partial_mismatch()`.
    2. `__virtio_net_resolve_csum_partial_mismatch()` calls `skb_checksum_help()`,
       which completes only the inner checksum at `hdr->csum_start` and sets
       `skb->ip_summed = CHECKSUM_NONE`, leaving the outer UDP `uh->check` with
       an uncompleted pseudo-header checksum seed.

    Despite the comment, this block neither completes any checksum in place nor
    is the outer UDP checksum zero when `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM` is set:
  
    - With `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM`, the outer `uh->check` carries the
      non-zero pseudo-header checksum seed (as expected by
      `__skb_udp_tunnel_segment()`), not `0`.
    - Clearing `SKB_GSO_UDP_TUNNEL_CSUM` on a `!skb_is_gso(skb)` packet leaves
      `skb->ip_summed == CHECKSUM_PARTIAL` at `inner_th` with nothing completing
      the outer `uh->check` on transmit/forwarding (`validate_xmit_skb()` only
      completes/offloads the single inner checksum, emitting a corrupt outer UDP
      checksum). Even zeroing `uh->check` would be invalid over IPv6 unless the
      receiver explicitly opted into RFC 6936 (`UDP_NO_CHECK6_RX`).

> +	}
> +
>  	return 0;
>  }
>  
> -- 
> MST
> 


