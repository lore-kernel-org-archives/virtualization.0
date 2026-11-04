Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757713;
	b=w8CpssAaf7uY7CeCiITad1N9cHJEsMQChiRjNx1twxRfzpRExrtVKydeELn8U5ijdJJY
	 jsWiVgq22mxroXorSLPMK+x8qS34LbU0EpGpqiDtOfup42Yq7YO+5mSrqtmmNtUhQZydc
	 8KwALEjtbro/WHbfo+68lft/U5ak84KXvSP1+3+HqvchVyKrlYp1vGy5p54fyabGsjKaK
	 8sbCaI0eU3I/NGNXIesvcxKLbzjZznFegDgdg3DIFi4qtBWWCEu7zdndkyYQSZoR0p8nU
	 mmKjwB5CFCduSbC1LU9hxxsi8OOBS4X5lEGnB6JB2tfaVG8P19Ha1wsiAwV7j4baLYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ef3LJtj0EHb+BHKwRreNfN/8Uj/h0T0Rh6JYGdvZlAI=;
	b=pwaFrbTb1EwUfLC6JCKRXA2E8jvDLSH0d3ZgeJSDKEcVEODY6tDT9XuKPbPyu0njUizj
	 XIC0Eg0Ja/qpnWR7wN5pPjQo4Wsh8w9KSlYF1qATkdxU031NHxyyB98qWXESVUyIKeeUI
	 hrk3yZKpP2As+LCBeW1GuNvyxbIvqKMAM6UPvkDnn4W8NrIKACqRPKbjQlmOJWG99hUhQ
	 ToJtuGokFxknM3Jm51wu2GlIwccCChwuuG313QYBwhQJt8Dl7gdPRhhAnMJ5c/O2mY/yS
	 acRMMFkD82g/TubPTr94IhqAcJsMYRgW+RQGGw4nnsk1NYwDy5cHy3T8g0tIwxqUgIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2P95gsm;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B6606A329
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 312B6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2P95gsm
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso44260e0c.3
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793757712; x=1794362512; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ef3LJtj0EHb+BHKwRreNfN/8Uj/h0T0Rh6JYGdvZlAI=;
        b=Q2P95gsmqjMv1L2fsQn/h1Mb5GrRKu0l857HkTSf4OXyLIzqj6PcivcH9eHdhJvUUc
         9fp/cOQGX4kqjuYaARNYZetKIlcAQJhAT/ru6VnRfLvRHZ7oox6h20LUF664rWLT/hPY
         yqV4V5sW4A1sRT8opGSUfuoPUkMroI+U1xhwdXgWi6RmgfqHyl8p65FI/uZHtJvJQ9DP
         7fFlgpF7gG5/meSKhUFjE1jX+RMv3SNHFZvcxVmRfCf+9hKAnXgMYSiWyM0mq+t5GKou
         ZoXtGsoj3ZtIZ5XakerVPxncz5TNP29RjINyAPrihZ3t1vNB2c8DDFGEz1pCNGNZQOZU
         ylrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793757712; x=1794362512;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ef3LJtj0EHb+BHKwRreNfN/8Uj/h0T0Rh6JYGdvZlAI=;
        b=hjH/SjNzHdcLLS9QVCzUUWYa6IpI4lX2c2zm/GS5/2o4wQb7rL3LxLB3tvYm3TF69t
         AYntelOJgn+sTxLegE5Ehmn3k3Y89DvSdDEOIjvPLmII7tLXq8lINc6HH/v/fKoK1JTx
         yG7RUq/t2hFtII5+yaIaDZk6NirKyw6kRJ1YiRPNXEgP+zTJkPpC+qKGjz9+r1bT2SoD
         Lw5rOavkuzIPq9Mnd5+LlEthqgMEzZ2V83aXOY/9MGwPph/SHDb3RcvXUbV602fnpWuO
         /QPDsIZXtM2Au2JwOYpwEDTZVJiHknfsc0oH9g0pl2+4mA0RXC2DnmTO/pWTVutoMKks
         Ly0w==
X-Forwarded-Encrypted: i=1; AKwUvBw9agKTa0anAYDvfBZvuYPBus4AcBtfj1ZAKWRFoHubwmElDDSJo2aWQNJfl2vI5g5hUQRbPdLGPJzIVH5s8w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8SPOlL8C1nrnt4K6QOQ5U+4AS10p5/zcC+3WkQ9Z+UnOuaY4Ha
	Vh+CULarHxLiMfENIij6VGKoGQ5uNoqZBOxtXhs4QIUTRa9f2mlcHevK/BCpQQ==
