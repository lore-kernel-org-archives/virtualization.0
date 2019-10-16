From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vsock/virtio: remove unused 'work' field from 'struct
	virtio_vsock_pkt'
Date: Wed, 16 Oct 2019 15:50:38 +0100
Message-ID: <20191016145038.GH5487__13063.836439845$1571237452$gmane$org@stefanha-x1.localdomain>
References: <20191015150051.104631-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3943229247751328346=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191015150051.104631-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============3943229247751328346==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 05:00:51PM +0200, Stefano Garzarella wrote:
> The 'work' field was introduced with commit 06a8fc78367d0
> ("VSOCK: Introduce virtio_vsock_common.ko")
> but it is never used in the code, so we can remove it to save
> memory allocated in the per-packet 'struct virtio_vsock_pkt'
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/virtio_vsock.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2nLj4ACgkQnKSrs4Gr
c8hxgQf/fJM59TTkQU6f/aLvKMLRivTzsa1Yz/4hy25NeYI++lHojSBwzdtd1BxY
PF945mWrEnCumX+FOqHdpwX6oRU4bnJ0pc3kzHPrxnLYoyHT1NYNPnEHnaZERFfP
7OdE3RMXooLx+JM7MrIn8Fh/ElR2Bi4JhUw+zOUMEO96aY+HIJ7cAPsDG3QTHinj
TL4WUjSRZEqwfZKvJ0TiydqJR/RKjpNEi1bYrTV9TzW84/5AmWternJ3sS76dH3w
2Qb9yLIBpDSbOnohYQQunrl8VuYdeCw2w0NZc9jsbslAgs6yc5EIE/6PoX//fwOn
Tf1ER5hbSetx0Lk+7Jaw3eVDH5r6Uw==
=GpdO
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--

--===============3943229247751328346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3943229247751328346==--
