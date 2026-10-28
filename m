Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182032;
	b=blaI2cOdAO/oE2tnjgFgu9gs0/pW/2ScU1N8xHl03dV2vGuTREKyEAIvNbYDAXgrGB+9
	 bRmcK68B+zd4Q+AhOBhT0VJwbTFLlKjBTgqwtUmBL9Uz/ijLbFBjX/6kfOvGctYsrX5qK
	 CXuviP99WLN9ozGLB/jk+PWMaO+5fN1IHquQZa9jszTe2eTGYHoKdNmYUxdRhYTUoqOLQ
	 VL3yAAHrLBHb/H+1LV2JnjKXtUolpNyNriaP+mzJouefoXdxTMPYgPHdNlOODYkrzHFxH
	 wXKSTvtCqLqzUaC8+3xSKpTScTInMi8xOIZOp9+zhyqAO6lTSve55RTDPJBylagOWwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Gxn7FnbbBTFP30OAJ5kgA0Slib5++lN4nximN7EwJg=;
	b=cModTtB17Q3++3a63ZdVMyJxNkCjGJqzObwh142Vqy5GnL3RfiX5XP6lB6NI6PQ73Kf0
	 X+OnPuWFD5tIMK5lRUScG/bKJjkK/mdP7I96ISX3SBkakGkjWRDrMm0XfLHI0g3VGpJMD
	 ddbL+1KT9nD5b5M+Gr9pkKVQILL0DkKbZfaOkjIguJxiIkbePNRBjx+67rQQgqSOwWvs2
	 ASMTpfNCL5baHk53clMxi4BxHnWysQKmfZ9YL8tbLAwwOYnNGaawoi4yapJCxTXn+qh1o
	 3b9ULgkS0gVra85kpRPhx3cgivBNhuGSfv1NET6b7KZCq9d6tGIPiCXUVg9XOFz7TeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlVs78Xf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603B606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlVs78Xf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F61F01828;
	Wed, 28 Oct 2026 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182031;
	bh=8Gxn7FnbbBTFP30OAJ5kgA0Slib5++lN4nximN7EwJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GlVs78Xfm1rTw7MCpoLhizh3dx3sp6lAY19ENfQJ9PdbKQzPhflebwL/W50O1rZMI
	 T0bCogl0oFELC7wwRQDcumbp8/q6NBudSZDkYUeTQXnzHnRxdNjEqIUudcMV6Ted6s
	 gIJzRTOM9WYqWUVX2G2RfsKL/c65f4fOPe627oFvcmDCr5BDxVKgsOlqtX19gWl3z2
	 9Z0sX06yoeT0FQXqlm97q2f2HBdImSb+EQP4E0uZWGON9rSRkYkyF3xZx1CDBDaVgG
	 F7/f5LtbyOa0sUc4B/aFI5zPtcPpl1Qe7HOibtz1q33ECmYIYPK3BaNuriVWKE3iji
	 PBf2D3cXEEINA==
Message-ID: <sashiko-outbox-187722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/16] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-7-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:07:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D6

