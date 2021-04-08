Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86770C433B4
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 11:34:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146A46113C
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 11:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146A46113C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6C7560E6B;
	Thu,  8 Apr 2021 11:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z_YwzcbOM9Co; Thu,  8 Apr 2021 11:34:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62B3A60660;
	Thu,  8 Apr 2021 11:34:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C520C000B;
	Thu,  8 Apr 2021 11:34:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96210C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DD9E404B0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ploJOa6LcKws
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:34:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15EA440350
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:34:06 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CF712B229;
 Thu,  8 Apr 2021 11:34:04 +0000 (UTC)
Subject: Re: [PATCH 0/4] drm: Generic dumb_map_offset for TTM-based drivers
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210406082942.24049-1-tzimmermann@suse.de>
 <YG7mHvmhPZIPA37B@phenom.ffwll.local>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <52dd3e3f-a893-3d90-e642-df01a033490a@suse.de>
Date: Thu, 8 Apr 2021 13:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG7mHvmhPZIPA37B@phenom.ffwll.local>
Cc: airlied@linux.ie, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org, bskeggs@redhat.com
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
Content-Type: multipart/mixed; boundary="===============4461556446211819599=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4461556446211819599==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wtPaAHNX0gkUUytT5iAsY74CPhbxKSfTl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wtPaAHNX0gkUUytT5iAsY74CPhbxKSfTl
Content-Type: multipart/mixed; boundary="qHPZSfiFLTcaOfLLakODrcFJUrLuyNz8z";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 kraxel@redhat.com, spice-devel@lists.freedesktop.org, bskeggs@redhat.com
Message-ID: <52dd3e3f-a893-3d90-e642-df01a033490a@suse.de>
Subject: Re: [PATCH 0/4] drm: Generic dumb_map_offset for TTM-based drivers
References: <20210406082942.24049-1-tzimmermann@suse.de>
 <YG7mHvmhPZIPA37B@phenom.ffwll.local>
In-Reply-To: <YG7mHvmhPZIPA37B@phenom.ffwll.local>

--qHPZSfiFLTcaOfLLakODrcFJUrLuyNz8z
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 08.04.21 um 13:16 schrieb Daniel Vetter:
> On Tue, Apr 06, 2021 at 10:29:38AM +0200, Thomas Zimmermann wrote:
>> The implementation of drm_driver.dumb_map_offset is the same for sever=
al
>> TTM-based drivers. Provide a common function in GEM-TTM helpers.
>=20
> Out of curiosity, why does this not fit for radeon/amdgpu?

These drivers perform additional permission checks in their implementatio=
ns.

But those checks are also part of the actual mmap code. I want to=20
propose a patch to use the generic drm_gem_ttm_map_offset in=20
amdgpu/radeon, and then rely on mmap to fail if necessary. It might=20
result in a longer discussion, so that's for another patchset.

Best regards
Thomas

> -Daniel
>=20
>>
>> Thomas Zimmermann (4):
>>    drm/gem-ttm-helper: Provide helper for struct
>>      drm_driver.dumb_map_offset
>>    drm/vram-helper: Use drm_gem_ttm_dumb_map_offset()
>>    drm/nouveau: Use drm_gem_ttm_dumb_map_offset()
>>    drm/qxl: Use drm_gem_ttm_dumb_map_offset()
>>
>>   drivers/gpu/drm/drm_gem_ttm_helper.c      | 33 ++++++++++++++++
>>   drivers/gpu/drm/drm_gem_vram_helper.c     | 48 ---------------------=
--
>>   drivers/gpu/drm/nouveau/nouveau_display.c | 18 ---------
>>   drivers/gpu/drm/nouveau/nouveau_display.h |  2 -
>>   drivers/gpu/drm/nouveau/nouveau_drm.c     |  3 +-
>>   drivers/gpu/drm/qxl/qxl_drv.c             |  3 +-
>>   drivers/gpu/drm/qxl/qxl_drv.h             |  3 --
>>   drivers/gpu/drm/qxl/qxl_dumb.c            | 17 --------
>>   drivers/gpu/drm/qxl/qxl_ioctl.c           |  4 +-
>>   drivers/gpu/drm/qxl/qxl_object.h          |  5 ---
>>   include/drm/drm_gem_ttm_helper.h          |  5 ++-
>>   include/drm/drm_gem_vram_helper.h         |  7 +---
>>   12 files changed, 45 insertions(+), 103 deletions(-)
>>
>> --
>> 2.30.2
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--qHPZSfiFLTcaOfLLakODrcFJUrLuyNz8z--

--wtPaAHNX0gkUUytT5iAsY74CPhbxKSfTl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmBu6iwFAwAAAAAACgkQlh/E3EQov+Bo
xA/+N/inEFG7DAxEuVBieUUeYry0VZLHkDhsuHDNCkbAxyPqlhO/SSDCCESlPAsm7FgzLYuklbhm
aB7wxekjdILBNWFLV0l6ymkF7lzTxdEZi2pi/Or8iJxEhOohWNyahKXsLfzgfqeN7sqjHNi/5h3B
HZnfLn24dQmOs767YvshMRDMkP7t4jIp5UM2XCHs/sDlOC6fevqOJCgVSZ65gj/WvvpfopbsLKnT
xibHhMyRlFxYwuAvamzcP6j364nN5yaVWDYBX2XYrTGCRV8BcN5IIvhq3464xOfwyFLUp/TSynL1
tm+AoFDJEJJBkDUjeBsqryu3ZcL+7fWaiYDY5vMTXb7nO/wh7mChfatnTiw2XlKHJ40ERuPRJ7iW
hQ+FyJdpx9HSTjLqgvJxROnmOa2zix+eO4ORtnqrDMCUpmDaeHkuRGadwcZR73/pA53hBiEKjvan
4XbhDa+njjUEtLLkAoFl0NaAfd+ezN2xFwv4iYA0NnGxDvzStWjOWxZphqunDTMMufu3p1e1/IZE
1E+4p9s8GSXsp0tPH+pGns5tt2HKBzaLuS+Cbbwu4nJLNuLTn8PKGhvFvjR82Fi6jUBzrV5Gs3yx
PlFhk+sWo1qm0yJWjSvW/civrO64AdAl8jGcMcPU6dLY92TfFksZwkXeq7SL7+FSKolX4GK93lBi
aBE=
=bGEM
-----END PGP SIGNATURE-----

--wtPaAHNX0gkUUytT5iAsY74CPhbxKSfTl--

--===============4461556446211819599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4461556446211819599==--
