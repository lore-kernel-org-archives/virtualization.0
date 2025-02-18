Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9ED23237C;
	Tue, 18 Feb 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872191; cv=none; b=py1eTJ+Q7h7R179wMmn3ciS/0QYY+/fOUpMR0wzmZ9In0Q8MMq/KR5bYYA50Uzwi8GeMKs/l+rb1tnr0Uz61znf2hmMEg9/H+03fOiR6VNx7+Switw7FaxjCHbwAG9Ru6PcEESzKKh2y8QL+purdbjIzZWRXecPy9BFyw/F1m3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872191; c=relaxed/simple;
	bh=EGzJILY69KaBGAu/j6uhfg0Ns9AWmYI3DuY2Ll/vyO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0Cx0sspbLpM43v4GuBsJWMA5i2dXrxwJK5zn9ByN7j1QflWo1Ue9ERBIEW1cjzKU7bgb/RP004n3mZgRzb2akXJvSGpdMqrLWJzhs3I/7WZ5N5e0Snv9wkLs1GSmarq5faoPzIjpGG96GsfrYa1m4wErHGI+Y+CV8lg3d3hFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkZe9OjY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkZe9OjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8CAC4CEE2;
	Tue, 18 Feb 2025 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872190;
	bh=EGzJILY69KaBGAu/j6uhfg0Ns9AWmYI3DuY2Ll/vyO8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LkZe9OjY6T3AAmtxwj1Xb06j5/KNp2WW26IN5goY9IcWp90alPhD7SYEaEgX5rJHt
	 ze3FQVUVUO5v51nu3K3QYfL+oLfPrhoIXu7ER/e+zBVjJCRW07zrE2cnuw1dCzn15o
	 bbZvSpjdZnt1Dk1jF+ut/kFKA46eZrP4y2kbrmMhzLd3WRbmTSICgRLS+oCvqhJVgq
	 sshopbF9SHGvBKNfCkG93sr0iG+cRUiJA6l9mDfhxDcS8KdVniFMdEdnfLuQlCPJDk
	 tu4m75UUHPX9uGTbDWYeeoI3PggiN9llNx4LC8OxCNGW6Yj+1gc01U1xF56P07rC7B
	 bunCvfIyD4N7Q==
Message-ID: <4c7e30d960b101fbcc9b6b8356f3bd20d26b0982.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
From: Amit Shah <amit@kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 10:49:47 +0100
In-Reply-To: <15729df921fa8718ee173963132a370de6aae9af.camel@kernel.org>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
			 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
			 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
			 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
			 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
			 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
			 <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
			 <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>
			 <535ivi67jdmcuhns5q4r36fjpqde3clnqq7hr26gmg33jwoxyb@ahvuhhaewh3u>
		 <2c676a9910c2d5b1332bb9baa999cdd16763a730.camel@kernel.org>
	 <15729df921fa8718ee173963132a370de6aae9af.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2025-02-17 at 11:59 +0100, Amit Shah wrote:
> On Mon, 2025-02-17 at 11:53 +0100, Amit Shah wrote:
> > On Fri, 2025-02-14 at 18:47 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Feb 14, 2025 at 05:55:41PM +0100, Amit Shah wrote:
> > > > On Fri, 2025-02-14 at 17:52 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Hello Amit,
> > > > >=20
> > > > > On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> > > > > > I'm thinking of the two combinations of interest:
> > > > > > REMOTEPROC=3Dm,
> > > > > > VIRTIO_CONSOLE can be y or m.=C2=A0 Say virtcons_probe() happen=
s
> > > > > > when
> > > > > > the
> > > > > > remoteproc module isn't yet loaded.=C2=A0 Even after later
> > > > > > loading
> > > > > > remoteproc, virtio console won't do anything interesting
> > > > > > with
> > > > > > remoteproc.
> > > > >=20
> > > > > Where does the interesting thing happen if remoteproc is
> > > > > already
> > > > > loaded
> > > > > at that time? I'm not seeing anything interesting in that
> > > > > case
> > > > > either
> > > > > ...
> > > >=20
> > > > The code I pointed to,
> > > >=20
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/char/virtio_console.c#n1993
> > > >=20
> > > > either enables remoteproc if the module is present; or it
> > > > enables
> > > > multiport, but not both at the same time.=C2=A0 If remoteproc isn't
> > > > present
> > > > when this probe routine is executed, multiport might get
> > > > enabled.=C2=A0
> > > > And
> > > > then there's no chance for remoteproc to get enabled.
> > >=20
> > > The only case where there is a difference between IS_REACHABLE
> > > and
> > > IS_ENABLED is:
> > >=20
> > > 	CONFIG_REMOTEPROC=3Dm
> > > 	CONFIG_VIRTIO_CONSOLE=3Dy
> >=20
> > Well, also if CONFIG_VIRTIO_CONSOLE=3Dm; and virtio_console.ko is
> > loaded
> > before remoteproc.ko.
> >=20
> > > Iff in this case you never want to test for MULTIPORT (even
> > > though
> > > the
> > > remoteproc module might never get loaded), then my patch is
> > > wrong.
> > >=20
> > > When creating the patch I thought there is a hard dependency on
> > > remoteproc (like calling a function that is provided by
> > > CONFIG_REMOTEPROC). I don't understand how the remoteproc stuff
> > > interacts with the virtio_console driver, is this something in
> > > userspace
> > > which then would also autoload the remoteproc module?
> >=20
> > What's happening is that multiport and remoteproc are mutually
> > exclusive in the virtio_console code.
> >=20
> > And, I'm also not sure of how remoteproc loads and configures
> > itself.
> > Does loading remoteproc cause a load of virtio_console?=C2=A0 How?
> >=20
> > So - based on our discussions, I think your assumptions are:
> >=20
> > 1. remoteproc will load virtio_console when remoteproc is required
> > 2. virtio_console will never be loaded by itself
> > 3. General virtio_console functionality (including tty and
> > multiport)
> > is never used when remoteproc is used
> >=20
> > I think at least 3 needs more thought/justification why it's a
> > valid
> > assumption.=C2=A0 Documenting it in the commit msg is fine.
> >=20
> > At least assumptions 1 and 2 will cause remoteproc to not function
> > correctly with virtio_console, despite both of them being loaded
> > (because they can be loaded in the unexpected order --
> > virtio_console
> > before remoteproc).=C2=A0 Do you want to adjust the code so that
> > remoteproc
> > queries for already-existing virtio_console.ko, triggers the code
> > that
> > would otherwise be not triggered in virtcons_probe(), and makes
> > remoteproc functional in that case?
>=20
> ... I just saw that virtcons_probe() doesn't have any setup in case
> of
> rproc.=C2=A0 So this last paragraph doesn't apply.

... I knew I was missing something yesterday. There's the call to
add_port() from virtcons_probe() that sets up the port for remoteproc.
So that part will be entirely skipped in case the virtcons probe
happens before remoteproc is loaded.

There's much too confusion here, better to start anew.

> So maybe just adding some notes in the commit log about why this will
> end up working, and why rproc usage and tty+multiport usage are
> mutually exclusive (and fine) will help.
>=20
> Thanks,
>=20
> 		Amit

