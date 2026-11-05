Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879590;
	b=fkkrEyC/jHpXP6UZZZTPYefVJ7iVV9RwCu1RCLj9jJb8liSldO2FTfCmuei0EFcP3NRt
	 UwGyb0Q4n+4tq0W1KS+uarFSHcrjKwrHiQgptjuPSkBQ8OI71DX9m7dXnEim0iUlW4Y5s
	 lpHPu30qQQZvsCQJEiW8p1/KuXlNtBOiE6jL/PoqsokaFCD36vAH7ovjHTyjB0i4b9/fO
	 OFh21ZgiKkXT6gXxIZKWPclrF75IY/ItutpeyUqzWhyGoZ/+DkQlv1TOKCcY4SUQ0XGrX
	 /a0pn7XToiQ/QAc13eAN5qau4IVIq8iUMHCzXDOrbqFRYA5sQOifNzGiLJVEJ9auGyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879590;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pU8MqVBzZi+RPXqbye/xaM5dO7j5j/RQgdDQgBghCKw=;
	b=hYiNcgtAuFDUuZdMd8H5vrBHDptnvI2oQJJglGimhfvVnL4YwaI5wRfAoIhpFItSANG1
	 jTrIG9w8fK+pRrFOrcYetyqGtm4rL4oEwRCiLU2fFhxbaSn9+WR5to0JnCXDpOl+DYiQb
	 hCfMiP2dDy2P/uE/q4Gii/XkzUhTvXDCbKwhvn20faecEWAtUO1oCsR5kBm0j2IJsFIrM
	 JgYQz7wIvxTjmhzvp49XCm6IYaBAL3ehT+esCXPU4+lnzIV33QevGsCIVhp2n8afObJi6
	 X6MxenD7ixeU8q+inL2FmMKU8PiJ9Nv6uLcjiaO6afT+6Iu2csmZt3DUyelN4Q1YLvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9laYjhL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8E606A927
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9laYjhL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88601F0093A
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879589;
	bh=pU8MqVBzZi+RPXqbye/xaM5dO7j5j/RQgdDQgBghCKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W9laYjhLL3ZbVRzIItjXmiAFRrTmirbi/Eyp+leZcob42t2A0IjZ4vOPQXIv/GRDv
	 r7CrMnfFN+oELGBuTTVk3OL58wy7XmdsXFSgxudEy8PjJErSEktIZ3uTwhvnbXDedt
	 a/iE17OXwL8qrT4ZtUzgB2w5b5h4Izq8do6e/9kW5+S87ly9ANbEa+XhrDOWW43LEJ
	 A6i6wqJDivqJNwmXWSw+JZ3qHEUS4CdxHYt1GQRKWShiwLlS5/coVs5pO+bxraD5XL
	 uO6p5M0WHH9E5X/o5MmUI/zLrB1wdZKamVQWdKKzbjKyIQo7GfS4X5xDa2TyKL+uMo
	 I1ghxfwyIRPUg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f48c750afcso1238285a34.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 03:53:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzSjxEQiStvTxFWh46B4znoX/XQiuE8uEBBwUqtzQNfuP9WM73R2FF1vtKzXcRd438NAsaJU4npv6zZVdI7CA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/qZKBd3Pd7MD+h8kMZURxiURWDMhG9WciPQdVuMjUJhx7UTBKd
	rdxfHRfPCqSiXER2UzsuJHagnmLc/sMJGnboD7FxTYo1/M4iHVUMKv+MMJuBTsv/v6smpkjUr2G
	E4msbhYObdbjb/K+g2tWErnHMEyjpP7o=
X-Received: by 2002:a05:6830:2694:b0:844:d1b5:df47 with SMTP id
 46e09a7af769-85d3640637bmr13785532a34.19.1793879588857; Thu, 05 Nov 2026
 03:53:08 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261104050131.629967-2-edumazet@kernel.org> <179387332014.488856.9111956413610107951@kernel.org>
In-Reply-To: <179387332014.488856.9111956413610107951@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 5 Nov 2026 12:52:57 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqw-nTCTPwd9pJ+Yzgz+ysNB3_Oa01mb_x7_ZB2w86R5A@mail.gmail.com>
X-Gm-Features: AclHuK_6gvJ7x0AL4m_JKZbY8pQOCPRBoVm7yEjNIav82DdDO4rj1Cvv-LcyOAk
Message-ID: <CAL4Wiiqw-nTCTPwd9pJ+Yzgz+ysNB3_Oa01mb_x7_ZB2w86R5A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com, 
	eperezma@redhat.com, hassansultan@google.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 5 nov. 2026 =C3=A0 11:08, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The new outer-header validator can still be bypassed, so the
