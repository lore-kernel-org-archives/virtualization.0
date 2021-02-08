Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FFC433E9
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 11:25:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC9C64E30
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 11:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC9C64E30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BEDCC87087;
	Mon,  8 Feb 2021 11:25:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZhB5esj0gG1; Mon,  8 Feb 2021 11:25:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1137F87071;
	Mon,  8 Feb 2021 11:25:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E57CBC0174;
	Mon,  8 Feb 2021 11:25:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C07D0C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE599868F0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZsT-dwlH2ATC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:25:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B9FC6867A7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:25:27 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4FE01AE85;
 Mon,  8 Feb 2021 11:25:26 +0000 (UTC)
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
 <88b6a41d-d457-6675-4692-c2dc773c9a2d@suse.de>
 <20210208105352.6mw7w6hlefrer5al@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <7a62641e-9276-fcab-7cd8-5543cfce0467@suse.de>
Date: Mon, 8 Feb 2021 12:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208105352.6mw7w6hlefrer5al@sirius.home.kraxel.org>
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
Content-Type: multipart/mixed; boundary="===============2000708677501567211=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2000708677501567211==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mF1TWG1lkMIx2GGMlCq95NisX01ksNRcb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mF1TWG1lkMIx2GGMlCq95NisX01ksNRcb
Content-Type: multipart/mixed; boundary="KmbtihYI2ty0mNn0YK7LSiBltEUUPqKp4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 sean@poorly.run
Message-ID: <7a62641e-9276-fcab-7cd8-5543cfce0467@suse.de>
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
 <88b6a41d-d457-6675-4692-c2dc773c9a2d@suse.de>
 <20210208105352.6mw7w6hlefrer5al@sirius.home.kraxel.org>
In-Reply-To: <20210208105352.6mw7w6hlefrer5al@sirius.home.kraxel.org>

--KmbtihYI2ty0mNn0YK7LSiBltEUUPqKp4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 08.02.21 um 11:53 schrieb Gerd Hoffmann:
> On Sun, Feb 07, 2021 at 07:33:24PM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 05.02.21 um 10:05 schrieb Gerd Hoffmann:
>>>     Hi,
>>>
>>>> I smoke-tested the code by running fbdev, Xorg and weston with the
>>>> converted mgag200 driver.
>>>
>>> Looks sane to me.
>>> Survived cirrus smoke test too.
>>>
>>> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> I had to add one additional patch to v2 of this patchset to make thing=
s work
>> with module-only builds. If you have a minute, could you ack this as w=
ell?
>> Thanks!
>=20
> Works fine too.

Thanks! I'll count this as an ack.

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


--KmbtihYI2ty0mNn0YK7LSiBltEUUPqKp4--

--mF1TWG1lkMIx2GGMlCq95NisX01ksNRcb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAhH6UFAwAAAAAACgkQlh/E3EQov+C7
jhAAgg7uymETg3/HZL+K9mNHfQk1W73+Il1DTGrWl0LwvCc+/7EKxXvtzzWinPw2VDvfjcq6bnao
5kjmVUNqwYrOW62ksEqpJSMQFMbVch/aXonPM1yGKkhqWF75wPa0MRkOXusZqXkk4DPyrOOhUPZK
pljQwn/FI/YAnNpAifA+dmaG09yqVD7iZjHdGMatZQPmratL2c9YBlcIpLT/4TcdZIccOKXjVfWt
zYlJGT3cUMg0J6gub3eQhWgY2JVFY+YlCK916S98kOU9lc6SkW+vZB8nsDqvuMmR6jEJKa/b6Roj
YuJGpdg6whepmP1i6zVFslGX8UXRVYfrpXWw2ZApOH5bnnDiU8UVyRSENA0uGbzTrdNs+eqXTV7j
Mz+yJKZJldVLS+CmQyEy9vMK46UziZL3HPHFNdJxxVEnnQIQQFTFxDwJr9EFKbrrlpWqAM4LBQR9
Nc16jRtRXkF/of33s6hqfw6DCaeorWcMAbnaIR3P8CexJGxlGqWymPkLIKBAgf+uH3oItmofQdwe
Mf/Jh2TVQlKO2ovvtDHey+NwEZ6fOCq91GrNCHIdIod+VoLOpPw+N1xezuhPw9xhSJSQOoiKupDy
6iGEWjVmVpSirBoFul/kpjL0M4CuGRsllsNFAtkDoUD/nn148JQYwyZYAdjsJIFB+yAE6LrxvY+T
SZM=
=Ep96
-----END PGP SIGNATURE-----

--mF1TWG1lkMIx2GGMlCq95NisX01ksNRcb--

--===============2000708677501567211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2000708677501567211==--
