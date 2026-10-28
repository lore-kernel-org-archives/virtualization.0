Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156318;
	b=mghcRLBe9T0xZvDhtDOBoQrgWEwHJnfvrQF5R2hcBZPMXluN2dOElnaLwsmgjuDzklYR
	 oM9UbO4yVF8YeP7kksx5ThfMkxmVi/iM7em6MjSh6jg2U5/w8KGUYmUXNJboKcqjZpLlu
	 1EtmqvQlzwp8oRPyUIcNI1FkTSrc7Fi4H7h0blcimwv0YFQwT82FVogKO8NDhQ8cKmAJh
	 CV21bGZoLmI7olP03uM+K2BPGt9Hbi5BY32D0lWNiLd7BEQNe0iaXGFlpCSnP3PbEIC3n
	 p6v2oYkE+ucD8HlPZGFNXc0zzHgFLq/AxtQc9tLqpX3PiSvUgP1ceD8hlD9LkgzcB3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iUMEUsIal193mMu6IA/PXZU6w9rLjP4fslu0e3lzvVE=;
	b=HD8mNou2yU3lgUVPHjEjlWfkr1KmQiVTiP/uRCnaX1wlz1ijQ0wbhzUe6Z/hRCCbnbui
	 tzEqjDjqGLe0ytZp8+0gm9YUb/fYMwc8v2D44epVuqcCd1Xhd3xj0RqdFnL0DWRVJJP3V
	 vnSKDg784Hgi8TJTaONT5THd7Gwkd6e5LH6emvmQP6CLmPdQggJnXJX3oIMh30gsEbtDD
	 ZUbHEPPL21NmjFOAbqG2vR5f9AxpvtIsK3wW7Z8y7HBfrnTbeqZstE7H1vrAMIXEMzJKW
	 wNRLRzC3qEQsshMuWILN4fpzp7TYyout9Jjh2hBYlkI5DQHUxKFXDFdjnuyY2Ty40Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxdhQMKY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BDB606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxdhQMKY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9841F01825;
	Wed, 28 Oct 2026 02:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793156318;
	bh=iUMEUsIal193mMu6IA/PXZU6w9rLjP4fslu0e3lzvVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxdhQMKYkZeTxQLwDl4leXzYkAZWqTwH2qHyl8M4tuIudzxecHqtg3274Ekz5PvFS
	 MOtIOipybd5lhDTz06JMC29U0KnYhBS4AMMhPTVO7HhsJptk8iv98W2UTISraLp95f
	 UYxQAnDOEY6S0K6fxQHP0izmt+wzC6muoutzSj7jsxFUcc7AeqyRhFSgkKFtUiTZ+N
	 6SbDbXah/sbeadqbxQlMnfRZIjdj+hN3WM2va+dhrNiEmwO1YBv+wpeJVWb3ySOhkT
	 mDVpHeJ4tnK2lBqsSM0j5wUD5bX80GQiFiEIx5eWthIrIB4Yb5nh15MD3UqEWOuV92
	 eDBhC/jTYIyMw==
Message-ID: <sashiko-outbox-187369@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/14] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-11-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 02:58:36 +0000
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
> READ_ONCE policy sampling in the following patch.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D10

