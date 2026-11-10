Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346149;
	b=TMH9LDIHwNl2IEtiwDvhSL1tKOeJKobDhaQ57T6HPhWcMGzrPOOrrmKclC4GZrWTCBTs
	 f0eEw8eF84+No6jZ5CFyxAY/ScJL8NifNq6RWZZ37MIKCKcDK0BlU2Pork+AWUzasboUS
	 ptfaI6mfK+ytatrdSVhsGM29/faEtGWKgNEWEEbfckg8dNAtYBNKyoxYDTUGTaEMWYdD7
	 +do6eh0wS6Pn8UqwbO0eJmJozj8AqO9vbfG4q2llJLrNuqgjjwrGzcbrnsX1supCEWyAQ
	 CKWdjT1dCpIh8sKjp1ozP5hjvQI2IinXFuZWMHa5ZOSzgunZmkpDY6Sn0RsUspqWKGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346149;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QvRngHIKvFqW6jRWzUlu52YQhDV4SuF4oJauIZT/Z4k=;
	b=wcJq6woagQPnziNS7KafcB4yPn6NXYpvZDcgTjO3vgPIzAO3zIUH8as9sz9PDYq5gkbE
	 r+5KUHx7w0M1TBdJTTi/lsTd0QPZ+d47ShDArdviRFW/pJy6gyENZJoOhqt72qOkqWnfO
	 35nkAGSDW2SSD9QpRvgkT7GwZe5zQ9KUXx0jaVZZhKklTYzrBaQOKKROML4/iNcWi+rkU
	 7es11CQNkaSf/ntJoBrx5AXieZfinFGyKY82/QfX1l5i+Zh/avKkqrrBwaVjmPSwvn11s
	 p8ZisHImJ+2Xu1vzQIvikdM17BTcSGwqLELati8vC4rLhcV0wXK7N+Hvuy1nMcwBB6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3Arx0qw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA550606A321
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3Arx0qw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF7C1F008BF
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346148;
	bh=QvRngHIKvFqW6jRWzUlu52YQhDV4SuF4oJauIZT/Z4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P3Arx0qwMLaoH7WBKEiWTBLyOxfs63vXV5cHfoZHHTqKLWZSq+NNDYxB3/qPbieoR
	 Yq+Oy0HjM1n5PTu/A9FXi3ViNmWQNurAaWCdepQPRqGVazTDszbf+kAvfaUEYRLCd4
	 N7MTVVSICCpiienm1RVrG5QmMYfvh7sh8oq6Nr6L2Rzp9cUplCDsB7Rt2YCjxFxIB3
	 L7zZx8oHgLJFWVMMC0a1v4lOavDXCtqqMuz+xOii6W2Vxmwjf+JwKqVhHI3vmgHvsB
	 TkOEuVqEeowBGQUZjADVukXDCDhKnW6hSja8Kluan7Dn8ao9mCKXwd+tOXJ5Mtdf/K
	 Fam+zU5JMSLeQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-702fd86d674so1240916eaf.2
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 13:29:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGKjlZhd9m4SQxfv7GBbnslLQteaGm2apTu2OwzHGkdyNAuJcT7eKbCgoOjztpcw/12fJwsyKUBvSkMqJrZAg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8ALwhTpk2dlfcRa4MohjIidqM8AE0qaXvj/UIKvdBt9p0FrmZ
	GwYFRaagh2jc1iZkRbSfCLUEJdTXDL1LaIYbCgjeJxdOkDUUF39z6K0p8Ar+795psF9xhDz6ZDl
	HmBLnoU7yyNMs1TldGYMMAmLPaIJmswc=
X-Received: by 2002:a05:6820:f02a:b0:709:f34e:e46e with SMTP id
 006d021491bc7-719175f8a1dmr288031eaf.1.1794346147805; Tue, 10 Nov 2026
 13:29:07 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109163507.3102091-2-edumazet@kernel.org> <179433950084.994134.15100186606737698605@kernel.org>
In-Reply-To: <179433950084.994134.15100186606737698605@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 22:28:56 +0100
X-Gmail-Original-Message-ID: <CAL4Wiir1500Vwthv6scfCDJVctY+PTMJ4wqJrbCXKKQ6TYFX4A@mail.gmail.com>
X-Gm-Features: AclHuK9CfxUTeJWZvRx6zMN0no9V9o8h0w5l6bkIB8qo1g_uSkervMfs31U5krs
Message-ID: <CAL4Wiir1500Vwthv6scfCDJVctY+PTMJ4wqJrbCXKKQ6TYFX4A@mail.gmail.com>
Subject: Re: [PATCH net v5 1/3] net: virtio: account for the VLAN tag in UDP
 tunnel GSO offsets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, horms@kernel.org, willemb@google.com, mst@redhat.com, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	hassansultan@google.com, virtualization@lists.linux.dev, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 20:38, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] virtio_net_hdr_tnl_from_skb() (include/linux/virtio_net.h)
