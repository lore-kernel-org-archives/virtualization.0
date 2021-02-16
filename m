Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1070C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:18:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F2164DDA
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F2164DDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 197718708D;
	Tue, 16 Feb 2021 13:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJyPIGWPUuVE; Tue, 16 Feb 2021 13:18:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BAF486FC8;
	Tue, 16 Feb 2021 13:18:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D521C0893;
	Tue, 16 Feb 2021 13:18:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F747C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F1C8485815
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xgChatoBqb-I
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:18:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1B66C856CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:18:31 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A96ECACBF;
 Tue, 16 Feb 2021 13:18:29 +0000 (UTC)
Subject: Re: [PATCH 08/10] drm/qxl: fix monitors object kmap
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-9-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <47d20b11-5e9e-df5d-f5d7-eeabad0fba51@suse.de>
Date: Tue, 16 Feb 2021 14:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216113716.716996-9-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4209278190199690038=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4209278190199690038==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM
Content-Type: multipart/mixed; boundary="pwM01gIs21csFcuVNF3Jw0rrOyqXUFxfO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <47d20b11-5e9e-df5d-f5d7-eeabad0fba51@suse.de>
Subject: Re: [PATCH 08/10] drm/qxl: fix monitors object kmap
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-9-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-9-kraxel@redhat.com>

--pwM01gIs21csFcuVNF3Jw0rrOyqXUFxfO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 16.02.21 um 12:37 schrieb Gerd Hoffmann:
> Use the correct kmap variant.  We don't hold a reservation here,
> so we can't use the _locked variant.  We can drop the pin because
> qxl_bo_kmap will do that for us.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index 8672385a1caf..7500560db8e4 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1159,12 +1159,10 @@ int qxl_create_monitors_object(struct qxl_devic=
e *qdev)
>   	}
>   	qdev->monitors_config_bo =3D gem_to_qxl_bo(gobj);
>  =20
> -	ret =3D qxl_bo_pin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_kmap(qdev->monitors_config_bo, &map);
>   	if (ret)
>   		return ret;
>  =20
> -	qxl_bo_kmap_locked(qdev->monitors_config_bo, &map);
> -
>   	qdev->monitors_config =3D qdev->monitors_config_bo->kptr;
>   	qdev->ram_header->monitors_config =3D
>   		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
> @@ -1189,8 +1187,7 @@ int qxl_destroy_monitors_object(struct qxl_device=
 *qdev)
>   	qdev->monitors_config =3D NULL;
>   	qdev->ram_header->monitors_config =3D 0;
>  =20
> -	qxl_bo_kunmap_locked(qdev->monitors_config_bo);
> -	ret =3D qxl_bo_unpin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_kunmap(qdev->monitors_config_bo);
>   	if (ret)
>   		return ret;
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--pwM01gIs21csFcuVNF3Jw0rrOyqXUFxfO--

--dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmArxiQFAwAAAAAACgkQlh/E3EQov+DX
pBAA0W9z+geNfjAswRgfoft+rrjdUHqknO2XhhcUtrtmzjXgj4PKfssqO5BWqbUv8Y6k886730Oo
I98cJ2BMs41j6s7Y/WJ0Z2N7pk/o+lSzPxcG4SDWuCWQVSFS9pa2vESADr5CSlc0FnSPdPQhUvOv
WZdZtIGAbny6Ga+6Xf/CRY3BElARaYaPV9xDgR50upLrkPDUR9kvoIbwXK+hT4CxKFgMFdZz3Vh+
CqLB0aX/0GYZ+GfHhlWYvNY/S1Q6MXmMT8AfchNVyDPMSt0grMnHvRkA8ZVxual3FCUUKK5S+8PD
NuX3sdcbfl6pDrXj4vFAGUzPAapnkvjCfxAsozfVbr/b28NrufKIiilKphOy0raCbpYQ/0GwtyTH
UPXOQdywe7+GJce5tbHTExvGmLJ+r7ce2VROllfqPWk/JeLR1Z72SwtRU9HDk34/s8DASjFy4aSv
XjbeSC9lqsdxVFtLlygqAu+VkhcuNUGy+tX4uBz0Xm6TvSCrSWYg4cXdEu9G2/gujkknCcQEE/qb
N7pB8oLc+nG5pwcWMMLHPxSWMtrREmSWSq53cdo9WfS69EWilpn2blAMrO/Yz9ImtABZ8GAS9KFM
4PjnDQqFM6gEl+AWhEYBDwG5fg53dR6XjZzqVshmAS23pYvUuEzGvQJ4OsNCeQwpaFjXg/yhwjgM
85M=
=SKuG
-----END PGP SIGNATURE-----

--dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM--

--===============4209278190199690038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4209278190199690038==--
