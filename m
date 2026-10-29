Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264412;
	b=FrBtHvM/eQJODMvRjLn4/tpClCO2fSvh02hEASr02TScYJOVD9WM0V7WErEtKimSNdff
	 PAR8mH4Puglv8itXsZLd4vJx3A6+0C5j0ReECugRw3gBeVjStsq7ho0ApGEcze4et2HOm
	 WbtP0BSEqaM+SSOcCTY8cuGHiwrHiSxZwRicEYiB3C4k0zPjXnWrhwD5Q3R/rh6xIRD+u
	 cg1LQmJN2jg1mU7XdOfOa4ki6dC8AeXYRg9jlTNeKReBo2PUX30QLuoADAbpPZX+GLNoX
	 /GnwqrhbGjAXKFceYdqyCkPi7aWZcPWCDRC8TPWkeaVStovlt0U14dQ5poQ72o+gy/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JdUL8CpTGncPGhzLhYYNkznWILE/cMlF4SMwaHXrjuw=;
	b=IWJwDCGyKNabOSrpK84cSWABmF4S9bdaabjg2lRIcpyZSGx5/V3LCKtH9pGZNAZNj6GG
	 R20JqXT6XjX2iG45/oreet7n6awWunl6EASy6ZjxAZY2hhl3SxD1Esu6dspq25qsnmril
	 ZoDOFokDvnRpa2zE1jRpd/rE6eFwRPt+y2zTJswV6MabMO8di1rbsJmNe7oOheO4nvTz1
	 5WK+Wz1p6o4EpeqoTQaVNjjyLuoGiBgtuHWGj6tyqGkFyPnc4RqL9M48VRXVfyxtoIp6y
	 IlftamMi3LMLUsqBVQbbzGc7Z5aTaE9NY2sAFfhnYrKNLvAFy1FnYEnFMoErjSl64/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTBVMRfw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617C60A260C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTBVMRfw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E491F01829;
	Thu, 29 Oct 2026 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264411;
	bh=JdUL8CpTGncPGhzLhYYNkznWILE/cMlF4SMwaHXrjuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTBVMRfwgV0GtR1OK7FtoaRwWzQaimCoD4DazAe1My+2hIRziGZIeNHKVFG/sM9Ym
	 iiW26PUF03oDebt61gT+oDdqIAMXen29ThM6fe86d87sEf/MHGHvtP1/wSHTOb7I6t
	 v5XHQFeBKR0xYnvxzDlB5kwKXJUn/XJaOlujeZ/2ggKgmlSV61IvKFIP8GfDnEdtg8
	 ChC5yW9zgP0nV9KlwoH8LM0yU5dHOwjj/DNA1215F7cVLEqATPchXRreMC0+pQkgAE
	 yxcdj4LOuG08gJAAHNlx5AkBJqB0hgXKlJ5kLLVORm/4taxKQ3TMq0hFRjiH4vNskn
	 vfg9wU4HlfSLg==
Message-ID: <sashiko-outbox-188999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/14] ALSA: virtio: prioritize staged capture period
 work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-11-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:00:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Queue staged capture period notifications on system_highpri_wq through
> the common scheduling helper. This allows capture notifications to make
> progress when ordinary workqueue workers are delayed by CPU contention.
> Playback and ordinary capture keep schedule_work().
>=20
> This preserves the existing priority proposal without mixing RESET or
> lifecycle changes into it. It provides no hard real-time deadline and
> cannot prevent a userspace reader from overrunning its buffer.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D10

