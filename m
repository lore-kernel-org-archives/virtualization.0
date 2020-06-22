From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v9 10/11] vhost/vsock: switch to the buf API
Date: Mon, 22 Jun 2020 10:59:38 +0100
Message-ID: <20200622095938.GB6675@stefanha-x1.localdomain>
References: <20200619182302.850-1-eperezma@redhat.com>
 <20200619182302.850-11-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200619182302.850-11-eperezma@redhat.com>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, kvm list <kvm@vger.kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 08:23:01PM +0200, Eugenio P=E9rez wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
>=20
> A straight-forward conversion.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wgQoACgkQnKSrs4Gr
c8gaawf8CE0r7lmdy1n0zKbFGNwbeFg1iFtb/arJ8/pKg6QjAIlXaL2eYU04kVXV
rOn/oN0avr1ji2MKbCL0eKOV2/FpmKhN0RmT/4mvVMfB7MrT/ooruRUoUBV5FsxE
B0ET9VJG6JuUg0xbp2UP/x3QRYSLYwwTXKkc5WDJCflAAlbOJPjHjuK6Mpubgb4y
vx26gYD2lK36TulNmBjkYiiQx72PE2LyA7Ss6Fe4E/DRCzeVNoDr5XQURcYIXjZw
8x2qTEZ95YrJA/cxr36Po9hlycV4P8QHF/sj6Rq1vlTJgFHSFupE1Z21GCuz3kDV
oqun+r8WanK92bkZqA2GYM5TCvZXZg==
=+yyR
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
