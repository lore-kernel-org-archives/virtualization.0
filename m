Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497843;
	b=DB6WzP2Eg6aqBqFHjfU+3+4y2qcZXkkT8oEluGmclkjpbo3MPcGsmpXUyBX9TmgQ6zmq
	 BFlVtd+XnRlM2xvexMWxYJhGmdyobslkgGSePqh9Re6kWaOmSKMnAI1sSCAQ6Wjh3vB89
	 SQnFKBRR9cYS5FWcca8OKxuGxkKg6A7takxokoeh6C0b2nPyca0S0Fw/ZVlCMkDDfvCxk
	 0O339/f/1oun557B45G2X3AnzfixHVIQ7yvTFx/SbM1wveCZq/HO5Snf4pCqlDtvdn8Kn
	 zZGTbGXc97uM8lOSWltilVKR/2UB3RstyzJZuavVphd+f04itP6R3yOAwBnV0nj3JhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C0J+40ynMWxKBpCxy/o8FkTMjBOGygp/kGX2oFQRYFw=;
	b=klYLuSDd04hqr+TqG8WOraU7RxGXDoKE2rtA9q7v5Cu7QEKpGdPOwBJOc4Cu049n8JRA
	 vhLdm0p3YZWeOWshHBDzslq+RB2gAvkywFpLc4lGbZTy1hW+nuo1klFaGnzouhwt+nQqi
	 EKYx4TkQAipcDcFKkCM6MLtxHh+d9tQZpjkFig7TkWS/orjyLt3btAu9BEjXifExGEBEF
	 RcrBkjp8s7ZXes1JIuZF9GCbOwx8NcHCbzR/CuEpqBnfML421DPZ+iLCgOPto0J71RYgg
	 xkLLe3PrMgYAttjbQNNZbtJyZpIJ3hi1e86hBrIaTrrh3wtGVr3ltfhw3sbelr5jC1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTtMMWFH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF83606A31B
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTtMMWFH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347821F000C5;
	Tue, 20 Oct 2026 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497842;
	bh=C0J+40ynMWxKBpCxy/o8FkTMjBOGygp/kGX2oFQRYFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTtMMWFHKNkZ39bYXmaitWVISSg7lCKOA0N8KPvh7mNscZKiTPzh6NVlO+fflej17
	 8thvMK1c/liH8IN5UDw8I++NeQekOvIcKRKHY5KceP5RDXe5+TO4QIPfDpq6ghZeP5
	 HvWVVY1JQrUD+2UDnHNuoByNoXLdCiO3vH4YHVQBKNY0DwYDpA1b0XUt159jQgJ9zn
	 jHP6LBcGCx/+GpZhnf7Ih6OSEe1zAqLS/MX/6eG/x75VmrMOsMzHXqbbm4DOWJV9Ud
	 /a1H/dxPSzIOQ7I1bu8e4R5/1txHrl/VAwtxBqs+yATX/lwzl1NGf5kypA1cF63obL
	 psYf+LoZjRT0A==
Message-ID: <sashiko-outbox-178921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 5/8] net: resolve uncommon partial checksums at
 ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:04:01 +0000
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
- [High] net: skb_checksum_help() in virtio_net_hdr_to_skb() skips shared f=
rag copy
- [High] net: virtio_net_hdr_tnl_to_skb() corrupts non-GSO skb state on tun=
nel hdr
- [High] net: virtio_net_l4_start() skips IPv6 NEXTHDR_AUTH by omitting IP6=
_FH_F_AUTH
- [High] net: virtio_net_l3_start() L2/L3 offset and protocol mismatch on l=
o and AF_PACKET
--

commit 338a1355fe27c4686a83ea9e73bf390729be2308
Author: Michael S. Tsirkin <mst@redhat.com>

net: resolve uncommon partial checksums at ingress

This commit validates csum_start and csum_offset at ingress so that
CHECKSUM_PARTIAL is only retained when matching a parsed TCP or UDP
header. Non-GSO packets with unrecognized checksum offsets are completed
immediately in software via skb_checksum_help(), while unrecognized GSO
packets are dropped.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea0..97b554ef7123f 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
[ ... ]
> @@ -48,6 +52,198 @@ static inline int virtio_net_hdr_set_proto(struct sk_=
buff *skb,
[ ... ]
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
> +	if (skb->dev->type =3D=3D ARPHRD_ETHER) {
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		*nhoff =3D ETH_HLEN;
> +		*proto =3D eth_hdr(skb)->h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto =3D __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		*nhoff =3D skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >=3D skb->len)
> +			return false;
> +		*proto =3D skb->protocol;
> +		if (!*proto) {
> +			u8 version;
> +
> +			/* A packet socket bound to ETH_P_ALL leaves the
> +			 * protocol unset: infer it from the IP version
> +			 * nibble at the network header.
> +			 */
> +			if (!pskb_may_pull(skb, *nhoff + 1))
> +				return false;
> +			version =3D skb->data[*nhoff] >> 4;
> +			if (version =3D=3D 4)
> +				*proto =3D htons(ETH_P_IP);
> +			else if (version =3D=3D 6)
> +				*proto =3D htons(ETH_P_IPV6);
> +		}
> +	}
> +	return true;
> +}

