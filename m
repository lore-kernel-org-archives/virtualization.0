Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837866;
	b=2swPxpvgGrmtOPfml3ep2pJCCPFfIB/4pzgRcPxK5bB0A89f7ML7rVMA6jmjuFZcomrK
	 C0yrJDMj7qjvQzXyIH3crYEo4p/IrI1am7i9I77jdOOQYwVIdRH5sD2G8DBzS52l23+yQ
	 aULqBQqWkcmOJ0kEv4ZrVVpdCVsrkfHBDda9LNpe/45zh2ZfScmBmNr1IUJSpsnFIQX7P
	 RxSAbvZPhbr3JydDC9pjdVu1lNdSF5V6FOQwSC4OPQsQBQ88wQR0eO+Sc+zvHwQ0v2TTS
	 GP/fjKbfxltNECN2rTxJ0FyFG2Xv7F8B2kNDehHyPkxvCCmgGxcVsJtT7iuzJnFftaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GgA71QohokT/YtQ8yuLE8XBFpx3OjdEU40/Ur0V1LrY=;
	b=X5l5WT+BCF+mhHKAuP9e63GYax0n/n+ZNlBf7Es2TJDDgdkJXvn6rrD+EMQloAYFKwEe
	 aWQKcavdYdyUh8lguQfuWd8QY0xHeC3QNogkH4mzlfoFrKjF4Ch3Co5zK9FIYpYL6uemE
	 M+BdZWiB3Pd5pfu0DUFTnq+/FeO9PIoJqoMbNMremiqf/nN8r3S+ENia1pf0roXN/bkm1
	 UYc10jDPg9JAycLEytq5V9XD7lFsfF1hqin+nkNnFgCAAxYZSCi6viZFZE/reUOQa3ByA
	 KZD7VL7fPKm3x95bl30vW9zL3LuYHGVsTDfzV+HOc2e+kO7hzM9EUYQoCK8jzvFdbdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBSQPP5a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9B606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBSQPP5a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C361F000C1;
	Thu,  5 Nov 2026 00:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837866;
	bh=GgA71QohokT/YtQ8yuLE8XBFpx3OjdEU40/Ur0V1LrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBSQPP5atdk87D4lh2jNGBCvXuS+cYgIMPeGwqi/163vjLShW6n9fP2dxFbrT7RIb
	 gg+wNrmRZE9ZgVsZIo15LMVh8NS2KYxjZoWfQrEUayuHTWsDc72IDp7jj0e5HgpPLR
	 hBTpTsB43rIIEUzUDw1Ov1moCY5FvJXrsdcRK45tuFaSCF+nDN9PrG1aTz3LuAy7On
	 M2YbCEr9h468NyHn+GPWifJ0BxsaGBQAbpGvnTXiABRdbrLysyMaXedjtVMU3VpWkq
	 EXDc6IxsUmWeKHT+JF0tVweKIb2fSOY5iX2xcVyNY3J/5FyXZ5VnDfB+KM/MCiROhV
	 UIgFoRo9zdJFw==
Message-ID: <sashiko-outbox-198341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-9-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:17:45 +0000
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
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D8

