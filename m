From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 01/19] drm: Add |struct drm_gem_vram_object| and helpers
Date: Mon, 6 May 2019 15:53:57 +0200
Message-ID: <20681195-13b8-5496-a23a-cf617f421dab__3334.85152093402$1557150902$gmane$org@suse.de>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506082649.942-2-tzimmermann@suse.de>
	<20190506123114.hzyl2hkix7lvqjyx@sirius.home.kraxel.org>
	<0fad955f-5a9e-15b1-0dca-c5e842b297c6@suse.de>
	<20190506131739.hmadwiqmjil2weth@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2795481818366731590=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190506131739.hmadwiqmjil2weth@sirius.home.kraxel.org>
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
Cc: airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2795481818366731590==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UGMzEXZdjFq8twEgpjNrvE7GTC4FpsjGO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UGMzEXZdjFq8twEgpjNrvE7GTC4FpsjGO
Content-Type: multipart/mixed; boundary="3lFZCR6nCiEs7kdDwSG9w8Zx7JdY0uGmB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 z.liuxinliang@hisilicon.com, hdegoede@redhat.com,
 kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com,
 sam@ravnborg.org, christian.koenig@amd.com
Message-ID: <20681195-13b8-5496-a23a-cf617f421dab@suse.de>
Subject: Re: [PATCH v4 01/19] drm: Add |struct drm_gem_vram_object| and
 helpers
References: <20190506082649.942-1-tzimmermann@suse.de>
 <20190506082649.942-2-tzimmermann@suse.de>
 <20190506123114.hzyl2hkix7lvqjyx@sirius.home.kraxel.org>
 <0fad955f-5a9e-15b1-0dca-c5e842b297c6@suse.de>
 <20190506131739.hmadwiqmjil2weth@sirius.home.kraxel.org>
In-Reply-To: <20190506131739.hmadwiqmjil2weth@sirius.home.kraxel.org>

--3lFZCR6nCiEs7kdDwSG9w8Zx7JdY0uGmB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 06.05.19 um 15:17 schrieb Gerd Hoffmann:
>   Hi,
>=20
>> This misses the call to drm_gem_vram_placement(), where
>> drm_gem_vram_push_to_system() enforces placement in system memory.
>=20
> Ah, missed that detail.
>=20
>> We
>> could build a common implementation out of both interfaces, but that
>> would obfuscate the code IMHO. I'd just leave it as it is.
>=20
> Ok.
>=20
>>>> +struct drm_gem_vram_object {
>>>> +	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
>>>> +	struct ttm_placement placement;
>>>> +	struct ttm_place placements[3];
>>>
>>> placements[2] should be enough I guess?
>>
>> TTM_PL_VRAM has index 2 and TTM_PL_SYSTEM has index 0. There's TTM_PL_=
TT
>> at index 1. We don't use all three array entries here, but I'm not sur=
e
>> if something in TTM does. I took the line from the drivers and didn't
>> change it for that reason.
>=20
> TTM_PL_* isn't an index into that array.  See drm_gem_vram_placement()
> which fills that array.  It'll use one or two entries of that array.

The field 'placements' is assigned to 'placement.placements' and
'placement.busy_placement'. The placement field is later given to
ttm_bo_validate() for internal use by TTM. From reading ttm_bo.c, that's
apparently not a problem. I'm just being defensive here, but let's
remove the additional entry if it's just overhead.

Best regards
Thomas


> cheers,
>   Gerd
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--3lFZCR6nCiEs7kdDwSG9w8Zx7JdY0uGmB--

--UGMzEXZdjFq8twEgpjNrvE7GTC4FpsjGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzQPHUACgkQaA3BHVML
eiODkQf/eN0JzOmQP3Irawq18oVQAThKfdWiQsukQlvK6ghpb992Rmbut4/a8I3A
gEpFV+fkF+m/94eKvpxvC7J+YQHT39aHeZNSld8+dCHtCMIqvBLpgPPUydjfHhm9
y5eezyUkR65B70NfbiSFV2OUxt+2yM2lx2VSKCznmt+LHG7WL8RUtqGSJWhQ8RP/
24FNaarHRrdm9Y5e9aqEP2bOQbv4XiyIGjzJuCreAjPetAgeVzlEsfKjUT4QMoxz
Dy6LumnXLl4CmevuF/FlkQBlTo1SPn1oGv30ckMAsCT4WpGAbfAAsWFLyZm7k44m
zwsiIBVtJD/7yFYZkdUN5ppY3PirTA==
=Ocpe
-----END PGP SIGNATURE-----

--UGMzEXZdjFq8twEgpjNrvE7GTC4FpsjGO--

--===============2795481818366731590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2795481818366731590==--
