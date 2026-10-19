Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426048;
	b=zoGUpSoFWz7vGhVWWrJq7TyiWOrpwlhEqmZV0taarTN7PeQHWGXkeKiWvGoUlT2fbzMm
	 lkhoa6NxZthhu0i25vmhu8Q8VlE0fLlA7G2yhYrCbhvz8SnlyNxqqMAyPlIscgGqSzvyY
	 bHWhePQ9BxpZU9blV0rLe0xS6ZyLtvfS77q9t1vbtiM9RysK6gyAfuOkP5JIqQCtQIduv
	 r1ioOcsvxm1LQY1GXdG2tFVTzGl5Yge8hWCNtEbcTXkFQc7FGs7woZCmWN/2k7HGCa/ff
	 jO5kRORdiR9VvT6HMTk1oO7ayTY9Kx8FGfYQ4vsDN7PQftS4JDSs0l2qryntM3rC5Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ryEx9gSfQbaA+k654eOX3nHYjYvo/h0lxiDtSNicm8A=;
	b=HINkUXSXAfOnpIN0Kapk247go95FHn9kzhWi2sWmNb8nktFD4f5GBzwIdW7cW4K2K3BO
	 X1OQhYK0MSREBply0u5T+yf75Ia67XCmnuVGqYLvd6EdDIVOyRo4thXEh/HXtgC4Py5qZ
	 okZAwE/fsXZje3LEd4XdLOIG5TruMJLnd7+RYwoIgpQRu4W3HjE3KfJUE62ET2G1LkrAV
	 T3j1mYZVWTfZTDRBAdFnuY8stmatu3YqpxjIZPimOsm7BZh2oq+a7uTEedYKu2caLkstw
	 PZg42DVUWEj2r6SOwMjd5ZaB10bo2S5WDoVdhKsHua1X4f7TtJ16n+Gt4WcVN8kXXxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5lr9eg6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCAB606C935
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5lr9eg6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94631F000C6;
	Mon, 19 Oct 2026 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426048;
	bh=ryEx9gSfQbaA+k654eOX3nHYjYvo/h0lxiDtSNicm8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5lr9eg6IlFJwUFloeotgbqS2Pto6Kr6zqiECMHEa9DaRhIkPQ0Abk5no5HjhjHWh
	 hMdtYWuAR6Zw9rggwqU9zzFJJVgh8nJRZjFBr3c6qFnHybAI0XGwwpkBvUpHv2lPUP
	 Ru3PJPjN3BF2JlEzuMx/cYsNuOBUWubmasd9+N0HZyXBeBEBGmRXmvJqQgfECA8yy1
	 AUPxtE657nD/VQSwCcRCB+rlHXBz5h/YevPymwPijbZOIM3aMsEJDHUZ6keJo1NooE
	 JDw2rCI2XUSn8cn3mgzrfHwhVqqr330JM2lzsqEeU5DQquUODk9PxfDN0cBAnNEpDV
	 voJHB1bWr+zCg==
Message-ID: <sashiko-outbox-177805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm: Add helper module for working with pixel data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019154612.777074-2-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
 <20261019154612.777074-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:07:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add drm_pixel_helper.ko. This module will contain helpers that copy
> and process pixel data, such as framebuffers. Drivers that want to
> use the helpers should select DRM_PIXEL_HELPER.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019154612.7770=
74-1-tzimmermann@suse.de?part=3D1

