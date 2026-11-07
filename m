Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064283;
	b=Rs8HqH8w6OFpfjpo6nEorrRCf08qWXAyg2xjBihANVymRgXHuF9HKXPLI6iJmGeOXz8S
	 8id3ubvYVwkh0cxyVlpqZygNhkzd5wISCgHjS3POBg0HGOBB1zz9AW1IJ2ie5rUoRfAvj
	 eSkE8BBz5CZM8IRM2uDOxaFt1Kx9v/mg1o4TuYGu3FOOm9VENiOjzNn+jH39uIzACdXcX
	 e8SfxUgvs9bdNmU1cdG8i94173cUP+iz8iVtvntQ+OGxd0Z9o/PjdLgdpoQtNEqIxpEp7
	 9y8ZlDLC4KoBeK+ZA+Zx5JUrSoA0ig8VSdEJxXDLkjvnjco+HLoRXYGDjMPoETHy1gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RpmrK8K63iMcnjMj1AAQmxzqc7C4+PghYokYlHkj6rI=;
	b=p4a5rv3X1jNqWiYRHuFyhf31hN8KKJqjJyGMVU7iRPxMOVPe5eoLn74iYD1FsgP9mzB0
	 lYIaBHCYdnzpH/ZF0XpqkYodqnZY1nGW1CQveP4HK/tzDscXaBXB2+KMZEhB2UzPhgbww
	 CRQTi0WUC8Cq5waPO8MdXSGKCBk455YRI9estZkj8eC6X5D5fH/nbOmRPxEEZ6qFRBKP0
	 9vzfCKO1dJNPkKFFP1F2QbGNbDDzjYUe6In7zp0inAv9aZ806lDKAacrFidGx4yEYHYsW
	 E238ZDTtaOBcaVFoxqJ78/39AwcbktqQsfn68g1743Cj6bwcyU9TeaPtTq6RxfncORA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cA1sUtso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76F6082BFD
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cA1sUtso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B181F0089F;
	Sat,  7 Nov 2026 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064283;
	bh=RpmrK8K63iMcnjMj1AAQmxzqc7C4+PghYokYlHkj6rI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cA1sUtsodmROIPYBm9VQ0aE1rQ61qiWEWPE6dAE62gZbx165af0LmaqDqadPelQ0W
	 zTh08sV1G2JnCkSnoJTDWOgBHPbbQL+89gUgRukgRrYJlg0mOPYJaOqpqSQd5cRNNE
	 JR+XdOj8M2Tv8hKZS4WbD9Bqm7DprGzYoINNz7075ysUdbXIcZzn9Oud044KB4w4JV
	 gOaSdPJNz3d7ui4tzTKEAOO6SK1LbLP1NZrEfqYoKhtwRIYuVVLmfk1HcrmcD7yf6W
	 elw1xDIhVAdd4u3A9bkFKcxrXuMB7brLoVl9pEAvoVAzVK5APXVxDfJctIwz/Lzc5y
	 cZxomCmJOxAjA==
Message-ID: <sashiko-outbox-202988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 07/12] ALSA: virtio: validate indirect capture
 appl_ptr accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-8-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 15:11:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Retain references to the pages backing ALSA's vmalloc buffer until its
> queued I/O messages are freed. On NOMMU systems, use driver-owned memory
> for DMA and copy playback data before submission and capture data after
> completion, so ALSA buffer release cannot invalidate an active request.
>=20
> Validate the PCM buffer and each period before building scatterlists.
> Require a successful full-period response for ordinary capture before
> advancing its pointer. Each descriptor targets a fixed ring slice, so a
> short response would expose the unwritten remainder as captured data.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Seed the ordinary capture ring once per prepare. Native STOP preserves
> [ ... ]
>=20
> Retain PCM DMA pages and validate full fixed-slot completions. Account th=
e successfully seeded RX ring as full so completed capture data stays reser=
ved until appl_ptr consumes it.
>=20
> Bound ordinary indirect capture appl_ptr consumption to completed, unackn=
owledged capture bytes before invoking the indirect transfer helper. Reject=
 positive advances before RX ring seeding and reject frame deltas not align=
ed to runtime->min_align before byte conversion.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D7

