From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 06/20] virtio: endianness checks for
	virtio 1.0 devices
Date: Fri, 23 Jan 2015 17:09:16 +0100
Message-ID: <20150123170916.202400f1@bahia.local>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-7-git-send-email-cornelia.huck@de.ibm.com>
	<20150122015409.GH27371@voom.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3123754739658276377=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150122015409.GH27371@voom.fritz.box>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============3123754739658276377==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/s02LzjgizBBKfYpgdkUKOod"; protocol="application/pgp-signature"

--Sig_/s02LzjgizBBKfYpgdkUKOod
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jan 2015 12:54:09 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Dec 11, 2014 at 02:25:08PM +0100, Cornelia Huck wrote:
> > Add code that checks for the VERSION_1 feature bit in order to make
> > decisions about the device's endianness. This allows us to support
> > transitional devices.
> >=20
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/virtio/virtio.c                |    6 +++++-
> >  include/hw/virtio/virtio-access.h |    4 ++++
> >  include/hw/virtio/virtio.h        |    8 ++++++--
> >  3 files changed, 15 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 7f74ae5..8f69ffa 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -881,7 +881,11 @@ static bool virtio_device_endian_needed(void *opaq=
ue)
> >      VirtIODevice *vdev =3D opaque;
> > =20
> >      assert(vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> > -    return vdev->device_endian !=3D virtio_default_endian();
> > +    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        return vdev->device_endian !=3D virtio_default_endian();
> > +    }
> > +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> > +    return vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_LITTLE;
>=20
> This doesn't seem quite right.  Since virtio 1.0 is always LE, this
> should just assert that device_endian =3D=3D LE and return false,
> right?
>=20

The device_endian field is ONLY used by devices when the software is
legacy.

It is set at device reset time (see virtio_reset()) since we can reasonably
assume that when the software changes endianness, it always reset the device
before using it again (aka. reboot or kexec).

In the case we would have a BE guest, device_endian would be BE, even if the
software is virtio 1.0. So, no, we shouldn't assert.


I had questioned Cornelia about why we care to migrate device_endian when in
virtio 1.0 mode. I got these answers:

https://lists.nongnu.org/archive/html/qemu-devel/2014-10/msg03979.html
https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg03888.html

My understanding is that a transitional device will necessarily be reset
if the software changes from legacy to 1.0 or vice-versa. So, yes, I still
think virtio_device_endian_needed() should return false.

> >  }
> > =20
> >  static const VMStateDescription vmstate_virtio_device_endian =3D {
> > diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virt=
io-access.h
> > index 46456fd..ee28c21 100644
> > --- a/include/hw/virtio/virtio-access.h
> > +++ b/include/hw/virtio/virtio-access.h
> > @@ -19,6 +19,10 @@
> > =20
> >  static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> >  {
> > +    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> > +        return false;
> > +    }
> >  #if defined(TARGET_IS_BIENDIAN)
> >      return virtio_is_big_endian(vdev);
> >  #elif defined(TARGET_WORDS_BIGENDIAN)
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 08141c7..68c40db 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -297,7 +297,11 @@ static inline bool virtio_has_feature(VirtIODevice=
 *vdev, unsigned int fbit)
> > =20
> >  static inline bool virtio_is_big_endian(VirtIODevice *vdev)
> >  {
> > -    assert(vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> > -    return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_BIG;
> > +    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        assert(vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> > +        return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_BIG;
> > +    }
> > +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> > +    return false;
> >  }
> >  #endif
>=20
> AFAICT, the only real difference between virtio_is_big_endian() and
> virtio_access_is_big_endian() is that the latter will become
> compile-time constant on targets that don't do bi-endian.
>=20
> With virtio 1.0 support, that's no longer true, so those two macros
> should just be merged, I think.
>=20


--Sig_/s02LzjgizBBKfYpgdkUKOod
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlTCciwACgkQAvw66wEB28IvowCgiq9EqUxun7aKkhJh4hUue2De
hKQAnRh7QUQnvSCSMAoc1ObvIqxHueZo
=Dn8d
-----END PGP SIGNATURE-----

--Sig_/s02LzjgizBBKfYpgdkUKOod--


--===============3123754739658276377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3123754739658276377==--
