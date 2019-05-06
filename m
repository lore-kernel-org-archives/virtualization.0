From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 01/19] drm: Add |struct drm_gem_vram_object| and helpers
Date: Mon, 6 May 2019 14:58:52 +0200
Message-ID: <0fad955f-5a9e-15b1-0dca-c5e842b297c6__10346.2981221796$1557147612$gmane$org@suse.de>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506082649.942-2-tzimmermann@suse.de>
	<20190506123114.hzyl2hkix7lvqjyx@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7016865771997385700=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190506123114.hzyl2hkix7lvqjyx@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7016865771997385700==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4sS3OfANxHAoq5OyGniA2xYvU7Lb8dibk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4sS3OfANxHAoq5OyGniA2xYvU7Lb8dibk
Content-Type: multipart/mixed; boundary="ZipD9EcZseCXiskT5bON6feXW3MQIdQ0B";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: daniel@ffwll.ch, airlied@linux.ie, christian.koenig@amd.com,
 ray.huang@amd.com, hdegoede@redhat.com, noralf@tronnes.org,
 sam@ravnborg.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <0fad955f-5a9e-15b1-0dca-c5e842b297c6@suse.de>
Subject: Re: [PATCH v4 01/19] drm: Add |struct drm_gem_vram_object| and
 helpers
References: <20190506082649.942-1-tzimmermann@suse.de>
 <20190506082649.942-2-tzimmermann@suse.de>
 <20190506123114.hzyl2hkix7lvqjyx@sirius.home.kraxel.org>
In-Reply-To: <20190506123114.hzyl2hkix7lvqjyx@sirius.home.kraxel.org>

--ZipD9EcZseCXiskT5bON6feXW3MQIdQ0B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

thanks for reviewing the patches.

Am 06.05.19 um 14:31 schrieb Gerd Hoffmann:
>> +	--gbo->pin_count;
>> +	if (gbo->pin_count)
>> +		return 0;
>> +
>> +	if (gbo->kmap.virtual)
>> +		ttm_bo_kunmap(&gbo->kmap);
>> +
>> +	drm_gem_vram_placement(gbo, TTM_PL_FLAG_SYSTEM);
>> +	for (i =3D 0; i < gbo->placement.num_placement ; ++i)
>> +		gbo->placements[i].flags |=3D TTM_PL_FLAG_NO_EVICT;
>> +
>> +	ret =3D ttm_bo_validate(&gbo->bo, &gbo->placement, &ctx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_gem_vram_push_to_system);
>=20
> Very simliar to drm_gem_vram_unpin, can't we just call that function?
>=20
> Something like this:
>=20
> 	drm_gem_vram_push_to_system()
> 	{
> 		if (gbo->pin_count =3D=3D 1 && gbo->kmap.virtual)
> 			ttm_bo_kunmap(&gbo->kmap);
> 		return drm_gem_vram_unpin();
> 	}

This misses the call to drm_gem_vram_placement(), where
drm_gem_vram_push_to_system() enforces placement in system memory. We
could build a common implementation out of both interfaces, but that
would obfuscate the code IMHO. I'd just leave it as it is.

The function is only used by ast and mgag200 framebuffer handling. It's
actually something that should be done by VRAM MM, but both drivers are
non-atomic and could require an overhaul anyway.

>> +struct drm_gem_vram_object {
>> +	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
>> +	struct ttm_placement placement;
>> +	struct ttm_place placements[3];
>=20
> placements[2] should be enough I guess?

TTM_PL_VRAM has index 2 and TTM_PL_SYSTEM has index 0. There's TTM_PL_TT
at index 1. We don't use all three array entries here, but I'm not sure
if something in TTM does. I took the line from the drivers and didn't
change it for that reason.

Best regards
Thomas

> cheers,
>   Gerd
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--ZipD9EcZseCXiskT5bON6feXW3MQIdQ0B--

--4sS3OfANxHAoq5OyGniA2xYvU7Lb8dibk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzQL48ACgkQaA3BHVML
eiPgHwf/QXvFOaFUtsEy7dOyFKSbWfcHoCbYowuNyo6DleV9v/rwBG/63YSp1WuS
ZdaU9S4OS1iz3o7uf8do5/Rs6kavGEQ6KjLQff6Ssry2+MFIDFB/DN98Z40n+PUe
nmZ9lOIDs8trzDnMfkFRxmmRvklJpLxXlAayeJDnrTkQ/3x5tTaX3F8YFgK8alwt
XWuMUVXs8+Zw51l1lVjh7B64/D/oC5+rPEwqO/leOzFZWwAQVOQqrEf6DoTGJi+q
u5Kcek/lQ5RKr62Yone6AF7hREiAHx7jWLgvPIkM9YNULo5y01hCSHRoSHSmD09b
aWTvinlZkgKHy2AkTzi+t63kRzZD3A==
=iP4G
-----END PGP SIGNATURE-----

--4sS3OfANxHAoq5OyGniA2xYvU7Lb8dibk--

--===============7016865771997385700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7016865771997385700==--
