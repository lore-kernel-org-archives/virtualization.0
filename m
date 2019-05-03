From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 01/19] drm: Add |struct drm_gem_vram_object| and helpers
Date: Fri, 3 May 2019 14:27:39 +0200
Message-ID: <a96ad14d-698b-ca7b-cbdb-347801c70ce0__29554.8741518118$1556909298$gmane$org@suse.de>
References: <20190429144341.12615-1-tzimmermann@suse.de>
	<20190429144341.12615-2-tzimmermann@suse.de>
	<20190429195855.GA6610@ravnborg.org>
	<1d14ef87-e1cd-4f4a-3632-bc045a1981c6@suse.de>
	<20190430092327.GA13757@ravnborg.org>
	<6e07e6c9-2ce7-c39f-8d55-46e811c61510@amd.com>
	<a2398439-3bb5-d1ef-db94-82f252f461c2@suse.de>
	<CAKMK7uGnUeeK-UPHZC+P5TsQTaOWPQd=LLV_Rr+VvPgNEEHhyg@mail.gmail.com>
	<c74362eb-c43a-a7be-5b52-106d207e8a8d@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4102515004177848698=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c74362eb-c43a-a7be-5b52-106d207e8a8d@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "Huang, Ray" <Ray.Huang@amd.com>, "zourongrong@gmail.com" <zourongrong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4102515004177848698==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wso2WylJrYE5BAjCVStQkMEIaju382Ct5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wso2WylJrYE5BAjCVStQkMEIaju382Ct5
Content-Type: multipart/mixed; boundary="4cdtrBoVZJR3xHpx49LzB45tdXPpojWto";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>, "airlied@linux.ie" <airlied@linux.ie>,
 "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>
Message-ID: <a96ad14d-698b-ca7b-cbdb-347801c70ce0@suse.de>
Subject: Re: [PATCH v3 01/19] drm: Add |struct drm_gem_vram_object| and
 helpers
References: <20190429144341.12615-1-tzimmermann@suse.de>
 <20190429144341.12615-2-tzimmermann@suse.de>
 <20190429195855.GA6610@ravnborg.org>
 <1d14ef87-e1cd-4f4a-3632-bc045a1981c6@suse.de>
 <20190430092327.GA13757@ravnborg.org>
 <6e07e6c9-2ce7-c39f-8d55-46e811c61510@amd.com>
 <a2398439-3bb5-d1ef-db94-82f252f461c2@suse.de>
 <CAKMK7uGnUeeK-UPHZC+P5TsQTaOWPQd=LLV_Rr+VvPgNEEHhyg@mail.gmail.com>
 <c74362eb-c43a-a7be-5b52-106d207e8a8d@amd.com>
In-Reply-To: <c74362eb-c43a-a7be-5b52-106d207e8a8d@amd.com>

--4cdtrBoVZJR3xHpx49LzB45tdXPpojWto
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

cc: noralf@tronnes.org

Am 03.05.19 um 14:07 schrieb Koenig, Christian:
> Am 03.05.19 um 14:01 schrieb Daniel Vetter:
>> [CAUTION: External Email]
>>
>> On Fri, May 3, 2019 at 12:15 PM Thomas Zimmermann <tzimmermann@suse.de=
> wrote:
>>> Hi Christian,
>>>
>>> would you review the whole patch set? Daniel mentioned that he'd pref=
er
>>> to leave the review to memory-mgmt developers.
>> I think Noralf Tronnes or Gerd Hoffmann would also make good reviewers=

>> for this, fairly close to what they've been working on in the past.
>=20
> I will try to take another look next week. Busy as usual here.

Thanks, I'll post v4 of the patches early next week.

> Christian.
>=20
>> -Daniel
>>
>>> Best regards
>>> Thomas
>>>
>>> Am 30.04.19 um 11:35 schrieb Koenig, Christian:
>>>> Am 30.04.19 um 11:23 schrieb Sam Ravnborg:
>>>>> [CAUTION: External Email]
>>>>>
>>>>> Hi Thomas.
>>>>>
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * Returns the container of type &struct drm_gem_vram_object
>>>>>>>> + * for field bo.
>>>>>>>> + * @bo:           the VRAM buffer object
>>>>>>>> + * Returns:       The containing GEM VRAM object
>>>>>>>> + */
>>>>>>>> +static inline struct drm_gem_vram_object* drm_gem_vram_of_bo(
>>>>>>>> +  struct ttm_buffer_object *bo)
>>>>>>>> +{
>>>>>>>> +  return container_of(bo, struct drm_gem_vram_object, bo);
>>>>>>>> +}
>>>>>>> Indent funny. USe same indent as used in other parts of file for
>>>>>>> function arguments.
>>>>>> If I put the argument next to the function's name, it will exceed =
the
>>>>>> 80-character limit. From the coding-style document, I could not se=
e what
>>>>>> to do in this case. One solution would move the return type to a
>>>>>> separate line before the function name. I've not seen that anywher=
e in
>>>>>> the source code, so moving the argument onto a separate line and
>>>>>> indenting by one tab appears to be the next best solution. Please =
let me
>>>>>> know if there's if there's a preferred style for cases like this o=
ne.
>>>>> Readability has IMO higher priority than some limit of 80 chars.
>>>>> And it hurts readability (at least my OCD) when style changes
>>>>> as you do with indent here. So my personal preference is to fix
>>>>> indent and accect longer lines.
>>>> In this case the an often used convention (which is also kind of
>>>> readable) is to add a newline after the return values, but before th=
e
>>>> function name. E.g. something like this:
>>>>
>>>> static inline struct drm_gem_vram_object*
>>>> drm_gem_vram_of_bo(struct ttm_buffer_object *bo)
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> But you ask for a preferred style - which I do not think we have in=
 this
>>>>> case. So it boils down to what you prefer.
>>>>>
>>>>> Enough bikeshedding, thanks for the quick response.
>>>>>
>>>>>           Sam
>>> --
>>> Thomas Zimmermann
>>> Graphics Driver Developer
>>> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
>>> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
>>> HRB 21284 (AG N=C3=BCrnberg)
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--4cdtrBoVZJR3xHpx49LzB45tdXPpojWto--

--wso2WylJrYE5BAjCVStQkMEIaju382Ct5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzMM7sACgkQaA3BHVML
eiNqMggAv9r5WqFL9LGjuADBqLu3tKaTKc7I8UJXF1E+GwvGepKtxQ3uj/c8alcv
IlMbVydXMyHqfMa1IcUmSaHOL89mucpR0QyYbVKdw/hENsN/qtHdVnnusanr1FbQ
D5BXtE4JdZgLUsPr+G3nKJW0O8j3EXA8ZzK2P1kPgFut7D5vfwRBb9tS680d8I0+
qJUGsmzQpL9jj4Iuoc1xctB1VtFZAj0wv3D8dcO+5ec4NbEKaZU/h211e/RxEwM7
QDWB865KJaMjRY38REsyHZJfBf6AW6F0ngNcdpWbMu/NtI9j0o8IxLastIK4vsKS
ORE/+kLmTmWpm858mh8PlZ8Zs9yM+A==
=wQDH
-----END PGP SIGNATURE-----

--wso2WylJrYE5BAjCVStQkMEIaju382Ct5--

--===============4102515004177848698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4102515004177848698==--
