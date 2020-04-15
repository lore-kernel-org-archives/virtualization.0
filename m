From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 37/59] drm/cirrus: Move to drm/tiny
Date: Wed, 15 Apr 2020 10:46:22 +0200
Message-ID: <1d8288b5-883c-fcda-0108-b1fecc5637e6@suse.de>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-38-daniel.vetter@ffwll.ch>
 <fe4fdf57-b039-02d3-ae89-24953304c79d@suse.de>
 <CAKMK7uHKqmUDMwsZ9OufZE-ZHqUHscmgiZ_HvRyr9TbH3UcYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0096994252=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAKMK7uHKqmUDMwsZ9OufZE-ZHqUHscmgiZ_HvRyr9TbH3UcYFQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>, Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0096994252==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nyXfRRKUSNJFSss05h7E4qmPW4psHqZj5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nyXfRRKUSNJFSss05h7E4qmPW4psHqZj5
Content-Type: multipart/mixed; boundary="8FplsbkvjG1J7atIv627aY0FKM93Herzb";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel.vetter@intel.com>
Message-ID: <1d8288b5-883c-fcda-0108-b1fecc5637e6@suse.de>
Subject: Re: [PATCH 37/59] drm/cirrus: Move to drm/tiny
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-38-daniel.vetter@ffwll.ch>
 <fe4fdf57-b039-02d3-ae89-24953304c79d@suse.de>
 <CAKMK7uHKqmUDMwsZ9OufZE-ZHqUHscmgiZ_HvRyr9TbH3UcYFQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHKqmUDMwsZ9OufZE-ZHqUHscmgiZ_HvRyr9TbH3UcYFQ@mail.gmail.com>

--8FplsbkvjG1J7atIv627aY0FKM93Herzb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 15.04.20 um 10:19 schrieb Daniel Vetter:
> On Wed, Apr 15, 2020 at 10:01 AM Thomas Zimmermann <tzimmermann@suse.de=
> wrote:
>>
>>
>>
>> Am 15.04.20 um 09:40 schrieb Daniel Vetter:
>>> Because it is. Huge congrats to everyone who made this kind of
>>> refactoring happen!
>>
>> Every other week, I felt an urge to send out this patch. Thank you so
>> much, Daniel! There are more candidates for tiny/. They are all <20k
>> LOCs and all we'd have to do is to move their code into a single file.=


I meant <20k file size, not LOCs.

>> bochs or arc come into my mind.
>=20
> arc I have (later in the series), bochs I feel like is maybe a bit too
> big. I'd put the limit for tiny well below 1kloc including whitespace
> and all that. bochs might be a candidate once we've helperized a few
> more things perhaps.

True. The largest tiny driver is repaper with ~1.1k LOCS. Reading this
code, it seems like it has reached an upper bound of what is feasible.

Best regards
Thomas

>=20
> btw I drmm_ version of vram helpers would help a bunch of these drivers=
 I think.
