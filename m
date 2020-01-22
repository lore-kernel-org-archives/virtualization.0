From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events by
 default
Date: Wed, 22 Jan 2020 09:20:07 +0100
Message-ID: <32a4a3ba-0f3a-27c9-4d7f-c9f85de94cb4@suse.de>
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
 <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
 <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
 <CACvgo52gwC6U5HjnsQSUUDgE7Gp_EDb-QqCY8VDFjAX7cE0Lxg@mail.gmail.com>
 <20200116235951.GD8400@dvetter-linux.ger.corp.intel.com>
 <fa8a22b5-9c19-7896-5b0d-06b038ed4862@suse.de>
 <20200122081104.GN43062@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7823249061182476468=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200122081104.GN43062@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, Dave Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>, Emil Velikov <emil.l.velikov@gmail.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Hans de Goede <hdegoede@redhat.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, xen-devel@lists.xenproject.org, Sam Ravnborg <sam@ravnborg.org>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7823249061182476468==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MYMcMdmk1LNu428DM8AAIBCtQQ8SbK5F0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MYMcMdmk1LNu428DM8AAIBCtQQ8SbK5F0
Content-Type: multipart/mixed; boundary="w5oWgMpZQufKwX3PNsMei1A8FksoTy6gb";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com,
 Dave Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 xen-devel@lists.xenproject.org, Emil Velikov <emil.velikov@collabora.com>,
 Sean Paul <sean@poorly.run>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <32a4a3ba-0f3a-27c9-4d7f-c9f85de94cb4@suse.de>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events by
 default
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
 <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
 <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
 <CACvgo52gwC6U5HjnsQSUUDgE7Gp_EDb-QqCY8VDFjAX7cE0Lxg@mail.gmail.com>
 <20200116235951.GD8400@dvetter-linux.ger.corp.intel.com>
 <fa8a22b5-9c19-7896-5b0d-06b038ed4862@suse.de>
 <20200122081104.GN43062@phenom.ffwll.local>
In-Reply-To: <20200122081104.GN43062@phenom.ffwll.local>

--w5oWgMpZQufKwX3PNsMei1A8FksoTy6gb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 22.01.20 um 09:11 schrieb Daniel Vetter:
> On Fri, Jan 17, 2020 at 08:17:10AM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 17.01.20 um 00:59 schrieb Daniel Vetter:
>>> On Thu, Jan 16, 2020 at 05:22:34PM +0000, Emil Velikov wrote:
>>>> Hi all,
>>>>
>>>> On Thu, 16 Jan 2020 at 07:37, Thomas Zimmermann <tzimmermann@suse.de=
> wrote:
>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/g=
pu/drm/drm_atomic_state_helper.c
>>>>>> index 7cf3cf936547..23d2f51fc1d4 100644
>>>>>> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
>>>>>> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
>>>>>> @@ -149,6 +149,11 @@ void __drm_atomic_helper_crtc_duplicate_state=
(struct drm_crtc *crtc,
>>>>>>       /* Self refresh should be canceled when a new update is avai=
lable */
>>>>>>       state->active =3D drm_atomic_crtc_effectively_active(state);=

>>>>>>       state->self_refresh_active =3D false;
>>>>>> +
>>>>>> +     if (drm_dev_has_vblank(crtc->dev))
>>>>>> +             state->no_vblank =3D true;
>>>>>> +     else
>>>>>> +             state->no_vblank =3D false;
>>>>>>  }
>>>>>>  EXPORT_SYMBOL(__drm_atomic_helper_crtc_duplicate_state);
>>>>>
>>>>> I think the if/else branches are in the wrong order.
>>>
>>> Yeah fumbled that.
>>>
>>>>> But generally speaking, is it really that easy? The xen driver alre=
ady
>>>>> has to work around simple-kms's auto-enabling of no_vblank (see pat=
ch
>>>>> 4). Maybe this settings interferes with other drivers as well. At l=
east
>>>>> the calls for sending fake vblanks should be removed from all affec=
ted
>>>>> drivers.
>>>
>>> Hm xen is really special, in that it has a flip complete event, but n=
ot a
>>> vblank. I think forcing drivers to overwrite stuff in that case makes=

>>> sense.
>>>
>>>> I'm not sure if setting no_vblank based on dev->num_crtcs is the cor=
rect thing.
>>>> From the original commit and associated description for no_vblank:
>>>>
>>>> In some cases CRTCs are active but are not able to generating events=
, at
>>>> least not at every frame at it's expected to.
>>>> This is typically the case when the CRTC is feeding a writeback conn=
ector...
>>>
>>> Yeah, but Thomas' series here wants to extend that. And I think if we=
 roll
