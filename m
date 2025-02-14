Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39226738A;
	Fri, 14 Feb 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551077; cv=none; b=Dp8l7vO0NWiKycQsBjx0/DiQyLgTXaNVwRCnabTd9Hzjd8ie5B7njVnr/Ib0GJVC6cI5n6FMvtxjMztaZVIlkE7qj4ynW47A2CEd48DK7W5uu8BK2YPcLImIYZy0HgU4BobCh5M23ktTgqImrCxkA4plp1eFL/uAcW6u5kuEtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551077; c=relaxed/simple;
	bh=KiKL/xIX5dcHtY7ElUptgVYlfiudLi1KrIxonsHKQB8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldb43+/Cvq+ivlrx0UtWB17dtUKtGNoiIIzpDJit61CELsXk0gHG/GDd+I9peTKsQRlv7ahaXcEUk/cVxt9hlnQNLPCWn8j99bcEvctc+0vdgaZD50erwgTXzwjZssVufi2Z75//9NVpYroTvm7p79372U/nX1suWpGh765WoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu0ajA65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu0ajA65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876D3C4CED1;
	Fri, 14 Feb 2025 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739551075;
	bh=KiKL/xIX5dcHtY7ElUptgVYlfiudLi1KrIxonsHKQB8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qu0ajA65JrVFcJ1WGK7YQl0OfzfKniSez+sfxm2Ibtn/EHmDvpb1+U07phemTC8jH
	 w+7bWlFydfRQB8IpKMXu4+6Iek9mvmQuhPP5N2Xdt//zWbJQ6ZUAapPmjyjdlR64t/
	 iF7cBZdHqWzytoemv2g4Hc3tlc3tIplKs40EVv0ursppGXsUA33M5IgmAL+0vaWrV3
	 64sU5pFKncO3DDJUYpQUTyPY7zJh4uH4KbaKfndfSqjKiF8ZvonhwzUDYghtNSEjMZ
	 lxQtXFIEdWXpgXdnuZ7RUC6ZJuqw/GY21Aset1Dk/1RxHajVa1S0Y0PIY6PYoCxRQp
	 4j0/p6ANS6oHw==
Message-ID: <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
From: Amit Shah <amit@kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 17:37:52 +0100
In-Reply-To: <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
	 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
	 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
	 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
	 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2025-02-14 at 17:13 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Amit,
