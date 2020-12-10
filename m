Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D44C4361B
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:42:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F6923D56
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F6923D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5194987752;
	Thu, 10 Dec 2020 11:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d5PP0DpQYpKd; Thu, 10 Dec 2020 11:42:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1967C8774A;
	Thu, 10 Dec 2020 11:42:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE7B4C0FA7;
	Thu, 10 Dec 2020 11:42:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C85A1C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BC3FF8774A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SBPXC0FX6A1w
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CD18187742
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:42:25 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B1475AE47;
 Thu, 10 Dec 2020 11:42:21 +0000 (UTC)
Subject: Re: [PATCH v2 09/20] drm/i915: Remove references to struct
 drm_device.pdev
To: Jani Nikula <jani.nikula@linux.intel.com>, airlied@linux.ie,
 daniel@ffwll.ch
References: <20201201103542.2182-1-tzimmermann@suse.de>
 <20201201103542.2182-10-tzimmermann@suse.de>
 <7c9b3127-0e79-fd22-0bba-b3e8430d876a@suse.de> <875z5a9gns.fsf@intel.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <48afe494-eab1-7dac-0f8c-ad1acd31cbfe@suse.de>
Date: Thu, 10 Dec 2020 10:24:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <875z5a9gns.fsf@intel.com>
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 spice-devel@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org
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
Content-Type: multipart/mixed; boundary="===============7669636320923971625=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7669636320923971625==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LHeFyx9QqIlGkEMELLBaAod1WWnnwq7bD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LHeFyx9QqIlGkEMELLBaAod1WWnnwq7bD
Content-Type: multipart/mixed; boundary="UYNLXYvdyqt1LAH6LX9dVWFS9wYsDJzAN";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Jani Nikula <jani.nikula@linux.intel.com>, airlied@linux.ie,
 daniel@ffwll.ch
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 amd-gfx@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 spice-devel@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org
Message-ID: <48afe494-eab1-7dac-0f8c-ad1acd31cbfe@suse.de>
Subject: Re: [PATCH v2 09/20] drm/i915: Remove references to struct
 drm_device.pdev
References: <20201201103542.2182-1-tzimmermann@suse.de>
 <20201201103542.2182-10-tzimmermann@suse.de>
 <7c9b3127-0e79-fd22-0bba-b3e8430d876a@suse.de> <875z5a9gns.fsf@intel.com>
In-Reply-To: <875z5a9gns.fsf@intel.com>

--UYNLXYvdyqt1LAH6LX9dVWFS9wYsDJzAN
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 10.12.20 um 10:03 schrieb Jani Nikula:
> On Tue, 08 Dec 2020, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> ping for a review of the i915 patches
>=20
> What did you have in mind regarding merging the series? Should we just
> pick the patches up?

Originally I thought that individual trees would merge their rsp=20
patches. I guess the larger drivers could get some minor conflicts.

Amdgpu/radeon devs suggested to put everything into drm-misc-next at=20
once. I'd prefer that, but ultimately it's up to you.

Best regards
Thomas

>=20
> BR,
> Jani.
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--UYNLXYvdyqt1LAH6LX9dVWFS9wYsDJzAN--

--LHeFyx9QqIlGkEMELLBaAod1WWnnwq7bD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/R6T8FAwAAAAAACgkQlh/E3EQov+D+
yBAAkmsb7v4JGw4GBDqZWXkf5yeRsZn3lzy9FuCJ49HPiWArqivWYnYoWu9O070xkrdvcGcbAsTO
L/JtiL8Nd5xwyw9A0lRhxes/adNTLIStoJGT/JfLUHLGXO3CiO2OnKxKnOMihtqlB/dUlvmB2B7J
4mNXjMyo06DEcDvsyFATN3BYRFRj1MFYUkzwXMrLAHQ9QXyvHrBMU6sfBuN/zwnKrXPmy9NevK2w
SAuSBY8kMiimRwWYSF2ZlaC/TVE9S97iEiTU7jo5CkXetNBVNUABRUOvG3JIlISV2GeJ19MBaPPd
KcJUyxuCLT/TJU+DPnfw92YWHbb/LGAEpsSCB0wd1S7Uokf3XDiqYfOn9PXRfsqo+m+lYv9AhPEz
MGpCSuqZFIv4OO9wQsUIeTZlqyNUF0W4jjmGDHvtzkcbQ7laRq+PzxgZ7WiWOxU5N7g2tcHdh7Q7
8mTfXYiOfZCbgakQ8t8DqW8ZvUtB2CqgfcWVbGkcVKnfR8Wmp9eTpFbTzrFd64/1mhC3DA5QtkRI
W6XV4PvCD1wLJetvEAXSo09A8d8NXyMG9NxyQ2ySF5w82dA2kswS7LsRSDFUHE3hEk+7HrJZZQkb
0odsemajAYcKfi5ab5WrszULfTV8IhCxACylTnqyKR4LoFfTk+WjRTwWeV4LYqn8rvmHnc1wXesh
jbo=
=uTJr
-----END PGP SIGNATURE-----

--LHeFyx9QqIlGkEMELLBaAod1WWnnwq7bD--

--===============7669636320923971625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7669636320923971625==--
