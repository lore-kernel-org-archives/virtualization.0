Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760350;
	b=J7V6Ybr+Uhpkc4I5em4tGSVawcs3prl5DMitQp+Ye+tsZe/qpnxBH68N8yjXSQyuxjCB
	 fwdqqdTKyhoNXu6XSujrjnb+p9zxrVEdNFhW4+0p8uQEdZ84RG3CSVot9W5zRg266md/u
	 vaXWKVo89jDNH7AC+dvB0p+2K2beN3taMEl98zbiDI07RZLWGj2yVOQLYDlPrLdEqScMn
	 sBayqk9e0C+S9jZr6yYHu1X1TW6QaxVRe8dFpwwvD2hvoVvuIAsNIJv5cKLw8KoFIfE6T
	 6j5zyt7/Uf6z3qKA7H71iTqM9PmD/8P2ee6KOmEh39Q3sh4UrHG1asE5HJ5wx0zXNMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760350;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mk2tCxkYtM32zp5NxRVSmm3VqSq8Gz+JsrKNRTr6FRU=;
	b=h7+JgyvMdnrR0U6kei9A6XhN3bk9ITUIdR/0VOKgU9UFWNE0yyHJMfhXpFkFj2aSqI7o
	 I/iIa+T3v0BSoQYz89ms+JRvqXGndIZuOKD19tTX/fWJWm0X/yLez2zldaNYFplCFC8UC
	 xhGuxurjCBEvAEBVC+YqSsGzAWsys8hTSt8drPEoNkfyURza8Kum9+B0z4mxxeOsqSFYe
	 LoC4cxQ9WucXhAZg1Iu5o9UElz2ZxCDUGpEuNhaDm+SCvU5DnmsloV2Guj4qE7IdKKktq
	 BSCjccw67DYZ/NvjiaRPeGxuo/9SrZgj0/Iv5mu3gTdg//q5FBlDha8R1AKQeGppuIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8WNxVen;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA56606A31E
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8WNxVen
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACF71F01828;
	Fri, 23 Oct 2026 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760349;
	bh=mk2tCxkYtM32zp5NxRVSmm3VqSq8Gz+JsrKNRTr6FRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8WNxVenFv4VLG70w7ylX6tglePhpfbHkW5s5l2LwOV4Zfhz8GuPv8oLTnwmwStij
	 /V53boDDOMzU4U7x/swSqF5yxy7tHNrcD3G/oKmTExz2Zfl6wXkeL7+Ec7mVzMam3K
	 SM/GBzw1Lb9NMg8VUq6RoIrmFjOgKVbS0eTqiAXkE/DwtxfFKo1m8YFm6Gjg0OT4Fa
	 ogqIjH3xrgML3OAggtRV961rtZtWj6kSsmvUmErsFDq35Yls8UFUKVHMAxzFyBERk8
	 w0Bkr6E55SBlEdqMY1c95mvUDycYlAJr2xgaJQCXgdMjjEZ2NucTE0knUb50ijvZq8
	 Hlrhob0Ljpf2A==
Message-ID: <sashiko-outbox-182808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 7/7] virtio_net: cleanup protocol calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <f8621d16cf0c67335641d07c1555ec1e43f17628.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <f8621d16cf0c67335641d07c1555ec1e43f17628.1792668082.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:59:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: use-after-free read of iph->ihl after pskb_may_pull() in ip4_=
parse()
- [High] virtio_net: failed drop of invalid non-GSO tunnel packets in virti=
o_net_hdr_tnl_to_skb()
--

commit 932b3459605ba3055ae9042b1894bc6eb02c03c4
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_net: cleanup protocol calculation

This commit removes a duplicate assignment of inner_proto in
virtio_net_hdr_tnl_to_skb() by computing it once before calling
skb_set_inner_protocol().

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 063cc116e51a1..e984e446ba44a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -613,8 +613,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			return -EINVAL;
>  	}
> =20
> -	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -			    htons(ETH_P_IP));
> +	inner_proto =3D inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	skb_set_inner_protocol(skb, inner_proto);
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -638,7 +638,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_s=
kb
>  	 * set CHECKSUM_PARTIAL.
>  	 */
> -	inner_proto =3D inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
>  	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
>  						 inner_proto))
>  		return 0;

