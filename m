Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476792;
	b=zKbu2W2LwTKIKpL67GL7hh5L1mPLwG9ifHUF0AIrBjbeJyFfAeq95h3dSw0Ugfm7F4xv
	 tDGYAoWzhhxrSv1P6KafFPfWcbwsdHnOpVPEXPyhYmJlhVl2+Z8gZvgb5waTPg/KPxqGP
	 /+utNGZAoLj5IpKSyy8Atny1L8HHt4uBPA0gfo4fKZ5a5FAF6E0AqAGJfK/xqE5RGAJys
	 Vhf05Sw7yurMDTkT8ISqqGzI83oSO329VBZ9+4s2GgQ9Om8R21kYUuwXxB3PfPjipderS
	 41am6qwdnI+1QRjSjGmoOo9TCDhA+wrvcAJnGWZNruemZWVrEKKLVdWBZRjgdOCIVEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476792;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j6eZ4aCZFTS/utwlBgKhOAgoPY6BL5WxRnVfSRhjSzs=;
	b=MQiIfGhCgKHqwP8Bx1wrp17HrBAa8CqnSo5fVnlFI2PfwACx3AwoUOJ66pfplUeZaDFA
	 Ovh22pILD5Mvp392tt70+suT0yL2OGsZiT81mgI7YS1Q7d4W+GhSFobdm3zSOVnmukrFK
	 PdVY1yObXG61U/Sj+kzndHi1UdoohroLNg4vTLEF7+oHD43UH5jutQ1y3oVFFgVrM827M
	 FlwmCBlMOdrjN5uKchnyVBaCXnZz0h2o5YrKHxLpmsjTd3ZV/7kTWwa48Vj+et+qSGv5Y
	 I64GlC/uiyk8NxXATO/6a+WVwAyhxOC8XUnnop+idyq+n2ATj5rW6Gsk3BRiZqMtPvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzBOJKST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8035606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzBOJKST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775941F00A05
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794476791;
	bh=j6eZ4aCZFTS/utwlBgKhOAgoPY6BL5WxRnVfSRhjSzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LzBOJKST07DI6OhKR9d/bV/f+EcOgB7DduaD1YvU39zKFCS/rJIAybY5s0taxn405
	 uR/pdQZZhAznLyB7nOQ+cufnEQqKOpnC5K0IJVR8Oq4IxawDfO2+KxuFEU6KobDRy6
	 EOZWHtZNf+OLv0tNVW6jMaW/GWbjjOuzvORsPft5nBryny0+60SKlJ07TJjbTwzLEh
	 pjJBoCVwl/3jcz1gV6z+XyIygjzLHbRCaM5QXVTAEZLwQrWwdNKlLILuk1WzQEkX1d
	 ehaHHedwd+Iu1lXkg6DteBdRHuHqE488DOHu9T2Z0S4T/EYfciiaMdmLUIH0JkfTHM
	 TPz9SulQgW1vg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-705cb6cedd5so463614eaf.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:46:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGxZZAByx9DCVeS4n7cdh2FXtwONDwCMpdNM8x9xqPS5cb4lVzZ8G3gC2DcAC2HO9zeSq+EUbMG2KYhzu/big==@lists.linux.dev
X-Gm-Message-State: APuU4Z+AdS0sr6/euy4ymfas8au6p2elVk8WujfMtgsXnQFLxOCA+cAV
	mnLQ4iwgDo6hUY1mJDLHKbSNZKwFneTqy7mk9pGad3n2uwthkQYjjzsfva81qmllytuIy0UJOrc
	dK35qt3kVEnKa3qTywY0afP4UaKat6Wo=
X-Received: by 2002:a05:6820:c2d1:20b0:716:f44b:2dcc with SMTP id
 006d021491bc7-719740e76c8mr830715eaf.15.1794476790507; Thu, 12 Nov 2026
 01:46:30 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110213628.3476051-4-edumazet@kernel.org> <179443691180.2199510.148246238688217560@kernel.org>
