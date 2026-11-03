Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664769;
	b=EG98F2MlJx8Wt3eOR56p70LwxCjKO+qjAKVh8H0Q9dryqXtyz05DGs6VIf0Z6KwpHaNR
	 ki+D/NRpzZRnBK8RF2v0wfRCSeHmoin7keTxUSBpbRQqNJzl0pOl2ZBUf5hPtabiSoXgj
	 vRIjVbypRdrZjpQVCtWDb4tXxEjLHU/uUxdKdVkWN1BUIpqRB3CXY9YQT3wSz9qN+p4GB
	 a3ptOB/+EeG5kadMJ/2IbwnP4qvi2YLrNBgOwcOuGmqFObI9oOrnck8u+t5z24rx21cVE
	 lfamwu1DNxaIbjcX5mBiQOmjS6ghuGk5g5U2vo5bebYZIbhfK12sHTSv9t0thhLQMnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UKxdljUcFjlIq7c7w9X9w7+xAgdgpZHk5iBJVAdXujY=;
	b=rstiMImIxW1ZoLPIaFEQPNCKeY5Ecr+YaFCdvV2DbLyUJ1cHQr2TGt483jWiFSusKx/K
	 T6spS80xVa/IYgiOplByQcMP3dJVMLtqxuZUfbqkfRo+Mi8IzTAKYhep3aXWxYqlizJlK
	 sqKtQEBAPxp1YFo8TYaaQZrv4egpEL8OV6yrkCz/vQe1Y/QchZvNZqYfx5pEGRCMYLnf9
	 Xs1vzXqUustPYY481uG1hlus407elzOHMP8v0sMQ7yIqiRmlXhm8DVkX+/DqsRR03l2bg
	 MeBkEj6kuGrS6kRi2C5bbnykYu6mNOeYs+Km0NY0rNUmFMLWPWyQ8iqNBjF6IQIB4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWmO5LHZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5B606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWmO5LHZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB781F000C1;
	Tue,  3 Nov 2026 00:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664768;
	bh=UKxdljUcFjlIq7c7w9X9w7+xAgdgpZHk5iBJVAdXujY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PWmO5LHZ8ARuJ7Ds47EV6OJzL9xT/YYVxnaDmAVP8dyxiH31xFYQuVeRpgbD2TUpK
	 7mI4xSVJL32nqcMDu5zpClfrOx2WWlwmgcmKO2hmOlStOD8J9FCRNDNMuYxdYn16gD
	 gHz1Ylv2jGSULGhQliykG5Hr8gPEB2XbTiV4TyB6+AlpuKMlOZjLQgRdrvUgncK2c6
	 7x1cv9HpvvwkxEwabBlyW7M28zzeluRySP5dKrT0c/FeRDCGXrJsMDaVmd2oTfqRJQ
	 XW/ffPxg/vxVVqYUBcdp7RF4spL92tuQxbVecatI7tf/SC1Ky+pS6dx1ltR6LcR99D
	 6h192Kh8bMiYg==
Message-ID: <sashiko-outbox-194364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-6-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:12:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D5

