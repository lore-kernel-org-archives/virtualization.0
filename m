Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553174;
	b=jSbFTOQnmXMIeLmpkIjUlGiGf/LZbA3dSDOtaOD6RinqBLjRrdR+MxHJ3DngUXW+ca8L
	 CR6DOKad1NFmKDDYd+ZAGkSY6o/PYqRDGwAkccw205OJ4QC56G8plPe+3qzy1DKtq+5eg
	 FZF7xv3Q8ef0hHbXGsPYTS/uI/oLf4z1JziloCCzYWZiPdlJPxDv9e2iuCrjHkJpY3gTl
	 IEzXAPKEVNyxeKQZpuGQTM1LNtFwMsQy2ojNybiEmE0psWRt8Gb+68UiwNQRUx9Oerp2H
	 AaSHC4Dfif+u37JXsZoOYSY2b/fU3zEsk92pzgB5n+nHXabDmiv+nu+Ws4HJp6bjlQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GOm9g8xU2sr0bJ+a9icQcsF6GP4guXMnH3AKJeDQRjQ=;
	b=TmoZlDKNtdhtZeOZ3Dteq7VTGatIeD09CSIMx0kr8vefWxum2EYNmz8w43u1x+hj9XVa
	 i+Czg4Uh8K26oKtHiFQ5aSUl0wx3PwKA4Ltg1g2xWHKTRSyZscEmI0hRKRtMYxDgWe640
	 jnYb4k1mZn9rSo+JsYKkJq9WbLwWIz6TIIWTw68W4tpyT7HO6/c+7z1z4oPR9YXLLi15L
	 ycLk+CEO8/QW8oSz26lRsQqBEhnb+Q3tGng3wDgjiaqV8jAZtC9cPsr9tJrDHJVPaiYWd
	 zwyV+kNQbjR+TasOTb9WO8Tg7sBZMVL8in+ELdl8mEKu/JH68TkhpkFkDQMmMjl/V/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/59gVvN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820E606A327
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/59gVvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D8B1F000C4;
	Fri, 13 Nov 2026 06:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553174;
	bh=GOm9g8xU2sr0bJ+a9icQcsF6GP4guXMnH3AKJeDQRjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/59gVvNLqrLikutfSnzNAUuXRNZIiWrJ5FOYscVXQHjAuVxmweaqf/+Gf1P7wwWD
	 vnyY12hGIKvbzKG5LjRGCcMTykYFbydP1JJ6XvNCqkUT7tNzTqFLlRyXd6w98BulKl
	 H7SBZhNiftgZaGj0L05LRoWMLMXV5pS/fZTuYjde0XFiX1h0Tx553ypXiLblRbF0H8
	 fhR3ARxK5Uhd4Rr0ZnGNwYY3TWLXRD84NBVNRhtsooo9Nf4zSfxqjBXXWdVbeAWv5l
	 NBBApPtXoCHvI0JV8cYaBEEQyJv7mxvEzMWqxh4b5uc9iNhosUttoCXhTdMz9G7KDO
	 +cFxw5CEuMMQw==
Message-ID: <sashiko-outbox-212303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 15/20] ALSA: virtio: reject invalid playback
 completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-15-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-15-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:59:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D15

