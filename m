Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953003;
	b=aFgMicHXianDeAgQthD+sQpSZRfTUi79Tx+YdNBDrKMsEhR93PJll0dRMj3+p5n2uvf+
	 2ISQVqyxZfMdbczGH6xeiCicZyOUq6idoD50qpMEgQLysjGkDLwpKGRkWqornjWbC6ELU
	 X5AjsvV+7mSf1hU8pBjG7xBQYu5I0e0IXTksVes2o5FkwrrbL+7S8arUPX6mUqFS9vORD
	 vwwa9vUK0PH991zr+V+ZJLJxXLom2m9yiUVmfaYbFmTD0Xp4az12ic/OYgfGnXX3GQ+XX
	 /gTfJPwhGaVedxPFC8P/Fg0or3aZ2iOBRPAdOSc65OCM/Barx9JUGxhwkHu5+/YHjdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lJ9z4BH1hj7jSFEI5rD+SemnUh2V0Q8o+GHfFSq/m+0=;
	b=k3XHJ4ual9CTdPFH7Fr/A3fBfOobCeflsSYLss0tiRthlb+wswoqBETPHYRjJhEbqyAA
	 PaEdeW44u3KOzqjyghelPsY8rz93wXas1kqK1++bM42VDaIUI6VIVRs2oj2UfrMRahyIy
	 Luw3pUC5Bqekh6dQC7UNHfre9fbZ4PZ/aKa1qs+bLT2Vv0mAyJiXitwbx0OUTxDOsynrb
	 P27hOSZeiG6A+TqDjW8C8+Yosnc+bJlL+kJxtCuYyFnNpXsqyicO0tyAYX/kfuZu7RTZw
	 ShGPdhUUzLFzVlduqTNivSw6nBbISVV4mdLK1WYplJevGLVyIfpX5HyFZPm8IM3u2Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mv/wDLZW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E340606A331
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mv/wDLZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3861F008A1;
	Fri,  6 Nov 2026 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953003;
	bh=lJ9z4BH1hj7jSFEI5rD+SemnUh2V0Q8o+GHfFSq/m+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mv/wDLZWCQ61WfimTgdPny1uNaXOo+Y5N3RX+sAP+5UPYfToifwbhPRsVWA0t56L0
	 zZu58D45iNweaFL2VCoeUZFqEWitQjrN6US/1kRGWmGVvr3xk9PFm3R/pZUJShbIiU
	 aTJf94r3k6h/1KImpzu1MhE8CIxttLMmnzlr4Z1vR/eTVZqiQl3uVg2wB5WyfGd3s6
	 trEXOX0g9pr5T1LjaGR+vg/3tKLX2qIOpRml1TKhgwHSwwzinnWlPGhjNGtrlvPooG
	 WN4tmZCXbFzXrfxrbiNTzagtxo6cr2b2Mi83ObaIBsihGinRho2u5YpucapKYYnklV
	 w81sscZbqABiw==
Message-ID: <sashiko-outbox-201042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 5/8] selftests: net: tun: test outer protocol of
 UDP tunnel GSO packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-6-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-6-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:42 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add tests writing single 4in4 Geneve GSO frames to tun devices with
> UDP tunnel offloads enabled.
>=20
> tun_vnet_udptnl_proto uses a tap device:
>=20
> - outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
>   is accepted.
> - outer_proto_bad: an outer ethertype that does not match the declared
>   tunnel type (IPv6 on an IPv4 tunnel, or NSH with or without a VLAN
>   tag) is rejected with EINVAL.
>=20
> tun_vnet_udptnl_proto_l3 uses an IFF_TUN device with a tun_pi header,
> so skb->protocol comes from userspace and there is no Ethernet header.
> The outer IPv4 header carries options, as virtio_net_hdr_tnl_to_skb()
> expects room for an Ethernet header before the outer transport header.
>=20
> - outer_proto_ok: tun_pi and the frame agree on IPv4, accepted.
> - outer_proto_bad: tun_pi claims IPv6, or the IP version of the frame
>   is not 4 while tun_pi claims IPv4: rejected with EINVAL.
>=20
> Without the first patch of this series, both outer_proto_bad tests fail
> because the kernel accepts the frames.
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D5

