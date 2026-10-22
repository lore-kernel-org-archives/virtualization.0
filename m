Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655440;
	b=0zz1ga0IpEqBsO70B+gVUMVkMllYiy3kHHpHRnPKea/x9I5r60Hij0ALG5ZaHbr1sqFd
	 SNyeH3OdDh/ir1SS3Nt9k94r1LqXJQ8wdmyhuvisWb2aNVIot5B7dmuOwCVpPFbdHdPPI
	 rpmatutuqanStz9Th6k0+wU+pcGgvdPyC1rAlisUCGvo+pH3TS8FgqwApSmsO6zx1oOVL
	 JO7o4BsvR/1l5cq01w9uOOJNhIGo2L/6XUo+pQ1bnvXd6n0diftX/pL6czn/6YLF8Aip0
	 jT7nchtoY1swLhM2Gt2zoPJsCrIjNrVfQ7SkRxHs/+Nn7o20rSdasLhKyorD1OLZ9eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A9Ar/IRPR9rFc2sOOD3GXX0tLXHFV8O8g947NmMxzHI=;
	b=ggZ1twhaqVS8XixroH/UewVNqLjTFNLBvCgorC4edx7gvBAcWUNIOk3DJtfP0jo3/Mdk
	 8k0U9FmrpQi6wPh2pygJRv9KDcy30qY2lxApNo1KsjmuD51Y5g9iMsnMdPCHbyYt07z2y
	 ZWnmm5DYg82W9Yp3o1vY1g+yMXDecNl+3jv05aUbnlAMKUhBQ4cS/L54iU3n5Nv7bHfTx
	 BlNPVYum/2YqMs+SvpEYD3wNJZ1qK/jV0qVtqai0cn48DqWPYJ3uBLdZR2iWrCzktMRM+
	 atew3CGFFbAVWYXWH2WFWhNja+IjVVofQNtqMiA9htsaiZ3QYxsOQ2W6+PMtJtgpV9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eoAg0/Fi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CC606A31F
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoAg0/Fi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135561F000C5;
	Thu, 22 Oct 2026 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655439;
	bh=A9Ar/IRPR9rFc2sOOD3GXX0tLXHFV8O8g947NmMxzHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoAg0/FiAAlw7SCzIl2y41qaOlp7TOW/+ABHjjyN8rTmwg+NKsjQhjXsht/ebvH8u
	 rsylU2kZHHI5zqqvy7Qmh05aqrhtvO+tc24rOGigUTs3BAojEeuDlrxT4DcwbcnMOA
	 h+A9nB1CeS25qIsDN2AAND8UULGpkA47aptuY7gjCi5KFHmgksqGQrqjtz0JUnxTf3
	 juG2sEfuRp+7GBhBi1fbONmqfEVSGknHJnRKSP9L7r6b1P9faDtJa5+afdNrUOWl1t
	 u2pSAbWD4D7pQg8sFjKUqjf+B7bOt0tS46azIThJgTlaCPN9hs25RQW1TAIXRVR8Ah
	 VauvTelfuYDhw==
Message-ID: <sashiko-outbox-181140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 4/7] net: resolve uncommon partial checksums at
 ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <5de86f1afe1165a1a13ac4ef0615b19f4a10cb7a.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <5de86f1afe1165a1a13ac4ef0615b19f4a10cb7a.1792565282.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:50:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: virtio_net_hdr_to_skb() runs skb_checksum_help() before skb_z=
copy_init()
- [High] net: skb->protocol ignored on Ethernet/loopback in virtio_net_l3_s=
tart()
- [High] virtio_net: csum validation bypass on non-GSO skb in virtio_net_hd=
r_tnl_to_skb()
--

commit 69b2836e804af5188d86e52f3cfbb8777bb548d1
Author: Michael S. Tsirkin <mst@redhat.com>

net: resolve uncommon partial checksums at ingress

