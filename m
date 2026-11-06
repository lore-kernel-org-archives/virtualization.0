Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955153;
	b=nHlUTNAfJap9VhBt4IjFPdcCNcFVEYct/wNtNpAyIeRZEHvgW5473WDL1zFTcbZYicNN
	 T0cwG+1WZmrIn/CosUGxvyQb0lIbas7iq5Bmnc8NXr5EJn44oblW/nUVlyFm34Bavv/A4
	 P2cQ2knggh9AeSkD91/Ag2hJxxAk8RN5K507c53K08+XkQzWCGwhD8ZxmUdFdrv8V4blG
	 u73TLz2uYW9SDeKuYNaXspOW0AmsScK9SC5Mgrgh+mz9Km97QhKUPLxenyVupK4uJSrG9
	 tE/txizLax2Y9GASwaIZoWaiqIVVED19VXBjTkeWii8QZCotF6SwMoXvTAct5GsMDEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955153;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8RneAuf1xmsu4lAAXTsZQMwDZvHLybBjDn6JR2+oYx4=;
	b=biPq2SjlNMa0gNdvNIKRtLMd6eT288HG7sfyehbobrbReU6RkPYchoeL27MjkH5WBtc5
	 te4NmfQp/N9ZQL73bKq9sNarbF5EQvh8nhfZwGzyS49oVmdJeCTyx33MIF6SNnMuFSAOP
	 nQwZF5NgqHSKPt8cQagZwrrVOQwvBQGbbkjFFLx3L6BiKfK1MNSicHYf1pt9Vncjc/K+p
	 ZbzIcSjPL7b6nCO0jwyx+Sp6cDk66IV4Vg5gruFejpclAm0TTHyQpDg6K4vdQOKKOVRwm
	 tO3eLEJmz/SMx9GqXokj3XtpE8+kDaCm7GL7ezsGRnGkaFaqZJi7lqC2R72EKSboaHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+4AantN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C07606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+4AantN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29B81F0089F
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955152;
	bh=8RneAuf1xmsu4lAAXTsZQMwDZvHLybBjDn6JR2+oYx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I+4AantN5xRitgJgC2T160dTdeac+IkYuoLeiNTLx0bM+624JhBSC8hZDvVfuKU5B
	 UxcyhzLU8yKPQoWxVWShvfFFaO8frF8alljX0pA7+kZCE9gd+88b4KME7jsWp5OiVp
	 og8hr3JstWVQk8Z6sXU2L2YNp4YJuB8oQrXKy0H+f5rp5y/xF+jTNtyztu1wKynE8F
	 untgYDtKPWPR7gPNZf/8AJhUgZWGAXGS4bbSffdy4ZmtM2UkfUlougUYOiHvgg898b
	 B2MTeeYvAtc3LLvbrTyV7wJ3qI4OXOg5PUyvMPdchchovbR2RnEG6bdsZqS+bW8m5x
	 vn6N8PhK8Gm6Q==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4ad4072943dso91974fac.3
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 00:52:32 -0800 (PST)
X-Gm-Message-State: APuU4Z/tJJqIjn/VTkurEDymgGvo/MlnyNEdTVKjNlXVG5A/e6xfKuxU
	X8XagZKTjajuQ2HBs4V0QoKl4euI/hFqbyYTDiu52BhqO27i/5V3KFmnz9KUOCHFvmVnMw4rTBe
	TPnP8anqC/9nByONK+sCZioDyGS2BVAY=
X-Received: by 2002:a05:6871:b20:b0:4ad:8c55:4087 with SMTP id
 586e51a60fabf-4ad986619e5mr1224510fac.4.1793955152136; Fri, 06 Nov 2026
 00:52:32 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105115715.1466924-1-edumazet@kernel.org> <20261105115715.1466924-9-edumazet@kernel.org>
 <sashiko-outbox-201045@kernel.org>
