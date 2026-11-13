Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568831;
	b=kgFp/R2c1SkpFl3v0nuK/YKBKMh9oP/gAP+tMsy8rk3n2E3SIhAEkGB4FWaYM3VbVYS1
	 3oxcWX0Eb+dgaaJKNd7u/fJ6fgD5roI2rTBRgDHNYsP2jnqDI4Kuzgv30pXpxqDQJacTC
	 +LFXfZwlddbi48fvk+zICJ5VWeKUXebkHhS/r/YdiEDL006+iVjYyf9mNoK2XoeGWsBXC
	 2vNhI8Fid7zKbLb17kEEtIO75Ng0mr0+VD+d4eJ04oqXaKGIaqYSOnYWn8MLRJm8bXR0o
	 zAvLdsdAo2K2XwwR8+XBW69qW0Ww5ztH0zsmVZnNxq2H3GygFzcErWPROVns15/Iz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gBlSQuzpofiqyGWeLZtB2OMr1O93E5lZ23TFQOTOCA0=;
	b=HOmaLe0SelN5L2dLUDzvjF+oz+Aey7gWG44ItBR89em3b9fVm6cRfOXHEZIFLHNg8w8B
	 RSRhP1FNy86HWmkGQZJq4Y9XA9ZPX1u+0FnIJL4qFewikijAMeG3r/wuIOlxKw5pxYHmO
	 xXGcP7RdMVrj5cRE83FHyYDdHykMOm9x21fSSd57wHkjUIWVC1qiYCWwVDK5b20yuKwq/
	 2apwPnhclglxoG2BqEaV8wGlrWnl3wsF77ax9OvkafGesqeGd8Sxck28m6YPcjDwT+a7R
	 ZmkfCSO7DikEmfU45pKKGhQFvuePSi8qFr6C1faaKFDRlj3bTEG0EnO4pHjIkUV3O9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0XOG0MH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167A606A88F
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0XOG0MH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80341F000C4;
	Fri, 13 Nov 2026 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568831;
	bh=gBlSQuzpofiqyGWeLZtB2OMr1O93E5lZ23TFQOTOCA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y0XOG0MHE9J195FLw9BGfj4+KWLqmDNy7+ecD5UfrQQIxQIMK64Dwp3MpR0eIKIEQ
	 VcZ/HZaDIGtIUm71oxIcUUKyEPpHP9nPVVre2ILhBkYOxc/7kRnp/+w3dHDsCp1D+h
	 zUFlSKk6dG/UlHJBxFMBqSjyml8UJZctmSEk23XrTJ5EJZKLJrxp3DIMsZm/LJ+pXE
	 N1WG+sraHh+19XdcHS312XaiCgoDFT4HmBx9bImCF96DFajTHBPyjjdViItdkuKa9s
	 yEsqbDN+N6ahxXbM31+nb89hDgRVxbmSwZXPpH+ylegtnCUZuqNIiatyhEPaK13aeu
	 yrPEv2LsQoK3g==
Message-ID: <sashiko-outbox-212706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 6/9] virtio-net: assert header sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The header is cast from skb->cb and from device buffers, so its layout
> must not change silently. Add static_asserts for the offset of tstamp,
> the total size, the alignment, and that the header fits into skb->cb.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D6

