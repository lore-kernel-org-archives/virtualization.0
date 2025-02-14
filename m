Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815C264A85;
	Fri, 14 Feb 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539940; cv=none; b=HzA/J8NsETmbAuGgVzyANExkGp0iFfCCFJBQbDcmPBL/j4xp7l3SE4I+jf72B/QFKHM1+888mr04wOszUH0nbkZDdMw8hV7kMji7WYZNGkVF3XCvfBVoJHvVm2lOD4A7pMpEq6FCzd2Jc3HeedJk2oFsyN1VRSf+n7wRrzPPe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539940; c=relaxed/simple;
	bh=zIzezJTtZX7gF+P2Mi7uN3v642Mtp3pblVa5iR9oZSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtw+9M+XpAWwwoIRniqTvw2G2TSldexv9++FPnaonB85Uzofi4Riyyf0rS/yIt92kgXlETVY/9IQ6GgxBmS2wOXRVw4hmhoOmdi3mjBBddx8JPwvkdRtPEH1DThaslvsmSKfZu2qeThAYUyc2nGTQ7eQodgfuiVRENuvsy9CTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgCAfYa9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgCAfYa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E953C4CED1;
	Fri, 14 Feb 2025 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739539939;
	bh=zIzezJTtZX7gF+P2Mi7uN3v642Mtp3pblVa5iR9oZSY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lgCAfYa9SsAhyGVHe2CEmgmbU3qLsPxmDiuTPVvKyzAZbB+tJZebrI81Fqw5tn/vt
	 MfVuRj6I2NTEmwGwt9/slmGeRzP8CIjFlhlKKEjZtoL0lU6B1zICFQLh3jluTOBqo/
	 3nkXmV5cSHTDwdt2tuCQ6oc0VJ71Wkw7jmrcApr7AweFnTI+j2mG8HeoKi7bo6LHsI
	 YbrO1IzJEI+w2ZZ6mhh5NEKbKP6EwPCmx/2myn1fP6rIjlue5ImXqhS03y7bd4rCcO
	 VpjTlMe2LAaRA4XF+9kVNvgb5us+JB2CRqt9SIdKgIqTvn9tC9laytZjiyCs0fTZr6
	 6B+HSNcHbpAww==
Message-ID: <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
From: Amit Shah <amit@kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 14:32:16 +0100
In-Reply-To: <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
	 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
	 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2025-02-14 at 12:14 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Amit,
>=20
> On Fri, Feb 14, 2025 at 11:58:44AM +0100, Amit Shah wrote:
> > On Thu, 2025-02-13 at 12:55 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > virtio_console.c can make use of REMOTEPROC. Therefore it has
> > > several
> > > tests evaluating
> > >=20
> > > 	IS_ENABLED(CONFIG_REMOTEPROC)
> > >=20
> > > . This currently only does the right thing because
> > > CONFIG_REMOTEPROC
> > > cannot be modular. Otherwise the configuration
> > >=20
> > > 	CONFIG_REMOTEPROC=3Dm
> > > 	CONFIG_VIRTIO_CONSOLE=3Dy
> > >=20
> > > would result in a build failure because then
> > > IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the
> > > built-
> > > in
> > > virtio_console.o must not use symbols from the remoteproc module.
> > >=20
> > > To prepare for making REMOTEPROC modular change the tests to use
> > > IS_REACHABLE() instead of IS_ENABLED() which copes correctly for
> > > the
> > > above case as it evaluates to false then.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > ---
> > > Hello,
> > >=20
> > > I didn't check what else needs to be done to make
> > > CONFIG_REMOTEPROC
> > > tristate but even if it stays a bool using IS_REACHABLE() is
> > > still
> > > the
> > > better choice.
> >=20
> > It might lead to a false sense of "better" -- the value of
> > IS_ENABLED
> > is cached in a variable which is determined at compile-time.
>=20
> Either I don't understand what you mean, or this is wrong.
>=20
> 	$ make allmodconfig drivers/char/virtio_console.i
> 	$ grep CONFIG_REMOTEPROC=3D .config
> 	CONFIG_REMOTEPROC=3Dm
> 	$ cat drivers/char/virtio_console.i
> 	...
> 	static bool is_rproc_serial(const struct virtio_device
> *vdev)
> 	{
> 	 return 1 && vdev->id.device =3D=3D 11;
> 	}
> 	...
>=20
>=20
> so is_rproc_enabled is still constant and known at compile time.

Well - so I was replying to your comment about what else is required.=20
And if remoteproc becomes a module, this check will not happen at
compile-time?

In any case, the next bit is the more important one:

> > That
> > caching, after this change, moves to driver init-time.=C2=A0 If the
> > rproc
> > module is loaded after virtio-console is initialized, there's no
> > way
> > it's going to be used.
>=20
> If both are modular, modprobe should make sure that rproc is ready
> before virtio-console. If virtio-console is builtin and rproc is
> modular, IS_REACHABLE(CONFIG_REMOTEPROC) evaluates to false and so
> rproc
> won't be used. (As is the case already today with
> CONFIG_REMOTEPROC=3Dn).
>=20
> > Only if the rproc module is loaded before
> > virtio-console will the rproc functionality be used -- which means
> > that
> > nothing changed in reality..
>=20
> With that patch indeed nothing changed yet, because CONFIG_REMOTEPROC
> cannot be =3Dm today. Until this changes IS_REACHABLE() and
> IS_ENABLED()
> are equivalent.
> =C2=A0
> > To properly detect and use rproc if available would need the rproc
> > initialization out of virtcons_probe() and into something that
> > happens
> > either via sysfs for existing ports, or when adding a new port to a
> > device.=C2=A0 However, the current spec doesn't allow for that, so some
> > more
> > changes will need to be made to ensure current backwards compat,
> > and a
> > new specification that allows for a late init of rproc.
>=20
> I didn't understand that and hope it's irrelevant with the things I
> wrote above.

See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/char/virtio_console.c#n1993

The device is configured at probe time on how it's going to be used -
all that will have to be reworked for making the remoteproc driver
tristate.

So in essence, this patch isn't changing anything; but it's not helping
the case you want to enable either.

		Amit
