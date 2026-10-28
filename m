Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157354;
	b=FhN6l/FG53W6SRoJ06suTv/iApYDEmiVXmlSOMi5+DXyMZhenvjiulW9n3OslZHmEoWE
	 HTuLw3Os8KMKwcSA1OMkS7eayoaWWxUaqPEFd7jH14M1Uu/jUWpJJDd1E8X5Yl3LSvOiV
	 ooRVzR7DFRS5TOHKNCn0oziasVqxuhN5Hac6+hk5bXSSmG2Bt2b9EvvGqVxPQxPDgQWZI
	 B+ZLJyiFEcnLCfLc9jTK2EffFrWn4yi2XWndwMqI68LrRcKuPvn7Nq5t+2VszM349wsWA
	 u1fmhSbTvbUysOgrOQzNb7ySnm5P948hcLY9E+8W047J3x36szEgGmTk80fzIsPz+lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I+5yf7mAOeeSkzrAM3DR7fyzpJnsm0wdRvVdKzxj4Lg=;
	b=VOzRKPs8bO8r5hnFDdERJHb15NWm5RoKgXFpCmTecQ+WKKTksJaIFIThGj/EO32Jzi01
	 HI/JMVoZBe7wFOdBVoii7UevnMhnwhzoKkjB4/+NunEOwdzT42v9TuNcq6mWKE737E085
	 fp5DeHxiRqPvA77Ad/fvkLroaD02FqEmz+ySfSTWolzz94+kDZ/MvpzSqG7JClqgP1wz+
	 sWVAc5HpYZXZRTPmKPIvlsSBFo6ZBBeBYq4lvLO4oeE0tnM5Atjj2fasAm/ZWKDYasWVq
	 wfPJHw/dUvxvzdNJvl31MIvuuhC0qcjiH8mp6Dp79ZlYc913D3/QELCt46vDxKGYvjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLuEE7lW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D76606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLuEE7lW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8671F01829;
	Wed, 28 Oct 2026 03:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157354;
	bh=I+5yf7mAOeeSkzrAM3DR7fyzpJnsm0wdRvVdKzxj4Lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLuEE7lW/DSVQxlt2S3C0LBW/pfk0PNaDIwasWQQM1DMoS4tQiIslweYCjn0+whZa
	 hriOd/wRqUs1qiNPUlhH87XZ0hWSMOTOhofgXSFyNliG4bcJ1+D+IWZ6Yldmdmy1li
	 4SzDpbvBAvVJjCqxigZc+qiENneJ2xUfL+PdlwmM1JxjchZ7oSreMHkHS8zAfwRcml
	 ESfx0SUccEXqgE14VJ+MvRDNyijwMcoOvtqR7Cs1pLuOXULDHZEAT6vyo2y5DL4ZK7
	 H5J3CxarFEOkejycHbbp8plJ/uTTknrq9/Pd5oigoxCREqfK3Ra8M+y077lxhPpOoX
	 xtdAuZ2rsrJog==
Message-ID: <sashiko-outbox-187404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/14] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-5-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:15:53 +0000
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
> Clamp device-reported capture lengths to the message capacity before
> advancing the hardware pointer, preventing an oversized completion from
> accounting bytes beyond the buffer actually submitted.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D4

