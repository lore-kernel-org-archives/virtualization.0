From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/simple-kms: Standardize arguments for callbacks
Date: Wed, 23 Oct 2019 08:47:57 +0200
Message-ID: <64a4e824-f730-2ac4-0b02-4ead2bce4b69__3913.81360111467$1571813296$gmane$org@suse.de>
References: <20191022155536.27939-1-daniel.vetter@ffwll.ch>
	<56867554-5169-e249-8e55-043d07be3e99@suse.de>
	<CAKMK7uHo2L8m+VT1vSMjOdScJmuSQP032HyAFj_aYiCJu+gaRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4008987601348081600=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKMK7uHo2L8m+VT1vSMjOdScJmuSQP032HyAFj_aYiCJu+gaRQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Emil Velikov <emil.velikov@collabora.com>, DRI Development <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4008987601348081600==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3738eZazcuctdTVEnimlhMqC7srKkdmvs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3738eZazcuctdTVEnimlhMqC7srKkdmvs
Content-Type: multipart/mixed; boundary="IDpWwrnJOX80L69oW7hJJsPBaVOSySCT3";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>,
 Emil Velikov <emil.velikov@collabora.com>
Message-ID: <64a4e824-f730-2ac4-0b02-4ead2bce4b69@suse.de>
Subject: Re: [PATCH] drm/simple-kms: Standardize arguments for callbacks
References: <20191022155536.27939-1-daniel.vetter@ffwll.ch>
 <56867554-5169-e249-8e55-043d07be3e99@suse.de>
 <CAKMK7uHo2L8m+VT1vSMjOdScJmuSQP032HyAFj_aYiCJu+gaRQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHo2L8m+VT1vSMjOdScJmuSQP032HyAFj_aYiCJu+gaRQ@mail.gmail.com>

--IDpWwrnJOX80L69oW7hJJsPBaVOSySCT3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 22.10.19 um 21:03 schrieb Daniel Vetter:
> On Tue, Oct 22, 2019 at 7:16 PM Thomas Zimmermann <tzimmermann@suse.de>=
 wrote:
>>
>> Hi,
>>
>> there are two types of callbacks in struct
>> drm_simple_display_pipe_funcs: functions that are genuine to simple KM=
S,
>> and functions that are merely forwarded from another structure (crtc,
>> plane, etc).
>>
>> In the former category are enable(), disable(), check(), and update().=