X-Gm-Gg: AYBFou2Pg4Gc2fI7XncvNe7CCD3YwEnkMpsuwxV9ytLKhMLoj0EpZjQ3jCGNGhXaSPy
	zYlyJzFDHQJzGrQ9523numldjkuJiTwh0ZDp/WTT1Mj8vRxcHrFbnCKU/SGD8TL0X2UH9yfBxki
	8jhBEfNJh97yc8Z9ko3upSHbhetIrC7KfdOj2/BAj2zoZJojUBDJvXF0xbvJGxXepz/Wzktk4nT
	xGkqOgq5JariXMoqm4lihPAmGUv1JZzbKX89xyJJnX+A9E1CuVCuGef5uC6f/ZtIAyws5eSkYS4
	PfH+K3fVeEtFYy6jFNELHIfUIMMeT+EP3VgzWnBo1TV2P2QBiZDHqeIsrmmqHiB/+/jwFaKhVlr
	uZLNjZpoE0QTxkeFQPTmdShU4IJnBlKjh99zYfpF91fWf/5bKDnau4Y7JGL2hzLPiC9e2JCdoHo
	XwOTb/NNT6FELQKfN/1lEJ92hEBRdE4pqn29r3N5JJRDsX5WC019ylnedeOi9G2cBOKiIQjsVjs
	UqVMgXuv7z7l6et3IiwAGbq0Vm33D8f9GVNKsh4dy1DCnv28GaNGMhmTOZ9rs/4LiKhdVoO6LAH
	Bd9fMaq57alUp73G0xj4M0UZLw1cKoiwp0OpPMnVaF7W9kTgIZKYz06Mp2TuNeqzPKEQeJy8Uve
	YyIAHHVR4IdE8WjDnzlhoJ3ijO0Ln/+k5eOhMHXSIn6/r86OWAILq9Bl5j26CB/+AyVBRPpM=
X-Received: by 2002:a05:6122:3115:b0:5d4:1193:73d3 with SMTP id 71dfb90a1353d-5ec6894bf5emr6089133e0c.14.1793757712007;
        Tue, 03 Nov 2026 18:01:52 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d7780fsm615030e0c.3.2026.11.03.18.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:01:51 -0800 (PST)
Date: Tue, 03 Nov 2026 21:01:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 mst@redhat.com
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2e11b18d6e190@gmail.com>
In-Reply-To: <20261103203113.550604-2-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-2-edumazet@kernel.org>
Subject: Re: [PATCH net 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
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

Eric Dumazet wrote:
> virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> carries such an outer header. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> dissector, so virtio_net_hdr_match_proto() is never applied either.
> 
> A guest (or a tap writer) can then inject a frame with an arbitrary
> outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> segmentation, which assumes a different header layout. The result is
> segments with skb->data before skb->head, and a host crash in
> skb_under_panic() as soon as a later layer pushes a header:
> 
>   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
>   kernel BUG at net/core/skbuff.c:215!
>    skb_push
>    __gre_xmit
>    gre_tap_xmit
>    ...
>    tun_get_user
> 
> Require the outer L3 protocol to match the declared tunnel type:
> for Ethernet frames, look at the ethertype after optional VLAN tags,
> and check that the outer network header fits before outer_th_offset.
> For IFF_TUN, skb->protocol is already set by the caller.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Hassan Sultan <hassansultan@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>

Thanks for the fix. It overlaps with

commit "net: resolve uncommon partial checksums at ingress"
https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/

There are a bunch of subtle issues here. That series is up to v7.

Two specific issues are that
- skb->protocol in general cannot be trusted, and
- non-L3 sources cannot be assumed Ethernet

Would it make sense to take the relevant parts from the quoted commit,
which has hopefully resolved those edge cases, and send that on its own?
The rest of the series can come later.

> ---
>  include/linux/virtio_net.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..d3f97d71d81c 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -282,6 +282,31 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* The outer network header of a UDP tunnel GSO packet must match the
> + * tunnel type declared in the virtio header, otherwise the GSO stack
> + * would parse the packet as something else (e.g. NSH).
> + */
> +static inline bool virtio_net_tnl_outer_proto_ok(const struct sk_buff *skb,
> +						 bool outer_isv6,
> +						 unsigned int outer_th)
> +{
> +	__be16 expected = outer_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	__be16 proto = skb->protocol;
> +	int nh_off = ETH_HLEN;
> +
> +	/* L3 device (IFF_TUN): the caller already set the protocol. */
> +	if (proto)
> +		return proto == expected;
> +
> +	/* Ethernet frame, possibly VLAN tagged. */
> +	proto = eth_hdr(skb)->h_proto;
> +	if (eth_type_vlan(proto))
> +		proto = __vlan_get_protocol(skb, proto, &nh_off);
> +
> +	return proto == expected &&
> +	       nh_off + virtio_l3min(outer_isv6) <= outer_th;
> +}
> +
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -338,6 +363,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> +	if (!virtio_net_tnl_outer_proto_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> -- 
> 2.53.0
> 


