Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062702;
	b=Uwuitm3Klk5D9FBPlVM1enXvHcS9cjQ73XNjbhHE9D7TYUTzJTtgW/P+P1IVxfZ1AOv7
	 zc+Nw0bjgjtTAFBGy2/t4I7RSZufwAfekOO/YtGnkuR4nVA8D/Jjh6tDc2CXFvY/NF7yg
	 PTK6ZM4UY1pD4nMyR0sJ899Aqc/WkONe4EpGs+H3kh3P1oimtGdhVfx07TUnauAKriIBy
	 8bAQH4n8gE+AVbJxl3+hjqXAiPntxfSKyha5AZlhR3Xl4IXgW9GIEBKKzL3QY+PJIpMKI
	 YHQbBOicINocZxWsJUMZno+QNiNjfVI1HAc405T71XIwMyuSodJowEZEBijuuIRV/cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hJuIDcfkQWpT0vNmoHDaU3xHb/qbam+MDfEj2t05W4s=;
	b=VVciLHxm88l0rlozR+n1Wn2eqXBsLiwCDvcIi4T0bLAllD7e6tes5bNp9womSHnHXpAx
	 JTg3xJ5B4de7t7suVjvQQJ8q6kJe1e14V6RTnyUgpu9pdCmtuyYZ+H/r/NB0C2HvamHT5
	 TajdMMCHdHl/SsRQT6QsaJjf8rmooYidDSv8ei+WhySCuKRG2vQ6wDLTAA+h3UbDtssGp
	 +K1qaNDGeE1oOzecDQRXum5/txEAHruBwyap7tNK0eUB1kVxlQCHViGiop47/1SgIHZHw
	 OB3kX3Y528za65VtLd1wqEmm/2/QMgVTPcT6SrDUuENjdkdZmJ7MNDhYRvoTBtPoT/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtRlEbF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042D606A32C
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtRlEbF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD041F0089F;
	Sat,  7 Nov 2026 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062701;
	bh=hJuIDcfkQWpT0vNmoHDaU3xHb/qbam+MDfEj2t05W4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtRlEbF2aHUFMCHnaE5RKMnbkggpDBKfZbiekkCyI5f9ZftyRgi1RRzZafvOcfBqY
	 GrDReT9Op5DyuN6IZ/WG0KlNBQT/wdEEMhbh/frAylrgk2OCh6zDBPNEPoZWFzTaAK
	 gLKurFFO57sKM+VxF5DZbSteRwAdWVu0+qh6ir2yJYwWoNERWxZWuAIKXp3mZuAP+S
	 fBpqwobm5yEzzvVcRYqllLbvcOE0MFJ/kQoa+S3m2Iw16WxqxQsokwoC6nBrbR97BS
	 nKU3hX02ZVVBQ4JsP89HSWIlKYr5thuE/P+qErWGkuwzOrP0IdrizauE4v9FLSvret
	 lPM0PO7tsW9hA==
Message-ID: <sashiko-outbox-202968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-9-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:45:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and
> payloads in the reference-counted message so caller cleanup cannot
> invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure.
> DMA cacheline alignment alone does not guarantee the structure's CPU
> alignment. Align regions to the greater of the DMA cacheline and
> control-value type alignment, and reserve prefix slack from the buffer
> base so typed accesses remain aligned while scatterlist regions stay on
> cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D8

