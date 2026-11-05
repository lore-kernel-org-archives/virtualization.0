Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846159;
	b=OsL1dFQVcSL7YXZ4GSuWZtoIbUd6dP9Kpdl1UoxMwBZgIIqE5vAn+mKJ/LzD2utNndTt
	 urg2q3xfo7hJvF6g2cAiU+BHyZHUkMe7+hvds6jpeDFcvbsBF1D6e5Tu1VTZ1fd9T/hJY
	 mKlTyCz8aiQqv9tyW8YttSDWgI7S4h5ZNoMaX6u+UF7tfCFtFI/dcYCkIBLKIxMCkjbiQ
	 N7+rTuSyW7zc3h2iMiJj365/OHtHtR5nW8UCPrOiB8Y4swxJ9lWdDhixFKJfDh/1RkF+b
	 wZPlmFvpRJmmYGxUYBX0YOv/5wT+y4ERyVHCQ524bptS36jH4z1qc0ABvASgu47264w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r+BFalCEzBBFL1mQoCqIOYHUEz+Bg70vdeC6IjwEwnc=;
	b=ApZJeV2G//lA89H8mWpdxNiNf9Vg8+qjNM+EYHfECnCWGuQSnJnIYG+lamLW/2+j2ONZ
	 mYzTWMwAzHElFkftZjBL1DfLBqu6Z863fdjpG9NGBWJYZ7XPfiWRXhA6YOjNr9Y+dFy/D
	 59crdyjvkiBBWBA9sw0n2Ltdhq9hnnyGsR1990LqNtNwHSKS/+LD//INAV4UhlORtYpDX
	 j4IL6QX/ahiKa7ANLbGAsmtzPr+uHpLLOo2uoS4Tg5rkTG7bie5/tW5sRiLC6PP5e7S9w
	 jA9L9SDmzgdEPR2pCFSwTlfTthWEegb99MtSIgqeyR25lwk3OLjssDPQlZYA2bMDPag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq21gRpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C57606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq21gRpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFB71F000C1;
	Thu,  5 Nov 2026 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846159;
	bh=r+BFalCEzBBFL1mQoCqIOYHUEz+Bg70vdeC6IjwEwnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dq21gRpyIUfOXi2jptzMHY2OKbcX/I8hLwDBaBQxYEfZgamzDo2wZkhF18PLTjUog
	 J1VqJEtLm77JiLRppqJha85WFT6OEp2ZfKSApTBuxawY0lOpPYUidheJrXsR8MY7Kx
	 2AD+Ri3wot1SqeJQTxkuyv0qFuaaSgZMQyxTe6OY0xEelMM8Cg28Li+fwBWamnWSKv
	 h5523t4DQXOsZdboYNI/BlRL/0nqLNV8R892VYOGJy5bQzHnGzQmvyqnLamZKTsEjA
	 ZpyjsG0Rz9mTH1ELEbT1gHbuXJVlQ4aK67DBvRJHF+KVZejnQiNNZfcao21kDjf3Ic
	 NKt8ttNMbmlKg==
Message-ID: <sashiko-outbox-198468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-2-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:35:58 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D1

