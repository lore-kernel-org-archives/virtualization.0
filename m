Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264149;
	b=CMTUQFZs0TLi4J02YhtJqadDZWZZdgkqrjvEszCKPMWZTqEXbDkiwrwW3MQ3Lb+4E9Va
	 7T5ScVVPZkkVuTBkHWP50BygfjobByp9PWDyfI0YPff42JUOAb5i4VlPu6I8vyrLVcJGN
	 zk+l/ruKhPeFaao/RddpnM7+llmNqmhAKRNwWpfq6UHDlyl9VTQJV1gsiR3ZdkQIfbFpD
	 V1B5e8fLMmfx71jK+w4GXRhebeNMODQZMBqqdHLPubfDGnB0ZKfq0aHE3BYVgsFSPpAMs
	 JHro3nnuh7O5UHdjYCz3B/bK4M0EfbIK5KeiBJr8OEVUP6vhAbV3AVLvC2FXGAoSLmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r7oEdPCb0og6uJ0uU06Qq1+zbZoVjmDqHhX5FHUe+1I=;
	b=OmC2eBF0CKL2otGqn2jeo9TCkiIWqSGCEIVd9vFwMOIjx0Vg1tWPknD3dqzkl96Bq1H8
	 Ou8Ea0uq4Iq8SW176tIkT1W5+6jFcfNvfgw28CfABSra9MpPh1RuDidIIeyguONMIWLhK
	 7gUOS76kLYbEJWwBKWf/TPnTspyKuL1pSJgrpamVwlnoxS3OIvbUg/AhWTay3cpvVWdpp
	 qmbIR75HmUbtzs1JyT/6n9+Mkhe+fM68F2BPS+WHeAqjm+tV+c8juH6ZcbqyxSWRiXXec
	 THd5TzjJEdmZ3Ph0wJlxj1nV4Y5v1On4iVQFW0a/50j/X9Bxn+HVKqUEcQcxs9HBFQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J28VIN3l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC609606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J28VIN3l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834A1F01825;
	Thu, 29 Oct 2026 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264148;
	bh=r7oEdPCb0og6uJ0uU06Qq1+zbZoVjmDqHhX5FHUe+1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J28VIN3lNo19n3lE+x/lgP3vLE56l+3UCL2zabm+8EHF2Uiv9+pLIr0qTEtRgFZ/q
	 uk2NCIYTikdcN5UqNWNM6Bx2XeQHGNyhucSOSAlMO/fFvyxefnxvCXkWXxAz5l59fc
	 w5JAtdOCRtkVh5SpPRrWfln1v2ROXNXn8+sjMvmX2c3KSHDvlsqGquv3AhbOc5wGzB
	 isZSalD/paPGy/Fr2p6+TAD5JHIdG8NEkV2nQrThyG4Jz9VacWy32FM9eZ2Dfe3TWU
	 5x/VTkypdr2Ut3jacCPQSnJCSUya41tcF/fcdAUCQBaYyzoZkP3hblSSPi3trRrTpY
	 wnVp9BwICPMtg==
Message-ID: <sashiko-outbox-188994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/14] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-8-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:55:47 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D7

