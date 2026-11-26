Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709234;
	b=DzPMR2F8yEDau67doe2pGTuGqy/urx9p1VYy8ZzD7JdmT/o2l4z6+25xaGFiR7NCRGn/
	 1jWLayEil9ogVo8v8mTtlegFuTOUv22D0ALqhbJ2OjsG3HiYtL3A1opV9/PNilOBKuuRw
	 v7Ef+9Y+8qLwehVRkQhobecLrBNXjZ69bDOePelRj8TCQV/3pIKtBw9EUd99+NSWXG6Jr
	 Fmc43BzXPsU6Eot3Dl5ju0cFhVm1Pimekop/VuknJzz/pvxKYM7KCdAir9j5Ciaf/xn8i
	 j2C/nwv+s8k8hh+sYVEdlFKA3zTHAFJH6DCxgTid8I3A/pth1MP2y3+o/8Zgwqi/DvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ERh6nOxAFDVCRhKfHQCmQuJurhpbxgAslUy/9JN2wyc=;
	b=NryKknVtqMiyAdZriSy9R6JaXBf5PqnfgckiivFJv7msDxt3twVhehzrlExMJxxanSBd
	 v8XWpdwEAIRNa7pQNqPcce6HnNqAPvwpq3VaoQVikwD0GLujxfsgpyp4gZNdUdEC3pe9A
	 F9saL82iUQ1l4ysRRbuZITTEJwdtMYLUSUkYCx0CSWuo3N15C5V3wpULYa7eWPGL1MjSv
	 JEVPPsjPhv6l3Ns1+E0yLNmhw80eJJQ12nVOteqhQGJxa4WIruB/47q85fqDmScnRiV5R
	 pHgWp+le9ui7tPji94IDBn3fadatGEQ5ytUmHrInunAl0KW3pjXYQHiRiG9xQ62lxew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQ6eO0Gc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A3606A326
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQ6eO0Gc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7B61F000C4;
	Thu, 26 Nov 2026 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709233;
	bh=ERh6nOxAFDVCRhKfHQCmQuJurhpbxgAslUy/9JN2wyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQ6eO0GcNIsLVKF6uFcDQV09UA5s4aLGRgeKQsw2XcvOnz0NrjnvLHuFmcnha0FVo
	 PxoNvja/IQe2iSUDw5mhOzw6kGy0y6B9llwapXEQUfnzLaV1DVuguY/k8bqNoNUdbA
	 KF5MkzHRoVdTUWr7EK6q0alhxACu2RDoImpXq2Y0PETePxSQByUafTiOs9Knhs+wbX
	 L9VT8BPZcxI2eH2yEXgj7xSKB/GlNs0ABkdTpw0d5Q10V6zc0zbC7PiJS4slI9MK2O
	 DaZbaBTIlIlj29JisxpBp0N7dkRKRX00pe5QzW7sMfdHTn+eVfm6ew+Q2S0fxq3yGh
	 LxKlG6fBNdhEQ==
Message-ID: <sashiko-outbox-235877@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v8 4/6] net: resolve uncommon partial checksums
 at ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Showta Ishizaki" <zakinko@snowrabbit.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261126.rfcv8.99797.4.zakinko@snowrabbit.org>
References: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
 <20261126.rfcv8.99797.4.zakinko@snowrabbit.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 16:07:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] net/packet: framing mismatch in packet_vnet_hdr_to_skb() via
  dev->type
- [Medium] net: packet: skb->protocol set after validation in
  packet_vnet_hdr_to_skb()
--

commit 4a97d36173ad7a2c090af1623638b2b508d7f3b0
Author: Michael S. Tsirkin <mst@redhat.com>

net: resolve uncommon partial checksums at ingress

This commit validates virtio_net_hdr csum_start and csum_offset against
parsed TCP or UDP headers at ingress, retaining CHECKSUM_PARTIAL only when
they match and completing non-GSO checksums or dropping GSO packets when
they do not.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 930e85e4bf739..c07a0196911b5 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2778,6 +2778,16 @@ static int tpacket_parse_header(struct packet_sock=
 *po, void *frame,
>  	return tp_len;
>  }
> =20
> +/* The device says how its frames start. */
> +static int packet_vnet_hdr_to_skb(struct sk_buff *skb,
> +				  const struct virtio_net_hdr *vnet_hdr)
> +{
> +	bool has_eth =3D skb->dev->type =3D=3D ARPHRD_ETHER ||
> +		       skb->dev->type =3D=3D ARPHRD_LOOPBACK;
> +
> +	return virtio_net_hdr_to_skb(skb, vnet_hdr, has_eth, vio_le());
> +}

