Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386451;
	b=xIC6VO6dQYvWTUb5bQbmM2m774VZLhjr9EB2fz4Vg8uVD24mA/NclXUKaNfrimiJp/wC
	 DcFsIlVnepo06Ho+K1QQisu/NKf49uo7vuomXssePwEPmwd61JmxK2JMzoWizZye9zGky
	 Dsqcs2n3DIZEckGhQjVEOjfZQBPY57u1j2uB5Ha6kRN7SJ6h1otfWTxPl10d2CTbEEydq
	 ABUPBEHdupugrstQoJNXjbwQyVyaUwVgP6bJlxETUUBvu79i+xzznW2bdnd7Ryisy6XIa
	 Qo7UIKxJTjUzGoYX5m15qt4rGgWZsHj1OeqBFTBIJyY3eAE+uyuZod2a6ydI97lhufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VNUPRxE5vW3rvsBbLZlT3UE72DiwhSKoqVxOQxQtvM0=;
	b=NMNCmg20OJ5KKVkEv64BpcnGwYtmDGMtmDJLDblMU1DmBs+LpuSBb6GDDuvNw4UUZyxe
	 UDfeD+ScigBLuRK8WnTZnlqByI5FauLuGwrogyNT6Qxbq4WUPkaoOjNxZ5NzaGXkmalD7
	 2j0L+uoLoBWcJpSCewTHyBe3jl/pzQ12d0z5ee7gddIBCiT7QbwltKyXCHY/96IV3xlrl
	 f1nKbYVs1HPBKqqXejk19EgnSDQkZqZUuacSMvQM0MnJdaC4MtBUtgcuinE6//UsXApYU
	 YYCxUM5TsnjntEDsGWv9eHBKv17JYZ3oYMWEYMAJan5jE8GUJqbTHXLukawzwVHwLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtiiC5ZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17484606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtiiC5ZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50AE1F0093A;
	Fri, 30 Oct 2026 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386451;
	bh=VNUPRxE5vW3rvsBbLZlT3UE72DiwhSKoqVxOQxQtvM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HtiiC5ZXPA6DU557HcUGxsqpUHsjkXlWbM8cPMXVHrNTk/QQqHxTrStBqoIVnP+Dv
	 vtLFskG7qvPf5L1mlew//U83Tu4r834mQBjwRctrGxXVR1yvlSJgdhZkvI5Z4WPM3g
	 hO2ByJQpfLWbpJzOsRVaXJMxdYKlZgwLT8qjZ4HAOF7B06iW6+mmfO/SFDKG11J7sP
	 vhQaghZcHfFUi/cnbPh9dIIeW4ysEuj5ypRnsD0k/GiQC0FnaRsPwzP8jxM/JqdSF/
	 IjLgJIbTsGNFD/F4jsBiQSZ83puZ95IjJLD6JGUyB1ZwkTXhE+osW+BkXKmeDKG0af
	 HL0e//oK2NgEg==
Message-ID: <sashiko-outbox-191420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v7 4/5] net: resolve uncommon partial checksums at
 ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
 <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:54:10 +0000
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
- [High] net: skb->protocol mismatch in virtio_net_l3_start() when unset
- [High] net: uncompleted csum in virtio_net_hdr_tnl_to_skb() for non-GSO
--

commit e848d2c54d731e54131a7b7019dc30d4e0367ad9
Author: Michael S. Tsirkin <mst@redhat.com>

net: resolve uncommon partial checksums at ingress

