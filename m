Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55901E48A
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786592; cv=none; b=B6CU/a98YfMT4ZeI+BwU/uGJkqjGEe9POdpf/vhnczPFYUJqbSvoq/awJSWN3HXiAwwaT+VgoFTFUw9fU2he3h9NAn7qRnTE3tgYJ+TqJmgNfywAXU80A9hm3IxuY8ewsRJUv79h2X0YXLjoH9fi4AUSvuPnHcYpzx3sf+CAqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786592; c=relaxed/simple;
	bh=zD5ceLjbuXPe6+5fOTicgv3WUEXkziJ/7+hhKU7mWaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i813ybZykTK8MY5aR3QKBagaDBTJM1VTYZ7FHpeEO5EtqOZg5Ffh8oD1bUAntoRBSq36yzf2wqltw8BikvaKphFxk0vRhUZjZ65VZQ0R8JMZTjXo3IHfKZvZnqEvVcmG22ioHijcAso1yOQX5qYriIdv70Vt4IKS558HMoYT7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tsMFk-0006Gj-GU; Wed, 12 Mar 2025 14:36:08 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tsMFi-005Mqb-0w;
	Wed, 12 Mar 2025 14:36:06 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DFFB73D8DBF;
	Wed, 12 Mar 2025 13:36:05 +0000 (UTC)
Date: Wed, 12 Mar 2025 14:36:05 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Harald Mommer <harald.mommer@opensynergy.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
 <Z9GL6o01fuhTbHWO@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vs4q5lbuhwsinm4l"
Content-Disposition: inline
In-Reply-To: <Z9GL6o01fuhTbHWO@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtualization@lists.linux.dev


--vs4q5lbuhwsinm4l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
MIME-Version: 1.0

On 12.03.2025 14:28:10, Matias Ezequiel Vara Larsen wrote:
> On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> > On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > > Hello,
> > > >=20
> > > > I thought there would be some more comments coming and I could addr=
ess
> > > > everything in one chunk. Not the case, besides your comments silenc=
e.
> > > >=20
> > > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > >=20
> > > > > Hi,
> > > > > a few nits below, should there be a v6.
> > > > >=20
> > > >=20
> > > > I'm sure there will be but not so soon. Probably after acceptance o=
f the
> > > > virtio CAN specification or after change requests to the specificat=
ion are
> > > > received and the driver has to be adapted to an updated draft.
> > > >=20
> > > What is the status of this series?
> >=20
> > There has been no movement from the Linux side. The patch series is
> > quite extensive. To get this mainline, we need not only a proper Linux
> > CAN driver, but also a proper VirtIO specification.=20
>=20
> Thanks for your answer. AFAIK the spec has been merged (see
> https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4).=20

Yes, the spec was merged. I think it was written with a specific
use-case (IIRC: automotive, Linux on-top of a specific hypervisor) in
mind, in Linux we have other use cases that might not be covered.

> > This whole project is too big for me to do it as a collaborative
> > effort.
>=20
> What do you mean?

I mean the driver is too big to review on a non-paid community based
effort.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vs4q5lbuhwsinm4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfRjcIACgkQDHRl3/mQ
kZzDpAf/X6+oHnjKGYwW4I9Lv9kcQu6D2ENfhcQKgS/Mb01KLJgVym9THvjrXq2p
gsxtzzjHc6kiPBwgrx0CRcqL4lOMmaJOCciAzmeCU+3WYPB8GxJceCk09gw4tJJj
0maj4PsCePgTekqu/hD0Oe5K8rImw2wKn+5xbFBf5fKrgLGyWNLwkoIO2CMj0E89
a1w7czCUBG5F8tpS/ryzfs/kNbXMgCAB0od26HgHOKggYPvL9hqkSMejiVfBsRlu
mM0w7H2GyJHXLnuBQqS7YPNDSPH0/NJSEwo2+AbX30ALhQDK5md3FSgQZ9MaxYj7
OAK+ES+660rBsbPscWDNlk6Q94CdIA==
=hEiz
-----END PGP SIGNATURE-----

--vs4q5lbuhwsinm4l--
