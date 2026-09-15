Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98C406805;
	Tue, 15 Sep 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442769; cv=none; b=ZHW4/42U/KkfbI9oY97IMZILsr/ss2LMDZ2TUS823cuaYv6HNaMQxFbyEbm3Q/XRPgtiRLXRqrtSDqCeS0+vbbKGsglhk8HS49ZO8/STK6pG5x0kmL233/BHrwExRkCgwTY92DDrD2XEs0C95Mn7fHSwJ/jdGGo/njmEMhcpmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442769; c=relaxed/simple;
	bh=a1nF96H/xBMJdmnYTk9q3HNa3u6e3BZckgqsUwxB+f4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d4T1BkmF1ud98wCBWqCQYo+DT2xJi6k7l0wBytyuFxGYcNShhtgBDFu2RCpU3J5KdwJHILFMEIwPSDAWnx/kFr7vP+SZBSzxel2j746qhKrb73DGt+uhi43nkaG73Km96enzNcwqeyI4JxA4GYDK6fGj5RxmJy/OBxrE8hVg50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh3c/THl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh3c/THl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6881E1F00898;
	Tue, 15 Sep 2026 03:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442761;
	bh=a1nF96H/xBMJdmnYTk9q3HNa3u6e3BZckgqsUwxB+f4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lh3c/THlrrb0eY4TTVZYClyrq/XNUtPP2Q1ILg2S2GJNJNvFoQFOYv6CyrBvcSKMe
	 gyMNV9yzsJJDPp1DDTvTiIbFXrXm2PBggZNlD1LwVKFuJcsR3bEc5sPQsTOYOhUjcK
	 XvoWfhLNId7Unh22JdKjuR7iOYw8L+4t1PhyeB0bxW5WA5lFKiw6FHlYYM+FiPR1MV
	 P1E13PjALObbPXGACzWpCFmkmY7feePRSLNpQ5URfhzP44cpczVOLJtL4Ib1GbDeDt
	 byJGPgEl8nihSGa+cJOGHlYGWtG3zjvx42aJ951RayShCwT/aNPo0UUFDI3UUpLHj8
	 GXRSEc850LHGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/17] timers: assert static storage for DEFINE_TIMER()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260915031334.1194975-7-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-7-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:00 +0000
Message-Id: <20260915032600.6881E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_TIMER() marks a timer as statically initialized for debugobjects.
> An automatic local timer instead needs timer_setup_on_stack() and the
> corresponding on-stack destruction before leaving scope.
>=20
> Add ASSERT_STATIC_STORAGE() to catch automatic declarations at compile
> time. The timer lockdep key is already static; this check enforces the
> debugobjects storage contract. Leave __TIMER_INITIALIZER() unchanged.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D12