[Severity: Medium]
Can deriving has_eth from skb->dev->type cause packet_vnet_hdr_to_skb() to
parse a different frame layout than packet_snd(), tpacket_fill_skb() and
packet_parse_headers()?

As noted above virtio_net_l3_start(), ioctl(TUNSETLINK) changes dev->type on
a tun or tap device without changing dev->hard_header_len or dev->header_op=
s.
On an IFF_TUN device whose dev->type is set to ARPHRD_ETHER via TUNSETLINK,
packet_snd() places the L3 header at offset 0, but packet_vnet_hdr_to_skb()
passes has_eth =3D true.  virtio_net_l3_start() then treats the first 14 by=
tes
of the L3 header as an Ethernet header and validates csum_start and
csum_offset against a fake L3/L4 header inside the payload, retaining
CHECKSUM_PARTIAL while packet_parse_headers() leaves skb->network_header at
offset 0 and derives skb->protocol from the real L3 header via
ip_tunnel_parse_protocol().

In addition, packet_vnet_hdr_to_skb() includes ARPHRD_LOOPBACK in has_eth, =
so
virtio_net_l3_start() walks past VLAN tags at ETH_HLEN when validating the
headers, whereas packet_parse_headers() only advances skb->network_header p=
ast
VLAN tags when skb->dev->type =3D=3D ARPHRD_ETHER:

net/packet/af_packet.c:packet_parse_headers() {
	...
	if (likely(skb->dev->type =3D=3D ARPHRD_ETHER) &&
	    eth_type_vlan(skb->protocol) &&
	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) !=3D 0)
		skb_set_network_header(skb, depth);
	...
}

> @@ -2941,7 +2951,7 @@ static int tpacket_snd(struct packet_sock *po, stru=
ct msghdr *msg)
>  		}
> =20
>  		if (has_vnet_hdr) {
> -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
> +			if (packet_vnet_hdr_to_skb(skb, &vnet_hdr) < 0) {
>  				tp_len =3D -EINVAL;
>  				goto tpacket_error;
>  			}
> @@ -3163,7 +3173,7 @@ static int packet_snd(struct socket *sock, struct m=
sghdr *msg, size_t len)
>  		skb->no_fcs =3D 1;
> =20
>  	if (vnet_hdr_sz) {
> -		err =3D virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> +		err =3D packet_vnet_hdr_to_skb(skb, &vnet_hdr);
>  		if (err < 0)
>  			goto out_free;
>  		len +=3D vnet_hdr_sz;

[Severity: Medium]
Should packet_parse_headers() and virtio_net_hdr_set_proto() run before
packet_vnet_hdr_to_skb() in tpacket_snd() and packet_snd()?

When the caller passes proto =3D=3D htons(ETH_P_ALL) or 0, skb->protocol is=
 still
0 when packet_vnet_hdr_to_skb() runs, so virtio_net_l3_start() skips its
skb->protocol consistency check.  After validation succeeds and retains
CHECKSUM_PARTIAL and GSO, packet_parse_headers() and
virtio_net_hdr_set_proto() populate skb->protocol.  Whenever
packet_parse_headers() leaves skb->protocol as 0 (for example on SOCK_DGRAM
sockets, or on SOCK_RAW sockets bound to devices without
header_ops->parse_protocol), virtio_net_hdr_set_proto() unconditionally sets
skb->protocol =3D htons(ETH_P_IP) for VIRTIO_NET_HDR_GSO_UDP_L4 and
VIRTIO_NET_HDR_GSO_UDP even when virtio_net_csum_partial_ok() just validated
an IPv6 packet, causing downstream GSO and transmit paths to process the IP=
v6
packet as IPv4.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126.rfcv8.9979=
7.0.zakinko@snowrabbit.org?part=3D4
