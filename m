From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH RESEND 1/3] Drivers: hv: Support the newly introduced KVP
	messages in the driver
Date: Fri, 16 Mar 2012 18:01:45 +0300
Message-ID: <20120316150145.GK3163@mwanda>
References: <1331910089-5207-1-git-send-email-kys@microsoft.com>
	<1331910147-5259-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1517557631=="
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1331910147-5259-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@linuxfoundation.org, virtualization@lists.osdl.org, ohering@suse.com, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org


--===============1517557631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3W6riq+uV6J42Ub"
Content-Disposition: inline


--u3W6riq+uV6J42Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 08:02:25AM -0700, K. Y. Srinivasan wrote:
> Support the newly defined KVP message types. It turns out that the host
> pushes a set of standard key value pairs as soon as the guest opens the K=
VP channel.
> Since we cannot handle these tuples until the user level daemon loads up,=
 defer
> reading the KVP channel until the user level daemon is launched.
>=20
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Great.  Thanks for doing this.

regards,
dan carpenter


--u3W6riq+uV6J42Ub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY1XYAAoJEOnZkXI/YHqR9DYP/2d+ZuJEuNxXeFBqHZIruKNp
Q+RjGbXWqwifTbdoDd/0N2vp3xSAJj9+citaZK59ubeKllvaEvnaGts2nHkqnm8L
QW1bT7Cs93wCVNJLYHT9khYNjiTlPSyzg0RmtC1+h3veqHPxNuOCgXVCMfYt50d6
N9rI2LHi4ri4AgEsk/b586pJhHgkxy58XiSrkkmIz7UDkDQvTU6QfrreR6fSC1FG
Cmb+yfcurC1QDDoJp1nG9wyQafrSet7rGIABfHxayVgMJCv3xSGOImrUcz4YMqCA
9kDLSNVJP8K+8zlBBPd2I1S2JwbMfQ4enVi/QUXeiRuyInfzO39DHKu+wZkoNAG3
GE4Jczzx5ju3bFcmYrc76UMz/DPlh3DjheNi/gKSVFBnH24fqVz8hOIMyoyu6On6
u3FhKJu+IDDh6KMHS6Aj96PQtwKLtcVXHaTqYHD/a04Xf4+Cgi41ROPXbPubuhQE
j5eAq212W1uB5Qp+CiSjnBoY4Q1UE8YMQDgqs99xI2AIY6A/oZ4Ftbiv+ely2DFi
bAfFypZx383nGmQUmLPs2v1f2EVEFzEoF5N8UfWsd0ztexhYyHdtRluKtMoHDgQu
2p2VNCcb/z5xEnJYyI0RZ4pfZyymlC6HtbPN1LfdKbt/FINdyS9XceX3/InSuHe3
QLMSXoCiGtUDvTtlkfWr
=NVdi
-----END PGP SIGNATURE-----

--u3W6riq+uV6J42Ub--

--===============1517557631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--===============1517557631==--
