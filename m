Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824293;
	b=ESb3zur/uLp/su9P9BVf6tr5vyZgit/gMIGYmDzMyhTxBLf10DyoVp3rSa2TratEmHrJ
	 3kXyf6gbHi0JYQhxTY5h4tu23r3TB4WeFpQ1ZGkqc+mxlZ0aSiIevu82XXsFs7DnjzAD/
	 0DHAIYjDgfxq1d6N14WcOWgK65ZWyjUpGHL/cR0M7nHagi1uhpGWzpVTXRT7D2ey1TC2T
	 ezP9clWiMUxS6tJRmO/l6E0H1G4VvYRr4F6HzpD1JAfxdquK9AnG9CcK8MQzEjN6qXJ2v
	 Dt3kkwCogbcgxEU2VSWENEZh+aZvoA+F0098mxRlVDdClWBVTyvuZcmE/3aryf5wYiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824293;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GkC6hlzznfqVyJ2TbdNnZQs4/DkpLYQvc92N7GdJIIk=;
	b=i/0uElAGwwjwDkGPcRdLJBMimNA8X60sc18J/5AG1cZlouzTdnbj7nZ/CAwxSdZOt8oo
	 8HK3EzEeRznpJGU5FatwdP2XjTpq1jHTXy3h+uQrsZroCsM1fDdQvIdVg9iCSzWAWHQxS
	 2Cpf0onHSwKtRrNIHgtiGLvfIxqiEXpFFr7o9CasiRO7nZ4oxY8kk88FYyIeYHS2LoQIE
	 +iZ1y65sl/6I7HwBYkQJiQ6M324EI2JJODVFGxwvE/l0tTjCGQ4hRvtSViNVpuFqnS1Fm
	 cctppEBI6NYa6XObh4Z4ZUO14uQVfz2x1fFqng7XuJ2p5lafLS8T0mW4XqmGrfWYqxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKmF6RT2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B98606AE27
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKmF6RT2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5180E1F000C1;
	Wed,  4 Nov 2026 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824292;
	bh=GkC6hlzznfqVyJ2TbdNnZQs4/DkpLYQvc92N7GdJIIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKmF6RT2BWOu2rvW7In3YTY9waZqDjccREGP8SBxzt7ZtXVgVQ01wkFOoCP/lMJRz
	 +hEVdCXYY+ypymcOzSFAY/U342p2VJqJ/UBXQ9tlk/ZO7OE385/RoJiRottJTIQAPH
	 2JOi5KyOW7T3Yrc+r+Smt6WmYkM/h7ClUnAsWjFNHba2j6TfYHCWQSqqXwsAUOZr4z
	 BTakljyF64gcUNaLhyZIm0170k4wfJf5OUBPT5jJCTiFi0AlwIO5rzrOO9hw0TJq2r
	 4Js5NqUKVV021VhdPFyvl+OcYm8W12Bnmo0ju2yJAm5BIagpsLo6quNdpE5rmw9xde
	 xX7rjkr+U6DWQ==
Message-ID: <sashiko-outbox-198016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103203113.550604-2-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-2-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:31:31 +0000
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
- [High] net: virtio: unreliable L3 check in virtio_net_tnl_outer_proto_ok()
--

commit 02f420dee7a050b3832ecf552c44f9c2eeaaddc1
Author: Eric Dumazet <edumazet@kernel.org>

net: virtio: validate outer protocol of UDP tunnel GSO packets

This commit validates that the outer L3 protocol of a UDP tunnel GSO packet
matches the tunnel type declared in the virtio header in
virtio_net_hdr_tnl_to_skb().

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..d3f97d71d81cc 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -282,6 +282,31 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
> =20
> +/* The outer network header of a UDP tunnel GSO packet must match the
> + * tunnel type declared in the virtio header, otherwise the GSO stack
> + * would parse the packet as something else (e.g. NSH).
> + */
> +static inline bool virtio_net_tnl_outer_proto_ok(const struct sk_buff *s=
kb,
> +						 bool outer_isv6,
> +						 unsigned int outer_th)
> +{
> +	__be16 expected =3D outer_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	__be16 proto =3D skb->protocol;
> +	int nh_off =3D ETH_HLEN;
> +
> +	/* L3 device (IFF_TUN): the caller already set the protocol. */
> +	if (proto)
> +		return proto =3D=3D expected;

[Severity: High]
Can testing if (proto) here be bypassed in tun_get_user() in two ways?

First, on an IFF_TAP device with IFF_NAPI_FRAGS enabled, tun_get_user()
allocates the skb via tun_napi_alloc_frags() -> napi_get_frags(). When a
prior packet was merged by GRO (GRO_MERGED_FREE in napi_frags_finish()),
napi_reuse_skb() caches napi->skb for reuse without clearing skb->protocol
(which napi_frags_skb() set to the previous frame's eth->h_proto, such as
htons(ETH_P_IP)).

In drivers/net/tun.c:tun_get_user(), tun_vnet_hdr_tnl_to_skb() runs before
eth_type_trans() updates skb->protocol for the new frame:

	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
		atomic_long_inc(&tun->rx_frame_errors);
		err =3D -EINVAL;
		goto free_skb;
	}

	if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
		skb->protocol =3D eth_type_trans(skb, tun->dev);

With a reused napi->skb still carrying skb->protocol =3D=3D htons(ETH_P_IP),
virtio_net_tnl_outer_proto_ok() takes the if (proto) branch and returns true
without inspecting eth_hdr(skb)->h_proto or checking nh_off +
virtio_l3min(outer_isv6) <=3D outer_th, and eth_type_trans() then sets
skb->protocol to the new frame's actual EtherType (such as ETH_P_NSH).

Second, on an IFF_TUN device without IFF_NO_PI, tun_get_user() copies struct
tun_pi from userspace and sets skb->protocol =3D pi.proto:

		skb_reset_network_header(skb);
		skb->protocol =3D pi.proto;
		break;

If userspace passes pi.proto =3D=3D 0, proto is 0, so
virtio_net_tnl_outer_proto_ok() falls through to the Ethernet path and chec=
ks
eth_hdr(skb)->h_proto inside the L3 payload, leaving skb->protocol =3D=3D 0=
 with
SKB_GSO_UDP_TUNNEL set if those bytes match expected.

Since all callers set skb->network_header before calling
virtio_net_hdr_tnl_to_skb() (to 0 via skb_reset_network_header() for IFF_TU=
N,
and to ETH_HLEN via skb_set_network_header() for IFF_TAP and virtio_net),
would checking !skb_network_offset(skb) instead of if (proto) avoid both
issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103203113.5506=
04-1-edumazet@kernel.org?part=3D1
