Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FC2673A5
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549634; cv=none; b=QZmFXKm6KGtGTmtAT87aoGE52R8/PrpfMU1y9UgTOH864vEyzsPjs7sVju/PZ848uTWtZPDxxh6Qqr8DrLZft03rIaKz4+vJsetWYwd+WeOeNGLO9RduXrPYuhc5t4SsQC+mEDMAsjSj+YM6kbVC3OUSxl7lcqQrmgVZbr5dVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549634; c=relaxed/simple;
	bh=5Cq2puqUbt7p8eb1Liza4srSylsA782g2EWTNazx6RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBBE6lEqEGmHlA7+5TAW3S9kfXwY5OYmOHmjygz8oxsrB0Gro+TzywEueaLfIJb5TZHSyPDs4+hy2V7SzY1dKJLLlpYa6fMz2wn9XkYMO6rj0dFeJmtEFyKoLy9g2BY4ESP4lIB5RiKI40cS788Zf1AWc7fdOE1ptiB8qnUZnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kZgY+PWt; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kZgY+PWt"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43690d4605dso14904865e9.0
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739549629; x=1740154429; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7s4xKwHi3JWHK99GmqV/eaV3Tj0T6uUs6iJnb9Y/Wg=;
        b=kZgY+PWtyIgQmrgvDu+3JLnDY4LXsX4lELhrbagVWLg+3E0mq4sf86sJnvX8swKvGj
         i8iGeDvhiTuN2rdOXkHoDiUdQXqbA1ZY1bkEmcPSea45jXo9Dcf+bmkBQ/+BJ78hxRR8
         5GSNpA1qBWtXboIK++phLDNy7e2/IGfWxaXlbHxOpH4raK0Jhasmsc36ZTCpYOzeeiMx
         eJIGbopx1SsewiKlb7QfwNu6UUowko1WWzQEw6vWA+ON24u9m1BS3fCDF3AI9/lEN4lR
         8nMfdKgDBo4ndldKwxs1x3T1uF8SxmJi3MMDGDsV2DIcggdmCrpaFysQaRxOkjxxFl1O
         EEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739549629; x=1740154429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7s4xKwHi3JWHK99GmqV/eaV3Tj0T6uUs6iJnb9Y/Wg=;
        b=YUS0ncXXwTgUDk4p1AjNP06+lHv+b8Zx/jrJfJbgBj5HLc1TrxMgDvs17WeGHnWw/4
         kvk0H2+2qXFtZqM/EVh4vOJwjEVPd4oCjPUmn8QS4pQGhnA1ZKm98ukWxZtwfdI4X6AV
         37xn6PpFOGn5ccNM9LDPqSVmQJfSYXgBDhLqPtzKCURQpt0uMKTsABWmbCgVkgtuhU79
         h4PQN8DqKpvlnKCzyGjoPP63UtIS8/ZZgp9KSfk7Vi3Jf6tqEihgJd+X1fOGvx5qBssX
         IVGmeIdGM++M0YCOYzSw5FLXZZ4O261+xtHuX2w3k0mGT5HXE00UpzfUmlJ/k792Eeej
         K2kA==
X-Forwarded-Encrypted: i=1; AJvYcCXYoh1HYdIjBjY5N7yJmxIRLzhADduIjOJYCXY9E+ARf9uyOhvJsxmhNCaRGRkgMmHCEBL1sqUGG8QVwdtGUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwouA8UpPOJYsrJfc4WvqzwYJFm+hW8tYA4hOayeOYGJ+TdN7qF
	JhOzcRYlkynh6Uo7J0fKFVn6+NA25ucGvtynK3znui5b3j5MN5D5dYgd6BFWNMU=
X-Gm-Gg: ASbGncupQQ7cQuDMY9nvFXjkFAADcL/xdUinhqqCyIRS3eeZ/xEHt6NyxDr51B9rwMn
	Q2usvxwuPMSa07oohgx1j+Zk9ALNPFlWJByonGUiONtDIwsnrQRD4XXW++4kehGtWqffM62MTY3
	W0Op+wJjiQB2f9uezogy8zUBUhjCZl/QHDwhmE2DLqzZS6lGTR4lUP1zc0WrD3W3Kvv7ri6gQgJ
	Kl64VbrOjVctjr2FygpS72dskD2aH+84WFStmfBJFwebVnUKDzSuKFUGGjwUp1Husvo+KEF6q78
	Sg4uWvt7M6MVjcvS9e1meC23ly/ybFBKE7IaUSOhM7xwt1XE+BcAxiBmGQ==
X-Google-Smtp-Source: AGHT+IHihWfHUqPQJ1KKE8UnWJbUvz30R0E+Y7ztpPEPIq4DHrLmg057hM7LfvgOZpQmTFyFOB4elg==
X-Received: by 2002:a05:600c:5110:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-43960185cf6mr114743125e9.12.1739549629117;
        Fri, 14 Feb 2025 08:13:49 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8602sm5117405f8f.94.2025.02.14.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:13:47 -0800 (PST)
Date: Fri, 14 Feb 2025 17:13:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfxyvzazdawba2s6"
Content-Disposition: inline
In-Reply-To: <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>


--lfxyvzazdawba2s6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

Hello Amit,

