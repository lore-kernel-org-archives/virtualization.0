Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752522;
	b=Xav6JWwXZiDia9jLh4qU+AUQBlWvSnEWJokIxrVo1jqvDGsSZ+8A3m+vhRi+pheqlxII
	 O7xrcXC2s6mXTwT1wjc0i7IYHz1Ioe10f0eS5EAWdLcySeey78DiQHvp/GEHh+Y3USaFv
	 zNFABF6/jZiASqiN+ojAdAdOTOE0dA4uTxoiB4HV4IhxJJrsCqG0MydLcUFyYroZGxQT6
	 tFs6hQhZJlEorUdTgah5RYLWCvSUOtRHg1Rv5xiObcXarDqaBxRwPfETTYMPIuIln+o+0
	 WkkMpc7//oivJ49dX6nomc9n4gR0Ll5ho+R5AuynzffeJUJY+RNQHgxKPCLHmQvZVOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752522;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4nYWT53yKN2cPUeGzZsS6CaMr4WQ719DCqDhnxRkcWc=;
	b=w/N1+laZ1n+JaBO8hq3WHWpaEz3Ape4z55TdKBPe2A0fByPTSUBjlAEGpcBaRdtOw5X0
	 crqSkgl2CMTKVGyR/yyU/UFV2iMfUqCQPXM1GAMExySfD07TiPh6SZjNqvrtdsubU3Av1
	 b24wSCdlB5hu+pdsJ2Te+7EUwsOO4StwHnQqnTJgOcJSN/nAnqvwPBeinq8IeLsNH4Gou
	 hHMqh6q+cwwIcaHEDqdUWPEktwyaQyzYVP537y783ZzWx1lZnj6dY+WkhDwSK3K+cHwJS
	 DmjNTs/UaJ4aau18iMw3s+XGwBTG7pcj3uQ41nLlTHlkFFUAIlt7zqITxHSgDim0Lsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8VwXCBe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34283606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8VwXCBe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968341F01825;
	Fri, 23 Oct 2026 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792752521;
	bh=4nYWT53yKN2cPUeGzZsS6CaMr4WQ719DCqDhnxRkcWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8VwXCBe//4rDJhvedbXVAVidgOrR01b9WDrhU577plpCW/gCriaIV+nrDiZSKS+T
	 WSSSQAy2z3DF4osrKV6I9oK75sBSANZxqyVANYcNGtHANA2VaPPSppjM8K3ZJ1+nl6
	 3mSEDmv5z+/pxbkUG8bschiR7TBKRCSsm4UTkEVyjqLki3saBVtp7zSCJUXDF5dwka
	 njRVEi49Fs4/wLFQ2eRWWLZD7tTRtHEec5AUk9Awr+Q8jmI8shzAZuWqSc7Oypjcp+
	 xQ/HpI1dev2+txXgkBvSVi4yb7shC/og0fwhmLijc7AMX6VnPkfZQoE86++WzbHdaX
	 NIEKNx0qriECw==
Message-ID: <sashiko-outbox-182705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost-scsi: fix page reference leak in misaligned
 I/O fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023104035.6686-1-physicalmtea@gmail.com>
References: <20261023104035.6686-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 10:48:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> iov_iter_get_pages2() returns a byte count that excludes the offset into
> the first page, but also returns a reference to that page in pages[].
>=20
> On the misaligned-I/O fallback, vhost_scsi_revert_map_iov_to_sgl() puts
> pages already added to the SG list. The cleanup loop starts at
> pages[npages], but accounts for its first page as PAGE_SIZE bytes
> rather than PAGE_SIZE - offset. If the remaining data starts at a
> non-zero offset, it can finish one page early and leave a page reference
> behind.
>=20
> Use PAGE_SIZE - offset for the first remaining page and clear offset for
> later pages, as in the mapping loop. Without this, each affected request
> leaks one page reference.
>=20
> Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023104035.6686=
-1-physicalmtea@gmail.com?part=3D1

