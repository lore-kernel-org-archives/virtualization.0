From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/5] Unmappable DRM client buffers for fbdev emulation
Date: Fri, 5 Jul 2019 09:09:41 +0200
Message-ID: <b9684edb-5f77-2ea1-5fba-8f905db9bfed__47289.2023202562$1562310605$gmane$org@suse.de>
References: <20190703083302.2609-1-tzimmermann@suse.de>
	<a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>
	<aa1b7431-21c5-4c99-bfb6-6c5e4946bec3@suse.de>
	<18d573b4-3cb8-dc4a-bee3-a8b9b0a18a28@tronnes.org>
	<5f9c7df7-3805-0e23-4201-be08d41da791@suse.de>
	<02821de5-8a43-53c4-d8f0-70a7f041f896@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1919134454043319970=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <02821de5-8a43-53c4-d8f0-70a7f041f896@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1919134454043319970==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D3ut2bhG6hEZRlg3RROQmjwblJorlxPn5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D3ut2bhG6hEZRlg3RROQmjwblJorlxPn5
Content-Type: multipart/mixed; boundary="u55emh8XsGlQdHlGixPqx0JjvdsuSok90";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com,
 daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org,
 yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <b9684edb-5f77-2ea1-5fba-8f905db9bfed@suse.de>
Subject: Re: [PATCH 0/5] Unmappable DRM client buffers for fbdev emulation
References: <20190703083302.2609-1-tzimmermann@suse.de>
 <a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>
 <aa1b7431-21c5-4c99-bfb6-6c5e4946bec3@suse.de>
 <18d573b4-3cb8-dc4a-bee3-a8b9b0a18a28@tronnes.org>
 <5f9c7df7-3805-0e23-4201-be08d41da791@suse.de>
 <02821de5-8a43-53c4-d8f0-70a7f041f896@tronnes.org>
In-Reply-To: <02821de5-8a43-53c4-d8f0-70a7f041f896@tronnes.org>

--u55emh8XsGlQdHlGixPqx0JjvdsuSok90
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 04.07.19 um 16:15 schrieb Noralf Tr=C3=B8nnes:
>>> Hm, why do you think that?
>>
>> Drivers may already come with their own shadow buffer. Cirrus is an
>> example of that. It uses shmem buffer objects as shadow fbs and
>> internally updates the device frame buffer in its dirty callback. Usin=
g
>> dirty() to select the shadow fbdev adds another buffer (and another
>> memcpy) for no reason.
>=20
> Cirruc uses shmem buffers and they won't work with fbdev defio (both us=
e
> page->lru). shmem is the reason I added shadow buffering to generic
> fbdev in the first place. It will now work with whatever backing buffer=

> the driver uses, as long as it can provide a virtual address on the dum=
b
> buffer (not the case with rockchip for instance, due to limited virtual=

> address space).

OK, I see. Thanks or clarifying.

Best regards
Thomas

> Noralf.
>=20
>>
>> Best regards
>> Thomas
>>
>>> The thing with fbdev defio is that it only supports kmalloc and vmall=
oc
>>> allocated memory (page->lru is avail.). This means that only the CMA
>>> drivers can use defio without shadow memory. To keep things simple
>>> everyone with a dirty() callback gets a shadow buffer.
>>>
>>> Noralf.
>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>>> Really nice diffstat by the way :-)
>>>>>
>>>>> Noralf.
>>>>>
>>>>>> [1] https://lists.freedesktop.org/archives/dri-devel/2019-June/224=
423.html
>>>>>>
>>>>>> Thomas Zimmermann (5):
>>>>>>   drm/client: Support unmapping of DRM client buffers
>>>>>>   drm/fb-helper: Unmap BO for shadow-buffered framebuffer console
>>>>>>   drm/ast: Replace struct ast_fbdev with generic framebuffer emula=
tion
>>>>>>   drm/bochs: Use shadow buffer for bochs framebuffer console
>>>>>>   drm/mgag200: Replace struct mga_fbdev with generic framebuffer
>>>>>>     emulation
>>>>>>
>>>>>>  drivers/gpu/drm/ast/Makefile           |   2 +-
>>>>>>  drivers/gpu/drm/ast/ast_drv.c          |  22 +-
>>>>>>  drivers/gpu/drm/ast/ast_drv.h          |  17 --
>>>>>>  drivers/gpu/drm/ast/ast_fb.c           | 341 --------------------=
-----
>>>>>>  drivers/gpu/drm/ast/ast_main.c         |  30 ++-
>>>>>>  drivers/gpu/drm/ast/ast_mode.c         |  21 --
>>>>>>  drivers/gpu/drm/bochs/bochs_kms.c      |   2 +-
>>>>>>  drivers/gpu/drm/drm_client.c           |  71 ++++-
>>>>>>  drivers/gpu/drm/drm_fb_helper.c        |  14 +-
>>>>>>  drivers/gpu/drm/mgag200/Makefile       |   2 +-
>>>>>>  drivers/gpu/drm/mgag200/mgag200_drv.h  |  19 --
>>>>>>  drivers/gpu/drm/mgag200/mgag200_fb.c   | 309 --------------------=
--
>>>>>>  drivers/gpu/drm/mgag200/mgag200_main.c |  61 +++--
>>>>>>  drivers/gpu/drm/mgag200/mgag200_mode.c |  27 --
>>>>>>  include/drm/drm_client.h               |   3 +
>>>>>>  15 files changed, 154 insertions(+), 787 deletions(-)
>>>>>>  delete mode 100644 drivers/gpu/drm/ast/ast_fb.c
>>>>>>  delete mode 100644 drivers/gpu/drm/mgag200/mgag200_fb.c
>>>>>>
>>>>>> --
>>>>>> 2.21.0
>>>>>>
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>>
>>>>
>>
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


--u55emh8XsGlQdHlGixPqx0JjvdsuSok90--

--D3ut2bhG6hEZRlg3RROQmjwblJorlxPn5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0e97kACgkQaA3BHVML
eiPnaAf/VlglQ6sGaP/FrHEAxMHbK0k+lo6fAXLyFeetgNeBCHBi1uMzh0v3Rpg8
bE2/LNKXUre7uB8uozhAKIBdWw4veio19zp6/KJ3AsV2HOhST8kDy+8sptEZYJBV
zHbreZKym1DUNKb9d0X8umwo8CteLPt/vBWHSRcBLQFygc6Mf/nFw7cvk00guB4N
cXGA4/bFcLFTFHpW2ulfGnz8vZ23yFoYBOz/la8gg4lQHcTRznTd2aQkJhpyXY0L
yrHhNpbfmsXHH3i7aJvu4PFSvmDLzxC0PcWSPEaIJ8XfrFs8yAWyMN1gDa0Q7Tqk
/q4hrLx0aqBxq1MfFgV+mLUPWlBQ3g==
=gi5u
-----END PGP SIGNATURE-----

--D3ut2bhG6hEZRlg3RROQmjwblJorlxPn5--

--===============1919134454043319970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1919134454043319970==--
