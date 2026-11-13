Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562238;
	b=vgPE3Ixb/ZL7nYdB3l5auZRwuCRGWcgxjEVQQfRSrm7grzh1qVY1yWYJRUIakDeUmR/L
	 7FuKb23ujY7bAa4TB3CUSUw3NRcFVb4gucd6JCazu9bWlCUwkeJVDzvDJkqgMQ5PJZraH
	 p2birdBDXyJYYcZBr8dt+dKId0VXulK5isjm9R2yCdqbVAN6pMxl9BoMDdPn4ROu8UPDL
	 owvPWOam37HR8uQkmQq8aNh2bp5cmHR0CW0srCfcoD8KntzZ+T3igEvEzPCL/qD4Z2zUq
	 gnEgvGwKjPegmXPaQabdYRYiYhmT12amaqianejtWnUztUplkrxCEXHLHGiisnPeY4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562238;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ifAA+/dT5aVnj7nCZbq2QMBE/0SVy8sgoADroqGPD00=;
	b=3i5vEQbj6i7AlG0dxJqizS2YGA1ZgIUaYjjFv7WLWREZnRV2s7N8HUPEAIgaB8EPBM0P
	 Z99X70AroU4h5+SwxVh/AnNx76CHF+3YVweD+T9MKqNCHh5LWBiw1Ggdg2VYIrtVcZo0f
	 GpEpMdBeCe2gaqvFdV7YIR0Xym+bGbTuMEpyHRpfzBMMLKGz+RNPW6Ex4m6n+njwWUY6+
	 x6LE1PKTqyUjMz30Pl2A+IY4jzDL+Cc05mElUW2rEJkLwOY+xbEDtunKMMz/nt+aypxdW
	 cX34X4mwje1I6FdSwWuzBmwBebdQk6UK1HkP/A7v33cNVSLWTkZZZyaKBz/oLIkDUfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MiC/wR51";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39A606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MiC/wR51
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191801F000C4;
	Fri, 13 Nov 2026 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562238;
	bh=ifAA+/dT5aVnj7nCZbq2QMBE/0SVy8sgoADroqGPD00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MiC/wR51eJCOXnruyi34M4AlhPImIhf5bdHni0REnkDtcZRnBMfsGosK8b0TjNEYM
	 8Fl11tqjXDUS614iZP7r9kXkIJEWJC46g3GiuZ0iuBEkIpQG6TkuZXB5FDcx2DBAq0
	 TmOZptqopCF4F/o5mFwOCVdOwTMqMJqMY15FSl+aABAcrCVVdDlfScvjpfhwVRzdLK
	 Ti1hvbxMa5blOXTh8oJrSFNyZTqMQ5GQscnRfhfDjzU76Xf3lN6CYgKS4+FZhbKI8k
	 wKNx8o36dO33lpIFc0BERlaRdgnPOkANS5607TtdDyYlZ9J2C3sX3qO94pW2zBJxKo
	 3hKhDNLNspIMg==
Message-ID: <sashiko-outbox-212546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 03/18] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-3-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-3-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:30:37 +0000
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
> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> [ ... ]
> leave prepare-time filling to the normal START path, preserving samples
> written and rewound after prepare.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D3

