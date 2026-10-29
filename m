Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264199;
	b=D/Zft6X2z7LSNx6Ja0zZx8jVHGUHlCgZ2Z/J8UTO/oa0QRq8J7PDUmMv3iRpjIsq+3kq
	 paRclbGV2ILK5eS1lsTQOAh18dapyYHrkN1giXPWt+012nKw7AvX2fIlkTGFRWx4pLNG0
	 tmjDf0JdTZnZVPqnP+OWvhnA2QWhKyQ3h1wIIeSCtw6eQgfxU1mzQ2E2E9Pq8Gg/dwKoW
	 csEgv2Vk1qYY41jiiy0xpX+WtdEiYWdFT0WI2zHw+Wc85ZXy/9597iPQSFhgDkS7Af2qK
	 hFZUUw+720vbCoM1F9Sy6va6wazWSAKux1LqScA0OwJbV2oXFEo2QLp0QfZyvq8jbKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264199;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0nNc9qp+CBENIxa18clPZgrOtMsr3ED5ReKfy0lIrSM=;
	b=l6WmXuB9lv2yaABJRWgZEvF24xO9625OhYyN6/3l45shSBcHH2MI2e6PE+TKZn5rG7Wd
	 TjXlICZk1OhReDCC8ak9LhN870ZfOOvE+lMG9ETpfoDMH2qDAKc33yRpPzGXFLgwNRi2k
	 +xW6tA/GtBrwRa2DWYkogGer1GePTPqWtGGX9nwOtomlo9rYKWXWI6cp9lP5/a1y/LW4j
	 NJD74BaWDOcgYkYK2D3GHqqOzmxLMx6b77FAKo/99fz9Lryj+nUvXnWNDGdKgaxiBclKI
	 ZSDGJgdLUjNEmBACpqZ65U/le7+Ujvo5ksHM1MKrD9Fv+f3w/muu+m6f4Ilf8To4jNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xux1gosh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE24606A31E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xux1gosh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DDC1F01825;
	Thu, 29 Oct 2026 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264199;
	bh=0nNc9qp+CBENIxa18clPZgrOtMsr3ED5ReKfy0lIrSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xux1goshpcZ7pk7Vw+x+udWMvjD9nUgYogjtq1ZcVhGlhGuHi70IK2zWBp91ieIC1
	 cIvTuGEQVdFqjlkd00o/3/n/yP04dm4R6H760E3IDpa20hbMhsSeVgmiwblYonsSYq
	 /S1tVQFkdO0SWIbwzEnx0w4HWwaSmdpIqpf2kmOh1zZyxOO5QZd5ZI4tsvTR5bnK7V
	 FMCL5bv0TVftYWfjdNkJdoi3fKS53+9Oy1ryVBAqJfJSW0fawPxgbromDUzyAd0J7/
	 vTIx0ixpcv4uLE8JjzeidqnTsdHMXO+yqo1EJWpt8ABJKJdwPL8qE4WScjxuHWzTR4
	 039mgQ+XtuHYQ==
Message-ID: <sashiko-outbox-188995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/14] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-9-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:56:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring wrap
> when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM time=
r.
> The driver must release its pointer and trigger locks before calling it.
> Existing period notification callers keep their current behavior.
>=20
> Atomic and nonatomic synthetic PCM tests reproduced the missing wakeup
> and false-wrap alternatives. The new helper delivered 64 final frames and
> reported four available frames after delayed partial progress without XRU=
N.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D8

