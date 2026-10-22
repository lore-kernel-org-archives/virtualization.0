Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672947;
	b=d7kk4lo+eBg/isTSMnWLRxqQPlt4Ij/NEZT6mtNCrNOdbJQzj1JBu8pmk8mC8T4Tl4xu
	 IR5MrH9luuBxqtHJvOGQQOAv7CaI8GgxZO91qEGDPVDonBf2/pYNBUhV2d9p65jyTtoui
	 LOK/aQf/5mkZIcqsG8pe6H3hZQ6G5XHN2uFMIp5yp6b2K2cVDJbncAmUbPC/WCQ6u4vD/
	 bBIUWd8jI/v6x8TeYCW4k2zUf/0pqJoesNe+ZvfS82i140K5fghaAfuTujhz+nqXz5J4h
	 Gmqbb1J3TizkgkJqFjC+k1JyYvxgQT6mkj5qY5u4zX/c2bGqJ/lVfbJni8M+7mjULRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672947;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OArmbIlI4s1fJafCRhLflrC0Ys/71Xni9vcyPFvqIJs=;
	b=z2wP9XzWPF5cugj1cfb97Hsuxq6YS+KvG7+xLav0PtYQtIVb311nmkW5TbAg0FKGYyIG
	 g4f9YclgU7LlcdVsSu0lKIvXzpv9Gj4Pi6Z9NTqFd7jH7M1A32spBFL1yZyTjNeyDBrXU
	 jfaWa0vFuUvsPU1rB0CNiIScXjuFdLCvlLrp8UIkIwnHV1SFc+bOXzSy1MnDsvHOX+WK0
	 /LvYgKnQc73AvT7PWFUe4AcOQM94AZLLUN+U1SSvngbUgcLH8G0fI0CJB4JRn8K5shL8I
	 JYXX4X71PyNMB5FNzLIIDvZac7MbitX90hPlPYTK1b1lNc6Io1s805AwkqkP0FXe+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ay/rOmpN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD87606A31B
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay/rOmpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176511F000C1;
	Thu, 22 Oct 2026 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672947;
	bh=OArmbIlI4s1fJafCRhLflrC0Ys/71Xni9vcyPFvqIJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ay/rOmpNreJCw8RkMpyQQKFUsMT+b7x7qUGv3VNqU0j3gvRlly83nwEPiOQFPs0l3
	 Rcie+oS8GKe1JQ5EV21OPtJvTDQ0YzhHJZttu93un5Py/t0gQ6WVr3MnDLLdBWi+01
	 SAj17Bf8zvG2JQ6n1JsyuRmFQAaRB8NSVlzobIUhm/Q5DjLMTJ11I2jdLgvbPVbTVz
	 eEkUQ2kH4ipO/k7G36Pam0NWm2fXJN/0zCePynhesey1ZiTT0uTsFQWNBLwSLU3+vj
	 YABJ0v8l64ch7zqNEwq91WSh3HSWBBa2EGyVABlxJH0XmwOkvQgBJNunFUx6kSppbW
	 ZrDbBMMfhQwNA==
Message-ID: <sashiko-outbox-181467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/59] drm/qxl: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-24-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-24-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:42:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The qxl connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D24

