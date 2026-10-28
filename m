Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181274;
	b=t6G5AbSw9Un5aEnFr+nazPzpUnEnsFPGKrxlas/PBLDaq2JEiKiWl5H9WXX+DOFbcbJS
	 81A7CjTityd4xQl17T1QASVn9xpGmClQiKzvGsdroD8it1N1CHpz2mM16VtwtkfBSJ+9S
	 leoMDWdQ+ErIJ04GrrLj1QI//f6PO34rVPJFW4S8psOWw4NWosdI6wnxcyWg1kzOUMsVe
	 UD2Mr2D4gJSUTYOdiZPqRqdhM4qTXMZP1RVUfmf9eEZ8TAfTibzw1nZRJ7g7k5eMRLi0r
	 iGLNLrAL+Ou9xymjSmOfU1ioplxAwMNH5drN45vijKhbomW/CpSd2tu700P0rjZvviA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kpv7y76fyGp5PyupcLPm3jDGaVONVPAw2wUMrdNnqBE=;
	b=g3RAwXp7U8fj+zZUszdLQe4rsc2Al8zU+IXG2gVbZgLW1ErOiFmyaPKbKm8hrw1z3Dzr
	 FqdqtA7p56paXQ92q5Unv4srFeC9tTQxjQOo8m6+9UxYaD5OvX8F85IAmVNn8vXcsoQvr
	 XNpP0Rm1ujGNlQQH2DU0LXCj3nvT4DVmOuBCoG+7liUj2yPEpLDG105lQVLnehQeDz0SC
	 BaHDvQ4hHB7Cl2740/q9u/YSj9jGuFP46iPmW2fRb8z0uYw2PbjEABIHGacUVtR0w7sTA
	 VavT7+br89ZVzL9AQc+ScZZKk9P9glWXor37R/wm5+pZ2qfJd3CZHkP/qbmgP/jYELg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UvY/GE03";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C1606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvY/GE03
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51741F01825;
	Wed, 28 Oct 2026 09:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181274;
	bh=kpv7y76fyGp5PyupcLPm3jDGaVONVPAw2wUMrdNnqBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvY/GE031SEhMn0i9sdCfHqIM9v6D0rBOXvgM9S56afHYGe7Vv4qKanAkGVGJAeTi
	 4LcTo4seEHEPWTEb1G2ABv/7YEWYsF4uAOn4bQ/8YrpMtl6bdrdwD3m+ilwLwg1l9q
	 7lc3xUr7Bpx7yIkCDbmqa8iq1pO5nkuqlyMYG2APCZx0LDnvAZbR46ao8+WxKMPqfB
	 sV2G/1Fw5p5deAOPv1n+9OhOJVACqLxdqfsRQl+Zu2HIMm57KlElc5jmANXOvKqhJN
	 p2zx5blELgmI3BiVFqXmcUImq5dVmn4udi+j1KMnnVEh0r/Nji81fXCOboHbvdPm2d
	 5jN7FSLkA8TGQ==
Message-ID: <sashiko-outbox-187703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/16] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-6-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:54:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and payloads
> in the reference-counted message so caller cleanup cannot invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure. DMA
> cacheline alignment alone does not guarantee the structure's CPU alignmen=
t.
> Align regions to the greater of the DMA cacheline and control-value type
> alignment, and reserve prefix slack from the buffer base so typed accesses
> remain aligned while scatterlist regions stay on cacheline boundaries.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D5

