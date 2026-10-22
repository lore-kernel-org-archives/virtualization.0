Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672942;
	b=mrfpak/lDzz6+1Hq7NqbOPyL7uQQFD1hNJy8sD2tdWOQRapVYq627TWDYaXj0KMUrSLN
	 47o1ODKZmEb94gvONDhNeIbrnhR10FykFuahY4T/17MdSkWYtvtnE8qnbHdx1VejXtylU
	 qHW/eWqXXhIVPuvvPkAKEw0quEoJ4SkW8+mDD8BbLoDGlxR+68t6rtI6jPh9bWxfKmm6B
	 Rar17Xh57SzMx7/1ETKM705A9MFxLJCWil72462ufw0Qxs1AW8KEZnktqUjQ/6e2JRjr9
	 STxlsgBoqlTSbe6AREpde7GS0JjMndeXJTUoNjumW8MMCdhTmhNrvd7J58VdyoBlHhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v3mEgYLb/EiT5gE2Rf8Qi70ORPvgAz+fr8AH2o/fTdQ=;
	b=pGBO/36Q+/7avqQGkTWZ2d+LiUAtgNhGqVb1Ln37BXsnTmPoueMkdRG9M9mppzzhCx74
	 KqrUd0Vw1rqZ7JzmpFID/SiW1ELsESYoN7K+WngWG2xgK4Vld1q2/5QW3ZgOaY4BsZlrJ
	 LNI9s01i+wP0z+kzNpZTY2X4rWVt6uDObgLpc3quv56fvjpny9RunJkvJ2mNAvzfTB7kE
	 FfS+iFnfj18J1dpNh2yDAav5NumK1njtQHqB5pcs+qvGeXxwb5cfyIiDLCtW9RkGbFneB
	 AyCivg//SGn+Mydr4g/D992XHLal1VEQlBukVqfakHsHq6YdL2EEK+MtA9s+Dkgr/+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnTbZpAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D4606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnTbZpAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E571F000C1;
	Thu, 22 Oct 2026 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672941;
	bh=v3mEgYLb/EiT5gE2Rf8Qi70ORPvgAz+fr8AH2o/fTdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnTbZpAA6nOnIb8S05S2448rw6TwbEdJl34P20QlMJzqEcwlIGxtn5FLNimvBThcA
	 rFVhd+HY2yB/FoXwS5k6Ww9t/9fE4r4WsEjceNL7ne0Z/5VVnsFGBjSVBRiQ0A4Wso
	 ZM1+Ao0XexO+EnqLgy3gJ+SsaUGRFfh0fPY9PVwZCe+oxWdeGrTIj2xLGvSg6n1uLc
	 lrqq5frtRGQkz1KpEoGHQXvReFzGc5MbTEkNeNQI21zcrEDrRKJQGUDHNgJtDveovy
	 tNKzBK1Ng6lFSMi1Y7bNQ5Kwe8ofAcfjxZVBlkiwJIiUufpoqLA4Urb14AqcMRTFQ2
	 eVuhc2HSpLodA==
Message-ID: <sashiko-outbox-181466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 33/59] drm/tiny: bochs: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-33-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-33-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:42:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The tiny: bochs connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D33

