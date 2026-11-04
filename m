Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759307;
	b=nXMrTZkj9bWtELE7tBAcu21p1vpt7m80Eqj6xV3IFA1dW/vLlAKdT6tOkk8EroF13WwC
	 CmU47XS+D4YWW40WCb6J9lURBd62yxviCWNNoEAvB9nsrZFXv9zG9Bx6lyDZP/rWqeeBA
	 8sWn+7Ug/S4EW17U54yg8wDEjXYaqi1Ot9wa3qCEUlY5HKJlBZq3/qqN2SnuFpiGCVPGD
	 T0LPyubLnk/CATxgd82bWyvSxatMKiiIbvOVsB0ksCftMwYdpO7AD42EI4XEnW7v8DBde
	 cVzqedd6Tx42M+CzKu7AMNsBjOgmkG/nM/aIfVs0X9BiTJv6zjdS94o2DoDo/2DhjIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=85wHwvGBsHucpBh7ywSEwaM5qX9Su/wjArJP2ZiMvvQ=;
	b=zWX6nzCs2WOFwiy/l05HYF++3gw3Cyfj28zc3pi2V6u1E9osaHuce4uQmT8Gtoo87i2+
	 sKlYIAQBxegqIECny9AxpXY+iAvwWuzMjwIPA1QnC424VWr4WsTjUyLcLG/jQiQ4Zl1Xo
	 SGpgjX2hbH1QlkuU+UANOGoLpm239eVYWBdSX/gjJpPpkqNXqIReX1skHKGKV6MlAbksy
	 QT5QrTc3qaKTwbV1x3u4auKhntGjDs8Jw9eCJZbYNSbzozHMP8C85LVvZFjZQ6KYzlI+t
	 Kc5miq9JQt0h3DDm3489KTr+r5Yl2OauXXEtUECkyEnC3/qk+Tm2w9vjku1M1mCf/jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lpH/TI8Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE30606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpH/TI8Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213D1F000C1;
	Wed,  4 Nov 2026 02:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759307;
	bh=85wHwvGBsHucpBh7ywSEwaM5qX9Su/wjArJP2ZiMvvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lpH/TI8Q9slrZlkt28TJqYxyWZcD3DqJDYZrbUaqpsr+Ec+BvoQE+BtfrSkAgKCry
	 EnCbXDDi4ECVxOcwF3GKLcWe4fYJPY0perDT8coV9kEyPD1Zp48MCjmHeNFA864h0/
	 adOlfuiJVsS1jcOsNHUbJ4CbOvLi7IuUWj7on2P5fCf7S3kDlFQmbWHBlgrp5gaFcV
	 W6FVhHwhRmcnQslGOQwZlSfd5dMYqxERd9U2UKm+8+KojhhXorwMnfNm2L6x3HmcPD
	 wGeTNMutiz6mMdpcAycF3vXq+MOnaBupxa7XH0d800apHi6qjTiI7em5A6B/Z4P636
	 WATaLou1ioSOA==
Message-ID: <sashiko-outbox-196467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-2-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:28:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D1

