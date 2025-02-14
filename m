Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED182260A47
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531669; cv=none; b=BWa7jUyPKnFgjxUFcjZ4GuKNrJ+UxV+DtE7+YiOjUMhFQ/Q1YGC1PVyHcwWv2/UJPVrcp9oVSSWQl0/Nh9wTNdca/U4KJ4/tvh2X+R9vLEijdjvtupoHjMb1vR648FE8bj6+1OovlprPvEsufWOqj8vaFWIrFbJQsFUrHW2CgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531669; c=relaxed/simple;
	bh=/+a0dDBN3Dzf9HiKDiSAuhwulCLdTInLVhDdp3sMloU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+dREPWSYxHwawLEr3dJsMSfRpjcXa6HFxxxYn/g0QbfSBb90+/HDfCRwXrHC+dC8sLQJ4yMAYUkGDmaWMl9tpFvfAT5VK+l6WUFd/sUHnULtpDfhYqnLZK1dk09XFplq/Z2PNazltVvhyjqhliasrEqPAh/4qQdRvihMGk0yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UFdjajNi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UFdjajNi"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1282051f8f.0
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 03:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739531665; x=1740136465; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5HZRptVwo1kZfc37SaJTjO4C2pKRjpW6kvADFRJRxY=;
        b=UFdjajNithmevsXBOTuPQqQbYztQBQPcrRQbPL9Y8AOVNKc3CWsq6DGUSGOQy+Kj2/
         63WL8Kxb9dzrcu6Qrq13aU6hsnOZSBQYT/K07Z48ug6tzkkslBjwIHoaR3dBuMykSZJq
         sAqqMhztWs7nHlaZYBoUvXlkLh/SmgEnk4gTH/a2WZYTiaH4VAkrcRtHvvJi7K0+Yo+H
         k8re+sLV4iLtNK+9nKMmpLoHcQK/6VxyJlpj5RosELFKCAI1fq5nV4MeduhmEd4UiuMg
         iR6pOu7OJKIbHaiSNqkTxl2leRd1hHwoUqUth5QrYGhppIg27vDLktDtaXPuMdMgeSbI
         uPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531665; x=1740136465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5HZRptVwo1kZfc37SaJTjO4C2pKRjpW6kvADFRJRxY=;
        b=Wd7c8OexVNZ3wIG0SW7/AjP0OlhOZdYDwAhxo/kEUbcTJXIU1X5v+8Wb6aQ9jx1Kx4
         ASQRA3iW3Vb75F6LQkHZOLg/EMOghYlkWnhZm5vG0j+4ouos3ritIwR0KZ6r03QbJt5p
         0cUd6Itb8FfpNrNqtvStF9ZqPq94P9YxqqLKOHuovfjBVfzzzr3kkUkmMx4N/AxwCozl
         hUscjP2+72TutkMMVZwqCZwOyBVFcfDSIVSd4UKUwDM7v7+wvrt7RTgBzJf36U90Vln9
         HmFHjwhdPOp9Vzn1SyEpXXIThuGEPm2UP2aynTv/OpJdAaASDeIdhMQjeW2D65rirw2E
         lnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeNudlf4uOm6Pr2gM5rRmir6d3IYZlKUxg/rbaZ0f1agTEaOjhMGSpor0YGaagMKxp0qCnj/xmsPHQoZmz2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJqTH3I+czQ93kPanV71IpIKmWacgSeTaoWbK/E+QJsCDvyThL
	V408eiU9qsZT6lcgSNZRlRSyBH1BWrdbVMVRhRAUsPwtNWqx0ISyLg1/3rnk6wQ=
X-Gm-Gg: ASbGncuMecXAfZFtMxuXLslZhZdeBLr5xHX+Q9fzjm5jpYymxDbvN7IpxyHgWzr8OqO
	Jqcy04iCj4x3UUunW7HPpKkiA8O1omZcGdcjNWq/R72PufFwF857rU6iMuzP6M61fiPPuFh9x/H
	QZDZT/MYf4kRwqcSIdb77R7/kH95tHGumdP1fKtZgajhe+z88eLjDB0QWHmk+E9nxOYiOA+s54e
	QVEKERpYipcu+WB9fYtgeiEUXFaBERxJbl8li41iZnbw1R5BZZzH4GCF2zH3vux7VeAnqNHwPnz
	pFx9Aldel1PYmxRYCE5HYZlK6FRp6YDDADnZR6/h+w1WRysb7KIaS5dkjw==
