From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vhost/scsi: fix up req type endian-ness
Date: Mon, 13 Jul 2020 10:29:49 +0100
Message-ID: <20200713092949.GE28639@stefanha-x1.localdomain>
References: <20200710104849.406023-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200710104849.406023-1-mst@redhat.com>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 06:48:51AM -0400, Michael S. Tsirkin wrote:
> vhost/scsi doesn't handle type conversion correctly
> for request type when using virtio 1.0 and up for BE,
> or cross-endian platforms.
>=20
> Fix it up using vhost_32_to_cpu.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8MKY0ACgkQnKSrs4Gr
c8gQOQf+KmgjzVnEXU62hGmZBNsGZ9+2r2VBviBdhlBL0AB0927CK0A8v4HXZ/5+
8Y6UwKNT0GZnj67/+PBXAVvJm4Jny+4TTgTafuZY0gnlNZKS6PpmSoztnzwjqtgI
ddm2TVEWDF/lDZNRcWZ1a0cURg8If2ZQPxNepxT3uqa5LnbYXiwuIlnFG6eetsHV
Cl751SmdjCSXzCDBvEE6eboXtzt3ok1TWIx3L2jU034AyexssehBz6C0G9LVQhau
pVJs0q2BfsF95xxX6k2Bo/8Paj4EqzUKxG4jEXteR9SIHwZH3anw0PKPygh96FWF
XrsnZG1MAaXY8ybmuVlQkaJofLFlMA==
=4fi+
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
