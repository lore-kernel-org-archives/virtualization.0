Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56478C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 18:22:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA2064F67
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 18:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA2064F67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 75EC0865AB;
	Thu,  4 Feb 2021 18:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZSbhP_ohu0KX; Thu,  4 Feb 2021 18:22:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 28A778655C;
	Thu,  4 Feb 2021 18:22:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED9DC0174;
	Thu,  4 Feb 2021 18:22:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B32F9C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE68D8655C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fsgM299lbaVK
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 54D058654C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:22:27 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DEA59AE95;
 Thu,  4 Feb 2021 18:22:25 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] drm/qxl: allocate dumb buffers in ram
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210204145712.1531203-1-kraxel@redhat.com>
 <20210204145712.1531203-11-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <494099f2-01d7-fa62-9101-eb09765d7b98@suse.de>
Date: Thu, 4 Feb 2021 19:22:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204145712.1531203-11-kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="===============9177881618094260130=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============9177881618094260130==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pyZR8drgja7WQpmkmetYozYATek7dMo4p"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pyZR8drgja7WQpmkmetYozYATek7dMo4p
Content-Type: multipart/mixed; boundary="9hodCVcSmlM4NSTMnLoweg2r3f8cZ8USb";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <494099f2-01d7-fa62-9101-eb09765d7b98@suse.de>
Subject: Re: [PATCH v6 10/10] drm/qxl: allocate dumb buffers in ram
References: <20210204145712.1531203-1-kraxel@redhat.com>
 <20210204145712.1531203-11-kraxel@redhat.com>
In-Reply-To: <20210204145712.1531203-11-kraxel@redhat.com>

--9hodCVcSmlM4NSTMnLoweg2r3f8cZ8USb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 04.02.21 um 15:57 schrieb Gerd Hoffmann:
> dumb buffers are shadowed anyway, so there is no need to store them
> in device memory.  Use QXL_GEM_DOMAIN_CPU (TTM_PL_SYSTEM) instead.

Makes sense. I had similar issues in other drivers about the placement=20
of buffers. For them, all new buffers now go into system ram by default, =

and only move into device memory when they have to.

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_dumb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_d=
umb.c
> index c04cd5a2553c..48a58ba1db96 100644
> --- a/drivers/gpu/drm/qxl/qxl_dumb.c
> +++ b/drivers/gpu/drm/qxl/qxl_dumb.c
> @@ -59,7 +59,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
>   	surf.stride =3D pitch;
>   	surf.format =3D format;
>   	r =3D qxl_gem_object_create_with_handle(qdev, file_priv,
> -					      QXL_GEM_DOMAIN_SURFACE,
> +					      QXL_GEM_DOMAIN_CPU,
>   					      args->size, &surf, &qobj,
>   					      &handle);
>   	if (r)
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--9hodCVcSmlM4NSTMnLoweg2r3f8cZ8USb--

--pyZR8drgja7WQpmkmetYozYATek7dMo4p
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAcO2AFAwAAAAAACgkQlh/E3EQov+Dq
Tw//Ss7qrE339QgFvgUo6KSyLaTR9reuXmew3gm2M+w7BM02VQBDcHJ6uEWDOHTQpxcki4wApp40
/UQ5tZ6lRKqSPdYcz9CVNAwj0gYIqREeNIubHQd08Lzzx/kGv4Y/8xQ1Q1GrjIVejJvXOYe9KJhR
dtAklxDPn1pRe8reSY5NRHuijsxX3RPIgUYgwPn1AwxS3faEIM1801ylnXdfdcgk7l4NvoXgt3D4
dZSltupfezt3qIsQHmZX3f1BmYj8mvJDi9cGYhl4ij8LVcTlePQCV52wkW5aQiajpGJPxbVOIbMv
G8jOx66aV2A92ZdO010Rfhz8kWL/StnjqvOhzYmmhoXeHrqUQNd28LGqgEbA8KMRVf9cYv5co9PW
ouaNVKV1wzeuGSqYzWcDQ/7zirLjqh2Al+OvweNkG+5MGazdcjH/LMSH00PCJRIsUXZFt/obw6P6
SPFmMpQARcaR/s2X5i9Aq8/mm9RPLzDLF35fs/pB+t4ZuJU5DM8o0+70GUpw4jF3f5ExLLhbQ13g
7yrkjQkaavTeUAuk7TXmyDc0rKPrTr9KghpS0qxPT5OKHLsOIXiH5Er3RLo2JLGs76itxag0Scyo
qh2icQZMUuPJP3MAXP5YL6oxB65ZoJbTB3VYBR9/1Y1AYrCX2qQJlBDKr0Xi/0zjnFrr1KE/3HVk
dno=
=OQ9o
-----END PGP SIGNATURE-----

--pyZR8drgja7WQpmkmetYozYATek7dMo4p--

--===============9177881618094260130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9177881618094260130==--
