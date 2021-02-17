Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736EC433E6
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 19:23:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D34064E4A
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 19:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D34064E4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2BAB587014;
	Wed, 17 Feb 2021 19:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1Vr+gpDNR1X; Wed, 17 Feb 2021 19:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8EA6481D3F;
	Wed, 17 Feb 2021 19:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68605C0174;
	Wed, 17 Feb 2021 19:23:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA6DC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D5E9600BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ewfov7VQATBR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:23:35 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 307CB6059D; Wed, 17 Feb 2021 19:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 950BB600BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:23:33 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 01A21ABA2;
 Wed, 17 Feb 2021 19:23:32 +0000 (UTC)
Subject: Re: [PATCH v2 04/11] drm/qxl: fix lockdep issue in
 qxl_alloc_release_reserved
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-5-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <8957d006-c521-292b-0e95-066098ec8b90@suse.de>
Date: Wed, 17 Feb 2021 20:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-5-kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============2377769335887740447=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2377769335887740447==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg
Content-Type: multipart/mixed; boundary="5K2XiOgMZEpkZsaQmRkNN3tpTWU2ThwaE";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <8957d006-c521-292b-0e95-066098ec8b90@suse.de>
Subject: Re: [PATCH v2 04/11] drm/qxl: fix lockdep issue in
 qxl_alloc_release_reserved
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-5-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-5-kraxel@redhat.com>

--5K2XiOgMZEpkZsaQmRkNN3tpTWU2ThwaE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Call qxl_bo_unpin (which does a reservation) without holding the
> release_mutex lock.  Fixes lockdep (correctly) warning on a possible
> deadlock.
>=20
> Fixes: 65ffea3c6e73 ("drm/qxl: unpin release objects")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qx=
l_release.c
> index 716d706ca7f0..f5845c96d414 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -283,7 +283,7 @@ int qxl_alloc_release_reserved(struct qxl_device *q=
dev, unsigned long size,
>   				       int type, struct qxl_release **release,
>   				       struct qxl_bo **rbo)
>   {
> -	struct qxl_bo *bo;
> +	struct qxl_bo *bo, *free_bo =3D NULL;
>   	int idr_ret;
>   	int ret =3D 0;
>   	union qxl_release_info *info;
> @@ -315,8 +315,7 @@ int qxl_alloc_release_reserved(struct qxl_device *q=
dev, unsigned long size,
>  =20
>   	mutex_lock(&qdev->release_mutex);
>   	if (qdev->current_release_bo_offset[cur_idx] + 1 >=3D releases_per_b=
o[cur_idx]) {
> -		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
> -		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
> +		free_bo =3D qdev->current_release_bo[cur_idx];
>   		qdev->current_release_bo_offset[cur_idx] =3D 0;
>   		qdev->current_release_bo[cur_idx] =3D NULL;
>   	}
> @@ -324,6 +323,10 @@ int qxl_alloc_release_reserved(struct qxl_device *=
qdev, unsigned long size,
>   		ret =3D qxl_release_bo_alloc(qdev, &qdev->current_release_bo[cur_id=
x], priority);
>   		if (ret) {
>   			mutex_unlock(&qdev->release_mutex);
> +			if (free_bo) {
> +				qxl_bo_unpin(free_bo);
> +				qxl_bo_unref(&free_bo);
> +			}
>   			qxl_release_free(qdev, *release);
>   			return ret;
>   		}
> @@ -339,6 +342,10 @@ int qxl_alloc_release_reserved(struct qxl_device *=
qdev, unsigned long size,
>   		*rbo =3D bo;
>  =20
>   	mutex_unlock(&qdev->release_mutex);
> +	if (free_bo) {
> +		qxl_bo_unpin(free_bo);
> +		qxl_bo_unref(&free_bo);
> +	}
>  =20
>   	ret =3D qxl_release_list_add(*release, bo);
>   	qxl_bo_unref(&bo);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--5K2XiOgMZEpkZsaQmRkNN3tpTWU2ThwaE--

--g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAtbTIFAwAAAAAACgkQlh/E3EQov+Cu
MA//cnHoAHJQ9PF56fAMErvtgYSHBawIIQ11eHErmocSJejf7Ln34v2+NiL+KHasW3q34ptuzNT5
d0KDbQwE2cQfcUNybx+mLZcn2YnB8o+IAkyRM1R3Tn8SC6AevXACinTB1NSISxipjU6iBmtPMWIA
HXlqiFvZxUhPGq/demqWXeTubcpq+2YhsPwo4cyZCtMBuFcsbpR06XA3kJhiOVBxTLP8+IqFQVsp
hTwKNXOo5+zqIdJvNx2rxIUT2egKjs/t+S+L/pOdnmnW60nP93utc7w/7dwLWbZowU9StTZdJpY/
mWRnsaxmEsAy8NUuKMLKyEYuWvBVkb42NB0gdcQfz/FyrFEpZy5BFROL/Aga16HzqV0jXrHxe9eY
amDlCyzJljnUoFKo+Hyth7Ia+sPnwR+dVzVqgwx5VZMjDmYiHmgVuJFdPJH1x0RO4IG9EvkzeIHs
yoT500xtIpCIAL2HBcM0i1je7ADkHWvmh8i3fZ+K8c5zyxRHq5+bk0Av92H+wPsMPILQKnui2L4q
HS+MpbJpoDtz4iPH9dvUGzogqzpWXmw6ia8zTaiKzBvtKekq3U7skJZk1ebwFnUjTtl2syJSGncl
z4ySMYPabg20ZFrrz7H4mXw6Y2Q8FnI5+3Oj5iWLmuWdLZdG0nPV2kUthCefvXqZRXVEwIXNqukm
yEI=
=AEpE
-----END PGP SIGNATURE-----

--g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg--

--===============2377769335887740447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2377769335887740447==--
