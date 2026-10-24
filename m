Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854591;
	b=yyy/NpHLSTUBxJdrwNV+Ef54GsYCxvWl7pxO1CS6lODjS6O8IFIgBYGIZkqiO8rZBGCt
	 8TAYgv2Ssnx1m6NkjCEc80oLLrGvWdZ34nu61nYrbVDjHaA2LBE20w2LRKE8FdkLrJ2wv
	 nuyrkbU2dBFVVKPQfgt1jtzBTkAQyUhz67lGz8imfQDpvFVhEVrusX9qalam02I5pqBjs
	 DNm2gjTcc8Sb27wFxUIs3OO9hdLRP4un+TrMFD7Ub8T8Bdtj2r23E1vb22a+sADWCWlRS
	 ucqSZi0sZVM96+ktmjpXCo+ku1jgcIdW0yosvDquAOmwuGoIhKwjoSag/HuERy6SH3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854591;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CkZVlmyPaijaOpPJcYvkZLGTul5ivF7ZZt1hjDsnSFY=;
	b=m7pS5I+VSmdnAFhZoaCJwE6bxXz8lrSI5wfhlQtq7H3zhbdy4IAFgf2syK626sI9MNH4
	 b2Ze4YbIK8/Tzw6XZEc889qLRRxIAJy04Utxvkerh9lNiCDqw7wuw6dclObvgJI9rO6tB
	 JbQBe/Em4O0/yxMYgLCxVAvwitWqYI/kDttH5fUE6YKVyRbtbbcq6V0NTNIo+0N8G3JN3
	 S4nnliw8dv4TxEr5V1DrMiEr05f3h0X7N7H4y8ydSfkBLgIbwDAcjv8AZvFIxsoc08loN
	 JWduGBfvSTKiQVuNmishejuQAv2pvCU0QGJBQZUU3Pk8fJWTyEhxofoUui356I6P/Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CejGk26g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78788606A31F
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CejGk26g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2471F01828;
	Sat, 24 Oct 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792854591;
	bh=CkZVlmyPaijaOpPJcYvkZLGTul5ivF7ZZt1hjDsnSFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CejGk26glOlIOyDTOvlljCCSAjuG846tNRjIMLMSJMsD2hskVTUtrUFH9+/T5G4ZY
	 lDWAdvOf7S55R8O6mO/qaWjjU63HKi8CsG7K8s4b+Qw64/RrqtmIxCbOG0MpgsBEA2
	 CBafbUpKJ9zg8lF8sJwdYA8VP4uBXwd9n2T7IEPHWDCzNKqP4He8LRyQnu9CKQO0Wg
	 h6v3gqzACTC6V0SBulp7algHD4pkNL43stvrWFE4Ip//v0FFdnKmqpnmdblYeyxliz
	 esWs6jCYBkCOBQXItCiiJSO4tRgDT7bJRw2qubCpAzU69KC8Rtft+Oc4SzxRgZ3lAe
	 fUXuA/GNA1Wew==
Message-ID: <sashiko-outbox-183770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 4/5] net: resolve uncommon partial checksums at
 ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
 <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 15:09:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: virtio_net_hdr_tnl_to_skb() retains untrusted inner state and=
 csum
--

commit fe9720049eff45b73b2666232bd03b5f28b7c81f
Author: Michael S. Tsirkin <mst@redhat.com>

net: resolve uncommon partial checksums at ingress

This commit validates virtio_net_hdr checksum offsets against parsed L3 and=
 L4
headers on ingress, completing non-GSO checksums in software and dropping G=
SO
packets when the checksum metadata does not match a known TCP or UDP header.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea0..14120710d0753 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -352,8 +621,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			return -EINVAL;
>  	}
> =20
> -	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +	inner_proto =3D inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	skb_set_inner_protocol(skb, inner_proto);
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -368,7 +637,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +						 inner_proto))
> +		return 0;
> +
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }

