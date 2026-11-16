Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826352;
	b=IC0RPQ60ighXHt5LMtkPdJIlXJ05QzER8SECZorGhwIFfQsct7AoQqa26wpsRdKj1xSa
	 IRDpFupXioFPAV9D9VD8pPbYRw98xJXGpCFwVedCnBJeIt3GxxctZomyTcyptAfRfltFD
	 kk3XEdYRQAQJ9xG+IBqJCLP4UCRPiVffI5lomqKtUZ0JppbBKK1YbjBaqSqjILUF7Kc5f
	 nyJ2lzcRjwkWfw4QwCUNqcCrH7OkxIe5zCBoYE2G4KbvKD8ErpJsO49xuv3nZJZzOsjng
	 FwMxVeYiAAanWzgP/QDk1cqOaMaAia9xt19EjVeCCipZEEXgrFLJ+74gu19IjT6J5nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0U5S7HYQyT7NzJucTJ1huyg+TfP6GaBdkKBQXfJ96pc=;
	b=AgHLRuAb5MqKYW8Xe81CZiis/YKKSC7PAI7VgZQ8l1FU77J86/75uTGR0kXPP2pTj8Yh
	 V6t4KwaYT/YXRhsbZ8BN5TwNNASOnjQb4lWotMzJx0GXVM5BcgP/Inu013bzdi68+E7RK
	 uBH533jmPV96Bw5xjjWCnC96hBr6lb22HdgUXDqMC2gVUh98LKqrXKgWjd1PU0fcA8BO3
	 pr7GY82ww9N2ykMZsSIIqLiM/ZAAfgunKKsKD27UN6i1MJ6EGDJtiAdsdqClYzWmZjK15
	 Az1XGO2vFpQLzHC7XsJFlerNcxwO/FrTrmsrIeOdPTjRoy5hebib8Mnzuuvpd9GgTEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lb0ftr55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D1606A31C
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lb0ftr55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F11F000C4;
	Mon, 16 Nov 2026 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826351;
	bh=0U5S7HYQyT7NzJucTJ1huyg+TfP6GaBdkKBQXfJ96pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lb0ftr55+imBGwCKD4eUhiLdAsbMkQREizC+5cw3ZoE6cowAUlB9zvkoFyM0EyGMC
	 T9qBglftrszCuOzzKaNtSb92TyeDfjIOgwNw3rQWNji+3sZ+yMVFCO/+iVSnGe1ddq
	 crBNmUhynXpjNRut99wHUTMXf6IttfouxUTFlgc0TUFTltwD2hfrXt5IlMoueON5EW
	 xNiUQ6IpjA3Fd+8PXfz85B5ScYwgxDjD909WLbbxH+6T9p0j1uhI/t3+o8xYuBcFpu
	 hIO0VRYVUa28BLE87fZOdqZjD5dsg2a5DPeQqasO5lVe/GlMjH+MaVnfRzI4M+U52V
	 Hknd63s1UgIkw==
Message-ID: <sashiko-outbox-216787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/64] drm/qxl: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-24-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-24-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:52:31 +0000
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
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D24

