Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176208;
	b=ZRw56UdQb5XYronz2ueNFppabOLvkMN+eLaEJLlZtZUfoABzVP4pWQYuOtAhCQgUnDd9
	 jjqjw5kO0+dKMDFJxytf5pyJXfL0bO/vj5efhibdLDc0+GlQa0+P6+hQp8irtF/2lVJo5
	 WOaZ8X92QFa3DxF2YY0cufTVs8mUvIk1hsctug3dtRdZY80VfbFWk2aKjxGUO0A32jrti
	 rF34NVqkfoqtNBpdq5cEf/4PyFCrVJ/CbD0wEpG4W1y7vSM3kXJxk43/LYCrdw/jPeQBr
	 ctPrPDe7vXNUgde/SifnV0V7CMA6teaeqwSWypWXS6/wn9cThwHT9beWLvNvIudKP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zpddY1H8oUvRQZIe/nwgRT++a2FonQBpRI3Q6+R0J2g=;
	b=FoWPxv6svpi8MIOhndTWWu7h4oiHXdAGlZdih9Cmhab2iPDuQc4Y1CUuW3PKVRwu0dps
	 ZT/DTjpHenh3G0jOmH4WMjvVB3Zh04a1vzkJmfmaq4eHUKOvABByvM7iNCHCy8OmnmjGy
	 +HxN6wd+yCHyrjowLR7VkuybKgJqsy1SsVPTUQY3z1NprLb2eovbr4Mt9wczAZTyU+Ohk
	 mIHf6aAk5ONrPp1j9PYWkm4qOIXe4e/zdbTYziQIVjTu7ClFhbP7pUCPxaQ4vLtWypbX1
	 ghuWgx9FzywapX4wTJyAYx+GmjYveGGc1cFMdOmCLOgcNiIP1KgU5u0XZ4yUJ5yTvZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cwimyrup;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA7606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cwimyrup
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775471F000C6;
	Fri, 20 Nov 2026 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176207;
	bh=zpddY1H8oUvRQZIe/nwgRT++a2FonQBpRI3Q6+R0J2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cwimyrup4ufurnPxVZuRHl07b1hZ6GyTIXqsoFnoY+W7y/R4tpT/ZkPV6Ox5LVdUL
	 w0Tyv9fnjDNAutTdr5eMomVU+m7bLIQanmvqA8cidAAQFV+9W+9GOHSOG/gbXZR3po
	 ckwFEcBUoi6mrryXUfwBm3FiqXIKa3KCQHdCSWZizKnW1vO+luceA2pHiM9m49DngL
	 e/k07GOGSBs3cx/sH9Az3vba6YfXRNwRkICCsCqt6zS0K1ArYm9kpIt7pUy+7BxGST
	 JcULoHjvvq4FJkp5mALvbx2nA//8UMKaOmdtV5PpTSGvpOi+q5PuIv04Ur67D8w0QL
	 yPFHS6uOWybVw==
Message-ID: <sashiko-outbox-225113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/7] mm: skip zeroing of pre-zeroed order-0 user
 pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <73917d7bc27d763dbcdd2044d311acaf452144a0.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
 <73917d7bc27d763dbcdd2044d311acaf452144a0.1795089715.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:03:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Skip initialization for order-0 PG_zeroed folios.
>=20
> For the generic vma_alloc_zeroed_movable_folio(), skip clearing known-zero
> contents and unpoison KMSAN metadata.
>=20
> On x86, vma_alloc_zeroed_movable_folio() requests __GFP_ZERO, so check
> PageZeroed() in post_alloc_hook() to cover that.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795089715.gi=
t.mst@redhat.com?part=3D4