[Severity: High]
Can virtio_net_l3_start() disagree with the networking stack on the L3
offset and protocol when packets are sent via AF_PACKET (packet_snd() or
tpacket_snd()) with PACKET_VNET_HDR enabled?

First, on loopback (where dev->type is ARPHRD_LOOPBACK, but
dev->hard_header_len is ETH_HLEN and loopback_xmit() calls
eth_type_trans()), virtio_net_l3_start() takes the else branch and sets
*nhoff =3D skb_network_offset(skb) (14) without inspecting eth_hdr(skb) or
VLAN tags:

drivers/net/loopback.c:loopback_xmit() {
	skb->protocol =3D eth_type_trans(skb, dev);
}

If a packet on lo has eth_hdr(skb)->h_proto =3D htons(ETH_P_8021Q) and a
4-byte 802.1P priority tag (VLAN ID 0) with h_vlan_TCI =3D htons(0x6000) and
h_vlan_encapsulated_proto =3D htons(ETH_P_IP), virtio_net_l3_start() and
virtio_net_l4_start() can validate a fake IPv6 header starting at the VLAN
tag (offset 14), while loopback_xmit() -> __netif_receive_skb_core() ->
skb_vlan_untag() strips the 4-byte tag and delivers the inner IPv4 packet
at offset 18 with CHECKSUM_PARTIAL retained at the unvalidated offset.

Second, on ARPHRD_ETHER devices, virtio_net_l3_start() always uses
eth_hdr(skb)->h_proto and advances *nhoff past VLAN tags via
__vlan_get_protocol(), whereas AF_PACKET SOCK_RAW preserves a
user-supplied sll_protocol in skb->protocol and packet_parse_headers()
only advances skb->network_header when eth_type_vlan(skb->protocol) is
true:

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

If sll_protocol is ETH_P_IP while eth_hdr(skb)->h_proto is ETH_P_8021Q (or
vice versa), wouldn't virtio_net_l3_start() validate csum_start against a
different protocol and network header offset than what skb->protocol and
skb->network_header represent for downstream processing?

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
> +			*ip_proto =3D ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);
> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}

[Severity: High]
Should flags in virtio_net_l4_start() be initialized to IP6_FH_F_AUTH
before calling ipv6_find_hdr()?

In ipv6_find_hdr(), NEXTHDR_AUTH is only treated as a terminal header when
IP6_FH_F_AUTH is passed in flags; otherwise it skips ipv6_authlen(hp)
bytes and continues walking into the following header:

net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
		} else if (nexthdr =3D=3D NEXTHDR_AUTH) {
			if (flags && (*flags & IP6_FH_F_AUTH) && (target < 0))
				break;
			hdrlen =3D ipv6_authlen(hp);
		} else
}

Downstream parsers such as nft_set_pktinfo_ipv6() (which sets flags =3D
IP6_FH_F_AUTH) and __skb_flow_dissect() stop at NEXTHDR_AUTH rather than
skipping it. With flags =3D 0, an IPv6 packet carrying NEXTHDR_AUTH followed
by TCP or UDP passes virtio_net_csum_partial_ok_at_offset() and retains
CHECKSUM_PARTIAL, allowing later checksum completion to overwrite the 2
bytes at csum_start + csum_offset after netfilter or flow-dissector
inspection, and also allowing IPv6+AH GSO packets through even though
ipv6_gso_pull_exthdrs() does not support IPPROTO_AH.

[ ... ]
> +/*
> + * Handle a packet whose checksum metadata does not match the packet:
> + * GSO packets are dropped, as segmentation needs one checksum per
> + * segment; others are completed in software.
> + *
> + * Return 1 if the checksum was completed in software, else a negative
> + * errno.
> + */
> +static inline int virtio_net_resolve_csum_partial_mismatch(struct sk_buf=
f *skb)
> +{
> +	if (skb_is_gso(skb))
> +		return -EINVAL;
> +
> +	return skb_checksum_help(skb) ?: 1;
> +}

[Severity: High]
When virtio_net_resolve_csum_partial_mismatch() calls skb_checksum_help()
from virtio_net_hdr_to_skb() or virtio_net_hdr_tnl_to_skb(), does
skb_checksum_help() miss copying shared zerocopy fragments because
skb_zcopy_init() has not been called yet?