>>> this out the common case will be "no hw vblank", and the writeback sp=
ecial
>>
>> Default values should usually be 0 for zalloc and static initializers.=

>> Should we rename no_vblank to has_vblank then?
>=20
> Hm, imo feels like hw without vblank is still the uncommon case. I'd le=
ave
> this as-is, but also no objections if you feel like repainting :-)

Not a bit. ;)

>=20
>>> case is going to be the exception to the exception. Yup, patch 1 that=

>>> updates the docs doesn't reflect that, which is why I'm bringing up m=
ore
>>> suggestions here around code & semantics of all these pieces to make =
them
>>> do the most reasonable thing for most of the drivers.
>>>
>>>> Reflects the ability of a CRTC to send VBLANK events....
>>>>
>>>>
>>>> The proposed handling of no_vblank feels a little dirty, although
>>>> nothing better comes to mind.
>>>> Nevertheless code seems perfectly reasonable, so if it were me I'd m=
erge it.
>>>
>>> The idea with setting it very early is that drivers can overwrite it =
very
>>> easily. Feels slightly dirty, so I guess we could also set it somewhe=
re in
>>> the atomic_helper_check function (similar to how we set the various
>>> crtc->*_changed flags, but we're not entirely consistent on these eit=
her).
>>>
>>> For the overall thing what feels irky to me is making this no_vblank
>>> default logic (however we end up computing it in the end, whether lik=
e
>>> this or what I suggested) specific to simple pipe helpers feels kinda=

>>> wrong. Simple pipe tends to have a higher ratio of drivers for hw wit=
hout
>>> vblank support, but by far not the only ones. Having that special cas=
e
>>> feels confusing to me (and likely will trip up some people, vblank an=
d
>>> event handling is already a huge source of confusion in drm).
>>
>> Making it a default for simple KMS was only the start. I intended to
>> cover all drivers at some point. I just didn't want to go through all
>> drivers at once.
>>
>> I guess for the patchset's v3 I'll audit all drivers for the use of
>> no_blank and drm_crtc_send_vblank_event(); and convert the possible
>> candidates.
>=20
> Yeah it's a pain, thanks for volunteering. Just figured the half-step h=
ere
> is too much in the uncanney valley. If we're going to polish this, let'=
s
> do it right (and we have plenty enough drivers to make sure what we pic=
k
> will be a solid choice I think).

I went through the drivers and updated them. It's the ones covered here
plus some more virtual HW. My search heuristic was to look for drivers
that call drm_crtc_send_vblank_event() but do not call
drm_vblank_init(). Please see v3 of this patchset. It should be pending
on this ML.

Best regards
Thomas

> -Daniel
>=20
>>
>> Best regards
>> Thomas
>>
>>>
>>> One idea behind drm_dev_has_vblank() is also that we could formalize =
a bit
>>> all that, at least for the usual case - xen and maybe others being so=
me
>>> exceptions as usual (hence definitely not something the core code sho=
uld
>>> handle).
>>>
>>> Cheers, Daniel
>>>
>>
>> --=20
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
>> (HRB 36809, AG N=C3=BCrnberg)
>> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>>
>=20
>=20
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--w5oWgMpZQufKwX3PNsMei1A8FksoTy6gb--

--MYMcMdmk1LNu428DM8AAIBCtQQ8SbK5F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4oBbcACgkQaA3BHVML
eiPDsAf9HE9E9wGmSJwzZ4OrzsqzCY37EhFnHvEaF31nFA1ZJhtCFYl1tlttVcHW
qlqudA5YvW2GcvcByvUIHnGuRcIPKtKAU3GEReVcDQVkDuqA70qtWK8a/VqX0Tep
YNiYFh+DldYaV6hrOe9l8wfcHRIivnmINDQo6np4v7I0/aXMgdWUzvSbmJhtm0z4
alrpsWrSnQTeqRIwhPlVdr5BfPaG+xU2tzCkrfGb+w1vWFQUVVID9pZadrotoyQW
5HTQCFiWrNU/aOXoT0IdoJ9j+G629HnarlbSKC/4dALC2CFETQOt7KklkHck8VU1
DrRirCUKBp+TQq2tdXVes/DVMWQPaA==
=0fVB
-----END PGP SIGNATURE-----

--MYMcMdmk1LNu428DM8AAIBCtQQ8SbK5F0--

--===============7823249061182476468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7823249061182476468==--
