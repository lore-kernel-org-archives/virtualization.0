Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346339;
	b=KrFJBw6aYr8F0Rs6ZvP9Lt9FSlSeXydIXi/4+tOYuc5BeD7fA6Wbca69W7A/EG7gNwgG
	 5BHTp2hm+cexclQHmv0siCsXXBpQ4ashvm1RCZAVrz21QUudNQOqBD0j/t3Jgw63kiywR
	 0fnDLJgyZ2DE7YbuOW2ZgTPHh0+0aIV+Uforjr+FHiGKv4wHxLVyF7/JIiJdSTwdSdrz6
	 Yuty8hOAwANz+9jO2xvTcGOxzXjn8XJ57/lIfZc/y0GgL0kMnQmF+Gvw4eerffTV1X5+j
	 loLUM5RfHQoRHjrKseG8EaDbP95gHXVQnGwqDQmgcwmieSYBkfSdcLWedmtwqOSLXnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346339;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bR2QwCLVl113XaGL2JHNc10EFvEqgLuw2sHI5aolBtw=;
	b=AeHhIvpiumez03yVM5ljZOlT1BFu9LmeDN43o0QNp2seNVTIXqXPJpe3dLIL6ZjXQIvL
	 UbAmT9HTJJy154J7QdjJ+ZrQieiIWaTxk2df2NpFotEP6cjSbPxOU1mmRPsEVuY1THMsP
	 tBRPEtVD8vUO0aEzdGwUQU+bPyWi/jaz5EzXSN84cVzkbeOwkVIEWSV88JzLW3OJvvWJ3
	 I1Ye/9cov1J8/Qy8lcEEPpW4YGioSOvB0qvoFYy2qpcvjbSLmNdb0atx/f1pTn3m3DP4l
	 U1c04bYbllTR932BM6c+8mbygF5RPc4H7He3I7JaVDMEW1fOFgHm94ojGmKLURrWwyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC9uE3es;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D68606A321
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC9uE3es
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A9A1F00900
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346338;
	bh=bR2QwCLVl113XaGL2JHNc10EFvEqgLuw2sHI5aolBtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IC9uE3esv27nxpze5/vcc+KXpLdzXhS12D7VRoglTXDY6+7qkmp93pnm4PjEm5CPQ
	 ldYyQszIqIB/m78ts6lVHd39pTJRQLkaUwa21crVUa8JocfK34guss71qxk3W6sB3x
	 YNrvLKlMJU5QMSvXFGxw26sIUBphk7zcpddK7D9o7WsqR8uGRPmP7pkhx9qvggYBgW
	 IzZlSbhYW6DBPcsEUDPtUF6gLc8rOMtbG00KIDwoe5gyvo7pIpTW2vxy4Xgk9AXsqm
	 G0U6i8hEn0mjuKFgTCdOW+LUfxQUXP/wsDV1G2QwrBOFTaWEel1nxjuY/R9JJIKQP4
	 YufYkzhaMmS+A==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-702dedeb70dso1323910eaf.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 13:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGbSjTyXsBx1OfxV49y3HOYE5LpkgP7hLhP5fzjH4rSefvjgKXpl0lGiq2MMWXT+KR+kFS4gsVpjKKl4zFiLA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9EG32acPXSC3D2i3U4mrTh6OJW/Xwy5LMH2f1KKLg3tavRe+Kt
	vowmQS0U7gUx0+0AbD6mzgklMlps+HpGabAw39yavr/lCBCrcKoprW68D2oG7W2C/iwqqSKdD2o
	b4UlfNNH3f3mW5/x+sxNmyFLuRXcufB8=
X-Received: by 2002:a05:6820:1ca5:b0:6f6:3762:5f9b with SMTP id
 006d021491bc7-71917975626mr191605eaf.67.1794346337475; Tue, 10 Nov 2026
 13:32:17 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109163507.3102091-3-edumazet@kernel.org> <179433950226.994134.600618537237720502@kernel.org>
