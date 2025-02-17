Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F13E499
	for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808393; cv=none; b=J1/mp5B2rPmEiwg/z2fTtKGgfpR+jHQRc6gWXuX6L0ipanNj1yv+zONc2vCVxfwTI2C+f3npTdIXGV9fw63jSk44CRFR0Pfwzb8rkp5vydd2woqwJz6wajFMWVS9csUgwTLu4yALfo73s2391YU8UuKY5dzvMl4x78aq7CC8+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808393; c=relaxed/simple;
	bh=t6fzYE9Z8ryLoZJ+7vGATWDozTDsrr74gCrb47HT/tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HulOnp2dqwu2doeIZhckX64yaNiojrkefdlq3hBPsEO5/U28lppXy3KjZu/Ngti9ffuri5TFxyM3xbNsD7SbjhW4Ho4O7gtNcfijFcT3uhgv8OmCMjM5Pbz+nE+zxPYMyj7CPpopWcXrpRo5W+DBzQNpxa24dO0PcIvElwLgNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dS71ZeQ8; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dS71ZeQ8"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43989226283so5644915e9.1
        for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739808390; x=1740413190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5zZLpKhpoL4pFz7vzigrvRBLC5VxoaVKvfWnN7a/3I=;
        b=dS71ZeQ8DRHZJ09uaPLo7aiaWGI49WfofXo8hKiFBs3s5BcBgqaHgscD/AVGO8MlXk
         2guYyt6b+2opJsFZgq1z2TY9Dy+iPUCE+HL9Bu8pXrxriDmiv3I2TvB5HVdlVFF2lomE
         5/vx59UsKfgX+UAphOiB30MCzrmSN/RKsXqilNz8mDOQVEUhIyPIjR0CyHFQ0SU9B1u/
         /G6qRMhjhlFGkSuk6qg6kbCNI4TpUYkjtoe30O4ai05HDnyWuXxZEsewpog8RSsX/L7Z
         siZ+SIeFn5sKvty7mvuAW9ZRD91ACnhivINuJoyq+xAbQFb/qYu5kLY/nrGw06wxV0Tj
         p8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739808390; x=1740413190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5zZLpKhpoL4pFz7vzigrvRBLC5VxoaVKvfWnN7a/3I=;
        b=CozOkbgh70PTC8FYR1B/i0POsur8tTyGpq6TfQIJDStcJC80yLziBfWdCVzjMS7SRN
         taoUFoTdg2gPzXcdd6AvDza9yPlrMp3rAdVsxXOAsF77jNx5oaotT+yZ0dpBzjaadBZ0
         FjaTVYSCqPoxyHnC/Geg0UQrj5YQicG6cFVj0clxuF0CIWoBvEJqyhgcx8ix+cL7yRt8
         romW30xXHLSemDCAFFAB9wG0e6n7RiF7y/QysHZuMUSUMTr/dXX1t6x3gpq8MCN+PYGy
         03waN4OzUwa7FDPwcWNE2mnSAWUSeTYr03+qa2eM6ggvgeOJIpoiAzh37+6F0MUb3YfP
         CvUw==
X-Forwarded-Encrypted: i=1; AJvYcCWVQpbczE23zlFXudYMhYuNSRBJ0j1tk77smbFB3Ma+U6xA8qQNc5mto5s6HHCyBGgEBNmlfZTaXO1A+N5e8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYVdSZMe+5it08WykvvXrRhdRulqao/TU3uXd38W6xSSgqC2/5
	eIdHoQSDzKkrMdzvL62nZRrhin66yZohi3Lfr+9xLW2/WIv22RcCFh73QpUGamw=
X-Gm-Gg: ASbGncs/Z2VCl3HOO1cjF5bMCyu54X+xhYy94G0J/jq/Yx3GhPUZ6yaBfQwcRJRV3Xp
	7d6R98ffn4ZzvlmgxnjgJvC555KgXtE6suQqeKF5JdZmS6SYl1Brp2Tp8nn5U+0sB+s+O1ysyGK
	vCvdJ0LqCfMy9B9GxSgB50epwVmDgl4hzr5pi7FvH9M6ZMpCHj01ZywXoCj/jVRAaNhzDwVkflY
	vTXsyrDVLLZGRRGF1I7I/0+Ool2yE5ekO01sqER6A15LQDMbk5nGHhaaWiF2Wsh66toZqe3z9I8
	idoYftnSylJQHjG0KneyQ8fBTk0foHpz2nMzEhFoyp+ryPrrS2tcsQGvog==
