Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953005;
	b=mQsT04YEPKI58SplIlsDzAAwRjLaMzaMopLnjJ/KQv2lfQPb1XmAjGSGqnwRd1s6cPpy
	 +Rn9eiRkDvekLzuyXYo0xn/Tt5P9+P5EgX5mHOn3rdZ9wSH9pXn2wuRjitfRVJyqgVCsb
	 OqxE5zGqsGTYCIpn90SEDH1GQJKqPOrY0cRC2uiDxC2+4vnxl2wuJBH448DlLpq6+csW5
	 e4C/rEaJflmtacHIp6cjfLN8s03PDG3Fm1nHb3yCbOWujDcqZ/EIFsBhRz4wSkp0Mf9/q
	 haMmFnbs0oXZwzXZC9YOdb2Ys+wwqpC6sTKLbG+pEsN3xGOC8WBdhtfFalXEwUG/YWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yy/Gt6KRSMmevGtujEE5wsqst5S2MekrJb/ecToLrQI=;
	b=DXYcL4jKBRy1kEzjt4elyBC9A+TD2o5sMCnKF670q9NZUGeH0wowpiN2TAOUveyBnNwc
	 3nqBYpz4nhVeLgGmbM1wvSHybub2h2mY7/eHwQV0EPCn4xssxhVdvC5bGqBzfQxxcINrb
	 Az7Sb5wIpVY/Alzo3U7NFPRgkcXpbxR/uZ7eti6fzvHTlRHCbaliWOv3Wg9pnvPnkX/EM
	 m9abCGnh8EYWZtMua1R8SLsP4VM6dkqnkXCL+6xYXHtfOGnCOoWS4vpuaqsC6YzYu28em
	 R8iY0SMqGkCHPLmuoh2v7tuWkjV93C99RIcc4UInwBbkGyaOW0huLG89e98p3bvRZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUFXQUQ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD04606A32D
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUFXQUQ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4B51F0089F;
	Fri,  6 Nov 2026 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953004;
	bh=Yy/Gt6KRSMmevGtujEE5wsqst5S2MekrJb/ecToLrQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UUFXQUQ2k6Zw/4RjKonhdZFSGbZC5Md63S6m7L8TwngUwugl4MI4H6HJ7K8ekttzu
	 89fBJyih6N83qdIJIAbUgGlPQYzlaInfTXPMMlx/wr+T6ytGeE1ViLngSk8bQhmiUO
	 BihammBNeRQENOyMBe5SzrVDRL5yqWlFuXgog8LiFg994P8VGYAoW/w/f4Mmp9PLFg
	 zc82o8Zo1aiVLXrX8zT2k2YgKiXPOAt4WGCNLcBKC2mv3aYAAzw5zMjisHlqb/IcPG
	 ltoKqFu/uW+XSUddZUMKZM3PFDinAZsFyQyLlVaVjP3+odU23ELJRMdJ7nr8lpTdNy
	 C0rkVCFe4DcRw==
Message-ID: <sashiko-outbox-201044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 7/8] selftests: net: tun: test more outer header
 mismatches of UDP tunnel GSO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-8-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-8-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:43 +0000
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
- [Medium] selftests: net: tun: off-by-ETH_HLEN lengths in
  build_udptnl6_frame()
--

commit 5c13d992f1a4a8ebd5983197ac9a5424f5b3dd20
Author: Eric Dumazet <edumazet@kernel.org>

selftests: net: tun: test more outer header mismatches of UDP tunnel GSO

This commit adds tap selftests in tools/testing/selftests/net/tun.c to test
outer header validation for UDP tunnel GSO frames, including IPv6 outer
headers, mismatched address families, VLAN-tagged frames, and non-UDP outer
L4 protocols.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/=
net/tun.c
> index cfeca53863ce2..a135d3aa10d18 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -869,6 +869,103 @@ TEST_F(tun_vnet_udptnl_proto, outer_proto_link_type)
>  	ASSERT_EQ(ret, len);
>  }
> =20
> +/* Build a 4in6 Geneve GSO frame whose outer ethertype is @l3proto. */
> +static int build_udptnl6_frame(uint8_t *buf, uint16_t l3proto,
> +			       int payload_len)
> +{
> +	int hlen =3D UDP_TUNNEL_GENEVE_4IN6_HDRLEN;
> +	uint8_t *outer_udph, *cur =3D buf;
> +	int pktlen;
> +
> +	memset(buf, 0, TUN_VNET_TNL_SIZE + hlen + payload_len);
> +
> +	cur +=3D build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
> +						   AF_INET6, AF_INET);
> +	cur +=3D build_eth(cur, l3proto, param_hwaddr_outer_dst,
> +			 param_hwaddr_outer_src);
> +
> +	pktlen =3D UDP_TUNNEL_GENEVE_4IN6_HDRLEN - ETH_HLEN -
> +		 sizeof(struct ipv6hdr) + payload_len;

[Severity: Medium]
Are hlen and pktlen in build_udptnl6_frame() off by ETH_HLEN (14 bytes)?

UDP_TUNNEL_GENEVE_4IN6_HDRLEN only counts one ETH_HLEN for the inner
Ethernet header encapsulated inside Geneve:

#define UDP_TUNNEL_GENEVE_4IN6_HDRLEN                               \
	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct ipv6hdr) + \
	 GENEVE_HLEN + 2 * sizeof(struct udphdr))

For comparison, the 4in4 counterpart in build_udptnl_frame() adds ETH_HLEN
to hlen for the outer Ethernet header and does not subtract ETH_HLEN when
computing pktlen:

	int hlen =3D ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
	...
	pktlen =3D UDP_TUNNEL_GENEVE_4IN4_HDRLEN - sizeof(struct iphdr) +
		 payload_len;

Because build_udptnl6_frame() emits both an outer Ethernet header and an
inner Ethernet header, leaving ETH_HLEN out of hlen and subtracting ETH_HLEN
from pktlen causes memset() to zero 14 bytes fewer than the returned frame
length (cur - buf), sets the virtio header hdr_len to 98 instead of 112
(which is smaller than csum_start at 104), and leaves the outer IPv6
payload_len, outer UDP length, and outer UDP checksum coverage 14 bytes too
short when outer_proto_ok_ipv6 and outer_proto_bad_family write the frame to
the tap device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D7
