Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452570;
	b=tLEkVdRZpusp+j0e4VJB9eLghLmpLsNPPGqfgFn+LWfHj/ehnXSFQbAZOoB4vUQOvHSP
	 OKmfoFkt8vb6OWOLVavgVoQ2IAkcd7acyIOydaVJkW0o0lyNzL/IUOAG3OeorFRgNrAUu
	 vEfOCGXft3Bf+rfX7EjAR0ARyJpo45m6pGwzbbPrxOG8MKbvlBtFyd2eQhby3XQ6sJJKe
	 bkW7AYjgHJ7BKmbewJaHc+/1Oh6XfURo/0hgofWjVYQFJvjA5ZNe5tTpUqQ9Kfl7YoRxM
	 TX71Qwys3RSMIVMhNHqFxgUCsOSKeXXwbowYFLhUeyohbvgjJFjJJ1lDGv36w3j+tXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2EOJbnehbW2RN12CIYw00MTZjU7MDuB03FY7MqT8lhA=;
	b=SZQ29A8L8II562jGNH8Vznr7bZIoSatryepjlRUFUM13GKRe0Qe4pVqJSaatfbneM7cf
	 7X3fSo6ETrhPucF0pTSfe9/oo3gDXNAKM6pcsckw93gdOQlm/1YrDTmVSKYoFPDYwcns3
	 JZlDGZKipd7juZk9BRKg33cfLOQX/fA9cGCmNLbGjKTFlpVIECKiDYFla5hvPJhstnTsP
	 nqtIoDvx6PFzkQtVXg1ZTNjJN3c0alBD8h53oAP9+U302t0UO5bM/7d7/qhoJxaPosXTV
	 xhS1jJbpEfO4M0e/mFW9KtZes1NZLRnh88krJLUWDUMDLY1p6B+7YuoBTlknJsnIPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLLE5dog;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5E606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 03:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLLE5dog
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5678D1F00A05;
	Thu, 12 Nov 2026 03:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452569;
	bh=2EOJbnehbW2RN12CIYw00MTZjU7MDuB03FY7MqT8lhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HLLE5dogXQRwQT2zcQ7yMWd5kc5QUQjHilXp/anpUzQvPkMYvR7uIZI8kvQm+oudk
	 QRfA9+SaIy5lj0Buh31sZoDq3GuTq9jLuNTPBTiyMy8zRA1iLmcYw7z4LCAEVstdWm
	 LyRqOfkRKpnJmOjCCNV2JRgKMC96D+wj9Mv8imQY6hiXBBcVI6nhRApsDqCZGhE5n2
	 m+LrrJqQM2SSf0lNVfZ276pM8iAUqRelXM7YqNzLsq/scv7dgps0lc8+ghsIlExOrK
	 nh79Ovaq+0sd1zZqrl+ROmSHPI4J8BABkpv0PIocgVOTYTaklUmj1fYgSYvtZpNid1
	 MS6Fa0UOnz4Uw==
Message-ID: <sashiko-outbox-210234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 15/17] ALSA: virtio: reject invalid playback
 completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-16-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-16-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:02:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D15

