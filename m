From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 06/20] virtio: endianness checks for
	virtio 1.0 devices
Date: Thu, 22 Jan 2015 12:54:09 +1100
Message-ID: <20150122015409.GH27371__48131.9489110776$1421893538$gmane$org@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-7-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2246565792450752719=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-7-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============2246565792450752719==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:08PM +0100, Cornelia Huck wrote:
> Add code that checks for the VERSION_1 feature bit in order to make
> decisions about the device's endianness. This allows us to support
> transitional devices.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/virtio/virtio.c                |    6 +++++-
>  include/hw/virtio/virtio-access.h |    4 ++++
>  include/hw/virtio/virtio.h        |    8 ++++++--
>  3 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 7f74ae5..8f69ffa 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -881,7 +881,11 @@ static bool virtio_device_endian_needed(void *opaque)
>      VirtIODevice *vdev =3D opaque;
> =20
>      assert(vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> -    return vdev->device_endian !=3D virtio_default_endian();
> +    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        return vdev->device_endian !=3D virtio_default_endian();
> +    }
> +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +    return vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_LITTLE;

This doesn't seem quite right.  Since virtio 1.0 is always LE, this
should just assert that device_endian =3D=3D LE and return false,
right?

>  }
> =20
>  static const VMStateDescription vmstate_virtio_device_endian =3D {
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
> index 46456fd..ee28c21 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -19,6 +19,10 @@
> =20
>  static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>  {
> +    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +        return false;
> +    }
>  #if defined(TARGET_IS_BIENDIAN)
>      return virtio_is_big_endian(vdev);
>  #elif defined(TARGET_WORDS_BIGENDIAN)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 08141c7..68c40db 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -297,7 +297,11 @@ static inline bool virtio_has_feature(VirtIODevice *=
vdev, unsigned int fbit)
> =20
>  static inline bool virtio_is_big_endian(VirtIODevice *vdev)
>  {
> -    assert(vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> -    return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_BIG;
> +    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        assert(vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> +        return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_BIG;
> +    }
> +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +    return false;
>  }
>  #endif

AFAICT, the only real difference between virtio_is_big_endian() and
virtio_access_is_big_endian() is that the latter will become
compile-time constant on targets that don't do bi-endian.

With virtio 1.0 support, that's no longer true, so those two macros
should just be merged, I think.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BXr400anF0jyguTS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFhBAAoJEGw4ysog2bOS8CYQAN1jxel1VT6iZ5CltYe0kbCx
9EgBzsMXOwLSTeVin+iX6G5Gzdy9cqQ0vbSLc1HRJ0bhfQD5Xsj9NjiWfg4/HHMj
HnTFbCjdTzw9l/EdssnH0jkITRJY6V/P5J9xLH88bfiYNpHh3Q6s9EbVN9TwYZZc
kdEvfzW3eSdwwmN980OSzx44yYOY1kkqUIA/6whRKCmBLepgjqZLTSptrrTFY/nk
TRs6+iNvV/KDvLuLgGdR0vxx/Y8RKUZSCp/SXh19qHWLQoYZR1OoykF5TB+owHXX
Z1EhFQ1bRfqZRQH6iyjbhTGxz4EUFhACpAkky7wBuOQeumqlRKlzw0dGhwKWsSRW
2Vqo8JrDnkVNYcv6ZrmlGTzFMje6aYTFOsjpl/oybwT+FqdTQD/tlxMPD+Rh4ofT
UxkDskiYEHyK5S4POFE8EWaoKRFShPqHipAGIzLLjAJjuO5c4y/l55FWiWsQMzZe
CAHVyQ29IJYkcV9zGhnWr9ddlOAX1p2eJXc4OzhAjQvr0MdyAWbKbcSpGoVkRbK1
6c4+FmrgFTVT+krJgF+cQU7A9TUIYXbcSs6cmL2ttdJ8g+07kYYQ9s62ZsmfKmUM
O9Fdc8exCcYResQxBgOtdNnOjt5nXLvWWyRtG1DXXNjhjhEIQyfB8vVxH3Xa5V5q
phAXWhYdLO55Gb9H1pP1
=iaM3
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--

--===============2246565792450752719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2246565792450752719==--
