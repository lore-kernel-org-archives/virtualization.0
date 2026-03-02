Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0E3E95AA
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457836; cv=none; b=MHKOUAoVjp8tcAPDPw/2d02E0lXIm04Cf5105u5g0PF2ziCAVP0arqxRMJM/Fg812+4BQdPvBBbIyUYTWrBj06K5iGeKkGM0g5eep9yThSWJ+/yNMFwKDm8YhAdTAGReqeYv/5b2shL+qgXfKkC4zzdGqhge1h+TdNhObz3F5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457836; c=relaxed/simple;
	bh=18EBpo8SQYyktsR06lBYxbFBYGzGGtPvL53FnsAC18s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I83qNqDS++72qum+GE3L0603bVLMCjvw+KJ4w8Z488FApKK52DoO/OzFi24OA00OxRfmZ9+b+waxKU/2TRyopCgolv5hCTIjfdEupnbEP7A1tvO6xJ5op/spdDNk6o5pBfeSeId/EIC2FqKR8CHqzdw7fuT+er0gDWJii4vqx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx3FR-0003AT-V7; Mon, 02 Mar 2026 14:23:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx3FO-003O8m-0M;
	Mon, 02 Mar 2026 14:23:43 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 024734F52A9;
	Mon, 02 Mar 2026 13:23:42 +0000 (UTC)
Date: Mon, 2 Mar 2026 14:23:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-can@vger.kernel.org, virtualization@lists.linux.dev, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <20260302-condor-of-nonconcrete-infinity-d3ddbb-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <aZRB7Reu/D6HvRcb@fedora>
 <20260302-mighty-wondrous-seagull-75085c-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jjf747iukq7iwcfs"
Content-Disposition: inline
In-Reply-To: <20260302-mighty-wondrous-seagull-75085c-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtualization@lists.linux.dev


--jjf747iukq7iwcfs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
MIME-Version: 1.0

On 02.03.2026 11:30:34, Marc Kleine-Budde wrote:
> > +static int virtio_can_open(struct net_device *ndev)
> > +{
> > +	virtio_can_start(ndev);
> > +
> > +	netif_start_queue(ndev);
> > +
> > +	return 0;
> > +}
>
> Is open_candev() missing? The CAN framework requires drivers to call
> open_candev() in their ndo_open handler. open_candev() validates that
> bittiming has been configured (returns -EINVAL if bitrate is 0), checks
> CAN FD data bitrate requirements, and manages carrier state. Without this
> call, can the device be brought up without configuring bitrate? The driver
> does call close_candev() in virtio_can_close(), showing awareness of the
> CAN lifecycle. Every other CAN driver in the kernel calls open_candev() in
> its open function.

This is true for physical CAN devices, so let's clarify things for
virtio.

As far as I can see, there's no interface to get/set the bit timing/bit
rate from the guest, right?

You can set bittiming.bitrate to CAN_BITRATE_UNKNOWN, remove the
netif_carrier handling from virtio_can_start() and use open_candev().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jjf747iukq7iwcfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaWPXAAKCRDMOmT6rpmt
0j0sAPwNAyAFG5YK/f5xejIGQh7RF86VwBOnSvklT3BlxI/mGAEA1ykl58Tu/t9i
lgQZ62GUmRw45Q4HQRlg+agWhiq+YQE=
=eIYn
-----END PGP SIGNATURE-----

--jjf747iukq7iwcfs--
