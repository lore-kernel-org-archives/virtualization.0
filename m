Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955093;
	b=ks2UcwBNMsL9oEDQTvOUZC4GyFHzyArI6NA62EgAdKmY6p06Wt6MKEdritOY46KIbxbN
	 8N1Tfa2Olwy45DN2jE5nJ6b/XO8+r5BDDfRx/8cHHUxXxrftWgS37yAYH1MROciVynRfV
	 LWEFqyTJb8Sd3B0WWZWs0bQqQvjHC2AcHHq3gGX9yzyvmhBUaMKxrapCAOQGRNtgZSwrr
	 swVx2zynKkbhMwIwlxkHPcGhTZgPSAwlBdhUhpXvnob8NEZ5R+9EnRknte/BjLKA3ZtN6
	 MLZkFLe0tPlLt5sEuvhWlps3t9BquIMwuM7WOttzoswm7CThfZ+LH03X8RECxRz+/ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955093;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NxKjmy5QN7CeV9WgkfECxfwOizM91A5Tir8dDXhRPyU=;
	b=v16vFKIhjwXcOD2Byg+j30t+x0xFoftAI5UDNUQNYDyQtRpm1CMp+Prgr5WLlkceETdp
	 NYfPR35NyMxxYcltFMOpx1UUtVIQcR6Tdo/4ecaB85DX5D0Z0m6nti5MOd9n5PyFAqZM2
	 sG2fplBl2iOvXQSXZtRpzDNXz/K5U/XqZG/VcYx6grQseGoIyrhMuXxVnPyPV1OZD3nHH
	 JBtahvV686RKCmx44I3Itj2ZjTFCCkvKw4uQtQt7tt8eRfMrY++tQysafQJ6iZ6gBwPLu
	 GubA+1a6Bb1xUIN0wEgVDfstz+uRTrYgHIoTBlwXzDdosaur9D5SA4neD9G63xeL0tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA1nitMz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F6606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA1nitMz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8071F008BC
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955092;
	bh=NxKjmy5QN7CeV9WgkfECxfwOizM91A5Tir8dDXhRPyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kA1nitMzLXdOMWqer97SCCkBHOqutRDfAf9T/4HdJTOFjgtjF2Q/f4FbcDC0FvqA+
	 MHevwGOEHKUP0e6uqOSIkvC9eGHfJTO0mzeBQaqrof3boGusJ48v7G4wgGk//D8zgJ
	 Gt/mp6/DizTMNBlA/hatgoscCmsXfj28i83LVhKQQlo4M2C5CLDexY5FdNoUzL8A/C
	 090JQas5qzeEuO4DLe/C3nZlUoLGqjY+/n68sV7tsKHGmUPZx+s0ScuqNcCaKzcyuc
	 uAtiRWQcBhUr0p4euGscN8ibuwKQjL4KzcuaCdl+d+GvTJ/vN0L5XqYShxyENE1HE6
	 65sda1hZJc5zQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-833e671ee9fso475235a34.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 00:51:32 -0800 (PST)
X-Gm-Message-State: APuU4Z+qb5rlTV5mas0mHwdF/hwA/vsNC6DooloGVPFT1w95vbkA+AIe
	uCKtOt2jsYakMjWwA/0gvGFACLkAaw+wtwJu9TXbF6TkKEq0+enH3yZ6P2kBk2uwpUbyyJ5Z9bg
	y1cPi6QFo5+jbaVN+X2npY1PpDwYQymI=
X-Received: by 2002:a05:6808:178d:b0:4d6:90f3:74a4 with SMTP id
 5614622812f47-567e116a68bmr1279668b6e.47.1793955091771; Fri, 06 Nov 2026
 00:51:31 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105115715.1466924-1-edumazet@kernel.org> <20261105115715.1466924-8-edumazet@kernel.org>
 <sashiko-outbox-201044@kernel.org>
