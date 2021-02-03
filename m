Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26DC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:14:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D81464F46
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D81464F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49D318712F;
	Wed,  3 Feb 2021 14:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y8AQWPLTG+2q; Wed,  3 Feb 2021 14:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CD2D87132;
	Wed,  3 Feb 2021 14:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 730DDC0FA7;
	Wed,  3 Feb 2021 14:14:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED6BC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E8DF0228E3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dprtyQhdtVdA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:14:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 72123228EA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:14:45 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F4048AC6E;
 Wed,  3 Feb 2021 14:14:43 +0000 (UTC)
Subject: Re: [PATCH v5 6/6] drm/qxl: simplify qxl_fence_wait
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-7-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <d00b212a-84dd-e75c-e362-f6b849e2103f@suse.de>
Date: Wed, 3 Feb 2021 15:14:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203131615.1714021-7-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============0960433752464568855=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0960433752464568855==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ir8R2lL3gimtGkGvKPcHDJLUdNht2HQZT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ir8R2lL3gimtGkGvKPcHDJLUdNht2HQZT
Content-Type: multipart/mixed; boundary="EUbSlfI9tcSCmBLKUHZFndYW0BhYL0cqh";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <d00b212a-84dd-e75c-e362-f6b849e2103f@suse.de>
Subject: Re: [PATCH v5 6/6] drm/qxl: simplify qxl_fence_wait
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-7-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-7-kraxel@redhat.com>

--EUbSlfI9tcSCmBLKUHZFndYW0BhYL0cqh
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 03.02.21 um 14:16 schrieb Gerd Hoffmann:
> Now that we have the new release_event wait queue we can just
> use that in qxl_fence_wait() and simplify the code alot.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 42 +++---------------------------=
-
>   1 file changed, 4 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qx=
l_release.c
> index 43a5436853b7..b6f4b8dcf228 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -59,53 +59,19 @@ static long qxl_fence_wait(struct dma_fence *fence,=
 bool intr,
>   {
>   	struct qxl_device *qdev;
>   	struct qxl_release *release;
> -	int count =3D 0, sc =3D 0;
> -	bool have_drawable_releases;
>   	unsigned long cur, end =3D jiffies + timeout;
>  =20
>   	qdev =3D container_of(fence->lock, struct qxl_device, release_lock);=

>   	release =3D container_of(fence, struct qxl_release, base);
> -	have_drawable_releases =3D release->type =3D=3D QXL_RELEASE_DRAWABLE;=

> -
> -retry:
> -	sc++;
>  =20
>   	if (dma_fence_is_signaled(fence))
>   		goto signaled;
>  =20
>   	qxl_io_notify_oom(qdev);
> -
> -	for (count =3D 0; count < 11; count++) {
> -		if (!qxl_queue_garbage_collect(qdev, true))
> -			break;
> -
> -		if (dma_fence_is_signaled(fence))
> -			goto signaled;
> -	}
> -
> -	if (dma_fence_is_signaled(fence))
> -		goto signaled;
> -
> -	if (have_drawable_releases || sc < 4) {
> -		if (sc > 2)
> -			/* back off */
> -			usleep_range(500, 1000);
> -
> -		if (time_after(jiffies, end))
> -			return 0;
> -
> -		if (have_drawable_releases && sc > 300) {
> -			DMA_FENCE_WARN(fence, "failed to wait on release %llu "
> -				       "after spincount %d\n",
> -				       fence->context & ~0xf0000000, sc);
> -			goto signaled;
> -		}
> -		goto retry;
> -	}
> -	/*
> -	 * yeah, original sync_obj_wait gave up after 3 spins when
> -	 * have_drawable_releases is not set.
> -	 */
> +	if (!wait_event_timeout(qdev->release_event,
> +				dma_fence_is_signaled(fence),
> +				timeout))
> +		return 0;
>  =20
>   signaled:
>   	cur =3D jiffies;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--EUbSlfI9tcSCmBLKUHZFndYW0BhYL0cqh--

--ir8R2lL3gimtGkGvKPcHDJLUdNht2HQZT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAar9IFAwAAAAAACgkQlh/E3EQov+Db
uA//VwivvYtJ6B2M8UqfwjmwGM7ZAtOmvqs05q/LF/IwsjmdTBNTP+8bdoI/9hIx24a+n7XySfaw
pIHBIbboH9Zvbh4CYROcFCGCEsQJ/gSVDMsP/KQT77QTDJxOJFSs+CX+VYCFvTKV7bo3yiqEveYR
MBcssEAGAcEglzs1jRq3rx0K94Ffhdf46+LCqWtdUZBh+ALEuR1OEk0IOVFcPToyEmSFXe3FV5Tm
JWIWRBFmoLU4wmE5F7pEXMnKRjMpwFifCYr3fM6GMmT1KZK0louM47yzj7NXnT7/l3kGSciC7NJb
SZZlyscslpLyYWDyUU5vW+hyWFrR3d0eIJP9Fu/0++S+OKFWLMOav79s9fGpJSVw6dFWyjPwD+x0
u27WufXrRThoSY6GWcAJLGVqTj1oUbCM1v5TgSfOeAEDJD/voQsnuFmjEkvNyoKES8Jig5CFKpNZ
oiyg8aIWoRdFabwpbe3Gq66DhpDGbo3uRSKhV/2bTOb8KqqaZ9rsaD1E+fA9xMicqH9PzeUsLPCc
fCMkGnhAcjmGth8FBHHjce2JbX5k+WZ5yVwIAu+D1V97Zf/62uxeIoo47X3IR5ph2qwCj3CSplh1
IFwUKmyLCQfMF72sUMbd5JmurlQRrqFNPUqlIi6fkhXZqEvLy3wF1QihdJ/onIc7CumpFJ738wUa
4Jo=
=fZEE
-----END PGP SIGNATURE-----

--ir8R2lL3gimtGkGvKPcHDJLUdNht2HQZT--

--===============0960433752464568855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0960433752464568855==--
