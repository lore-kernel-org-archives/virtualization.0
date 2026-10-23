Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743273;
	b=5oxDgkX0qgD55FBN/mO8vFIhbzBQg6Pcy/al+MaCApV4jFkboBsR6cgQxJFNY0tIhFcF
	 u7qjP5XNncHw6+99UTBvhMuPlkIEPT5pYOEH6fKoeylK1N405N2HZYXyppBSfBMcGdXcc
	 S7XclX5ZTUnrmF4Ss/HxZ91y/1W6zDtkbAizoLDuMAU2tD2a90gpllyUDdeG9liXBxLVL
	 Tv7fJmrKXq+697ZuI5WoVVkJHKdk3UxBzUxSNpBul89909jTVCbxPl/ZtC3a8kgMgatnl
	 cNoboUoT1/6KvkDpfpB1sIdrg6FjGHhIev4nN9WWBq+ZzWUZ6aQZaPTqPLjLy19P7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EiC13Ei1CrQqxisRHF/ze/HLaxB7ewnwBlTRDPkpPZE=;
	b=MS9JLObxate3BT8Pl4qRMc8hCO/64X4FzfVNWAvq08/wobSgmaofpXHq+tJS5V8vSnm6
	 tDOvNScW9AuH0pypCijen5m/h1c9JkMf2WxhvTfxA57qPXLHHB5ZDJj1+fBtT/bWFx+Mv
	 uX1TIZ2apTz397JQ4PTwJyJ1jKdO7cG4eXABb/mvJTsLhGp4Rpb4PnnkCAhZsPSUKXPyZ
	 z6FIGiW77+QPN/nD0wA2E8Rf3EYS7YUd66LVXA1a3VXntHTgvsOLYxDz6eTeOoFOd8IZE
	 EKdd7h9kVcu5r9oZCc8z6CRAZNYpvXhYk7TE3TiAhhF6qDbHlshPevD6DNYNBpM1bWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjXA76er;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D3606A31E
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjXA76er
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763671F01828;
	Fri, 23 Oct 2026 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743272;
	bh=EiC13Ei1CrQqxisRHF/ze/HLaxB7ewnwBlTRDPkpPZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjXA76erU5SdgFgAOs1K4hELPFWUR8iiwB7nMdYvU/Nu5WkF0sUb5Q24kuNGx3LH7
	 d4IDwhN0G2fcYMfDOS4S8BQWVYueaXGpKXEyTFXQuyh9c2BYAKTZ7Jt0h5vqsmSZ2X
	 JAtWDnyfsOCO6WX2PJVQDdLA7ZaE+lTX55tmnxTRbVV0pe1ec2RyG3Cnu3JETNkO+V
	 yztNyRRDI+3xftXK86zfROHQ3nsqJFTpJ3jL6vLxQ87cYwzGuG/VAKC40ousqcWmcZ
	 a50E2qc4zWcF7FYymx4QVJV9u/euKxtnXdzi0tHmR15jP2a0lOsopAQJWUhUHXZ2+S
	 dGH4YBCeS5UZg==
Message-ID: <sashiko-outbox-182493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 5/5] vsock/virtio: defer native RX readiness
 notifications until batch unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023075140.9613-6-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
 <20261023075140.9613-6-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:14:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> An RX batch can make a socket readable while the RX worker retains its
> socket lock. Waking a blocked reader before release_sock() merely makes it
> wait for the same lock.
>=20
> P4 coalesces native sk_write_space notifications while retaining their
> under-lock callback context. This patch also coalesces native sk_data_rea=
dy
> notifications and moves both callbacks after release_sock(), so awakened
> tasks do not immediately block on the RX worker's socket lock.
>=20
> Save the native data-ready callback before the AF_VSOCK socket is
> published. Batch only while the native protocol and both native readiness
> callbacks are present and no psock is observed under sk_callback_lock. A
> socket with a replacement callback continues down the existing per-packet
> path.
>=20
> [ ... ]
>   8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
>   16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
>   64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023075140.9613=
-1-physicalmtea@gmail.com?part=3D5

