From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/4] drm/mgag200: Use simple encoder
Date: Fri, 21 Feb 2020 08:48:48 +0100
Message-ID: <3044661c-7552-e685-37b3-88865f97a991@suse.de>
References: <20200218084815.2137-1-tzimmermann@suse.de>
 <20200218084815.2137-4-tzimmermann@suse.de>
 <20200220185642.GA20011@ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3254062500935002867=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200220185642.GA20011@ravnborg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, noralf@tronnes.org, daniel@ffwll.ch, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3254062500935002867==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DUBWN9ElGP8OsLUD5XE3WCTOucgrt5Zs9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DUBWN9ElGP8OsLUD5XE3WCTOucgrt5Zs9
Content-Type: multipart/mixed; boundary="Z9QfqVzg1HcrcJJFQy30vOtUHaPfVRzvn";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, noralf@tronnes.org,
 alexander.deucher@amd.com, emil.velikov@collabora.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org
Message-ID: <3044661c-7552-e685-37b3-88865f97a991@suse.de>
Subject: Re: [PATCH v2 3/4] drm/mgag200: Use simple encoder
References: <20200218084815.2137-1-tzimmermann@suse.de>
 <20200218084815.2137-4-tzimmermann@suse.de>
 <20200220185642.GA20011@ravnborg.org>
In-Reply-To: <20200220185642.GA20011@ravnborg.org>

--Z9QfqVzg1HcrcJJFQy30vOtUHaPfVRzvn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sam

thanks for reviewing the patch set.