This patch validates csum_start and csum_offset in virtio_net_hdr_to_skb() =
and
virtio_net_hdr_tnl_to_skb() against parsed TCP and UDP headers, completing
partial checksums in software for non-GSO packets when validation fails and
dropping unrecognized GSO packets.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea0..54048759cc6ec 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	/* skb->dev should always be set here already,
> +	 * but let's not crash when it is not.
> +	 */
> +	if (WARN_ON_ONCE(!skb->dev))
> +		return false;
> +
> +	if (skb->dev->type =3D=3D ARPHRD_ETHER ||
> +	    skb->dev->type =3D=3D ARPHRD_LOOPBACK) {
> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto =3D eth_hdr(skb)->h_proto;
> +		/* skb->protocol is a sender claim, and parts of the
> +		 * stack parse the packet per it: when it disagrees with
> +		 * the frame we do not know which view the packet will
> +		 * be parsed as, so do not validate.
> +		 */
> +		if (skb->protocol && skb->protocol !=3D h_proto)
> +			return false;
> +		*nhoff =3D ETH_HLEN;
> +		*proto =3D h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto =3D __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		const struct iphdr *iph;
> +
> +		*nhoff =3D skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >=3D skb->len)
> +			return false;
> +		/* No L2 header to cross-check with: take the protocol
> +		 * from the IP version at the network header.
> +		 */
> +		if (!pskb_may_pull(skb, *nhoff + 1))
> +			return false;
> +		iph =3D (const struct iphdr *)(skb->data + *nhoff);
> +		if (iph->version =3D=3D 4)
> +			*proto =3D htons(ETH_P_IP);
> +		else if (iph->version =3D=3D 6)
> +			*proto =3D htons(ETH_P_IPV6);
> +		else
> +			return false;
> +		if (skb->protocol && skb->protocol !=3D *proto)
> +			return false;
> +	}
> +	return true;
> +}

[Severity: High]
Can virtio_net_l3_start() validate a packet as ETH_P_IPV6 when skb->protocol
is unset (0), only for the caller to later set skb->protocol to ETH_P_IP or
leave it as 0?

In net/packet/af_packet.c, both packet_snd() and tpacket_snd() invoke
virtio_net_hdr_to_skb() before setting skb->protocol:

net/packet/af_packet.c:packet_snd() {
	...
	if (vnet_hdr_sz) {
		err =3D virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
		if (err < 0)
			goto out_free;
		len +=3D vnet_hdr_sz;
	}

	packet_parse_headers(skb, sock);

	if (vnet_hdr_sz)
		virtio_net_hdr_set_proto(skb, &vnet_hdr);
	...
}

When a packet is sent with proto =3D=3D 0 (or htons(ETH_P_ALL)) on a
non-ARPHRD_ETHER, non-ARPHRD_LOOPBACK device (such as tun in IFF_TUN mode,
sit, ipip, gre, or wg), skb->protocol is 0 when virtio_net_hdr_to_skb() run=
s.

If the L3 header has iph->version =3D=3D 6, virtio_net_l3_start() sets
*proto =3D htons(ETH_P_IPV6) and allows skb->protocol =3D=3D 0. Then
virtio_net_csum_partial_ok_at_offset() walks the IPv6 header and any IPv6
extension headers, and for VIRTIO_NET_HDR_GSO_UDP or
VIRTIO_NET_HDR_GSO_UDP_L4 it only checks ip_proto =3D=3D IPPROTO_UDP:

include/linux/virtio_net.h:virtio_net_csum_partial_ok_at_offset() {
	...
	case VIRTIO_NET_HDR_GSO_UDP:
	case VIRTIO_NET_HDR_GSO_UDP_L4:
		return ip_proto =3D=3D IPPROTO_UDP;
	...
}

After virtio_net_hdr_to_skb() succeeds and retains CHECKSUM_PARTIAL at the
IPv6 transport offset, packet_parse_headers() leaves skb->protocol as 0 on
devices without header_ops->parse_protocol (or SOCK_DGRAM), and
virtio_net_hdr_set_proto() unconditionally overwrites skb->protocol with
ETH_P_IP:

include/linux/virtio_net.h:virtio_net_hdr_set_proto() {
	if (skb->protocol)
		return 0;

	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
	case VIRTIO_NET_HDR_GSO_TCPV4:
	case VIRTIO_NET_HDR_GSO_UDP:
	case VIRTIO_NET_HDR_GSO_UDP_L4:
		skb->protocol =3D cpu_to_be16(ETH_P_IP);
		break;
	...
}

The packet then enters packet_xmit() with skb->protocol =3D=3D htons(ETH_P_=
IP)
despite having been validated as IPv6, so inet_gso_segment() and flow
dissection parse the IPv6 header as IPv4 while csum_start points to the IPv6
extension-header-derived offset. Similarly, when hdr->gso_type is
VIRTIO_NET_HDR_GSO_NONE in packet_snd() / tpacket_snd(), or when pi.proto =
=3D=3D 0
in tun_get_user() on an IFF_TUN device without IFF_NO_PI, skb->protocol
remains 0 after validation.