>   chooses the outer-family GSO bit with `if (skb->protocol =3D=3D=E2=80=
=A6
>
> --
>
> net: virtio: account for the VLAN tag in UDP tunnel GSO offsets
>
> This commit adds vlan_hlen to inner_nh_offset and outer_th_offset in
> virtio_net_hdr_tnl_from_skb(), the same way virtio_net_hdr_from_skb()
> already adjusts csum_start. It targets the case where tun_put_user()
> inserts a hwaccel VLAN tag into the frame, which leaves both tunnel
> offsets 4 bytes short.
>
> Closes: https://lore.kernel.org/netdev/179421814766.994134.36692281812511=
58303@kernel.org/
>
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd00..ab44342cf09f7 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -461,8 +461,11 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *=
skb,
> >       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
> >               hdr->flags |=3D VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;
> >
> > -     inner_nh =3D skb->inner_network_header - skb_headroom(skb);
> > -     outer_th =3D skb->transport_header - skb_headroom(skb);
> > +     /* Like csum_start, the offsets must account for a VLAN tag
> > +      * the caller inserts in the frame.
> > +      */
> > +     inner_nh =3D skb->inner_network_header - skb_headroom(skb) + vlan=
_hlen;
> > +     outer_th =3D skb->transport_header - skb_headroom(skb) + vlan_hle=
n;
>
> [Severity: High]
> This fixes the hwaccel case. There, vlan_hlen is VLAN_HLEN and
> skb->protocol still holds the real L3 protocol. What happens when the
> skb carries its VLAN tag inside the packet data?
>
> Just above this hunk, the outer family comes from skb->protocol:
>
> include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
>     ...
>         if (skb->protocol =3D=3D htons(ETH_P_IPV6))
>                 hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
>         else
>                 hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
>     ...
> }
>
> For an in-band tagged frame, vlan_insert_tag_set_proto() has already set
> skb->protocol to ETH_P_8021Q or ETH_P_8021AD. Wouldn't an IPv6 outer
> header then be reported as VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4?
>
> The commit message says:
>
>     virtio_net passes vlan_hlen =3D 0 and is not affected.
>
> virtio_net has no NETIF_F_HW_VLAN_CTAG_TX, so validate_xmit_vlan() pushes
> every tag into the data:
>
> net/core/dev.c:validate_xmit_vlan() {
>         if (skb_vlan_tag_present(skb) &&
>             !vlan_hw_offload_capable(features, skb->vlan_proto))
>                 skb =3D __vlan_hwaccel_push_inside(skb);
>     ...
> }
>
> Its vlan_features and hw_enc_features still include
> NETIF_F_GSO_UDP_TUNNEL. Take a VXLAN or Geneve device over an IPv6
> underlay on a VLAN subinterface: it sends unsegmented skbs with
> skb->protocol =3D=3D ETH_P_8021Q into
> xmit_skb()->virtio_net_hdr_tnl_from_skb(). Is virtio_net really
> unaffected in that case?
>
> tun seems to reach the same path in three cases: ethtool -K tapX txvlan
> off, QinQ (outer tag in hwaccel, inner tag in the data), and a vlan
> device created with reorder_hdr off.
>
> Before this series, a Linux receiver used this bit only to compute a
> looser outer_l3min, so the wrong value did no harm. Later in the series,
> "net: virtio: validate outer protocol of UDP tunnel GSO packets" adds
> virtio_net_tnl_offsets_ok(). That function walks the VLAN tags and
> rejects the mismatch:
>
>         if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
>                 return false;
>         if (outer_isv6 !=3D (proto =3D=3D htons(ETH_P_IPV6)))
>                 return false;
>
> Once that check is in place, will tun_get_user(), tun_xdp_one() and
> virtnet_receive_done() drop every VLAN tagged UDP tunnel GSO packet with
> an IPv6 outer header from these senders?
>
> Could the outer family be taken from vlan_get_protocol(skb) here instead
> of skb->protocol?

Right. When __vlan_hwaccel_push_inside() inserts the tag, skb->protocol
becomes the VLAN protocol, and an outer IPv6 header is reported as
IPv4. The offsets are correct in that case, only the family is wrong.
This is the default for virtio_net, which has no VLAN TX offload, and
happens with tun when VLAN TX offload is off or with QinQ.

v6 fixes both issues in this patch, using vlan_get_protocol() for the
outer family. The patch is renamed to
"net: virtio: fix UDP tunnel GSO header of VLAN tagged packets".

pw-bot: cr