On Fri, Feb 14, 2025 at 02:32:16PM +0100, Amit Shah wrote:
> On Fri, 2025-02-14 at 12:14 +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Feb 14, 2025 at 11:58:44AM +0100, Amit Shah wrote:
> > > On Thu, 2025-02-13 at 12:55 +0100, Uwe Kleine-K=F6nig wrote:
> > > > virtio_console.c can make use of REMOTEPROC. Therefore it has
> > > > several
> > > > tests evaluating
> > > >=20
> > > > 	IS_ENABLED(CONFIG_REMOTEPROC)
> > > >=20
> > > > . This currently only does the right thing because
> > > > CONFIG_REMOTEPROC
> > > > cannot be modular. Otherwise the configuration
> > > >=20
> > > > 	CONFIG_REMOTEPROC=3Dm
> > > > 	CONFIG_VIRTIO_CONSOLE=3Dy
> > > >=20
> > > > would result in a build failure because then
> > > > IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the
> > > > built-
> > > > in
> > > > virtio_console.o must not use symbols from the remoteproc module.
> > > >=20
> > > > To prepare for making REMOTEPROC modular change the tests to use
> > > > IS_REACHABLE() instead of IS_ENABLED() which copes correctly for
> > > > the
> > > > above case as it evaluates to false then.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > > ---
> > > > Hello,
> > > >=20
> > > > I didn't check what else needs to be done to make
> > > > CONFIG_REMOTEPROC
> > > > tristate but even if it stays a bool using IS_REACHABLE() is
> > > > still
> > > > the
> > > > better choice.
> > >=20
> > > It might lead to a false sense of "better" -- the value of
> > > IS_ENABLED
> > > is cached in a variable which is determined at compile-time.
> >=20
> > Either I don't understand what you mean, or this is wrong.
> >=20
> > 	$ make allmodconfig drivers/char/virtio_console.i
> > 	$ grep CONFIG_REMOTEPROC=3D .config
> > 	CONFIG_REMOTEPROC=3Dm
> > 	$ cat drivers/char/virtio_console.i
> > 	...
> > 	static bool is_rproc_serial(const struct virtio_device
> > *vdev)
> > 	{
> > 	 return 1 && vdev->id.device =3D=3D 11;
> > 	}
> > 	...
> >=20
> >=20
> > so is_rproc_enabled is still constant and known at compile time.
>=20
> Well - so I was replying to your comment about what else is required.=20
> And if remoteproc becomes a module, this check will not happen at
> compile-time?

The code I quoted is with both CONFIG_REMOTEPROC=3Dm and
CONFIG_VIRTIO_CONSOLE=3Dm.

> In any case, the next bit is the more important one:
>=20
> > > That
> > > caching, after this change, moves to driver init-time.=A0 If the
> > > rproc
> > > module is loaded after virtio-console is initialized, there's no
> > > way
> > > it's going to be used.
> >=20
> > If both are modular, modprobe should make sure that rproc is ready
> > before virtio-console. If virtio-console is builtin and rproc is
> > modular, IS_REACHABLE(CONFIG_REMOTEPROC) evaluates to false and so
> > rproc
> > won't be used. (As is the case already today with
> > CONFIG_REMOTEPROC=3Dn).
> >=20
> > > Only if the rproc module is loaded before
> > > virtio-console will the rproc functionality be used -- which means
> > > that
> > > nothing changed in reality..
> >=20
> > With that patch indeed nothing changed yet, because CONFIG_REMOTEPROC
> > cannot be =3Dm today. Until this changes IS_REACHABLE() and
> > IS_ENABLED()
> > are equivalent.
> > =A0
> > > To properly detect and use rproc if available would need the rproc
> > > initialization out of virtcons_probe() and into something that
> > > happens
> > > either via sysfs for existing ports, or when adding a new port to a
> > > device.=A0 However, the current spec doesn't allow for that, so some
> > > more
> > > changes will need to be made to ensure current backwards compat,
> > > and a
> > > new specification that allows for a late init of rproc.
> >=20
> > I didn't understand that and hope it's irrelevant with the things I
> > wrote above.
>=20
> See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/char/virtio_console.c#n1993
>=20
> The device is configured at probe time on how it's going to be used -
> all that will have to be reworked for making the remoteproc driver
> tristate.
>
> So in essence, this patch isn't changing anything; but it's not helping
> the case you want to enable either.

I still don't understand. With both CONFIG_REMOTEPROC=3Dm and
CONFIG_VIRTIO_CONSOLE=3Dm the expression is_rproc_serial(vdev) will be
true iff vdev->id.device =3D=3D VIRTIO_ID_RPROC_SERIAL. (And with
CONFIG_REMOTEPROC=3Dm and CONFIG_VIRTIO_CONSOLE=3Dy it will be 0.)

Both IS_ENABLED(CONFIG_REMOTEPROC) and IS_REACHABLE(CONFIG_REMOTEPROC)
evaluate to constants known at compile time.

So the device is still configured at probe time on how it's going to be
used and I don't see what needs to be reworked.

If you're still convinced there is something broken, would you please
point out in which case (CONFIG_REMOTEPROC=3D?, CONFIG_VIRTIO_CONSOLE=3D?)
something broken happens, and what this is?

Best regards
Uwe

--lfxyvzazdawba2s6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeva64ACgkQj4D7WH0S
/k4Kfwf/aTGJ+S09I41QPe3OqC4OGbekR2zOy237C7qE424gBH7TEl2oJDjCSZ+n
nsRoEUfYOl6g7l4FfkA6/UB32LtXeayMKGg1SjmOSMXy1olGq+1cF8WOaK5u2+S/
7FBnnmkg8jthoT6MY4pI+maokvR9HmfPdcmv2knpcMMXRwwHXsvlqaWaKpQbqC66
c7ELz4kO5f09eMz/y5U7qbv3fyEJYfGy1+HpiFv/+e6PJJ1mgSLYYE/Kh8TonXFg
7LTE3yvWCWqdheKa01qWN76v1TV7E0k/tQ+keBEI5Ctypg6FB+GgImZnqNjQNf3z
jOw9Cx8qkE5xh9rabsFevrA9jiIfSQ==
=tY2l
-----END PGP SIGNATURE-----

--lfxyvzazdawba2s6--