In-Reply-To: <179443691180.2199510.148246238688217560@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 12 Nov 2026 10:46:19 +0100
X-Gmail-Original-Message-ID: <CAL4WiipcxHnbZye9P8_NySU=pLfQoSrMWF3PahgSQvfeuOgmsA@mail.gmail.com>
X-Gm-Features: AclHuK_cZ9ao9G0cYjqdJ9o0VFbuRHG2Gy61oDEJ6kFhBEJLvS-rEY_T6EP_Vvc
Message-ID: <CAL4WiipcxHnbZye9P8_NySU=pLfQoSrMWF3PahgSQvfeuOgmsA@mail.gmail.com>
Subject: Re: [PATCH net v6 3/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, willemb@google.com, horms@kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	hassansultan@google.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 11 nov. 2026 =C3=A0 23:41, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new has_eth=3Dfalse path in virtio_net_hdr_tnl_to_skb()
>   (include/linux/virtio_net.h) rejects almost every valid frame, so it=E2=
=80=A6
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is a
>   sibling of the injection the patch closes.
>
> --
>
> net: virtio: validate outer protocol of UDP tunnel GSO packets
>
> This patch makes virtio_net_hdr_tnl_to_skb() check that a UDP tunnel GSO
> frame really carries the outer IPv4 or IPv6 header it claims, with UDP at
> outer_th_offset. Callers now pass a has_eth argument that says whether th=
e
> frame starts with an Ethernet header. tun_get_user() passes false for
> IFF_TUN devices.
>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2=
f2e2.1793276116.git.mst@redhat.com/
>
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index d1fcb25ab026b..ced5a1596e609 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1950,7 +1950,8 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >               break;
> >       }
> >
> > -     if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > +     if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
> > +                                 (tun->flags & TUN_TYPE_MASK) =3D=3D I=
FF_TAP)) {
> >               atomic_long_inc(&tun->rx_frame_errors);
> >               err =3D -EINVAL;
> >               goto free_skb;
>
> [ ... ]
>
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 83f801ff57006..fc9667176f23c 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
>
> [ ... ]
>
> > @@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >       if (ret)
> >               return ret;
> >
> > +     if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th=
))
> > +             return -EINVAL;
> > +
>
> [Severity: Medium]
> Can the has_eth =3D=3D false path be reached by ordinary IFF_TUN frames?
>
> On IFF_TUN, tun_get_user() resets the network header to offset 0 and now
> passes has_eth =3D=3D false. virtio_net_l3_start() then takes the L3 head=
er
> from skb_network_offset(), so virtio_net_tnl_offsets_ok() needs outer_th
> to be 20 for a plain IPv4 outer header, or 40 for plain IPv6.
>
> Earlier in virtio_net_hdr_tnl_to_skb(), the offset floor still assumes a
> 14-byte Ethernet header, whatever has_eth says:
>
>         outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);
>         ...
>         if (outer_th < outer_l3min ||
>             inner_nh < outer_th + sizeof(struct udphdr) ||
>             inner_th < inner_nh + inner_l3min)
>                 return -EINVAL;
>
> So an outer_th of 20 or 40 fails against 34 or 54 before the new check
> runs. The only IFF_TUN frames that can pass both checks have IPv4 options
> (ihl >=3D 9) or at least 14 bytes of IPv6 extension headers.
>
> On the TX side, virtio_net_hdr_tnl_from_skb() computes outer_th relative
> to skb->data:
>
>         outer_th =3D skb->transport_header - skb_headroom(skb) + vlan_hle=
n;
>
> On IFF_TUN, skb->data points at the IP header, so this emits 20 or 40.
> set_offload() also enables NETIF_F_GSO_UDP_TUNNEL without checking the
> device type. As a result, IFF_TUN devices advertise tunnel GSO, but their
> ordinary tunnel GSO frames get -EINVAL and increment rx_frame_errors.
>
> The ETH_HLEN floor predates this patch and comes from a2fb4bc4e2a6.
> However, the commit message relies on the has_eth =3D=3D false path:
>
>   "tun_get_user() passes whether the device is IFF_TAP."
>
> Should outer_l3min follow has_eth, for example:
>
>         outer_l3min =3D (has_eth ? ETH_HLEN : 0) + virtio_l3min(outer_isv=
6);

Same answer as for v4 and v5: UDP tunnel GSO over IFF_TUN has never
worked since a2fb4bc4e2a6, and this series does not change that.
has_eth only makes sure IFF_TUN frames are not parsed as Ethernet.

Relaxing the floor enables a path that has never run. I prefer to do
that in a separate patch, with selftests covering IFF_TUN in both
directions, and not in this painful series.

>
> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch, but it is
> closely related to the injection fixed here. Plain (non-tunnel) GSO
> frames return early and never reach the new check:
>
>         gso_tunnel_type =3D hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL=
;
>         if (!gso_tunnel_type)
>                 return virtio_net_hdr_to_skb(skb, hdr, little_endian);
>
> In __virtio_net_hdr_to_skb(), the VIRTIO_NET_HDR_F_NEEDS_CSUM branch only
> checks pskb_may_pull(), skb_partial_csum_set() and the transport offset
> against nh_min_len. virtio_net_hdr_match_proto() and the flow dissector
> run only in the branch without NEEDS_CSUM.
>
> So can a tap writer, or a guest via vhost-net, still send an Ethernet
> frame with ethertype ETH_P_NSH, gso_type TCPV4, TCPV6 or UDP_L4, and
> NEEDS_CSUM set? eth_type_trans() would then set skb->protocol to
> ETH_P_NSH.
>
> Suppose such a frame is forwarded, by a bridge or tc mirred, to a device
> that segments in software. Could the segmentation then recurse without
> limit?
>
> skb_mac_gso_segment()
>   nsh_gso_segment()
>     proto =3D tun_p_to_eth_p(nsh_hdr(skb)->np);   /* TUN_P_NSH -> ETH_P_N=
SH */
>     __skb_pull(skb, nsh_len);
>     skb->mac_len =3D proto =3D=3D htons(ETH_P_TEB) ? ETH_HLEN : 0;
>     skb_mac_gso_segment()
>       nsh_gso_segment()
>         ...
>
> Neither nsh_gso_segment() nor skb_mac_gso_segment() limits the depth.
> Commit 006c8b834aed ("net: gso: limit recursive IP-in-IP segmentation")
> added the SKB_GSO_CB(skb)->recursion_counter check in
> gso_recursion_inc_test(). It is called only from inet_gso_segment() and
> ipv6_gso_segment().
>
> A frame of about 64KB made of stacked 8-byte NSH headers could recurse
> thousands of levels deep and overflow the kernel stack.
> TUN_P_ETHERNET -> ETH_P_TEB -> NSH appears to be a second route into the
> same recursion.
>
> Should nsh_gso_segment() use gso_recursion_inc_test()? Or should the
> plain NEEDS_CSUM path also validate the outer protocol?


This one looks real, and is independent of this series:
nsh_gso_segment() can call itself through skb_mac_gso_segment() with
no depth limit, whatever the way the packet entered the stack.

I will send a separate fix for nsh_gso_segment(), with a selftest.

The remark on the changelog of patch 2 is noted, I do not plan to
respin for it.

Let's merge this series and move on.
