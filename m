Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8143AFB13
	for <virtualization@lists.linux.dev>; Sat, 30 May 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780149383; cv=none; b=heOJ0/0pxyPxSCYw9LQFOBDwPoPiXb2FVEg/3/EPIbuWveJbXlpaYlq9UI/164TRl3twlFcVQyI3cbOFG9kAq8zVRex+vdFoa3N1OOyzFatbbgh9dXiXGZK70QQnC8MQ7pb8uJ3wTMz6CbrFhdnWN4HyP84q4pNpf+TgbSc93HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780149383; c=relaxed/simple;
	bh=YMvgpgeBNQFZf/mfS5MLvMZ3xo+WZclkLGl8IUtEEMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfVow9d+6Ec17pwLzB2p48pehdsR5MzIDXqT6xvuY1QjbxQWfn0YEXGtVB54Tbhpg/QF6u5M/utFv3B8uEHCH03RbdVR8DNOWnno/HBYColmfgTZD6yx1ly+0+Ii7W1LYPsr6PSOm/YPlIuNcs8f3UjRkhqHzASS3uTs0/jxUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=f7+rYxJL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="f7+rYxJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=YMvg
	pgeBNQFZf/mfS5MLvMZ3xo+WZclkLGl8IUtEEMM=; b=f7+rYxJLtwA2keuan1TL
	/UVl7gUppwFel7hmBilvw/viU72F+MgK3t3mKfd/skmMc8P+k4I9lklFyUG1Smhk
	G3HPHO7j1grf7QiljwWvSJ/mVwMI3M7p4VCIp4AbAT4iRtylAckw/59BoE84gzX+
	5rufuLdLmt1NDlu9xJZz2ULuEudq/jWtsGF/SgSlil+ZNOH9Utf7nts0E1XNe00o
	tKKfoBWdJuB31O44TV5l2VwVH5rB6+t+xOPvCpRUAR1nPKL2z2x5PYeQO2Ar8+AW
	4FhmvsSqiQXD9KUlaD1JWYfivohVzUjcqtzxves6GnurUl4OlYbW27oxfYvqzFnn
	aA==
Received: (qmail 1761302 invoked from network); 30 May 2026 15:56:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 May 2026 15:56:18 +0200
X-UD-Smtp-Session: l3s3148p1@+FpTUwlTJMEqAQ4KEBW5QLbOwWyJKVt/
Date: Sat, 30 May 2026 15:56:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: BouziguesAlexis@johndeere.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: virtio: mark device ready before registering the
 adapter
Message-ID: <ahrsgR99iHrlcRES@shikoro>
References: <20260529-virtio-i2c-driver-ok-v1-1-ecf2504f6a56@JohnDeere.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JM/lZ+vA41vYZQH2"
Content-Disposition: inline
In-Reply-To: <20260529-virtio-i2c-driver-ok-v1-1-ecf2504f6a56@JohnDeere.com>


--JM/lZ+vA41vYZQH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 09:28:14AM -0500, Alexis Bouzigues via B4 Relay wro=
te:
> From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
>=20
> virtio_i2c_probe() synchronously probes child i2c drivers on the bus,
> but peripherals may use the bus at probe for tasks like reading a chip
> id. The vhost-user-i2c backend stalls at such probes unless DRIVER_OK
> is already set before the virtqueue is first kicked.
>=20
> Set DRIVER_OK explicitly before i2c_add_adapter(), as done for the
> same reason in commit f5866db64f34 ("virtio_console: enable VQs
> early") and commit 71e4b8bf0482 ("virtio_rpmsg: set DRIVER_OK before
> using device").
>=20
> Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>

Applied to for-current, thanks!


--JM/lZ+vA41vYZQH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoa7IEACgkQFA3kzBSg
KbaR7Q/8DkfG3Q2f7HJIF84gSfLeygb8Dc6ZmJSF0SyU4APZlAL5svYMCSlYILVX
cBppfGzwgrIe/9ECLui81zcX3d3EDwzFsmjxMTDqcU7kyTJ8X+FDJ5alrAUul1Mc
9579mC2LjgMLYfi305/9/cFO7pivE1naStxR0rNCBp4jVCa2mgRCkR6w15fsfDYV
ea78rQ4ESyF1MIc+xVkom7YsACo+wZ/tRf8juwrhcd8ejMUQ76mMMvbrY8pj3Fcj
rbG3gLxfKjH0XT6kt5pZsMVg8AlDRWij4gRqhIRMhf0kltEFJGDrAENH3/YeClUK
EqCXgmLiFa2EPjtmpLhE8i3eQJLlo4ER+zFnkpW88ABUf4HiCY5+KdYxY9XurYRQ
w2XESu73ixAFmNX5YWyjrZja/dY4oyXg8Ei7yB6S++KYk4+g0e0hRmkX5zgWX8Xs
TAKZu8qrnjpv+/dTba8N7NcP74IKA9z2bCPLKsL6ZyfitwZmUohH0lisqLurgArT
l2OSaf0Bi4L5kY2GNx4RQvoSZCah8yolVIkwfsQOBHLonnKbJkJmJeA3DOYm8wL7
ZpUbSfi8ySYDKZ/I8l3zuS2eSDDmUrlJ6dYnk72P+PK/XNl20o5fFEM8nd8e9O9Y
tofLG5wPmL60z3EKYEcwLEPRZaXATeHNvnutFn3nSeecmYMnMdU=
=jpHC
-----END PGP SIGNATURE-----

--JM/lZ+vA41vYZQH2--
