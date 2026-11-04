Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822520;
	b=eiyo5HNamcp/9trs7fOHq5Wr5xpX1zmQrwfgoSiEfkMiL6JNF6zN3c6v8FqEsz8vIzsD
	 27tbgJ+keerFpIHCHwI7sIhnCsspJR/rKtdO1MtBrCz3nQVxu8wYmUN3YZw/HMY0RGhMi
	 95FnhG0sg44cfTn5CtzAW6WpsTVAUkkFQqGf8uPJ/vzX7Fuv3GJfXsufpaynunOq8W9Xv
	 MX9lrmYsW1zrQFZY/tTQtos68VqIaIIWFNn2ACEeozeDijVrPT9N3zMZuh1/9MQR89vnW
	 bqqH6RKiyIn2yiohz+qnRDtRhE8f4aJ0v5ZLmu8ZBLh2DRW8Kznj6TVP+c21zWU3UbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7B1dL+7wDfNrCepqeQ+YxsywK+j6s2fDZQTzAfjp/tA=;
	b=5hfkxAPSyLJdbrs+g5kMRXekdoAsx7cOKU/+PDGon7/cZvySGQGZNbwpsSB7pYfmv5H2
	 eqOD3pymzfCdkk7m/fvz5Hw4HJWTMjwc07vIXI5tuSjA8a0em2/99qY23c0lc4QfNpjZh
	 Fg9zTPjluK9z/YVY68mGVv0ptZMGffSXLPCi0Nxa20NukW0TPUBOTMvRt3BTuL4H1ZIm/
	 cNPB/U324y7MSOJEKRIwrY3ZG0E++ohvVsJ9GYH7l9pwHQoprH85S2blB5ZdyZNosB9+0
	 bEGT5jTcT8cVMvAMfnBEP/AX5tqAqlIN/ZljyJcig0F5jJjpMj0/0EaD5hZs32WnKiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ND5ory5B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE039606E815
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ND5ory5B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D881F00919;
	Wed,  4 Nov 2026 20:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822519;
	bh=7B1dL+7wDfNrCepqeQ+YxsywK+j6s2fDZQTzAfjp/tA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ND5ory5BhLEcksLn8+xxemnWfGPQ0YnIWdKJEfeGV4bEcnM/ShyJiz04pXTRWfH8g
	 FiyXKqcM8aiNwFJymyQkdFamyicxQGBDGETbM2A203GozQLW0w7tTyl9ZA4F/leqGE
	 Uf6DUTOYzvLYfaaAWoJOaEykWLmnwTaMBloQP17JXQaUnkBfUXfgEXTreTKqnm1QCJ
	 BZjZYjyL2iOD+mUhObqyzpqmdoqfKS1cXgviu6rpv6YMOKsaYinMJ3TkyROJe0Q8jX
	 LItGDPIquMHq1IlnSyy1B+ZktKjGHwMqDo1MN6SzRxAwgIwxbMl5KY3lNvLfp8Ii47
	 vdFLH3rYSfTUg==
Message-ID: <sashiko-outbox-197987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] gpio: virtio: compute the line names size in a
 size_t
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
 <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:01:59 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_gpio_get_names() computes the size of the GET_LINE_NAMES response
> as sizeof(*res) + gpio_names_size in an int, where gpio_names_size is a
> u32 from the config space. A gpio_names_size of 0xffffffff makes the
> size 0, devm_kzalloc() returns ZERO_SIZE_PTR, and reading the status
> byte of the response through it oopses:
>=20
>   Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000002: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:_virtio_gpio_req+0x2b8/0x550
>   Call Trace:
>    virtio_gpio_probe+0xc2a/0xfc0
>    virtio_dev_probe+0xa7a/0xc50
>=20
> Compute the size with struct_size() into a size_t.
>=20
> This patch is assisted by Claude Opus 5.5.
>=20
> Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104195632.1702=
765-1-lian@is.s.u-tokyo.ac.jp?part=3D2

