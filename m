Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156981;
	b=E6qU3IK0y58O3Y03ROFhejcVwpH6T8T3UKK36MnYIMYzH4yPJhUE9myeceSwkC4nQnmS
	 OK3KBMIGWET8ptQ2ZZhCup5ucpgpZBNVJRoj9+C2FhXM5umzNF3V0Ct/4JinL4nNzGPgM
	 38qsvncqXdAAqWNEEqnEEj+nBcfgodOU5/g525WNNcw/oj0fuA1b80yPwWgLahRK1wqUg
	 gkrvzCU1LEJgAsU6VYIbrVlVHB3RMRfGWhbhmqcnUdXliHT2SiS0jD1pP4HTy4Kiwxfiz
	 QG52o8m54UWeMEBzbvMtJ7ntpX6dlQX0odEj7P20o6lefPGkww2ITZZEeN0zZjFOZNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156981;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QNtZ42gTExcB71iJuDvFLn6Bj5cn6SLBFK7BQ1y0Zqg=;
	b=oCVhuOnyXs2hKR6ABvTzWNxnpcg644HEMwv07rS/mfPdW+31kuUHWGrZHsNK0XuqLJbM
	 SOA7uEXfyCDxV5RP3Cy4BVvoZsQ9AZKlSg/xSj+egGv8RQHSRABoQcloMEvGB/bNRIylB
	 c5F/K+r441WT1/K37ZyNgCgUvxwG53LyfALY+WRvuY8VGfe9h4u0FhQ3YDx8x/Yr7aBBm
	 GVnWVSUfwDSSeee9KQP+96mqnY4H2OfbFnV2pgwlcNtJ0mvVe4+3zq7lAfqQhoKyInkhd
	 ZVfEuQkHx+/OaihN4ECQ1EIlBhfZy5+w+D7oEfbCm3iAF7HjwD9d4orqSTS+tNthRWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxCmIAE0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF6606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxCmIAE0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B8F1F01828;
	Wed, 28 Oct 2026 03:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793156980;
	bh=QNtZ42gTExcB71iJuDvFLn6Bj5cn6SLBFK7BQ1y0Zqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxCmIAE0WBQWKJnhw/o4YznaqH8lmaoIENWzK9jHnfeTSr2SG0+dpvaY0hcCgjBHM
	 Frp4NPslmjPJG/t0m5f/fSyoWHnOZYDAAIlINHV2LCkjwrM3+fK5EScnN+WV6JmCp7
	 lEiMMwuRwDiufwBR9wi6pXKnTlvgHTG7nUhyfpf9NS9pY61SG72jM2FXgHaHI0tMVE
	 +z6Df5emrt6GSs7Db0IpC5ylOpo7KcUEbvoxdgeS0eoVHhU6vVYI4cnVZkNPft+cUe
	 eu9PXIdDShfxyjqrBU6kHz6YCIxJrUipBaX3up9yN41cAKOwaNnNFqb87/GfO8q6qT
	 8pXuZ6pUgXauQ==
Message-ID: <sashiko-outbox-187389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/14] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-2-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:09:39 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate that failure through the indirect PCM transfer callback instead
> of discarding it. Commit the updated indirect state only after successful
> submission and stop further transfers when a send fails. Return an XRUN
> error to ALSA so the stream can recover.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D1

