Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837613;
	b=jkBTb7b+HV4B560R8NktLdx6baV6ulMT2uU6Rciwx8ZMCTtNTh+zaV6AiDkxLaB7JP7T
	 4rVmF4LyB2tMuEnyFBAUYfrLigthhbntf3E2+50OFBudNntFcjVhpHiuq26Aul7TUhhBC
	 6/OJ1Z8Olbb9Z+ufOA8ldCYPbviskts9S7Id8lX0p4knn3ZQMEScokLA75hxUt0Ksr6R4
	 li8iGPcoFdzon5qYLGEw9T5J3RHy/0YD0VRNkB0Ae+QoptAmvr+sTFn1rinN9bmpfflr1
	 9M9Ph6GW3GGDm+EH0cF9nSSinBGBUP67t9ufEWXLEzg7wyM80/u+M+fap+DBi9+JNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837613;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1VCPAkb/y+8i6b5YaKHwIFg69efiNAPfJw23pFbu6M0=;
	b=DWh51LJvSTWg8v3img1iCztIjhSmbzzQoCVpu3bpKX+2B6Kt/nxWzEpmAT6IMGC4sACd
	 EWXuTvD09UYPUdEfByHec0dVcqfUvZhN/AOUIdEA5MMm56PMpUkk6OnLIPYFz4bd125Es
	 oFUrTi6GumhiKgy+HPNkND6eE+jRX/CgTrmy1lcs5W9XlLMSuONE3Tv62ADRhgAbxGmuy
	 FX2u59YGWljm2LCeq1GSI7Sy0Q0nBKGF6uDL7X8IZIN82oJBxtJRapgoKj/Az23cgp9Yq
	 y03C9S/aV2nOlYcLeHlrV/S8mO1/8WuuvXv1p/l5sqrfQsAbNMzj+kBOQGaxUeKp1sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGvVJ5xb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5644606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGvVJ5xb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929201F000C1;
	Thu,  5 Nov 2026 00:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837612;
	bh=1VCPAkb/y+8i6b5YaKHwIFg69efiNAPfJw23pFbu6M0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGvVJ5xbRsvhtN9iPJJf/ji2MhqPAQBr+KugE9K2VyqRrPgLDtpES3buQJlCeOkem
	 bAQR8Gf9+BX/HcRvJeBILzdmjE9u4Kxoc0zURA0KJS4caqktq05jpo68+k+4vmjy/N
	 Xqad0SsqE3vzKn1R+MahFKcmtLRpRL+0D8FNMGc4rwtgnK9OBdAlc05q1ldL/2CyaN
	 kPzGZLhmjoRyk0C6MdgSuKdd1Knbz2+Rn0PNYe0T5kKlMXVkNEDSjTfbuMmC/EXEiJ
	 Ewas9jO1nLaROVA5GSCBzNy/+CpvXC+gvVCD94NeXGD4UloWyXyTksU+Ca08fyOKW5
	 Tv19AJjQAMMng==
Message-ID: <sashiko-outbox-198336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-2-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:13:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D1

