Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30893C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 09:30:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA636613BA
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 09:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA636613BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2F5242257;
	Thu, 15 Jul 2021 09:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WQKglpRgcb0G; Thu, 15 Jul 2021 09:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6FE24226C;
	Thu, 15 Jul 2021 09:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF12FC001A;
	Thu, 15 Jul 2021 09:30:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B757BC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9969660B5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="mM6TvzD+";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="9n4RAZIl"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6X0HNX0QJZ9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:30:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAEAA60B55
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:30:42 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1272A2292A;
 Thu, 15 Jul 2021 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626341440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJ/9Gr3eoqAJctk2n0YKskrK9wmCBCiTnG1XoGzapDI=;
 b=mM6TvzD+WxjROMOi/gWqrn7PSiPCDpLD6WFrsvluzyQRIdSW5GdZnzQNDsXahukZSgNZVl
 kxFRryMdyn6YEoKww+M/YVZZVZSXtELAQx/t5aEgE4wtUdQ4A05yTpjchHzvP3KUTFB3i4
 UBviofXBgCZ66eXH7JxGD88RPtfE7g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626341440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJ/9Gr3eoqAJctk2n0YKskrK9wmCBCiTnG1XoGzapDI=;
 b=9n4RAZIl1JRu0f5W7QK7mpSfUC0/LJ7Rj6J5FOqSeOobNUdqOlmG1ET6mISiFvOME+JjCm
 G8CJrusBP8iRvxAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D7EC613AB6;
 Thu, 15 Jul 2021 09:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id cp57Mz8A8GDcBgAAGKfGzw
 (envelope-from <tzimmermann@suse.de>); Thu, 15 Jul 2021 09:30:39 +0000
Subject: Re: [PATCH -next v2] drm/bochs: Fix missing pci_disable_device() on
 error in bochs_pci_probe()
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
References: <20210715020551.1030812-1-yangyingliang@huawei.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <49771e7d-666a-bac3-2cd7-23008a95ad8e@suse.de>
Date: Thu, 15 Jul 2021 11:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715020551.1030812-1-yangyingliang@huawei.com>
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
Content-Type: multipart/mixed; boundary="===============8038439024407917294=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8038439024407917294==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ABSJuNRvgtVRizXpSLt8b9avW36PfrpRS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ABSJuNRvgtVRizXpSLt8b9avW36PfrpRS
Content-Type: multipart/mixed; boundary="HFvtUBen1oNeXSkMyBE7tGhl5aQoTXbSv";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: airlied@linux.ie, kraxel@redhat.com
Message-ID: <49771e7d-666a-bac3-2cd7-23008a95ad8e@suse.de>
Subject: Re: [PATCH -next v2] drm/bochs: Fix missing pci_disable_device() on
 error in bochs_pci_probe()
References: <20210715020551.1030812-1-yangyingliang@huawei.com>
In-Reply-To: <20210715020551.1030812-1-yangyingliang@huawei.com>

--HFvtUBen1oNeXSkMyBE7tGhl5aQoTXbSv
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

for the change


Acked-by: Thomas Zimmermann <tzimmermann@suse.de>


but there are some style issues AFAICS.

Am 15.07.21 um 04:05 schrieb Yang Yingliang:
> Replace pci_enable_device() with pcim_enable_device(),
> pci_disable_device() will be called in release automatically.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

S-o-b line goes first

> ---
> v2:
>    use pcim_enable_device()

This changelog should rather be located between the commit description=20
and the first S-o-b line.

Best regards
Thomas

> ---
>   drivers/gpu/drm/tiny/bochs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.=
c
> index a2cfecfa8556..73415fa9ae0f 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -648,7 +648,7 @@ static int bochs_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent
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


--HFvtUBen1oNeXSkMyBE7tGhl5aQoTXbSv--

--ABSJuNRvgtVRizXpSLt8b9avW36PfrpRS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmDwAD8FAwAAAAAACgkQlh/E3EQov+By
NRAAiUrdLMyeq9mv4+Lh9MLnJbPei3guqnKqDae5PhaAELNBNS1kxK9CBkoXXa5rfFGx4PeBowCF
KB5fcMs9Px8a3zj9cNbt2DBAa0pJ9aQP49C8iVJulvrheK8aCOnxv0mF0KFtieZZB1UmGHon9zRf
FfpqsipdPHsmUvkDnsI/zlDbfiSG2SnOog64OsRhJFUhVaHs9Nkpv0rvKdzr+Y3BhNWnYk+wCJqp
ftYah5H63xFFt2SZ1oY4FGh0RqaarA1p191k5AArg9W5fFnS37dN/K8C97nbcQTWfk7JzqnZAjiv
MFSc+S6Bh0wHV9r0eOXZeyvAHSrg2glkXx8U5fGNpGU8WJdJZGoT8ag32iPpMLsn+uQR+RaoTh2W
yPe6A6QICOOzS9b8KWccfloAPPKN6YWK52gw2i6qO99UflkDaOkYbDl2aIcmOVl8wHc2mU+UI1OD
vegZ7Soc1Ixp8DDhJj/2KIjz1+N9nQECY5KNqM8H/1vkZE53pS/VdWkAtK41fHtMG4jP6cDMwze1
34p+OH/BmjTLwaSatoZGgcsqJpwse7BnzF1Mhtr7FJ43IXmbO+68nxVsuEeTWsJrFSKQgYyXBmsl
1ZV2CWHa7/KmyMPhDWBDEYqsv6oNiY2T3ESmtlkjgWGIapzby7nhJFE00n03hYhE6Umrb2g0SoJR
4nM=
=+QTY
-----END PGP SIGNATURE-----

--ABSJuNRvgtVRizXpSLt8b9avW36PfrpRS--

--===============8038439024407917294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8038439024407917294==--
