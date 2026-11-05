Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879694;
	b=sU1iMrHq5cMSyfNQPZY/KpyiJiJKMbbxEmToIqMa6t62+yZDLBxu2tBJZzkf8tC46wq8
	 1cb1hy0gkcyrIKV18HxPWeOfaOPcVzUDL3sP7A8xGMSsao9KR90QFbHs8bUJB2Y8jKvXV
	 2ydWUsMO76bNNyZIY6z/OPbdWvdtFrVPkgUJ65u73JUBQ7NG6Z5YK+o0arPQ2H4PdnZHT
	 90c8/JNqrHulMhHQA0zpeU9203bEq1AYpsGhAnMuQrq+SrGoitN4G5fQnu41fId2Oxdjo
	 lQorUbDoXsJeoQTHxYOb+I45y9yi20yZmM0iIjiiRj/aR0cN/poKJg/v7knGIQGu03w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879694;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q2rA5jlFQ5oNsOaWrAqPmh3Zn9uZ0TYXSfi1U3ODhsI=;
	b=msHYM6HJxNFQFKEhTDHDnbIfFqNGvjQRdAZqXT/GNs8wotz9A4KZpU2kgVuLDXeg/dTz
	 ry6Kmdk90PNZVvXrmjtDcxLhML+f5vGHj823Yj2RdNhDFg6/aj+kWzET1+mnUKsc3cIbS
	 LP0D38Alt42TKiPotootknb2nMo1XKIH/p4oNdQtryp8zYFRsycSfwuqpTuJUw76BraHr
	 vrQNuhUJrAYCRp7E52njsswDzoJBvBr9Riuki2D6AeXr2xlgBBuXWwUHK1ED1OH+MmA+y
	 SHswtM0jJQxrLBJcQyTUi8h56+9MGRPe0n+whVFzvQ5R8LfdWBG7KSn0KV4p7eoToLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irbXjNOU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A5606A32C;
	Thu,  5 Nov 2026 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irbXjNOU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F20E1F000C1;
	Thu,  5 Nov 2026 11:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879693;
	bh=q2rA5jlFQ5oNsOaWrAqPmh3Zn9uZ0TYXSfi1U3ODhsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=irbXjNOUiDpWM9K5MGVhu+lJ0fAsf+DYJcX6K7KmaDnI7a1yvkgd+I83Ccom4bgwp
	 PWpmPQsig0YH7XK4tNcBt3rmi1TLL+MT6IuK8qmAVH8eXH4IvlKGuN7gRWmA3CsPzL
	 F7inMghQj5QsEOghu/f1muMQb+N3HXRnV1e20PXXd/Gjm1GoF02jJdvVOyDCFVOfE4
	 +gYUlNmZoPYVaSY+p7cVxhl4B2ECEBfah0RGFb6d9pjnZlwHyrVXOTZhE0fyt6eBOc
	 TcXj2hHJ2Vv2ZW7SHQygEC5lbaC+e7KIUV4tPpwpUkkuJgIIwmXQjiuW+X6qHIEgCY
	 WUHNdxX9zjWhg==
Message-ID: <sashiko-outbox-198976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Stanner" <phasta@kernel.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261105113529.1989375-3-phasta@kernel.org>
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:54:53 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Currently, there are two init functions for dma_fence, dma_fence_init()
> and dma_fence_init64().
>=20
> Since more future user options for dma_fence initialization would
> require distinct init functions, too, it is better to do this in a
> unified way.
>=20
> Add a flags field to dma_fence_init(). Adjust all affected drivers,
> preserving the old behavior.
>=20
> Support the SEQNO64 flag, and add a check-function so that the user only
> sets valid bits.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105113529.1989=
375-2-phasta@kernel.org?part=3D1

