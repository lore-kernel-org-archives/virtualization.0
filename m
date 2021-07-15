Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F38C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 11:45:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9EE613BA
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 11:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9EE613BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DA2960B5D;
	Thu, 15 Jul 2021 11:45:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zr5AE7ra8m9m; Thu, 15 Jul 2021 11:45:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80EF96074B;
	Thu, 15 Jul 2021 11:45:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55EC3C001A;
	Thu, 15 Jul 2021 11:45:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED38C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB070415A3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="AV7jvbq6";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="5/zsxVNP"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a4c-Xxrg3pBg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:45:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B221A414BE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:45:42 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05DAE2291C;
 Thu, 15 Jul 2021 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626349540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNOiYM64D0XdBystkwy6NCXzF/faGnX77dvFKQJZz90=;
 b=AV7jvbq6DvW3jzotSD7kwBtv9bxmixN3jIxa3YxTbl6XqKMbOuaYRmUgV067qYtpRcso4Q
 sxPOUkw14SIrT/uzTAR+lp0oxD+6VCacuLW3Jhy0Hg8QAqoH8jaGtI3cTj8fdZurdtFcII
 5SXjIeaGjIIUkcivwDIq7lTd4bjypfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626349540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNOiYM64D0XdBystkwy6NCXzF/faGnX77dvFKQJZz90=;
 b=5/zsxVNPpAXvbQD0+jHZIV/Qf/mQMKVhzNOtYTYAHsHzV9N31TxS9Z4lmqOLa5oKw0VHys
 mhH3AdCG21XsScDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CECCA13D89;
 Thu, 15 Jul 2021 11:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id zK4OMeMf8GDbMQAAGKfGzw
 (envelope-from <tzimmermann@suse.de>); Thu, 15 Jul 2021 11:45:39 +0000
Subject: Re: [PATCH -next v2] drm/bochs: Fix missing pci_disable_device() on
 error in bochs_pci_probe()
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
References: <20210715020551.1030812-1-yangyingliang@huawei.com>
 <49771e7d-666a-bac3-2cd7-23008a95ad8e@suse.de>
 <22ff114a-9810-37f4-43c2-22ce55d6482f@huawei.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <5d694c99-18fe-9790-df6a-d6d258b133f5@suse.de>
Date: Thu, 15 Jul 2021 13:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <22ff114a-9810-37f4-43c2-22ce55d6482f@huawei.com>
Cc: airlied@linux.ie
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
Content-Type: multipart/mixed; boundary="===============5770591988541248937=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5770591988541248937==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aqlkHsf0eQfhuGP9gSI1va5sw3lzu55Iq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aqlkHsf0eQfhuGP9gSI1va5sw3lzu55Iq
Content-Type: multipart/mixed; boundary="jiN1hXlrZAcYwDZmtPkSVWLJ0mmfLmxnR";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: airlied@linux.ie, kraxel@redhat.com
Message-ID: <5d694c99-18fe-9790-df6a-d6d258b133f5@suse.de>
Subject: Re: [PATCH -next v2] drm/bochs: Fix missing pci_disable_device() on
 error in bochs_pci_probe()
References: <20210715020551.1030812-1-yangyingliang@huawei.com>
 <49771e7d-666a-bac3-2cd7-23008a95ad8e@suse.de>
 <22ff114a-9810-37f4-43c2-22ce55d6482f@huawei.com>
In-Reply-To: <22ff114a-9810-37f4-43c2-22ce55d6482f@huawei.com>

--jiN1hXlrZAcYwDZmtPkSVWLJ0mmfLmxnR
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.07.21 um 13:03 schrieb Yang Yingliang:
>=20
> On 2021/7/15 17:30, Thomas Zimmermann wrote:
>> Hi,
>>
>> for the change
>>
>>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>>
>> but there are some style issues AFAICS.
> OK, need I resend it with the style changes and your ack ?

Please do. I'll merge it a few days later if no further comments come in.=


Best regards
Thomas

>>
>> Am 15.07.21 um 04:05 schrieb Yang Yingliang:
>>> Replace pci_enable_device() with pcim_enable_device(),
>>> pci_disable_device() will be called in release automatically.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>
>> S-o-b line goes first
>>
>>> ---
>>> v2:
>>> =C2=A0=C2=A0 use pcim_enable_device()
>>
>> This changelog should rather be located between the commit description=
=20
>> and the first S-o-b line.
>>
>> Best regards
>> Thomas
>>
>>> ---
>>> =C2=A0 drivers/gpu/drm/tiny/bochs.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/boch=
s.c
>>> index a2cfecfa8556..73415fa9ae0f 100644
>>> --- a/drivers/gpu/drm/tiny/bochs.c
>>> +++ b/drivers/gpu/drm/tiny/bochs.c
>>> @@ -648,7 +648,7 @@ static int bochs_pci_probe(struct pci_dev *pdev, =

>>> const struct pci_device_id *ent
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(dev))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR=
(dev);
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D pci_enable_device(pdev);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D pcim_enable_device(pdev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_free_=
dev;
>>>
>>

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--jiN1hXlrZAcYwDZmtPkSVWLJ0mmfLmxnR--

--aqlkHsf0eQfhuGP9gSI1va5sw3lzu55Iq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmDwH+MFAwAAAAAACgkQlh/E3EQov+CP
rA//VBmygDY27/jOPapIR8wIXFeNX8Mp8qn9EKO+u8UzAbM85Ylsj157m2hw4RPeusCogzJOiq5z
3XpadiQaDFjQ8emXOBZFdzHEwcxRP43V+xVYzfPtHSuagcgsOlafVJXK+MHTqRaJ8CVTGUvXfPVH
mtnsJRvXHsS71vs1hOMYyv97mKWIuvrH3eSTTroL6RBWQXX9Gs2p9JjS+s+4ur1zaPnohJ5RnCbU
OGjseWN9R7KisRcFmFrEKpBGjffo8wTb/3QkLXQ/63hGXZwWmlIsQ4uadKCY2bvPYX6j/WdSM+vP
+M2X01nBjsVKjpbJy1DJzkMf2RmQIat1IY+s4e58Y0vFPwdRKwNmC+IwayzT9432djV1KrcNu4Az
fnXS+LvuWO9U2qpiw+j1KWa6Z3AnoTjHZaWZqlMiGbtONjKWvQMaPm6CGOT0HgRE2OhvZ6VIweLy
l4DYUs6kbxpVTtYhwSyZ42rf6v89O3X8KJLLmuJLBWQx4dP3m9qztkyAY3/lB2K1VhpdGloqMFIo
8+ocheH+FtUCHPhpwEAEXk0LMQTyT0YWkhJ5wrmwp+bca9FtF7Qaszdxuask52+aYSh7Pq3qXd4d
0iYQxv2CCKeJn6J1uE+8F/VHkmANvkQdf6izpCU2xV/VIjA8ef6eINzO0THZ1Af2p3jlXfTX11Cq
ooM=
=m5u5
-----END PGP SIGNATURE-----

--aqlkHsf0eQfhuGP9gSI1va5sw3lzu55Iq--

--===============5770591988541248937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5770591988541248937==--
