From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 02/17] drm: Add |struct drm_gem_vram_object| callbacks
	for |struct ttm_bo_driver|
Date: Wed, 24 Apr 2019 14:05:06 +0200
Message-ID: <0fb26281-af29-5d94-6d45-6617fc886e45@suse.de>
References: <20190424114842.4723-1-tzimmermann@suse.de>
	<20190424114842.4723-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2728490220126183624=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190424114842.4723-3-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, christian.koenig@amd.com, ray.huang@amd.com, Jerry.Zhang@amd.com, hdegoede@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2728490220126183624==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bPHKb1s0Y3BKnweOhBeTQhCeTEGFrEbBs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bPHKb1s0Y3BKnweOhBeTQhCeTEGFrEbBs
Content-Type: multipart/mixed; boundary="KmDLAt9TwVN6B2g7GLExhYJ0lgOp6TkV5";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com,
 christian.koenig@amd.com, ray.huang@amd.com, Jerry.Zhang@amd.com,
 hdegoede@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <0fb26281-af29-5d94-6d45-6617fc886e45@suse.de>
Subject: Re: [PATCH v2 02/17] drm: Add |struct drm_gem_vram_object| callbacks
 for |struct ttm_bo_driver|
References: <20190424114842.4723-1-tzimmermann@suse.de>
 <20190424114842.4723-3-tzimmermann@suse.de>
In-Reply-To: <20190424114842.4723-3-tzimmermann@suse.de>

--KmDLAt9TwVN6B2g7GLExhYJ0lgOp6TkV5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Am 24.04.19 um 13:48 schrieb Thomas Zimmermann:
> +
> +/*
> + * Helpers for struct ttm_bo_driver
> + */
> +
> +static bool drm_is_gem_vram(struct ttm_buffer_object *bo)
> +{
> +	return (bo->destroy =3D=3D ttm_buffer_object_destroy);
> +}
> +
> +/**
> + * drm_gem_vram_bo_driver_evict_flags() - \
> +	Implements &struct ttm_bo_driver.evict_flags
> + * @bo:	TTM buffer object. Refers to &struct drm_gem_vram_object.bo
> + * @pl:	TTM placement information.
> + */
> +void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
> +					struct ttm_placement *pl)
> +{
> +	struct drm_gem_vram_object *gbo;
> +
> +	/* TTM may pass BOs that are not GEM VRAM BOs. */
> +	if (!drm_is_gem_vram(bo))
> +		return;
> +
> +	gbo =3D drm_gem_vram_of_bo(bo);
> +	drm_gem_vram_placement(gbo, TTM_PL_FLAG_SYSTEM);
> +	*pl =3D gbo->placement;
> +}

For drm_is_gem_vram(), I'm not quite sure what else to test for. So
there are still a few things I'd like to discuss.

 1) If this test is about the placement flags, then it's unrelated to
the actual DRM driver. All buffers of type |struct drm_gem_vram_object|
share the same placement flags.

 2) I tested the code to work with ast and mgag200.

 3) If this test is really about individual instances of each DRM
driver, then the current implementations are already broken. In this
scenario TTM should sort out BOs with a BO device different from the one
that triggered the eviction process; or pass the original BO device to
the evict_flags callback, so we can sort out buffers here.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--KmDLAt9TwVN6B2g7GLExhYJ0lgOp6TkV5--

--bPHKb1s0Y3BKnweOhBeTQhCeTEGFrEbBs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzAUPIACgkQaA3BHVML
eiNnfgf+JpBPKENxTeNfi8rdxN/z875+DftZIHdFiwElxecIZ/PTW3dw0Nxod9CS
HX2b2ZY+v+SOq38KV3ggXs6Zz4rqsLq0UZjrB2T2LPN3StNaiJZiZTtPBSyx+8AG
v1OpQ2k+wXdeuOBQEZ/rSM/3hZORf2xAtfbkCRgRlKs6mvXLMssZ+hulzrhaM/Oz
qGWciKGYTT2kDnDoLuuk2KUvrd2JaVFeznwBOh+AwNIFV9UGRJKyKzFvYfgLBYJw
FWDVTycy8qnDY1WF1Ry+2Cu+z15EMdtpZLr3NCIOhX6R+YCDZR2SVaAVJwow2ciB
Q2pY7/+7UywLzB7iRXaLz0N9Qt2AfA==
=uGEi
-----END PGP SIGNATURE-----

--bPHKb1s0Y3BKnweOhBeTQhCeTEGFrEbBs--

--===============2728490220126183624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2728490220126183624==--
