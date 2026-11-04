Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822632;
	b=bVI8eVcDdFOnGlU+/eJnwCQVPWAr3Ll15fL/U0b8NahcHq+fg97DXI9rPRwfcvBWRqmy
	 kv9ThS/9TgEy1CnZvM/0lO3kr18L+gDsiFwItyDKPRp6VJl/DGkduYvL6hrfSSMTKuEDS
	 nYu/aB4uzlM1Wzr56MZOhJaUfL8Yi6TDUVWapYRaUFpZ52GRmyZnHWVBD9eWTwU3OrXK4
	 0sROiX+DiIEOd3H/XAHgnN0BvicdETMTgVL1Ojd0BhYgGoNYrVGipHcge0Rlk8t2eYcZQ
	 lCQkZvZbIpawI0iadIv+U7L7H5AWcSEj3OGHHBModsfZEMb27V6OuyBIyiY9DhlGrfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822632;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EauI2F9zE8X32gU+4zTTTj61PF8BoqcUugWVKf7JV3Y=;
	b=h+0Hsrw0rVD6Or+MN1pwHG6nIJW3Cf80YXwPJgHpa4r2u3tiTI+9cIwchGHw0Vwynkoj
	 TqkQ8wmAOj40X0AxoTO7+eEcYeifXrr/VPsuUGXaMbyDyDQl99FZQhSD79CtCu6OflrT7
	 7/MoKa0pn6ZF9j9QAJJAHDRYs6rZ+w+XgQek5DKxJu2FJ2GLhGzIPqJJ/r1iWZDJfQLXO
	 VWSOcSo0qCNjLdOqIuFzhqBV54pX9/wJ48IEqXm2Jgj3grAy+vAiAgsOJNots2ZDYS/43
	 WR8P6CtGUQv60K5vkDyVuwugu6JnG+j42wGzaKJe17vcU3XokH8gtCwNApQtD12JZgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBkwm24W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0B606D4D5
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBkwm24W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD57E1F000C1;
	Wed,  4 Nov 2026 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822631;
	bh=EauI2F9zE8X32gU+4zTTTj61PF8BoqcUugWVKf7JV3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBkwm24WXYmTV3ZiBI5Jv3hODbHImnQ4ZlswDVZyL5+tv6jjUe8lzNY2kt4FNlPtR
	 QKb9I4UOz22s2FmiwIz9KOo9Qesqn/mzAPQaAlYHc40sIn9kjCyOacxygzLPkpG5Pc
	 f2gfGEfEs38s1hPiFC1gDzpXDGxE3tNqG7QsiIdbxDejLg6mxSHHbcO/+n6KnvnDz4
	 P8+IGtGcanapbQ7ovE+G4iW3SImQo/z8xnU8MS2vl+9/2Bn0ef6dv0JGSegJRmKriA
	 TZWL9sijycnN/Rl+e0KCIh/tTxOcufRzOD1sWToW0KE6nFVqvB5CXjITxCVBt10ujG
	 kqLSmQJL73CDA==
Message-ID: <sashiko-outbox-197990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] gpio: virtio: bound the line names block by its
 configured size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:03:51 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_gpio_get_names() walks the line names that the device returns in
> a block of gpio_names_size bytes, which the driver ends with a NUL, and
> checks each name only after stepping past it. If the block holds fewer
> than ngpio names, the walk reaches the end of the block after the last
> name, and the next iteration starts strlen() at the byte after the
> allocation. With a block that holds one name for four lines, KASAN
> reports:
>=20
>   BUG: KASAN: slab-out-of-bounds in strlen+0x57/0x70
>   Read of size 1 at addr ffff8880026687c0 by task swapper/0/1
>   Call Trace:
>    strlen+0x57/0x70
>    virtio_gpio_probe+0xcb4/0xfc0
>    virtio_dev_probe+0xa7a/0xc50
>   Allocated by task 1:
>    devm_kmalloc+0x6e/0x280
>    virtio_gpio_probe+0xc06/0xfc0
>   The buggy address is located 0 bytes to the right of
>    allocated 64-byte region [ffff888002668780, ffff8880026687c0)
>=20
> Check that a name starts inside the block before reading it.
>=20
> This patch is assisted by Claude Opus 5.5.
>=20
> Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104195632.1702=
765-1-lian@is.s.u-tokyo.ac.jp?part=3D1