This patch validates csum_start and csum_offset on incoming packets with
virtio net headers, retaining CHECKSUM_PARTIAL only when the offsets match a
parsed TCP or UDP header. Non-GSO packets with unrecognized partial checksum
offsets have their checksums completed immediately in software via
skb_checksum_help(), while unrecognized GSO packets are dropped.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea0..ec6f47ce1c974 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -48,6 +52,202 @@ static inline int virtio_net_hdr_set_proto(struct sk_=
buff *skb,
>  	return 0;
>  }
> =20
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
> +	iph =3D (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version !=3D 4 ||
> +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> +		return NULL;
> +
> +	*thoff =3D nhoff + iph->ihl * sizeof(u32);
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
> +	/* Loopback carries ethernet frames, too:
> +	 * loopback_xmit() calls eth_type_trans() on them.
> +	 */
> +	if (skb->dev->type =3D=3D ARPHRD_ETHER ||
> +	    skb->dev->type =3D=3D ARPHRD_LOOPBACK) {
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		*nhoff =3D ETH_HLEN;
> +		*proto =3D eth_hdr(skb)->h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto =3D __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}

[Severity: High]
What happens here when an AF_PACKET SOCK_RAW socket with PACKET_VNET_HDR se=
nds
a frame whose skb->protocol disagrees with eth_hdr(skb)->h_proto?

In net/packet/af_packet.c, both packet_snd() and tpacket_snd() (via
tpacket_fill_skb()) set skb->protocol from the socket or sll_protocol and
place skb->network_header at ETH_HLEN before calling virtio_net_hdr_to_skb(=
),
and then call packet_parse_headers():

net/packet/af_packet.c:packet_snd() {
	...
	if (proto !=3D htons(ETH_P_ALL))
		skb->protocol =3D proto;
	skb->dev =3D dev;
	...
	if (vnet_hdr_sz) {
		err =3D virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
		if (err < 0)
			goto out_free;
		len +=3D vnet_hdr_sz;
	}

	packet_parse_headers(skb, sock);
	...
}

In packet_parse_headers(), a pre-set skb->protocol is preserved, and
skb->network_header is only advanced past VLAN tags when skb->dev->type is
ARPHRD_ETHER and eth_type_vlan(skb->protocol) is true:

net/packet/af_packet.c:packet_parse_headers() {
	if (!skb->protocol && sock->type =3D=3D SOCK_RAW)
		skb->protocol =3D dev_parse_header_protocol(skb);

	skb_probe_transport_header(skb);

	/* Move network header to the right position for VLAN tagged packets */
	if (likely(skb->dev->type =3D=3D ARPHRD_ETHER) &&
	    eth_type_vlan(skb->protocol) &&
	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) !=3D 0)
		skb_set_network_header(skb, depth);
}

Because virtio_net_l3_start() ignores a pre-set skb->protocol on ARPHRD_ETH=
ER
and ARPHRD_LOOPBACK devices and unconditionally parses eth_hdr(skb)->h_proto
and VLAN tags via __vlan_get_protocol(), a sender can set sll_protocol to
htons(ETH_P_IP) while placing htons(ETH_P_8021Q) in eth_hdr(skb)->h_proto
(or send a VLAN-tagged frame on ARPHRD_LOOPBACK).

In that case, virtio_net_l3_start() advances *nhoff to 18 and validates
csum_start and csum_offset against a crafted IPv4 and UDP/TCP header embedd=
ed
inside the real IPv4 header at offset 14, keeping CHECKSUM_PARTIAL on the
skb. Downstream paths that rely on skb->protocol and skb_network_offset(skb)
at ETH_HLEN (such as nf_hook_egress(), sch_handle_egress(),
ipvlan_process_outbound(), and skb_mac_gso_segment()) will then inspect or
segment the packet at offset 14 before checksum completion overwrites the t=
wo
bytes at csum_start + csum_offset.

Should virtio_net_l3_start() honor a pre-set skb->protocol (and avoid
advancing past VLAN headers on ARPHRD_LOOPBACK when skb->network_header will
remain at ETH_HLEN) so that checksum validation parses the same L3 header a=
nd
offset as the rest of the stack?

[ ... ]

> +/*
> + * Handle a packet whose checksum metadata does not match the packet:
> + * GSO packets are dropped, as segmentation needs one checksum per
> + * segment; others are completed in software.
> + */
> +static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_b=
uff *skb)
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
> @@ -194,11 +394,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk=
_buff *skb,
>  	return 0;
>  }
> =20
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
> +	typeof(skb->transport_header) old_transport =3D skb->transport_header;
> +	int ret =3D __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> +					  hdr->gso_type);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (skb->ip_summed !=3D CHECKSUM_PARTIAL ||
> +	    virtio_net_csum_partial_ok(skb, hdr->gso_type))
> +		return 0;
> +
> +	/*
> +	 * Here we do not trust the checksum metadata.
> +	 * __virtio_net_hdr_to_skb set the transport header to csum_start
> +	 * from virtio hdr, restore it to a known good value.
> +	 */
> +	skb->transport_header =3D old_transport;
> +
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }

[Severity: High]
Can calling skb_checksum_help() inside virtio_net_hdr_to_skb() bypass the
shared fragment linearization check on zerocopy SKBs?

In net/core/dev.c, skb_checksum_help() checks skb_has_shared_frag(skb) (whi=
ch
tests SKBFL_SHARED_FRAG in skb_shinfo(skb)->flags) and linearizes the skb so
that userspace-mapped pages cannot be mutated during or after checksum
calculation:

