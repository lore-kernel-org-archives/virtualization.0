From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 07/20] virtio: allow virtio-1 queue
	layout
Date: Thu, 29 Jan 2015 11:14:24 +1100
Message-ID: <20150129001424.GF14681@voom>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-8-git-send-email-cornelia.huck@de.ibm.com>
	<20150122020609.GI27371@voom.fritz.box>
	<20150128170701.4788fd09.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6819557591846783114=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150128170701.4788fd09.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============6819557591846783114==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 05:07:01PM +0100, Cornelia Huck wrote:
> On Thu, 22 Jan 2015 13:06:09 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Dec 11, 2014 at 02:25:09PM +0100, Cornelia Huck wrote:
> > > For virtio-1 devices, we allow a more complex queue layout that doesn=
't
> > > require descriptor table and rings on a physically-contigous memory a=
rea:
> > > add virtio_queue_set_rings() to allow transports to set this up.
> > >=20
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > ---
> > >  hw/virtio/virtio-mmio.c    |    3 +++
> > >  hw/virtio/virtio.c         |   53 ++++++++++++++++++++++++++++------=
----------
> > >  include/hw/virtio/virtio.h |    3 +++
> > >  3 files changed, 40 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > > index 43b7e02..0c9b63b 100644
> > > --- a/hw/virtio/virtio-mmio.c
> > > +++ b/hw/virtio/virtio-mmio.c
> > > @@ -244,8 +244,11 @@ static void virtio_mmio_write(void *opaque, hwad=
dr offset, uint64_t value,
> > >      case VIRTIO_MMIO_QUEUENUM:
> > >          DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEU=
E_MAX_SIZE);
> > >          virtio_queue_set_num(vdev, vdev->queue_sel, value);
> > > +        /* Note: only call this function for legacy devices */
> >=20
> > It's not clear to me if this is an assertion that this *does* only
> > call the function for legacy devices or a fixme, that it *should* only
> > call the function for legacy devices.
>=20
> It's more like a note to whoever takes the virtio-mmio legacy device
> code and writes a virtio-1 virtio-mmio device.
>=20
> Does
> /* Note: this function must only be called for legacy devices */
> make that intention clearer?

Yes, I think that's better.

>=20
> >=20
> > > +        virtio_queue_update_rings(vdev, vdev->queue_sel);
> > >          break;
> > >      case VIRTIO_MMIO_QUEUEALIGN:
> > > +        /* Note: this is only valid for legacy devices */
> > >          virtio_queue_set_align(vdev, vdev->queue_sel, value);
> > >          break;
> > >      case VIRTIO_MMIO_QUEUEPFN:
>=20
> (...)
>=20
> > >  /* virt queue functions */
> > > -static void virtqueue_init(VirtQueue *vq)
> > > +void virtio_queue_update_rings(VirtIODevice *vdev, int n)
> >=20
> > Perhaps something in the name to emphasise that this is only for <v1.0
> > devices?
>=20
> virtio_queue_legacy_update_rings()? Maybe a bit long...

There aren't many callers, so I think long is ok in this case.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyXtgAAoJEGw4ysog2bOSS5wQALHFbhSCWB6Ipc0XVYQKzm+I
5gx53xEeV/eYdfqYLuHeKsOAyCuGHVluktIe0fK5l37MeFLa/mz/gg8HWuCJ2lmq
V/eCWJ6bnKWPL27gmFkU/HJ34O6X39Ke/te7j06ZAwIUBUFYZJwEr4q5tmKL+k9k
6tB3ojBzEoQwpRUBSGSNY9e7GJScCla0BooV/zdwHcOZhPSFJILheXz7v69N5pya
3eqQoeXf8OqBQcEzy6XrSu73etmjiykBIUKH9/OF2F5K7/IBSXU1zcUbHGSQ2H4P
Mszkb1WYMp8R2rP59PYgDlbiR7Uf0MAY77y7LAsr1BXUk+qoE0SVvoz/Hg6JrdD+
KUz98FZ6CQ0eu0Ltu97sIuu8QzTEB5vLSfhH9+cAG9B2OB7eVN/5vCOHvQWacCvE
4c5OkYJZKFnmVR3QZFAHap9f2HXVoYFLLj5wC+opV9wJ05U/Q4nweECGtrPNgjde
rSkhYQCJVIuE7AEjAJzADvtfHr1NU8DkOC7usllbFsU9w9wMd4jdOEP5ndSNehFM
OmbyPFCpKTrKVUxMvLfk2YPu8RKSpxZFRoI0qtR7sb/hylBcnBqRMRgOIi3CPp/X
lCaujlf3sSPg6Luvz3H1O4wfOmMXtFe1FBjxboifzf0DnGMisUqmQuW3EfkuC0uZ
LPbtEfjNO6z0/YcmJiDb
=yW4b
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--

--===============6819557591846783114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6819557591846783114==--
