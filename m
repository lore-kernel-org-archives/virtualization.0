Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E96267710
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555234; cv=none; b=VfEImNsVIKILx/Mazo09QAFTbXy47AqcRKWBjHGoFPuonUVbMO4Dz2ycLoLJfD4zcRpckg3/Gy+DpVaUD4hC/EocGNqkKsm+JrJjEA3OIXQ11wf2cxs9X1AoodXacuun61EKMxQ+N9muftz37Ji6TVYLTzu+lynOnyEqJs5tvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555234; c=relaxed/simple;
	bh=t3oWETlabnmfVg8DbBC0SNH2igt6njm5VPlQ2ZhjXkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOJ/Ja4nRwrjawzE0x9V4lSEiEpch/2hBtmN3oStoO1elP6txaZpEYzqR182iScQB6x0sGwF3FL/dI0AfmikT7H8o4T5pErkDacKhnCdZyqOy+ikXvYV7IN0Ha47U1clngQFT7CkZE8IojpU06OTAXNBeQnwU8a6jtxgYjQZp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fccOM7ci; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fccOM7ci"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so17111735e9.1
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739555230; x=1740160030; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lazeQVqM8HBrkNbfoBLsm78c+HYiZJZx2UTk1PYr3WQ=;
        b=fccOM7ciamXg+MKOxqcjDCJQ9/6nlsyez7Q5f9iRa4sLa2Ob6g21hx/B0uHKIy9Oaw
         Oke+A7njRd6GXWC+4HZwH7BhUrCIQlZ8lvibTCJRC2IKBzoHp0Ueueax2AYEkFJB4zY+
         oq6diGPvP9gqJD7RFxV2bIK8okkvzV9k9vmUQj63tT4AXEi/Z4Gao8W9KR2deTT4myr3
         1f6H8iRR6sfVfBu+XxRKOVslf2/liaq7iZYj0KHT200Wuh7DfOmBMFgc+jTyA4m0rkjV
         0bW5VnRcqI39XV8/wCklfcfwy44aIZ6/Yf/UPFH3c/t6vfywwlZX+zGdjo6bZ8nTfGMY
         paFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555230; x=1740160030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lazeQVqM8HBrkNbfoBLsm78c+HYiZJZx2UTk1PYr3WQ=;
        b=S23U9ivazztbU/ii0yB7V4z2MIn88f/0GbkO9qSMuCW59RjMZD8da4cfk1lEv+HvfK
         e8rmkHRrNRHYh09nwZcgYk5bG/W2sO/TvCPC2A906bFP7hUYkC8BOWKH4w1OKHWSWiUt
         wI1az63otgOI1ZsMptn4/OBYkZ2ZK0bfOzhUUx/QkRwK/eacWFDKZlVfWa5dqjcUqR1r
         YhUaHLYYMGo8HrPu6AlKSAGt7jtJIeokplyF6erLswZEutnaH2NqT/dW7kOX3Z8Yt6nm
         wiSiN1/iXtUdaTxBKzyEBfo/rXcWMdoGHLUDO7hOvxAvIHgqXqPGI5Piu82DTzdyTNxI
         Zagw==
X-Forwarded-Encrypted: i=1; AJvYcCXWfSK0iav4oY41NofFH6FGlrBiyhAzFSuMuOPR6MUEkCLU6GLC0jXGfX4fjnB96sBSjdzLBLxTJl9SOgB8wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjNoO/slCuf8OqrRBvJCXmv96dbf7xPBW3CZpA/FR+eYcP/8ci
	dg8VMDQOmXDN4avLAFrWaZI6JweJDnjE/152/s2Peb1yKhr4/Vt6azBzcOvNMZI=
