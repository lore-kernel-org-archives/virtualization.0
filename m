Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058053;
	b=Oxz87NKpXzEjBHjzku86w2KvB5fWuLmFQ9qbaxSfDUQEuTabfniZy9BLZFshFlhTOcoc
	 EtcBWglMoJNL3cR6YENsxkp5WX3SMOuzBKshpEJYb9EqHALYJYpPAkBnGl3QD9d/TWVhl
	 IEhW88/dj/t2XEMydSVKV2xmylEK8NMOnQ5gUJLeqCDLsaaqyKugr3AxR30JifaFqFuGr
	 GmZi0cLoPKBX4/AGbWKE72lj8homHH/GklOtW/NAQqWV4E5zbyIIyuXMUdGblgbWlkHVd
	 EYn40I6z+HJKIT0D15qfjaBJwYD0Cj1zYYsaFzuhslYxfiycVaXI+Pu1tPD6HdPkJ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bPUk4flzlX2JlqDDYO6RSR4KFqyEeTc3bplfuenfa7E=;
	b=djTUcIfTp+YmjrgDbyEYXLVP4eSwJWsz5w1TXlBK1YvL0b2DG0pEQ3xe4BmfQKxIr5Vd
	 VFeJk0fwjVsBF7FnVlh8tzPS1yZcvVP8R/bXAAWDfIE0kxz9uBxdNaZiAFgIFR9jiglg7
	 0ZnX/x4/uZX8XKO6DFHFiMM0aBtTZPqTbT/wC7mIL+wLRlQhAEY0QCcqndDnkEhtEG1KG
	 wrlUdmrNY3yu3WDMF1DkFFZ0FLhrdotJr88ZQ7HvoY7xb2RIw+Job07licq9fYrEiDXZI
	 DdSyZSR/gDEcDJsCupBXJObSROTqpRb6LR043JW8hZ0lia7oMfQSlM/T6w6u9lSBimQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b46Rhxf0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFC606A339
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b46Rhxf0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C381F0089F;
	Sat,  7 Nov 2026 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058053;
	bh=bPUk4flzlX2JlqDDYO6RSR4KFqyEeTc3bplfuenfa7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b46Rhxf0fuSAmCilFr7OhDQAyzitXuXtls2LTjSx6GzgZIA5vKIN+JEidT2m4OfXr
	 cQmRhFhOiUKKhm0k9qogGT5ikSlSbRZ2Ehk32rM55kj4bdYxZakhtL7bi45XqIj4aN
	 +wHj2VDWSFrm822of/77urN44iimtCGjFbhYw6Zkw/a3+quyCUBQVboH3vyZ6G1QV9
	 wIqlCXKElwlIGA9YK4u4rMDJWRpqcxaNzhPH/D/f3YSgDXPGBb3Di59rkvwWAQLAqY
	 DpXejNiRa/g0tLjWFpL/sVaDT/e+Xk0LA8MjooPQXZ6cDS45L+xJdWhqZFvQq4MmDk
	 45YdH4uY0UTdQ==
Message-ID: <sashiko-outbox-202924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] io_uring: account the remaining per-object
 allocations to memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106131829.3228926-8-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-8-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:27:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Tao Cui <cuitao@kylinos.cn>
>=20
> A handful of io_uring allocations still scale with user controlled
> counts on plain GFP_KERNEL: the per-ring io-wq and its workers, the
> alloc cache entry arrays, the provided buffer peek and import iovec
> arrays, and the registered eventfd contexts.  The tctx side is covered
> by commit 0b34e7b20a48 ("io_uring: charge tctx nodes and
> personalities").
>=20
> Charge what is left.
>=20
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106131829.3228=
926-1-cui.tao@linux.dev?part=3D7