>> Those should probably receive a simple display pipe as their first arg=
ument.
>=20
> mode_valid _very_ much belongs to this category too, since there's
> mode_valid hooks also on other objects. But simple pipe helper
> condenses that down to one mode_valid hook (we could also put the
> mode_valid onto encoder, wouldn't change anything).
>=20
>> In the latter category are mode_valid(), prepare_fb(), cleanup_fb(),
>> enable_vblank(), and disable_vblank(). IMHO those functions should
>> receive a pointer to the original structure as their first argument.
>> This type provides the context in which the operations make sense. (Ev=
en
>> their documentation already refers to the original structure.)
>=20
> Now on those you can maybe make a case that they only exist in one
> object. But the entire point of simple helpers was to condense the zoo
> of drm types down to one. Only reason you don't also get a
> drm_simple_display_pipe_state is that this one would be a bit more
> work to make work correctly. If we full on leak all the underlying
> objects, then you might as well set them up yourself and set up all
> the hooks, it's just a few more lines of code.
>=20
> Imo for simple pipe we should go more into that direction, not less.
>=20
>> I admit that not all are as shareable as prepare_fb() and enable_fb().=

>> But what else than boiler-plate wrappers do we get from simple display=

>> pipe here?
>=20
> Boiler plate wrappers is pretty much the entire point of simple pipe
> helpers. Anytime you're interested in the things it abstracts away
> (crtc, plane, encoder) you probably want your own atomic
> implementation.

I was speaking of boiler-plate code in drivers and other helpers (e.g.,
drm_gem_fb_simple_display_pipe_prepare_fb() )

TBH I don't think it is possible to build and use simple pipe without
exposing the underlying primitives (crtc, plane, connector). This would
require a completely separate set of atomic helpers. IMHO the current
simple pipe is a mid-layer and comes with typical mid-layer problems.

Anyway, given your rational for the current design, I'll update my
recent patches for prepare_fb() to support simple pipe.

For this patch

  Acked-By: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

> conversion is a good fit, it's not meant to be useful for all small
> drivers. Only for the _really_ simple ones.
>=20
> Otherwise if we readd all the bells and whistles to simple pipe
> helpers, then we just end back where we started. That's also why I
> personally think explicit simple wrappers would fit better, instead of
> wrestling the prepare/cleanup_fb functions to match full atomic
> helpers.
> -Daniel
>=20
>>
>> Best regards
>> Thomas
>>
>> Am 22.10.19 um 17:55 schrieb Daniel Vetter:
>>> Passing the wrong type feels icky, everywhere else we use the pipe as=

>>> the first parameter. Spotted while discussing patches with Thomas
>>> Zimmermann.
>>>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Eric Anholt <eric@anholt.net>
>>> Cc: Emil Velikov <emil.velikov@collabora.com>
>>> Cc: virtualization@lists.linux-foundation.org
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> ---
>>>  drivers/gpu/drm/cirrus/cirrus.c         | 2 +-
>>>  drivers/gpu/drm/drm_simple_kms_helper.c | 2 +-
>>>  drivers/gpu/drm/pl111/pl111_display.c   | 4 ++--
>>>  include/drm/drm_simple_kms_helper.h     | 2 +-
>>>  4 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus=
/cirrus.c
>>> index 7d08d067e1a4..248c9f765c45 100644
>>> --- a/drivers/gpu/drm/cirrus/cirrus.c
>>> +++ b/drivers/gpu/drm/cirrus/cirrus.c
>>> @@ -390,7 +390,7 @@ static int cirrus_conn_init(struct cirrus_device =
*cirrus)
>>>  /* -----------------------------------------------------------------=
- */
>>>  /* cirrus (simple) display pipe                                     =
       */
>>>
>>> -static enum drm_mode_status cirrus_pipe_mode_valid(struct drm_crtc *=
crtc,
>>> +static enum drm_mode_status cirrus_pipe_mode_valid(struct drm_simple=
_display_pipe *pipe,
>>>                                                  const struct drm_dis=
play_mode *mode)
>>>  {
>>>       if (cirrus_check_size(mode->hdisplay, mode->vdisplay, NULL) < 0=
)
>>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/dr=
m/drm_simple_kms_helper.c
>>> index 046055719245..15fb516ae2d8 100644
>>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>>> @@ -43,7 +43,7 @@ drm_simple_kms_crtc_mode_valid(struct drm_crtc *crt=
c,
>>>               /* Anything goes */
>>>               return MODE_OK;
>>>
>>> -     return pipe->funcs->mode_valid(crtc, mode);
>>> +     return pipe->funcs->mode_valid(pipe, mode);
>>>  }
>>>
>>>  static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
>>> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/=
pl111/pl111_display.c
>>> index 024771a4083e..703ddc803c55 100644
>>> --- a/drivers/gpu/drm/pl111/pl111_display.c
>>> +++ b/drivers/gpu/drm/pl111/pl111_display.c
>>> @@ -48,10 +48,10 @@ irqreturn_t pl111_irq(int irq, void *data)
>>>  }
>>>
>>>  static enum drm_mode_status
>>> -pl111_mode_valid(struct drm_crtc *crtc,
>>> +pl111_mode_valid(struct drm_simple_display_pipe *pipe,
>>>                const struct drm_display_mode *mode)
>>>  {
>>> -     struct drm_device *drm =3D crtc->dev;
>>> +     struct drm_device *drm =3D pipe->crtc.dev;
>>>       struct pl111_drm_dev_private *priv =3D drm->dev_private;
>>>       u32 cpp =3D priv->variant->fb_bpp / 8;
>>>       u64 bw;
>>> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_si=
mple_kms_helper.h
>>> index 4d89cd0a60db..15afee9cf049 100644
>>> --- a/include/drm/drm_simple_kms_helper.h
>>> +++ b/include/drm/drm_simple_kms_helper.h
>>> @@ -49,7 +49,7 @@ struct drm_simple_display_pipe_funcs {
>>>        *
>>>        * drm_mode_status Enum
>>>        */
>>> -     enum drm_mode_status (*mode_valid)(struct drm_crtc *crtc,
>>> +     enum drm_mode_status (*mode_valid)(struct drm_simple_display_pi=
pe *pipe,
>>>                                          const struct drm_display_mod=
e *mode);
>>>
>>>       /**
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


--IDpWwrnJOX80L69oW7hJJsPBaVOSySCT3--

--3738eZazcuctdTVEnimlhMqC7srKkdmvs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2v96AACgkQaA3BHVML
eiNyQAf/bHb3V1RDufKDc3sepf4QTxO+0RDoM9lloJKdcVq9t26IfQAMinzjluEk
zxwOy0pdI1VjWMdqnKNeTuUpmndh6kSsDhLkSB/zJtZme5ORRrfovA7/I5pkGwiQ
Oc9wLEv5OlVv8Q0b08eNeaN6WE3UrurKXL4y8nt7uuuBVyQEu84xkVlw4+4PuHFo
Oz19wOwkIhPhUQLlI/9+KyNWo4wEZfElWB9c8+FXk2IzoD1UlAFxbELQR+KWpqfS
1W7LPRboFODusOuCa9jt9p+yR3qGWjkasJu4Wna7gxLBi+bmyZ/v6lLB3fEFRnA2
oSuy2HOjtF/3pVjRMv3ceTn40o88QA==
=ZgIZ
-----END PGP SIGNATURE-----

--3738eZazcuctdTVEnimlhMqC7srKkdmvs--

--===============4008987601348081600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4008987601348081600==--
