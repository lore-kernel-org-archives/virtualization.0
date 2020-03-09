From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH][next] drm: Replace zero-length array with
 flexible-array member
Date: Mon, 9 Mar 2020 08:49:45 +0100
Message-ID: <67c46a2b-8127-a4b7-c825-8cba6f28db8c@suse.de>
References: <20200225140347.GA22864@embeddedor> <87a756sqdc.fsf@intel.com>
 <138ff691-94b3-1ce5-e7fa-e6d7c436bf8e@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968610042=="
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <138ff691-94b3-1ce5-e7fa-e6d7c436bf8e-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joonas Lahtinen <joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rodrigo Vivi <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, VMware Graphics <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0968610042==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ul1CrpBm5H0rrZlYhdIfEA75XDUYdEO4y"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ul1CrpBm5H0rrZlYhdIfEA75XDUYdEO4y
Content-Type: multipart/mixed; boundary="0DgKy29qpwpTjPxx9ZHosYzYcoKck294a";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
 Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
 Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
 Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
 Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>,
 Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Joonas Lahtinen <joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
 Rodrigo Vivi <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
 Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
 Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 VMware Graphics <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>,
 Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>,
 Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
 Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <67c46a2b-8127-a4b7-c825-8cba6f28db8c-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH][next] drm: Replace zero-length array with flexible-array
 member
References: <20200225140347.GA22864@embeddedor> <87a756sqdc.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
 <138ff691-94b3-1ce5-e7fa-e6d7c436bf8e-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
In-Reply-To: <138ff691-94b3-1ce5-e7fa-e6d7c436bf8e-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>

--0DgKy29qpwpTjPxx9ZHosYzYcoKck294a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Gustavo

Am 03.03.20 um 19:20 schrieb Gustavo A. R. Silva:
>=20
>=20
> On 2/25/20 08:17, Jani Nikula wrote:
>> On Tue, 25 Feb 2020, "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org> wr=
ote:
>>> The current codebase makes use of the zero-length array language
>>> extension to the C90 standard, but the preferred mechanism to declare=

>>> variable-length types such as these ones is a flexible array member[1=
][2],
>>> introduced in C99:
>>>
>>> struct foo {
>>>         int stuff;
>>>         struct boo array[];
>>> };
>>>
>>> By making use of the mechanism above, we will get a compiler warning
>>> in case the flexible array does not occur last in the structure, whic=
h
>>> will help us prevent some kind of undefined behavior bugs from being
>>> inadvertently introduced[3] to the codebase from now on.
>>>
>>> Also, notice that, dynamic memory allocations won't be affected by
>>> this change:
>>>
>>> "Flexible array members have incomplete type, and so the sizeof opera=
tor
>>> may not be applied. As a quirk of the original implementation of
>>> zero-length arrays, sizeof evaluates to zero."[1]
>>>
>>> This issue was found with the help of Coccinelle.
>>>
>>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>>> [2] https://github.com/KSPP/linux/issues/21
>>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
>>> ---
>>>  drivers/gpu/drm/etnaviv/etnaviv_gem.h         | 2 +-
>>>  drivers/gpu/drm/gma500/intel_bios.h           | 2 +-
>>>  drivers/gpu/drm/i915/display/intel_vbt_defs.h | 4 ++--
>>>  drivers/gpu/drm/i915/gt/intel_lrc.c           | 2 +-
>>>  drivers/gpu/drm/i915/i915_gpu_error.h         | 2 +-
>>
>> Please split out the i915 changes to a separate patch.
>>
>=20
> Sure thing. I can do that.

I think each driver deserves it's own patch. Makes backporting easier.

Best regards
Thomas

>=20
>>>  drivers/gpu/drm/msm/msm_gem.h                 | 2 +-
>>>  drivers/gpu/drm/qxl/qxl_cmd.c                 | 2 +-
>>>  drivers/gpu/drm/vboxvideo/vboxvideo.h         | 2 +-
>>>  drivers/gpu/drm/vc4/vc4_drv.h                 | 2 +-
>>>  drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c    | 2 +-
>>>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c       | 2 +-
>>>  include/drm/bridge/mhl.h                      | 4 ++--
>>>  include/drm/drm_displayid.h                   | 2 +-
>>>  include/uapi/drm/i915_drm.h                   | 4 ++--
>>
>> Not sure it's worth touching uapi headers. They're full of both [0] an=
d
>> []. Again, please at least split it to a separate patch to be decided
>> separately.
>>
>=20
> Yeah, it's worth it; the purpose of these patches is to replace [0] wit=
h [] across
> the whole tree.
>=20
> Thanks
> --
> Gustavo
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--0DgKy29qpwpTjPxx9ZHosYzYcoKck294a--

--Ul1CrpBm5H0rrZlYhdIfEA75XDUYdEO4y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl5l9RkACgkQaA3BHVML
eiNGUQgAgjKSCBND55SWYJrmDfa3irwlGfO6EKxH9F6r/W+oYNLwfa7Re8zDiRjN
oMHZLY2a2iKckXvawizS65l/0mqLfNQ11BfXFGBr6RAgxWt7Ac2pw1wP9FaVQ3HN
PSksqH6ASJUhgDm9hfZSRu9fZDLV1AGIWdTE/pHRcJ8inzEV543+SffD2ddPFjwV
m+hBDC678jVfSux+/aBkp40Mv9VryJTVN4TyQNRuUtmciIWSoVvoiJxk5d+0Ykcn
McM6bm+GmCvvUmjlLa7LNv8Fv9zr17XF3Q2Nv2v8Gn+sYDXY2S8RU8BXlV05XZVE
xLoQ88iIqzrGQjmARyUf0W4vvek8XQ==
=9S1h
-----END PGP SIGNATURE-----

--Ul1CrpBm5H0rrZlYhdIfEA75XDUYdEO4y--

--===============0968610042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Freedreno mailing list
Freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/freedreno

--===============0968610042==--