X-Gm-Gg: ASbGnctWG/1lI6fQvAYOYhOkC18p7Zlxnt08ZRG5lTe+JYNdMIAUpkXADWPje/hDJE7
	YSspM5hYfEgH2Wnp414J75fIyMT8lxE41lE5ervnPat9/2INp8Hr4+OZMEZMhM5EcAPjXbzdK7a
	QK/q/72LL7bLvik5QY34LuquaRqpVVawDOP33q9CMpSvne3v8OFbvROaMe6HZV401pKzYsq9VUl
	iw4Z9FCTFIIdxezFjuuq2oP9PoYSywSV1cTGCOrOinodIFjsQmPVsCnX3NiK5z/riZyHqCFExoK
	0IZlAFsvz5EY0zIFJij/iUY3Q3Iub/I3uFHlOhiwhfcEYu8XmBkFLQ+haw==
X-Google-Smtp-Source: AGHT+IEs0d7y7ALPKarUJ4mTHnR3e/ikwhGCmRE/iYFLD7SdNQTwPJz+bIdLpQ+jOwOyuaxzGwSscQ==
X-Received: by 2002:a05:600c:4711:b0:439:608f:a37f with SMTP id 5b1f17b1804b1-4396e699e92mr2382245e9.5.1739555230357;
        Fri, 14 Feb 2025 09:47:10 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395afaf052sm77057895e9.13.2025.02.14.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:47:09 -0800 (PST)
Date: Fri, 14 Feb 2025 18:47:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <535ivi67jdmcuhns5q4r36fjpqde3clnqq7hr26gmg33jwoxyb@ahvuhhaewh3u>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
 <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
 <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="walgac2exdfodujc"
Content-Disposition: inline
In-Reply-To: <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>


--walgac2exdfodujc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

On Fri, Feb 14, 2025 at 05:55:41PM +0100, Amit Shah wrote:
> On Fri, 2025-02-14 at 17:52 +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Amit,
> >=20
> > On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> > > I'm thinking of the two combinations of interest: REMOTEPROC=3Dm,
> > > VIRTIO_CONSOLE can be y or m.=A0 Say virtcons_probe() happens when
> > > the
> > > remoteproc module isn't yet loaded.=A0 Even after later loading
> > > remoteproc, virtio console won't do anything interesting with
> > > remoteproc.
> >=20
> > Where does the interesting thing happen if remoteproc is already
> > loaded
> > at that time? I'm not seeing anything interesting in that case either
> > ...
>=20
> The code I pointed to,
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/char/virtio_console.c#n1993
>=20
> either enables remoteproc if the module is present; or it enables
> multiport, but not both at the same time.  If remoteproc isn't present
> when this probe routine is executed, multiport might get enabled.  And
> then there's no chance for remoteproc to get enabled.

The only case where there is a difference between IS_REACHABLE and
IS_ENABLED is:

	CONFIG_REMOTEPROC=3Dm
	CONFIG_VIRTIO_CONSOLE=3Dy

Iff in this case you never want to test for MULTIPORT (even though the
remoteproc module might never get loaded), then my patch is wrong.

When creating the patch I thought there is a hard dependency on
remoteproc (like calling a function that is provided by
CONFIG_REMOTEPROC). I don't understand how the remoteproc stuff
interacts with the virtio_console driver, is this something in userspace
which then would also autoload the remoteproc module?

Best regards
Uwe

--walgac2exdfodujc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmevgZgACgkQj4D7WH0S
/k7HTQf/Qu3c/c+WXh9ZVNVbAWLGM595jWag8q5Fnrvl5a5haHcpx3WNtyTyVcW+
hz9ygSWroLlA3Mm4rvYjbsYTIwhqVSeXdhH3WvQ/ihfkJLLm2PizX/89foU/DfgT
uHfEUWlCi3VdZ+IWRw/1V9vdjzNrS+88tjYXGHIJ2oGzxIbczuYrwFwgk7ecHA/Z
0VcS1MbdvgNHoXN6y1kvvSiO0vPSXmBFos4bFfVGWxjxqt6ZHI2kHB8xt4E+wuFt
Hmce87lyhSguCtF/tsbf1MU6BRv5VvhwYtkHxxxlsjRxF2vWDZ9fpte8z+nVD4yD
sftqkZCLoiGOtr2PqZDxEiIvsJz55g==
=QIOV
-----END PGP SIGNATURE-----

--walgac2exdfodujc--
