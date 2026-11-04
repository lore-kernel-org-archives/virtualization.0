Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767801;
	b=ifKBiaDuz1SCZwvorHYGbILc/4vUZOVVlgEziTwjAwhzEvSBG4Cg66FELaOuyS2j2y1i
	 H3cAKVYYw7mbxGAZIsIu3J61/CVuHa53QqB+z4AbJzTOAaVwzWa7c1EfJt+MsiHPCI+d2
	 g7xFwRs1Rcghk1ITOK1/JmjYt1qlDVNhPSALJ5+UNndKdRtRLjoX9nO7JPRUvHgPKF7oT
	 AENSHj2i1/rd36hiL3sYNx13LRw9VnDAUq5jXGjznIUQBc4LUSzxJ6P3gQOpywyIPdxwO
	 ZXCWTpuVNwFWiiwQO4rhIwYYXq9QHAE15vVDKBJEkwIjzklv6bksqtkP5D64TVX7HVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767801;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qvTB6orR9VnOe8lzo+/JurYDotlGDFrB0B/lCSPx3t4=;
	b=EKQtMYkHVzzYYqKGoDqcNrDZgHnkwqA0nwQBZFiMoDFT5hBb6AxEFGilWBXQOX/4BhNP
	 +pXOzXshMi1PXp7ntllXjJGWHuTAOEflm1YPR/lqf7ZcaslsfOK/IHoLYQJ4mQnCwlY0D
	 MM5n2O+q6sVqfg/Z4PcT7YrK8G4cpwLhqkJpjFMqArHpdOybTE2+ppO7+myUnzQBdzThj
	 MNq2ufh+Ct/Vj/VtqYgcbJHmEZOt7VmocntrixrDh9cOXrAwb2jeevx6veExhFDBGQgyw
	 wHW81rqgm+OaJSW83JDHFiMZoxVm+A4tVYuPoq4llTH5Wu0lYwLHNPKnsOKBESG7/sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGWSztWO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8A606A32C
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGWSztWO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F2C1F00A1A
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 04:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767800;
	bh=qvTB6orR9VnOe8lzo+/JurYDotlGDFrB0B/lCSPx3t4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OGWSztWOlnSC49QWCnONMoxB548HtMJ3i+EbtpVkfmP86vwGg3IwMgF/6eJHgI2cj
	 /0fSbUFEPm1ibfocgjpcMFr0S1E66EZ0b9m1hYJGudE8ouJXU1nBuvI48F3SfzB+yx
	 wYgqNNr9Q4K90k2j8cPoRSUbr+UHs/UrGy5yCSPxu/DVt/DV0YXKkX7OWCy3LGmU9/
	 8mc/az6AYqmu2Gc/NZxO1wIEWWPNzcdxrpTEWUNi+bvKpvkQC3f/LPLSe9J4yU5lhj
	 xAJRF2rxgBplb17VDWIaSocjvaS9YbXlxukIrYjFDvhyi4ORIwxRzSstpEs4hPk+FX
	 yZ0Nd+zD3tPig==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46556b9e02cso160574fac.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 20:50:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBytQj9L9YeNmND5eMdFOMkograhUulYzFL/WHJx++9gr0GcD295kGS3F84wzpzr3ojRfH6qoNs1Ky2cnEm6+g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8o0UaPZxY5LiVYvHD/H1y64/i0OGujCVcXz0j5z8vMqHofnh77
	C/6EdCMMVruIQxYFdyNVOgH1wFFOAYvmwASgZ1rY0LYhWIrmcqMncsuxuJ6ZvaocR12j+keHNQ9
	q+6KvYvP+6BdplhxhKT0l041UT9l9qaA=
X-Received: by 2002:a05:6871:203:b0:4a2:4e0c:5964 with SMTP id
 586e51a60fabf-4a8e099d9dbmr9359126fac.18.1793767800077; Tue, 03 Nov 2026
 20:50:00 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103203113.550604-1-edumazet@kernel.org> <20261103203113.550604-2-edumazet@kernel.org>
 <willemdebruijn.kernel.2e11b18d6e190@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2e11b18d6e190@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 05:49:48 +0100
X-Gmail-Original-Message-ID: <CAL4WiipSx0h-zFwHR-CPLi0dVo3EwhhKgSqhQa1SaKixKSRiaQ@mail.gmail.com>
X-Gm-Features: AclHuK_Xn8BTM2XHTtAW8fRMMiq8m8CUtMjMGhCCbjgo-W_Yc0MLwBl7Lw5xvW4
Message-ID: <CAL4WiipSx0h-zFwHR-CPLi0dVo3EwhhKgSqhQa1SaKixKSRiaQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mst@redhat.com, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Hassan Sultan <hassansultan@google.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 03:01, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> a =C3=A9crit :
>
> Eric Dumazet wrote:
> > virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> > UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> > carries such an outer header. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> > mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> > dissector, so virtio_net_hdr_match_proto() is never applied either.
> >
> > A guest (or a tap writer) can then inject a frame with an arbitrary
> > outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> > The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> > segmentation, which assumes a different header layout. The result is
> > segments with skb->data before skb->head, and a host crash in
> > skb_under_panic() as soon as a later layer pushes a header:
> >
> >   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
> >   kernel BUG at net/core/skbuff.c:215!
> >    skb_push
> >    __gre_xmit
> >    gre_tap_xmit
> >    ...
> >    tun_get_user
> >
> > Require the outer L3 protocol to match the declared tunnel type:
> > for Ethernet frames, look at the ethertype after optional VLAN tags,
> > and check that the outer network header fits before outer_th_offset.
> > For IFF_TUN, skb->protocol is already set by the caller.
> >
> > Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO t=
unneling.")
> > Reported-by: Hassan Sultan <hassansultan@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
>
> Thanks for the fix. It overlaps with
>
> commit "net: resolve uncommon partial checksums at ingress"
> https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1=
793276116.git.mst@redhat.com/
>
> There are a bunch of subtle issues here. That series is up to v7.
>
> Two specific issues are that
> - skb->protocol in general cannot be trusted, and
> - non-L3 sources cannot be assumed Ethernet

Agreed on both. With IFF_TUN and a tun_pi header, skb->protocol is
whatever userspace put in pi.proto, and v1 would accept an IPv4 tunnel
frame whose IP version says otherwise.

>
> Would it make sense to take the relevant parts from the quoted commit,
> which has hopefully resolved those edge cases, and send that on its own?
> The rest of the series can come later.

Done in v2: patch 1 now uses virtio_net_l3_start(), virtio_net_l4_start(),
virtio_net_ip4_parse() and virtio_net_tnl_offsets_ok() from Michael's
v7 4/5, unchanged except that ipv6_find_hdr() stops at AH, as you
suggested in your v7 review. The checksum validation/completion parts
and the non-GSO carve-out are left to Michael's series.

Michael, I added your Co-developed-by and Signed-off-by, since the code
is yours; please let me know if you prefer a different attribution.

v2 also adds IFF_TUN tests with a mismatching tun_pi protocol, and
addresses your comments on patches 2 and 3.

One side note: virtio_net_hdr_tnl_to_skb() uses
outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6) for IFF_TUN too, so
tunnel GSO frames without an Ethernet header are rejected unless the
outer IP header carries at least 14 bytes of options (the tests pad
with IPv4 options for that reason). This predates the series, I left
it alone for now.

Thanks!

pw-bot: cr
