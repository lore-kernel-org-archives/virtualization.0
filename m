Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760347;
	b=Fxux+nJmKNXFX2Cno8eRqdMkrDozAfUEUNCrw9B3VFa//7sNZTErIXLMtDEKZTVC1IDQ
	 SpJMu+3qXGXdcxbDVVUOOaFaY1HC305jvGxpVqaNKWU7Nhm/CPZSlYjMgikoIRtEwZaox
	 dpud0MBhBMUK9JoPtrzDjCYkXmTrmyDFX9Fu1Wlh2ygLZe4Ox+881RcLzzOwtVeCFk808
	 QYbP5yupXhaqGlCUmzXT7/qnkHyQWMAs5SUI+3qa1ulcmbw6W6NJ6DvmIY3SsCUdW99xG
	 tFzTlBr+fGnPQu4pW4a/oxsqbs1ltCYBqN60PzJ/nODNDDXan8L0ebdS0xCEH9r3gaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ljbgSX/WPPxAMzwwJCkR14CFtbtmFz9L4z1u8EDsLI4=;
	b=my5Qx1GIq77G42LQV5lWpwY9lQNL/u+VJPmz2+E0NNSoIPuf/QRQAIPOqqXZ91238M9+
	 efu8tH0gHO4Bbf7LDPhJBLRqpbet/1i99pPLAVkwG7WybxgTrB7SfytMl1FtyOYghW5Sc
	 N0eFqwF+bRu12Yxg/6esPk/EFn6cE/VAxLZWgR4VyJi3nx6BztP1yOrfReBAyrM5R1M7u
	 VGW5xQmCF6I5fVgFkynQFjIwrFhSJNEGowV66y0Ny+I1597e96H8yrWArAQIdH7zcMn9P
	 QfS28Va9A2HcWfKm867LIQ3yTJ/YnZucg+ju+sHBnK3GOr3O1NCzk/1d5IkNyBcNmQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxPKrCx0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB1606A324
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxPKrCx0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4581A1F01825;
	Fri, 23 Oct 2026 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760347;
	bh=ljbgSX/WPPxAMzwwJCkR14CFtbtmFz9L4z1u8EDsLI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxPKrCx0uKLTMUTJHI9R6igoRfzo0pr7Phy7FInC6qtQuuuD+tV3iNNqnz45fs7zL
	 J31b+jmOH17aO+RrnrB5Y/uEEjTf1gGvOCmCs8lkYrXMcfBRtbFJku99nDo0mIhE0R
	 sd+wybYgNyh1DcOb8xoXWJPGV0HcDFHran4ayJBz8K55FjxFnfVAR63ApnvFXE6lf6
	 /xq6peVc1qOScooJk5+cjtIodD9dQXPr5ncH4aScKwQiDTyvmGVRU2DXRU8ZZ/LOQB
	 7QXU4zPEJNxpbIx99OBtZhcxQaOAUEKw1tzeFD2FW3hmDHBQuyDpESPrMSzP5YRO9c
	 ZZ5GfoSXxf/CQ==
Message-ID: <sashiko-outbox-182805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 4/7] net: resolve uncommon partial checksums at
 ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:59:06 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] net: virtio_net_l3_start() allows skb->protocol and eth_hdr() mism=
atch
- [High] net: virtio_net_hdr_tnl_to_skb() mishandles non-GSO tunnel packets
- [High] net: virtio_net_l3_start() IPv6 inference overwritten by set_proto
- [Medium] net: virtio_net_l4_start() skips IPv6 AH headers without IP6_FH_=
F_AUTH
--

commit 1c3b02f56c070f59dd306e2b6555bc2eacaea7e4
Author: Michael S. Tsirkin <mst@redhat.com>

net: resolve uncommon partial checksums at ingress