Am 20.02.20 um 19:56 schrieb Sam Ravnborg:
> Hi Thomas.
>=20
> On Tue, Feb 18, 2020 at 09:48:14AM +0100, Thomas Zimmermann wrote:
>> The mgag200 driver uses an empty implementation for its encoder. Repla=
ce
>> the code with the generic simple encoder.
>>
>> v2:
>> 	* rebase onto new simple-encoder interface
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/mgag200/mgag200_drv.h  |  7 ---
>>  drivers/gpu/drm/mgag200/mgag200_mode.c | 61 ++-----------------------=
-
>>  2 files changed, 3 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/m=
gag200/mgag200_drv.h
>> index aa32aad222c2..9bb9e8e14539 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_drv.h
>> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
>> @@ -95,7 +95,6 @@
>>  #define MATROX_DPMS_CLEARED (-1)
>> =20
>>  #define to_mga_crtc(x) container_of(x, struct mga_crtc, base)
>> -#define to_mga_encoder(x) container_of(x, struct mga_encoder, base)
>>  #define to_mga_connector(x) container_of(x, struct mga_connector, bas=
e)
>> =20
>>  struct mga_crtc {
>> @@ -110,12 +109,6 @@ struct mga_mode_info {
>>  	struct mga_crtc *crtc;
>>  };
>> =20
>> -struct mga_encoder {
>> -	struct drm_encoder base;
>> -	int last_dpms;
>> -};
>> -
>> -
>>  struct mga_i2c_chan {
>>  	struct i2c_adapter adapter;
>>  	struct drm_device *dev;
>=20
> Any particular reason why the drm_encoder is not embedded in struct
> mga_device?
>=20
> I found it more elegant - like you did it for ast in the previous patch=
=2E

I think I wanted something that uses drm_simple_encoder_create(). But I
can change that. The embedded variant is indeed better.

Best regards
Thomas

>=20
> I also noted there is one more unused "last_dpms" - but it is outside
> the scope of this patch to remove it.
>=20
> 	Sam
>=20
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/=
mgag200/mgag200_mode.c
>> index 62a8e9ccb16d..957ea1057b6c 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> @@ -15,6 +15,7 @@
>>  #include <drm/drm_fourcc.h>
>>  #include <drm/drm_plane_helper.h>
>>  #include <drm/drm_probe_helper.h>
>> +#include <drm/drm_simple_kms_helper.h>
>> =20
>>  #include "mgag200_drv.h"
>> =20
>> @@ -1449,72 +1450,16 @@ static void mga_crtc_init(struct mga_device *m=
dev)
>>  	drm_crtc_helper_add(&mga_crtc->base, &mga_helper_funcs);
>>  }
>> =20
>> -/*
>> - * The encoder comes after the CRTC in the output pipeline, but befor=
e
>> - * the connector. It's responsible for ensuring that the digital
>> - * stream is appropriately converted into the output format. Setup is=

>> - * very simple in this case - all we have to do is inform qemu of the=

>> - * colour depth in order to ensure that it displays appropriately
>> - */
>> -
>> -/*
>> - * These functions are analagous to those in the CRTC code, but are i=
ntended
>> - * to handle any encoder-specific limitations
>> - */
>> -static void mga_encoder_mode_set(struct drm_encoder *encoder,
>> -				struct drm_display_mode *mode,
>> -				struct drm_display_mode *adjusted_mode)
>> -{
>> -
>> -}
>> -
>> -static void mga_encoder_dpms(struct drm_encoder *encoder, int state)
>> -{
>> -	return;
>> -}
>> -
>> -static void mga_encoder_prepare(struct drm_encoder *encoder)
>> -{
>> -}
>> -
>> -static void mga_encoder_commit(struct drm_encoder *encoder)
>> -{
>> -}
>> -
>> -static void mga_encoder_destroy(struct drm_encoder *encoder)
>> -{
>> -	struct mga_encoder *mga_encoder =3D to_mga_encoder(encoder);
>> -	drm_encoder_cleanup(encoder);
>> -	kfree(mga_encoder);
>> -}
>> -
>> -static const struct drm_encoder_helper_funcs mga_encoder_helper_funcs=
 =3D {
>> -	.dpms =3D mga_encoder_dpms,
>> -	.mode_set =3D mga_encoder_mode_set,
>> -	.prepare =3D mga_encoder_prepare,
>> -	.commit =3D mga_encoder_commit,
>> -};
>> -
>> -static const struct drm_encoder_funcs mga_encoder_encoder_funcs =3D {=

>> -	.destroy =3D mga_encoder_destroy,
>> -};
>> -
>>  static struct drm_encoder *mga_encoder_init(struct drm_device *dev)
>>  {
>>  	struct drm_encoder *encoder;
>> -	struct mga_encoder *mga_encoder;
>> =20
>> -	mga_encoder =3D kzalloc(sizeof(struct mga_encoder), GFP_KERNEL);
>> -	if (!mga_encoder)
>> +	encoder =3D drm_simple_encoder_create(dev, DRM_MODE_ENCODER_DAC);
>> +	if (IS_ERR(encoder))
>>  		return NULL;
>> =20
>> -	encoder =3D &mga_encoder->base;
>>  	encoder->possible_crtcs =3D 0x1;
>> =20
>> -	drm_encoder_init(dev, encoder, &mga_encoder_encoder_funcs,
>> -			 DRM_MODE_ENCODER_DAC, NULL);
>> -	drm_encoder_helper_add(encoder, &mga_encoder_helper_funcs);
>> -
>>  	return encoder;
>>  }
>> =20
>> --=20
>> 2.25.0

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--Z9QfqVzg1HcrcJJFQy30vOtUHaPfVRzvn--

--DUBWN9ElGP8OsLUD5XE3WCTOucgrt5Zs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl5Pi2MACgkQaA3BHVML
eiMSbggAkKW4IPwzooc5SmxndNtmXeGJBR7GSbpTrkC93svgAJek8UbcW8W1L2fT
xhwoCFC3AqyDHX85Bvw4FVOXQW7jeozq0TeOrMZ8L2rIZMXgXJSOqU+9fILF7hfN
nTRQnh26fPvM+gf30BK7OxIEU29+xP3Qgk6YtybUkxZ085ye9WNdDwolSOUaCU+m
Jo+gsNnaGESGyznHsDI+AFA6BqFoSVon6YtI0Gh0h4dKRW8jdIKJnGvGiaAY2eqn
iZJoOb2X6ViMHwTDTkV6DCwZbtiNSLpWqjtcfLAEtmuCtQqJd14CAS2Grkq0nmi/
+EzQZc6CBEzUofFnXoi+FJ+njNaI0A==
=Pd8i
-----END PGP SIGNATURE-----

--DUBWN9ElGP8OsLUD5XE3WCTOucgrt5Zs9--

--===============3254062500935002867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3254062500935002867==--
