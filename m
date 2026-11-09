Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241477;
	b=nr2Q61+ja+h3ZIAGTfjia0WTLQg5gDRH/ZoTMsoHl0/TbuazpbGxNVtRUAVHp55fCVsp
	 Hs9YmE4ufUiySGa5BRMB/qOc3s/1T5FD5dasejuD5m2Dd1fZT2KYSiTgfLql3DUUijSZL
	 cBLBo9eCLStjCJDowjmM2qs4RWOzci+C2q2ug9dgYPIAeqSqadhSFkJBo4E+UXbyPTVpS
	 dHtzji9AzvWnrdhxWmejXPjSVbykD6Q5Z01HH7vGs9oKNCPnHjIfAePmAbXxKjn6NGvnk
	 J2lFzsFbBcCMIW2VzJRwes9VwpcGsMTDqJgnxJpoTe5/8IovltyqD6P2YjMrEu5IhHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241477;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n5wuRW+BfwesQSl9RZrQwjD+U8kT1DloxPy/4T2mCjg=;
	b=VFezA7o7NppMAlkRTey0GIFJL/PKxv3gJJ8zntfjiveKZPvrOgVt7asOBOxjRcVIdsdO
	 KSqwJdPJq3+ZoKsf6LFh/XatljLLhyg8JKzzCuKckXwazOQMXN0V+9pLcsd5crCsFzqro
	 vhKiiZD5PlNqzOOqhtkXLNshiW6rwKenn5eCbrCCed5iHy4b5HqjO+LcKnyWGEoGH0pwI
	 tps+fuCiT3cj1yVnaE7kSuhnPOdXA+rzdX2TiFvauFc1+zm7xZTUt+8m6oxh/T1FphsX+
	 C0auu6KM+k6yOL4K4SnH6XwuCEl3vzBqV3cGI0xBemAgTzvmJIs7D/LMuO6cfz1FW8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iLsvu3/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF4606EE81
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLsvu3/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADA21F008BE
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241477;
	bh=n5wuRW+BfwesQSl9RZrQwjD+U8kT1DloxPy/4T2mCjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iLsvu3/IT33w2+nw1tF/w838npiyt65hR1rXxS8vjaUt3qDkKBO8b5eWmYbwZ6OHJ
	 8Snwt3Yyv/03bfyxCdmcwa+imVXIrxZCqOWxdbDYB5XSXcNen/nPu5kraSi0kTvBCE
	 htS9lFwL5+zzJsEAnOFmua9OnZ6MHIAVuIx0M3zl0uoBPDAExEHjC4f/OU+ulyHnI2
	 h7Z3Ini3FqqPlsDjiRUJvZf9ypBD2c7AL8pZCP80U1JYgxZ4u4SwH96LuT52FqTlYk
	 1ZXMHHwmAUcnpoo6jTdp+dCjoWJXEiKlqdGhmAYDGbS49uaVVpTpH5q6GxYgLhLS8i
	 nFijdDGiI/45Q==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4ad60ec5eaaso833380fac.0
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 08:24:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF3TzyZxFYUQlG7/vyU6PE/GGd1U0pKI1q9Dy5/7O70vo9wtE2M1RWo05P5mS/rYkdAlhPFCmTsu916mRs+aw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+cdokIocBT5ySilqkZo2M7M36UT39KNVpHlMu+FxyiMxiLfEkv
	Tv6nhwFFLxaalQZkZop0aISvbOjkLMoKdaFfWtpPdLhWOrOga5Lln9HXz/okCCJ1xDfI/tZJ5h2
	iraJ6zltVq3iwEG0R2U7k5/pEAhM+DaI=
X-Received: by 2002:a05:6870:e311:b0:46a:c673:a16c with SMTP id
 586e51a60fabf-4ae1fe6de5cmr5970fac.5.1794241476458; Mon, 09 Nov 2026 08:24:36
 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106095340.2113683-2-edumazet@kernel.org> <179421814766.994134.3669228181251158303@kernel.org>
