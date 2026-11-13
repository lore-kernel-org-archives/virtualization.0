Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552609;
	b=kp5AIcawBl0/SXRBuJPMsdSnG/UVA0Yg0oZ+k+EL8H7JQNFPUjnXbQpP+TL7gZ0NMugV
	 ATp7444B9ETekkPKA3oSrRDJhxhWGjB4jP1C2xZPH8kLAWXOtJWkPKgMcc/h7uRE4WetK
	 mu30VuVJSu63aGkAFRHpg688PtB0KjJ1g4xEUfuCABIFSwRSsluDOEZwLlvHl82gvThgd
	 EwCR485QlWrLd6mxXazt7Sx0ZKCBbFxmE0kn4ufJalFZZkUuzHe+0vAN959NOrpZcbTot
	 CjkiaZ2FZF2dVD0M2Qj+HpvVpwN7BhYDwGXCy4J4FMjWqyGTBLHOpN4GgbcbwjFWnvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wd1F+Dmlklyp3kJ0zWndn1SzmxdxaYkhcwHlqJxyDt4=;
	b=k8PISzs/LJfKSciFEgRBIuKhwrUESWe1Lq3ybsvM7ukj+IlgtOZPszCq0yAthRFdfH7D
	 slH6NsUKbMA6v3kx5L59lrayjUSWPrxshY0n6hK9fotCTIHQGjJAs9zdwgBqfMhbHdUvu
	 ZSAVYAYTAeb7aKS4siKhYuycifBfHY+8M62gwqRhPXQJ/UCUB0YOwlh2jeQ4z44pYYBoS
	 uqwVMBeSoRdJljKDMEbauhJhRQwmAQVH/+OdcAyN1xYOushsybZtT1S3nfhAQO2BTs903
	 Zw5Qh6ZCCV/VIX3X0wVcD+PJlAWMgMIRpZBzVK64p1WRnWWz+uP2pmtnWW1rAO5z+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ge/ezpON";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923DB606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ge/ezpON
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3856F1F000C4;
	Fri, 13 Nov 2026 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552609;
	bh=wd1F+Dmlklyp3kJ0zWndn1SzmxdxaYkhcwHlqJxyDt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ge/ezpON/icbKpxn+1ecJu0CjyhfWMTxgzqKGbXtN1Cjf6iFxIrh5ypRwhj8rh1rl
	 Aua+LXOo81VS2NS1g/8Mf5EOBswgezTNVSVgSIiNB3X+iWvKK/6A1wRbCWt2JjEeFB
	 nbfP3FuqrU78MkAaI74IAZYwhWw3uqfLTYHPPeeEsu9fBZCEm1yGwMbQKfpJfI9Lvm
	 mZXBzJ7ErWd01+JC+xgjMm6Z0bNnHLtQp2iTaQkhtNPDJt4hcIimQAtBY2Y4B++E5Z
	 SzqxmF1HwBboRgqwf3+4Cokoz6tyGO/CCwLyFwctKBcJyPoHATTkxVqzia7owPAxgU
	 7ZADxYXmxqhRw==
Message-ID: <sashiko-outbox-212288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 10/20] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-10-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-10-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:50:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
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
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D10

