Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56210272E56;
	Sat, 26 Sep 2026 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439363; cv=none; b=jc8/rP3f3tV7gqI60JQV+caQxYdSR4k2QZui+7jswvR5jbkxxH22Sgq+WMI02xHfGOhi6OiVgr4UVvulAsvWpq/+7KdcMqJTRMgAdKMjcgACJeGaL4eTe0xCx1wj+WSAtXJObDEox9ENTNxcndXz2A1dMcB4PG4GI/6ioIQ5jWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439363; c=relaxed/simple;
	bh=koJdcjq/zxVsqRg8BoZjo0AeCO/+whsDFtkvTmURmqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1kbqhMg5+qmwnsLN7LCl4e0kRoa2IGeuN+PvRx4MaWYf56DoTXUfKSEQ67816yImpXswa2MK1m4+Iezab091qzrdnw9mHvnGLD82sXI21skfAsJuu8sNT0AoTV8dNNieKM2SHtMw9fxjAsPNw1OzYlTtxfKLZNZVgyztC3kxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXbJXf3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXbJXf3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A301F000FF;
	Sat, 26 Sep 2026 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790439361;
	bh=pURLcO7UGj5kYuwalRzZ8iE9wpSw4sCWI7WDvd9AV/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXbJXf3CxF7DiSLnh/Yca7TTaSAeVJ/FzcctjD9Bm9NJKjGQziPJBRRyqhrrhowml
	 VPAD6zUHzAlXpOnFIsndc8wDsU7jUm3V082bu9EcE0bSDMnUHEop4ZDBIjvr0T5mDT
	 jRUpCODUawGKF1bjYT0pHD8zc01OZc7i5Vjk2tT793o0JirPZMu40M0cPFLCA7fpaX
	 VpjH+LbgojkPx022mAKvZb02CqjBBz2r67fttvajz4YL+6Vwvr2WELC12IcVIe4/lk
	 7Bc2b063cNbEUO/Fqgg1jnYIuBBlrfMVS0IUuxBiMylQxBdRT5zPtPNRi9b0V8/gyY
	 aNsorYQAnoLXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vringh: reject empty / undersized indirect
 descriptor tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260926160755.21485-1-fangxy@xiaopeng.com>
References: <20260924030627.13287-1-fangxy@xiaopeng.com>
 <20260926160755.21485-1-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:16:01 +0000
Message-Id: <20260926161601.A4A301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> move_to_indirect() validates an indirect descriptor table only with
> "len % sizeof(struct vring_desc)".  A descriptor flagged
> VRING_DESC_F_INDIRECT with len =3D=3D 0 passes that test, so *desc_max is
> set to 0 while *descs points at the empty table.  __vringh_iov() then
> copies one struct vring_desc from descs[0] -- 16 bytes past the end of
> the table -- before the "indirect_count > desc_max" loop detection
> aborts the walk.  The over-read value is discarded when the walk aborts
> and is never used to map anything, but the access itself is out of
> bounds.
>=20
> Reject any len smaller than one descriptor, alongside the existing
> stride check, so an empty table is refused with -EINVAL and no
> descriptor is ever fetched from it.
>=20
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926160755.2148=
5-1-fangxy@xiaopeng.com?part=3D1