In-Reply-To: <179421814766.994134.3669228181251158303@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 9 Nov 2026 17:24:25 +0100
X-Gmail-Original-Message-ID: <CAL4Wiioa61dp2DXSOfJwj3avru8zBiqyx44G_JfBBfHbrAjMsg@mail.gmail.com>
X-Gm-Features: AclHuK83hY0GSMGeOmqZ2p3f1VOqev2f_DFnXet7mIxLfflYJSQXAipPxiQLIMA
Message-ID: <CAL4Wiioa61dp2DXSOfJwj3avru8zBiqyx44G_JfBBfHbrAjMsg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 9 nov. 2026 =C3=A0 10:55, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new strict outer-offset check rejects UDP-tunnel GSO
>   frames that the kernel's own tun TX path produces whenever the skb=E2=
=80=A6
>
> Pre-existing issues:
> - [Low] In virtio_net_hdr_tnl_to_skb(), outer_l3min =3D ETH_HLEN +
>   virtio_l3min(outer_isv6) (include/linux/virtio_net.h:491).
>
> --
>
> net: virtio: validate outer protocol of UDP tunnel GSO packets
>
> This commit makes virtio_net_hdr_tnl_to_skb() check that the frame's oute=
r
> L3 protocol matches the declared tunnel type. It also checks that the out=
er
> UDP header sits exactly at outer_th_offset. Callers pass a new has_eth
> argument that says whether the frame starts with an Ethernet header. This
> closes a path where an arbitrary outer ethertype combined with
> SKB_GSO_UDP_TUNNEL could crash the host in skb_under_panic().
>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2=
f2e2.1793276116.git.mst@redhat.com/
>
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd00..b7b6b542f4763 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
>
> [ ... ]
>
> > @@ -282,9 +424,33 @@ static inline unsigned int virtio_l3min(bool is_ip=
v6)
> >       return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> >  }
> >
> > +/* Do the tunnel offsets match the outer headers in the frame?
> > + * The L3 header the tunnel claims must be the one the frame
> > + * carries, with UDP following it at @outer_th.
> > + */
> > +static inline bool
> > +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool oute=
r_isv6,
> > +                       unsigned int outer_th)
> > +{
> > +     int nhoff;
> > +     __be16 proto;
> > +     unsigned int thoff;
> > +     int ip_proto;
> > +
> > +     if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
> > +             return false;
> > +     if (outer_isv6 !=3D (proto =3D=3D htons(ETH_P_IPV6)))
> > +             return false;
> > +     if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> > +             return false;
> > +
> > +     return ip_proto =3D=3D IPPROTO_UDP && outer_th =3D=3D thoff;
>
> [Severity: Medium]
>
> Can this exact match reject UDP tunnel GSO frames that tun itself produce=
s
> when the skb carries a VLAN hwaccel tag?
>
> On the producer side, tun_put_user() writes the 802.1Q tag into the frame
> it copies to userspace or vhost-net. It calls tun_vnet_hdr_tnl_from_skb()
> with vlan_hlen =3D VLAN_HLEN. Only csum_start accounts for the tag:
>
> include/linux/virtio_net.h:virtio_net_hdr_from_skb() {
>     ...
>                 hdr->csum_start =3D __cpu_to_virtio16(little_endian,
>                         skb_checksum_start_offset(skb) + vlan_hlen);
>     ...
> }
>
> The tunnel offsets do not:
>
> include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
>     ...
>         inner_nh =3D skb->inner_network_header - skb_headroom(skb);
>         outer_th =3D skb->transport_header - skb_headroom(skb);
>         vhdr->inner_nh_offset =3D cpu_to_le16(inner_nh);
>         vhdr->outer_th_offset =3D cpu_to_le16(outer_th);
>     ...
> }
>
> So outer_th_offset and inner_nh_offset both end up 4 bytes short of the
> real UDP and inner headers in the emitted frame.
>
> On the consumer side, with has_eth set, virtio_net_l3_start() walks the
> in-band VLAN tag with __vlan_get_protocol(). That gives nhoff =3D 18, so
> thoff points at the real UDP header (38 for IPv4). The emitted outer_th i=
s
> 34, this comparison fails, and virtio_net_hdr_tnl_to_skb() returns -EINVA=
L.
>
> Before this patch the same frame was accepted. Only transport_header was
> off by 4, and ip_rcv_core() and ip6_rcv_core() reset it for local deliver=
y.
>
> With this change, would a guest that gets these frames from a host tap
> drop them in virtnet_receive_done() as "bad gso" and bump
> rx_frame_errors? A tun/tap writer that re-injects frames it read from
> another tun would see the same rejection.
>
> This looks reachable with VLAN-tagged UDP tunnel GSO traffic. Two example=
s
> are a VLAN filtering bridge with a tagged egress port, and a vlan device =
on
> top of a tap. tun advertises NETIF_F_HW_VLAN_CTAG_TX/STAG_TX in
> hw_features and hw_enc_features, so the tag stays in hwaccel until
> tun_put_user().
>
> The later patch in this series, "tun: clear stale skb->protocol of NAPI
> frags skbs", does not seem to fix the producer side. Should
> virtio_net_hdr_tnl_from_skb() add vlan_hlen to outer_th_offset and
> inner_nh_offset, with that fix landing with or before this check?
>

