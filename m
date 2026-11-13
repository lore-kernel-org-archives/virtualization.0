Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552663;
	b=F+8dicmyyP4clRtHELcf4pbQFLqhNDEtzW8bIazPSIS6FeECCxha8Ef4/LKE3lcYDlVS
	 K8rLKU6CqE4/Xggy6fqM104SrKPn5sOn7JEbDZ4qxQrDoc/kSTfUJXKRBTj4/g7ZVhiKW
	 looaRBLOHpC3gz4kTgJV6mFR48siD94AfEjXOWiYK8mO3eSem9NnmW/G10+L+bXMvYYsp
	 gWd76urYbK7HbNc+OZPYY6zmuTLAzZhpiYMigOyWmAsXLHDodCAXDRqN3vd2VX2NhBl9i
	 1E0lo4q5mG3acRiAGFSmU2tIpmBB03W4Cw7sGF8sGWRG+NIdBTmXJ/bCAE5A8VDN3Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kX6Ea739G5+gExAisrjJ4jeLyH/ffYLaF9aVPNo+nTs=;
	b=so3m7PBpr5kexXEMT8BpfpE9T7Lcy55Q0oszeEZZkyrRlpQQFsc2TD4UiqOn64NNiq9u
	 cAXVmNksRA6ql39RowsmeSO2LtIKiHwoDTrZ13Gy/1FRumyjrVQDBW93QdRw7X9ks7hqu
	 A96beNbC1uRyeNR+vHx70d9ZnhTCZvcCY7HaqtKSS4QTgeXbsBeILIveAZ0HTsJ3XAmNW
	 YtCO9Wg96XpduuPS2xApHYpk+tqZ/51dG8Xaqe5+bbpmSSVbc7+JOThq39B9tuzF+HiFy
	 hCPFPsKgICBRgh/LCGTF0SN+FEl4FpoJ2PIs08E1gF7L+ZtnYpMopUJCUPocakeo2qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTWY02tm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B1606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTWY02tm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496EE1F000C6;
	Fri, 13 Nov 2026 06:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552662;
	bh=kX6Ea739G5+gExAisrjJ4jeLyH/ffYLaF9aVPNo+nTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nTWY02tmTh8Pvj1HMZPSUA23acLN9B8IWucT4mhXN9GhVgeK+RO0Zwrhxr9YvPTkl
	 Zio1NOjsRItsiKjvzuZYlLJeCnkqGPRU5yPM2v0+sZ9NUhfurLomT/cVFGpMcsB1HR
	 5YWSaDbgtB7jUHvWRZBAmL2zj8zztHtuVVaVB74fLh9WnMGvKs2Xz6y/MuS1MHs4EB
	 j9IptXcFzzXLVPM8CPo67vD81MA+iyaADTBSNpcUSRbk8oI5zl+x1QjeWT8OOo3TrY
	 SP9qboN6O3jXcNBR/ynMMAg6yrnFpkrvDTcSagaUR5RDvD4ZBm58g2p6q1CPgAgVZz
	 38U/8Ipp5ANZA==
Message-ID: <sashiko-outbox-212291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 05/20] ALSA: pcm: serialize linked buffer actions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-5-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-5-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:51:01 +0000
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
> Concurrent non-atomic actions on different members of a linked PCM group
> currently lock their own buffer first, then the other members. That
> acquisition order can differ between callers. Sibling buffer mutexes
> also do not close their buffer-access admission counters.
>=20
> Close buffer access for every member before taking any buffer mutex, and
> acquire those mutexes in the stable linked-list order while group
> membership is protected. Release every access gate on success and on
> failure, including when a member already has an active buffer access.
> The group action then uses the buffers already held by its caller.
>=20
> The PCM stream and group locks are not held across sleeping driver
> prepare callbacks. Single-stream non-atomic actions keep their existing
> buffer-access locking path.
>=20
> Fixes: 3c3201f8c7bb ("ALSA: pcm: Fix races among concurrent prepare and h=
w_params/hw_free calls")
> Fixes: bc55cfd5718c ("ALSA: pcm: Fix potential AB/BA lock with buffer_mut=
ex and mmap_lock")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D5

