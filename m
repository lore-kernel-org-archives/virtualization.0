Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE8372071
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440716; cv=none; b=VOdSaGVkwYde6Tp+Lgt2PhI2py1oCUaU3hH6oM8K9WgzJFFGaCOrSLSFyIH1fazzAgGohm46jTQ03OsdrNUjXyx0Q74Uoia/llCRji0/Af3sCApwyK3Umx79Dl7yRsZGF/IPiztvCXm0mOQjN/11WZZGIQbxnBGR2MpmrjAWmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440716; c=relaxed/simple;
	bh=UKd5EJx9RhEc5mhWrlxsoYjk314pmwYozNNFOokkaP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TArH12+sN4yo0NtdmI9J5x4BkRUrM6mIay3Ukfnl3IJvG9OvdbsBBDVGaKCb4IiKwHQQjI7vXhN0mMwQueZg5nUK9N+QEE/TILGq+/w8xvNOd2HwmZ/3hqcflwBjMZULPEJsUY6Zgu80XbNR+d3Znnqurb9j4o/JjdySUW5yedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjNLZRf+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjNLZRf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AF71F000FF;
	Sat, 26 Sep 2026 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440715;
	bh=UKd5EJx9RhEc5mhWrlxsoYjk314pmwYozNNFOokkaP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjNLZRf+FOmpyjTGfFOQHqhxXrPreLJjZzuvfTT7Y6UIQzfVZlYSuFiQ9ftOrBk+K
	 mEONsPGShW4MjOmLdYqDzRTuYoQ22W3i3mEgCB48E0tdkXraRlx7uIE94ho9mTVICy
	 yIlL1wF4sR14BAT/jQ5bdwdkFN8abtCyzbMVoVatYaKQPPx13v4xAQYF98bdf5g7CR
	 Nootl2zqSIs5DBFwDhwKTiyIOWcVkURfGvtwvkclqKhXn97toh7Ps0Jo7+crA62cWH
	 N/fL188vG2V3uVLrfFWQzU0X1R1AhRnda3rRFisQ2PsTWg5HLjc974rm0TGyd1m+Nz
	 mJrb6MMTVa8zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] drm/qxl: unpin the framebuffer when plane
 preparation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
In-Reply-To: <20260926163123.39217-2-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-2-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:38:34 +0000
Message-Id: <20260926163834.B1AF71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> qxl_plane_prepare_fb() pins the framebuffer before preparing its GEM
> fences. If GEM preparation fails, the atomic helper cleans up only the
> previously prepared planes, leaving this framebuffer pinned.
>=20
> Unpin this plane's framebuffer before returning the preparation error.
>=20
> Fixes: 6071c4c2a319 ("drm/qxl: add drm_gem_plane_helper_prepare_fb")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D1

