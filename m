From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/cirrus: add drm_driver.release callback.
Date: Fri, 7 Feb 2020 14:16:14 +0100
Message-ID: <04253f60-c374-6eb1-53e9-fff2299658cd@suse.de>
References: <20200207121345.25639-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vWiAiFYFDSjXvdHMKsa0eatJA1wnAmM4k"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207121345.25639-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vWiAiFYFDSjXvdHMKsa0eatJA1wnAmM4k
Content-Type: multipart/mixed; boundary="0UNtBLvA4uOHbcc5wWuhUjblFlWPhipdc";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <04253f60-c374-6eb1-53e9-fff2299658cd@suse.de>
Subject: Re: [PATCH] drm/cirrus: add drm_driver.release callback.
References: <20200207121345.25639-1-kraxel@redhat.com>
In-Reply-To: <20200207121345.25639-1-kraxel@redhat.com>

--0UNtBLvA4uOHbcc5wWuhUjblFlWPhipdc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 07.02.20 um 13:13 schrieb Gerd Hoffmann:
> Move final cleanups from cirrus_pci_remove() to the new callback.
> Add drm_atomic_helper_shutdown() call to cirrus_pci_remove().
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/cirrus/cirrus.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/c=
irrus.c
> index a91fb0d7282c..39a9e964aac9 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -502,6 +502,16 @@ static void cirrus_mode_config_init(struct cirrus_=
device *cirrus)
> =20
>  /* ------------------------------------------------------------------ =
*/
> =20
> +static void cirrus_release(struct drm_device *dev)
> +{
> +	struct cirrus_device *cirrus =3D dev->dev_private;
> +
> +	drm_mode_config_cleanup(dev);
> +	iounmap(cirrus->mmio);
> +	iounmap(cirrus->vram);
> +	kfree(cirrus);
> +}
> +
>  DEFINE_DRM_GEM_FOPS(cirrus_fops);
> =20
>  static struct drm_driver cirrus_driver =3D {
> @@ -515,6 +525,7 @@ static struct drm_driver cirrus_driver =3D {
> =20
>  	.fops		 =3D &cirrus_fops,
>  	DRM_GEM_SHMEM_DRIVER_OPS,
> +	.release         =3D cirrus_release,
>  };
> =20
>  static int cirrus_pci_probe(struct pci_dev *pdev,
> @@ -596,14 +607,10 @@ static int cirrus_pci_probe(struct pci_dev *pdev,=

>  static void cirrus_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev =3D pci_get_drvdata(pdev);
> -	struct cirrus_device *cirrus =3D dev->dev_private;
> =20
>  	drm_dev_unregister(dev);
> -	drm_mode_config_cleanup(dev);
> -	iounmap(cirrus->mmio);
> -	iounmap(cirrus->vram);
> +	drm_atomic_helper_shutdown(dev);
>  	drm_dev_put(dev);
> -	kfree(cirrus);
>  	pci_release_regions(pdev);
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


--0UNtBLvA4uOHbcc5wWuhUjblFlWPhipdc--

--vWiAiFYFDSjXvdHMKsa0eatJA1wnAmM4k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl49Yx4ACgkQaA3BHVML
eiMtXAf/VzMYqgF7SypSGA1bMF0d9GIyj659fF5zNajxoPTbtaxZPtcPDXJCMwoW
iivOqe6ST42//C280daFteKV7wCx7yCww0KnA+X1sPT/6+RQEwKEpLoQovQaa5fM
SBPcS2hmeeq5CpXJch3ko+9cqagJD2H7zAzhOX+Sl7gLZSE7fQmtdBNoXbnbEUso
SigkqoEwtgGsEDliJJqU8lb2kd43YBOhpBbyabtDGSGecl/brrEUl8hHF8xnAh3y
Td0vqh5fHqMhg/2Y411eJDSrIDxi++mB/bJERF/hwfTkaUo1muMSM1QV3D8YWTGB
iTAxce401tBAjl3mpGYxPtwznblneg==
=McVl
-----END PGP SIGNATURE-----

--vWiAiFYFDSjXvdHMKsa0eatJA1wnAmM4k--
