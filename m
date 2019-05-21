From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/2] drm: Add drm_gem_vram_{pin/unpin}_reserved() and
	convert mgag200
Date: Tue, 21 May 2019 12:57:02 +0200
Message-ID: <e9841344-ea79-0904-4ca7-638687cdb66d__7316.90912959806$1558436241$gmane$org@suse.de>
References: <20190516162746.11636-1-tzimmermann@suse.de>
	<20190516162746.11636-2-tzimmermann@suse.de>
	<20190520161900.GB21222@phenom.ffwll.local>
	<20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0519219179240233126=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0519219179240233126==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LOVgZkxeRXm1NywhZnbn1v1ODCOH08eP6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LOVgZkxeRXm1NywhZnbn1v1ODCOH08eP6
Content-Type: multipart/mixed; boundary="TwDUteRU3iGUYjdEukaAwY6zTh9zjwGc6";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 z.liuxinliang@hisilicon.com, hdegoede@redhat.com,
 kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com,
 sam@ravnborg.org, christian.koenig@amd.com
Message-ID: <e9841344-ea79-0904-4ca7-638687cdb66d@suse.de>
Subject: Re: [PATCH 1/2] drm: Add drm_gem_vram_{pin/unpin}_reserved() and
 convert mgag200
References: <20190516162746.11636-1-tzimmermann@suse.de>
 <20190516162746.11636-2-tzimmermann@suse.de>
 <20190520161900.GB21222@phenom.ffwll.local>
 <20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>
In-Reply-To: <20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>

--TwDUteRU3iGUYjdEukaAwY6zTh9zjwGc6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 21.05.19 um 12:35 schrieb Gerd Hoffmann:
>   Hi,
>=20
>> I think would be good to have a lockdep_assert_held here for the ww_mu=
tex.
>>
>> Also general thing: _reserved is kinda ttm lingo, for dma-buf reservat=
ions
>> we call the structure tracking the fences+lock the "reservation", but =
the
>> naming scheme used is _lock/_unlock.
>>
>> I think would be good to be consistent with that, and use _locked here=
=2E
>> Especially for a very simplified vram helper like this one I expect th=
at's
>> going to lead to less wtf moments by driver writers :-)
>>
>> Maybe we should also do a large-scale s/reserve/lock/ within ttm, to a=
lign
>> more with what we now have in dma-buf.
>=20
> Given that mgag200 is the only user I think the best way forward is to
> improve the mgag200 cursor handling so we can just drop the _reserved
> variants ...
>=20
> When looking at mga_crtc_cursor_set() I suspect the easierst way to do
> that would be to simply pin the cursor bo's at driver_load time, then w=
e
> don't have to bother with pinning in mga_crtc_cursor_set() at all.
>=20
> Thomas, as you have test hardware, can you look into this?

Sure, that's the plan. May take a few days, though.

I'd like to see all of the locking/reservation gone from the helper API.
By using bochs' PRIME helpers, the generic console could probably be
used in mgag200 and ast. That would remove the remaining calls from
mgag200 and ast.

Best regards
Thomas


> thanks,
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


--TwDUteRU3iGUYjdEukaAwY6zTh9zjwGc6--

--LOVgZkxeRXm1NywhZnbn1v1ODCOH08eP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzj2YMACgkQaA3BHVML
eiMqDAf+P2T7mSIcjVDpy3js0U41mhx7KjNP2XifM+KfQIHfuXVMsGtqJ6JSdrGz
G+LGf5UepbCT790PpUhJXuqD3JlTEWFTYBKH5C+0jAxUkvaoK2liXfbuCZzU00aN
1yrwqVZjdVs7gS5+8FkLCCDCfAtzcwSQ8Py0uuyHrbTHu/M+nogvZw+sYWxG1Vmm
yTcG9e+dYHkBz5aA7D+naX91fq9+sHxzOuDGFTCqmcQsztwPoFbt/racQgKg7Kuk
D9LzOcSPZ09mVA+N2VM+2O8ykflV1ojvARmZ5wL3x0MzrbTFKE05hRSX3s2QK/9o
pbj3qalt5qFXEm/2ujqSYvKgtzrAqQ==
=s8r4
-----END PGP SIGNATURE-----

--LOVgZkxeRXm1NywhZnbn1v1ODCOH08eP6--

--===============0519219179240233126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0519219179240233126==--
