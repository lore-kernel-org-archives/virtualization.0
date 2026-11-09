Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182644;
	b=HEWEorpzN/gDEsbkJ8ocBb5e+G1bB2wPL8ADMJ3HAsmYGtztHsncUMVuX7bIqw1qfeJQ
	 jwdsbaL5R4dGTNrwXyr4GCZ/L69F5a+bMoq2zbPu4rjF8TybdH3AzdVypDsjArpE4b/gn
	 fBGj7AeNIwRGDE16Lk7qXGxeoUa2HoQwcGzK/EJ2zCjMHp+OkoZa3DFdip/NLAlvVNGw/
	 3sF3Eh81I7Flz+5lhXgq1R5CFltctIfJ4IrJkr48874euT6b+KsE9q4WvdZELWLyk8uDI
	 b3PgivZ4OT5rJLPpx2ECRP5xnpQIxjQyzH/+zBllpT0I1c5AEe2ntdrELC91lshjT7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1RR7avhcdPmMkP8L/ldrmUUFPJjlBufNjxjrgtRo9sE=;
	b=tHhdtW2uArAwDZ8bXX7BfMOu1qbKGVipEVPs33r7t6Pz1kWoZqj1SW+QWEAmvqTLmZXM
	 uBsPT8nDMheLzZaHNE4zH9KSkwIO5B+gOm929HBIghJ07lJyJz2FdYKfEHawwI5d8ZdKs
	 3SbGiAf8qN7ApjHYUujurGaEf6R+S3A8o4FZm3vxIfezbC7QQTuNhqBWxH1S23fwzwUN5
	 e5xWrX256LNcI32pnbyfhB6pIq81/6PfFY30L15XQJEu/W21UsR2PxD8HntAEDGJocGPQ
	 ADLM9L4medgKteyQcqeBh8XRvAfJSzimy1+CYgV2uVPN1fwswhoVnI0NRn7uxvVjidw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ypklba7O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5B606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ypklba7O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0B31F0089F;
	Mon,  9 Nov 2026 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794182643;
	bh=1RR7avhcdPmMkP8L/ldrmUUFPJjlBufNjxjrgtRo9sE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ypklba7OjSY0qlKE4Ij+PwSA9SNDSosDdIOG+TWQ/Ze6aGQ1kAFSflNmI9UtcjdjZ
	 3XV9oFeGCQ9I7MKuIK5W+ECC+u0ijNko58yNn5b143hpigRO+yuGXcNMjy4ZKbDGzd
	 FLcYqhWfhijK1K3/uMpKa6rVS4xSrgWyaK/kGpearjs+pjHzQbAkBdpZYb7mR0QorF
	 kq3eAQCe4PqOVLOM7F5o0dVRh09w5M/Y3kErCLqZc5lsI+wYyaR4jReGpME9Ztwlcy
	 hIWoSicLT++cAKoV8R2saTa1ehRQSaSx4H3tPQszqTDXGGCyzYYpnzoEAIztJ7ayNb
	 xA4N5VdJ7AKjg==
Message-ID: <sashiko-outbox-204185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-9-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:04:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and
> payloads in the reference-counted message so caller cleanup cannot
> invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure.
> DMA cacheline alignment alone does not guarantee the structure's CPU
> alignment. Align regions to the greater of the DMA cacheline and
> control-value type alignment, and reserve prefix slack from the buffer
> base so typed accesses remain aligned while scatterlist regions stay on
> cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D8

