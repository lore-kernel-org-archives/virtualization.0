Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484195;
	b=IfQ20jyxI7pmY6LUpcKmiJtddhopY2x3etB16w6LsYPKrmFqx9WRuBkH6f5KmleaqqJy
	 ifKzhLVmSKVpwDj8VYBgBNqunr1xQoLgZhG1j/NzAhIOTofgX+IPsTnnodScdKg51cQUS
	 v+68zdNb+1jvJxlkCQ6O93HoPqPPuzwanXNS+JPiTJpQzAeMv0E+KfWpTuEVpDAbvbpzd
	 zv+qVa7zqvBH0aXKQ7JpZJ2ovfwoHkNhUhjRevYfvxNwYdHKFw6m42DAD7L7eyHkdSnxS
	 brO+oqXEqNTEEIUUvJKqMYNT/IQpaExTjxJeOOHmZ5v/WehP7ut6Qh1c5HEhZHNcuJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uJGkr/RxeLRrEPw0ccmReaRnPeHz5UFoDbhHCZZ1RHw=;
	b=sVLf5A04P+r8ACfGq8OnepqI1AzfBncnQGgKrWbWny84aj2wz9/O1oQjiHb/tqd0/kqu
	 HJAsT9+/BuZhpv5NOz2aHIZ5dPvBeXA9V/q3hnmI8rjR18ObVxoXpuEm4YMkLa9SNw17f
	 /iKiHQPlf7I5ZExF2CMHbj/GbD9uEU0vmFT8va5xk5mdUk40YteiAP5AI7LPSJfAFvk/O
	 gDQilT83WKuE6/T/gJysut8n4y7ycAlGah9rXzKrHfW5MVOJz8j1z7IBdzVPGgk68+kY1
	 +qGe2XsQmBJgDW3VacAmr9PuHr6gcbkaXUbBcFFrSWz2F5tbedCnq+6BfEEPDgNHiwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkgO3EVQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957E606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkgO3EVQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08911F000C4;
	Tue, 20 Oct 2026 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484194;
	bh=uJGkr/RxeLRrEPw0ccmReaRnPeHz5UFoDbhHCZZ1RHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JkgO3EVQnEx8nuynuQ6vG5wjpSvkLx5zeub6aDGDBM/fCNvmnbExwiiyEtcn07Spw
	 6Gs/aFmkWq46gEiDWzRrngeYEyq0ubIDbyjDP8hNSKZN9dLTKZM15/1Mx0q3Nl2Smk
	 FrgnedCXuKK5FI28XFdPKlHa1C6A3GDtQJ9l/OTpFo8FxbgKGKwr+dI7GafKyxb2M9
	 lXdmDoRUrGh+jswH1dGBMEU7uHuBUSA+kZ+nWXuBtkjje8+YSC1EKWLBSkErRdqjs+
	 GmJvSflH1lMTc4FirAeHcjdbboquS3azetl6APNcGL6YD4QVNFh+VaocCNw4apGW4y
	 Zw+quBpHt3peg==
Message-ID: <sashiko-outbox-178506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tools/virtio: add a shim for
 linux/device-id/virtio.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TGlhbSBSLiBIb3dsZXR0IChHb29nbGUp?= <liam@infradead.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020032958.1930203-2-liam@infradead.org>
References: <20261020032958.1930203-1-liam@infradead.org>
 <20261020032958.1930203-2-liam@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:16:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> include/linux/virtio.h takes struct virtio_device_id from
> <linux/device-id/virtio.h>, which the tools build cannot find.
>=20
> Add a shim for it beside the others, pointing at the real header.
>=20
> Fixes: ecca1d63c1ea ("Replace <linux/mod_devicetable.h> by more specific =
<linux/device-id/*.h> (headers)")
> Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020032958.1930=
203-1-liam@infradead.org?part=3D1

