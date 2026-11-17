Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905084;
	b=030zRFdzyn5MX4HR7nKUhK/YkS4tysXXBttnyTgApTYx/gTEwTKlfgf3d3tGzXW4QW/t
	 RF7uCpcB+fK0k1eneRGf8oX/5ih0Eg8R8PexrQYIbD6qF7wX81Yx3dRrwOtCRCGqqMKC3
	 06xLgTTfQvVde1Z0RKIR8QslgdvA9Iw1KsqHn4vIpDMfbiGFG6E5w94/RPD7vX5oO8mwb
	 r9JKQAeJ+LORBF/00sBotqVrEOKAP89+BOJzOIw1EWRqCSLWnEJkuSBPcn3sFHDNp0ho9
	 rkTLy+8xqzvAdUXZupWz8jbrnKu4KVplSJdMShelt26NnVMDWTSpANjpHwHAcnyA3yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905084;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UMbTA8aDAJy2tLIb/utGoSjf+MEFHZVVYTC9zn/WZkE=;
	b=elJoVDC6zIAL7XU0V16BMBta4eHS918wHrFM3Fgd/T06d3b+B5N+Fp+/47H3dxXUALCL
	 R9tVT08ld4SCLSHTepVcd9Ctlvs51Y/fWVhU+Om2H3XtegLKEhWrqerUoe7Mqjt9Giear
	 3MpUSiQxJcKoncLA2hw/M1IzyyK8HfGtSfuoQBup+8HZPUC4WCMlFc1slFNdV6Dpg1Mh/
	 Bo9QH4T1NLQm9Nx6m1v6YGrLFAFlFvdq5/I2r6D/zOJNYiDEeu5jK+FWQ0ZbGcQXUmhFt
	 O71hSQHYjmX7U+YwK7WU/LOLzkyoCPgbSgV6v/DTXbVgVI84K8V/2/HX3xjqpwtWKow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5+QeN+r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA0606A8B0
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5+QeN+r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588C01F000C4;
	Tue, 17 Nov 2026 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794905084;
	bh=UMbTA8aDAJy2tLIb/utGoSjf+MEFHZVVYTC9zn/WZkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5+QeN+rUuPJcZtKGjDvJmeY4Hb2VuOnPnl2TMBVWmd9glR2K6sruu0hMUbQat2Hd
	 Wr0nspsKnfK1kF9LInt2Kmt/zDxIcAT3pFnlLsvYYji1gMeyphsLfW6laFIom+z5+E
	 NAuQrPtrCyFyGyTdhuomkxRqsOU0QPgHBWB57mVWAFb38CeTwEOellEQWkEl3fRvvS
	 Y7qm25QYfaxgGVs0j46vDRaAhOG+Utntu/SXjNuOJbYsMmHy4y4vptKcVRPl1GH/eh
	 l463N34vmB7nL/PnUIDBIYumQtlA3IGRp1ln+zsUZ52TttIRbkxaFTPHJvD6gsWTwO
	 FwyHgfD1ndKVg==
Message-ID: <sashiko-outbox-218427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] vhost: set dirty log bits without pinning pages
 on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaoguohan@kylinos.cn
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117083323.89502-2-zhaoguohan@kylinos.cn>
References: <20261117083323.89502-1-zhaoguohan@kylinos.cn>
 <20261117083323.89502-2-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 08:44:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: "Michael S. Tsirkin" <mst@redhat.com>
>=20
> vhost had a TODO to replace page pinning with a version
> of set_bit that works on userspace memory, since forever.
>=20
> It is really best to avoid GUP on fast path entirely.
> Implement set_bit_user and use it in vhost, to do just that.
>=20
> Should not be too hard for non-x86 too.
>=20
> Reported-by: Khan Zhao <zhaoguohan@kylinos.cn>
> Link: https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kyli=
nos.cn/
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [Khan: declare efault with __label__ so it is local to the macro]
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117083323.8950=
2-1-zhaoguohan@kylinos.cn?part=3D1