Should virtio_net_l3_start() reject skb->protocol =3D=3D 0 (or ensure
skb->protocol is populated with the validated protocol)?

[ ... ]

> @@ -335,9 +604,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> @@ -352,9 +624,29 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			return -EINVAL;
>  	}
> =20
> -	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +	inner_proto =3D inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +
> +	/*
> +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_s=
kb
> +	 * set CHECKSUM_PARTIAL.
> +	 */
> +	if (unlikely(!virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type,
> +							  inner_nh,
> +							  inner_proto))) {
> +		/* __virtio_net_hdr_to_skb set the transport header to
> +		 * csum_start, restore it to a known good value.
> +		 */
> +		skb->transport_header =3D old_transport;
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
> =20
> @@ -368,6 +660,21 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header =3D inner_nh + skb_headroom(skb);
>  	skb->transport_header =3D outer_th + skb_headroom(skb);
>  	skb->encapsulation =3D 1;
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
> +		skb_shinfo(skb)->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL_CSUM |
> +					       SKB_GSO_UDP_TUNNEL);
> +	}
> +
>  	return 0;
>  }

[Severity: High]
In virtio_net_hdr_tnl_to_skb(), when a packet tagged with a tunnel GSO type=
 is
too small to segment (!skb_is_gso(skb)), the comment states "Too small to
segment: complete the checksum in place instead of dropping", but doesn't t=
his
block only clear the tunnel GSO flags while leaving CHECKSUM_PARTIAL
uncompleted?

When __virtio_net_hdr_to_skb() sees skb->len - nh_off <=3D gso_size, it doe=
s not
set shinfo->gso_size, so skb_is_gso(skb) is false. If
virtio_net_csum_partial_ok_at_offset() succeeds, virtio_net_hdr_tnl_to_skb()
reaches the !skb_is_gso(skb) block without calling skb_checksum_help() (or
__virtio_net_resolve_csum_partial_mismatch()):

1. Because inner_nh (from vhdr->inner_nh_offset) is an untrusted offset ins=
ide
   the outer UDP payload and no tunnel header between outer_th and inner_nh=
 is
   verified, a sender can place a fake 20-byte IPv4 header inside the UDP
   payload of a non-GSO UDP packet with csum_start =3D inner_nh + 20. Both
   virtio_net_tnl_offsets_ok() and virtio_net_csum_partial_ok_at_offset()
   succeed, SKB_GSO_UDP_TUNNEL is cleared, and the non-GSO UDP packet retai=
ns
   CHECKSUM_PARTIAL at an arbitrary offset inside its UDP payload (which can
   later overwrite 2 bytes of payload after netfilter/BPF inspection and ca=
uses
   udp4_csum_init() / udp6_csum_init() to treat the outer UDP checksum as
   unnecessary).

2. If VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM was set, clearing
   SKB_GSO_UDP_TUNNEL_CSUM without completing the inner checksum leaves the
   outer UDP header with an uncompleted non-zero pseudo-header checksum whi=
le
   CHECKSUM_PARTIAL still points to the inner transport header.

3. skb->encapsulation remains set to 1 even though SKB_GSO_UDP_TUNNEL and
   SKB_GSO_UDP_TUNNEL_CSUM are cleared.

4. Conversely, if a !skb_is_gso(skb) packet fails virtio_net_tnl_offsets_ok=
()
   or the inner_th < inner_nh + inner_l3min check earlier in
   virtio_net_hdr_tnl_to_skb(), it returns -EINVAL instead of restoring
   skb->transport_header =3D old_transport and completing the checksum via
   __virtio_net_resolve_csum_partial_mismatch(skb).

Should virtio_net_hdr_tnl_to_skb() resolve !skb_is_gso(skb) packets via
__virtio_net_resolve_csum_partial_mismatch(skb) after restoring
skb->transport_header =3D old_transport?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/305bcadb19f4a539a31=
8c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com?part=3D4
