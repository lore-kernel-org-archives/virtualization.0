Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794761240;
	b=zQcW97b9jUE59rYcnoRgiJ4jSGUVvLpdHF0uF0lGyoy6RqJ2TEVsJRmXkcwdMzuuFXMT
	 NKxuphOHcXbMuH2M+ZWuyEKKdrYLmcSlhZIkeplhDjDBz3Lbgvify1F5o9n0ZkV43Mkyl
	 V8ZMRM+RF3irys5dk9quRh9Ob8V/iRd593t5HE4BDSkXwyf4QzqxsAN2M9nFag2VfANwe
	 ZCKeFIbk2UP43gRuosJiwHqVlHthxE43t+x+8DVODHfXOuhdIQ345NcGo9gkQtyeKdpPJ
	 u8iGzO+wS0MjY2G0r6W1Kw/sx5vMb4MCI7uqWNYheP01WYmhZuC3o/b1nObpv2S+N0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6louHoinpNs3EUNID7jZdBIRJOWqtgvhgkrI+xPQ6fA=;
	b=R4fDv7kpL1P1DZg6NwPnES7yYQP+q0OALprQ7n86uvqDaRSpB0F5KMtrtFnxJEIBWYoH
	 RF7d+5uzKvDGDHJbm6CLPXxAGuCapCM35deIUFe+3LZn1FoOsSymp4T8XzLDyEoAJ2Nz6
	 7Oahm0/i1NH7fki6i4rSHBh1gn+pj0AI73fE0XB3C8ABDw89LLj+UI1NN+iNk20TeBLJJ
	 kU4mUREkJWJnjT9dFvd/lAJrtUufBRsZCgbJFOwqftZngG6cQns7Wrwg3Zd4wZxjkgKYx
	 2UBwvzfQFz6uO1Bjwb2ab3vUuAzjf2J1akgfKIOyJqXCx+yU6V+33cMq/nkM/ZbD3VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msNmsNkY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EE606A31F
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msNmsNkY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6D21F000C4;
	Sun, 15 Nov 2026 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794761240;
	bh=6louHoinpNs3EUNID7jZdBIRJOWqtgvhgkrI+xPQ6fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=msNmsNkY4vUNtQfsBy1bM++LCbRCkB37JN4KyI8e8w/mmLlLWwSnMTXliSMxMWRze
	 niFA9E8WEZDWSwAE7tx5bN2QtyajUJr1KARLTobRkzaWr7u5ytyfUHI+wRFEQAMTkB
	 wE/JGETR1Ps2qejbK4wk09pDyxGoirEhcblTVYtgtDvdx4UMp4ES9YnSfxPFivPTY3
	 hRNkNblmkqOws4jg6toD6i0PG1JbcxtUdl4zVWEY/tjCrrksqPR3TH2lVTcYJATtYz
	 QjUIjt8APtlU3FLtMSWDHf0VepIETgKGJPDi35ZhLQOJes+6HE2NHIl/J9Ue529aLm
	 7bMDSMX3/F0YQ==
Message-ID: <sashiko-outbox-215655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/balloon: fix NR_BALLOON_PAGES accounting on
 migration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: shao.mingyin@zte.com.cn, akpm@linux-foundation.org, david@kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261115004708909xx05JgB9nXnOCG0zL7h_K@zte.com.cn>
References: <20261115004708909xx05JgB9nXnOCG0zL7h_K@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 16:47:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/balloon: duplicate subject line in commit message body
--

commit d7902e64fbea27d19919ebb1f5426990572ba432
Author: Shao Mingyin <shao.mingyin@zte.com.cn>

> mm/balloon: fix NR_BALLOON_PAGES accounting on migration failure
>
> mm/balloon: fix NR_BALLOON_PAGES accounting on migration failure
>
> A balloon driver's -ENOENT migration result means that the old page was
> deflated but the replacement was not inflated. vmw_balloon returns this
> when its deflate operation succeeds and the subsequent inflate fails.
>
> balloon_page_migrate() accounts the deflation and frees the old page,
> but does not decrement NR_BALLOON_PAGES. Each such failure therefore
> leaves one extra page in the per-node count, which also contributes to
> the Balloon value in /proc/meminfo.
>
> Decrement the counter on the old page's node, matching normal dequeue
> accounting.
>
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES sta=
te")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

[Severity: Low]
This isn't a bug, but the commit message body repeats the subject line at
the top.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115004708909xx=
05JgB9nXnOCG0zL7h_K@zte.com.cn?part=3D1