X-Google-Smtp-Source: AGHT+IEa/epQxR37BEhyFDusO4FdLZ4NM5IKYGmbhJVL1W+AN0lFXYuZ9wSXrzhqqXI4vFYGVQqTcQ==
X-Received: by 2002:a5d:47a7:0:b0:38f:4b2c:2448 with SMTP id ffacd0b85a97d-38f4b2c2531mr2416224f8f.32.1739808390129;
        Mon, 17 Feb 2025 08:06:30 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7df2sm12632945f8f.84.2025.02.17.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:06:29 -0800 (PST)
Date: Mon, 17 Feb 2025 17:06:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <o5dabgse26d5vn4lzf6hllslfr4h4wdzep7jonkmhtq6njenjy@vmnsshcve6dm>
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
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yawypp2wpqlzvds"
Content-Disposition: inline
In-Reply-To: <2c676a9910c2d5b1332bb9baa999cdd16763a730.camel@kernel.org>


--5yawypp2wpqlzvds
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

On Mon, Feb 17, 2025 at 11:53:01AM +0100, Amit Shah wrote:
> On Fri, 2025-02-14 at 18:47 +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Feb 14, 2025 at 05:55:41PM +0100, Amit Shah wrote:
> > > On Fri, 2025-02-14 at 17:52 +0100, Uwe Kleine-K=F6nig wrote:
> > > > Hello Amit,
> > > >=20
> > > > On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> > > > > I'm thinking of the two combinations of interest: REMOTEPROC=3Dm,
> > > > > VIRTIO_CONSOLE can be y or m.=A0 Say virtcons_probe() happens
> > > > > when
> > > > > the
> > > > > remoteproc module isn't yet loaded.=A0 Even after later loading
> > > > > remoteproc, virtio console won't do anything interesting with
> > > > > remoteproc.
> > > >=20
> > > > Where does the interesting thing happen if remoteproc is already
> > > > loaded
> > > > at that time? I'm not seeing anything interesting in that case
> > > > either
> > > > ...
> > >=20
> > > The code I pointed to,
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/char/virtio_console.c#n1993
> > >=20
> > > either enables remoteproc if the module is present; or it enables
> > > multiport, but not both at the same time.=A0 If remoteproc isn't
> > > present
> > > when this probe routine is executed, multiport might get enabled.=A0
> > > And
> > > then there's no chance for remoteproc to get enabled.
> >=20
> > The only case where there is a difference between IS_REACHABLE and
> > IS_ENABLED is:
> >=20
> > 	CONFIG_REMOTEPROC=3Dm
> > 	CONFIG_VIRTIO_CONSOLE=3Dy
>=20
> Well, also if CONFIG_VIRTIO_CONSOLE=3Dm; and virtio_console.ko is loaded
> before remoteproc.ko.

There is nothing about module load ordering in my patch. What
virtio_console does or does not doesn't depend on the remoteproc module
being loaded or not. It only depends on .config.

This is true for both IS_ENABLED() and IS_REACHABLE() which both
evaluate to a constant known at compile time.

And already now it can happen that the virtio_console init code runs
before remoteproc is properly loaded.

Having said that your mail just confuses me more than it helps.

The problem I thought there is and that made me propose my patch doesn't
exist. So I suggest we just drop the patch and the discussion.

Best regards
Uwe

--5yawypp2wpqlzvds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmezXoEACgkQj4D7WH0S
/k6dhAgAg6ULV4QetXhbVDz/LC/H+OPXIxD2pxT2t34iejoU0E46UekQwbAPoAEW
nhsq5aG7Nv+J0dYult1rN39eEDWo05NXonBQKgV5jDy0n8B0iV7CqZVpZk9Oyp6+
YyDGzI8u2emU4pMyNx9lbNj9AvI8bi4FlzeBKYZe+GCI3r551RUT1OYe4JjGvwDW
JgqtMTA451OWGbdZzkzzap7IfTVO0ErdibdPPAMaybMnx6y/LpuaDUNQAXtjWLA0
CLAQBGNJlXuz33gDNn50Fv/4XhP/CsuwBwuUeFzvaubWAz/yKvehZRLxOhP+6bxX
b02pmHiG4xdM3VHcVyCf+RGRXI3vxA==
=xm/J
-----END PGP SIGNATURE-----

--5yawypp2wpqlzvds--
