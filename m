Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338408;
	b=3idMpcz+lhlxYh0ALZqu65P3F3NgB1g+zhHB3zdElihMpkwWOn9ctoh2KmDo8vANQSfk
	 j15RlwRvZNU7NVA7y3e9+acpAy7iPsDehV4LyCTVwWKonecUGf7xvDuO5nytjvQF+fkCb
	 FY3ctINKNkLKr82Gf789a10wuwJCBHQyws6LDqVvPdE8/GcBllsJg8Pd7dX+Wi8MfdUdR
	 Zaqdth6YU2hzbkPYoXV9neWbbKSnyiF6we8AdJcb0WDo8QE06MYf67QNc4kNTfTOdFqmh
	 gkRrHp50rA9V/yBmRzEARBz/j64qYRQ1DfY3Pq2Fqfr9tmS4V6f8nv1J98NfyO0vduA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TiYCE8e+EfXmljrLAepzlCpQEsk0qHUHbj6Qa/KiAoA=;
	b=vpL44zdurj7cw9yCS1oK7Az2t0H8XpQQHCK8uNyF7jFNwrIAWHVxc/vTSa557XNn9lHZ
	 ty2/B8t3hhKyRh+LdxzRHpgiydbpBq9KPZI4NgPaC6I1mzVVB7fZD4pe0L/IidYQmBw5g
	 /tkOSDGLNaw/VtBSK99q3PHPMVtm1r7jNr28EoALy4uvzRkJAH0dlV2UjWs2wt/OEiSQw
	 nJ7+feN5nnnCz8l9859GVszW7zPmgHZrlEEO9MHezeGjczto55GIKS5SZw25movtCzU8W
	 Dq/sV6RX2yAnsHYCyTFn51ncTsNsbxEWPhoH0kIPNKd7gWR5iuajPFm0y3HZ3XxE8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbDKcS9a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8003606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbDKcS9a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AADE1F000C1;
	Fri, 30 Oct 2026 05:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793338407;
	bh=TiYCE8e+EfXmljrLAepzlCpQEsk0qHUHbj6Qa/KiAoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbDKcS9aExHJ/vIXuCYmHTzaeRu0wLp1Zt0zdj4VngjitpeKITMaGFKKPDQClh3cI
	 CN2qEsgEC2am6BQnUmXLjrvZEPPuFwKWVtZsBF696sBixFP88yVkN94i+MDWSY337a
	 +n150873Ntgdj7ocsJ5uvfeEmbX5gBvTbwmbVMy/E9ecZ599CdY4Rv72KzUc+Nmbt1
	 geqOf9Zbsc/I24CJJ3GVT8BaPQEVgdoA6DQIqXNmADfbSIgrUkDbRQ/v8MPbPOQtqL
	 CmWhrSoWupKYjYPX6BOoCBrJ66Nald0T3hvxdowwfGHjSX/zP//GTGRhKldx+rv97/
	 AmxoBp4YSYYtA==
Message-ID: <sashiko-outbox-190563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/14] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-11-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:33:26 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D10

