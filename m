Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CABC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:07:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025B564FA4
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025B564FA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B868868BB;
	Wed,  3 Feb 2021 14:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKrAZvfXXSek; Wed,  3 Feb 2021 14:07:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 41AEA859BE;
	Wed,  3 Feb 2021 14:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BF2FC0FA7;
	Wed,  3 Feb 2021 14:07:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F05BC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8AAB587123
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynIrbAajU9qK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:07:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 66CCC8618C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:07:19 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0008FACB0;
 Wed,  3 Feb 2021 14:07:17 +0000 (UTC)
Subject: Re: [PATCH v5 4/6] drm/qxl: handle shadow in primary destroy
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-5-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <a47d7646-d34e-8a5a-eb66-6b7e0f3aa777@suse.de>
Date: Wed, 3 Feb 2021 15:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203131615.1714021-5-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4247807705415716648=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4247807705415716648==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ
Content-Type: multipart/mixed; boundary="VtRkb7Y62egMcaLwIsPWaCXoVqjlYGBKM";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <a47d7646-d34e-8a5a-eb66-6b7e0f3aa777@suse.de>
Subject: Re: [PATCH v5 4/6] drm/qxl: handle shadow in primary destroy
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-5-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-5-kraxel@redhat.com>

--VtRkb7Y62egMcaLwIsPWaCXoVqjlYGBKM
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 03.02.21 um 14:16 schrieb Gerd Hoffmann:
> qxl_primary_atomic_disable must check whenever the framebuffer bo has a=

> shadow surface and in case it has check the shadow primary status.

I believe you :)

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index 60331e31861a..f5ee8cd72b5b 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -562,6 +562,8 @@ static void qxl_primary_atomic_disable(struct drm_p=
lane *plane,
>   	if (old_state->fb) {
>   		struct qxl_bo *bo =3D gem_to_qxl_bo(old_state->fb->obj[0]);
>  =20
> +		if (bo->shadow)
> +			bo =3D bo->shadow;
>   		if (bo->is_primary) {
>   			qxl_io_destroy_primary(qdev);
>   			bo->is_primary =3D false;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--VtRkb7Y62egMcaLwIsPWaCXoVqjlYGBKM--

--zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAarhQFAwAAAAAACgkQlh/E3EQov+B5
0Q//QF3+DxUtgM4jYfWiDkOHWVPkTilkocbU+UmeJ4FeVVTtpsBpmVkMnZgJINaapQhY1NUnpI6k
hpvgCT+tekKDBOZutLQXWWPy5T1r7Smrhip8Db1BzElpkl7XK0ONQ5b2EqmfLCfVv53pBKR7nSov
1nFv8gCLQwmAUkeW5Rw1SRlXioQbs5ByeD5anVHUKsDMoovDyflyfgRG1P+z1KA9CB5d3vaH0wTS
AHGednnr0q9GeVeLHN9UCKzIXF0zClSZ7DovbPgmcTYS3TDjU8JNPf8qfjMJyhocTS9n036At65X
kIbK7HxblJtmUmJ2cTRkmxgou0mqtbD2PTYyHTvMEQwQCUP9kRU3/rMlhEVtiOxHpOw9RxcApXta
GOTVQZSgHhZ/ukfZg65fltF7Gm5jCUSaaqSs/00tuUN9ACpoCyTEc2e/ubwxvx4J1vqDka9wpTZv
7BtAdpu+En5NjYYsSGrsr87OObNx334zYQN2knzyI1ah3lvQ5vs9qxkgmHcRzK+e7iop3HWqak3g
MTn7DEK4X4A7ASH0F7c/bgMhtk5fAJAFNLXXid/7f2kiY0LeR0JwTGFUJBX0uzV7O0Bt7kW57Zpi
LyCuF22UrSGlW5FOQN5EDqck5F9I4mNkB+WpbE3RiMx7jjTX3gL6K4/fSvDXbMo4ICW30BwvSKra
7sk=
=dwrl
-----END PGP SIGNATURE-----

--zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ--

--===============4247807705415716648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4247807705415716648==--
