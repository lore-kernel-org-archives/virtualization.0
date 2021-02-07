Return-Path: <SRS0=8NGF=HJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF0C433DB
	for <virtualization@archiver.kernel.org>; Sun,  7 Feb 2021 18:33:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA6464DE1
	for <virtualization@archiver.kernel.org>; Sun,  7 Feb 2021 18:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA6464DE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E6F3086839;
	Sun,  7 Feb 2021 18:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VRjUZ-wuf5Vy; Sun,  7 Feb 2021 18:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B691986830;
	Sun,  7 Feb 2021 18:33:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77B0BC08A1;
	Sun,  7 Feb 2021 18:33:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB75BC0174
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 18:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8C34286F7E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 18:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1WJWGGI-9wAv
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 18:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1B8C186F7C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 18:33:28 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0191CAD6A;
 Sun,  7 Feb 2021 18:33:26 +0000 (UTC)
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <88b6a41d-d457-6675-4692-c2dc773c9a2d@suse.de>
Date: Sun, 7 Feb 2021 19:33:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
Cc: airlied@linux.ie, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 sean@poorly.run
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
Content-Type: multipart/mixed; boundary="===============4563258017296548648=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4563258017296548648==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cYpey3WLi2LTeiB95Top8wIoUEbSK1HRh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cYpey3WLi2LTeiB95Top8wIoUEbSK1HRh
Content-Type: multipart/mixed; boundary="Lddldf1ZWyKcn0Oi46pfKAKIpPvjlmRod";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, sam@ravnborg.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 dri-devel@lists.freedesktop.org, sean@poorly.run
Message-ID: <88b6a41d-d457-6675-4692-c2dc773c9a2d@suse.de>
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
In-Reply-To: <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>

--Lddldf1ZWyKcn0Oi46pfKAKIpPvjlmRod
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 05.02.21 um 10:05 schrieb Gerd Hoffmann:
>    Hi,
>=20
>> I smoke-tested the code by running fbdev, Xorg and weston with the
>> converted mgag200 driver.
>=20
> Looks sane to me.
> Survived cirrus smoke test too.
>=20
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

I had to add one additional patch to v2 of this patchset to make things=20
work with module-only builds. If you have a minute, could you ack this=20
as well? Thanks!

https://lore.kernel.org/dri-devel/20210205150628.28072-3-tzimmermann@suse=
=2Ede/

Best regards
Thomas

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


--Lddldf1ZWyKcn0Oi46pfKAKIpPvjlmRod--

--cYpey3WLi2LTeiB95Top8wIoUEbSK1HRh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAgMnQFAwAAAAAACgkQlh/E3EQov+Dj
dBAAq7SUGl7A9fN0DSOndk4NBjCGdrLQuE1yQAUzjPCdRIOlicf1w90KOzy4vfakAZRqYd8f7h5/
GABwSMhK51JH30uH0IPLXGY25bxQu/L3jhBeP8ySDiGSHcCXTTiNdLGkQwdocTkb+cI+OQKb5bdJ
Vhuwx57IvV8DcyzTCp3IGZkqztrHfDx36PfKcmiJ/JYemq42BtBu1eIinZXdwuQPQt/MOPPxKtNE
j6Q4eMi+xmBS6igezvyRu/2SlOFxuaRu+cBnCeERV77JwCS186yax5cq2rPtDMnUeHAG7qxGhIMB
fAQYpUViXIV6HTAaMuxg8FyQ4YrxTEDFV4XZGh7DoQB3HYyEvK8g3O+LsYJINaEsbjuKQodWOcH/
P6lqSmbM4VKwDjTOVL3wNcfqs50JnpxG92wYAIma4yzg0mE4V+7LpEeHgISerrGEwnMLorLBdtta
tL/1OYkwjcsejYrs58ONa5OrvoeFqL0nxOzj1NZVp3bmpyEz0JBJ0D0lIpHnds5ajkfCfK3dLLSf
AQsmMeX+0GZNJrSzvSkn/tG4ZNUHH1W1N3Kz6WwaA4nk/LiQzc+qjb9hlT7HW4uDQSy/oAFyW/Mc
HoyOWxhowJDkB37G5wOl1SA859iZeBtxVk+JZhKMqpK/IDp2/1q11ZYKJTP7SfdHZRzhaCm4bn7e
gSs=
=2HuM
-----END PGP SIGNATURE-----

--cYpey3WLi2LTeiB95Top8wIoUEbSK1HRh--

--===============4563258017296548648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4563258017296548648==--
