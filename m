From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/5] drm/qxl: use drm_gem_object_funcs callbacks
Date: Mon, 2 Sep 2019 16:34:49 +0200
Message-ID: <0a9d97c7-26a4-bee6-e9a2-120abbd5277c__24875.0524873444$1567434907$gmane$org@suse.de>
References: <20190902124126.7700-1-kraxel@redhat.com>
	<20190902124126.7700-5-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4652639790002981853=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190902124126.7700-5-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4652639790002981853==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0
Content-Type: multipart/mixed; boundary="VYtJRpb5LuEH9QQwQSr1D2uADEAmevApW";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <0a9d97c7-26a4-bee6-e9a2-120abbd5277c@suse.de>
Subject: Re: [PATCH 4/5] drm/qxl: use drm_gem_object_funcs callbacks
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-5-kraxel@redhat.com>
In-Reply-To: <20190902124126.7700-5-kraxel@redhat.com>

--VYtJRpb5LuEH9QQwQSr1D2uADEAmevApW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This patch seems unrelated.

Am 02.09.19 um 14:41 schrieb Gerd Hoffmann:
> Switch qxl to use drm_gem_object_funcs callbacks
> instead of drm_driver callbacks.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c    |  8 --------
>  drivers/gpu/drm/qxl/qxl_object.c | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_dr=
v.c
> index 2b726a51a302..996d428fa7e6 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -258,16 +258,8 @@ static struct drm_driver qxl_driver =3D {
>  #endif
>  	.prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
> -	.gem_prime_pin =3D qxl_gem_prime_pin,
> -	.gem_prime_unpin =3D qxl_gem_prime_unpin,
> -	.gem_prime_get_sg_table =3D qxl_gem_prime_get_sg_table,
>  	.gem_prime_import_sg_table =3D qxl_gem_prime_import_sg_table,
> -	.gem_prime_vmap =3D qxl_gem_prime_vmap,
> -	.gem_prime_vunmap =3D qxl_gem_prime_vunmap,
>  	.gem_prime_mmap =3D qxl_gem_prime_mmap,
> -	.gem_free_object_unlocked =3D qxl_gem_object_free,
> -	.gem_open_object =3D qxl_gem_object_open,
> -	.gem_close_object =3D qxl_gem_object_close,
>  	.fops =3D &qxl_fops,
>  	.ioctls =3D qxl_ioctls,
>  	.irq_handler =3D qxl_irq_handler,
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl=
_object.c
> index 548dfe6f3b26..29aab7b14513 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -77,6 +77,17 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qb=
o, u32 domain, bool pinned)
>  	}
>  }
> =20
> +static const struct drm_gem_object_funcs qxl_object_funcs =3D {
> +	.free =3D qxl_gem_object_free,
> +	.open =3D qxl_gem_object_open,
> +	.close =3D qxl_gem_object_close,
> +	.pin =3D qxl_gem_prime_pin,
> +	.unpin =3D qxl_gem_prime_unpin,
> +	.get_sg_table =3D qxl_gem_prime_get_sg_table,
> +	.vmap =3D qxl_gem_prime_vmap,
> +	.vunmap =3D qxl_gem_prime_vunmap,
> +};
> +
>  int qxl_bo_create(struct qxl_device *qdev,
>  		  unsigned long size, bool kernel, bool pinned, u32 domain,
>  		  struct qxl_surface *surf,
> @@ -100,6 +111,7 @@ int qxl_bo_create(struct qxl_device *qdev,
>  		kfree(bo);
>  		return r;
>  	}
> +	bo->tbo.base.funcs =3D &qxl_object_funcs;
>  	bo->type =3D domain;
>  	bo->pin_count =3D pinned ? 1 : 0;
>  	bo->surface_id =3D 0;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--VYtJRpb5LuEH9QQwQSr1D2uADEAmevApW--

--5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl1tKIkACgkQaA3BHVML
eiMbjAf6AxrSfiSwm5E9Q+kRgf/F5G7EF7dbpaTiSosYTZd7U+6DSM3ljVOdBoTP
7tGDxBOB2gISyEwV80XSSNlfznuwu/AmcUlV0zxmmhQFbtAg5d+tltxkl8JUbThu
IXnvhuagV3gTKsFLoRDcIaZhfX7WRQRdzT2aE3v8gPlC+2Gq79CRgkcWTUjxRqiC
H8wZduikC5Eh8DIdMx8psHsnaIPB+Ody48ahAuc3IlSzW/Uml8pvktfFOt/E/1pt
CR+A4iUYA8elgRKIBIvbTydzWgno/Yssq2jJmodCD/CchssJ/+L5XK67QuD04hmP
kgiY7AUlzJRS2ECQGZq+jq0gSrkabw==
=zx9m
-----END PGP SIGNATURE-----

--5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0--

--===============4652639790002981853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4652639790002981853==--
