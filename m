Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339273;
	b=JMuySss/UJEiH6ElBtCNgGyscJdKP7mH6aXpasVCIxMgGzOF0nQZdAMfiNzcJlsYgceA
	 eNz5CY4jLnkRA+PuztjU1PVIh/wA26hoIlk0qUbJ6m3u1H/Ae/hWRpPShduqTafUIFXFn
	 Oi/IlNShCwcmIEmzmNiZj2lu7mJLpudfrNl4RU1+H5fst5AGm2Df1ScSTRF6TCjMSYbOi
	 xSCWkQDLV/SSNNWwZBwu3z7r4e2SoTVfnbXzTH+aDISpr3XWVb2GgEkBndXT2i89SMRi0
	 vvykV9iqz1Upx/iTJtaIj6krbOpGnGPhhQCuO58HnQZw5n4rjf2Iw542A7M0bSGdiPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3+hCKR8W9mJ3xRIrI5b1LbBcdEu+UfHjKxh7Ti9mn28=;
	b=0CNHeWTIlqAeUVQvK9qvRVUWsU0kZSaIxndZFd0h/BL/dqzpLNRa2W0KRTYlb/IVQ+LL
	 JA/xjw6tLQ6J/ve+Lnkvb+BSENhUosqNxFm51VdLtVZegltz+VgbJ5rmYXyrF50lrnPrE
	 BPVH5gd1MYUtfm9Bjl/9jVa7o2SZ2cAiJfDS5EZr+UV74RKm9sSFNPBIp22mWkiH+oJWx
	 A7sa9KbpwI5qmTE2BN/sxhScKqANfSTzVwi5UR1FlvgHto44rH/7hj+ElLEQKBLoEQ/mW
	 TQDKMFCRo0h/GMFlVhm2bkOsKQX9Lxf5fOm7/15hTUC8B0oTvXKoY4fq8orxOu3kTeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAZYkpjk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D805606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAZYkpjk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CF11F000C1;
	Fri, 30 Oct 2026 05:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339273;
	bh=3+hCKR8W9mJ3xRIrI5b1LbBcdEu+UfHjKxh7Ti9mn28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GAZYkpjkW746Cl+mTLBlASoL3O6TmDsoATKI8QWv9+kZ/B5inaBsHZoHrCON/E3Ic
	 w5cfoo4ybFjwuFjDTCjlfRsz3upidCPTwTF9Vjvgf/3+LLfNGTsyGPo97+Yf7nfwC5
	 E47czjqulrDA8RThbCG5DoqsBqTbPfFTQOCkyeQF0OFsP+6ZWzSaAg2j8i0xs/L2Ri
	 fMYHYvrPTAAHtGjRP6dpojrLTASk1xnCggKzoiKJI0aPhhF/aCeBRW8LrQHaAl1kP4
	 qD/lveECKvsIi3iQ6Tv+tiCZeiRT+WYWdjm+MskFI6bqt87n6WKh/80W69ZhWezHrt
	 d/84Gbg+7Fn/g==
Message-ID: <sashiko-outbox-190574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/14] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-7-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:47:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D6

