Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BAAC07E9B
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 09:07:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67E061209
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 09:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67E061209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0BD76403BA;
	Tue, 20 Jul 2021 09:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQn1HFBiZ8lF; Tue, 20 Jul 2021 09:07:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B0E340392;
	Tue, 20 Jul 2021 09:07:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D6C6C0010;
	Tue, 20 Jul 2021 09:07:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1102EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E598960813
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="qPP+VPih";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="Cqa4nl1n"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MH-mrg6yMydr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:07:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08822607F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:07:35 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F96F1FD3E;
 Tue, 20 Jul 2021 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626772053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QfevtJ7CO69XvR/FgxUv0tcNBb6dOkmnHZF1Y+3ecPE=;
 b=qPP+VPihQCLt5SbGo30Cs//xoYyzsjBqGVUjA1v7oynKA9Cpsold5dkRVWMNHDcSRlokhM
 LCow4zT5u2rnHLYUO2ZSdDffdy0kluHmt+QDRZjUPkycsfob/l4ri3ItuHoA1M49cw+IO6
 6tZ/1WMRGEGu9BMKvVp4Kr+7n7Rcpac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626772053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QfevtJ7CO69XvR/FgxUv0tcNBb6dOkmnHZF1Y+3ecPE=;
 b=Cqa4nl1n11cdmVl8DLDjDwA/2gnzCV/ihRUyR8BgzbHvrr18EHskqB+DQPNMIsOG1Ft4ET
 YFTG7BbQu9ai/GAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0403213A2E;
 Tue, 20 Jul 2021 09:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id pTTIOVSS9mD+FgAAGKfGzw
 (envelope-from <tzimmermann@suse.de>); Tue, 20 Jul 2021 09:07:32 +0000
Subject: Re: [PATCH -next v2 resend] drm/bochs: Fix missing
 pci_disable_device() on error in bochs_pci_probe()
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
References: <20210715132845.2415619-1-yangyingliang@huawei.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <5c3f06d5-509a-0e59-7021-d25180f82de9@suse.de>
Date: Tue, 20 Jul 2021 11:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715132845.2415619-1-yangyingliang@huawei.com>
Cc: airlied@linux.ie, daniel@ffwll.ch
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
Content-Type: multipart/mixed; boundary="===============0570905236621416609=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0570905236621416609==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl
Content-Type: multipart/mixed; boundary="3UkehBvmd5mFqfwTL1h90To2blVmYbJVN";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Message-ID: <5c3f06d5-509a-0e59-7021-d25180f82de9@suse.de>
Subject: Re: [PATCH -next v2 resend] drm/bochs: Fix missing
 pci_disable_device() on error in bochs_pci_probe()
References: <20210715132845.2415619-1-yangyingliang@huawei.com>
In-Reply-To: <20210715132845.2415619-1-yangyingliang@huawei.com>

--3UkehBvmd5mFqfwTL1h90To2blVmYbJVN
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.07.21 um 15:28 schrieb Yang Yingliang:
> Replace pci_enable_device() with pcim_enable_device(),
> pci_disable_device() will be called in release automatically.
>=20
> v2:
>    use pcim_enable_device()
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, I'll merge it into drm-misc-next as v3. I also had to update the =

path to the bochs driver meanwhile.

Best regards
Thomas

> ---
>   drivers/gpu/drm/bochs/bochs_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/=
bochs_drv.c
> index c828cadbabff..8065c9537237 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -118,7 +118,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>   	if (IS_ERR(dev))
>   		return PTR_ERR(dev);
>  =20
> -	ret =3D pci_enable_device(pdev);
> +	ret =3D pcim_enable_device(pdev);
>   	if (ret)
>   		goto err_free_dev;
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--3UkehBvmd5mFqfwTL1h90To2blVmYbJVN--

--1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmD2klQFAwAAAAAACgkQlh/E3EQov+Dn
LRAAytKE28XZKTScOgeBjGLyb6I50t+nAoIMtve7Gc22yETMye3+lkQ8ulGWm8OC931jHub2Qz8v
3VsC3q2YuJSdXLPpPRGe59bgtnzSqgvvmEYzGXJ/dB6yhS4DDbks885mZBg5HusB5hvpwyE29lki
67RuwzuQQ1tXmxSSuPmI5kT2BtawUxvP1bbU/44xgmhfUP4YMm53eLV/ELRvyvDjFfSJOxF857hQ
ijfX6xWc3i7zLES4EPIc0sqNj0PPrP2wnuzUf6X65phtbS276Ym7tG9vTuI18YTnk7On9boiFtDr
ZWeTSEmBq4nTi+XRsY3JPRQaGOmzMVx8vjex6iht5Uf835wX1j3F7FOEac9vP+/XFSVv4hAJ2/cy
n2kuvhhLbko1TDgquFTqBI2cYZofEe6kkHqi0SSrIKn7/K7bJehJIBAZcHyqpBB5S6P1BkiusACM
cqgM6NZ5t1OwFm1YFM9Oop4Hj2Kyat6Ucuv6O1sOLCfvWFS16g0jaJBUPfEar58Ly6FFefRvPD5v
+3Ma64SwyLbRkVLxJjPYL2VuqDuVlTyGca8G42iHSi9P8gUTEJ797lWVLtKUi0HFxIPk75G6ctaU
70sbjXHpsnIPS/+c6ekVJKDyDog2VBXAH7ip+tgDDxxYdlU1ssUGG5GqyETK65Y+bGqGTNcl0sJa
rlI=
=Sdka
-----END PGP SIGNATURE-----

--1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl--

--===============0570905236621416609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0570905236621416609==--
