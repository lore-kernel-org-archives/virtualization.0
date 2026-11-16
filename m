Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826878;
	b=FDL295/x+d7JQjzRTbibVUKf3mHAhY+DxZWHJJ+dJRVJCQth5ixbFOJy2u9OhUelKbHf
	 WAOGk7lGmY2e9ejmKDi3eOo443vCruDJkM82ixcyuNCavbO7u4XY6mFaqBFwF9VGN2yPm
	 9efaGdJTNvlP37/xlb6krs6YVgl8x+IWq9WdAIBmiKvLBI5lWJHykalyxU9ubJUabdH/q
	 yHTD7VLlEYVx4d4Zbfv9oNl9hYMOy7uLO96zttGVQH0OTT0osjG9DpSKiuuwuwlAiwEZr
	 A9zEJRTSqreXdepMqnAAMpsZZoYpYyeiFHh/msEBVT2T2HZ0Myart3rr0luP3LaZ3rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MWvNMGMepE2a5VecMutgtg6opi+/nzRLHsC4sDjZFG0=;
	b=33m52VaMyS3Us0T5LRNl+XZfokXKzSGohGoHlGsAGtdyW0WkTLJEwZqvpQZnxTiq6QIp
	 nBygsCQJpE+qcoLCKWtSg/c8VBUezEPPM4ig3ugrK6mcOOYli4iYFYpmUp+LFHn/z2FYE
	 DYbXY02NPOBAPb6u4+ofdVcy8PLfoziFwJgytw8blnGpVCpjPqdEPV6HuwKAWn0zLGy9/
	 /FLs+7nDeZZSgTs3jemDdNCJ7pfgvKPPEZ3GuHHHZDs4C3FSF/kaLWkbXnYa2r0G8cfga
	 58lxEpiH974sfk8v7WqhaL4rxxWDk2m+CDqdYsHigfn05oMe9X3QN1zdJZj6XDnkSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVEF1vl6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC851606A329
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVEF1vl6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7CB1F000CA;
	Mon, 16 Nov 2026 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826878;
	bh=MWvNMGMepE2a5VecMutgtg6opi+/nzRLHsC4sDjZFG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVEF1vl6bzueV4Ocu7Ol2foU3bXaVNqeDjnhOnD34ZU6p7b30tjirBWjHydnqlr7w
	 YU8wgSa4yTJt7jn/JGEgCGIPqSsD9EmQYI4A7Cd/i9UFfexoHp8Nc7xh9dpBDbSGLY
	 aTYtabGpe7hD/6+VcVhcc/CdfDO8JcfRGJLwOcKwWYKeweak56gXvnv5sNvU6jqI0y
	 8OwcmhZJJ7U7iJfw2F/bapoBiNiM4Xg84/W8grKQhAaJIfqgWlh8oT41rntfwTr8sJ
	 riqhK4IvK8YI9slQxaAeYO1YyUwO09juJCcWCbrGYTWSAicftgPnQuDN7OPkF3c1cF
	 QKiWbBAAMcUvQ==
Message-ID: <sashiko-outbox-216823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 61/64] drm/virtio: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-61-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-61-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:01:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-no-mor=
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D61

