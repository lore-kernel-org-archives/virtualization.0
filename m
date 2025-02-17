Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71621661C;
	Mon, 17 Feb 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789584; cv=none; b=HPy9JBRGLAfKNVKtRyErU3HsjBkh+99Np7cFcwS0d6JnJUr/4tDAM1kt90MJqZWaNoDKOz1SJ2Y9Ncc9uhh6Q6n1UA0LCSBsQ2kylDFwjyJVXABi7hZ1gC1EzVi2vaNqP5opKDZG22JX1savqQPOPqsETa/+4Tj5FHJs4iisAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789584; c=relaxed/simple;
	bh=EKDu0FFdU5glr/+Aae4x0n+uySneQaiQRnxmjB8Z6eY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOEKTXzpA/jYE5PZ56kh7dZqtWB/0RT/TMx0bwoWY9N0iKQtFaMmERKMjCmaJnxPsMS3Gx+kE5PECJyyB8njMF/WuqsbVZhKo5jgifE+aDzTnU4jMu0GH422AcynvSaLxUQq8QucsD3K2c7VFohxdVpgh9q9LoS80r6HJBCtOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHBQk5eh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHBQk5eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0107CC4CED1;
	Mon, 17 Feb 2025 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739789584;
	bh=EKDu0FFdU5glr/+Aae4x0n+uySneQaiQRnxmjB8Z6eY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JHBQk5ehp4JSqdqpfeH4t8LADleAWhe+XrCu9fd+Su5wgXvaRVchX/fPqRiDO9+dg
	 8fj7pFcOraXxJPGeAFIzXf191fPwzEaxZFS8qd7d+rDkQAq0Ft5JFASEQZ3oBC7+Mn
	 /xQgLf8GWBtNPk3d74qZdTltgT2K+S+E2J8FdvUeeuAG8e4u6ZDFtdxayFAdTR/ADY
	 R2hjOyIoqVke/ZV+2A8qbCAmBUOtZmBaVbvh5vHhcannBUsVnLBrrwRAyp4c5ZGOZ1
	 gTz3y2iIobXbfWKUXotKbatennlFOY8kGGoXnIhwejK4R+j1qqB/30jh9aDzyPIn1E
	 vtJW61RLRYwDQ==
Message-ID: <2c676a9910c2d5b1332bb9baa999cdd16763a730.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
From: Amit Shah <amit@kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Mon, 17 Feb 2025 11:53:01 +0100
In-Reply-To: <535ivi67jdmcuhns5q4r36fjpqde3clnqq7hr26gmg33jwoxyb@ahvuhhaewh3u>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
	 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
	 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
	 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
	 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
	 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
	 <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
	 <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>
	 <535ivi67jdmcuhns5q4r36fjpqde3clnqq7hr26gmg33jwoxyb@ahvuhhaewh3u>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2025-02-14 at 18:47 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Feb 14, 2025 at 05:55:41PM +0100, Amit Shah wrote:
> > On Fri, 2025-02-14 at 17:52 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello Amit,
> > >=20
> > > On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> > > > I'm thinking of the two combinations of interest: REMOTEPROC=3Dm,
> > > > VIRTIO_CONSOLE can be y or m.=C2=A0 Say virtcons_probe() happens
> > > > when
> > > > the
> > > > remoteproc module isn't yet loaded.=C2=A0 Even after later loading
> > > > remoteproc, virtio console won't do anything interesting with
> > > > remoteproc.
> > >=20
> > > Where does the interesting thing happen if remoteproc is already
> > > loaded
> > > at that time? I'm not seeing anything interesting in that case
> > > either
> > > ...
> >=20
> > The code I pointed to,
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/char/virtio_console.c#n1993
> >=20
> > either enables remoteproc if the module is present; or it enables
> > multiport, but not both at the same time.=C2=A0 If remoteproc isn't
> > present
> > when this probe routine is executed, multiport might get enabled.=C2=A0
> > And
> > then there's no chance for remoteproc to get enabled.
>=20
> The only case where there is a difference between IS_REACHABLE and
> IS_ENABLED is:
>=20
> 	CONFIG_REMOTEPROC=3Dm
> 	CONFIG_VIRTIO_CONSOLE=3Dy

Well, also if CONFIG_VIRTIO_CONSOLE=3Dm; and virtio_console.ko is loaded
before remoteproc.ko.

> Iff in this case you never want to test for MULTIPORT (even though
> the
> remoteproc module might never get loaded), then my patch is wrong.
>=20
> When creating the patch I thought there is a hard dependency on
> remoteproc (like calling a function that is provided by
> CONFIG_REMOTEPROC). I don't understand how the remoteproc stuff
> interacts with the virtio_console driver, is this something in
> userspace
> which then would also autoload the remoteproc module?

What's happening is that multiport and remoteproc are mutually
exclusive in the virtio_console code.

And, I'm also not sure of how remoteproc loads and configures itself.=20
Does loading remoteproc cause a load of virtio_console?  How?

So - based on our discussions, I think your assumptions are:

1. remoteproc will load virtio_console when remoteproc is required
2. virtio_console will never be loaded by itself
3. General virtio_console functionality (including tty and multiport)
is never used when remoteproc is used

I think at least 3 needs more thought/justification why it's a valid
assumption.  Documenting it in the commit msg is fine.

At least assumptions 1 and 2 will cause remoteproc to not function
correctly with virtio_console, despite both of them being loaded
(because they can be loaded in the unexpected order -- virtio_console
before remoteproc).  Do you want to adjust the code so that remoteproc
queries for already-existing virtio_console.ko, triggers the code that
would otherwise be not triggered in virtcons_probe(), and makes
remoteproc functional in that case?

		Amit