>=20
> On Fri, Feb 14, 2025 at 02:32:16PM +0100, Amit Shah wrote:
> > On Fri, 2025-02-14 at 12:14 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Feb 14, 2025 at 11:58:44AM +0100, Amit Shah wrote:
> > > > On Thu, 2025-02-13 at 12:55 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > > virtio_console.c can make use of REMOTEPROC. Therefore it has
> > > > > several
> > > > > tests evaluating
> > > > >=20
> > > > > 	IS_ENABLED(CONFIG_REMOTEPROC)
> > > > >=20
> > > > > . This currently only does the right thing because
> > > > > CONFIG_REMOTEPROC
> > > > > cannot be modular. Otherwise the configuration
> > > > >=20
> > > > > 	CONFIG_REMOTEPROC=3Dm
> > > > > 	CONFIG_VIRTIO_CONSOLE=3Dy
> > > > >=20
> > > > > would result in a build failure because then
> > > > > IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the
> > > > > built-
> > > > > in
> > > > > virtio_console.o must not use symbols from the remoteproc
> > > > > module.
> > > > >=20
> > > > > To prepare for making REMOTEPROC modular change the tests to
> > > > > use
> > > > > IS_REACHABLE() instead of IS_ENABLED() which copes correctly
> > > > > for
> > > > > the
> > > > > above case as it evaluates to false then.
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@baylibre.com>
> > > > > ---
> > > > > Hello,
> > > > >=20
> > > > > I didn't check what else needs to be done to make
> > > > > CONFIG_REMOTEPROC
> > > > > tristate but even if it stays a bool using IS_REACHABLE() is
> > > > > still
> > > > > the
> > > > > better choice.
> > > >=20
> > > > It might lead to a false sense of "better" -- the value of
> > > > IS_ENABLED
> > > > is cached in a variable which is determined at compile-time.
> > >=20
> > > Either I don't understand what you mean, or this is wrong.
> > >=20
> > > 	$ make allmodconfig drivers/char/virtio_console.i
> > > 	$ grep CONFIG_REMOTEPROC=3D .config
> > > 	CONFIG_REMOTEPROC=3Dm
> > > 	$ cat drivers/char/virtio_console.i
> > > 	...
> > > 	static bool is_rproc_serial(const struct virtio_device
> > > *vdev)
> > > 	{
> > > 	 return 1 && vdev->id.device =3D=3D 11;
> > > 	}
> > > 	...
> > >=20
> > >=20
> > > so is_rproc_enabled is still constant and known at compile time.
> >=20
> > Well - so I was replying to your comment about what else is
> > required.=20
> > And if remoteproc becomes a module, this check will not happen at
> > compile-time?
>=20
> The code I quoted is with both CONFIG_REMOTEPROC=3Dm and
> CONFIG_VIRTIO_CONSOLE=3Dm.
>=20
> > In any case, the next bit is the more important one:
> >=20
> > > > That
> > > > caching, after this change, moves to driver init-time.=C2=A0 If the
> > > > rproc
> > > > module is loaded after virtio-console is initialized, there's
> > > > no
> > > > way
> > > > it's going to be used.
> > >=20
> > > If both are modular, modprobe should make sure that rproc is
> > > ready
> > > before virtio-console. If virtio-console is builtin and rproc is
> > > modular, IS_REACHABLE(CONFIG_REMOTEPROC) evaluates to false and
> > > so
> > > rproc
> > > won't be used. (As is the case already today with
> > > CONFIG_REMOTEPROC=3Dn).
> > >=20
> > > > Only if the rproc module is loaded before
> > > > virtio-console will the rproc functionality be used -- which
> > > > means
> > > > that
> > > > nothing changed in reality..
> > >=20
> > > With that patch indeed nothing changed yet, because
> > > CONFIG_REMOTEPROC
> > > cannot be =3Dm today. Until this changes IS_REACHABLE() and
> > > IS_ENABLED()
> > > are equivalent.
> > > =C2=A0
> > > > To properly detect and use rproc if available would need the
> > > > rproc
> > > > initialization out of virtcons_probe() and into something that
> > > > happens
> > > > either via sysfs for existing ports, or when adding a new port
> > > > to a
> > > > device.=C2=A0 However, the current spec doesn't allow for that, so
> > > > some
> > > > more
> > > > changes will need to be made to ensure current backwards
> > > > compat,
> > > > and a
> > > > new specification that allows for a late init of rproc.
> > >=20
> > > I didn't understand that and hope it's irrelevant with the things
> > > I
> > > wrote above.
> >=20
> > See
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/char/virtio_console.c#n1993
> >=20
> > The device is configured at probe time on how it's going to be used
> > -
> > all that will have to be reworked for making the remoteproc driver
> > tristate.
> >=20
> > So in essence, this patch isn't changing anything; but it's not
> > helping
> > the case you want to enable either.
>=20
> I still don't understand. With both CONFIG_REMOTEPROC=3Dm and
> CONFIG_VIRTIO_CONSOLE=3Dm the expression is_rproc_serial(vdev) will be
> true iff vdev->id.device =3D=3D VIRTIO_ID_RPROC_SERIAL. (And with
> CONFIG_REMOTEPROC=3Dm and CONFIG_VIRTIO_CONSOLE=3Dy it will be 0.)
>=20
> Both IS_ENABLED(CONFIG_REMOTEPROC) and
> IS_REACHABLE(CONFIG_REMOTEPROC)
> evaluate to constants known at compile time.
>=20
> So the device is still configured at probe time on how it's going to
> be
> used and I don't see what needs to be reworked.
>=20
> If you're still convinced there is something broken, would you please
> point out in which case (CONFIG_REMOTEPROC=3D?,
> CONFIG_VIRTIO_CONSOLE=3D?)
> something broken happens, and what this is?

I'm thinking of the two combinations of interest: REMOTEPROC=3Dm,
VIRTIO_CONSOLE can be y or m.  Say virtcons_probe() happens when the
remoteproc module isn't yet loaded.  Even after later loading
remoteproc, virtio console won't do anything interesting with
remoteproc.

		Amit