In-Reply-To: <179433950226.994134.600618537237720502@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 22:32:06 +0100
X-Gmail-Original-Message-ID: <CAL4WiirHNJJ2Ej5uaDiPYTgim6L9jzzrBaLBosxp_H1EafyHcw@mail.gmail.com>
X-Gm-Features: AclHuK8CHgDbYAbLV0XKnyH3aBO3kF-SKFuTv95wYOvUbq7elfb6rzk1qkv9nI8
Message-ID: <CAL4WiirHNJJ2Ej5uaDiPYTgim6L9jzzrBaLBosxp_H1EafyHcw@mail.gmail.com>
Subject: Re: [PATCH net v5 2/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
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
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new check in virtio_net_tnl_offsets_ok()
>   (include/linux/virtio_net.h:442), `if (outer_isv6 !=3D (proto =3D=3D=E2=
=80=A6
> - [Medium] virtio_net_l3_start() (include/linux/virtio_net.h:112) rejects
>   the frame when a non-zero skb->protocol differs from the Ethernet=E2=80=
=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the patch's
>   new has_eth=3Dfalse path is effectively unreachable for valid frames.
>
> --
>
> net: virtio: validate outer protocol of UDP tunnel GSO packets
>
> This patch makes virtio_net_hdr_tnl_to_skb() check that the frame really
> carries the outer IPv4/IPv6 and UDP headers that the virtio UDP tunnel GS=
O
> header claims. It rejects frames with mismatched ethertypes, fragments, o=
r
> wrong offsets. Callers now pass a new has_eth argument that says whether
> the frame starts with an Ethernet header.
>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2=
f2e2.1793276116.git.mst@redhat.com/
>
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index ab44342cf09f7..0b7a8569812fe 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
>
> [ ... ]
>
> > @@ -48,6 +51,145 @@ static inline int virtio_net_hdr_set_proto(struct s=
k_buff *skb,
>
> [ ... ]
>
> > +static inline bool
> > +virtio_net_l3_start(struct sk_buff *skb, bool has_eth, int *nhoff,
> > +                 __be16 *proto)
> > +{
> > +     if (has_eth) {
> > +             __be16 h_proto;
> > +
> > +             if (!pskb_may_pull(skb, ETH_HLEN))
> > +                     return false;
> > +             h_proto =3D eth_hdr(skb)->h_proto;
> > +             /* skb->protocol is a sender claim, and parts of the
> > +              * stack parse the packet per it: when it disagrees with
> > +              * the frame we do not know which view the packet will
> > +              * be parsed as, so do not validate.
> > +              */
> > +             if (skb->protocol && skb->protocol !=3D h_proto)
> > +                     return false;
>
> [Severity: Medium]
> On the tun IFF_NAPI_FRAGS path, can a stale skb->protocol cause valid
> frames to be rejected here?
>
> In that mode tun_get_user() gets the skb from napi_get_frags(). If GRO
> merged the previous frame with GRO_MERGED_FREE, napi_reuse_skb() recycles
> the skb without clearing skb->protocol. That field still holds the
> previous frame's h_proto, set by napi_frags_skb().
>
> tun_get_user() reaches this check before eth_type_trans() updates
> skb->protocol:
>
> tun_get_user()
>     tun_vnet_hdr_tnl_to_skb()
>         virtio_net_hdr_tnl_to_skb()
>             virtio_net_tnl_offsets_ok()
>                 virtio_net_l3_start()
>     ...
>     skb->protocol =3D eth_type_trans(skb, tun->dev);
>
> With only this patch applied, a valid UDP tunnel GSO frame can have a
> different ethertype from the previous frame (IPv6 after IPv4, or VLAN
> tagged after untagged). Would that frame be dropped with -EINVAL and
> counted in rx_frame_errors?
>
> The next patch in the series, "tun: clear stale skb->protocol of NAPI
> frags skbs", fixes this by setting skb->protocol =3D 0 in
> tun_napi_alloc_frags() right after napi_get_frags(). Could that fix go
> before this patch, so this regression never shows up between the two
> commits?

Yes, v6 moves it before this patch.

>
> > +             *nhoff =3D ETH_HLEN;
> > +             *proto =3D h_proto;
> > +             if (eth_type_vlan(*proto)) {
> > +                     *proto =3D __vlan_get_protocol(skb, *proto, nhoff=
);
> > +                     if (!*proto)
> > +                             return false;
> > +             }
> > +     } else {
> > +             const struct iphdr *iph;
> > +
> > +             *nhoff =3D skb_network_offset(skb);
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but can this has_eth =3D=3D fa=
lse
> branch ever accept a valid frame?
>

As said in the v4 review, this predates this series: UDP tunnel GSO
over IFF_TUN has never worked with plain IPv4/IPv6 outer headers. Both
directions would need changes, which would enable something that never
worked rather than fix a regression. I will look at it separately, for
net-next.

> For IFF_TUN, tun_get_user() resets the network header to offset 0 and
> passes has_eth =3D false, so nhoff is 0 here. virtio_net_tnl_offsets_ok()
> then requires outer_th to equal the real transport offset. That is 20 for
> IPv4 without options, or 40 for IPv6 without extension headers.
>
> Before that check, virtio_net_hdr_tnl_to_skb() still applies an
> Ethernet-sized minimum, whatever has_eth is:
>
> include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
>     ...
>         outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);
>     ...
>         if (outer_th < outer_l3min ||
>             inner_nh < outer_th + sizeof(struct udphdr) ||
>             inner_th < inner_nh + inner_l3min)
>                 return -EINVAL;
>     ...
> }
>
> That minimum is 34 or 54. A frame only passes both checks if it carries a=
t
> least 16 bytes of IPv4 options or 14 bytes of IPv6 extension headers.
>
> The TX side also produces offsets that the RX side rejects. In
> tun_put_user()->virtio_net_hdr_tnl_from_skb(), outer_th is computed
> relative to skb->data, and an IFF_TUN frame has no Ethernet header:
>
>         outer_th =3D skb->transport_header - skb_headroom(skb) + vlan_hle=
n;
>
> tun_set_offload() also lets IFF_TUN enable UDP tunnel GSO.
>
> Should outer_l3min leave out the ETH_HLEN term when has_eth is false?
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
>
> [Severity: Medium]
> Could this check drop frames built by the kernel's own producer?
>
> virtio_net_hdr_tnl_from_skb() picks the tunnel family from skb->protocol:
>
>         if (skb->protocol =3D=3D htons(ETH_P_IPV6))
>                 hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
>         else
>                 hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
>
> When the VLAN tag is inline, skb->protocol is ETH_P_8021Q or
> ETH_P_8021AD, so a frame with an IPv6 outer header gets labelled IPV4.
>
> This looks deterministic for a virtio_net guest that sends VXLAN or Genev=
e
> over an IPv6 underlay on a VLAN subinterface. virtio_net never advertises
> NETIF_F_HW_VLAN_CTAG_TX, but it keeps NETIF_F_GSO_UDP_TUNNEL in
> vlan_features, so the tag is pushed inline while the skb is still GSO:
>
> vlan_dev_hard_start_xmit()          /* tag kept as hwaccel */
> ...
> validate_xmit_vlan()
>   __vlan_hwaccel_push_inside()
>     vlan_insert_tag_set_proto()     /* skb->protocol =3D vlan_proto */
> ...
> xmit_skb()
>   virtio_net_hdr_tnl_from_skb()     /* labelled GSO_UDP_TUNNEL_IPV4 */
>
> Before this patch, the host only checked outer_th against ETH_HLEN plus
> the IPv4 minimum, so it accepted the frame. GSO later parsed
> 8021Q -> IPv6 -> UDP and segmented it correctly.
>
> With this patch, virtio_net_l3_start() walks past the tag and finds
> ETH_P_IPV6 while outer_isv6 is false. tun_get_user() and tun_xdp_one()
> then drop the frame with -EINVAL and increment rx_frame_errors.
>
> The same mislabel can happen from host to guest through tun_put_user()
> when the C-tag is inline, for example QinQ with a hwaccel S-tag. In that
> case virtnet_receive_done() would drop the frame as "bad gso".
>
> In all these cases the offsets are correct and only the family label is
> wrong. The commit message does not mention this change in behaviour.
>
> Should virtio_net_hdr_tnl_from_skb() derive the family with something lik=
e
> vlan_get_protocol() or skb_network_protocol() as part of this fix?

Same issue as the one reported on patch 1, fixed there in v6 with
vlan_get_protocol().
