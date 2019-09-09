From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/7] drm/vram: fix Kconfig
Date: Mon, 9 Sep 2019 14:47:59 +0200
Message-ID: <bf878fb7-416a-ba41-c1a4-d1c95bd3a4ee__13748.0736522534$1568033306$gmane$org@suse.de>
References: <20190904054740.20817-1-kraxel@redhat.com>
	<20190904054740.20817-8-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5935939521323371651=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190904054740.20817-8-kraxel@redhat.com>
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen Feng <puck.chen@hisilicon.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Xinliang Liu <z.liuxinliang@hisilicon.com>, Hans de Goede <hdegoede@redhat.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5935939521323371651==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="47bhEdBPYH43lCBuMRYtaXkG7ni6nsatf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47bhEdBPYH43lCBuMRYtaXkG7ni6nsatf
Content-Type: multipart/mixed; boundary="OxFJn0wfhCczI7Nqkb3gSMltDAonUXRjh";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen Feng <puck.chen@hisilicon.com>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 Xinliang Liu <z.liuxinliang@hisilicon.com>, David Airlie <airlied@linux.ie>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>,
 Sean Paul <sean@poorly.run>
Message-ID: <bf878fb7-416a-ba41-c1a4-d1c95bd3a4ee@suse.de>
Subject: Re: [PATCH v3 7/7] drm/vram: fix Kconfig
References: <20190904054740.20817-1-kraxel@redhat.com>
 <20190904054740.20817-8-kraxel@redhat.com>
In-Reply-To: <20190904054740.20817-8-kraxel@redhat.com>

--OxFJn0wfhCczI7Nqkb3gSMltDAonUXRjh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 04.09.19 um 07:47 schrieb Gerd Hoffmann:
> select isn't recursive, so we can't turn on DRM_TTM + DRM_TTM_HELPER
> in config DRM_VRAM_HELPER, we have to select them on the vram users
> instead.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/Kconfig                 | 2 --
>  drivers/gpu/drm/ast/Kconfig             | 2 ++
>  drivers/gpu/drm/bochs/Kconfig           | 2 ++
>  drivers/gpu/drm/hisilicon/hibmc/Kconfig | 3 ++-
>  drivers/gpu/drm/mgag200/Kconfig         | 2 ++
>  drivers/gpu/drm/vboxvideo/Kconfig       | 2 ++
>  6 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 1be8ad30d8fe..cd11a3bde19c 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -168,8 +168,6 @@ config DRM_TTM
>  config DRM_VRAM_HELPER
>  	tristate
>  	depends on DRM
> -	select DRM_TTM
> -	select DRM_TTM_HELPER
>  	help
>  	  Helpers for VRAM memory management
> =20
> diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
> index 829620d5326c..fbcf2f45cef5 100644
> --- a/drivers/gpu/drm/ast/Kconfig
> +++ b/drivers/gpu/drm/ast/Kconfig
> @@ -4,6 +4,8 @@ config DRM_AST
>  	depends on DRM && PCI && MMU
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
> +	select DRM_TTM
> +	select DRM_TTM_HELPER
>  	help
>  	 Say yes for experimental AST GPU driver. Do not enable
>  	 this driver without having a working -modesetting,
> diff --git a/drivers/gpu/drm/bochs/Kconfig b/drivers/gpu/drm/bochs/Kcon=
fig
> index 32b043abb668..7bcdf294fed8 100644
> --- a/drivers/gpu/drm/bochs/Kconfig
> +++ b/drivers/gpu/drm/bochs/Kconfig
> @@ -4,6 +4,8 @@ config DRM_BOCHS
>  	depends on DRM && PCI && MMU
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
> +	select DRM_TTM
> +	select DRM_TTM_HELPER
>  	help
>  	  Choose this option for qemu.
>  	  If M is selected the module will be called bochs-drm.
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/=
hisilicon/hibmc/Kconfig
> index f20eedf0073a..8ad9a5b12e40 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> @@ -4,7 +4,8 @@ config DRM_HISI_HIBMC
>  	depends on DRM && PCI && MMU
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
> -
> +	select DRM_TTM
> +	select DRM_TTM_HELPER
>  	help
>  	  Choose this option if you have a Hisilicon Hibmc soc chipset.
>  	  If M is selected the module will be called hibmc-drm.
> diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/=
Kconfig
> index 76fee0fbdcae..aed11f4f4c55 100644
> --- a/drivers/gpu/drm/mgag200/Kconfig
> +++ b/drivers/gpu/drm/mgag200/Kconfig
> @@ -4,6 +4,8 @@ config DRM_MGAG200
>  	depends on DRM && PCI && MMU
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
> +	select DRM_TTM
> +	select DRM_TTM_HELPER
>  	help
>  	 This is a KMS driver for the MGA G200 server chips, it
>           does not support the original MGA G200 or any of the desktop
> diff --git a/drivers/gpu/drm/vboxvideo/Kconfig b/drivers/gpu/drm/vboxvi=
deo/Kconfig
> index 56ba510f21a2..45fe135d6e43 100644
> --- a/drivers/gpu/drm/vboxvideo/Kconfig
> +++ b/drivers/gpu/drm/vboxvideo/Kconfig
> @@ -4,6 +4,8 @@ config DRM_VBOXVIDEO
>  	depends on DRM && X86 && PCI
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
> +	select DRM_TTM
> +	select DRM_TTM_HELPER
>  	select GENERIC_ALLOCATOR
>  	help
>  	  This is a KMS driver for the virtual Graphics Card used in
>=20

Thanks for fixing the Kconfigs for VRAM helpers.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>


--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--OxFJn0wfhCczI7Nqkb3gSMltDAonUXRjh--

--47bhEdBPYH43lCBuMRYtaXkG7ni6nsatf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl12Sf8ACgkQaA3BHVML
eiPh6AgAl0mzBwbaxMhxqlfZNPq3tFs4h1Py9aWi3/+VF7K75pm8zhBl9y2q4TD+
7DVEpJM5xzY5O9KivyzLr53y/q5Ilzp18oNlaO/gjCBMFgtB81IizFtm67yIdkLA
AfrdR3IaWU/s01Fbs5fHUysMWXdKFNdcWWRvJTBoYAcrCO2VvVuyiTkatPmVBoNd
AizqjzvMlv8m/cLFSEuOLotgG0+lQuUu5kYsTlv/9NG4BmU+n3r27Tjh/X1PSHU1
xqFld4QRloIm+xusum2R8R/tZvzGnPf7wV7HBvZioqs6JQ9llc3agnyKoRRszTJz
FKrHDtGQT3NuI8677j2ombzXIp3gtA==
=V8zx
-----END PGP SIGNATURE-----

--47bhEdBPYH43lCBuMRYtaXkG7ni6nsatf--

--===============5935939521323371651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5935939521323371651==--
