Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699763;
	b=IgNrNiix6TpyD2VU8ctutFrI9Fy2IfWDaX/MEsHccJEomMnewqEfwyPAgxYLSuHAYtAr
	 heq8jWP2mLuxialy3n/exihasmTYV0G+YrvNqJA7LWQY0/BqD7xdQRQDRWpMcJhSRCGKH
	 H0oiISe5Ar5TYghtrhgMJAoDUpTW/YzUNPerZzZL5BAhnUnmfpZaTNtBEg8xixoZMc7qv
	 HVail6AZ3z9kVgtTQQhArq8l+D7rqezimRy1iy7ZNTDV0LXPrEX8NO7rX08yDU4HlT+M0
	 dvRAeNUSUyAp3wX79vEifCZdcRNd+1Ox98l/suilOAxT/jdKXigbyvXaTs3+dXJDa4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=49WjQLGYFYfgeSGJVI+TYq0ZZAn78QnoLzeUYxuPilw=;
	b=suKR9eFCpNhOwaShi5mxZgR+mHnPrHG5vZGSlO8cX5eiaV/KDvt/la5+6v80Xx/a3ec3
	 +5+EEjjaTd9f+pxJZdw1d57cG3iGgO7fzlRQU5y2B4fxwBucxsW1Ev0GzZt56RydfBd8V
	 7BJcNtlOEukL8PsI2liTr5RkBjyoAVZ/1vm0VSEuPPZ1J8pswTYEs6FjmVXGI3MZeDDxl
	 7Yspzj+njJ6hz0zESFTl6wmkQHU5YZ1zkAx+sRJrVP8rClnsRyWu8avBlKGgc4WwkZjH7
	 b6TH4CEu7m7Qp8tDT5sb8NAc6kDRK/6kgh390P9j8qETdY+IpD8fV7pMFMgPZMit3Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOdcgNBP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C816085085
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOdcgNBP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2FA1F0093A;
	Tue,  3 Nov 2026 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699763;
	bh=49WjQLGYFYfgeSGJVI+TYq0ZZAn78QnoLzeUYxuPilw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOdcgNBPn2D3ANoKQ0uDLYx49d03Wp+rKHeqMNlMGZ9T1GKt03P0pbtkEQtZ3k3/7
	 oHpuxVDX6TvQnCIy07YU4dkaKBmJZ613zWkXH1d4rwqPvtotiVl0nU6XieqxZhPIEO
	 FcFS/ZbhNdMaWsYXEjSjhaKYQD1ABp1sClb/JOCK7Kqk3Jf9oUogc7iq6tAMR6a+zX
	 Hx0E24Px0b1R9y21u2lc1IoNMnVh9aoZUgxXZbztz7C+6osJhJdtHFep7m4KpyO5eG
	 dtVjFJA4MsSdRRW+OC+mVUNJCG8M+mvDRRsNB25BCPuCkrJ6WrgBplPsEHw/91ms5J
	 xu1yDDaPc1tGA==
Message-ID: <sashiko-outbox-194984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-6-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:56:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D5

