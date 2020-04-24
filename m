From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Date: Fri, 24 Apr 2020 11:42:48 +0100
Message-ID: <20200424104248.GB174193@stefanha-x1.localdomain>
References: <20200423123717.139141-1-stefanha@redhat.com>
 <20200423141338.GA29646@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200423141338.GA29646@infradead.org>
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: virtualization@lists.linux-foundation.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Lance Digby <ldigby@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 07:13:38AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 23, 2020 at 01:37:17PM +0100, Stefan Hajnoczi wrote:
> > A virtio_blk block device can still be referenced after hot unplug by
> > userspace processes that hold the file descriptor.  In this case
> > virtblk_getgeo() can be invoked after virtblk_remove() was called.  For
> > example, a program that has /dev/vdb open can call ioctl(HDIO_GETGEO)
> > after hot unplug.
> >=20
> > Fix this by clearing vblk->disk->private_data and checking that the
> > virtio_blk driver instance is still around in virtblk_getgeo().
> >=20
> > Note that the virtblk_getgeo() function itself is guaranteed to remain
> > in memory after hot unplug because the virtio_blk module refcount is
> > still held while a block device reference exists.
> >=20
> > Originally-by: Lance Digby <ldigby@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/block/virtio_blk.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 93468b7c6701..b50cdf37a6f7 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -300,6 +300,10 @@ static int virtblk_getgeo(struct block_device *bd,=
 struct hd_geometry *geo)
> >  {
> >  =09struct virtio_blk *vblk =3D bd->bd_disk->private_data;
> > =20
> > +=09/* Driver instance has been removed */
> > +=09if (!vblk)
> > +=09=09return -ENOTTY;
>=20
> If this ever hits you have a nasty race condition and this is not
> going to fix it, as it could be removed just after this check as well.

Perhaps a better fix is to keep a refcount in struct virtio_blk and
implement block_device_operations->release() to decrement the refcount.

That way the struct virtio_blk stays around until all block device
references are dropped.  This is similar to nbd_put() in
drivers/block/nbd.c.

Stefan

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6iwqgACgkQnKSrs4Gr
c8gkBQgAwHhtsW9ZXLDZXqp0Kkfsefk/q7JtsVeNejQKlMtOxFqaksestEjC6QvD
i1eTIlK/eNKdy6dfYcLANEpE4GQWxfYcdRGjVFiEghbpyOxCqbhk+Tj2PYIEpczs
Hs0l/nnEN07+hP7nI+owGGdpPN3USN8ZPGJyUOEVjPMT10wYbU5msh2sFnPGGAcU
NbCMJQq6PaNij35r1AL8GdimGQ6lqjnMoTbL1ex9Jrf1KzBoYBBJckK/JkDd1v59
5DsDbjTkDFcaRHKJzf3iuxg8a0AzGXQKudwiS2rGzVirxwVQN1RAi5yHBZnLJ0uT
C0Q7z66olBCYP+IxjOpt5ZtA7X8H6A==
=+zCT
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
