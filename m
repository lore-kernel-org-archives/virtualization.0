Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADA3DDB09
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807068; cv=none; b=LgRDJV9VcxliIX7puG0l7jkKxuMCOeJ+yoeMAq45R/NAesi/5WCa+zlJUWcprOwypRQ6FPN2t/EQSvX4grKfPM3aOJJBlsyPml2IFN06gCnVJ2d5khS2QGkIGK3O6lneYxJJIi2i0UUqvH3iD3Eav2vz3LCIL1GqQdxRCnRCD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807068; c=relaxed/simple;
	bh=ZG8bC5kH+mnTwQmBknY7tt/+iynOnhcYvEELtpShYiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g58zwEcwSNlRIyZcVP9ssae6HoW84A9jkkSQ+LN9gF57HOqVqXEL0xdMnDQNGPQuAEHcmEGtkb7/fD+VbfvEp/gxr1/GnRN11Jgk4q/ZUcMkqGfbDK5KCVt7eyUzTCYw6v4R0z14FI3xCyb/xBVmhx6dF1Mxr2pMOI3Hc5BV3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECVXCgOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECVXCgOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2DD1F000FF;
	Wed, 30 Sep 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790807067;
	bh=ZG8bC5kH+mnTwQmBknY7tt/+iynOnhcYvEELtpShYiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECVXCgODznKyNrZs81iI6n7b5ZBGtlB9JwLTOUwer1Q2WhsmY3cK3XZmA48HJ/zQu
	 cGmgGkVD3BbKBnrKirn/V/9iOMaziSlx8ntJ/y/cR9aZ7iQTU3Zaxdu8yiXXBsfFxx
	 zsV56do8q1h5aOXrRUrab2EJ/mLhdBz2yZt8xofUGE7R+R06bY1N98fQqG8ADxEbN1
	 V/qvZ3W6tO98WqVX+c8BdvIw+dr8zp+XGDm2omuG8rMzpPyBvHbZvqTM+Vt4JFiqw5
	 94rnSouO5pT8CmymX8B3C57xOowCweAGEfQWHyekr0G9feTct3hWx1Vhs7aXJWMKVg
	 VHsxVh1BU0S4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: return -ENODEV for unsupported revisions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matheus Alves de Almeida" <matheus.aalmeida@inf.ufrgs.br>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260930222214.69443-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260930222214.69443-1-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 22:24:26 +0000
Message-Id: <20260930222427.0E2DD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The qxl driver currently returns -EINVAL when the emulated qxl revision
> is too old. This is not a driver initialization failure but rather a
> match rejection, which should return -ENODEV.
>=20
> Change the value returned when the qxl revision is below 4 to -ENODEV.
> Switch the xf86-video-qxl suggestion log to be info level, as this is
> not an error.
>=20
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930222214.6944=
3-1-matheus.aalmeida@inf.ufrgs.br?part=3D1

