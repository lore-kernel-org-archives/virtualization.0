From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC 12/13] vhost/vsock: switch to the buf API
Date: Fri, 5 Jun 2020 09:36:52 +0100
Message-ID: <20200605083652.GC59410@stefanha-x1.localdomain>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-13-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200602130543.578420-13-mst@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 09:06:22AM -0400, Michael S. Tsirkin wrote:
> A straight-forward conversion.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7aBCQACgkQnKSrs4Gr
c8iqrgf/W5qzuVqOztDa26raKxGSK1HW1tigkHdgjm6LUcghCLUBNVTqklvPgnVt
8n0X/em12Ztmj43uNCuw0U+4ZpTZjibzwlvp4QnFw8nVsLtdMZIR9nAORPM/9Lbq
cihrvmGGikfHp5Rlj76nOnVODooOuQEI+S0ii+m5uKGEE3Y2z5n0LIh8j1p5Ms0k
Xr5j9JKZ5mHH9ZYA6c79KVPPn7k18+4H5aSr5GPr3gsrUR8jSJhUhub1H6tAwKoB
Tg+68nP4BA7Gcowm+QE22SwmmT1YEmjLKydYLH0bP2NewcRqh10Dw3DsV2fMU8BN
3LEoQfYetWn383ZxfvbNLNO8JCQ4wQ==
=D/8f
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