This commit validates virtio_net_hdr checksum offsets at ingress so that
CHECKSUM_PARTIAL is only retained when csum_start and csum_offset match a
parsed TCP or UDP header. Other non-GSO partial checksums are completed in
software immediately, while unrecognized GSO packets are dropped.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea0..52852a33a2db7 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -48,6 +52,205 @@ static inline int virtio_net_hdr_set_proto(struct sk_=
buff *skb,

[ ... ]

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
> +	if (skb->dev->type =3D=3D ARPHRD_ETHER ||
> +	    skb->dev->type =3D=3D ARPHRD_LOOPBACK) {
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		*nhoff =3D ETH_HLEN;
> +		*proto =3D skb->protocol;
> +		if (!*proto || skb->dev->type =3D=3D ARPHRD_LOOPBACK)
> +			*proto =3D eth_hdr(skb)->h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto =3D __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}

[Severity: High]
What happens when skb->protocol and eth_hdr(skb)->h_proto disagree on an
AF_PACKET socket?

In net/packet/af_packet.c, packet_snd() and tpacket_snd() set skb->protocol
from the user-supplied sll_protocol or socket protocol before calling
virtio_net_hdr_to_skb():

	if (proto !=3D htons(ETH_P_ALL))
		skb->protocol =3D proto;
	skb->dev =3D dev;
	...
	if (vnet_hdr_sz) {
		err =3D virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());

On an ARPHRD_ETHER device, if userspace presets skb->protocol to
htons(ETH_P_8021Q) while eth_hdr(skb)->h_proto in the frame is
htons(ETH_P_IP), virtio_net_l3_start() ignores eth_hdr(skb)->h_proto and
calls __vlan_get_protocol(), treating the first 4 bytes of the IPv4 header
as a VLAN tag and advancing *nhoff by 4 bytes into a fake header inside the
packet. Conversely, if skb->protocol is htons(ETH_P_IP) while
eth_hdr(skb)->h_proto is htons(ETH_P_8021Q), virtio_net_ip4_parse() parses
the VLAN tag as the start of an IPv4 header.

When the frame is transmitted across virtual ARPHRD_ETHER devices that
forward via __dev_forward_skb2() in net/core/dev.c (such as veth_xmit() ->
veth_forward_skb() -> __dev_forward_skb(), macvlan, ipvlan, or netkit),
skb->protocol is overwritten from eth_hdr(skb)->h_proto:

	if (likely(!ret)) {
		skb->protocol =3D eth_type_trans(skb, dev);
		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
	}

On the other hand, on ARPHRD_LOOPBACK, virtio_net_l3_start() ignores a
preset skb->protocol and validates against eth_hdr(skb)->h_proto, even
though the transmit path prior to loopback_xmit() (such as TC egress and
validate_xmit_skb() -> skb_mac_gso_segment() -> skb_network_protocol())
uses skb->protocol.

Could this allow a packet with mismatched skb->protocol and
eth_hdr(skb)->h_proto to bypass the CHECKSUM_PARTIAL offset validation in
virtio_net_csum_partial_ok()?

> +	} else {
> +		*nhoff =3D skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >=3D skb->len)
> +			return false;
> +		*proto =3D skb->protocol;
> +		if (!*proto) {
> +			const struct iphdr *iph;
> +
> +			/* A packet socket bound to ETH_P_ALL leaves the
> +			 * protocol unset: infer it from the IP version
> +			 * at the network header.
> +			 */
> +			if (!pskb_may_pull(skb, *nhoff + 1))
> +				return false;
> +			iph =3D (const struct iphdr *)(skb->data + *nhoff);
> +			if (iph->version =3D=3D 4)
> +				*proto =3D htons(ETH_P_IP);
> +			else if (iph->version =3D=3D 6)
> +				*proto =3D htons(ETH_P_IPV6);
> +		}
> +	}
> +	return true;
> +}

[Severity: High]
Should virtio_net_l3_start() also update skb->protocol when it infers the
protocol from the IP version, or should virtio_net_hdr_set_proto() inspect
the IP version as well?

When a packet socket bound to ETH_P_ALL sends an IPv6 packet with
VIRTIO_NET_HDR_F_NEEDS_CSUM and VIRTIO_NET_HDR_GSO_UDP_L4 (or
VIRTIO_NET_HDR_GSO_UDP) on a non-Ethernet device without
header_ops->parse_protocol, __virtio_net_hdr_to_skb() takes the
VIRTIO_NET_HDR_F_NEEDS_CSUM branch and leaves skb->protocol as 0.

virtio_net_l3_start() then infers *proto =3D htons(ETH_P_IPV6) into its loc=
al
variable, and virtio_net_csum_partial_ok_at_offset() validates the packet
as IPv6. However, after virtio_net_hdr_to_skb() returns, packet_snd() and
tpacket_snd() call virtio_net_hdr_set_proto() in include/linux/virtio_net.h:

	if (skb->protocol)
		return 0;

	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
	case VIRTIO_NET_HDR_GSO_TCPV4:
	case VIRTIO_NET_HDR_GSO_UDP:
	case VIRTIO_NET_HDR_GSO_UDP_L4:
		skb->protocol =3D cpu_to_be16(ETH_P_IP);
		break;

Wouldn't this overwrite skb->protocol with htons(ETH_P_IP) after the packet
was validated as IPv6, causing skb_mac_gso_segment() to dispatch the IPv6
packet to inet_gso_segment()?

