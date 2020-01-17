From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events by
 default
Date: Fri, 17 Jan 2020 08:17:10 +0100
Message-ID: <fa8a22b5-9c19-7896-5b0d-06b038ed4862@suse.de>
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
 <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
 <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
 <CACvgo52gwC6U5HjnsQSUUDgE7Gp_EDb-QqCY8VDFjAX7cE0Lxg@mail.gmail.com>
 <20200116235951.GD8400@dvetter-linux.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3470916133552270718=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200116235951.GD8400@dvetter-linux.ger.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Vetter <daniel@ffwll.ch>, Emil Velikov <emil.l.velikov@gmail.com>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, Dave Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Hans de Goede <hdegoede@redhat.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, xen-devel@lists.xenproject.org, Emil Velikov <emil.velikov@collabora.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3470916133552270718==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="31xbyValn4E7bq95B5drBIEMmXCNmZCnm"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--31xbyValn4E7bq95B5drBIEMmXCNmZCnm
Content-Type: multipart/mixed; boundary="S5QhwU6gaKPyTq4N0LqU8xziaGJOq80j1";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>, Emil Velikov <emil.l.velikov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 oleksandr_andrushchenko@epam.com, Dave Airlie <airlied@linux.ie>,
 Sean Paul <sean@poorly.run>, ML dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Hans de Goede <hdegoede@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 xen-devel@lists.xenproject.org, Emil Velikov <emil.velikov@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>, david@lechnology.com
Message-ID: <fa8a22b5-9c19-7896-5b0d-06b038ed4862@suse.de>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events by
 default
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
 <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
 <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
 <CACvgo52gwC6U5HjnsQSUUDgE7Gp_EDb-QqCY8VDFjAX7cE0Lxg@mail.gmail.com>
 <20200116235951.GD8400@dvetter-linux.ger.corp.intel.com>
In-Reply-To: <20200116235951.GD8400@dvetter-linux.ger.corp.intel.com>

--S5QhwU6gaKPyTq4N0LqU8xziaGJOq80j1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 17.01.20 um 00:59 schrieb Daniel Vetter:
> On Thu, Jan 16, 2020 at 05:22:34PM +0000, Emil Velikov wrote:
>> Hi all,
>>
>> On Thu, 16 Jan 2020 at 07:37, Thomas Zimmermann <tzimmermann@suse.de> =
wrote:
>>
>>>> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu=
/drm/drm_atomic_state_helper.c
>>>> index 7cf3cf936547..23d2f51fc1d4 100644
>>>> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
>>>> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
>>>> @@ -149,6 +149,11 @@ void __drm_atomic_helper_crtc_duplicate_state(s=
truct drm_crtc *crtc,
>>>>       /* Self refresh should be canceled when a new update is availa=
ble */
>>>>       state->active =3D drm_atomic_crtc_effectively_active(state);
>>>>       state->self_refresh_active =3D false;
>>>> +
>>>> +     if (drm_dev_has_vblank(crtc->dev))
>>>> +             state->no_vblank =3D true;
>>>> +     else
>>>> +             state->no_vblank =3D false;
>>>>  }
>>>>  EXPORT_SYMBOL(__drm_atomic_helper_crtc_duplicate_state);
>>>
>>> I think the if/else branches are in the wrong order.
>=20
> Yeah fumbled that.
>=20
>>> But generally speaking, is it really that easy? The xen driver alread=
y
>>> has to work around simple-kms's auto-enabling of no_vblank (see patch=

>>> 4). Maybe this settings interferes with other drivers as well. At lea=
st
>>> the calls for sending fake vblanks should be removed from all affecte=
d
>>> drivers.
>=20
> Hm xen is really special, in that it has a flip complete event, but not=
 a
> vblank. I think forcing drivers to overwrite stuff in that case makes
> sense.
>=20
>> I'm not sure if setting no_vblank based on dev->num_crtcs is the corre=
ct thing.
>> From the original commit and associated description for no_vblank:
>>
>> In some cases CRTCs are active but are not able to generating events, =
at
>> least not at every frame at it's expected to.
>> This is typically the case when the CRTC is feeding a writeback connec=
tor...
>=20
> Yeah, but Thomas' series here wants to extend that. And I think if we r=
oll
> this out the common case will be "no hw vblank", and the writeback spec=
ial

Default values should usually be 0 for zalloc and static initializers.
Should we rename no_vblank to has_vblank then?

> case is going to be the exception to the exception. Yup, patch 1 that
> updates the docs doesn't reflect that, which is why I'm bringing up mor=
e
> suggestions here around code & semantics of all these pieces to make th=
em
> do the most reasonable thing for most of the drivers.
>=20
>> Reflects the ability of a CRTC to send VBLANK events....
>>
>>
>> The proposed handling of no_vblank feels a little dirty, although
>> nothing better comes to mind.
>> Nevertheless code seems perfectly reasonable, so if it were me I'd mer=
ge it.
>=20
> The idea with setting it very early is that drivers can overwrite it ve=
ry
> easily. Feels slightly dirty, so I guess we could also set it somewhere=
 in
> the atomic_helper_check function (similar to how we set the various
> crtc->*_changed flags, but we're not entirely consistent on these eithe=
r).
>=20
> For the overall thing what feels irky to me is making this no_vblank
> default logic (however we end up computing it in the end, whether like
> this or what I suggested) specific to simple pipe helpers feels kinda
> wrong. Simple pipe tends to have a higher ratio of drivers for hw witho=
ut
> vblank support, but by far not the only ones. Having that special case
> feels confusing to me (and likely will trip up some people, vblank and
> event handling is already a huge source of confusion in drm).

Making it a default for simple KMS was only the start. I intended to
cover all drivers at some point. I just didn't want to go through all
drivers at once.

I guess for the patchset's v3 I'll audit all drivers for the use of
no_blank and drm_crtc_send_vblank_event(); and convert the possible
candidates.

Best regards
Thomas

>=20
> One idea behind drm_dev_has_vblank() is also that we could formalize a =
bit
> all that, at least for the usual case - xen and maybe others being some=

> exceptions as usual (hence definitely not something the core code shoul=
d
> handle).
>=20
> Cheers, Daniel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--S5QhwU6gaKPyTq4N0LqU8xziaGJOq80j1--

--31xbyValn4E7bq95B5drBIEMmXCNmZCnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4hX3oACgkQaA3BHVML
eiOx3wf+JL6tqWlEX9L40nwERe3Rlr1Xvm8ER1K8MDUck/KmXTB3g7JQAG5VJNK0
GS6Ty7upA/SBZqxeI/cj96fVQ/Gq4WmZ+89EeTDXI5BNm56vJeL+VF+7BW1nSYGn
MqaKotRUhYOTRShgDRlSzyhvZCTQG82HUQb50y/dPGJMb5a48qwxG4XVhc24zV6V
Suw+MpBWQlYwOqKXGviNiJUfSvS7XhH4r66hDPcJLawuCG3LCp7m5r0JcZJW2qbL
SBmdgjJ4NeLr7oteSPn2BOEW8+9Zas86xaV5Ekxn/oRR3Jw9W+1uWWYVQlycpWJz
3t3ViGqnZGaSTTCI4P25n4iJGgkXIA==
=RnyY
-----END PGP SIGNATURE-----

--31xbyValn4E7bq95B5drBIEMmXCNmZCnm--

--===============3470916133552270718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3470916133552270718==--
