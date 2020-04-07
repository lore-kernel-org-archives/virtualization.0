From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v8 09/19] virtio: stop using legacy struct vring in kernel
Date: Tue, 7 Apr 2020 09:51:23 +0100
Message-ID: <20200407085123.GA247777@stefanha-x1.localdomain>
References: <20200407011612.478226-1-mst@redhat.com>
 <20200407011612.478226-10-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200407011612.478226-10-mst@redhat.com>
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 09:16:46PM -0400, Michael S. Tsirkin wrote:
> struct vring (in the uapi directory) and supporting APIs are kept
> around to solely avoid breaking old userspace builds.
> It's not actually part of the UAPI - it was kept in the UAPI
> header by mistake, and using it in kernel isn't necessary
> and prevents us from making changes safely.
> In particular, the APIs actually assume the legacy layout.
>=20
> Add an internal kernel-only struct vring and
> switch everyone to use that.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c       |  1 +
>  include/linux/virtio.h           |  1 -
>  include/linux/virtio_ring.h      | 10 ++++++++++
>  include/linux/vringh.h           |  1 +
>  include/uapi/linux/virtio_ring.h | 26 ++++++++++++++++----------
>  5 files changed, 28 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6MPwoACgkQnKSrs4Gr
c8i4iwf/bOwj2ZidNGGENtcVu7gvojGcqqZUH3YTJ7iTnAiBQzurGIHN6p9vGEal
2cS8Jb9OuArHQhIfm5M/AaSzNa3zmy8D9l2tWRVFAooBSK40l4Q10e5EUkybhClw
ITad9nQtPO0n0IGfFGrJasavS7MBhBJw/7wqNtzkHIxq3I86MKA9aLdefTGmkMVp
+PJjhgvzRzjtmbHL/wIu9+bVEFEmMOIjTgHaOoaYvStvVmOqKEOtoiyyb/hormmM
yLJJOmq4zMKsjpKYeQB4wmFDKtXheVRFrRPASciZEMRS8+dPVBRq7QzzWUdG1Awq
edDSidc+l3t9UZBO/tsqBqQQSC6YNQ==
=wat3
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
