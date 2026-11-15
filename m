Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727279;
	b=0krWAhSny9lrFMY6lz+wWiembkbLQ6I8tlov7naW6rlszwNZF7bka1nAWqQ400dHiK56
	 Se+lRcBM1MxUntRDocAUdnXuiHqZettO/w7ddO7duZ78riKzo/D8ztf5fQZA20ij+gZVr
	 z/EXg1eCEViYnDT1UWj9k1h0KpmAfHkaw8VOFxjm+NBUIIVSEwH41siaJj5SMT1auOn2E
	 4RaqmLkN2sTWCdAdBdVudNRRboNCHgTRQZ/0IInBQdQUXRbm/+IeTw9hDP1Dd40AMhw8O
	 iZ8o8elr/EnfYsIxHoEDBcUsAH0XHT8HpgHxq9DRU3iJyRil5s2D4ljMwOB1OE3WbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WwctEtLrg8sIkpONRC3JJObdHyutr6qJqVr7ydDuN4g=;
	b=eFlxTXdSIzTPb+nBYm1MV4DwqnbmZdDd7Xi6MHVHH5IO0iB3q0kQ7gZxRD9RwOFrCWWG
	 UmDw5V2xN7mJSYtrtFFCLj97HHWB59Iu0tDoOoFVAG0IFtNVzVNuTEfp67rlxyWDsi+5C
	 2bMQhwwpvxy3x8jti9m34z1BuzT6wClEJL0je7FWYh+tqMtImpEKW41CI74LLqaShOMZC
	 8NBHbzm+vGjemoTW+7vVVGDaxhvipCHw3p92WLn59dbl2jdQgrfCT3H4Y5BQWes+dR9cu
	 jHM0U/MEYLkyn3QQBybze9+yhdRVHfZ6EGloqXIDDNAc/zWuMR94m4JL19VNh3UuC7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ffq6/wCY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090E606A89E
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffq6/wCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998361F000C8;
	Sun, 15 Nov 2026 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727278;
	bh=WwctEtLrg8sIkpONRC3JJObdHyutr6qJqVr7ydDuN4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffq6/wCY9zhkQUUP6Y7so4qXMp4BndyT+t6UxuEzwTmP29xkwtRmIwJDAXsEfu16f
	 0CmttosybqDHunXHwiMR1SiNQgXARAJeRWO9AVbR40KvvbM83qB8ZK3ctcpxtAMdIu
	 7uBvaDI2svtr6S93DYYaGKgDD0y55s4VIRPnOEthpmqQcoz7tzPXnipxovbwPn2nF4
	 EN1r8JJQWZpvslk+ghd9EtctTgft9Fkj7SOHTMEJFGWbWIO1oT66rCuKpT5KfPyVEF
	 GGEWpRwQKH66GKpsEGYGrl6wFS+oTQ5G0suLyHT2gysQnxz1uTurst5b9lIYxJaztZ
	 DyIeLNare7YfA==
Message-ID: <sashiko-outbox-215253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] net: napi: add completion with an ordered
 IRQ mask callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Congjie Zhou" <zcjie0802@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_2A5F8EBA9EC78CA99CD080386A68EE90B506@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <tencent_2A5F8EBA9EC78CA99CD080386A68EE90B506@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:21:18 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> napi_complete_done() can clear SCHED, arm the watchdog and return false
> when deferring hard IRQs. A false return therefore does not guarantee
> that the caller still owns NAPI. Masking interrupts after this return
> can overwrite the interrupt state established by a successor poll.
>=20
> Add napi_complete_done_with_irq_mask() with a mask callback that runs on
> false-return paths before ownership can be handed off. The callback
> must be non-sleeping, idempotent and leave NAPI state unchanged, since
> a state-update retry may invoke it more than once.
>=20
> Keep napi_complete_done() as a wrapper without a callback, and inline
> the shared implementation to eliminate the callback path for existing
> callers.
>=20
> Signed-off-by: Congjie Zhou <zcjie0802@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_2A5F8EBA9EC=
78CA99CD080386A68EE90B506@qq.com?part=3D1