Right. tun keeps the tag in hwaccel for UDP tunnel GSO packets, and only
csum_start accounts for it. The wrong offsets were already a bug: the
receiver set inner_network_header 4 bytes off, and a forwarded packet
segmented again would use the wrong inner headers.

v5 will add a patch before this one, so that virtio_net_hdr_tnl_from_skb()
adds vlan_hlen to both offsets.

> > +}
> > +
> >  static inline int
> >  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >                         const struct virtio_net_hdr_v1_hash_tunnel *vhd=
r,
> > +                       bool has_eth,
> >                         bool tnl_hdr_negotiated,
> >                         bool tnl_csum_negotiated,
> >                         bool little_endian)
> > @@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >       if (ret)
> >               return ret;
> >
> > +     if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th=
))
> > +             return -EINVAL;
> > +
>
> [Severity: Low]
>
> This is a pre-existing issue, not one introduced by this patch, but does
> the has_eth =3D false path ever see ordinary IFF_TUN frames?
>
> Earlier in virtio_net_hdr_tnl_to_skb(), the minimum outer offset still
> assumes an Ethernet header, whatever has_eth says:
>
>         outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);
>         ...
>         if (outer_th < outer_l3min ||
>
> For IFF_TUN, tun_get_user() passes has_eth =3D false and the network head=
er
> is at offset 0. virtio_net_tnl_offsets_ok() therefore needs outer_th =3D=
=3D 20
> for plain IPv4 or 40 for plain IPv6. Both values are below the 34/54 floo=
r,
> so these frames are rejected before the new check runs.
>
> That leaves the !has_eth branch of virtio_net_l3_start() reachable only f=
or
> outer IPv4 with at least 16 bytes of options, or outer IPv6 with at least
> 16 bytes of extension headers. The L3-relative offsets produced by tun TX
> and by the selftest helper build_virtio_net_hdr_v1_hash_tunnel()
> (eth_hlen =3D 0 for !is_tap) are still rejected.
>
> The ETH_HLEN floor dates from a2fb4bc4e2a6. Now that callers pass has_eth=
,
> should outer_l3min depend on it?
>

This predates this series: UDP tunnel GSO over IFF_TUN has never worked
with plain IPv4/IPv6 outer headers. Removing the floor would enable a
path that has never been used, which does not belong in this fix.
I will send this as a follow-up.

pw-bot: cr
