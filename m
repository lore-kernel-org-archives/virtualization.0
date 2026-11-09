Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182521;
	b=YdwABKUvhEDlN8V1mE8rmGONxsZCnUc6rDIlMpjUiAjOY90N6imGKKKVEkmxEkwQNPnZ
	 d1ROlbta+oze44XdiqpZd1H05Sv2odUKD+HYK1KCRNlyW+LkYBGA6ukDM3IxoJP0PFGaG
	 kUZKZiYzz80Z+T2/79+AhYV+VsCw/rFJxA2x28M6MWekbvu47yPYhgyMNqqgTJQaj3hVg
	 qF3xaCb0f189ctQ1G0I/p/grpI6GXO+aNpXnA9Xoip4DcFOdQPVd35AWrnhbxeHdFZecx
	 jX0fFfI0wxs5gWTjYd8s8HvLvV21TVLR6PMPnQP9EMQo9GxEgC5JUaZV7aN1rfiLXRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182521;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hPd6WvMjSzEHlRopRvNO/y6gK1Fh8WAhVaASealGWkA=;
	b=Kb2AawPqahevMovj2TyZylXqBV3hT0UtagMs8scD3qjWX+PGuAD6VMYx9UqvPfBWbh06
	 n8cVBjGm5jiOaNASk89vF2Xy0KqdUDwW991nheX6ryBgM8QWWqknRkUxjpx7CcOtbTjR+
	 SGoflkCknXAGgCruoOpB7qxGIMLUKfCSz+bQPtyP8U723cjvSExKnUyLqC2vZxsz+64rp
	 iz9XGYmwtJ7DeNYdFUygU1sHXWkflcfO1TsgokBRNIsoWZkgtBtDOy/YnJsqt7c5qj63E
	 SjbLKK0S/Dt2Mc7H4o3RdXv50372Dvoh9REYlzYGsP3+p1K5UElvdP3OkBZjMTjYBJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gakyiKXl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C10606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gakyiKXl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F691F0089F;
	Mon,  9 Nov 2026 00:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794182520;
	bh=hPd6WvMjSzEHlRopRvNO/y6gK1Fh8WAhVaASealGWkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gakyiKXl47icipF8Jxy+zaPlt9/pEucaac0fIYurriViqyXmG+jxioqnWWsms6jmd
	 AoNydw0A/wh6A0d+BiUnIac8cqCU5b7s8zM7yXCDi5KzS5V1HQggdplxUkMBmtxBnY
	 TqjB1GKuIlUfbSjs1tPaCTfZBaXdOnfbyHvy8FNP2n1IKJZyIVPBFQum29fNnom3Ig
	 yWn8ZmOjWWZ5EdMjNityXc3yOXm+6xbuBMkPhACivNI2Skq7c1ilFd2kuEVUxbKeGC
	 u0IIe/D/Chyeqhig/CtzcoAPDVeVBiVOWhw+0Y6LkHh5fmXy8YxyhzBuOpC431HFJc
	 t17hMk+bnn/JA==
Message-ID: <sashiko-outbox-204183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-3-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:02:00 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring
> wrap when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM
> timer. The driver must release its pointer and trigger locks before
> calling it. Existing period notification callers keep their current
> behavior.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D2

