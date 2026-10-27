Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144922;
	b=xaedI/U2/0ndPbdShAUDiVfpopjouQR0mn9LL3TmCGUHO2ij7LL4dlpKW2eoD9HD+9+I
	 m+3YxScWL+bROxro/rh75QKaQn7UPOFHHUSGuVBsIETApAHxfSe4SeYnlUVxY5xVBvEd+
	 Yd9wCivnQuBMavFzZTf+S3ZMBg9jhgeqXUNM55TOsTT1KX8/ZcGRLNa6gQbCGf4x8X1QU
	 MrELwuxWgRQ0tTDCCQikhP582aBbHgj+BniQo8P+5nBEeXfUVKeoyMJoNYJy9ofLjtDv7
	 jthpuKYIiMftB0sTSk0AClKjkYpdRo7g85tMvJexKbszjmoELhI2Ux4jcVts5KCEJfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144922;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Agdxhed5kIkRdw0LaEU0PM/U6VTny+oz4n2KlguhYv8=;
	b=G0TvV3R/aLdhqrtfo6T7T7wBIGg8T8IVZw37w3oC7x3Gvu3wwmpSFuIUVfMiGLUTa36v
	 EUPFKWFf3KkmwJXsaf4sSo5lcVccop9ONhEZb4ua+UUcTRU8h0S3ai4YNIztSqAiKnCeE
	 Owq/KmltnAdcfdOsqh2wuULAMTYHpR+nJGXOn45MPo7EDScEpiSvpdTO/6GZILJqJhT4p
	 C5/ja46ihNcaFNq6qqqGnPfTein1My2oEXHRgCwZd82D/x3Bn1T7jEJK46+rIOJZ04ynP
	 NEMJx1+RoSclJDaTHlgUtdxBU+SR3cXkXFqR/hUHw0qjVnCMkvAVEpdQkHzHJdpfY4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9bE5nnB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A1606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9bE5nnB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E631F031E0;
	Tue, 27 Oct 2026 23:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144922;
	bh=Agdxhed5kIkRdw0LaEU0PM/U6VTny+oz4n2KlguhYv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9bE5nnBSC3vBssA4Slqbjb/bkR82IYAy7mZAJd+amcsvPEsej//Wz1umfziyqxCZ
	 B9v5AiAlvopZxBF/9XhFwPWLy5AJoXGDkhwtJWNbNEUJWsCZI/oOYxzBwG9dIoF8/9
	 qzXvOEkqAr2aFUoTSd8G3ZXbJ4kqsPlvUbr3dh+hAi4ZCqPF5ADCRJricf2MviR710
	 nprdFPu3vhqrfz0aAjGXTOujBfKyQ7cufsAkriLOk8iRfx3movubUdr9WAEZOXxa+0
	 RH4cCnxuLiQmOgp4dlXMFbnko6ljhzvlX1+mTI28CEQjBlYERTK/RL3i0Lbym9r1Nj
	 ef7nVu3vdstfQ==
Message-ID: <sashiko-outbox-187238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/11] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-11-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:48:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in the following patch.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D10

