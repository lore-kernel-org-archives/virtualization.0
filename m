Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183465;
	b=UEtukDbWgyENNdNS8wey0880CjI8lgMqEkFps8tKZ6bT8qyDO86zdPIalLvfgnPrzOb/
	 Tymx2Rs/gd+/7yjX0+v2yUQCtPCnhNYLgE+MHN/lDPQVimaQjHVnp+kFbzF+ZNsnS6sMh
	 5zCeDBV9xcjq3U/W1Qu5I9Nfpol42RwPVT0MbtnUTaDs+ZQQ9HW2NgTQG4T1aSoJRDgnk
	 kCoS36qTUFgZlS6vHDgPaol//sGObPKrNxc35jYBWd0Q0rQ833IpanJ9v9Wu0p6WDQ/EQ
	 AzFW2D4wLcSBf/WpyuWCSx9+BXOVCW9Jvg9IyYEGlAKSQ5GmOgDq5sZpiFlJRn5PlOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183465;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sAy/m7KFMxiX1HIuJJzktwrF36XquPiGJ9FJHHvbbi4=;
	b=CVfWMsJNCLRlgFTgfr5dAqTxRy2ePlNXwWhCiRXV0KoljSr9W1ck3lBryJnSaJ1sFubO
	 FD0slv7YblX55Be/l8vT/uirSozB/ILaepKMmrCKjY8q3r2atO1MZDUXNXOcOmO6zFmoQ
	 5xfdrnhz633ntHJ9GRS5N0u6xxTgWOcU5zplcF8rnStxs8A/EQR5289WUh3nOgkxOhdjj
	 Qag7HApF8IX6VQsfk36Dl9+m9gTNhKwXHkaiHoWXJGIt/hgFbOcTHET49wXMe9Pg2GOoF
	 Ok2C9ss1GHwkxoDrAhVHHrEwkKLwYbGwEhaoTW2uqHhEm24hQxgN9UBQvoa5P+ZHAQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKBPC1qK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F53606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKBPC1qK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C011F0089F;
	Mon,  9 Nov 2026 00:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183464;
	bh=sAy/m7KFMxiX1HIuJJzktwrF36XquPiGJ9FJHHvbbi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKBPC1qKk2wgb7HKi/cCAbOsBh2nMzlqBF1PoRRpMIb6BvCmxRnvfksNZ58N7RJwP
	 amPOV2AfSt+sIREf3aWMq8mLVdjaVwNQPiLxhj2WSfBLbd/cqaSEz2lvxZHySuLuhn
	 4hRHE86TUhhxOdBVi8P3zvx/cJP1128Ev8Kdpm59wx2oGiODIpzMq+dLhou0Td+JFu
	 0hxeKSlVX9wutDloZAktZE2FWKwAi6b+gr61WRnOPL0nuunNHiqEH7ywmhZ5uyKUBs
	 /AXe4ECkiTTgAb2KVyuV7KOjcrkQlmChutb6jHLPwU065GXsMm9G0MpT31cHVTypd0
	 IRJphHkIWyxmw==
Message-ID: <sashiko-outbox-204205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-10-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:17:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Keep timeout and wait results in the types returned by the kernel wait AP=
Is.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D9

