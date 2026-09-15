Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69897353A6E
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505554; cv=none; b=CcFIWdlThwCer6uQpF2jN0pp5ydJ80owMLGrEIKMeELyth9o8ueEpfFezax1DJ44AAX4F+KVNBnSQno6bMBTXHYB3TlSVp785mvsTZDlifkXjSvpzn1Mdk5AMcf9kyXkBk/lK+IxteS89SOA79C7wBpNtnyDS2tZ+5k+6geUAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505554; c=relaxed/simple;
	bh=LvOJuSWNTVKblsAq7L3pMxJVDKtxsnrx//WaKFaEacY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XEfo7rrzqTZXu+QP2CrHnxZIE1t/KarviZHb4FSd2hpfRm9c0V26+/HQRf9u4u3472iD8fdNmaAQsKsP6M0zYbS8AGVgn1Jr/UDzUTnWm9DkycLZZqObIKtcknZorIuospaEDvGt54X9Heb0nf2+629Dvlevh2pGfYo0eBWufYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDhSreka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDhSreka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD61F000FF;
	Tue, 15 Sep 2026 20:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789505553;
	bh=LvOJuSWNTVKblsAq7L3pMxJVDKtxsnrx//WaKFaEacY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDhSrekaS1XAoLm2e0R5+9Kep4y9KCc38q0sub/1WZrfwuR2X+79HDSjlGPhpm+Tv
	 yVJfGboVkdErrXq0BTqUuGtMwNGO8p2h37yDoI6xMMuv+SsfEcdDicZd1W8PWY7KBR
	 6S5V+0/SeNe1Mvqo9wVs7fWkEeTIPbypabZwM35UIpItOzA3A6uzgGRyItH6SvT/rg
	 CBv4nhrYnCWDUmssIfXcQxr7eX2SPp7c2xy02ycby4GrC/UL9o9WnXjjHmRv6zP2Im
	 kl/HkBVVAFaAle4EiLqjCt1C6p9DrQJHcAVKyJVquX3aOGm8OydvKB7Dlmxq/WyqkU
	 zAkT3IzGiUG9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] spi: virtio: drop unused field from private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260915-virtio-spi-fix2-v1-2-7a474cb1b13b@valla.it>
References: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
 <20260915-virtio-spi-fix2-v1-2-7a474cb1b13b@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 20:52:32 +0000
Message-Id: <20260915205232.97DD61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The mode_func_supported field is read from the config space into the
> driver's private data, but then never used outside of the function it is
> read in. Drop the variable from the private data and parse it from the
> stack instead.
>=20
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-virtio-spi=
-fix2-v1-0-7a474cb1b13b@valla.it?part=3D2

