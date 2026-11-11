Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379035;
	b=d9Ak73HUiTSWRLLWy69Q7t04Um3ieDFcAnCaQ1SJwzHY4OPtCbZq0NsGnQAWQtzbHPmA
	 R8HEg8hb9x1qaMa+3PdCF3Mpmve/4SGfmcRAAj4iTEURyN72xt8Y4wPFaAwEPqcgVq9T0
	 wgJKeUJjvJZYY9fhbkF49icpNyhg1tK3rGiRNShHuEUy1fePD7Sf2e4R6cWZY2eB9Cu22
	 k2caqttLtMYWs+HeT3b6/JaKcTGa3kdAdD3o8jw8tJCduARuvQKqIo0FQ+uXVX32PuRg0
	 KlohZKJ1j9rmjJApZ1bBukOc/sNPoeQ3SBT48zc8BAoCm40I5jlXDWo0yUYcCWeQ8kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XEbZiKVheL1I86DE+JIGvv9Ea2bf6sSL+PlAdxv0kms=;
	b=rKzANj4g8kAPTsaK32kD+gi9Mb9ND745gusL0NGo1Pnu+Rw6YHgvvyxFfhGgouXgAYIq
	 KZnCvJ+0NGujj0p0qlMPxvLTSY/aeKv9AJjqefozxfgQNuf50qTjANBds2RnnUMgiCyWm
	 Fn2DUwry9WY6tk/iw3TzO6G4cCGicUI35kqRxOCRcjVCDaYMc4X2dPqiIIYPlgOxN7wYR
	 rhZK6Zl9YB7/zX3kpjCarb0Wxjs5qbrEz4T/fYfGOm3I/dHwSjmHChnHM0/MA1DWaUhMP
	 3zSJVpJsYYF25Gr+v+H/lBrCN6wn2BPEHFijfuMZVTgEihwbuwymmyzlfBVsmR013Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWJ+Bhon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F0606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWJ+Bhon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F81F00A05;
	Wed, 11 Nov 2026 06:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379034;
	bh=XEbZiKVheL1I86DE+JIGvv9Ea2bf6sSL+PlAdxv0kms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TWJ+BhonwxeqCM+tomhHwMPvJ2407irpyPkhx9IHcoOBgBBgST9yK/fiNoWoiCsn6
	 gcobZqDQCStMnKx/AKE1gQsBTybElz85MRmAhu6+1epBoGQdSqLUzWqiQkZ1j2UBC0
	 wSBcdx2C1LOOvqU0vmdla/KAj3kuqpE0MIQYMyjpfDynCDPlRF/M60OMIR2djoiA+t
	 V5Juro7DkFfwdycYTnQwFJjoigjpguD7sFy8ur0o3tvLBXr08JML4VvsA1dW/CM6j5
	 Y3oHNNbkfdQU3jUN86xStQqVtYHqTbZfaupV7m/lpKzhqw13IaRUHNvl0O0G+/qXu5
	 lKbvj52hb/WhA==
Message-ID: <sashiko-outbox-208454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 15/16] ALSA: virtio: reject invalid playback
 completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-16-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-16-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:37:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A TX completion currently advances the hardware position even when the
> used length is malformed or the device reports an error. Validate the
> fixed status response before publishing progress. Retire the request
> once, latch XRUN and schedule error delivery while preparation is
> active. Keep malformed or failed transfers out of successful playback
> byte accounting.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D15

