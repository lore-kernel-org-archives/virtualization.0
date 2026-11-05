Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846645;
	b=g9ARK0sW6shNcUoKl+dIXkfcwJir5MrmdNNC/LD8jN8WPqsVJMGffBtAsVEbRU0LOKUV
	 8F39nftYk/yfsGpj7SXuWi9wMfS55JcPwRZvo+aKTtwOE92YULTJKPOFXn/md3r/vUosz
	 43GqZ3U38SVEPr5VZmG1xIS9fH5kO5HYnwmQUztjUaxbIy7leeFktLDMKSj6uuATGqwLG
	 hPGYVVnmJFg0pzmAtiq4+07eKJR1GetIPyzew5l1ZNLzjhikbYCiyd+FIOYKfZyZeWyDA
	 iZ6dIYULptbv9SHQNm588Y6Jue8NCD6n0FEjBMGQ84wAjsOPqL/CWTTBUk/sFZiiCXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4tLLIyEtrbl0/e5j1Gno/ZMTtQGu/YZAIYRJJ+mKOFQ=;
	b=wQs3LPxSZs0P2uh8ubNHUMWFNaRuxVQULj+1tA1yQxE8MKWHtRUqDGmzJmXV84LZPq6e
	 PQaorJ8YILNu3vTXNHiKoWYOyymrzOPn94ys30DA/kJ7mHRI2lHAD+SAlwowZdN9r/N9f
	 18a9pXP875fN1WKoJmLiZPnzwWZZkZQiOzn89WIclzGCTSVt2a1mQHcK7r19vQfyX8dKO
	 m7wtp/Ba8usO37YDXHjdn1d84YLRFr3jukeCwQmAq+KGYxogJcndtUCjvRZxsAiJvpiv/
	 dP8pdsl00YaIpk4E6atQZHzfipSJSCm0PYzrXx/nZnxutz1n1pWkgbDEVB8oL75iigw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCwgQB2B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7B606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCwgQB2B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0E01F000C1;
	Thu,  5 Nov 2026 02:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846645;
	bh=4tLLIyEtrbl0/e5j1Gno/ZMTtQGu/YZAIYRJJ+mKOFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCwgQB2BrlloFeWUjY7k2s+3OWq8xpDKSAd7+uWwwU4B3uZKGElE7ZPh8uiHi5pnx
	 7uAjlnqcLfBRtW86OgZx0tBbe72XvCtQqvR3j5MkK1gxCrzWdekKncWf8q+Iuk/mjA
	 gNBPRNoD7RsJX2qBwNz1Ow16+mbQkjfXVokHEITEZO8yziIGKt5eBSACWXkAVh6vQZ
	 gzv84F49/VQOhpp/n185ifnXCVfW4oA4FBIYPbH1zoyZu4D9EzmD/gTdGMzkKCHbh8
	 a9d2Ktn+UbTULhjHKXeRfzTjGyXa58vTKeqkxM4heQpJohOvrTskaZIWZ3f4dWhF1K
	 TgNGH+OtXn5iA==
Message-ID: <sashiko-outbox-198476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-12-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:44:04 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D11

