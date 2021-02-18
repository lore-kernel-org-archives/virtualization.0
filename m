Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF0C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 13:33:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C43564EAE
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 13:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C43564EAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 197B88734F;
	Thu, 18 Feb 2021 13:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ql1R7XMx1g4g; Thu, 18 Feb 2021 13:33:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E611E87343;
	Thu, 18 Feb 2021 13:33:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2249C0017;
	Thu, 18 Feb 2021 13:33:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88DC9C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 13:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 81A5E86637
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 13:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0887135I2RD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 13:33:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F1D9286640
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 13:33:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D2AF6ACE5;
 Thu, 18 Feb 2021 13:33:12 +0000 (UTC)
Subject: Re: [PATCH v2 10/11] drm/qxl: rework cursor plane
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-11-kraxel@redhat.com>
 <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
 <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <2d7a649c-bf1d-aa41-8d3c-af9746b94bc0@suse.de>
Date: Thu, 18 Feb 2021 14:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4370611668077668609=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4370611668077668609==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nY8nnbVTZ7BT0N6Kj6baQxQEwgr1cULoW"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nY8nnbVTZ7BT0N6Kj6baQxQEwgr1cULoW
Content-Type: multipart/mixed; boundary="UncSznus3ByHfOkcxonBdJz5e6MeKSXqO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Dave Airlie
 <airlied@redhat.com>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>
Message-ID: <2d7a649c-bf1d-aa41-8d3c-af9746b94bc0@suse.de>
Subject: Re: [PATCH v2 10/11] drm/qxl: rework cursor plane
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-11-kraxel@redhat.com>
 <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
 <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>
In-Reply-To: <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>

--UncSznus3ByHfOkcxonBdJz5e6MeKSXqO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.02.21 um 12:50 schrieb Gerd Hoffmann:
>    Hi,
>=20
>> I'm still trying to wrap my head around the qxl cursor code.
>>
>> Getting vmap out of the commit tail is good, but I feel like this isn'=
t
>> going in the right direction overall.
>>
>> In ast, these helper functions were only good when converting the drvi=
er to
>> atomic modesetting. So I removed them in the latst patchset and did al=
l the
>> updates in the plane helpers directly.
>=20
> I see the helper functions more as a way to get some structure into the=

> code flow.  The callbacks are easier to read if they just call helper
> functions for stuff which needs more than a handful lines of code
> (patch 9/11 exists for the same reason).
>=20
> The helpers also make it easier move work from one callback to another,=

> but that is just a useful side-effect.
>=20
> I had considered making that two separate patches, one factor out code
> into functions and one moving the calls.  Turned out to not be that eas=
y
> though, because the old qxl_cursor_atomic_update() code was a rather
> hairy mix of qxl_create_cursor() + qxl_primary_apply_cursor() +
> qxl_primary_move_cursor().
>=20
>> For cursor_bo itself, it seems to be transitional state that is only u=
sed
>> during the plane update and crtc update . It should probably be stored=
 in a
>> plane-state structure.
>>
>> Some of the primary plane's functions seem to deal with cursor handlin=
g.
>> What's the role of the primary plane in cursor handling?
>=20
> It's a quirk.  The qxl device will forget the cursor state on
> qxl_io_create_primary(), so I have to remember the cursor state
> and re-establish it by calling qxl_primary_apply_cursor() again.
>=20
> So I'm not sure sticking this into plane state would work.  Because of
> the quirk this is more than just a handover from prepare to commit.
>=20
>> For now, I suggest to merge patch 1 to 8 and 11; and move the cursor p=
atches
>> into a new patchset.
>=20
> I can merge 1-8, but 11 has to wait until the cursor is sorted.
> There is a reason why 11 is last in the series ;)
>=20
>> I'd like ot hear Daniel's opinion on this. Do you have
>> further plans here?
>=20
> Well.  I suspect I could easily spend a month cleaning up and party
> redesign the qxl driver (specifically qxl_draw.c + qxl_image.c).
>=20
> I'm not sure I'll find the time to actually do that anytime soon.
> I have plenty of other stuff on my TODO list, and given that the
> world is transitioning to virtio-gpu the priority for qxl isn't
> that high.

Well, in that case:

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

for patches 9 and 10. Having the vmap calls fixed is at least worth it.

Best regards
Thomas

>=20
> So, no, I have no short-term plans for qxl beyond fixing pins +
> reservations + lockdep.
>=20
> take care,
>    Gerd
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--UncSznus3ByHfOkcxonBdJz5e6MeKSXqO--

--nY8nnbVTZ7BT0N6Kj6baQxQEwgr1cULoW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAubJcFAwAAAAAACgkQlh/E3EQov+BB
5BAAiaqEuFQuNX/Edte8pTgw0EtC+8JuFX94XO6ZPE14G7zF8aoqmPSoTZ7mfazDN0kqhCUbOUpX
jcDLZuRE+KoJEi75UcxkbejxT2/HZiwTwmL/Nq0Lbv6gVq7X4v+mVflSMKeZytS3Xq98IEOn/Y43
ud9e064McQ0NNgOJb5Fjy2Rjd6rujdFU73B8rE5NumkiaJptCk+qE/TAJipSGXXSJ1zkgvSHSAga
OutrnKsSUXe8i0BHJUMrK2LaK2Zkheb2GCUe9QxSOThoDEtuEz0NBOU2eoYewkE4IBBO+DXeQ6wp
Qnd5D0kIkh+qBe8SWwPqXIGNsEhoEdkuEmfdEN/BsqOdr3mL1p1bks8ZHpgqyNSH1UQ/irka0buz
eTFUnWuirhRrPWJo8lC65LvaINW+BRjcmq5PcZTKLMPPYn7UFzbL/PCNIggAwDbwiaAReHzUiwui
XqAgB5cchmLxz3OjBiJgPM3rgIldcvOFIt2qu8e44nwnYMG97ifpDDWydfwmGj4VcU2ejV5T3kBN
eHbbWSTMgKHT6L2IeOIRAeTjc/r5DmuX6uLGz3OXYS/oPlR+zNKpRaxIbgyQxTIlZ2OkzykXl8Sj
DBeIHA466qiG1dHoWKW/zqNjmgKxFrZ/dAnmGxH7eqbkw/ZymCs4PP8Z1Z5k8+L/0bU50Nonm5bx
HZc=
=9OXG
-----END PGP SIGNATURE-----

--nY8nnbVTZ7BT0N6Kj6baQxQEwgr1cULoW--

--===============4370611668077668609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4370611668077668609==--
