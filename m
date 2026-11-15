Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727279;
	b=4i4GFJybcush2vdQMzdqaYv+2o0HxpnzgoFEhX3ugneuz24jCX772uag7kDr3Iwnlo8S
	 M8xwmpWwEP6FxKLxaEw0zzte/ETP8FUXxk5ZzGhMkhTG4lj2LJvvQMIUrKtgUNjWODLoO
	 rgnMmus91/3sVEAdz+F3rXqBEM+/pUNaHXqKhKSSgwSRoTXWgrH/9YyJHa4o9ZVd3WcHX
	 PVFRtf1tgb9fm28a1BokmUiFzgw3J6znX9g4y1L6GXbJqmtpkM+FAy8iEHlz53NB76ynV
	 0spMEbYMpeR3FCGD3aFMoFhckdVNP36IcbnYbZX6pjRH8581W++WDWy66jmOOAdUnSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r1+BFBuZq2X00aKCGqYA4d+iVksV9wGSDEbVC2VjFcw=;
	b=zvTa/CcKQQjK/Fv/y/hosYUVxO2c0QZqUjzy4NIK8QTdQnatq61uR3tmw3VBl1Djaner
	 lpJttgcHpw4FJHWD7g+kl012/Ock2cbb1LTdcb7rKcDMIwEClS/15CBpAEqR2yTX/ILcq
	 gEFFboXTbEJma+yXpv4Kltv0e0wlqLEvAo6dCUH8t0vj9CG4TP+J1osIX/TdkwuEVZEWj
	 3aw32DA0tTsHM0MNK83uSEmcn2sjTN+X8jUCQaXkwLQtvDGlgAV6QUyuoNEWyKohv7d01
	 +cXPITHO70oOYwSRAVxQpKayW4xiQyDdq9SWbiqwcNr+fzHkjKyE6582mHWTet0L6WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfNvfYTk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB743606A8AA
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfNvfYTk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F351F000C4;
	Sun, 15 Nov 2026 07:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727279;
	bh=r1+BFBuZq2X00aKCGqYA4d+iVksV9wGSDEbVC2VjFcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfNvfYTkF1wREtBNDfnPbhCPV+or7j2zRrBxz/spKZGS2qAtsBRKH106QZwKzzaif
	 ss1hBfxQC5sGbKdFsXXywFbfqscLHqlPR1Vp6o+M7chs0HAjDVSy29J/6SnnxTehZw
	 3rrgNKkF6DuUSKFPc3dRzK2jWgSExrW35NsFj7UhdCq0ZVn4h/FRw45J/VAMte9buq
	 dzB9V8whyiizO8E4QMGZYTepWB4I5qU/NJCjuEBRvMZ8kItIMxPSTGo6Y6xOMKMyHj
	 yBfvzVcytGG9fDaAYFPq9qOMXwnoHBrQt3rPq1AldshJcH1fr6rrbO3gJl0H9+PVMG
	 So8pz6jRPg2qw==
Message-ID: <sashiko-outbox-215254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] virtio_net: mask callbacks before releasing
 NAPI ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Congjie Zhou" <zcjie0802@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_E27D0F1CA04EE58A5873E5A4EBBDCDF8C80A@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <tencent_E27D0F1CA04EE58A5873E5A4EBBDCDF8C80A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:21:18 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtqueue_napi_complete() prepares callbacks before calling
> napi_complete_done(), then disables them if completion returns false.
> On the hard IRQ deferral path, completion can release NAPI ownership
> and arm the watchdog before returning false.
>=20
> A successor poll can rearm callbacks and complete before the old caller
> executes virtqueue_disable_cb(). The stale mask then disables
> notifications again. If the one-shot watchdog has already run, no NAPI
> owner or timer remains to consume later used entries, causing a
> persistent RX stall.
>=20
> Use napi_complete_done_with_irq_mask() to disable callbacks before
> completion can hand NAPI to a successor, and remove the stale mask after
> a false return. Keep virtqueue_enable_cb_prepare() before completion:
> moving it after ownership release would reintroduce the RX virtqueue
> race fixed by commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
> processing").
>=20
> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> Signed-off-by: Congjie Zhou <zcjie0802@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_2A5F8EBA9EC=
78CA99CD080386A68EE90B506@qq.com?part=3D2