> +
> +/* Walk the L3 header at @nhoff: where does its transport header
> + * start, and which protocol is it?  Returns false if the header
> + * is truncated, malformed or fragmented.
> + */
> +static inline bool
> +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 prot=
o,
> +		    unsigned int *thoff, int *ip_proto)
> +{
> +	if (proto =3D=3D htons(ETH_P_IP)) {
> +		const struct iphdr *iph =3D virtio_net_ip4_parse(skb, nhoff, thoff);
> +
> +		if (!iph || ip_is_fragment(iph))
> +			return false;
> +		*ip_proto =3D iph->protocol;
> +		return true;
> +	}
> +
> +	if (proto =3D=3D htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags =3D 0;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph =3D (const void *)(skb->data + nhoff);
> +		if (iph->version !=3D 6)
> +			return false;
> +		*thoff =3D nhoff + sizeof(*iph);
> +		*ip_proto =3D iph->nexthdr;
> +		if (*ip_proto !=3D IPPROTO_TCP && *ip_proto !=3D IPPROTO_UDP) {
> +			*thoff =3D nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers, AH included.
> +			 */
> +			*ip_proto =3D ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);
> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}

[Severity: Medium]
Should flags be initialized to IP6_FH_F_AUTH before calling ipv6_find_hdr()
in virtio_net_l4_start()?

When ipv6_find_hdr() in net/ipv6/exthdrs_core.c is called with flags =3D 0,=
 it
skips NEXTHDR_AUTH headers by ipv6_authlen(hp) bytes. By contrast, packet
dissectors and netfilter helpers such as nft_set_pktinfo_ipv6() in
include/net/netfilter/nf_tables_ipv6.h stop at NEXTHDR_AUTH:

	unsigned int flags =3D IP6_FH_F_AUTH;
	int protohdr, thoff =3D 0;
	unsigned short frag_off;

	protohdr =3D ipv6_find_hdr(pkt->skb, &thoff, -1, &frag_off, &flags);

Because ipv6_find_hdr() only checks the first 2 bytes of the AH header, a
packet carrying NEXTHDR_AUTH can advance *thoff to any 4-byte-aligned offset
past the IPv6 header and keep CHECKSUM_PARTIAL armed across rules that stop
at NEXTHDR_AUTH.

In addition, on local IPv6 receive, ah6_input() in net/ipv6/ah6.c resets
skb->ip_summed =3D CHECKSUM_NONE without completing CHECKSUM_PARTIAL before
verifying the AH ICV over the inner transport header, and IPv6 GSO offload
in ipv6_gso_pull_exthdrs() does not support NEXTHDR_AUTH. Wouldn't stopping
at NEXTHDR_AUTH via IP6_FH_F_AUTH allow non-GSO AH packets to have their
checksum completed in software at ingress and reject AH GSO packets,
matching the IPv4 behavior?

[ ... ]

> @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header =3D inner_nh + skb_headroom(skb);
>  	skb->transport_header =3D outer_th + skb_headroom(skb);
>  	skb->encapsulation =3D 1;
> -	return 0;
> +
> +	if (!skb_is_gso(skb))
> +		skb_shinfo(skb)->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL_CSUM |
> +					       SKB_GSO_UDP_TUNNEL);
> +
> +	/*
> +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_s=
kb
> +	 * set CHECKSUM_PARTIAL.
> +	 */
> +	inner_proto =3D inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +						 inner_proto))
> +		return 0;
> +
> +	/* A tunnel header implies GSO, so drop. */
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }

[Severity: High]
How are non-GSO packets with a tunnel header handled in
virtio_net_hdr_tnl_to_skb()?

In __virtio_net_hdr_to_skb(), if skb->len - nh_off <=3D gso_size,
shinfo->gso_size is not set, so skb_is_gso(skb) is false when control
returns to virtio_net_hdr_tnl_to_skb().

If !skb_is_gso(skb) and virtio_net_csum_partial_ok_at_offset() returns true,
virtio_net_hdr_tnl_to_skb() returns 0 while keeping CHECKSUM_PARTIAL at the
caller-chosen vhdr->inner_nh_offset + inner_th inside the UDP payload (for
example, pointing at a fake IPv4 header placed inside the UDP payload or
overlapping a VXLAN inner Ethernet header), even though GSO segmentation
will not run. If VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM was set, clearing
SKB_GSO_UDP_TUNNEL_CSUM also leaves the outer UDP checksum uncomputed.

On the other hand, if !skb_is_gso(skb) and
virtio_net_csum_partial_ok_at_offset() returns false, the comment states
that a tunnel header implies GSO so the packet is dropped, but
__virtio_net_resolve_csum_partial_mismatch() only returns -EINVAL when
skb_is_gso(skb) is true:

static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff=
 *skb)
{
	if (skb_is_gso(skb))
		return -EINVAL;

	return skb_checksum_help(skb) ?: 1;
}

When !skb_is_gso(skb), __virtio_net_resolve_csum_partial_mismatch()
completes the checksum via skb_checksum_help() and returns 1, leaving
skb->encapsulation =3D 1 and the unvalidated skb->inner_transport_header,
skb->inner_network_header, and skb->inner_mac_header fields set on the skb.
Could this leave bogus encapsulation metadata or arbitrary inner
CHECKSUM_PARTIAL offsets on non-GSO packets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v5.git.mst@re=
dhat.com?part=3D4
