Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C93C32
	for <virtualization@lists.linux.dev>; Fri,  8 Mar 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923604; cv=none; b=kNCpD7EtmFs3HcREN87JpPP/sya70QQoZ5W3np29y5td1r2NDU1+Ko91FTDk5M676fdQ7dO2eEN+tAD/Uo+spqvbYioS1OneK6pARuyD/uqW2ySCLywEl/MJuip6CPG9h7V9M35uWIwOQIt2jEhj8MwqvbRlfC0LRd9x/gaRHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923604; c=relaxed/simple;
	bh=x0j42jhPh/MLbb9JbXocSIltT5lWWPSMGpo2bWMSPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/j2JcRvdTAbkRt9uLKp8LsDeqNSqGPLeNVvq44o0lrGyGZTWeLTm6KrGyiUe91pXQEh3rtUnnE12YyDg5m2jbEDuMhHXW0Ykm2Aykl7fsIv+Cx95TAXNBqvWc2iuKLZC6/B1Ku9DBbEbGQ1N09+PimSAhHvC2FwZHgoh/y0mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rifEm-0008OD-Co; Fri, 08 Mar 2024 19:46:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rifEk-005Bdj-U9; Fri, 08 Mar 2024 19:46:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rifEk-002SPL-2j;
	Fri, 08 Mar 2024 19:46:30 +0100
Date: Fri, 8 Mar 2024 19:46:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH] virtio-mmio: Convert to platform remove callback
 returning void
Message-ID: <jsfldiklmu45j72rp7rqlpxfrgzjvpjmz664zsuvaetz4t2h5f@2hiy3huvrukc>
References: <ef71f955531d5e41b20d801e1149bb08d155679a.1709886922.git.u.kleine-koenig@pengutronix.de>
 <20240308121725-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pacfivvrj6g767f5"
Content-Disposition: inline
In-Reply-To: <20240308121725-mutt-send-email-mst@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtualization@lists.linux.dev


--pacfivvrj6g767f5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Fri, Mar 08, 2024 at 12:18:26PM -0500, Michael S. Tsirkin wrote:
> On Fri, Mar 08, 2024 at 09:51:20AM +0100, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >=20
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> do u want me to merge this?

I have no merge plan, so if you take it, that would be great.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pacfivvrj6g767f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXrXQUACgkQj4D7WH0S
/k785wf/TRoS/GWWgYsmoPJJHWQnXnXuBCn+c8v0RRSGBhiH8F5sHQ7q+o5fIloQ
NHdTdzB8176zAR52iyP4xCsamJ4fgi+8ADXBu/sXGaqkd8s9wt0ZV90TR55OEsJ7
4VXLJPAgQPPeNRkvjyBgIISAP2AzhB4fc951Upx1kdvD2LJnZLcix0fUqx5+iWpG
nEHwt+qZtnVVhwVw2hicJ15pEsRHR/HeV4qHfpD5IN3X9hd0JvJEJ1EQc9q13LLf
ii93u9ZdbSya2pBjpmO9Fd9CkqTKDewHq2UlCGPMnjslQNwrna42TI9ASKEOQisR
pPI/tVpevBujw698rxylSsVYDkrizg==
=Oma0
-----END PGP SIGNATURE-----

--pacfivvrj6g767f5--