In-Reply-To: <sashiko-outbox-201045@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 09:52:20 +0100
X-Gmail-Original-Message-ID: <CAL4Wiipvz_9GXQHyBdFkU5-2FfgBDau2SdKzfW82UgExKbUYVQ@mail.gmail.com>
X-Gm-Features: AclHuK9X66fECRKcPpELakqcOkmA8DYj9F0HjZRlVwbMa_eCYpyMXewkwtkezco
Message-ID: <CAL4Wiipvz_9GXQHyBdFkU5-2FfgBDau2SdKzfW82UgExKbUYVQ@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] selftests: net: tuntap: write UDP tunnel
 offsets in little endian
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 09:16, <sashiko-bot@kernel.org> a =C3=A9crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] selftests: net: tun: UDP tunnel GSO tests still fail on
>   big-endian hosts
> --
>
> commit 19b0a422177cb62b0357c401d17b939feb10dca3
> Author: Eric Dumazet <edumazet@kernel.org>
>
> selftests: net: tuntap: write UDP tunnel offsets in little endian
>
> This commit converts the outer_th_offset and inner_nh_offset fields of
> struct virtio_net_hdr_v1_hash_tunnel to little-endian in the tuntap
> selftests while leaving the base virtio_net_hdr_v1 fields in host byte
> order.
>
> > diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testi=
ng/selftests/net/tuntap_helpers.h
> > index ecad83fae1582..dc85cd9bc0aec 100644
> > --- a/tools/testing/selftests/net/tuntap_helpers.h
> > +++ b/tools/testing/selftests/net/tuntap_helpers.h
>
> [ ... ]
>
> > @@ -375,11 +377,14 @@ static inline int build_virtio_net_hdr_v1_hash_tu=
nnel(uint8_t *buf, bool is_tap,
> >       inner_iphlen =3D (inner_family =3D=3D AF_INET) ? sizeof(struct ip=
hdr) :
> >                                                  sizeof(struct ipv6hdr)=
;
> >
> > -     vh_tunnel->outer_th_offset =3D eth_hlen + outer_iphlen;
> > -     vh_tunnel->inner_nh_offset =3D vh_tunnel->outer_th_offset + ETH_H=
LEN +
> > -                                  GENEVE_HLEN + sizeof(struct udphdr);
> > +     outer_th =3D eth_hlen + outer_iphlen;
> > +     inner_nh =3D outer_th + ETH_HLEN + GENEVE_HLEN + sizeof(struct ud=
phdr);
> >
> > -     vh->csum_start =3D vh_tunnel->inner_nh_offset + inner_iphlen;
> > +     /* The tunnel offsets are always little endian. */
> > +     vh_tunnel->outer_th_offset =3D htole16(outer_th);
> > +     vh_tunnel->inner_nh_offset =3D htole16(inner_nh);
> > +
> > +     vh->csum_start =3D inner_nh + inner_iphlen;
> >       vh->csum_offset =3D __builtin_offsetof(struct udphdr, check);
> >       vh->flags =3D VIRTIO_NET_HDR_F_NEEDS_CSUM;
> >       vh->hdr_len =3D hdr_len;
>
> [Severity: Medium]
> Will the UDP tunnel GSO tests still fail on big-endian hosts because the
> kernel hardcodes little_endian =3D true when delegating the base header f=
ields
> in virtio_net_hdr_tnl_to_skb() and virtio_net_hdr_tnl_from_skb()?


Right, the kernel treats the whole tunnel header as little endian, so
the tests need TUNSETVNETLE and little endian accesses for all fields,
not only the tunnel offsets. I will do that in the separate selftests
series.

>
> In tools/testing/selftests/net/tun.c, tun_open() does not set TUNSETVNETL=
E,
> so tun_vnet_is_little_endian() is false and __tun_vnet_hdr_get() reads
> hdr_len, csum_start, and csum_offset in host order. However, when
> tun_vnet_hdr_tnl_to_skb() calls virtio_net_hdr_tnl_to_skb() with
> little_endian =3D false:
>
> include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
>         ...
>         inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
>         inner_nh =3D le16_to_cpu(vhdr->inner_nh_offset);
>         outer_th =3D le16_to_cpu(vhdr->outer_th_offset);
>         if (outer_th < outer_l3min ||
>             inner_nh < outer_th + sizeof(struct udphdr) ||
>             inner_th < inner_nh + inner_l3min)
>                 return -EINVAL;
>
>         /* Let the basic parsing deal with plain GSO features. */
>         ret =3D __virtio_net_hdr_to_skb(skb, hdr, true,
>                                       hdr->gso_type & ~gso_tunnel_type);
>         if (ret)
>                 return ret;
>
>         if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th=
))
>                 return -EINVAL;
>         ...
> }
>
> Because __virtio_net_hdr_to_skb() is called with little_endian hardcoded =
to
> true instead of passing little_endian, it byte-swaps the host-order
> csum_start, csum_offset, and gso_size on big-endian hosts. That causes
> __virtio_net_hdr_to_skb() to return -EINVAL (either in pskb_may_pull() or=
 the
> skb->csum_offset check) before virtio_net_tnl_offsets_ok() is reached in
> tun_vnet_udptnl_proto, tun_vnet_udptnl_proto_l3, and tun_vnet_udptnl.
>
> Similarly, on the receive path in virtio_net_hdr_tnl_from_skb():
>
> include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
>         ...
>         /* Let the basic parsing deal with plain GSO features. */
>         skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
>         ret =3D virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen)=
;
>         skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
>         ...
> }
>
> virtio_net_hdr_from_skb() is also called with little_endian hardcoded to
> true, writing hdr->gso_size in little-endian while recv_gso_packet in
> tools/testing/selftests/net/tun.c compares vh->gso_size against host-orde=
r
> variant->gso_size.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.14=
66924-1-edumazet@kernel.org?part=3D8