X-Google-Smtp-Source: AGHT+IGhliTXVNeRfrHTSy6hBKPYnfviLsTWydLXmYdaqLmpgylUt5q4O9xtV5B7+Y1DWpO0kchKsw==
X-Received: by 2002:a5d:5f82:0:b0:38f:3009:61c1 with SMTP id ffacd0b85a97d-38f30096290mr1498623f8f.26.1739531663571;
        Fri, 14 Feb 2025 03:14:23 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm4396579f8f.67.2025.02.14.03.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:14:22 -0800 (PST)
Date: Fri, 14 Feb 2025 12:14:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzgr4aiedgk6nxy7"
Content-Disposition: inline
In-Reply-To: <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>


--hzgr4aiedgk6nxy7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

Hello Amit,

On Fri, Feb 14, 2025 at 11:58:44AM +0100, Amit Shah wrote:
> On Thu, 2025-02-13 at 12:55 +0100, Uwe Kleine-K=F6nig wrote:
> > virtio_console.c can make use of REMOTEPROC. Therefore it has several
> > tests evaluating
> >=20
> > 	IS_ENABLED(CONFIG_REMOTEPROC)
> >=20
> > . This currently only does the right thing because CONFIG_REMOTEPROC
> > cannot be modular. Otherwise the configuration
> >=20
> > 	CONFIG_REMOTEPROC=3Dm
> > 	CONFIG_VIRTIO_CONSOLE=3Dy
> >=20
> > would result in a build failure because then
> > IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the built-
> > in
> > virtio_console.o must not use symbols from the remoteproc module.
> >=20
> > To prepare for making REMOTEPROC modular change the tests to use
> > IS_REACHABLE() instead of IS_ENABLED() which copes correctly for the
> > above case as it evaluates to false then.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> > Hello,
> >=20
> > I didn't check what else needs to be done to make CONFIG_REMOTEPROC
> > tristate but even if it stays a bool using IS_REACHABLE() is still
> > the
> > better choice.
>=20
> It might lead to a false sense of "better" -- the value of IS_ENABLED
> is cached in a variable which is determined at compile-time.

Either I don't understand what you mean, or this is wrong.

	$ make allmodconfig drivers/char/virtio_console.i
	$ grep CONFIG_REMOTEPROC=3D .config
	CONFIG_REMOTEPROC=3Dm
	$ cat drivers/char/virtio_console.i
	...
	static bool is_rproc_serial(const struct virtio_device *vdev)
	{
	 return 1 && vdev->id.device =3D=3D 11;
	}
	...

so is_rproc_enabled is still constant and known at compile time.

> That
> caching, after this change, moves to driver init-time.  If the rproc
> module is loaded after virtio-console is initialized, there's no way
> it's going to be used.

If both are modular, modprobe should make sure that rproc is ready
before virtio-console. If virtio-console is builtin and rproc is
modular, IS_REACHABLE(CONFIG_REMOTEPROC) evaluates to false and so rproc
won't be used. (As is the case already today with CONFIG_REMOTEPROC=3Dn).

> Only if the rproc module is loaded before
> virtio-console will the rproc functionality be used -- which means that
> nothing changed in reality..

With that patch indeed nothing changed yet, because CONFIG_REMOTEPROC
cannot be =3Dm today. Until this changes IS_REACHABLE() and IS_ENABLED()
are equivalent.
=20
> To properly detect and use rproc if available would need the rproc
> initialization out of virtcons_probe() and into something that happens
> either via sysfs for existing ports, or when adding a new port to a
> device.  However, the current spec doesn't allow for that, so some more
> changes will need to be made to ensure current backwards compat, and a
> new specification that allows for a late init of rproc.

I didn't understand that and hope it's irrelevant with the things I
wrote above.

Best regards
Uwe

--hzgr4aiedgk6nxy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmevJYsACgkQj4D7WH0S
/k6KUQf/aA9uO96t2pGocJZnHU//2K0WSVxG4nFOMYKCKjAZdGghi/epov61HPSE
a8HbMZohKmePEKsEcdXh6fXq/6hkoYTxBSgmEl7SdHHNCOhMv6Qk2rogifehfB0d
M2vPFvtDUK+vKVEADfSTcEafuZYqNgwonVEL4ljvs25esvLg+fHzXfN79tJXDI8b
VxBZQwI6sqmlSBE3FRzCw+pkSXmvm4QffPBiraBVI/bJqso13JsTjZYahpJMuNjM
/foOvmwioAehcpaDksZhfNw2llNVbI/aEv75wdWkJc4SHYwcToQkhSIBGZuAHJQY
43jU7Wbn96BE5dJS1zWn6wZsKq5vCg==
=FmCn
-----END PGP SIGNATURE-----

--hzgr4aiedgk6nxy7--
