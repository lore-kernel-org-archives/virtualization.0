Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878987;
	b=Ot9Gbr/FG5qXAVw50vSALbZ41knM7SCRfjzrg9wEImh+w2DP5ShvlZ1m/KTI1RWWWiIu
	 WW8YI1wamR//1sfUP+OUJoXU1CLBE+LWhlWKpOoqjRivUO9O44/LdmTc0hbsDZVN43gB1
	 8WEKnPuUhQZ+fM7niCqyzy7fixDyOoweqm3yCKmWso3fb761Ae4CWB6/MwgAON3IkQNZG
	 WhhYoBQPyB+t9fd3X4Y1AYOVwl5ZVMIm1RxD3EcSqkquMWdknpogjQwVfk1iX5lC0HILA
	 hf2yrz/aPY1CEVA0uTptL+uaiy6Q0L1D0LbUXJRtJQIo/IFQMeddSLW7Jb4x73h9Usw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nmPeh1g6C2/hpJvPIZDMC59Tr8cSFQBga2uJG30i8ec=;
	b=EMRvFYfpBoL0XCgBiIrHOmB5rtKjc086euyCuH45jTodkwByifyGWutGAV6BJgQnxdcy
	 jR5ECRalVj1+JtPLQea5IQ4Gk4i3rFalEX0SmdDkovkjHvDT9G0BTfPu7NItf4p8Gso+u
	 3N8vtp4I1GKEKMW0y8KVizflPnUJ4TCiN8p921LjbQchLElvGPSicXigyRVOOft8CgIt4
	 GLJnujwQpWpUoGKjit5Bi3WPtkXEqWWdUPN0+0G+2DLUnvE8SE3cJFjc5kccA2lSZ8Oui
	 pbBPD2XHbUHeF/iqwvqNREx/X9vrj6bGIYfN3JYD7+rIT/pl8ppCdYQ7EYYkES/VRyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeYt2+Ng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399F608363B;
	Thu,  5 Nov 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeYt2+Ng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3856F1F00A2B;
	Thu,  5 Nov 2026 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878986;
	bh=nmPeh1g6C2/hpJvPIZDMC59Tr8cSFQBga2uJG30i8ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OeYt2+NgcBA6b2dGab6VCq49hzDSsdI+GSZ9lwhJOrwB3uBYgoSEwdCaBO52LQHXc
	 fvBjRa9s2slZDsXp9hKnApPTQvtSfISeQOsb0Y7HzusDq87iqZ4PdNU269k7uGPY1D
	 NgZ48Du2ei6Uo/PSrcJ7l8QOf2r1tv/ON3kTzhsJWZMbdhUV0b4VGB5alxtRuUGggm
	 adnZd/l7h7gnnMgosKjusaF2blOTAYhcPo+szGpdOiJf7p1rNUwyzEd/1bN338YBQw
	 +0QsUWYyJzQpnPCKuBhiNDDU3NyiimjjfwsfMM9FCFlajvjJ82GpB+gs3oRidC1jlX
	 Cw5dQXesrukaw==
Message-ID: <sashiko-outbox-198971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] dma-buf: dma-fence: Remove dma_fence_init64()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Stanner" <phasta@kernel.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261105113529.1989375-5-phasta@kernel.org>
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:43:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> All users of dma_fence_init64() have been removed. They now use the
> respective initialization flag in dma_fence_init().
>=20
> Remove dma_fence_init64().
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105113529.1989=
375-2-phasta@kernel.org?part=3D3

