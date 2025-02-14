Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7D253341;
	Fri, 14 Feb 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530728; cv=none; b=flsThMJo3I1vrgV5RlFahyeUQiwxnz2Tw7KsmPL2gYMvnh0bwsyjOORSgeWtAT4Rku3+FauMywluSv9JWh3jksQnUdD/YxvxsW3wMz3d2Vwifs3CsgkQ/s52W21MLGlg/gfjkHxu7S2aMCmQJya1TWk6jwkFfTTKtIYmcvdnrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530728; c=relaxed/simple;
	bh=YGO5Pln5UyIPpL0aOKK/m3y/N5/ml4T2i3knF1u/zA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+y/VpV8kcIh4FvKmbSVvpX/91mLV7eMIRkOJ1Cnknu7zQq7Ja9NOLlE+JH41Bwb8sHdTHv3AJ4+M/DLh+rweRB6TeYKEVS02TBfC2Z4QuXQQgqiQfYwo1LUrh0KTw89eniG/0ZK7ZcDRt0geDalRdbKTG8Z5fghaIhi0GgHZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb+eLgfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb+eLgfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35691C4CED1;
	Fri, 14 Feb 2025 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739530727;
	bh=YGO5Pln5UyIPpL0aOKK/m3y/N5/ml4T2i3knF1u/zA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Sb+eLgfYNSEFXnXityoe73cR+IlCkF7ZyGkOwChYv//zxPM/MZdBnRLOyrPbziJN6
	 CkEPslDJSkosJNNqE3WIRK81jAn2I08vnEIy50y4RfJY8YtRcVody4FFFfjS31P+P+
	 YGpAJvqLUD00XTBk+02555+ozl/9WmGaJAewu7oEXxnir76VDIfsDGVVZPZcFgZY/j
	 J8DqtHu4j5fXJkLd4hSwOEjrgJUK023joqgZcRbbMx9LE4P5tUtE2MUZ6a4v27F7Fr
	 uQDKv+cvnYt5lMGUC98V2NRnGpMWM4c7ajfTIlAXHZv+HZ8RTgGAvjFWCSu46NWXXJ
	 S0I6zV86umaqw==
Message-ID: <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
From: Amit Shah <amit@kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Arnd Bergmann
	 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 11:58:44 +0100
In-Reply-To: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2025-02-13 at 12:55 +0100, Uwe Kleine-K=C3=B6nig wrote:
> virtio_console.c can make use of REMOTEPROC. Therefore it has several
> tests evaluating
>=20
> 	IS_ENABLED(CONFIG_REMOTEPROC)
>=20
> . This currently only does the right thing because CONFIG_REMOTEPROC
> cannot be modular. Otherwise the configuration
>=20
> 	CONFIG_REMOTEPROC=3Dm
> 	CONFIG_VIRTIO_CONSOLE=3Dy
>=20
> would result in a build failure because then
> IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the built-
> in
> virtio_console.o must not use symbols from the remoteproc module.
>=20
> To prepare for making REMOTEPROC modular change the tests to use
> IS_REACHABLE() instead of IS_ENABLED() which copes correctly for the
> above case as it evaluates to false then.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> I didn't check what else needs to be done to make CONFIG_REMOTEPROC
> tristate but even if it stays a bool using IS_REACHABLE() is still
> the
> better choice.

It might lead to a false sense of "better" -- the value of IS_ENABLED
is cached in a variable which is determined at compile-time.  That
caching, after this change, moves to driver init-time.  If the rproc
module is loaded after virtio-console is initialized, there's no way
it's going to be used.  Only if the rproc module is loaded before
virtio-console will the rproc functionality be used -- which means that
nothing changed in reality..

To properly detect and use rproc if available would need the rproc
initialization out of virtcons_probe() and into something that happens
either via sysfs for existing ports, or when adding a new port to a
device.  However, the current spec doesn't allow for that, so some more
changes will need to be made to ensure current backwards compat, and a
new specification that allows for a late init of rproc.


		Amit
