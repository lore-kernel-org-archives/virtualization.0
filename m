Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462595;
	b=jG29yUMMp93B4vNmKvw/S0ORvJVuhOqb5nbLf2EVIHW+wbIoTABTmJZATOW9ZNg3AnKE
	 vmtB5/JWmGmU5EE0Q4BNk8pG7sGyP7RhOkVzleAJcXRs2/S9gQQRYsRFgNaU6xAzm/Gsa
	 Ewi4gKn7gSKidSz8VvKWgMwQnvKzF0xS8EsGFINYnZSMntdoFuhYaJB0LBdhpJ2rEf64I
	 cBaZUs3gRFcldltFpCqMoW4ICwITQLK4DpxC8zE/s40tNJNCpXsLA07jPvlsg6zEKqgDN
	 M241kONTrDe2UbIFQASaQygV+HzM/AJ7hVz2qArcPRGfr7KMLY9D/l0vCjzzMX0Lx9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZC/GhqwUzG4/S+lnqZ22MIoXMGawowOMEATE1tQdGYU=;
	b=nJOZX6kZg1S9k+GoL+bcrNeUXIcjL9gnIPHK0klUdKjUfvmEYhhoekep7cYrXue8MaR1
	 05KymOmthrbmpg/QgTcksJKYq3HDe8uvY/pDcRW50FBaZOigXUv3NxwLuSujRrMz7so9w
	 6jEpIkpwly83E4UxFFGU/AHyFEDZ0cmsUYKFTsoYZh4u3inrO+/Ga3YmOSJTmFJNKzqmF
	 8RCQakKJUSRALrfJ4jFd3wYFBfOJZV/rEqmWE1fuJkEfzqNTI+kYQjx3oUVPBwPPIvVzh
	 0CprDwrhqjd8016VZO4MwMkpmoik8abKAbRh8hBOe0+0fsXLrFUfLdz5GMEmLH+Hi2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHCUJH2M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AAA606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHCUJH2M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B671F00A05;
	Thu, 12 Nov 2026 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462594;
	bh=ZC/GhqwUzG4/S+lnqZ22MIoXMGawowOMEATE1tQdGYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHCUJH2M7TpHHhVy9GgEq7YTgK3FKvGl5Bc4Ick/BxOA/dhCzPOu9ZMvA7BgEHmFx
	 bLtaR2hZl0C2bb7sn/3RFZOvbIh4ceJkK3X97//pgCQbjntAaRglamPiwq7ptCt3oE
	 DnGMJfVup6xqe6Zgo/XrP1HuuDCAgFAMK/+puf67QRLojzKqzoWkduOF3GARWD7/cB
	 gC+4i3Livtg3sFyUh8AL1U+kzteCSovzFGOjUbba/nWnpeCgZ3eO5yw79d0iizcE+S
	 DcD6iDLR/AR0g6Pq986JHlVEqnqubHv66JRZfH4HJldcyLYDsRkEi70eO4rWsra2Dg
	 OPG5el5ZuUypg==
Message-ID: <sashiko-outbox-210482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 11/17] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-12-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:49:54 +0000
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
> Keep timeout and wait results in the types returned by the kernel wait
> APIs.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D11

