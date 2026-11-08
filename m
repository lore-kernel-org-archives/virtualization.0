Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794113909;
	b=xDEjqz5fFzYbHFsiFny2exQfON7eCJA8aQlnnCPbvxZC2AAZMVP/DvxIQqTaPH0FnMMD
	 urdrtX/XupqSa762rNUNY/PbLe9lnAA/lYLIMzkiCh5fme4T0ShzgSgkeM13WpazcsZ8W
	 +NoNHkTSJHh4H2uDQSNMz61bUsc916wisLNxFb2pYPt3z71R2CD9GIb3LJdVhLVPHdhfN
	 SASNvuq0151Wc0WtPb46vwsESRGrGXd9LrfZbSomO/LzD1nhq1gaVGpWGGk5g/u6Qvnm8
	 7N3uEgMS8T6ZWK+ASfSKnRH/hl6iE3c9sLC6knNt/mULgj80D+/h7B4Cb+POrnSaFiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794113909;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j7ZefcQDHttY15sHJGvnBuhp1QAjSG4PpEqjk8RYFgs=;
	b=LfurjI5jdwDVbqJVDV2/lyWRBrcZGFpwifcgb03W7C9F6yTecndz1eK8Ee2U5jPwY72n
	 nrIXRL2l+nkYvAdYoDG+nkn4ww/t+4g3HvcauqE9jjD4ONvEJFov5UUNlnfNMPMhpeaqp
	 dDZUuVmAp6LoCCyAB3IDCWsKcpXdJk1b6sKk6ZwWVw8a5ZbvF9b6ZQdWnNxb+kLXeuiWm
	 Bb2iCkcaAmMmpRgtFnHfHJE66dHzGHwyGBxrVtAffOaL4zkEvybbBRbIJrFgd3JbVAoT0
	 yWc+ehH5GVUzeLReCTk+MRTlalWgRmmOiyNOL+8/zgcMdGBkKLsRpOEpVzNDD0oBxmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHdTx2zV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD9606A323
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHdTx2zV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AB81F008A1;
	Sun,  8 Nov 2026 04:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794113908;
	bh=j7ZefcQDHttY15sHJGvnBuhp1QAjSG4PpEqjk8RYFgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kHdTx2zV0cALSxXjdth7PD5Xs9u4Ezid/hiT9bfXVXCgjVyoEe06+5NSJICDfnbuJ
	 2RiZa6JhJORp3acXc98Jdv8oCg5mKP6uMVxASgzRqs2uVJPw5PJIHc1Xtq3NONRLQX
	 Io38z1BFCAkeP5cDCh/TwygTv9IP9MPqRLTXFXDnS2kn27bqmUFhBTYvlH2u9Y6LFG
	 l/AhNS4sXZSedchqPCwTZeldiArccJ1fuuwfU13i+vCsUngvKtfYjjSMMF+jZjCVF1
	 oPorWRzyxNPy6VK8JAWTvtOqohfB7aRGv3/q9S6CJ4zr3PLBLD7Kg1vbkGmfb9AdL0
	 8gfkaLC0CUABQ==
Message-ID: <sashiko-outbox-203565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] virtio_net: Don't DMA map the kernel image for
 the AF_XDP TX header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107125723.33547-2-yanhaishuang@cmss.chinamobile.com>
References: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com>
 <20261107125723.33547-2-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 04:58:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtnet_xsk_pool_enable() DMA maps the static xsk_hdr, which lives in
> the kernel image. On arm64 the kernel image is mapped in the vmalloc
> area, so when the device uses the DMA API the mapping is rejected:
>=20
>   virtio_net virtio0: rejecting DMA map of vmalloc memory
>   WARNING: drivers/virtio/virtio_ring.c:3882 ...
>=20
> and binding an AF_XDP zero-copy socket fails with -ENOMEM. Even where
> the mapping succeeds, the header shares cache lines with unrelated data.
>=20
> Allocate the all-zero header per send queue when the pool is enabled
> and free it when it is disabled.
>=20
> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107125723.3354=
7-1-yanhaishuang@cmss.chinamobile.com?part=3D1

