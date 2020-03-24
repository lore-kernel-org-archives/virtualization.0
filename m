From: Rodrigo Siqueira <rodrigosiqueiramelo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 20/22] drm/vkms: Use simple encoder
Date: Tue, 24 Mar 2020 07:59:05 -0400
Message-ID: <20200324115905.dp5jqzbmvhbmk2rn@smtp.gmail.com>
References: <20200305155950.2705-1-tzimmermann@suse.de>
 <20200305155950.2705-21-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xyxw5g6b72ps7vfq"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200305155950.2705-21-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Cc: airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org


--xyxw5g6b72ps7vfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

First of all, thanks for your patch!

I applied all your series, compiled it, and when I tried
`make INSTALL_MOD_PATH=3D/PATH/ modules_instal` I got the following
message:

 depmod: ERROR: Cycle detected: drm_kms_helper -> drm -> drm_kms_helper
 depmod: ERROR: Found 2 modules in dependency cycles!
 make: *** [Makefile:1317: _modinst_post] Error 1

I cleaned up my local files and tried again, but I got the same error;
If I just use `drm-misc-next` everything is fine.  Did I miss something?

Thanks

On 03/05, Thomas Zimmermann wrote:
> The vkms driver uses an empty implementation for its encoder. Replace
> the code with the generic simple encoder.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/gpu/drm/vkms/vkms_output.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vk=
ms_output.c
> index fb1941a6522c..85afb77e97f0 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -3,6 +3,7 @@
>  #include "vkms_drv.h"
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> =20
>  static void vkms_connector_destroy(struct drm_connector *connector)
>  {
> @@ -17,10 +18,6 @@ static const struct drm_connector_funcs vkms_connector=
_funcs =3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
>  };
> =20
> -static const struct drm_encoder_funcs vkms_encoder_funcs =3D {
> -	.destroy =3D drm_encoder_cleanup,
> -};
> -
>  static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
>  	int count;
> @@ -70,8 +67,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int i=
ndex)
> =20
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> =20
> -	ret =3D drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> -			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	ret =3D drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
>  	if (ret) {
>  		DRM_ERROR("Failed to init encoder\n");
>  		goto err_encoder;
> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--xyxw5g6b72ps7vfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl559gMACgkQWJzP/com
vP9BEQ//bENFpSJc2y0XTYIOh3A9lmWbJYMBLW1j5T3uUJJu8x0lC0hqd0fJW3V8
iT1Pedxmmf7duluAn7uKjUQ1sPztm2PcJB8F9ADs+bJdKN2CqmsL3kB4Ip1Q+US7
t7cptBTF6FrLPo4e1WpZAEEu4UdyVsq16+0v3+8icC0YSX6KMQdI9QNvvp/5PmXF
xYc6wwyGGqNZhmVRyLu0Im+zG5TvscTmK3iIu1BOMEubsgZD/BP8ZSx0efQJKRhA
aPhzGs8S7Sp+EnE4wiTU6iZch3+KUw6D0lc398rdlvbZXmvxSxe8WxCwciMksgu5
c+A/+oJ80KIhkjWCQNpF5oddWXUUqy6yHZrzIWzkPAj9oVxQa0jr7EwAkT1h+Zp1
wUDLrQw9ZRw/GHv6awiSFDukLpHIabDgN9F0fsvx9aa/PJ53FOR6hilCOn8tIVnJ
oZabUjqa7pV3L8N5CFott+8EV2y4GZK5R+VW6MX8px2bfa7SaJl+9HgeKssOYOkF
6cwm+IquaD3wz9h7elWGmEQgqj3jOviny3HT7I8U+ZlmMa6+JCMt4iq5e1R9q4du
PP4mh695VhSas/mbB3qjZFy/FCj1bvJ8J6AdHOoNDmjM4JVv9F5S5yi3UN5uEBXC
ZtKmSxghh2GJS2LFK6b88yxVNVNYrCX6bYWSyfovToU6C0QzbKs=
=srDw
-----END PGP SIGNATURE-----

--xyxw5g6b72ps7vfq--
