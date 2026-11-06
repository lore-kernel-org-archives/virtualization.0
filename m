Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953002;
	b=17XjYkZ+LOUe5fGV9vNckJUwKLmSEpOWaSYOyNPoyrls9W1NKng6Rhj4uXOYinpFTbHf
	 R6vGHSNDNz83+CGfNlktORVJGhP4q2ZHiLAinOrgQ4HE0yHz19wbdOUr8a095+ckyAhP2
	 MoEnySE2CrF5xFhAkozR4Nc+8TgEzWM6QvbLLrxrO1zDwTLKjZWAjWhXwOcfzTlGDLPdY
	 cZYgD8Uvlbmi+TROAbFOv2RKfDZZkAMO2Rp18OhccQo+W4Mx6BHHnNq45jVhIKe/bXfAd
	 gLA9fP06DU0VR/3ckCd3af0ixhwUUF8VSZoxZv+l1uNM0cvj9OlINeN5HXgEdx+YscA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iFhbw3zpcKIkumWSyiJ3DyBaBwuoIMgsXETLOsk+iEA=;
	b=Q9H1dxYlceSzm6CJia5hA3zmcfJyfsymTZLuXdMyzjHKSTcTND1FoprRL6JZgdwOFVO+
	 +qxF+DEY+cLTBsaK4PaE2HOuZjKKv55mpqvlSExJ/L9NL2rIa+CcuyqYmp/2xUkHiMIpm
	 cc0K8G2VfF+8pStxFgzTMUc+JjnukXx4H+pGsqpuDDWHwYp3iIHqBbeqU1x6zOpdIIWIV
	 NSI7BwXDDFaroK6d4SalUtOoYaMROWW1Lfke5EYWus6ymHYW5BtRe0L7zgA23bKvuBH0m
	 9IHFnJPZjVIPzKVOKaWTJ1t3PCkWOBAZZEcIDrYNj90Ou2HONto5wn5OBKepeVPEAxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEly3GuB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B6D606A32E
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEly3GuB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F021F008A2;
	Fri,  6 Nov 2026 08:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953001;
	bh=iFhbw3zpcKIkumWSyiJ3DyBaBwuoIMgsXETLOsk+iEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEly3GuBhdx+4/wTsxqzlwUrlBZGO9+SOsIVP2pq1kjz8zQvcCvE+6YKTGVVuXhig
	 quGLnnktnKf5ouLpH3dlj3EuKmL199KABsmelw/skSNBInZzylG7CAQd9VZKZEu7zl
	 xXL7CGAj2QmqMKaXKuFtsLIYWGVuBdDlosGFvUUtX3s65c0qKsn7R8feTlFuI6DrVT
	 UQcOOjVJN30XKsWXiq/Hc5bzFFc88He7J7UHBA8XoqlswtLHEF8y9C+lZor6KExEb2
	 v153w6y6p+kgR+MfdouttQwu0rj6IAimrDUcVqxMNyfNuVKyEtjP/d4YNVuEC4qrvM
	 JzKh+vHiO+EUg==
Message-ID: <sashiko-outbox-201040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/8] tun: clear stale skb->protocol of NAPI frags
 skbs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-4-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-4-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> With IFF_NAPI_FRAGS, tun_napi_alloc_frags() gets its skb from
> napi_get_frags(). If GRO merged the previous frame with
> GRO_MERGED_FREE, that skb was recycled by napi_reuse_skb(), which does
> not reset skb->protocol set by napi_frags_skb() for the previous frame.
>=20
> On the IFF_TAP path, tun_get_user() calls tun_vnet_hdr_tnl_to_skb()
> before eth_type_trans(), so the virtio header checks see the protocol
> of the previous frame: the outer protocol check of UDP tunnel GSO
> packets rejects a valid frame when the two ethertypes differ, and
> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with
> the wrong protocol.
>=20
> This needs GRO to hold packets across writes, for example with
> napi_defer_hard_irqs and gro_flush_timeout set on the device.
>=20
> Clear skb->protocol for IFF_TAP frames, as for skbs allocated by
> tun_alloc_skb(). eth_type_trans() sets it right after.
>=20
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179386753589.488856.11455181721004=
759454@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D3

