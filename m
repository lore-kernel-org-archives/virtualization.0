From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 01/15] drm: Initialize struct drm_crtc_state.no_vblank
 from device settings
Date: Mon, 27 Jan 2020 19:42:27 +0100
Message-ID: <183782e6-164c-bae8-90e0-906edb059a1d@suse.de>
References: <20200123092123.28368-1-tzimmermann@suse.de>
 <20200123092123.28368-2-tzimmermann@suse.de>
 <CACvgo53YvKjPNNshZoTjJehHyOX6e05kJ5gAXtjwxs+oLLv7vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8148662793110252667=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACvgo53YvKjPNNshZoTjJehHyOX6e05kJ5gAXtjwxs+oLLv7vw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, Dave Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, Daniel Vetter <daniel@ffwll.ch>, xen-devel@lists.xenproject.org, Emil Velikov <emil.velikov@collabora.com>, Sean Paul <sean@poorly.run>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8148662793110252667==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xOxj5EAc8eozWsu9aetd70iPvMav8MAEx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xOxj5EAc8eozWsu9aetd70iPvMav8MAEx
Content-Type: multipart/mixed; boundary="plrgK2rFyOclW2N2pxB9OddQThC5DZIA4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 david@lechnology.com, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Sean Paul <sean@poorly.run>, oleksandr_andrushchenko@epam.com,
 Sam Ravnborg <sam@ravnborg.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Emil Velikov <emil.velikov@collabora.com>, xen-devel@lists.xenproject.org,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
Message-ID: <183782e6-164c-bae8-90e0-906edb059a1d@suse.de>
Subject: Re: [PATCH v4 01/15] drm: Initialize struct drm_crtc_state.no_vblank
 from device settings
References: <20200123092123.28368-1-tzimmermann@suse.de>
 <20200123092123.28368-2-tzimmermann@suse.de>
 <CACvgo53YvKjPNNshZoTjJehHyOX6e05kJ5gAXtjwxs+oLLv7vw@mail.gmail.com>
In-Reply-To: <CACvgo53YvKjPNNshZoTjJehHyOX6e05kJ5gAXtjwxs+oLLv7vw@mail.gmail.com>

--plrgK2rFyOclW2N2pxB9OddQThC5DZIA4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Emil

Am 27.01.20 um 19:12 schrieb Emil Velikov:
> Hi Thomas,
>=20
> On Thu, 23 Jan 2020 at 09:21, Thomas Zimmermann <tzimmermann@suse.de> w=
rote:
>=20
>> @@ -174,12 +174,22 @@ struct drm_crtc_state {
>>          * @no_vblank:
>>          *
>>          * Reflects the ability of a CRTC to send VBLANK events. This =
state
>> -        * usually depends on the pipeline configuration, and the main=
 usuage
>> -        * is CRTCs feeding a writeback connector operating in oneshot=
 mode.
>> -        * In this case the VBLANK event is only generated when a job =
is queued
>> -        * to the writeback connector, and we want the core to fake VB=
LANK
>> -        * events when this part of the pipeline hasn't changed but ot=
hers had
>> -        * or when the CRTC and connectors are being disabled.
>> +        * usually depends on the pipeline configuration. If set to tr=
ue, DRM
>> +        * atomic helpers will sendout a fake VBLANK event during disp=
lay
>> +        * updates.
>> +        *
>> +        * One usage is for drivers and/or hardware without support fo=
r VBLANK
>> +        * interrupts. Such drivers typically do not initialize vblank=
ing
>> +        * (i.e., call drm_vblank_init() wit the number of CRTCs). For=
 CRTCs
>> +        * without initialized vblanking, the field is initialized to =
true and
>> +        * a VBLANK event will be send out on each update of the displ=
ay
>> +        * pipeline.
>> +        *
>> +        * Another usage is CRTCs feeding a writeback connector operat=
ing in
>> +        * oneshot mode. In this case the VBLANK event is only generat=
ed when
>> +        * a job is queued to the writeback connector, and we want the=
 core
>> +        * to fake VBLANK events when this part of the pipeline hasn't=
 changed
>> +        * but others had or when the CRTC and connectors are being di=
sabled.
>>          *
>=20
> Perhaps it's just me, yet the following ideas would make the topic
> significantly easier and clearer.
>=20
>  - adding explicit "fake" when talking about drm/atomic _helpers_
> generating/sending a VBLANK event.
> For example, in 15/15 the commit message says "fake", while inline
> comment omits it... Leading to the confusion pointed out.

No problem on being more precise here. I'll update the docs accordingly.

>=20
> - s/no_vblank/fake_vblank/g or s/no_vblank/no_hw_vblank/g
> Simple and concise. With slight inclination towards the former wording =
:-)

I'd prefer to not change the field's name. The current name 'no_vblank'
indicates state and lets helpers decide what to do with it. The name
'fake_vblank' indicates an instruction to the helpers, telling them what
to do. It does neither seem to fit into drm_crtc_state, nor into the
overall concept.

Best regards
Thomas

>=20
> If you and Daniel agree with the rename, then the first sentence of
> the description should probably be tweaked.
>=20
> HTH
> Emil
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--plrgK2rFyOclW2N2pxB9OddQThC5DZIA4--

--xOxj5EAc8eozWsu9aetd70iPvMav8MAEx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4vLxMACgkQaA3BHVML
eiMniQgAoMHRhI6ErQBZBW15wxr+4WFi1xiReRxPUJNhDs1YsUJvsMwE0AXBHbkh
j5lmVFmbd5rv/EMgDYibBpMVY/zAL1EYuuqxdEVS6YmhH63SUWNtIvcfnIakofEK
2MvRXne7UCX1Nh0l1vxr3iYailXChIGSC4FLQb3SrgDUGKGZw+pBEIH+7w4hwXOY
yVIPmaCLUXIcjBX1Wu6CA0IP2BinpAVa+6lpUJ7H2628CVTzwV5p7VyZhtEUawlJ
KR4W0gb1z864Biqs0IA2Ukp7WKHY51L96JhqwWofJULi5xIsmFptyW/gVND3MBW8
O0CfSFppbmZQhlT+vO3wof3qZmTbGg==
=b1dk
-----END PGP SIGNATURE-----

--xOxj5EAc8eozWsu9aetd70iPvMav8MAEx--

--===============8148662793110252667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8148662793110252667==--
