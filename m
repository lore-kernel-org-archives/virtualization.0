Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953005;
	b=kTR+NCa9be3N1EDH4EPy0sVNJYG4ViEN4wnYHftkVlyUBqUkJLrrshOyJAPKHuWJiO6f
	 BMdMiTVed9PXUgwci0CqRtiQ7ReD1i4+zLGD3yGWCfGNlfLpJ6p6MalrgNesdheZIBEVM
	 kL6VIuEfKMFEUWVI1S7Py5uu7RD9s1hr3ZfG8Qa3W1Wec5Iuna3+Pw8BG/tV+kH+/tcfO
	 vKRyxbxRf12S2T/JgVVlSmwj2SIq9ekVmwx4LK9txlkvx1xORzyzCaUPIx4KdDu8vJQyA
	 KJnmKzZB2oFew/DE1M5vEVcUEcbp7ZL9Bp3vStymBV++cM3wnZfmdIsj6+hb/rleN3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E0tW/qv+05yK0gSh3x4qfa0US334vvfZbioq78DOhQE=;
	b=uylrthxWw7cnIsoxL9Lu7OeE5f/v7yjQjQs7xPSoLlTZ7LDEWwbWJW9SbIqO508VyE0v
	 35XsYreJinKW0Toxv2Un5f02xxW8rALklVWnFMpruew7dNgQmx8iZCC9ESawme7MIZIoM
	 h5z7XQIY0dHofzBf/B+OrbuIGSs7W2AAWEcJPUqp1ThfWpHP2LObDo8ZLXJ8HTrxU43QK
	 bORZ3wNZp7yNLPxtXYhPg/hhDV3AxB5cx/GppfjId4O9URZKLIbqfMqMRJZ2z6wQP+y9W
	 ZpgtFFTY70J/rQj5YmCxI/Wglm7qJ22MO4xtD31leS4raZSGn/U6ClzphhmZZ7vRvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SojAUcp2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D912606A328
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SojAUcp2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4011F008A2;
	Fri,  6 Nov 2026 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953005;
	bh=E0tW/qv+05yK0gSh3x4qfa0US334vvfZbioq78DOhQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SojAUcp25NHUCvUmIAJ1Qp4quKC8ryFUjtzjbk9iSNHMZfAjlrFbVgA2ZvDA6+gH4
	 x9t+4oTWgUc3V15/M6UvkpRVsn6P9oP9gp/qS4nmy8D3jAwE58OYXfB2unlZ8UQ04M
	 uWOXudPns6N8QmSbUSkX3h9O/K2l+BFav+jrDIlWRx3t1+6eNlDKNlF1A86ABM+AY/
	 C249Z7OADjvgWUhJWpyoqpkCZrz3G0mNeUakVqLkydkZjnjHEJeAaaEJhIccOkVZAH
	 VlKPOSar+K1hK2Jd9DZ84SrNK133lHNyZdDg9L4SMUrcnkwHOPUL8d3Znhjh7G6CPB
	 J5EbtDmZvVK9Q==
Message-ID: <sashiko-outbox-201045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 8/8] selftests: net: tuntap: write UDP tunnel
 offsets in little endian
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-9-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-9-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests: net: tun: UDP tunnel GSO tests still fail on
  big-endian hosts
--

commit 19b0a422177cb62b0357c401d17b939feb10dca3
Author: Eric Dumazet <edumazet@kernel.org>

selftests: net: tuntap: write UDP tunnel offsets in little endian

This commit converts the outer_th_offset and inner_nh_offset fields of
struct virtio_net_hdr_v1_hash_tunnel to little-endian in the tuntap
selftests while leaving the base virtio_net_hdr_v1 fields in host byte
order.

> diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing=
/selftests/net/tuntap_helpers.h
> index ecad83fae1582..dc85cd9bc0aec 100644
> --- a/tools/testing/selftests/net/tuntap_helpers.h
> +++ b/tools/testing/selftests/net/tuntap_helpers.h

[ ... ]

> @@ -375,11 +377,14 @@ static inline int build_virtio_net_hdr_v1_hash_tunn=
el(uint8_t *buf, bool is_tap,
>  	inner_iphlen =3D (inner_family =3D=3D AF_INET) ? sizeof(struct iphdr) :
>  						   sizeof(struct ipv6hdr);
> =20
> -	vh_tunnel->outer_th_offset =3D eth_hlen + outer_iphlen;
> -	vh_tunnel->inner_nh_offset =3D vh_tunnel->outer_th_offset + ETH_HLEN +
> -				     GENEVE_HLEN + sizeof(struct udphdr);
> +	outer_th =3D eth_hlen + outer_iphlen;
> +	inner_nh =3D outer_th + ETH_HLEN + GENEVE_HLEN + sizeof(struct udphdr);
> =20
> -	vh->csum_start =3D vh_tunnel->inner_nh_offset + inner_iphlen;
> +	/* The tunnel offsets are always little endian. */
> +	vh_tunnel->outer_th_offset =3D htole16(outer_th);
> +	vh_tunnel->inner_nh_offset =3D htole16(inner_nh);
> +
> +	vh->csum_start =3D inner_nh + inner_iphlen;
>  	vh->csum_offset =3D __builtin_offsetof(struct udphdr, check);
>  	vh->flags =3D VIRTIO_NET_HDR_F_NEEDS_CSUM;
>  	vh->hdr_len =3D hdr_len;

[Severity: Medium]
Will the UDP tunnel GSO tests still fail on big-endian hosts because the
kernel hardcodes little_endian =3D true when delegating the base header fie=
lds
in virtio_net_hdr_tnl_to_skb() and virtio_net_hdr_tnl_from_skb()?

In tools/testing/selftests/net/tun.c, tun_open() does not set TUNSETVNETLE,
so tun_vnet_is_little_endian() is false and __tun_vnet_hdr_get() reads
hdr_len, csum_start, and csum_offset in host order. However, when
tun_vnet_hdr_tnl_to_skb() calls virtio_net_hdr_tnl_to_skb() with
little_endian =3D false:

include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
	...
	inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
	inner_nh =3D le16_to_cpu(vhdr->inner_nh_offset);
	outer_th =3D le16_to_cpu(vhdr->outer_th_offset);
	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;

	/* Let the basic parsing deal with plain GSO features. */
	ret =3D __virtio_net_hdr_to_skb(skb, hdr, true,
				      hdr->gso_type & ~gso_tunnel_type);
	if (ret)
		return ret;

	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
		return -EINVAL;
	...
}

Because __virtio_net_hdr_to_skb() is called with little_endian hardcoded to
true instead of passing little_endian, it byte-swaps the host-order
csum_start, csum_offset, and gso_size on big-endian hosts. That causes
__virtio_net_hdr_to_skb() to return -EINVAL (either in pskb_may_pull() or t=
he
skb->csum_offset check) before virtio_net_tnl_offsets_ok() is reached in
tun_vnet_udptnl_proto, tun_vnet_udptnl_proto_l3, and tun_vnet_udptnl.

Similarly, on the receive path in virtio_net_hdr_tnl_from_skb():

include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
	...
	/* Let the basic parsing deal with plain GSO features. */
	skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
	ret =3D virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
	skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
	...
}

virtio_net_hdr_from_skb() is also called with little_endian hardcoded to
true, writing hdr->gso_size in little-endian while recv_gso_packet in
tools/testing/selftests/net/tun.c compares vh->gso_size against host-order
variant->gso_size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D8
