Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A5EC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 14:42:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912B264E3E
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 14:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912B264E3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45AAC86880;
	Thu, 18 Feb 2021 14:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MjLt8z1eqmkX; Thu, 18 Feb 2021 14:42:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38E4D867ED;
	Thu, 18 Feb 2021 14:42:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EDBEC000F;
	Thu, 18 Feb 2021 14:42:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57198C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 455C0605CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZJzetq2X2yD2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:42:43 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 608C2605FE; Thu, 18 Feb 2021 14:42:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D30D9605CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:42:41 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 90E5CAE42;
 Thu, 18 Feb 2021 14:42:39 +0000 (UTC)
Subject: Re: [PATCH v2 08/11] drm/qxl: fix monitors object vmap
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-9-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <1743626e-d34d-8a7d-1b66-ae38f77c5ea5@suse.de>
Date: Thu, 18 Feb 2021 15:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-9-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============7438056269271041758=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7438056269271041758==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2
Content-Type: multipart/mixed; boundary="n6b1Z8I5X2eTfl1kktnTO3v7jFlZGXmyO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <1743626e-d34d-8a7d-1b66-ae38f77c5ea5@suse.de>
Subject: Re: [PATCH v2 08/11] drm/qxl: fix monitors object vmap
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-9-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-9-kraxel@redhat.com>

--n6b1Z8I5X2eTfl1kktnTO3v7jFlZGXmyO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Use the correct vmap variant.  We don't hold a reservation here,
> so we can't use the _locked variant.  We can drop the pin because
> qxl_bo_vmap will do that for us.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

I simply forgot to ack this patch.

> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index bfcc93089a94..f106da917863 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1159,12 +1159,10 @@ int qxl_create_monitors_object(struct qxl_devic=
e *qdev)
>   	}
>   	qdev->monitors_config_bo =3D gem_to_qxl_bo(gobj);
>  =20
> -	ret =3D qxl_bo_pin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_vmap(qdev->monitors_config_bo, &map);
>   	if (ret)
>   		return ret;
>  =20
> -	qxl_bo_vmap_locked(qdev->monitors_config_bo, &map);
> -
>   	qdev->monitors_config =3D qdev->monitors_config_bo->kptr;
>   	qdev->ram_header->monitors_config =3D
>   		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
> @@ -1189,8 +1187,7 @@ int qxl_destroy_monitors_object(struct qxl_device=
 *qdev)
>   	qdev->monitors_config =3D NULL;
>   	qdev->ram_header->monitors_config =3D 0;
>  =20
> -	qxl_bo_vunmap_locked(qdev->monitors_config_bo);
> -	ret =3D qxl_bo_unpin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_vunmap(qdev->monitors_config_bo);
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


--n6b1Z8I5X2eTfl1kktnTO3v7jFlZGXmyO--

--0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAufN4FAwAAAAAACgkQlh/E3EQov+C5
Tg//TrufcEVK61EAu1+3Er/neTjfN+QwzueogPCYKACr6iPKEZ2vmb31JaXyjAnaXOUw+PxLzH/V
rgOunhMQ7uqjE7Hjvn2Skrf/PjpT2LzN6zTMXZ1BcX4ABYpyg/dCYOrnGrV2rAzQFGxg296HOmur
r6WTQ0a1fdMKZHtl4utDXmEPTWvH2ky8eje1iAMm+xez8h98XknnK2daMQAmSJMFBWuM+0gPnW1z
dGEIP58ZeonvoBkBn0gU340s8aK3VQVWxb8T1U7Qv98MWC+UlXyrl6iCrx+ObsnnUI2OKlJ+1EYw
0l+MudQWVpELBAQVRlNSH5dc9WXXkaLcVP3c7TqyfLHLcuczxVLQqMontuUCw8hVmM3QIWHSDWda
0RlNMBR4pAyxet+Da4Cv8ln7Ka6ftqs+b2HQRdDDn7W5daaCWp5AXhliX3BZqIq3dN35X0tgeH0t
e+zMIzU8Xtu4DN61pxZhJUszK1QdVGpj+uMYo7t1Dchc3NWRcZerbS4iWvG03szzpOcS3rIGpHlA
FOKUL0nslKpQOht8i7kPx1cEngTGtWiVvESkhTgx5FFVjH4F4DjFAA/23ogwbsdO0Icf98KYSXUU
J2bq4Mm7UM81q94GVmKyqaYtwOzVsSnw5iXad+bqWYqYCtdNnx9usNcZz4Q2jKHaIk0Qq+sCLtZ1
iPU=
=eckE
-----END PGP SIGNATURE-----

--0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2--

--===============7438056269271041758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7438056269271041758==--
