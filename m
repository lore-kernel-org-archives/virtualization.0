Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838065;
	b=EvAV3KYeSo+sn1muufWTm1Dy2txlAv3Bobvx9X9dABSsq3S49JGFNUEapVE5OGf4PGt/
	 CYzzYE8eadNdvG3CMNOy1MlJ0WNKA/JDuVyqywCgCdx1mleiDiItMCI4Q2eVX0qy4UoOp
	 T7+sgft/gCYN/EOv7uS4HH1LH/yzisi+BcT9oPjfrcRgwsOFUHqIAgML54wsTjwwJxjZ3
	 YIZwoquDLemiqDio+0dTHlZXAK7TjXhTcf62bz1/wvjeOIYzLitfDUhoaN/B5zsvupYTe
	 lHlY861vw9CMymATyH22NHIhqtEAYK54FhtVuG/3GHkCR+38BwCR0xxumrb4OgCcz2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yp0eq1K9tj9TpvaY7VAMDaj25KLl4Rf17vhTeZYcSQ4=;
	b=1KqoNRGZo2jnxERc4iyJu29lrQpzmn047tWxoogP2UxCzCzubPFWWVLdiB+BAAxCuwFo
	 tiFsUm4maAOH/iI7EHkqBkO7LTAQWGqenNnkPieZHnISER+FtOjIDhZUsbiHz+tXi2KQg
	 XaxlC1lNexjcdh2cdFu5TUyT7ZoFDqvrCPrkNqM2sCtroaVhojkO5GiaHNeSRWGMfSioq
	 mMeCFKEDkTxRQ9tL4cbnQJ05OMAOwSEwVDnlyw8iWd8vab85JPJ7AzpVeHuohn6+bJD3V
	 4nOwGJk1jJdzlsYirZDc1g+1YVniglFdJ4prTdDt1zeQMx7heLYqAnAzemhwszRRJAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVkxxGGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50A606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVkxxGGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99D41F000C1;
	Thu,  5 Nov 2026 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838065;
	bh=yp0eq1K9tj9TpvaY7VAMDaj25KLl4Rf17vhTeZYcSQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVkxxGGiQZw+ImGTaBGAH5Xtprc/fVRrei67SladYjQqRl/Btk7OA1sYSbQPP0nvd
	 WUnGMDXeQLiaWcJqzjA2GcQL1iMGNTasbN/JPoY3efCTslP6xzYA9lLqQaI1L3jYE9
	 2v8vH4dUN9rwFnMd1d1CxJNxaenD6iO+/Yq1F10KVbt8O6gdw92Mtwt8M7CIqzYK08
	 TJUMYcgUbTEQj9hnJhsu+KCWYhFD6IpamihKa3H7XZZCFEuQkUZM7VgfPkmIngWTmh
	 tA6sogYOxeyQIvrKvQU1B6k7VfXYU7FKf4Rd9rDNhXf0ANonS2KyjI41CO4uh/XMVB
	 3cpZAsSHF0pPQ==
Message-ID: <sashiko-outbox-198349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-12-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:21:04 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D11

