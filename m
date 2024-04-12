Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20156B9F
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924953; cv=none; b=dzRog8kdSlQbsVoXHK4ttlfauuxGymPMW3okGuDWKZ7qImcJn6h7iTvEBIZbQDvx3P2XfpqSOYymxrc2aH+9TqhfAldNnWr4vMxkuBF0v3/mxnhbEENSRbqBG909VtUlpli671xZSTXt3uYDQ0VIOFimlsVaEBLqWojNRhvn2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924953; c=relaxed/simple;
	bh=jHNxvSQpxO59xfjT/gyQrb8cvyhAHCTGkRIauX5Hw2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXmOpCPPYdwD4N4uxj6wCBpcrlc2BT/GVTnlVa/ue2dNJ4gkVzYKBG8L8I1JYQco+JobdRaf7e2+yqQnvEwTrqOLdKNn6Uwv1gWGIsaqbvJzss9hG7DbPMbIH5S90b+0nbeDTTADKOwP3APGrRuTgXVkZncIffoJ6vHZGHtNI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvG1e-000701-VQ; Fri, 12 Apr 2024 14:29:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvG1d-00BsDM-FF; Fri, 12 Apr 2024 14:29:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvG1d-000AT0-1F;
	Fri, 12 Apr 2024 14:29:01 +0200
Date: Fri, 12 Apr 2024 14:29:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH] virtio-mmio: Convert to platform remove callback
 returning void
Message-ID: <pweeconqpltug34tocjnk2i3sdqljvucwmndqprnlfusrle2lq@4rytnwrmjsnc>
References: <ef71f955531d5e41b20d801e1149bb08d155679a.1709886922.git.u.kleine-koenig@pengutronix.de>
 <20240308121725-mutt-send-email-mst@kernel.org>
 <jsfldiklmu45j72rp7rqlpxfrgzjvpjmz664zsuvaetz4t2h5f@2hiy3huvrukc>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="biob5otnyxfgqphy"
Content-Disposition: inline
In-Reply-To: <jsfldiklmu45j72rp7rqlpxfrgzjvpjmz664zsuvaetz4t2h5f@2hiy3huvrukc>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtualization@lists.linux.dev


--biob5otnyxfgqphy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 07:46:30PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Michael,
>=20
> On Fri, Mar 08, 2024 at 12:18:26PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Mar 08, 2024 at 09:51:20AM +0100, Uwe Kleine-K=F6nig wrote:
> > > The .remove() callback for a platform driver returns an int which mak=
es
> > > many driver authors wrongly assume it's possible to do error handling=
 by
> > > returning an error code. However the value returned is ignored (apart
> > > from emitting a warning) and this typically results in resource leaks.
> > >=20
> > > To improve here there is a quest to make the remove callback return
> > > void. In the first step of this quest all drivers are converted to
> > > .remove_new(), which already returns void. Eventually after all drive=
rs
> > > are converted, .remove_new() will be renamed to .remove().
> > >=20
> > > Trivially convert this driver from always returning zero in the remove
> > > callback to the void returning variant.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > do u want me to merge this?
>=20
> I have no merge plan, so if you take it, that would be great.

It seems you didn't merge it yet (at least the patch isn't in next). It
would be great if this patch made it in during the next merge window as
I intend to change struct platform_driver::remove in the merge window
leading to 6.11.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--biob5otnyxfgqphy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZKQwACgkQj4D7WH0S
/k5dcAgAnRLSmV6NXK6Do6rU4y9teSnGyzqR0lWBFoEoN+MhjaHa/TGIhRv4q3rg
K0m2Qvp4tSu6iJZ9ZD9RxcxmzmmOXIJ8b1eEzrHgA4B26ASyQpKlws2z1Nsw113f
N5/PtlFK1k7aw/yGicTEh3dTkxz/UqMjE934ogLQFjHircgsXMNNFuAcDBGFPSvl
zo4/RfK31pDdBdyYJn7F22Zs51OMwDZIHpMCeO6i6MePb69uMynWOqE8yGG1PJI3
Nltr9c8LPeycbYIf0g9vk8orSkTlikxZfTnUbB/Rl4i9Mg+22/LRVHRlk3u1LQhG
nWOi4ucNZRGvwAMahg25kRK306pXww==
=AfDo
-----END PGP SIGNATURE-----

--biob5otnyxfgqphy--