>   NSH-over-UDP-tunnel GSO crash this commit claims to fix is still=E2=80=
=A6
> - [Low] In virtio_net_l4_start() (include/linux/virtio_net.h), the
>   comment before the ipv6_find_hdr() call says "Find the transport=E2=80=
=A6
>
> --
>
> net: virtio: validate outer protocol of UDP tunnel GSO packets
>
> This commit makes virtio_net_hdr_tnl_to_skb() validate the outer headers
> of UDP tunnel GSO packets. The frame must carry an outer IPv4 or IPv6
> header that matches the declared tunnel type, with UDP at
> outer_th_offset. The L3 start is taken from the device type: either an
> Ethernet/VLAN header, or the network header the caller set.
>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2=
f2e2.1793276116.git.mst@redhat.com/
>
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd00..b9c8babb1fd73 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
>
> [ ... ]
>
> > @@ -48,6 +51,146 @@ static inline int virtio_net_hdr_set_proto(struct s=
k_buff *skb,
>
> [ ... ]
>
> > +static inline bool
> > +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> > +{
> > +     /* skb->dev should always be set here already,
> > +      * but let's not crash when it is not.
> > +      */
> > +     if (WARN_ON_ONCE(!skb->dev))
> > +             return false;
> > +
> > +     if (skb->dev->type =3D=3D ARPHRD_ETHER ||
> > +         skb->dev->type =3D=3D ARPHRD_LOOPBACK) {
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
> > +             /* An unset network header shows up as an offset
> > +              * outside of the packet.
> > +              */
> > +             if (*nhoff < 0 || (unsigned int)*nhoff >=3D skb->len)
> > +                     return false;
> > +             /* No L2 header to cross-check with: take the protocol
> > +              * from the IP version at the network header.
> > +              */
> > +             if (!pskb_may_pull(skb, *nhoff + 1))
> > +                     return false;
> > +             iph =3D (const struct iphdr *)(skb->data + *nhoff);
> > +             if (iph->version =3D=3D 4)
> > +                     *proto =3D htons(ETH_P_IP);
> > +             else if (iph->version =3D=3D 6)
> > +                     *proto =3D htons(ETH_P_IPV6);
> > +             else
> > +                     return false;
> > +             if (skb->protocol && skb->protocol !=3D *proto)
> > +                     return false;
> > +     }
> > +     return true;
> > +}
>
> [Severity: High]
>
> Can a tap owner push this function into the wrong branch, so the NSH
> crash from the commit message is still reachable?
>
> The branch is chosen from skb->dev->type. In tun, the real framing and th=
e
> later eth_type_trans() call both follow tun->flags. The tap owner can set
> dev->type to any value with TUNSETLINK while the device is down:
>
> drivers/net/tun.c:__tun_chr_ioctl() {
>     ...
>                         tun->dev->type =3D (int) arg;
>     ...
> }
>
> Take an IFF_TAP device with dev->type set to, for example, ARPHRD_NONE.
> tun_get_user() does:
>
>                 skb_set_network_header(skb, ETH_HLEN);
>         ...
>         if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
>         ...
>         if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
>                 skb->protocol =3D eth_type_trans(skb, tun->dev);
>
> In that case virtio_net_l3_start() takes the else branch with
> nhoff =3D ETH_HLEN and only reads the IP version nibble at byte 14.
>
> The skb->protocol cross-check is skipped because skb->protocol is still 0
> at this point. h_proto in bytes 12-13 is never read.
>
> With a valid IPv4 header at offset 14 and UDP at offset 34,
> virtio_net_tnl_offsets_ok() returns true. eth_type_trans() then sets
> skb->protocol from the unchecked h_proto, for example ETH_P_NSH, while
> SKB_GSO_UDP_TUNNEL is set. tun_xdp_one() has the same order: validation
> first, then an unconditional eth_type_trans().
>
> If that skb is redirected with tc mirred to a gretap, does it reach the
> same crash shown in the commit message?
>
> validate_xmit_skb()
>   skb_mac_gso_segment()
>     nsh_gso_segment()
> ...
> gre_tap_xmit()
>   __gre_xmit()
>     skb_push()
>       skb_under_panic()
>
> Compared with the original reproducer, the only extra step seems to be
> one TUNSETLINK ioctl before bringing the tap up.
>
> There is a second variant: an IFF_TUN device with a packet-info header
> and dev->type set to ARPHRD_ETHER.
>
> With pi.proto =3D 0x8100 and bytes 12-13 =3D 0x8100, the cross-check pass=
es.
> The validator then walks a VLAN tag at 14 to IPv4 at 18 and UDP at 38.
>
> The stack handles the packet as raw L3, though. skb_vlan_untag() reads
> the VLAN header at data[0], so attacker-chosen bytes 2-3 (for example
> NSH) become skb->protocol.
>
> The skb->protocol cross-check cannot catch either case. In the first it
> is 0, and in the second the sender controls both values.
>
> vhost-net guests cannot change dev->type, so the guest path looks closed.
> The tap writer path named in the commit message still seems open.

Right, both variants are real. They need CAP_NET_ADMIN over the
device: TUNSETLINK only works while the device is down, and it has to
be brought up again. A vhost-net guest cannot use them, but a tap
writer in a user namespace can.

v3 follows your suggestion: virtio_net_hdr_tnl_to_skb() gets a has_eth
argument from its callers, and virtio_net_l3_start() no longer looks
at the device type. tun passes whether the device is IFF_TAP (and true
from tun_xdp_one(), which always calls eth_type_trans()), virtio_net
always passes true. v3 also adds tests for both variants (tap set to
ARPHRD_NONE, IFF_TUN set to ARPHRD_ETHER).


>
> A smaller point: dev->type is read here without READ_ONCE() or a lock,
> while TUNSETLINK writes it under rtnl. The bypass above does not need
> that race, though, since a stable mismatched type is enough.
>

Since tun_get_user() only drops packets of a down device after the
checks, a check of dev->type in tun alone would have been racy too.
With has_eth, dev->type is no longer read on this path.


> Could the caller tell the validator whether the frame starts with an
> Ethernet header instead? tun knows this from tun->flags, and virtio_net
> always has one. Another option would be to always cross-check h_proto
> whenever eth_type_trans() will be applied afterwards.
>
> [ ... ]
>
> > +     if (proto =3D=3D htons(ETH_P_IPV6)) {
> > +             const struct ipv6hdr *iph;
> > +             int flags =3D IP6_FH_F_AUTH;
> > +
> > +             if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > +                     return false;
> > +             iph =3D (const void *)(skb->data + nhoff);
> > +             if (iph->version !=3D 6)
> > +                     return false;
> > +             *thoff =3D nhoff + sizeof(*iph);
> > +             *ip_proto =3D iph->nexthdr;
> > +             if (*ip_proto !=3D IPPROTO_TCP && *ip_proto !=3D IPPROTO_=
UDP) {
> > +                     *thoff =3D nhoff;
> > +                     /* Find the transport header behind any
> > +                      * extension headers, AH included.
> > +                      */
> > +                     *ip_proto =3D ipv6_find_hdr(skb, thoff, -1, NULL,
> > +                                               &flags);
>
> [Severity: Low]
>
> This isn't a bug, but the comment says the walk goes past AH. With
> flags =3D IP6_FH_F_AUTH and target =3D -1, ipv6_find_hdr() actually stops=
 at
> the AH header:

Indeed, the comment comes from Michael's helper, which walked past
AH. I will fix it in v3.

pw-bot: cr


>
> net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
>     ...
>                 } else if (nexthdr =3D=3D NEXTHDR_AUTH) {
>                         if (flags && (*flags & IP6_FH_F_AUTH) && (target =
< 0))
>                                 break;
>     ...
> }
>
> It returns NEXTHDR_AUTH, so an outer IPv6+AH+UDP frame is rejected. That
> matches the commit message ("ipv6_find_hdr() stops at an AH header").
>
> Could the comment say that the walk stops at AH? As written, a reader
> might take it as a reason to drop IP6_FH_F_AUTH later.
>
> > +                     if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > +                             return false;
> > +             }
> > +             return true;
> > +     }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261104050131.629967-1-edumazet%40kernel.org
