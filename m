From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/bochs: add drm_driver.release callback.
Date: Fri, 7 Feb 2020 14:15:16 +0100
Message-ID: <e1b86bba-ffc2-3c2e-6e6d-b58074072dcc@suse.de>
References: <20200207121312.25296-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207121312.25296-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1
Content-Type: multipart/mixed; boundary="roUT122ea9dVbbMdoLRaORWXJWNLO7PGu";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>
Message-ID: <e1b86bba-ffc2-3c2e-6e6d-b58074072dcc@suse.de>
Subject: Re: [PATCH] drm/bochs: add drm_driver.release callback.
References: <20200207121312.25296-1-kraxel@redhat.com>
In-Reply-To: <20200207121312.25296-1-kraxel@redhat.com>

--roUT122ea9dVbbMdoLRaORWXJWNLO7PGu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 07.02.20 um 13:13 schrieb Gerd Hoffmann:
> From: Gurchetan Singh <gurchetansingh@chromium.org>
>=20
> Move bochs_unload call from bochs_remove() to the new bochs_release()
> callback.  Also call drm_dev_unregister() first in bochs_remove().
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/=
bochs_drv.c
> index 10460878414e..87ee1eb21a4d 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -60,6 +60,11 @@ static int bochs_load(struct drm_device *dev)
> =20
>  DEFINE_DRM_GEM_FOPS(bochs_fops);
> =20
> +static void bochs_release(struct drm_device *dev)
> +{
> +	bochs_unload(dev);
> +}
> +
>  static struct drm_driver bochs_driver =3D {
>  	.driver_features	=3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>  	.fops			=3D &bochs_fops,
> @@ -69,6 +74,7 @@ static struct drm_driver bochs_driver =3D {
>  	.major			=3D 1,
>  	.minor			=3D 0,
>  	DRM_GEM_VRAM_DRIVER,
> +	.release                =3D bochs_release,
>  };
> =20
>  /* -------------------------------------------------------------------=
--- */
> @@ -148,9 +154,8 @@ static void bochs_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev =3D pci_get_drvdata(pdev);
> =20
> -	drm_atomic_helper_shutdown(dev);
>  	drm_dev_unregister(dev);
> -	bochs_unload(dev);
> +	drm_atomic_helper_shutdown(dev);
>  	drm_dev_put(dev);
>  }
> =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--roUT122ea9dVbbMdoLRaORWXJWNLO7PGu--

--SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl49YuQACgkQaA3BHVML
eiMIagf7BLAgwaxEZQ+WpNM3sl5Rvo6p8Ig5y87QonriAW9AtUkCkl3Gaf3P3XSj
/175Sb8DOrQbjTeXjo8oo4k3dLzGEpc6J+2FJkkflAQDAGlrj04HA60zNJnxY2KG
BUNALqPd1NXHSlnP518mudWwK4lHQ6lCCRys7X0aix0srjBgBy5VEaCA3BVMepRp
5IePxEKXzcLD2cy0oJGgosDaXtfyUcXwktTwUCirZ0V/cxzhNk30oZPWa8CyUh0r
EwXit075NrZ8/8W9DhN/YhvA6jolUwbuoUFUKWD1qFnaaINYEHdI5YjzLkriI7WJ
BtqNDK0JaWJYojTeAkHGtb2n9xIqFg==
=872b
-----END PGP SIGNATURE-----

--SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1--
