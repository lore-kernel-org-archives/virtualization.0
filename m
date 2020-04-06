From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 30/44] drm/qxl: Use devm_drm_dev_alloc
Date: Mon, 6 Apr 2020 14:11:09 +0200
Message-ID: <f85e0d74-2d1a-03ce-3eef-8c21b90845d4@suse.de>
References: <20200403135828.2542770-1-daniel.vetter@ffwll.ch>
 <20200403135828.2542770-31-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1625703035=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200403135828.2542770-31-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Dave Airlie <airlied@redhat.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1625703035==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U47qTCGnlx1wJpHiO8OcTjEHNNfTq4eiS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U47qTCGnlx1wJpHiO8OcTjEHNNfTq4eiS
Content-Type: multipart/mixed; boundary="6kv8mAox5GvUraJWEerWSr8Z7ZNmjb3HG";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
Cc: spice-devel@lists.freedesktop.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, Gerd Hoffmann
 <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>,
 Dave Airlie <airlied@redhat.com>
Message-ID: <f85e0d74-2d1a-03ce-3eef-8c21b90845d4@suse.de>
Subject: Re: [PATCH 30/44] drm/qxl: Use devm_drm_dev_alloc
References: <20200403135828.2542770-1-daniel.vetter@ffwll.ch>
 <20200403135828.2542770-31-daniel.vetter@ffwll.ch>
In-Reply-To: <20200403135828.2542770-31-daniel.vetter@ffwll.ch>

--6kv8mAox5GvUraJWEerWSr8Z7ZNmjb3HG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 03.04.20 um 15:58 schrieb Daniel Vetter:
> Also need to remove the drm_dev_put from the remove hook.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 15 ++++++++-------
>  drivers/gpu/drm/qxl/qxl_drv.h |  3 +--
>  drivers/gpu/drm/qxl/qxl_kms.c | 12 +-----------
>  3 files changed, 10 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_dr=
v.c
> index 09102e2efabc..6b4ae4c5fb76 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -81,13 +81,16 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pc=
i_device_id *ent)
>  		return -EINVAL; /* TODO: ENODEV ? */
>  	}
> =20
> -	qdev =3D kzalloc(sizeof(struct qxl_device), GFP_KERNEL);
> -	if (!qdev)
> +	qdev =3D devm_drm_dev_alloc(&pdev->dev, &qxl_driver,
> +				  struct qxl_device, ddev);
> +	if (IS_ERR(qdev)) {
> +		pr_err("Unable to init drm dev");
>  		return -ENOMEM;
> +	}

My feeling is that it is too early to allocate. Wouldn't it be better to
first do the pdev and conflicting-fb stuff and allocate right before
qxl_device_init() ?

Best regards
Thomas

> =20
>  	ret =3D pci_enable_device(pdev);
>  	if (ret)
> -		goto free_dev;
> +		return ret;
> =20
>  	ret =3D drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "qxl"=
);
>  	if (ret)
> @@ -101,7 +104,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pc=
i_device_id *ent)
>  		}
>  	}
> =20
> -	ret =3D qxl_device_init(qdev, &qxl_driver, pdev);
> +	ret =3D qxl_device_init(qdev, pdev);
>  	if (ret)
>  		goto put_vga;
> =20
> @@ -128,8 +131,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pc=
i_device_id *ent)
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  disable_pci:
>  	pci_disable_device(pdev);
> -free_dev:
> -	kfree(qdev);
> +
>  	return ret;
>  }
> =20
> @@ -155,7 +157,6 @@ qxl_pci_remove(struct pci_dev *pdev)
>  	drm_atomic_helper_shutdown(dev);
>  	if (is_vga(pdev))
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
> -	drm_dev_put(dev);
>  }
> =20
>  DEFINE_DRM_GEM_FOPS(qxl_fops);
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_dr=
v.h
> index 435126facc9b..86ac191d9205 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -276,8 +276,7 @@ struct qxl_device {
>  extern const struct drm_ioctl_desc qxl_ioctls[];
>  extern int qxl_max_ioctl;
> =20
> -int qxl_device_init(struct qxl_device *qdev, struct drm_driver *drv,
> -		    struct pci_dev *pdev);
> +int qxl_device_init(struct qxl_device *qdev, struct pci_dev *pdev);
>  void qxl_device_fini(struct qxl_device *qdev);
> =20
>  int qxl_modeset_init(struct qxl_device *qdev);
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_km=
s.c
> index 9eed1a375f24..91a34dd835d7 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -108,21 +108,13 @@ static void qxl_gc_work(struct work_struct *work)=

>  }
> =20
>  int qxl_device_init(struct qxl_device *qdev,
> -		    struct drm_driver *drv,
>  		    struct pci_dev *pdev)
>  {
>  	int r, sb;
> =20
> -	r =3D drm_dev_init(&qdev->ddev, drv, &pdev->dev);
> -	if (r) {
> -		pr_err("Unable to init drm dev");
> -		goto error;
> -	}
> -
>  	qdev->ddev.pdev =3D pdev;
>  	pci_set_drvdata(pdev, &qdev->ddev);
>  	qdev->ddev.dev_private =3D qdev;
> -	drmm_add_final_kfree(&qdev->ddev, qdev);
> =20
>  	mutex_init(&qdev->gem.mutex);
>  	mutex_init(&qdev->update_area_mutex);
> @@ -138,8 +130,7 @@ int qxl_device_init(struct qxl_device *qdev,
>  	qdev->vram_mapping =3D io_mapping_create_wc(qdev->vram_base, pci_reso=
urce_len(pdev, 0));
>  	if (!qdev->vram_mapping) {
>  		pr_err("Unable to create vram_mapping");
> -		r =3D -ENOMEM;
> -		goto error;
> +		return -ENOMEM;
>  	}
> =20
>  	if (pci_resource_len(pdev, 4) > 0) {
> @@ -293,7 +284,6 @@ int qxl_device_init(struct qxl_device *qdev,
>  	io_mapping_free(qdev->surface_mapping);
>  vram_mapping_free:
>  	io_mapping_free(qdev->vram_mapping);
> -error:
>  	return r;
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


--6kv8mAox5GvUraJWEerWSr8Z7ZNmjb3HG--

--U47qTCGnlx1wJpHiO8OcTjEHNNfTq4eiS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl6LHF0ACgkQaA3BHVML
eiN5oAgAiGX1c+294XzOEnNtdftBXz6wvc9tUg7FAMoBixHQK3BrcgYD9CIZ5RkA
EMKoRH7GkgVruL7ABjv6Pw2h/Gb3ywxUui1pNONAmqj5mk59l7ZpNxHHgtArTvV1
+puo9VV2l7UklAoH+w8xf9obXFKSwfwyRX+bIuemq1pJGwRbIQ0/XxkTe4fK6CVu
g8+b9arcUfykEiZXH6MUWOZwUkj2nvC/oVVdc3+sFThfbKhkAd2j+Zbfa2OOXWJ6
Rf1no3zjvXrwawkGBd6k/WpwHBziIM5C6LHeAOR4OVckgLFI+cLjEiix7VyYcwYR
kiWzBaGT9GfEkX90fAqhSFia/0GXQA==
=mZNW
-----END PGP SIGNATURE-----

--U47qTCGnlx1wJpHiO8OcTjEHNNfTq4eiS--

--===============1625703035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1625703035==--
