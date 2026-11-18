Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009965;
	b=VG8q2XzutAVhYxuvl5f8FvIpKzqs6/2AmII60X0a+U9zy3H6cB7u1MSQ0ei1Webvlyj1
	 CrOyQTzjNccB5GHi4F8oOgyQeCold43wY4fbLqL+WxJxsFwMgdpg2XomVgdokklaVe/Uq
	 tXix3LKcr4MuOHBsrYo5Lvz8rV085lLICP7ND341Dd8yH7ywwbcG3i+gXMnUeuwyDrhGI
	 VIyewtzDMahZyTAYJT71aJ4ajjCCSgc29J5Rf44XFsWUGxj+TcfeNGf4S25hrlwYsSfKi
	 ph63qsC4VZA9PP+2JOnbP3mdQJmAh5WZf9F6ebD7rRRuTX1HRbWekLqy5c4ZRe7tLpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NY5qaD5WDLuf3Irs6N5ax+zI5cCgavhPaEnO6j6gc7I=;
	b=wuuWhAVKWomQ1oEsGoCo+rMqlsX8kygCszGlqmUqxKSmmuUhMnfa7prR3X2aIlQdN1Bz
	 im+k4O6cn2QXg0S0PV5nxFJ0Zgq4Q7DxVcKxiPg6cu+1tKG4sGEhWdrKUrGeLuxJGRoNp
	 QAFhUStdVxU2EtXi6Y5e0webwt8BXaOnMgeYSi1UslhRfwjxaC/9xbehTf/iJLCnIgoEP
	 1q7/QdMgSNQXifiVpND8rZ+brAbTCtp/GHgyfsu1s8pM8YXAks140FJ0pYgNihHeQht6y
	 bDi3pNf4oRALATHF21B+myW6lFiKc9g05SsIYq7hbam4xP4vkI/lgGRaT7SCUpW5bAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RC2Eg8Mw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C910606A32A;
	Wed, 18 Nov 2026 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RC2Eg8Mw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22E61F000C4;
	Wed, 18 Nov 2026 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009965;
	bh=NY5qaD5WDLuf3Irs6N5ax+zI5cCgavhPaEnO6j6gc7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RC2Eg8MwWBgiE9RWDMfPXzoyX3LJEuszv5RmS0YP0UGwPnr1YcHXy0kxsjXcIZXxH
	 UnaM+1RqAYE4M/dFGMcCB6hp9Da6OGHqzvQvauD6v0n7HF0sEGF4VbrJlDtLxdRbSl
	 ON9bIFILA+4rLzBOmGsKT2GDXwVQn1sWBASYDtm+zdRGqX+ooO800b2JBEdGn4fYDB
	 k+Eo+RP8/xq1nTWITQfIIeyFVUe4Nb1kTAgf39PO8ZtNt1tXIlv1xjLrFxbFsFRcF1
	 sex0WwV1INaK3wDEXgyDqdYkzR8f0rfVqThh8IYAUp16uKJI1WKJ3vZO5ZE1zYdLC/
	 bWowNQ7G4xWXg==
Message-ID: <sashiko-outbox-221091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Stanner" <phasta@kernel.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261118134522.1646892-3-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
 <20261118134522.1646892-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 13:52:44 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118134522.1646=
892-2-phasta@kernel.org?part=3D1

