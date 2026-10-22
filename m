Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673028;
	b=KdzxEThDbUNJpljJcno2BA8oF6naf31OGcaUSDcw7Y+U0+fguC17LZjnUp5UP49MZEXp
	 FpEzgRXwDHdViUB17wgIeqqwehfyxGuflMD/doXqZjpjkC5vw5XDRoOj8pEqXpB1B3iq/
	 NgFACl6Qy+Mq71jwcP5qgLAKkX6M/XEZ/Nq4qZs7Bx64LJdqMeQtVU1dRr1sD3dEDmfSG
	 ILIQ3ZMqPtI12jZPNj4SK8gDtQcIJmrc9ZuMGV0rze32DSetQCj5As3Q7zAtPCKT/ZM08
	 UNojQ0Lgwqc4XBp6aKoHRwIizlauWdNEHcvDcICIfOgQr6GX+qV443HEi2o/oN7Jtjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673028;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xRKE3FB4KmO9MSUmdcA/9U5hQPUY0UvGz8Pg1zWH0YA=;
	b=fbV1Z8FVAI/gDRBaspZVQcLS9er0eLpEC/jVnLkv4VRs77Yvri+ppSKwClLKeSjINtXk
	 vGEEjkIx0s0FrSNdgzA6QiPDQMFN5ZKZ6rDB0Trt3/CO283JZo/VTqDnH86F6mgPSdV9T
	 HsRfPmgUhc0ZKzbPY/M013ZkCD0Ynz3nNPQIl1DChGWBwH27cZ2+iuyiasPFrV7Vf8684
	 1Xui1Je57KU5d5EmiyuGs/LtnEMWsBbch+BE52lo+06dlWXfzuyi//AWyXpoS9o5ekSkU
	 jmvOXI6/6sdQwDwCcTd25ShPFjMqvUS4OcluboEC47XcaczvUxKljye2/lyG8hL/gzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZ+lbfdY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA6606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZ+lbfdY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF5E1F000C1;
	Thu, 22 Oct 2026 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673028;
	bh=xRKE3FB4KmO9MSUmdcA/9U5hQPUY0UvGz8Pg1zWH0YA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZ+lbfdY7LXHJSLjh1xvQO7fNsirvYAS6t8+TBVRonHSJU+PB+aqUPl9xNLSNXHW8
	 nhz1bg/BKYcNHS8fk5TRPkws7yQ9SwjzQC+Q6KrrPDzhbVyt6oQPUhYoZNsrR0thaP
	 8G/kiQdyYw6Pu74UhErKO5jdI51FUcL9ebzDywPzkrlJK8WyEMBuUDYFPPIqmBl5EI
	 894A8JUi0ZITdvf6wtQ4+3CXxvPl0HxZbd+UhahBx52aK5SDQmn/Ti84FirrSuDZWG
	 5tnXD2QxgqtkTl43yWF8Da19Mk0jBbE+Wa6Kv39Jp+iqjr6q9jueMH02RjmZ9fJqd+
	 O+MJUaE8QTpVQ==
Message-ID: <sashiko-outbox-181483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 34/59] drm/tiny: cirrus: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-34-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-34-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:43:47 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The tiny: cirrus connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D34