[Severity: High]
When virtio_net_csum_partial_ok_at_offset() validates an IPv4 header via
virtio_net_l4_start() -> ip4_parse() (introduced earlier in this series in
commit f0109d51e8b0 ("net: add ip4_parse()")), can ip4_parse() in
include/linux/ip.h perform a use-after-free read of iph->ihl?

In include/linux/ip.h:ip4_parse():

	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
		return NULL;

	iph =3D (struct iphdr *)(skb->data + nhoff);
	if (iph->version !=3D 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
		return NULL;

	/* Pull the options as well: the transport header offset
	 * returned below must be within the linear data.
	 */
	if (!pskb_may_pull(skb, nhoff + iph->ihl * sizeof(u32)))
		return NULL;

	*thoff =3D nhoff + iph->ihl * sizeof(u32);
	return (struct iphdr *)(skb->data + nhoff);

When an IPv4 packet has options (iph->ihl > 5) that reside in nonlinear
paged data (so nhoff + iph->ihl * sizeof(u32) > skb_headlen(skb)), or when
the skb is cloned, the second pskb_may_pull() call invokes
__pskb_pull_tail() -> pskb_expand_head(), which allocates a new skb->head
buffer and frees the old buffer still pointed to by iph.

Dereferencing iph->ihl to compute *thoff after the second pskb_may_pull()
then reads from the freed buffer before iph is reloaded from
skb->data + nhoff. This affects all callers of ip4_parse(), including
ip_rcv_core(), virtio_net_l4_start(), br_validate_ipv4(), and
nf_reject_iphdr_validate().

Should ip4_parse() cache iph->ihl * sizeof(u32) in a local variable before
the second pskb_may_pull() call, or reload iph from skb->data + nhoff first?

[Severity: High]
Also in include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb(), what happens
when virtio_net_csum_partial_ok_at_offset() returns false for a non-gso
packet with a tunnel header?

Earlier in virtio_net_hdr_tnl_to_skb(), __virtio_net_hdr_to_skb() only sets
shinfo->gso_size and shinfo->gso_type when skb->len - nh_off > gso_size. If
a caller provides gso_size >=3D skb->len - nh_off, skb_is_gso(skb) remains
false, which virtio_net_hdr_tnl_to_skb() explicitly accounts for after
setting the inner header offsets and skb->encapsulation:

	skb->inner_transport_header =3D inner_th + skb_headroom(skb);
	skb->inner_network_header =3D inner_nh + skb_headroom(skb);
	skb->inner_mac_header =3D inner_nh + skb_headroom(skb);
	skb->transport_header =3D outer_th + skb_headroom(skb);
	skb->encapsulation =3D 1;

	if (!skb_is_gso(skb))
		skb_shinfo(skb)->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL_CSUM |
					       SKB_GSO_UDP_TUNNEL);

	/*
	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
	 * set CHECKSUM_PARTIAL.
	 */
	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
						 inner_proto))
		return 0;

	/* A tunnel header implies GSO, so drop. */
	return __virtio_net_resolve_csum_partial_mismatch(skb);

However, in include/linux/virtio_net.h:__virtio_net_resolve_csum_partial_mi=
smatch():

static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff=
 *skb)
{
	if (skb_is_gso(skb))
		return -EINVAL;

	return skb_checksum_help(skb) ?: 1;
}

When !skb_is_gso(skb) and virtio_net_csum_partial_ok_at_offset() fails
because the inner headers are malformed or do not match inner_th,
__virtio_net_resolve_csum_partial_mismatch(skb) does not drop the packet.
Instead, it completes the inner checksum via skb_checksum_help(skb) and
returns 1, which callers treat as success.

Does this allow a non-gso tunnel packet with invalid inner headers to enter
the networking stack with skb->encapsulation =3D 1, unvalidated inner header
offsets, and any requested outer tunnel checksum
(VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) lost when skb_checksum_help() sets
ip_summed to CHECKSUM_NONE? Should virtio_net_hdr_tnl_to_skb() return
-EINVAL directly when virtio_net_csum_partial_ok_at_offset() returns false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v5.git.mst@re=
dhat.com?part=3D7