In-Reply-To: <sashiko-outbox-201044@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 09:51:20 +0100
X-Gmail-Original-Message-ID: <CAL4Wiir2RmHmYoFNOLCw8LJpWdd2d9o-VXNqg4fF6YYc+YD6cA@mail.gmail.com>
X-Gm-Features: AclHuK9XApUbflAHprGKceK5i5r_ngI2pvMUL-7_WRp2a9gpBQA2cue61obcqS0
Message-ID: <CAL4Wiir2RmHmYoFNOLCw8LJpWdd2d9o-VXNqg4fF6YYc+YD6cA@mail.gmail.com>
Subject: Re: [PATCH net v3 7/8] selftests: net: tun: test more outer header
 mismatches of UDP tunnel GSO
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 09:16, <sashiko-bot@kernel.org> a =C3=A9crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] selftests: net: tun: off-by-ETH_HLEN lengths in
>   build_udptnl6_frame()
> --
>
> commit 5c13d992f1a4a8ebd5983197ac9a5424f5b3dd20
> Author: Eric Dumazet <edumazet@kernel.org>
>
> selftests: net: tun: test more outer header mismatches of UDP tunnel GSO
>
> This commit adds tap selftests in tools/testing/selftests/net/tun.c to te=
st
> outer header validation for UDP tunnel GSO frames, including IPv6 outer
> headers, mismatched address families, VLAN-tagged frames, and non-UDP out=
er
> L4 protocols.
>
> > diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftest=
s/net/tun.c
> > index cfeca53863ce2..a135d3aa10d18 100644
> > --- a/tools/testing/selftests/net/tun.c
> > +++ b/tools/testing/selftests/net/tun.c
> > @@ -869,6 +869,103 @@ TEST_F(tun_vnet_udptnl_proto, outer_proto_link_ty=
pe)
> >       ASSERT_EQ(ret, len);
> >  }
> >
> > +/* Build a 4in6 Geneve GSO frame whose outer ethertype is @l3proto. */
> > +static int build_udptnl6_frame(uint8_t *buf, uint16_t l3proto,
> > +                            int payload_len)
> > +{
> > +     int hlen =3D UDP_TUNNEL_GENEVE_4IN6_HDRLEN;
> > +     uint8_t *outer_udph, *cur =3D buf;
> > +     int pktlen;
> > +
> > +     memset(buf, 0, TUN_VNET_TNL_SIZE + hlen + payload_len);
> > +
> > +     cur +=3D build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 140=
0,
> > +                                                AF_INET6, AF_INET);
> > +     cur +=3D build_eth(cur, l3proto, param_hwaddr_outer_dst,
> > +                      param_hwaddr_outer_src);
> > +
> > +     pktlen =3D UDP_TUNNEL_GENEVE_4IN6_HDRLEN - ETH_HLEN -
> > +              sizeof(struct ipv6hdr) + payload_len;
>
> [Severity: Medium]
> Are hlen and pktlen in build_udptnl6_frame() off by ETH_HLEN (14 bytes)?
>

Right, both miss the outer Ethernet header. The tests passed because
the kernel checks under test do not look at these lengths. The
selftests are not part of v4, I will fix this when sending them
separately.


> UDP_TUNNEL_GENEVE_4IN6_HDRLEN only counts one ETH_HLEN for the inner
> Ethernet header encapsulated inside Geneve:
>
> #define UDP_TUNNEL_GENEVE_4IN6_HDRLEN                               \
>         (ETH_HLEN + sizeof(struct iphdr) + sizeof(struct ipv6hdr) + \
>          GENEVE_HLEN + 2 * sizeof(struct udphdr))
>
> For comparison, the 4in4 counterpart in build_udptnl_frame() adds ETH_HLE=
N
> to hlen for the outer Ethernet header and does not subtract ETH_HLEN when
> computing pktlen:
>
>         int hlen =3D ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
>         ...
>         pktlen =3D UDP_TUNNEL_GENEVE_4IN4_HDRLEN - sizeof(struct iphdr) +
>                  payload_len;
>
> Because build_udptnl6_frame() emits both an outer Ethernet header and an
> inner Ethernet header, leaving ETH_HLEN out of hlen and subtracting ETH_H=
LEN
> from pktlen causes memset() to zero 14 bytes fewer than the returned fram=
e
> length (cur - buf), sets the virtio header hdr_len to 98 instead of 112
> (which is smaller than csum_start at 104), and leaves the outer IPv6
> payload_len, outer UDP length, and outer UDP checksum coverage 14 bytes t=
oo
> short when outer_proto_ok_ipv6 and outer_proto_bad_family write the frame=
 to
> the tap device.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.14=
66924-1-edumazet@kernel.org?part=3D7
