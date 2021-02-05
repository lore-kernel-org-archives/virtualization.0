Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0537C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 10:08:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AA364E0D
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 10:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AA364E0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CEB7871B7;
	Fri,  5 Feb 2021 10:08:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vhqloQyNU4na; Fri,  5 Feb 2021 10:08:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F2E9B86F92;
	Fri,  5 Feb 2021 10:08:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB96C08A1;
	Fri,  5 Feb 2021 10:08:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 275A0C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 10:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 11BFA87189
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 10:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWME+20nfJtR
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 10:08:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7A02586F92
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 10:08:48 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6BAECAE76;
 Fri,  5 Feb 2021 10:08:46 +0000 (UTC)
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <0ed91db9-f70e-48dc-d826-f13d02e833ca@suse.de>
Date: Fri, 5 Feb 2021 11:08:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
Cc: airlied@linux.ie, sam@ravnborg.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, virtualization@lists.linux-foundation.org,
 hdegoede@redhat.com, noralf@tronnes.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, sean@poorly.run
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
Content-Type: multipart/mixed; boundary="===============6197825005343488558=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6197825005343488558==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z4rnQrrnAkIpE1OUWivrmJJ6fiqFTFmT9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z4rnQrrnAkIpE1OUWivrmJJ6fiqFTFmT9
Content-Type: multipart/mixed; boundary="FPjmtJ5Q1xvUMwboNPbSuumgXKHOmXYEQ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, hdegoede@redhat.com, sean@poorly.run, sam@ravnborg.org,
 noralf@tronnes.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Message-ID: <0ed91db9-f70e-48dc-d826-f13d02e833ca@suse.de>
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
In-Reply-To: <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>

--FPjmtJ5Q1xvUMwboNPbSuumgXKHOmXYEQ
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

Thanks a lot! I have on small change to the simple-kms interface for v2. =

But it doesn't make a difference overall.

Best regards
Thomas

>=20
> take care,
>    Gerd
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--FPjmtJ5Q1xvUMwboNPbSuumgXKHOmXYEQ--

--z4rnQrrnAkIpE1OUWivrmJJ6fiqFTFmT9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAdGS0FAwAAAAAACgkQlh/E3EQov+C7
lA//VZ5DaPWW35tUIvNizGPuPN0t4ZLaX8qdsSTP60SBE4zspKLbZpFnRhPDdP0mb7YhF66hnVx1
/UKPpmaVmvRLSqh85XJgSd+gaY6rVTWdvcrLGmjZiqD4jADwd73B7bvgoMhuoQFS+jSInsbdmNY+
vkXuxTAQ/pTGEUabT9snST8aNmfABAYvYRGiGfO+M48jDKQcEFi89U1uTdk8Um7CIudlAhclJE4R
ygPro0Cq5KVLwS+cQ2ZgKrxe3YxVhWkSdHbovzSZfalWafXZ4JDF/fZdLRh5dYCicuORooeO2g3s
vMF2ZDNUuMvo3r4JA1B34xjl6i3ToEG7XxQrLGgCYWlaBMA0xN2kEd9KOZtXjmXfOe/jdR0YRcmN
1n59RptfVa8j/ils4N95qktBoXqzKqQjSSVLlm/um6RubLpQg61KXlCVVDnR1YIwBX9Vb0kl3Qe4
hzi/WiGlEV/y/PlgYq/CTXJK423igqzPq7ucXaXKWmjUe59wXNVU1LCmB96evrgIjBt8pqlbPog8
mBeSkCUQ6NLJaJPlJNRSSo/SdXNm1Mo8dcQu6OedOZMePob32HYK0WouRuM6oW1bByRvg6LQMSNj
xmwhT80B7niXXbmQ2vP6DE9EhaHacRB6qmuuik1sxBw6LNI2Mopta/PavTtjYIxLMJvKAIq/+8l+
MFc=
=/ot5
-----END PGP SIGNATURE-----

--z4rnQrrnAkIpE1OUWivrmJJ6fiqFTFmT9--

--===============6197825005343488558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6197825005343488558==--