[Severity: High]
When a packet arrives through tun_get_user() -> tun_vnet_hdr_tnl_to_skb() or
virtnet_receive_done() -> virtio_net_hdr_tnl_to_skb() with
VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 or VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 and
a gso_size large enough that __virtio_net_hdr_to_skb() does not mark the skb
as GSO (skb->len - nh_off <=3D gso_size, so !skb_is_gso(skb)), can this han=
dling
in virtio_net_hdr_tnl_to_skb() leave untrusted inner header state and parti=
al
checksums active on non-GSO packets?

First, when !skb_is_gso(skb) and virtio_net_csum_partial_ok_at_offset()
returns false because the inner offsets or headers are invalid,
__virtio_net_resolve_csum_partial_mismatch() completes the checksum via
skb_checksum_help() and returns 1. However, virtio_net_hdr_tnl_to_skb() has
already set skb->encapsulation =3D 1, skb->inner_protocol,
skb->inner_transport_header, skb->inner_network_header, and
skb->inner_mac_header from the unvalidated vhdr->inner_nh_offset and
hdr->csum_start.

If that non-GSO packet is later forwarded into an IP tunnel,
iptunnel_handle_offloads() in net/ipv4/ip_tunnel_core.c checks:

	if (likely(!skb->encapsulation)) {
		skb_reset_inner_headers(skb);
		skb->encapsulation =3D 1;
	}

Because skb->encapsulation is already 1, skb_reset_inner_headers() is skipp=
ed
and ip_tunnel_xmit() / ip_md_tunnel_xmit() read skb_inner_network_header(sk=
b)
at the unvalidated inner_nh offset. Drivers and stack paths that inspect
skb->encapsulation on non-GSO packets, such as mlx4_en_xmit() in
drivers/net/ethernet/mellanox/mlx4/en_tx.c:

	if (skb->encapsulation) {
		...
		ip.hdr =3D skb_inner_network_header(skb);
		proto =3D (ip.v4->version =3D=3D 4) ? ip.v4->protocol :
						ip.v6->nexthdr;

as well as netif_skb_features(), i40e_features_check(), ice_features_check(=
),
udp_gro_receive(), xfrm_get_inner_ipproto(), geneve_rx(), skb_mpls_push(), =
and
bpf_skb_adjust_room(), will also act on the unvalidated inner header offset=
s.

Second, virtio_net_tnl_offsets_ok() only verifies that the outer L3 header =
is
followed by UDP at outer_th, while inner_nh is taken directly from the
untrusted vhdr->inner_nh_offset (requiring only inner_nh >=3D outer_th +
sizeof(struct udphdr)). On a non-GSO UDP packet (!skb_is_gso(skb)), can a
sender place fake IP and UDP headers at a chosen offset inner_nh inside the
UDP payload (or inside an inner Ethernet/VXLAN header) so that
virtio_net_csum_partial_ok_at_offset() succeeds and returns 0, keeping
CHECKSUM_PARTIAL at an arbitrary offset inside the UDP payload where later
checksum completion modifies the packet after protocol or firewall inspecti=
on?

Third, when !skb_is_gso(skb) and virtio_net_csum_partial_ok_at_offset()
returns true, clearing SKB_GSO_UDP_TUNNEL_CSUM drops the outer UDP tunnel
checksum request while leaving skb->ip_summed =3D=3D CHECKSUM_PARTIAL point=
ing to
inner_th. If the packet is delivered locally to udp_rcv() -> udp4_csum_init=
(),
skb_csum_unnecessary() in include/linux/skbuff.h:

	return ((skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) ||
		skb->csum_valid ||
		(skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
		 skb_checksum_start_offset(skb) >=3D 0));

evaluates to true at the outer UDP layer while udp_unexpected_gso() is fals=
e,
skipping outer UDP checksum validation and leaving the inner checksum
uncompleted.

Should virtio_net_hdr_tnl_to_skb() reject or avoid setting tunnel
encapsulation and inner CHECKSUM_PARTIAL state when !skb_is_gso(skb), and o=
nly
populate skb->encapsulation and skb->inner_* after the inner headers have b=
een
validated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792768096.gi=
t.mst@redhat.com?part=3D4
