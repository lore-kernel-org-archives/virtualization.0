Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631781;
	b=uPmFm8jvjcwtNBo12mYv0ZXvVMwgWMMqOnWaRwrNQn0k+EuSXDTlIijOnRLWuxWmdu8I
	 ES+3F0emj1OWpNX0OCPZcmLSrf+CJUJMxAZkugfa7RCX8SKVLgF/ak1j8ipe60fIx838B
	 WrWyfUzGP0NQ9GZzBAb2xyUOMg6AcGC+Y260VOIG0d4J2q6AfdNEbJyIrWj4Q4QSolCLl
	 BubW1TTs6kwSxHVrGbLz9NTfQub5Zt4fQCAlEJuL/7gNyhmNFGxqJS/sohzWlc7r0RdBj
	 0dBM8rN6Nx7qSzAaKzoF+/5jIPcMtJzY/xsAoV7YdNXbwLiL+UAwBjFxQye5p3xHUTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lr82EtZIjZ1WUBLjmArT2lySHbJgzwCbeH89H/k/lB4=;
	b=0d0aTaVYSBa8YYQ7P5JDqLZPDVyf9CZZFgIWCg0t49O4HrbZfX0TdFLSuLFKkbXZpzVf
	 XWpRDF9/c1rePSLOdxxELzcKuovKN1cpHeXeIx1+QXCr9mMwFOJhLsCyzkwePctJZDxvP
	 /TdVd4i4RBFBFzkV1/YCNPOsFrOzMZNXZ6CzpgbH265gJjNSiIX2bZmkez90RJAMXfsgO
	 789cM10rh+iTsnBU1O5ThDPEXHu5arfQSOs6gbGMSsIUYCK/Ued+mkhbF2D5cczQtcJkH
	 rCKVJXELUkCIwBC3HDGac9azF/6Rathfp5fykLNSNFhJZ+AuOoXxsig+a9a2DfSG0Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdzggiKt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2C606A321
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdzggiKt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4F61F000C1;
	Thu, 22 Oct 2026 01:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631781;
	bh=lr82EtZIjZ1WUBLjmArT2lySHbJgzwCbeH89H/k/lB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdzggiKtesNGBLvO8EEnKCymuhBBJqS5JZngCAmnEQnuFpKLcU4Ynm0w9iiP8a37+
	 AC/P2k4DBMem/zX3km3sqLzTD0Gxs6wFWi+n5eJhSNuIszj6NqPjt8VNYSACnuNEYb
	 H3Y35STYT8uy1x53Vy1z4IxCvGvs75/0Awu6ELNuF2omoIBDbrIP9yv+8MyLDaPrG4
	 lewwiPv1c6Ll9PaLQOAmrbZ1tygi68wR/7YKLLFUtynTGUCQihH0I6HbOmzaglkUtm
	 OADKKEA+Nb+RKqtl699JrttHE8+g/N+JAvJ5yyxMxvDex+FcdS78Kx5cMiiD60Fb7A
	 2hXdEnTcYfCLA==
Message-ID: <sashiko-outbox-180840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 3/7] vsock: pass the netns to
 ->has_remote_cid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 01:16:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The transports only use the socket to find its network namespace. Pass
> the namespace instead, so that a later patch can ask whether a CID is
> taken in a namespace without necessarily having a socket on hand. This
> will help with avoiding CID collisions when devices move between
> namespaces.
>=20
> No functional change.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vsock-gues=
t-ns-v4-0-047527cfccfc@meta.com?part=3D3

