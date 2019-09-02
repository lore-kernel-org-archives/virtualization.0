From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/5] drm/qxl: use drm_gem_ttm_print_info
Date: Mon, 2 Sep 2019 16:42:52 +0200
Message-ID: <6648e4f5-8a86-1daa-f6e7-b724980a5be5__36633.6198103213$1567435398$gmane$org@suse.de>
References: <20190902124126.7700-1-kraxel@redhat.com>
	<20190902124126.7700-6-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3540485744817867524=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190902124126.7700-6-kraxel@redhat.com>
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
--===============3540485744817867524==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Clit6RfTTM8Htb9tNSh6wHS8QmmDLqS2V"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Clit6RfTTM8Htb9tNSh6wHS8QmmDLqS2V
Content-Type: multipart/mixed; boundary="nnvPW0OXUdx3uGyybx7O16Dcj4tJtS9wE";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <6648e4f5-8a86-1daa-f6e7-b724980a5be5@suse.de>
Subject: Re: [PATCH 5/5] drm/qxl: use drm_gem_ttm_print_info
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-6-kraxel@redhat.com>
In-Reply-To: <20190902124126.7700-6-kraxel@redhat.com>

--nnvPW0OXUdx3uGyybx7O16Dcj4tJtS9wE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Am 02.09.19 um 14:41 schrieb Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.h    | 1 +
>  drivers/gpu/drm/qxl/qxl_object.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_dr=
v.h
> index 9e034c5fa87d..d4051409ce64 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -38,6 +38,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_gem_ttm_helper.h>
>  #include <drm/drm_ioctl.h>
>  #include <drm/drm_gem.h>
>  #include <drm/qxl_drm.h>
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl=
_object.c
> index 29aab7b14513..c013c516f561 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -86,6 +86,7 @@ static const struct drm_gem_object_funcs qxl_object_f=
uncs =3D {
>  	.get_sg_table =3D qxl_gem_prime_get_sg_table,
>  	.vmap =3D qxl_gem_prime_vmap,
>  	.vunmap =3D qxl_gem_prime_vunmap,
> +	.print_info =3D drm_gem_ttm_print_info,
>  };
> =20
>  int qxl_bo_create(struct qxl_device *qdev,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--nnvPW0OXUdx3uGyybx7O16Dcj4tJtS9wE--

--Clit6RfTTM8Htb9tNSh6wHS8QmmDLqS2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl1tKmwACgkQaA3BHVML
eiNabAgAtv1B3wPVXOGKwUAvkeOBYizfbSBQdULp6Jca91gaG1yStTzQuU+yxJqd
BEZzpuJRtal9jCt7iNOQJKpZuSo66kkyDDn64EYAAoIOxTjC7itN+ZKBl/z9aV+n
/ztmjcmJadB+O5kvUD4X1D8tJ68EKOgBymdHMQecb9cL9qn54vFwoCzhhrL7/50E
RNO3HwI7yi7TVNcEvSgsabn+2xH3wpiVYHqOGjN5jRjfizgJuFiULmmckg0adMOJ
MbjR19Qu8wvvEe3CIa7dVsvCD/zbS0fsoALpsY8lxXsOhjfK9Uh0BmSiV56OP4N2
Mnq91MRlMwnZB3m8ciAPS8rvxOk8ww==
=Owph
-----END PGP SIGNATURE-----

--Clit6RfTTM8Htb9tNSh6wHS8QmmDLqS2V--

--===============3540485744817867524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3540485744817867524==--