In skb_checksum_help(), shared fragments are linearized before computing
the checksum so that userspace cannot modify the payload pages after the
checksum is calculated:

net/core/dev.c:skb_checksum_help() {
	/* Before computing a checksum, we should make sure no frag could
	 * be modified by an external entity : checksum could be wrong.
	 */
	if (skb_has_shared_frag(skb)) {
		ret =3D __skb_linearize(skb);
		if (ret)
			goto out;
	}
}

However, skb_has_shared_frag(skb) checks SKBFL_SHARED_FRAG in
skb_shinfo(skb)->flags, which is only set when skb_zcopy_init() runs.
In tun_get_user(), tap_get_user(), and tpacket_snd(), the userspace pages
are attached to the skb first, then virtio_net_hdr_to_skb() (or
tun_vnet_hdr_tnl_to_skb() / tun_vnet_hdr_to_skb()) is called, and
skb_zcopy_init() is only called afterwards:

drivers/net/tun.c:tun_get_user() {
	err =3D tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
	...
	/* copy skb_ubuf_info for callback when skb has no error */
	if (zerocopy) {
		skb_zcopy_init(skb, msg_control);
	}
}

drivers/net/tap.c:tap_get_user() {
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

net/packet/af_packet.c:tpacket_snd() {
		if (has_vnet_hdr) {
			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
				tp_len =3D -EINVAL;
				goto tpacket_error;
			}
		}
		...
		uarg->ubuf.flags =3D SKBFL_ZEROCOPY_FRAG;
		refcount_set(&uarg->ubuf.refcnt, 1);

		/* Hold a sk_wmem_alloc reference until completion */
		refcount_inc(&po->sk.sk_wmem_alloc);
		skb_zcopy_init(skb, &uarg->ubuf);
}

Because SKBFL_SHARED_FRAG is not set yet when
virtio_net_resolve_csum_partial_mismatch() calls skb_checksum_help(),
skb_has_shared_frag(skb) returns false, __skb_linearize(skb) is skipped,
and the packet proceeds with skb->ip_summed =3D CHECKSUM_NONE while its
fragments remain backed by writable userspace pages.

[ ... ]
> @@ -335,9 +586,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> @@ -353,7 +607,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	}
> =20
>  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +			    htons(ETH_P_IP));
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -368,7 +622,17 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> +	return virtio_net_resolve_csum_partial_mismatch(skb);
>  }

[Severity: High]
What happens in virtio_net_hdr_tnl_to_skb() when a packet carries a tunnel
GSO type in hdr->gso_type, but its length is not greater than gso_size?

In __virtio_net_hdr_to_skb(), small packets do not populate
shinfo->gso_size or shinfo->gso_type:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
		/* Too small packets are not really GSO ones. */
		if (skb->len - nh_off > gso_size) {
			shinfo->gso_size =3D gso_size;
			shinfo->gso_type =3D gso_type;

			/* Header must be checked, and gso_segs computed. */
			shinfo->gso_type |=3D SKB_GSO_DODGY;
			shinfo->gso_segs =3D 0;
		}
}

Because shinfo->gso_size remains 0, skb_is_gso(skb) is false, but
virtio_net_hdr_tnl_to_skb() still sets shinfo->gso_type |=3D
SKB_GSO_UDP_TUNNEL_CSUM (or SKB_GSO_UDP_TUNNEL), sets inner header offsets
from vhdr->inner_nh_offset and hdr->csum_start, overwrites
skb->transport_header, and sets skb->encapsulation =3D 1.

If virtio_net_csum_partial_ok_at_offset() then returns false,
virtio_net_resolve_csum_partial_mismatch(skb) sees !skb_is_gso(skb),
completes the inner checksum via skb_checksum_help(), and returns 1
without cleaning up the tunnel state on the skb. That leaves the non-GSO
skb with skb->encapsulation =3D 1, unvalidated inner header offsets, a
non-zero shinfo->gso_type with gso_size =3D=3D 0 (which triggers
WARN_ON_ONCE(1) in tun_vnet_hdr_tnl_from_skb() if forwarded to another
tun/virtio interface), and an uncomputed outer UDP checksum when
VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM was set.

Conversely, if the payload at the caller-chosen vhdr->inner_nh_offset
happens to look like a valid IP + TCP/UDP header,
virtio_net_csum_partial_ok_at_offset() returns true on this non-GSO UDP
packet, allowing CHECKSUM_PARTIAL to be retained at an arbitrary offset
inside the UDP payload. Should virtio_net_hdr_tnl_to_skb() reject packets
where !skb_is_gso(skb) after __virtio_net_hdr_to_skb()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D5
