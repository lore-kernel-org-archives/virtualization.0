Return-Path: <SRS0=15y9=JX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AC4C433ED
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 12:22:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CFA61178
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 12:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CFA61178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 147944028A;
	Mon, 26 Apr 2021 12:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6wcdW1bQ_Mn; Mon, 26 Apr 2021 12:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF2B140290;
	Mon, 26 Apr 2021 12:22:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9490DC000F;
	Mon, 26 Apr 2021 12:22:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55103C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 12:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35A9B40290
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 12:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T3_D3zOsbYC6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 12:22:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 573264028A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 12:22:23 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9DA0CAC38;
 Mon, 26 Apr 2021 12:22:21 +0000 (UTC)
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20210416090048.11492-1-tzimmermann@suse.de>
 <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
 <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
 <20210420092204.7azdb7nxgofegjht@sirius.home.kraxel.org>
 <CAMuHMdX=0H3LHP5Yme9tpN4JnmpJcnF=SQN8bc=4XTd-X6AVTg@mail.gmail.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <e2d46fc0-5452-5d13-0354-e2e9bd407139@suse.de>
Date: Mon, 26 Apr 2021 14:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX=0H3LHP5Yme9tpN4JnmpJcnF=SQN8bc=4XTd-X6AVTg@mail.gmail.com>
Cc: bluescreen_avenger@verizon.net,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Emil Velikov <emil.l.velikov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1498130638604914008=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1498130638604914008==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j3vG4wKnJAormeO5lVRoEdvWqXNHNlWdV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j3vG4wKnJAormeO5lVRoEdvWqXNHNlWdV
Content-Type: multipart/mixed; boundary="2FNIcz9YNwfBpAUZWENkhSI2HLlwytP1d";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: bluescreen_avenger@verizon.net, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 virtualization@lists.linux-foundation.org,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <e2d46fc0-5452-5d13-0354-e2e9bd407139@suse.de>
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
References: <20210416090048.11492-1-tzimmermann@suse.de>
 <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
 <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
 <20210420092204.7azdb7nxgofegjht@sirius.home.kraxel.org>
 <CAMuHMdX=0H3LHP5Yme9tpN4JnmpJcnF=SQN8bc=4XTd-X6AVTg@mail.gmail.com>
In-Reply-To: <CAMuHMdX=0H3LHP5Yme9tpN4JnmpJcnF=SQN8bc=4XTd-X6AVTg@mail.gmail.com>

--2FNIcz9YNwfBpAUZWENkhSI2HLlwytP1d
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 20.04.21 um 11:27 schrieb Geert Uytterhoeven:
> Hi Gerd,
>=20
> On Tue, Apr 20, 2021 at 11:22 AM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
>>>>> Patches 4 to 8 add the simpledrm driver. It's build on simple DRM h=
elpers
>>>>> and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. =
During
>>>>
>>>> .... if support for 8-bit frame buffers would be added?
>>>
>>> Is that 8-bit greyscale or 8-bit indexed with 256 entry palette? Form=
er
>>> shouldn't be a big thing, but the latter is only really supported by =
the
>>> overall drm ecosystem in theory. Most userspace assumes that xrgb8888=

>>> works, and we keep that illusion up by emulating it in kernel for hw =
which
>>> just doesn't support it. But reformatting xrgb8888 to c8 is tricky at=

>>> best.
>>
>> Well.  cirrus converts xrgb8888 on the fly to rgb888 or rgb565
>> (depending on display resolution).  We could pull off the same trick
>> here and convert to rgb332 (assuming we can program the palette with t=
he
>> color cube needed for that).  Wouldn't look pretty, but would probably=

>> work better than expecting userspace know what color palettes are in
>> 2021 ...
>=20
> Yeah, I already had a similar idea for Amiga HAM ;-)

I vaguely remember that HAM mode uses some crazy format where pixel=20
colors depend in the values of their neighbors. (?) How complicated is=20
it to write a conversion from RGB to HAM?

Best regards
Thomas

>=20
> Gr{oetje,eeting}s,
>=20
>                          Geert
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--2FNIcz9YNwfBpAUZWENkhSI2HLlwytP1d--

--j3vG4wKnJAormeO5lVRoEdvWqXNHNlWdV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCGsHwFAwAAAAAACgkQlh/E3EQov+DV
lg//T7tmFsNA85Ryaq43kUbOtlqmcj7ZRZmIOn53tHJll440AxyiFwERA/g6ZHEo44WKCQ6Y7R8j
8miZfCpgssWp00gkkROFaFhhEd8370QuTGOlFPe8R655rcdQYzsm8z5teGkdba0li3ONM8CdQVVH
6UGMuBbZvySDYuRtT1vqW/9AvOMbWn1ge1zJYp+VKH7tJKLQVLEd1gxgwC7EHxp11lPrL0G0IWOH
lSUuXUFA80atM/0udglvjPdKeoDpVyYE9jAWzGSO5B/nsBmpmnQV1Id71D+u1bYkze/YIBxGT+gs
WYUaPDKtmpZtUJh4GBlXsggdw5TviUZj+0MDY8iu9G5ihCvkl7hOsK+ZwMXa7KnrlFrizoCBDpaP
BkPhW4/7iqS8lFs00ICiCJIW8wmK7aPM1jm6tWBetn2B7Um0UM34ndM9S/gO9LeRHpP+7DVaAZIV
cezd6kRUbldR3KM1VKIvVoYxI55TkKQI5L8sMgMfDZx/z7OD8wbsgG97VSDwHI/lxN12pwWRbDDN
l+p6gJZrLTqwft6gQHlVNqDLULZE5vGs01RYC1L99HNvgvja5U1hb6Uroo4O1Nj2BjfYiFLhUcg1
4FkQR8/SaUVXDC70YVIa9o6Jq1rzqm5bOLlv8+mpFx9HYE7Kh4yxlwjSp+B5+C0/WcaE0YyIdciz
8pw=
=CgI8
-----END PGP SIGNATURE-----

--j3vG4wKnJAormeO5lVRoEdvWqXNHNlWdV--

--===============1498130638604914008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1498130638604914008==--