> -Daniel
>=20
>>
>>>
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> Cc: Dave Airlie <airlied@redhat.com>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: virtualization@lists.linux-foundation.org
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>>> ---
>>>  MAINTAINERS                               |  2 +-
>>>  drivers/gpu/drm/Kconfig                   |  2 --
>>>  drivers/gpu/drm/Makefile                  |  1 -
>>>  drivers/gpu/drm/cirrus/Kconfig            | 19 -------------------
>>>  drivers/gpu/drm/cirrus/Makefile           |  2 --
>>>  drivers/gpu/drm/tiny/Kconfig              | 19 +++++++++++++++++++
>>>  drivers/gpu/drm/tiny/Makefile             |  1 +
>>>  drivers/gpu/drm/{cirrus =3D> tiny}/cirrus.c |  0
>>>  8 files changed, 21 insertions(+), 25 deletions(-)
>>>  delete mode 100644 drivers/gpu/drm/cirrus/Kconfig
>>>  delete mode 100644 drivers/gpu/drm/cirrus/Makefile
>>>  rename drivers/gpu/drm/{cirrus =3D> tiny}/cirrus.c (100%)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 7b3255d96d1d..0a5cf105ee37 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -5397,7 +5397,7 @@ L:      virtualization@lists.linux-foundation.o=
rg
>>>  S:   Obsolete
>>>  W:   https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considere=
d-harmful/
>>>  T:   git git://anongit.freedesktop.org/drm/drm-misc
>>> -F:   drivers/gpu/drm/cirrus/
>>> +F:   drivers/gpu/drm/tiny/cirrus.c
>>>
>>>  DRM DRIVER FOR QXL VIRTUAL GPU
>>>  M:   Dave Airlie <airlied@redhat.com>
>>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>>> index 43594978958e..4f4e7fa001c1 100644
>>> --- a/drivers/gpu/drm/Kconfig
>>> +++ b/drivers/gpu/drm/Kconfig
>>> @@ -310,8 +310,6 @@ source "drivers/gpu/drm/ast/Kconfig"
>>>
>>>  source "drivers/gpu/drm/mgag200/Kconfig"
>>>
>>> -source "drivers/gpu/drm/cirrus/Kconfig"
>>> -
>>>  source "drivers/gpu/drm/armada/Kconfig"
>>>
>>>  source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
>>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>>> index f34d08c83485..2c0e5a7e5953 100644
>>> --- a/drivers/gpu/drm/Makefile
>>> +++ b/drivers/gpu/drm/Makefile
>>> @@ -74,7 +74,6 @@ obj-$(CONFIG_DRM_I915)      +=3D i915/
>>>  obj-$(CONFIG_DRM_MGAG200) +=3D mgag200/
>>>  obj-$(CONFIG_DRM_V3D)  +=3D v3d/
>>>  obj-$(CONFIG_DRM_VC4)  +=3D vc4/
>>> -obj-$(CONFIG_DRM_CIRRUS_QEMU) +=3D cirrus/
>>>  obj-$(CONFIG_DRM_SIS)   +=3D sis/
>>>  obj-$(CONFIG_DRM_SAVAGE)+=3D savage/
>>>  obj-$(CONFIG_DRM_VMWGFX)+=3D vmwgfx/
>>> diff --git a/drivers/gpu/drm/cirrus/Kconfig b/drivers/gpu/drm/cirrus/=
Kconfig
>>> deleted file mode 100644
>>> index c6bbd988b0e5..000000000000
>>> --- a/drivers/gpu/drm/cirrus/Kconfig
>>> +++ /dev/null
>>> @@ -1,19 +0,0 @@
>>> -# SPDX-License-Identifier: GPL-2.0-only
>>> -config DRM_CIRRUS_QEMU
>>> -     tristate "Cirrus driver for QEMU emulated device"
>>> -     depends on DRM && PCI && MMU
>>> -     select DRM_KMS_HELPER
>>> -     select DRM_GEM_SHMEM_HELPER
>>> -     help
>>> -      This is a KMS driver for emulated cirrus device in qemu.
>>> -      It is *NOT* intended for real cirrus devices. This requires
>>> -      the modesetting userspace X.org driver.
>>> -
>>> -      Cirrus is obsolete, the hardware was designed in the 90ies
>>> -      and can't keep up with todays needs.  More background:
>>> -      https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-consider=
ed-harmful/
>>> -
>>> -      Better alternatives are:
>>> -        - stdvga (DRM_BOCHS, qemu -vga std, default in qemu 2.2+)
>>> -        - qxl (DRM_QXL, qemu -vga qxl, works best with spice)
>>> -        - virtio (DRM_VIRTIO_GPU), qemu -vga virtio)
>>> diff --git a/drivers/gpu/drm/cirrus/Makefile b/drivers/gpu/drm/cirrus=
/Makefile
>>> deleted file mode 100644
>>> index 0c1ed3f99725..000000000000
>>> --- a/drivers/gpu/drm/cirrus/Makefile
>>> +++ /dev/null
>>> @@ -1,2 +0,0 @@
>>> -# SPDX-License-Identifier: GPL-2.0-only
>>> -obj-$(CONFIG_DRM_CIRRUS_QEMU) +=3D cirrus.o
>>> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kcon=
fig
>>> index 4160e74e4751..2b6414f0fa75 100644
>>> --- a/drivers/gpu/drm/tiny/Kconfig
>>> +++ b/drivers/gpu/drm/tiny/Kconfig
>>> @@ -1,5 +1,24 @@
>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>
>>> +config DRM_CIRRUS_QEMU
>>> +     tristate "Cirrus driver for QEMU emulated device"
>>> +     depends on DRM && PCI && MMU
>>> +     select DRM_KMS_HELPER
>>> +     select DRM_GEM_SHMEM_HELPER
>>> +     help
>>> +      This is a KMS driver for emulated cirrus device in qemu.
>>> +      It is *NOT* intended for real cirrus devices. This requires
>>> +      the modesetting userspace X.org driver.
>>> +
>>> +      Cirrus is obsolete, the hardware was designed in the 90ies
>>> +      and can't keep up with todays needs.  More background:
>>> +      https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-consider=
ed-harmful/
>>> +
>>> +      Better alternatives are:
>>> +        - stdvga (DRM_BOCHS, qemu -vga std, default in qemu 2.2+)
>>> +        - qxl (DRM_QXL, qemu -vga qxl, works best with spice)
>>> +        - virtio (DRM_VIRTIO_GPU), qemu -vga virtio)
>>> +
>>>  config DRM_GM12U320
>>>       tristate "GM12U320 driver for USB projectors"
>>>       depends on DRM && USB
>>> diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Mak=
efile
>>> index c96ceee71453..6ae4e9e5a35f 100644
>>> --- a/drivers/gpu/drm/tiny/Makefile
>>> +++ b/drivers/gpu/drm/tiny/Makefile
>>> @@ -1,5 +1,6 @@
>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>
>>> +obj-$(CONFIG_DRM_CIRRUS_QEMU)                +=3D cirrus.o
>>>  obj-$(CONFIG_DRM_GM12U320)           +=3D gm12u320.o
>>>  obj-$(CONFIG_TINYDRM_HX8357D)                +=3D hx8357d.o
>>>  obj-$(CONFIG_TINYDRM_ILI9225)                +=3D ili9225.o
>>> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/tiny/c=
irrus.c
>>> similarity index 100%
>>> rename from drivers/gpu/drm/cirrus/cirrus.c
>>> rename to drivers/gpu/drm/tiny/cirrus.c
>>>
>>
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
>> (HRB 36809, AG N=C3=BCrnberg)
>> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>>
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--8FplsbkvjG1J7atIv627aY0FKM93Herzb--

--nyXfRRKUSNJFSss05h7E4qmPW4psHqZj5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl6Wyd4ACgkQaA3BHVML
eiPa+Af8CVapqi1hBYrMT47endqvJfDWOWsM7KWfjN1LisYrMDL6Hnvm65sBIzDX
fT2f3pKbuWP3clORnAUacZfKi1WIzgrGAwtx87Xql/DXABmQkOgzzYOYonNN9iB2
5Bnqx+6f1s4ObhoqZjE/S2xntRM8f3GaII6jcIVVFWytoRI0+uyOFInjB52o8gGw
5yoqNLN0Oc05Gz/Fxiwh+tqDIdYLfdv6y4iHFjMQ1UbOtc0UG1q17XXtb3RFByNW
BTs63Hzk9jiAdD06lQdlEv/rOrNAjuuXr25u4tWZvSFVS/3gC8pZI3+8buw97Q/k
ULIsfLHOX6EcG24upLy1XgD7q0aANw==
=4Hvi
-----END PGP SIGNATURE-----

--nyXfRRKUSNJFSss05h7E4qmPW4psHqZj5--

--===============0096994252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0096994252==--
