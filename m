Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B38FC433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 18:40:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD70964E05
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 18:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD70964E05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 73C69870D3;
	Mon, 15 Feb 2021 18:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 702hWSMjH+Cf; Mon, 15 Feb 2021 18:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C253187095;
	Mon, 15 Feb 2021 18:40:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE80C0893;
	Mon, 15 Feb 2021 18:40:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6231C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 18:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B54A184E5D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 18:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63D_kAYdP17s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 18:40:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8CC2A84E55
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 18:40:00 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 38F23ACD4;
 Mon, 15 Feb 2021 18:39:58 +0000 (UTC)
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <b50fe1ac-57a5-26da-b358-d8c90578948d@suse.de>
Date: Mon, 15 Feb 2021 19:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
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
Content-Type: multipart/mixed; boundary="===============5599542580918245846=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5599542580918245846==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="65kZwvqIiuzbJZeYhiRShIjtH1xfj7yM2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--65kZwvqIiuzbJZeYhiRShIjtH1xfj7yM2
Content-Type: multipart/mixed; boundary="7tqD3VmYMHLzuULlIYlVHY9UeroFKCm2X";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, hdegoede@redhat.com, sean@poorly.run, sam@ravnborg.org,
 noralf@tronnes.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Message-ID: <b50fe1ac-57a5-26da-b358-d8c90578948d@suse.de>
Subject: Re: [PATCH 0/6] drm: Move vmap out of commit tail for SHMEM-based
 drivers
References: <20210204200308.24216-1-tzimmermann@suse.de>
 <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>
In-Reply-To: <20210205090514.ln6eeoqfcijrd5q2@sirius.home.kraxel.org>

--7tqD3VmYMHLzuULlIYlVHY9UeroFKCm2X
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

Reviewers are hard to find. Since you reviewed the shadow-plane=20
conversion for cirrus; may I ask you for a review of a similar patchset=20
in the ast driver. It's mostly about moving code around. In the end, ast =

cursors will use generic shadow planes as well.

=20
https://lore.kernel.org/dri-devel/20210209134632.12157-1-tzimmermann@suse=
=2Ede/

If you have something where I can help out with a review, let me know.

Best regards
Thomas

>=20
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
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


--7tqD3VmYMHLzuULlIYlVHY9UeroFKCm2X--

--65kZwvqIiuzbJZeYhiRShIjtH1xfj7yM2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAqv/wFAwAAAAAACgkQlh/E3EQov+BF
HBAAtAkQJzvpwuAeTX/XI6z4jaCJk1TiKuYZP+/D6wL8wWZPbiR1mqLIjUCeddM86UQBNYbugIND
OGVH9vBBA6U/bc3hf8xKZWGJBPMye0J1sVHDxbuhUxS8xLSdI8bYv8v7/mlu3E1TAUF1g1u9VFj9
zn2biCquo9S/Z80vePIhhGuLf/VClnnU8BjoD3VVp4WeUP1gj/1/9NubcapTfMJERrYdVV6P1iJP
uLqFEhlzdCRJCkRw9CDHn6CTRQhyYqZBNbSKrL3sGtO+AXxReT7BA2qr1jeMgkp743azZFS6lSa2
D+Pr4cENKgeOX3B6xHWSUp2KiTRpOKYBwQWk5TTmflLYcZdVF/ORnH/Rcrdntva1zlwYmqRJY00A
gAnuI5c++zugmy5joH/xgRCOpm+VarvxqdOUYN4K4LK1LkSqkZwrjK48XqjDpVohnT+EdmW6qJNH
wpJmzR6a74wjZwRc7q8tiI1tZ7I7j1HRLOdz2XlP1pR1E+msYiOq3VzwM6f9UwJlJdK8ZCdZ5AR2
0X0bAJIEV/MAWJoFw5xKPWvT/1X4Hkuh9JnwFrPOojI2fr40XgqOpsbo1DdRTgsYs1pvERT0JvzD
lHysQqgoZrMPa6DtHdOcWIiL9B3Y8upI5uWIMVqywRJ+YwOWOWo433V0mVgFTpTMbYpColaoTjxK
xzc=
=aCVH
-----END PGP SIGNATURE-----

--65kZwvqIiuzbJZeYhiRShIjtH1xfj7yM2--

--===============5599542580918245846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5599542580918245846==--