net/core/dev.c:skb_checksum_help() {
	...
	/* Before computing a checksum, we should make sure no frag could
	 * be modified by an external entity : checksum could be wrong.
	 */
	if (skb_has_shared_frag(skb)) {
		ret =3D __skb_linearize(skb);
		if (ret)
			goto out;
	}
	...
	*(__sum16 *)(skb->data + offset) =3D csum_fold(csum) ?: CSUM_MANGLED_0;
out_set_summed:
	skb->ip_summed =3D CHECKSUM_NONE;
}

However, in tap_get_user() (drivers/net/tap.c), tun_get_user()
(drivers/net/tun.c), and tpacket_snd() (net/packet/af_packet.c), userspace
pages are attached to skb_shinfo(skb)->frags[] first (via
zerocopy_sg_from_iter() or tpacket_fill_skb()), then virtio_net_hdr_to_skb()
is called, and skb_zcopy_init() (which sets SKBFL_ZEROCOPY_FRAG, i.e.,
SKBFL_ZEROCOPY_ENABLE | SKBFL_SHARED_FRAG) is only called afterwards:

drivers/net/tap.c:tap_get_user() {
	...
	if (zerocopy)
		err =3D zerocopy_sg_from_iter(skb, from);
	...
	if (vnet_hdr_len) {
		err =3D tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
		...
	}
	...
	/* copy skb_ubuf_info for callback when skb has no error */
	if (zerocopy) {
		skb_zcopy_init(skb, msg_control);
	}
}

When a non-GSO zerocopy packet takes the slow path in virtio_net_hdr_to_skb=
()
-> __virtio_net_resolve_csum_partial_mismatch() -> skb_checksum_help(),
SKBFL_SHARED_FRAG is not yet set on the skb. As a result,
skb_has_shared_frag(skb) evaluates to false, __skb_linearize(skb) is skippe=
d,
skb_checksum_help() computes the checksum directly over writable userspace
pages and sets skb->ip_summed =3D CHECKSUM_NONE, and skb_zcopy_init() then =
marks
the fragments as shared after the checksum has already been finalized.

[ ... ]

> @@ -335,9 +589,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret =3D __virtio_net_hdr_to_skb(skb, hdr, true,
>  				      hdr->gso_type & ~gso_tunnel_type);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
> =20
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> @@ -353,7 +610,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	}
> =20
>  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +			    htons(ETH_P_IP));
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -368,7 +625,18 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header =3D inner_nh + skb_headroom(skb);
>  	skb->transport_header =3D outer_th + skb_headroom(skb);
>  	skb->encapsulation =3D 1;
> -	return 0;
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
> +	return -EINVAL;
>  }

[Severity: High]
Does virtio_net_hdr_tnl_to_skb() need to verify that skb_is_gso(skb) is true
after calling __virtio_net_hdr_to_skb()?

In __virtio_net_hdr_to_skb(), when skb->len - nh_off <=3D gso_size, the pac=
ket
is treated as non-GSO and shinfo->gso_size and shinfo->gso_type are left as=
 0,
while skb->ip_summed remains CHECKSUM_PARTIAL at hdr->csum_start:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
	...
		/* Too small packets are not really GSO ones. */
		if (skb->len - nh_off > gso_size) {
			shinfo->gso_size =3D gso_size;
			shinfo->gso_type =3D gso_type;

			/* Header must be checked, and gso_segs computed. */
			shinfo->gso_type |=3D SKB_GSO_DODGY;
			shinfo->gso_segs =3D 0;
		}
	}

	return 0;
}

If a sender on tun (tun_get_user() or tun_xdp_one()) or virtio_net
(virtnet_receive_done()) submits a small UDP packet with a tunnel GSO type,
VIRTIO_NET_HDR_F_NEEDS_CSUM, and gso_size >=3D skb->len - nh_off,
__virtio_net_hdr_to_skb() returns 0 with skb_is_gso(skb) false.

virtio_net_hdr_tnl_to_skb() then sets SKB_GSO_UDP_TUNNEL (or
SKB_GSO_UDP_TUNNEL_CSUM) on the non-GSO skb and validates csum_start against
the untrusted vhdr->inner_nh_offset inside the UDP payload via
virtio_net_csum_partial_ok_at_offset(). By placing a fake 20-byte IPv4 head=
er
stub at inner_nh_offset inside the UDP payload and setting csum_start to
inner_nh + 20, the packet passes validation and enters the stack as a non-G=
SO
UDP packet with CHECKSUM_PARTIAL pointing inside the UDP payload (and with
shinfo->gso_type non-zero while shinfo->gso_size is 0, which also triggers
WARN_ON_ONCE(1) in tun_vnet_hdr_tnl_from_skb() if forwarded to a tun device
without NETIF_F_GSO_UDP_TUNNEL).

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v4.git.mst@re=
dhat.com?part=3D4
