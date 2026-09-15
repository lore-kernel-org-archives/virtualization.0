Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3E40681E;
	Tue, 15 Sep 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442769; cv=none; b=CuORXEcfI6q1N4D2UORD35yjej2AlVh5fepveFBhmNmWbXwnzzrGP2/Rx2S/VZdrx/sbw8JUxC1kXEUXWauf8tB7J/ElMUZc2ja4ElvwuWPiH3ilfd5DFn5L2EieQche1Y3Yu9L1ELHp4N929zbPbdgBSToMs6PTu8g/iWTAnnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442769; c=relaxed/simple;
	bh=FKRHlunTHjoXiepxJeN6gSinZZeNyzckmSG51HIfGmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hEgyNOPnFradLfD+3Q+ePkyQlMwuo/A5Yl0ZOsqOrHwp43RlQdQu2DWiCPYMgw4leowQYd/wvQss4hafRyvxjjARBQ+gTvALe1KBl4UvRtmcjSaYAtiH3CzHCf+xH4xAgHrH2cgqAIV6+a36nZz0BDci5ZnSt/Z0FHPe2mNq5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLPPU34G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLPPU34G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5761F0089C;
	Tue, 15 Sep 2026 03:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442762;
	bh=FKRHlunTHjoXiepxJeN6gSinZZeNyzckmSG51HIfGmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLPPU34G/Y1ATM5tzmL9KSax7/KP3IPVzc7moT1wr1r2k9vvhPz7IamvkfImij8ZU
	 7lmuPOwaDqU0KwcNj810GUCUER2uDtGB1UHGVLJwR06MYpMOuznno0LNjRv3Dsi8qv
	 XwLn9JeHu6oKzQTX6QFqGh0C58v87BCwhp8x3WHcFU6aVYtWkWBf6u4Yu/y9ea4Gb6
	 PRvJ5FEDkL0FUirwtTHFDfFf/gXY1Q9YKIbdvQIkClRqb0nVUJJZmDc6uiwTctXVw1
	 nifwH78shkQR8NBIUOOa6cLWyjJFNCujU6CnTR0IV6tm8xUcFlIwQLZg14U0WJuv9W
	 HcfeqNX/SWDog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/17] locking/semaphore: assert static storage for
 DEFINE_SEMAPHORE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260915030336.1192299-5-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915030336.1192299-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:02 +0000
Message-Id: <20260915032602.7C5761F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_SEMAPHORE() statically initializes its embedded raw spinlock.
> Using it for an automatic local semaphore leaves lockdep without a
> persistent class key.
>=20
> Reject this use with ASSERT_STATIC_STORAGE(). Automatic semaphores must
> use sema_init(), which supplies a static class key. Preserve the underlyi=
ng
> initializer used by sema_init() and by embedded objects.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D4

