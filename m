Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266D4078ED;
	Tue, 15 Sep 2026 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442757; cv=none; b=ur5F6lWtEDGPNHviN/iv0zt0mo85ts09AclFAnW7KmxXHxpY4Z+RnEKJPsBZU94S6djilSQdn96bBFaExZmP45+wKoJzA0f8PAW3As5YhPpTtVTGHp5gLbQ2SagMmnIxIOwVhNM3734BsvFola1xwgji+E1vvivTT7YB2PLenxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442757; c=relaxed/simple;
	bh=vFqFv4twydPElGBufIcblk08lU5Lzs1v/ujE35fD+FY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ru06+iHXV46uIJITtCygQBwEIctPfLYUm6/7RlYG8aD7OC5KmDGzqLpl/yNubQ3grVoqvhxfV71OU3LGUAh5E12nRaKkDXTKtypChmYc98sywcJGFFBR1zzu/Ud9xxh5ydxWErD5sl4Apxtnuo3J90hXAenSuU4AxvmaioU6Jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kct2VZXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kct2VZXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299101F00898;
	Tue, 15 Sep 2026 03:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442756;
	bh=vFqFv4twydPElGBufIcblk08lU5Lzs1v/ujE35fD+FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kct2VZXlb5ATLjqDHgJTQ1NSG40E/rAfRN4FlJ9II4l+5pAJ/ol4pshyRPXy93QaG
	 3NTrSOY2oYCc8FQQR8kZ+P1Xmyeu9iU7XtLGMeVy6h8SmxeFluDjSyh0F2a3eXQACO
	 oXclhq7gb20hF9BtQyqevuzkSE38xlkpxbzUeYIwCME2zGJEq66GKXWj1GdOrFINCY
	 lcth2bn1Bh2baR8E7By60MAVJK0IONaGBFqx2pcesZX3lfuUU5oGV7HTMl2ZfU2DLN
	 o6Gm0lKXmzbHzI5unqHCJXKTei+WBInTSRufVnT7+qZo+QXzaZtR9odPna0InbcbUA
	 BENhHYMlw1MRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/17] klist: assert static storage for DEFINE_KLIST()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, virtualization@lists.linux.dev
In-Reply-To: <20260915031334.1194975-5-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:55 +0000
Message-Id: <20260915032556.299101F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_KLIST() statically initializes k_lock, relying on the object
> address as a persistent lockdep class key. An automatic local klist must
> instead use klist_init().
>=20
> Add ASSERT_STATIC_STORAGE() to enforce this requirement at compile time.
> Keep KLIST_INIT() available for embedded objects.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D10

