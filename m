Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491537;
	b=wz2oA+Kr7ol+b6dd3TSFcgbkaw0TZ1a7Kd8yDAi9Wag3JeiLPTo3/Ye30HZ7drlFdZVM
	 KeGGzzEUIeS3B3SuUBkDuMLantT81OighLe+Q4sowx3WS13yBDIN9j6uRVfrNMMl1uBEJ
	 mgP8QOO3LpYGbGhhpKHxiFPTF6i5W8AZyStpB1jyVxexJLm5Yv0ZCUl4i4MKuphbFgMM6
	 rPWw+b3EHNRAY4drPaYhzPmoeq+i3BtjH5bvWUGP4dHST8OKIn1/9+4xOCS9GrN/0TemX
	 XhB6eEF3yIldJuC2h1raSEe8Ghb1MJIlkflkzujkXciAS/vdb2xX9rgaGyvViXtOi5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XDNrklkaljjoo+tbQvcuivuRLm2jLmi0keVIhvhRUGE=;
	b=mXikgcjglRt+u/ruQ5Poetl1OeoOnlf4sbVsWjj3DxQW/pEyp9PaxFPkkUw/PdhlN3w/
	 TmfYhYUodOdBQOon4BMW+Ur7kL4j/40KEZ/wNMnteQz6CU7Rqn66J+Un6Mxy8Sb7LW+Ak
	 y44LfttxZ53l8t9w7n7pS/klVCLkpzDyZ4DJ0RZXFzS5Z5dEXLcCd0UMK/pimZ7yQfMpi
	 cJnDFdeqaucboGjKHPVz08HJkiprjfMPTJZGmA/RVVCTSwZCCgXihn3uJwEESdbBysxpa
	 vVX3iJj84YRWpPcfHWS95TGCccVw7GkrTWSTFPoahbuZhT+K5s0jGTVcqZFcMNPhIDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Wjg7/eAj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2D606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wjg7/eAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161781F00A05;
	Thu, 12 Nov 2026 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491537;
	bh=XDNrklkaljjoo+tbQvcuivuRLm2jLmi0keVIhvhRUGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wjg7/eAjt4iL+y2jSaUv37+TGHW4uIVHAn7iZuRYUY5mAiXgobiWph5zQgLQlO1jq
	 mAwoTDwjajqevcF4EEpg0leaHe4U310wlRKOM2p6RQzZdM64LXu/Y5A7gAbVq7NZ1T
	 g984JNZ/TgIJvC2ErB61eB5mPpxipNxgNUwI4N+iwPc6TWYEAt+aHe/lGE853wAkkH
	 GHWE3B0AKb4Sw1ZAITMRZNZUFxgen9oRWjYvRm1JAmVOfpmPSHEkwZdi7ZKE9JfmbX
	 MX4HLaSm2zUdktR4N5WOlKrylKSglX6nTn1zfigMvG+yD8y9/AS0Uq8zR/nkGdun+N
	 LB/ssw+j2/esg==
Message-ID: <sashiko-outbox-211233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: napi: add completion with an ordered IRQ
 mask callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Congjie Zhou" <zcjie0802@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_74EA7A2E8BF5758E9C5EF18C9B1CED401D06@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <tencent_74EA7A2E8BF5758E9C5EF18C9B1CED401D06@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:52:15 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> napi_complete_done() can clear SCHED, arm the watchdog and return false
> when deferring hard IRQs. A false return therefore does not guarantee
> that the caller still owns NAPI. Masking interrupts after this return
> can overwrite the interrupt state established by a successor poll.
>=20
> Add napi_complete_done_with_irq_mask() with a mask callback that runs on
> false-return paths before ownership can be handed off. The callback
> must be non-sleeping, idempotent and leave NAPI state unchanged, since
> a state-update retry may invoke it more than once.
>=20
> Keep napi_complete_done() as a wrapper without a callback, and inline
> the shared implementation to eliminate the callback path for existing
> callers.
>=20
> Signed-off-by: Congjie Zhou <zcjie0802@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_74EA7A2E8BF=
5758E9C5EF18C9B1CED401D06@qq.com?part=3D1

