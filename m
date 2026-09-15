Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7A40802F;
	Tue, 15 Sep 2026 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442771; cv=none; b=GIva1Eg5pxvDmeZ/gsxFd5uTRU4P+d7Dyh6kpRhYSQKfts6tIFvv35hBysHOJSjRgw0BdWYFbPaHe/kjTpyxeAR1yZ6Pr2rXNp2Wqiz7g9Z/ZLJY/tNjl0U690hM+HZ7gGwuXgqyIEPbEuajGwFT37tzlZCzy4YR3ZZRS9n1so0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442771; c=relaxed/simple;
	bh=/fmdiimriYiJUuAsrtFECO434CstEhP8JLQH9A3VZck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBGYt5hlHknF4+QJIJggdfbWlVCaHbPaLn7vHNetMYpdXoP/hKtlsk6ugs/BJ5VgRYd42tUHUV/v9l62w1aBxco4E+Oyp9DWmGnIWxwRsZyatLPuOV16oyGGUUoy2okPSmiHlT5d/tI0gimKoOzgZsNtm7gJQHzenkVe4Ebj+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av7kjRuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av7kjRuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB881F008A0;
	Tue, 15 Sep 2026 03:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442766;
	bh=/fmdiimriYiJUuAsrtFECO434CstEhP8JLQH9A3VZck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Av7kjRufsggVudr+71MAZZ8myv2HDvbcuMT0tzC6UcCAANnaoqOtkj/VwrMAV25Tv
	 Ez5zbuXg4eBnq4EgJtGBaC7wkXbIc1VJ41clM3GZax/Nclj+o2PkWrYVeRv/Xb5Tv/
	 pSIheOVdn7Meoz1YscIwHMI3dW0+X2F00wHDZBAPYL/NVkl2M8kXuMfH16XCygrWfI
	 HqYQZWbtFg1GVunzhZ2b/6n0b3tGwUNYZnl8NrXHzpXu0b8J/7aCJovx1gwegB3cem
	 Jm+B/k170WsoqFIL1D331KitUj/v9OIRlDAfRND6TimufZYOe2Z1+5qinCM/bxX60c
	 q2/IZ+4Yu+RcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/17] notifier: assert static storage for locking
 notifier heads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-rt-devel@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20260915031334.1194975-10-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-10-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:05 +0000
Message-Id: <20260915032606.0AB881F008A0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Atomic, blocking and SRCU notifier head declarations statically initialize
> locks or SRCU state that require persistent lockdep class keys.
>=20
> Apply ASSERT_STATIC_STORAGE() to ATOMIC_NOTIFIER_HEAD(),
> BLOCKING_NOTIFIER_HEAD() and the common _SRCU_NOTIFIER_HEAD() wrapper,
> including both Tree SRCU and Tiny SRCU variants. Leave RAW_NOTIFIER_HEAD()
> unchanged because it has no such initialization requirement.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D15

