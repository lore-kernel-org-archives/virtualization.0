Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032408;
	b=R8NinDgrDzgM8NiSdZic/rneOpIuOzyGLxUk8vBbl2XoSAKQt8VXtphcgFMZ26h4KdpF
	 x+QHMfiX8mFlQuUF2PDAdn9otYPNr6sASDkqEhU0C4VLfX4/V+goMLtrG3uzc+K+SgvV+
	 gXxuSTqruVX/d+5BEwlj2nqWjAr+3l/+6Hp5vF72qFHFkAyjZeWIv7KZ3jm1k7mKIMeRg
	 y1VY+6LMvUDrvlU31YEsNWp4PewX1siyu6bV8cSZfqMYF7JVVhjNKSPFqcyUVxNI9YruP
	 HsIDByV/SWcJU/c7fUbJBdz1Fa3shL6gESdSPr3lbtEFD7IeLcapiFqJ9oXymYwKBag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0v5nBlQ/cOk7jHMT0UQD5uVObxFZfSR4bxs2YX2YBgU=;
	b=SdyPqXyrJmdH9W1u/c4Mh9KTlFBcwwIXXtzTiPJExfcRUlUERg5HbnVFBD1v6HdDlXEv
	 G30HgWjh+0T1vy/eNy2cAm+0gumB1DNP6MdtSIrfgw6fB388/za/ZrYGx0uJ1OC2mxPrB
	 Gg4l5Bm+9r2VKl8O434n+hQKl+XqvpV9x8dp95CDxzNedsK4d0F2WN4uySgLd0DHuGtul
	 dFZ/Wqv79Fenf1ANMKfNNpgHkr4gnQFzonxVge8i0enO4D81zNKX6rjM7SaSvdO63ijVf
	 tQOATgsWcAqcoZGQJXV0e1rJEeH3vaIog5xDmfNpy1zu7oFtUwfHjVfMYYrybnxdxfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEKrbP9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA2606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEKrbP9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58311F01825;
	Mon, 26 Oct 2026 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032408;
	bh=0v5nBlQ/cOk7jHMT0UQD5uVObxFZfSR4bxs2YX2YBgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FEKrbP9pnrG4GiaOWg4hv8zengtzyGOCw3NPBeJ/ut6/ZTf4Pli6vVI3sx5Ka1tnZ
	 7vW5HYA6rODF/ZQ793DnQsTbjgcCuFwBIBNU1AESf41J6Ua0WJqhze6HOghr9jWpxw
	 idWvuHsQrgV/mcP5iu7TehSGmA8wF0u81GD2skTpYplVZOrxnKBcETa3102x2ckx5N
	 HGb2evu4lItZE4qmdmdwzHNRaolGGlTLdPRxEj7YoRR75Hqf3Oqk038kCKe0iC5POE
	 pmd0szCYg5mS1D1+Add8f0UwbD8WAJX/5HhXa021z9gb/O7a89axQcRutOn0ZXgTg5
	 VvKrohxoL9yKA==
Message-ID: <sashiko-outbox-185536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/22] gpio: Unify style of various *_device_id
 arrays
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <7a3aad753cd5bebe6dd3f05d72edff398920d1f6.1793030820.git.u.kleine-koenig@baylibre.com>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
 <7a3aad753cd5bebe6dd3f05d72edff398920d1f6.1793030820.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:33:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Update the various *_device_id arrays to conform to the most used and
> generally recommended coding style. That is:
>=20
>  - no comma after the list terminator;
>  - a comma after an initializer if (and only if) the closing } is not
>    directly following;
>  - no explicit zeros in the list terminator;
>  - a space after an opening { and before a closing }, a single space in
>    the list terminator;
>=20
> Adapt the few offenders accordingly.
>=20
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793030820.gi=
t.u.kleine-koenig@baylibre.com?part=3D22

