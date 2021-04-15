Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D252C433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 11:02:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BF7611AB
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 11:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BF7611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3A1160C1A;
	Thu, 15 Apr 2021 11:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqYv4qR_DJdy; Thu, 15 Apr 2021 11:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30C3D60727;
	Thu, 15 Apr 2021 11:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA191C000C;
	Thu, 15 Apr 2021 11:02:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B48BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C8D040219
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H72IR0p7KdGa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:02:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AE29401CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:02:48 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3334FAE5C;
 Thu, 15 Apr 2021 11:02:46 +0000 (UTC)
Subject: Re: [PATCH v2 08/10] drm/simpledrm: Acquire clocks from DT device node
To: Maxime Ripard <maxime@cerno.tech>
References: <20210318102921.21536-1-tzimmermann@suse.de>
 <20210318102921.21536-9-tzimmermann@suse.de>
 <20210408081353.ojt2kgnnbh6kp6gp@gilmour>
 <3c7bacd1-e40e-0953-9ad9-9f79274106d5@suse.de>
 <20210415092123.7zn6fbnkuqlajord@gilmour>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <9b21042c-9908-3847-702a-cb891d1769e0@suse.de>
Date: Thu, 15 Apr 2021 13:02:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415092123.7zn6fbnkuqlajord@gilmour>
Cc: robh@kernel.org, bluescreen_avenger@verizon.net, geert+renesas@glider.be,
 corbet@lwn.net, airlied@linux.ie, emil.l.velikov@gmail.com,
 linux-doc@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 lgirdwood@gmail.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 broonie@kernel.org, daniel@ffwll.ch, sam@ravnborg.org
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
Content-Type: multipart/mixed; boundary="===============6615183649379100512=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6615183649379100512==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pv9oRcu0brx3qp43qMsIO2M2HlTYKSgAh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pv9oRcu0brx3qp43qMsIO2M2HlTYKSgAh
Content-Type: multipart/mixed; boundary="CcQrpjqdj87PdBCsgqbGS58fbpaH1Wc0B";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Maxime Ripard <maxime@cerno.tech>
Cc: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 kraxel@redhat.com, corbet@lwn.net, lgirdwood@gmail.com, broonie@kernel.org,
 sam@ravnborg.org, robh@kernel.org, emil.l.velikov@gmail.com,
 geert+renesas@glider.be, hdegoede@redhat.com,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org
Message-ID: <9b21042c-9908-3847-702a-cb891d1769e0@suse.de>
Subject: Re: [PATCH v2 08/10] drm/simpledrm: Acquire clocks from DT device
 node
References: <20210318102921.21536-1-tzimmermann@suse.de>
 <20210318102921.21536-9-tzimmermann@suse.de>
 <20210408081353.ojt2kgnnbh6kp6gp@gilmour>
 <3c7bacd1-e40e-0953-9ad9-9f79274106d5@suse.de>
 <20210415092123.7zn6fbnkuqlajord@gilmour>
In-Reply-To: <20210415092123.7zn6fbnkuqlajord@gilmour>

--CcQrpjqdj87PdBCsgqbGS58fbpaH1Wc0B
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.04.21 um 11:21 schrieb Maxime Ripard:
> Hi,
>=20
> On Thu, Apr 15, 2021 at 09:31:01AM +0200, Thomas Zimmermann wrote:
>> Am 08.04.21 um 10:13 schrieb Maxime Ripard:
>>> Hi,
>>>
>>> On Thu, Mar 18, 2021 at 11:29:19AM +0100, Thomas Zimmermann wrote:
>>>> Make sure required hardware clocks are enabled while the firmware
>>>> framebuffer is in use.
>>>>
>>>> The basic code has been taken from the simplefb driver and adapted
>>>> to DRM. Clocks are released automatically via devres helpers.
>>>>
>>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Tested-by: nerdopolis <bluescreen_avenger@verizon.net>
>>>
>>> Even though it's definitely simpler to review, merging the driver fir=
st
>>> and then the clocks and regulators will break bisection on the platfo=
rms
>>> that rely on them
>>
>> I'd like to keep the patches separate for now, but can squash patches =
6 to 8
>> them into one before pushing them. OK?
>=20
> Yep, that works for me :)
>=20
>>>
>>> Another thing worth considering is also that both drivers will probe =
if
>>> they are enabled (which is pretty likely), which is not great :)
>>>
>>> I guess we should make them mutually exclusive through Kconfig
>>
>> We already have several drivers in fbdev and DRM that handle the same
>> hardware. We don't do this for any other pair, why bother now?
>=20
> Yeah, but simplefb/simpledrm are going to be enabled pretty much
> everywhere, as opposed to the other drivers that are more specialized.

Well, OK. But I'd like to give simpledrm preference over simplefb. There =

should be an incentive to switch to DRM.

Best regards
Thomas

>=20
> Maxime
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=FCrnberg, Germany
(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer


--CcQrpjqdj87PdBCsgqbGS58fbpaH1Wc0B--

--pv9oRcu0brx3qp43qMsIO2M2HlTYKSgAh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmB4HVQFAwAAAAAACgkQlh/E3EQov+AF
pxAAozROWie7dTxAtiRfgzQSS03XukbT+QHR6seC98Xrm+SH2tiSpSBZNZ/L857rVnPWBGaXcmPu
u4XvB6rJZ8n87m10g1nQjODoeAdRInWOXn9pRwLbcEmMcQBNPx224OCjtijEtDvmnnX/efsJJ9mX
/+f2/n4T5+FlCfQgGF9MDLmZEjCxNYwlU63zwS3Ben6WZYtS0aYPKUjctDRAJAyGtO7u4mbu1P+b
OIqvx/bezvuuEQbvxLIr61VOg1fDkRWBMgyx6aKcr6wJHOcGFyGTw2KTWl0TKN0CmQpRyA+dnDZM
jfv7WUxsIvJc3+3UNqfM46BXKVMG2bx0df5K9dWcNfJMYThnUaqooXXvu2Ea+SqjtCPBwoa6TyHT
qTceXK3/h/UNOjIZh/I69CYkeJeWgYzOvyf3AlCWAZUPZml2zomzHRRH+anK8QDZ+nEjX7+f73FG
qWQVp2Zzv6pfVAUhQtpqYwNh22RmUgmWgDweT1bK4U2636HpEeAOAzO4/zMYPpm6Dkp3Cl3LpwHI
+jtGcIruoG98psJcBdiwELvIH22Rs3VxukqSROaRuWqVtYkgwaP7LZPZ8Vg+4hXkfb0d5vqK95G9
makNHChC9A14HgJ+uRXZXbl21H2fhrqV2uJNwOe35P7JjSgedWFoJLlyb1Hoz1O2iRTGdrzGGKPw
hRM=
=tU5/
-----END PGP SIGNATURE-----

--pv9oRcu0brx3qp43qMsIO2M2HlTYKSgAh--

--===============6615183649379100512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6615183649379100512==--
