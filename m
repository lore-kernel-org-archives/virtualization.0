Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EA31D730
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000611; cv=none; b=DWZj70qWuH84+3ougauTwKnziXMqkWke4ZgtcX/v+c5T+xM2E6ujD+IFN9GM9YbGArxGa0Q+ylwo/sVy7EXR/I5BCyJfNSRaprY1DqaBgXs51wMjyfThsuyUzwPI/ewjy1OygUNIAhIshYyeu4Ud21yCNP1JDjuUm6opXXU4L9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000611; c=relaxed/simple;
	bh=Z8sFonwXy4T08ZmQ45esYoKIe511IgwqVhHXA812zck=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NlrZxJ9ULQFqKfCLCOsbkVGUMCTHLL7lCcU6lFqwPOGrKOfGxB5XfAfajlxp2YfEl5azhS+qEAdORJSgx5JiJnmHtpfjuhjk+NUvktmqRMsv3km6xe7gs2RRGHEhwYqRrwkPn6QhbbDgJshUmiLcYR0wR40jYJJzEl3O1pT7r64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR0hiP2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR0hiP2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7047B1F000C4;
	Wed, 14 Oct 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792000609;
	bh=Z8sFonwXy4T08ZmQ45esYoKIe511IgwqVhHXA812zck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aR0hiP2SgigFiEzgRZZqemMao5SMFG+bBbOMuk2TFC3ABmZl+suDCpuueG5D5C6wk
	 SH4oMGQWIvTJ5BfiCpotIC8lg8P4060G+QPIAmuisbZb6kopNmeEk2DpRH5VGnd2aY
	 Npyore5SWkjpehgXvmrjTvIHdPyhegdN6t0luCM/FijBHN+0zjoNt0G0HTdL4Hcv2j
	 44AVDcOiLO9kPGE+P0QPhlXDURuuRXICwEyt4QjedLjhG5zT3lceuEnWUS/qacLY5g
	 jpugk9J7K1xxZUApyoD/ChtZK7Drrw2ZKBJVr6m6VGD+dHipAIhmsIJzRIAE/Vh+iS
	 hKpE+MN9YlXLg==
Message-ID: <sashiko-outbox-171631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 43/75] drm/tiny: bochs: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-43-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-43-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:56:47 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The tiny: bochs connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D43

