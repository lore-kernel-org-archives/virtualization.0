Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1174481A91
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792323110; cv=none; b=onfft+wfh6x++Neh3tox78YfaPDYa2NddcfS6faUfvMgGliUDpW9q/VTUNobPZpWuoV5MAqZ4t3gNklCMcu1KL78yb0cLsVVzaJ7LSQnOwMJ/l01u3oursUB5cZnmAHoHmsVtUbPHZx162q3dUpF8rRipYYTN9eM3sZRAn6giSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792323110; c=relaxed/simple;
	bh=OuBnvuol1W70cS77NGkbtzwjSP4+Q5XdkRIfKqdEONI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RkJXfT8iodzJ0tYKAwzJdlkiUkS/ISudIX8mJSs4n4l5Nd8B+jk0VGFMVx2zjUp2G0xtUtppVDBWn5d2UtN8Cp0WAPX06U7UAtKIGkx4rSYTYGpoSt6iusfsy+elXqJCMx6Sdc6DNM4GBy6xfdK5AEFyouaJPsl3/I1dtd8tfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxXAozwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxXAozwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C5B1F000C4;
	Sun, 18 Oct 2026 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792323109;
	bh=OuBnvuol1W70cS77NGkbtzwjSP4+Q5XdkRIfKqdEONI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxXAozwyjotP+vLeoCsdhCI4V0yyE/jkOcg08iokjR4GHvxWigE3q8ExCKUM0b+NG
	 v58rtNJYxFLj344K1S3KgTukSf5Nze74GO5A+LrJ6KkBhWZCTsEvhM/1JCVZHIQbmt
	 KYEGTltxya7air832D0H8S2Fft7uFZy1wWRs63nkQRip8893oCX1pFVbbR+IHWsZxv
	 JgDvh+t7nmJCXB//Jm9srOcKco33QNo9SX5a/XFNNLwj6dPYqjX+ir66QhHCTl3+kn
	 GT2EZHKnUaOttgEXZhMgPKm/O93mn6dFvMn2SWumGdnADUlhDwtIaSiTStlIqzPEbq
	 XhppMmDroeRTw==
Message-ID: <sashiko-outbox-176081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: inline drm_simple_encoder_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Melih Emik" <melihemik@noirlang.tr>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261018112844.360262-1-melihemik@noirlang.tr>
References: <20261018112844.360262-1-melihemik@noirlang.tr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 11:31:48 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The helper drm_simple_encoder_init() is deprecated because it adds an
> unnecessary intermediate layer between atomic modesetting and DRM drivers,
> as documented in Documentation/gpu/todo.rst.
>=20
> Inline the functionality by calling drm_encoder_init() directly with a
> local instance of struct drm_encoder_funcs. This allows removing the
> dependency on <drm/drm_simple_kms_helper.h> in favor of
> <drm/drm_encoder.h>.
>=20
> Signed-off-by: Melih Emik <melihemik@noirlang.tr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018112844.3602=
62-1-melihemik@noirlang.tr?part=3D1

