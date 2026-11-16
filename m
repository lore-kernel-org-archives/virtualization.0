Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826552;
	b=VO0h93zWlggW6T2Gv1ANiM52wutEXiGguGGdGp3jz/4aGkpzr5dx9Ng4RCFMpjKFt6wR
	 mJKVa5Q5bSaaxQsz7VYeIkMh+I5NFvboiLni+Y8WWEloFFztYfxGIr76aHm2WJBwxTbtJ
	 aEbicpjQyeaU+JnK2M2ysDt0RPlo5Gfx5sF526hyu7Xp2Ie8eCyBR8gYcidPIsr7VSp+S
	 2D/6RGbJko+nON7Gq+EYuKdcjRXBWejkX8ceuSie/Wn7qSbWFTm6wcOd4S+DTc7IWtfzR
	 WgpORkuD6kcPhetHPpEDsoTf8Yrioi/8LMfpxjRsQnRXrvTbhA+mK2+REf9M8frXQ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VBdWEB/rKY9T92op2UJdXKC5ZlJU/j9wBD/Mn/uOv4Q=;
	b=HoGfrIijpshgaXQd211XEC+Rg7AsaXB3KI3ZU20HmhvYCZhC8bCUh53aX5IkQyWFvj/A
	 JwBKotMnsGHmgrEz8ocvbOgdRoBNOiUqBtgOIb2mWQunB5KaWR0mbsk4TxChJgGEFaJ7L
	 HK4X4p1w8EbJFGiM/tKDbsWth8NyFTvv6nei4AjTCgr8igJOu3toZFmgArtbpmemJU0h5
	 c6NIXoE1D0/tbpSsaZGy6mbL5fyb3HiH5gxSl19MDZOMlEdrq5Bhr900EbleWi26uPbZq
	 FO+SLNxyiOkzhmJEtU2bDkhGtJadT0f6wE3fl1m64SJZ4EKTNTULHxtMzpFmv3IXAjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9BON94x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280BD606A333
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9BON94x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E281F000C9;
	Mon, 16 Nov 2026 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826552;
	bh=VBdWEB/rKY9T92op2UJdXKC5ZlJU/j9wBD/Mn/uOv4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9BON94xMONfMsQZkRylnzEe+4NlKH3uMosQjgnrEAsaXbnYnY5myxCA84g845vSw
	 fOOxnNv0qmcvyCzuRlSuyDf63Gks+m/qONnIC/JaIYS/NFcUO2ENnsVq4j/mFp861w
	 1CB7dZJQZ5dF8keSp+E15jfCmtBVICzJZ7XxPMq4lbDN57O9XAQhlx5iOjp5CSOTyM
	 kT6F1GG7235DBCWzmzHXJxpmjjVjSjWCbgn/0S94vqNC5UwJBO4sOkWcofK+CpYRBA
	 JsHZM/HO1ImlY6snQpuZyacU9PRd2iW0ZYXHXSrgg7hWAEuQun7rQJeucK8lw6fUML
	 oDOa22qY6HmRQ==
Message-ID: <sashiko-outbox-216800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 45/64] drm/bochs: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-45-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-45-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:55:51 +0000
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
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D45

